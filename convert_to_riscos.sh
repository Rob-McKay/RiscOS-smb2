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


function copy_or_diff() {
    if [ -f $1 ]; then
        if [ ! -f $2 ]; then
            cp -n -p $1 $2
        else
            diff --strip-trailing-cr -p $1 $2
        fi
    fi
}


# Ensure that the required directories exist, and are read and writable from RISC OS

for dir in 'c' 'h' 'o' 'lib' 'lib/h' 'lib/c' 'include/h' 'include/smb2/h'; do
    if [ ! -d $dir ]; then
        mkdir -p library/$dir
        chmod u=rwx,g=rwx,o=rwx library/$dir
    fi
done
chmod u=rwx,g=rwx,o=rwx library

# lib/*.(c|h) files

for source in 'aes' 'aes_apple' 'aes_reference' 'aes128ccm' 'alloc' 'asn1-ber' 'compat' 'dcerpc' 'dcerpc-lsa' 'dcerpc-srvsvc' 'errors' 'hmac' 'hmac-md5' \
                'init' 'krb5-wrapper' 'libsmb2' \
                'md4' 'md4c' 'md5' 'ntlmssp' 'pdu' 'sha' 'sha-private' 'sha1' 'sha224-256' 'sha384-512' 'smb2-cmd-close' 'smb2-cmd-create' 'smb2-cmd-echo' \
                'smb2-cmd-error' 'smb2-cmd-flush' 'smb2-cmd-ioctl' 'smb2-cmd-logoff' 'smb2-cmd-negotiate' 'smb2-cmd-query-directory' 'smb2-cmd-query-info' \
                'smb2-cmd-read' 'smb2-cmd-session-setup' 'smb2-cmd-set-info' 'smb2-cmd-tree-connect' 'smb2-cmd-tree-disconnect' 'smb2-cmd-write' \
                'smb2-data-file-info' 'smb2-data-filesystem-info' 'smb2-data-reparse-point' 'smb2-data-security-descriptor' 'smb2-share-enum' 'smb2-signing' \
                'smb3-seal' 'socket' 'spnego-wrapper' 'sync' 'timestamps' 'unicode' 'usha'; do
    for type in 'c' 'h'; do
        copy_or_diff libsmb2/lib/$source.$type  library/lib/$type/$source
    done
done

# include/smb2/*.h files

for header in 'libsmb2-dcerpc' 'libsmb2-dcerpc-lsa' 'libsmb2-dcerpc-srvsvc' 'libsmb2' 'libsmb2-raw' 'smb2-errors' 'smb2'; do
    copy_or_diff libsmb2/include/smb2/$header.h library/include/smb2/h/$header
done

# include/*.h files

for header in 'libsmb2-private' 'portable-endian' 'slist'; do
    copy_or_diff libsmb2/include/$header.h library/include/h/$header
done

# RISC OS specific header files

for header in 'config'; do
    copy_or_diff libsmb2/riscos/$header.h library/h/$header
done

# RISC OS specific source files

for source in 'asprintf'; do
    for type in 'c' 'h'; do
        copy_or_diff libsmb2/riscos/$source.$type library/$type/$source
    done
done

# RISC OS specific files

for file in 'Makefile.riscos' 'Mk,fd7' 'MkClean,fd7'; do
    copy_or_diff libsmb2/riscos/$file library/$file
done
