# Makefile for libsmb2

libsmb2Sources = aes aes128ccm alloc compat dcerpc \
	dcerpc-lsa dcerpc-srvsvc errors hmac hmac-md5 init \
	libsmb2 md4c md5 ntlmssp pdu sha224-256 sha384-512 \
	smb2-cmd-close smb2-cmd-create smb2-cmd-echo smb2-cmd-error \
	smb2-cmd-flush smb2-cmd-ioctl smb2-cmd-logoff smb2-cmd-negotiate \
	smb2-cmd-query-directory smb2-cmd-query-info smb2-cmd-read \
	smb2-cmd-session-setup smb2-cmd-set-info smb2-cmd-tree-connect \
	smb2-cmd-tree-disconnect smb2-cmd-write smb2-data-file-info \
	smb2-data-filesystem-info smb2-data-reparse-point \
	smb2-data-security-descriptor smb2-share-enum smb2-signing \
	smb3-seal socket sync timestamps unicode usha asprintf

COMPONENT = libsmb2
CMHGFILE_SWIPREFIX=SMB2
LIBS=TCPIPLibs:o.inetlibzm TCPIPLibs:o.unixlibzm TCPIPLibs:o.socklibzm


CFLAGS += -ff -Wp -fah -ez -DHAVE_CONFIG_H
CFLAGS += -I@.^.library.lib -I@.^.library.include -I@.^.library.include.smb2 -I@.^.library -ITCPIPLibs:
# The CMHG and resources object files are added automatically, so don't need to be listed
CMHGDEPENDS = libsmb2Hdr
OBJS = swi_handlers $(libsmb2Sources)

VPATH=@.^.library.lib @.^.library

include CModule

# Dynamic dependencies:
