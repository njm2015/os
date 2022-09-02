#ifndef UTILS_CACHE_H
#define UTILS_CACHE_H

#include "types.h"

bool check_mtrr_enabled();
int read_msr(int reg);
void set_msr(int reg, int val);
void set_mtrr_fixed_lower(int reg, int mask);
bool read_cache_cd();
bool read_cache_nw();

#endif
