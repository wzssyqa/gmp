dnl  MIPS64 mpn_sqr_diagonal.

dnl  Copyright 2001, 2002 Free Software Foundation, Inc.

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


dnl  INPUT PARAMETERS
dnl  rp		$4
dnl  up		$5
dnl  n		$6

include(`../config.m4')

ASM_START()
PROLOGUE(mpn_sqr_diagonal)

Loop:
	ld	$8,0($5)
	daddiu	$6,$6,-1

	dmultu	$8,$8
	mflo	$10
	mfhi	$9

	sd	$10,0($4)
	sd	$9,8($4)

	daddiu  $5,$5,8

	bgtz	$6,Loop
	daddiu	$4,$4,16
Lend:
	j	$31
	nop
EPILOGUE(mpn_sqr_diagonal)
