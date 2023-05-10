#!/bin/bash

for dir in 'h' 'o' 'lib/h' 'lib/c' 'include/h' 'include/smb2/h'
do
    if [ ! -d $dir ]; then
        mkdir -p $dir
    fi
done


for source in 'aes' 'aes128ccm' 'alloc' 'compat' 'dcerpc' 'dcerpc-lsa' 'dcerpc-srvsvc' 'errors' 'hmac' 'hmac-md5' 'init' 'krb5-wrapper' 'libsmb2' 'md4c' 'md5' 'ntlmssp' 'pdu' 'sha1' 'sha224-256' 'sha384-512' 'smb2-cmd-close' 'smb2-cmd-create' 'smb2-cmd-echo' 'smb2-cmd-error' 'smb2-cmd-flush' 'smb2-cmd-ioctl' 'smb2-cmd-logoff' 'smb2-cmd-negotiate' 'smb2-cmd-query-directory' 'smb2-cmd-query-info' 'smb2-cmd-read' 'smb2-cmd-session-setup' 'smb2-cmd-set-info' 'smb2-cmd-tree-connect' 'smb2-cmd-tree-disconnect' 'smb2-cmd-write' 'smb2-data-file-info' 'smb2-data-filesystem-info' 'smb2-data-reparse-point' 'smb2-data-security-descriptor' 'smb2-share-enum' 'smb2-signing' 'smb3-seal' 'socket' 'sync' 'timestamps' 'unicode' 'usha' 
do
    if [ ! -f lib/c/$source ]; then
        cp -np libsmb2/lib/$source.c lib/c/$source
    else
        diff --strip-trailing-cr -p libsmb2/lib/$source.c lib/c/$source 
    fi

    if [ -f libsmb2/lib/$source.h ]; then
        if [ ! -f lib/h/$source ]; then
            cp -np libsmb2/lib/$source.h lib/h/$source
        else
            diff --strip-trailing-cr -p libsmb2/lib/$source.h lib/h/$source
        fi
    fi
done


for header in 'libsmb2-dcerpc'  'libsmb2-dcerpc-lsa'  'libsmb2-dcerpc-srvsvc'  'libsmb2'  'libsmb2-raw'  'smb2-errors'  'smb2'
do
    if [ ! -f include/smb2/h/$header ]; then
        cp -np libsmb2/include/smb2/$header.h include/smb2/h/$header
    else
        diff --strip-trailing-cr libsmb2/include/smb2/$header.h include/smb2/h/$header
    fi
done


for header in 'asprintf' 'libsmb2-private'  'portable-endian'  'slist'
do
    if [ ! -f include/h/$header ]; then
        cp -np libsmb2/include/$header.h include/h/$header
    else
        diff --strip-trailing-cr -p libsmb2/include/$header.h include/h/$header
    fi
done
