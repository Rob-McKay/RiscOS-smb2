#!/bin/bash
#
# Convert the standard libsmb2 source tree into the RISC OS source tree.
#
# Changed files are not overwritten - either manually merge them,
# or write them back to the standard source tree and delete them
# from the RISC OS tree before using git to merge the changes and
# then re-convert them.
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

# Ensure that the required directories exist

for dir in 'h' 'o' 'lib/h' 'lib/c' 'include/h' 'include/smb2/h'; do
    if [ ! -d $dir ]; then
        mkdir -p library/$dir
    fi
done

diffopts="--strip-trailing-cr -p"

# lib/*.(c|h) files

for source in 'aes' 'aes128ccm' 'alloc' 'compat' 'dcerpc' 'dcerpc-lsa' 'dcerpc-srvsvc' 'errors' 'hmac' 'hmac-md5' 'init' 'krb5-wrapper' 'libsmb2' 'md4c' 'md5' 'ntlmssp' 'pdu' 'sha1' 'sha224-256' 'sha384-512' 'smb2-cmd-close' 'smb2-cmd-create' 'smb2-cmd-echo' 'smb2-cmd-error' 'smb2-cmd-flush' 'smb2-cmd-ioctl' 'smb2-cmd-logoff' 'smb2-cmd-negotiate' 'smb2-cmd-query-directory' 'smb2-cmd-query-info' 'smb2-cmd-read' 'smb2-cmd-session-setup' 'smb2-cmd-set-info' 'smb2-cmd-tree-connect' 'smb2-cmd-tree-disconnect' 'smb2-cmd-write' 'smb2-data-file-info' 'smb2-data-filesystem-info' 'smb2-data-reparse-point' 'smb2-data-security-descriptor' 'smb2-share-enum' 'smb2-signing' 'smb3-seal' 'socket' 'sync' 'timestamps' 'unicode' 'usha'; do
    for type in 'c' 'h'; do
        if [ -f libsmb2/lib/$source.$type ]; then
            if [ ! -f library/lib/$type/$source ]; then
                cp -np libsmb2/lib/$source.$type library/lib/$type/$source
            else
                diff $diffopts libsmb2/lib/$source.$type library/lib/$type/$source
            fi
        fi
    done
done

# include/smb2/*.h files

for header in 'libsmb2-dcerpc' 'libsmb2-dcerpc-lsa' 'libsmb2-dcerpc-srvsvc' 'libsmb2' 'libsmb2-raw' 'smb2-errors' 'smb2'; do
    if [ ! -f include/smb2/h/$header ]; then
        cp -np libsmb2/include/smb2/$header.h library/include/smb2/h/$header
    else
        diff $diffopts libsmb2/include/smb2/$header.h library/include/smb2/h/$header
    fi
done

# include/*.h files

for header in 'asprintf' 'libsmb2-private' 'portable-endian' 'slist'; do
    if [ ! -f include/h/$header ]; then
        cp -np libsmb2/include/$header.h library/include/h/$header
    else
        diff $diffopts libsmb2/include/$header.h library/include/h/$header
    fi
done

# RISC OS specific header files

for header in 'config'; do
    if [ ! -f h/$header ]; then
        cp -np libsmb2/riscos/$header.h library/h/$header
    else
        diff $diffopts libsmb2/riscos/$header.h library/h/$header
    fi
done

# RISC OS specific files

for file in 'Makefile,fe1'; do
    if [ ! -f $file ]; then
        cp -np libsmb2/riscos/$file library/$file
    else
        diff $diffopts library/$file libsmb2/riscos/$file
    fi
done
