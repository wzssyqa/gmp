dnl  MIPS64 mpn_mul_1 -- Multiply a limb vector with a single limb and store
dnl  the product in a second limb vector.

dnl  Copyright 1992, 1994, 1995, 2000-2002 Free Software Foundation, Inc.

dnl  This file is part of the GNU MP Library.
dnl
dnl  The GNU MP Library is free software; you can redistribute it and/or modify
dnl  it under the terms of either:
dnl
dnl    * the GNU Lesser General Public License as published by the Free
dnl      Software Foundation; either version 3 of the License, or (at your
dnl      option) any later version.
dnl
dnl  or
dnl
dnl    * the GNU General Public License as published by the Free Software
dnl      Foundation; either version 2 of the License, or (at your option) any
dnl      later version.
dnl
dnl  or both in parallel, as here.
dnl
dnl  The GNU MP Library is distributed in the hope that it will be useful, but
dnl  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
dnl  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
dnl  for more details.
dnl
dnl  You should have received copies of the GNU General Public License and the
dnl  GNU Lesser General Public License along with the GNU MP Library.  If not,
dnl  see https://www.gnu.org/licenses/.

include(`../config.m4')

C INPUT PARAMETERS
C res_ptr	$4
C s1_ptr	$5
C size		$6
C s2_limb	$7

ASM_START()
PROLOGUE(mpn_mul_1)

	move	$2,$0		C zero cy2
Loop:
	lw      $8,0($5)
	addiu	$6,$6,-1	C decrement loop counter

	mulu	$3,$7,$8

	addu	$3,$3,$2	C add old carry limb to low product limb
	sltu	$2,$3,$2	C carry from previous addition -> $2
	sw	$3,0($4)

	muhu	$9,$7,$8

	addiu	$5,$5,4
	addiu	$4,$4,4

	bgtz	$6,Loop
	addu	$2,$9,$2	C add high product limb and carry from addition
Lend:
	j	$31
	nop
EPILOGUE(mpn_mul_1)
