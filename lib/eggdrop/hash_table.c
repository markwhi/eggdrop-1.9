/*
 * hash_table.c --
 */
/*
 * Copyright (C) 2002, 2003 Eggheads Development Team
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#ifndef lint
static const char rcsid[] = "$Id: hash_table.c,v 1.2 2003/01/02 21:33:13 wcc Exp $";
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "hash_table.h"

static unsigned int my_string_hash(const void *key);
static unsigned int my_int_hash(const void *key);
static unsigned int my_mixed_hash (const void *key);
static int my_int_cmp(const void *left, const void *right);

hash_table_t *hash_table_create(hash_table_hash_alg alg, hash_table_cmp_alg cmp, int nrows, int flags)
{
	hash_table_t *ht;
	int size;

	if (nrows <= 0) nrows = 13; /* Give them a small table to start with. */

	/* One of the rows is included in the struct definition. */
	size = sizeof(*ht) + (nrows-1) * sizeof(hash_table_entry_t);
	ht = calloc(1, size);

	if (alg) ht->hash = alg;
	else {
		if (flags & HASH_TABLE_STRINGS) ht->hash = my_string_hash;
		else if (flags & HASH_TABLE_INTS) ht->hash = my_int_hash;
		else ht->hash = my_mixed_hash;
	}
	if (cmp) ht->cmp = cmp;
	else {
		if (flags & HASH_TABLE_INTS) ht->cmp = my_int_cmp;
		else ht->cmp = (hash_table_cmp_alg) strcmp;
	}
	ht->flags = flags;
	ht->max_rows = nrows;
	return(ht);
}

int hash_table_destroy(hash_table_t *ht)
{
	return(0);
}

int hash_table_check_resize(hash_table_t **ht)
{
	if ((*ht)->cells_in_use / (*ht)->max_rows > 100) {
		hash_table_resize(ht, (*ht)->max_rows * 3);
	}
	return(0);
}

int hash_table_resize(hash_table_t **ht, int nrows)
{
	int i, newidx;
	hash_table_t *newht, *oldht;
	hash_table_row_t *row, *newrow;
	hash_table_entry_t *entry, *next;

	/* First allocate a new hash table. */
	oldht = *ht;
	newht = hash_table_create(oldht->hash, oldht->cmp, nrows, oldht->flags);

	/* Now populate it with the old entries. */
	for (i = 0; i < oldht->max_rows; i++) {
		row = oldht->rows+i;
		for (entry = row->head; entry; entry = next) {
			next = entry->next;
			newidx = entry->hash % nrows;
			newrow = newht->rows+newidx;
			entry->next = newrow->head;
			newrow->head = entry;
			newrow->len++;
		}
	}

	newht->cells_in_use = oldht->cells_in_use;
	free(oldht);
	*ht = newht;
	return(0);
}

int hash_table_insert(hash_table_t *ht, const void *key, void *data)
{
	unsigned int hash;
	int idx;
	hash_table_entry_t *entry;
	hash_table_row_t *row;

	hash = ht->hash(key);
	idx = hash % ht->max_rows;
	row = ht->rows+idx;

	/* Allocate an entry. */
	entry = malloc(sizeof(*entry));
	entry->key = key;
	entry->data = data;
	entry->hash = hash;

	/* Insert it into the list. */
	entry->next = row->head;
	row->head = entry;

	/* Update stats. */
	row->len++;
	ht->cells_in_use++;

	return(0);
}

int hash_table_find(hash_table_t *ht, const void *key, void *dataptr)
{
	int idx;
	unsigned int hash;
	hash_table_entry_t *entry;
	hash_table_row_t *row;

	hash = ht->hash(key);
	idx = hash % ht->max_rows;
	row = ht->rows+idx;

	for (entry = row->head; entry; entry = entry->next) {
		if (hash == entry->hash && !ht->cmp(key, entry->key)) {
			*(void **)dataptr = entry->data;
			return(0);
		}
	}
	return(-1);
}

int hash_table_delete(hash_table_t *ht, const void *key)
{
	int idx;
	unsigned int hash;
	hash_table_entry_t *entry, *last;
	hash_table_row_t *row;

	hash = ht->hash(key);
	idx = hash % ht->max_rows;
	row = ht->rows+idx;

	last = NULL;
	for (entry = row->head; entry; entry = entry->next) {
		if (hash == entry->hash && !ht->cmp(key, entry->key)) {
			/* Remove it from the row's list. */
			if (last) last->next = entry->next;
			else row->head = entry->next;

			free(entry);
			ht->cells_in_use--;
			return(0);
		}
		last = entry;
	}
	return(-1);
}

int hash_table_walk(hash_table_t *ht, hash_table_node_func callback, void *param)
{
	hash_table_row_t *row;
	hash_table_entry_t *entry;
	int i;

	for (i = 0; i < ht->max_rows; i++) {
		row = ht->rows+i;
		for (entry = row->head; entry; entry = entry->next) {
			callback(entry->key, &entry->data, param);
		}
	}
	return(0);
}

static int my_int_cmp(const void *left, const void *right)
{
	return((int) left - (int) right);
}

static unsigned int my_string_hash(const void *key)
{
	int hash, loop, keylen;
	unsigned char *k;

#define HASHC hash = *k++ + 65599 * hash
	hash = 0;
	k = (unsigned char *)key;
	keylen = strlen((char *)key);

	loop = (keylen + 8 - 1) >> 3;
	switch (keylen & (8 - 1)) {
		case 0:
			do {
				HASHC;
		case 7:
				HASHC;
		case 6:
				HASHC;
		case 5:
				HASHC;
		case 4:
				HASHC;
		case 3:
				HASHC;
		case 2:
				HASHC;
		case 1:
				HASHC;
			} while (--loop);
	}
	return(hash);
}

static unsigned int my_int_hash(const void *key)
{
	return((unsigned int)key);
}

static unsigned int my_mixed_hash (const void *key)
{
	unsigned char *k;
	unsigned int hash;

        k = (unsigned char *)key;
	hash = 0;
	while (*k) {
		hash *= 16777619;
		hash ^= *k++;
	}
	return(hash);
}