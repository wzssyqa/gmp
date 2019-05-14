dnl  MIPS64 mpn_sub_n -- Subtract two limb vectors of the same length > 0 and
dnl  store difference in a third limb vector.

dnl  Copyright 1995, 2000-2002, 2011 Free Software Foundation, Inc.

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
C s2_ptr	$6
C size		$7

ASM_START()
PROLOGUE(mpn_sub_nc)
	move	$2,$8
	b	Loop
EPILOGUE()
PROLOGUE(mpn_sub_n)
	move	$2,$0
Loop:
	ld	$9,0($5)
	ld	$10,0($6)
	daddiu	$7,$7,-1	C decrement loop counter

	daddu	$10,$2,$10
	sltu	$2,$10,$2
	dsubu	$10,$9,$10
	sltu	$9,$9,$10

	sd	$10,0($4)

	daddiu	$5,$5,8
	daddiu	$6,$6,8
	daddiu  $4,$4,8

	bgtz	$7,Loop
	daddu	$2,$2,$9
Lend:
	j	$31
	nop
EPILOGUE()
