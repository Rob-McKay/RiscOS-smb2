# Makefile for the libsmb2 RISC OS Module
#
# Copyright 2023 Rob McKay
#
# This file is part of 'RISC OS libsmb2'
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# You should have received a copy of the GNU Lesser General Public
# License along with this program.  If not, see <http://www.gnu.org/licenses/>.

cc = CC

.SUFFIXES: .o .oz .s .c .h .c++ .cpp

# C source files -> object files
.c.o:;          ${cc} ${CCflags} ${CAPPFLAGS} -o $@ $<
.c.oz:;         ${cc} ${CCflags} ${CMODFLAGS} ${C_MODULE} -o $@ $<

# Assembler source files -> object files
.s.o:;          ${as} ${ASFLAGS} -o $@ $<
.s.oz:;         ${as} ${ASFLAGS} -pd "zM SETL {TRUE}" -o $@ $<

libsmb2Includes = -I@.^.library.lib -I@.^.library.include -I@.^.library.include.smb2 -I@.^.library

CCflags = -c -IC: -ITCPIPLibs: $(libsmb2Includes) -throwback -Wp -fah -DHAVE_CONFIG_H -ez -zM -zps1
C++flags = -c -IC: -throwback
Linkflags = -rmf -o $@
ObjAsmflags = -throwback -NoCache -depend !Depend
CMHGflags =
LibFileflags = -c -o $@
Squeezeflags = -o $@
ModSqzflags = -o $@

Sources = swi_handlers

ObjectFiles = $(addprefix @.oz., $(Sources))
LibraryFiles = @.^.library.libsmb2_zm TCPIPLibs:o.inetlibzm TCPIPLibs:o.unixlibzm TCPIPLibs:o.socklibzm C:o.stubs

# Targets:
all: @.libsmb2

@.libsmb2:	@.oz.smb2Hdr $(ObjectFiles) $(LibraryFiles)
	link $(LibFileflags) $(ObjectFiles) $(LibraryFiles) @.oz.smb2Hdr

clean:
	-wipe @.oz.* frv~c
	-remove @.libsmb2

@.h.smb2Hdr: cmgh.libsmb2Hdr
	cmhg -p -IC: -o oz.smb2Hdr -d h.smb2Hdr cmgh.libsmb2Hdr

@.oz.smb2Hdr: cmgh.libsmb2Hdr
	cmhg -p -IC: -o oz.smb2Hdr -d h.smb2Hdr cmgh.libsmb2Hdr

@.oz.swi_handlers: @.h.smb2Hdr @.c.swi_handlers cmgh.libsmb2Hdr
