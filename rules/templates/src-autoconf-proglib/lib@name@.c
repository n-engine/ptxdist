/*
 * For copyright/license information refer COPYING in the main directory
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include "internal.h"

DSO_VISIBLE int fish(void)
{
	printf("hello fish!\n");
	return 0;
}

