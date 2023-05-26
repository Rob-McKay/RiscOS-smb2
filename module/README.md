RISC OS libsmb2 Module
======================

This directory contains the sources for the RISC OS libsmb2 module which is an interface to the libsmb2 library.

  Module Name: libsmb2\
  SWI chunk: &5A500\
  Prefix: SMB2\
  Description: SMB 2/3 services

# SWIs

## SMB2_CreateContext

(SWI &54500)

### Exit

R0 contains the context handle if the V (overflow) flag is clear.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Create an SMB2 context.

___

## SMB2_DestroyContext

(SWI &54501)

### Entry

R0 the SMB2 context handle

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Destroy a SMB2 context.

Any open `SMB2 file handle` will automatically be freed. You can not reference
any `SMB2 file handle` associated with the context after the context is destroyed.

Any open `SMB 2 directory handle` will automatically be freed. You can not reference any `SMB 2 directory handle` after the context is destroyed.

Any pending async commands will be aborted with -ECONNRESET.

___

## SMB2_SetVersion

(SWI &54502)

### Entry

R0 the SMB2 context handle\
R1 SMB2 negotiate version

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set which version of SMB to negotiate. Default is to let the server pick the version.

#### SMB2 negotiate version

``` C
 SMB2_VERSION_ANY  = 0,
 SMB2_VERSION_ANY2 = 2,
 SMB2_VERSION_ANY3 = 3,
 SMB2_VERSION_0202 = 0x0202,
 SMB2_VERSION_0210 = 0x0210,
 SMB2_VERSION_0300 = 0x0300,
 SMB2_VERSION_0302 = 0x0302,
 SMB2_VERSION_0311 = 0x0311
```

___

## SMB2_SetSecurityMode

(SWI &54503)

### Entry

R0 the SMB2 context handle\
R1 the security mode

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set the security mode for the connection. This is a combination of the flags SMB2_NEGOTIATE_SIGNING_ENABLED and SMB2_NEGOTIATE_SIGNING_REQUIRED. Default is 0.

``` C
SMB2_NEGOTIATE_SIGNING_ENABLED  = 0x0001,
SMB2_NEGOTIATE_SIGNING_REQUIRED = 0x0002
```
___

## SMB2_SetSeal

(SWI &54504)

### Entry

R0 the SMB2 context handle\
R1

* 0: disable encryption. This is the default.
* Non-zero: enable encryption.

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set whether smb3 encryption should be used or not.

___

## SMB2_SetSigning

(SWI &54505)

### Entry

R0 the SMB2 context handle\
R1

* 0: do not require signing. This is the default.
* Non-zero: require signing.

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set whether smb2 signing should be required or not

___

## SMB2_SetUser

(SWI &54506)

### Entry

R0 the SMB2 context handle\
R1 `const char *` user

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set the username that we will try to authenticate as.
Default is to try to authenticate as the current user.

___

## SMB2_SetPassword

(SWI &54507)

### Entry

R0 the SMB2 context handle\
R1 `const char *` the password to use when connecting

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set the password that we will try to authenticate as.

___

## SMB_SetDomain

(SWI &54508)

### Entry

R0 the SMB2 context handle\
R1 `const char *` the domain to use when connecting

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set the domain when authenticating.

___

## SMB2_SetWorkstation

(SWI &54509)

### Entry

R0 the SMB2 context handle\
R1 `const char *` the workstation name to use when connecting

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Set the workstation when authenticating.

___

## SMB2_ConnectShare

(SWI &5450A)

### Entry

R0 the SMB2 context handle\
R1 `const char *` server address to connect to\
R2 `const char *` share to connect to\
R3 `const char *` the user to connect as

### Exit

R0 corrupted.
If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Synchronous call to connect to a share.

___

## SMB2_DisconnectShare

(SWI &5450B)

### Entry

R0 the SMB2 context handle

### Exit

R0 corrupted.

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Synchronous call to disconnect from a share

___

## SMB2_OpenDir

(SWI &5450C)

### Entry

R0 the SMB2 context handle\
R1 `const char *` the path of the directory

### Exit

R0 the SMB 2 directory handle

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Synchronous open directory

___

## SMB2_CloseDir

(SWI &5450D)

### Entry

R0 the SMB2 context handle\
R1 the SMB 2 directory handle

### Exit

R0 corrupted.

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

close directory

___

## SMB2_ReadDir

(SWI &5450E)

### Entry

R0 the SMB2 context handle\
R1 the SMB 2 directory handle

## Exit

R0 `struct smb2_dirent *` pointer to a directory entry

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Read a directory entry

___

## SMB2_RewindDir

(SWI &5450F)

### Entry

R0 the SMB2 context handle\
R1 the SMB 2 directory handle

### Exit

R0 corrupted.

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Rewind directory entry

___

## SMB2_TellDir

(SWI &54510)

### Entry

R0 the SMB2 context handle\
R1 the SMB 2 directory handle

## Exit

R0 The location of the current entry

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

tell directory position

___

## SMB2_SeekDir

(SWI &54511)

### Entry

R0 the SMB2 context handle\
R1 the SMB 2 directory handle\
R2 the location of the new current directory entry

### Exit

R0 corrupted.

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

seek directory position

___

## SMB2_Open

(SWI &54512)

### Entry

R0 the SMB2 context handle\
R1 `const char *` the file path to open\
R2 the file open flags

### Exit

R0 the SMB2 file handle

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Opens or creates a file.

Supported flags are:

``` C
O_RDONLY =       0x0000,      /* open for reading only */
O_WRONLY =       0x0001,      /* open for writing only */
O_RDWR   =       0x0002,      /* open for reading and writing */
O_SYNC   =       0x0080,      /* synch I/O file integrity */
O_CREAT  =       0x0200,      /* create if nonexistant */
O_TRUNC  =       0x0400,      /* truncate to zero length */
O_EXCL   =       0x0800       /* error if already exists */
```

___

## SMB2_Close

(SWI &54513)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle

### Exit

R0 int

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Sync close()

___

## SMB2_FSync

(SWI &54514)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle

### Exit

R0 int

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Sync fsync()

___

## SMB2_GetMaxReadSize

(SWI &54515)

### Entry

R0 the SMB2 context handle\

### Exit

R0 uint32_t maximum read size

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

SMB2 servers have a maximum size for reading data that they support.

___

## SMB2_GetMaxWriteSize

(SWI &54516)

### Entry

R0 the SMB2 context handle\

### Exit

R0 uint32_t the maximum write size

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

SMB2 servers have a maximum size for writing data that they support.

___

## SMB2_PRead

(SWI &54517)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle\
R2 `uint8_t *buf`\
R3 `uint32_t count`\
R4,R5 `uint64_t offset` (R4 = lower 32 bits of the offset)

### Exit

R0 the number of bytes read

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Synchronous file read.
Use SMB2_GetMaxReadSize to discover the maximum data size that the server supports.

___

## SMB2_Read

(SWI &54518)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle\
R2 `uint8_t *buf`\
R3 `uint32_t count`

### Exit

R0 the number of bytes read

If the V flag is set, then an error occurred, and R0 points to an error block, the first word of which contains an error number. The rest of the error block consists of a null-terminated error message.

### Use

Synchronous file read.
Use SMB2_GetMaxReadSize to discover the maximum data size that the server supports.

___

## SMB2_PWrite

(SWI &54519)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle\
R2 `uint8_t *buf`\
R3 `uint32_t count`\
R4,R5 `uint64_t offset` (R4 = lower 32 bits of the offset)

### Exit

R0 Number of bytes written

### Use

Use SMB2_GetMaxWriteSize to discover the maximum data size that the server supports.

___

## SMB2_Write

(SWI &5451A)

### Entry

R0 the SMB2 context handle\
R1 the SMB2 file handle\
R2 `uint8_t *buf`\
R3 `uint32_t count`

### Exit

R0 Number of bytes written

### Use

Use SMB2_GetMaxWriteSize to discover the maximum data size that the server supports.

___

# Structures

## smb2_stat_64

``` C
/* Stat structure */
#define SMB2_TYPE_FILE      0x00000000
#define SMB2_TYPE_DIRECTORY 0x00000001
#define SMB2_TYPE_LINK      0x00000002

struct smb2_stat_64 {
        uint32_t smb2_type;
        uint32_t smb2_nlink;
        uint64_t smb2_ino;
        uint64_t smb2_size;
        uint64_t smb2_atime;
        uint64_t smb2_atime_nsec;
        uint64_t smb2_mtime;
        uint64_t smb2_mtime_nsec;
        uint64_t smb2_ctime;
        uint64_t smb2_ctime_nsec;
    uint64_t smb2_btime;
    uint64_t smb2_btime_nsec;
};
```

## smb2_dirent

``` C
struct smb2_dirent {
        const char *name;
        struct smb2_stat_64 st;
};
```

# Errors

It is planned that the error numbers will use the same error number range and encoding as the Internet module uses for common errors. The error numbers (ie &20E00 - &20E7F) are used for standard Internet errors. These are &20E00 greater than the corresponding Unix error number (listed below).

## Unix Error Numbers

| Value | Name            | Meaning                             |
|------:|-----------------|-------------------------------------|
| 1     | EPERM           | Not owner                           |
| 2     | ENOENT          | No such file or directory           |
| 3     | ESRCH           | No such process                     |
| 4     | EINTR           | Interrupted system call             |
| 5     | EIO             | I/O error                           |
| 6     | ENXIO           | No such device or address           |
| 7     | E2BIG           | Arg list too long                   |
| 8     | ENOEXEC         | Exec format error                   |
| 9     | EBADF           | Bad file number                     |
| 10    | ECHILD          | No children                         |
| 11    | EAGAIN          | Resource temporarily unavailable    |
| 12    | ENOMEM          | Not enough memory                   |
| 13    | EACCES          | Permission denied                   |
| 14    | EFAULT          | Bad address                         |
| 15    | ENOTBLK         | Block device required               |
| 16    | EBUSY           | Device busy                         |
| 17    | EEXIST          | File exists                         |
| 18    | EXDEV           | Cross-device link                   |
| 19    | ENODEV          | No such device                      |
| 20    | ENOTDIR         | Not a directory                     |
| 21    | EISDIR          | Is a directory                      |
| 22    | EINVAL          | Invalid argument                    |
| 23    | ENFILE          | File table overflow                 |
| 24    | EMFILE          | Too many open files                 |
| 25    | ENOTTY          | Inappropriate I/O control operation |
| 26    | ETXTBSY         | Text file busy                      |
| 27    | EFBIG           | File too large                      |
| 28    | ENOSPC          | No space left on device             |
| 29    | ESPIPE          | Illegal seek                        |
| 30    | EROFS           | Read-only file system               |
| 31    | EMLINK          | Too many links                      |
| 32    | EPIPE           | Broken pipe                         |
| 33    | EDOM            | Argument value error                |
| 34    | ERANGE          | Result out of range                 |
| 35    | EWOULDBLOCK     | Operation would block               |
| 36    | EINPROGRESS     | Operation now in progress           |
| 37    | EALREADY        | Operation already in progress       |
| 38    | ENOTSOCK        | Socket operation on non-socket      |
| 39    | EDESTADDRREQ    | Destination address required        |
| 40    | EMSGSIZE        | Message too long                    |
| 41    | EPROTOTYPE      | Protocol wrong type for socket      |
| 42    | ENOPROTOOPT     | Option not supported by protocol    |
| 43    | EPROTONOSUPPORT | Protocol not supported              |
| 44    | ESOCKTNOSUPPORT | Socket type not supported           |
| 45    | EOPNOTSUPP      | Operation not supported on socket   |
| 46    | EPFNOSUPPORT    | Protocol family not supported       |
| 47    | EAFNOSUPPORT    | Address family not supported by protocol family |
| 48    | EADDRINUSE      | Address already in use              |
| 49    | EADDRNOTAVAIL   | Can't assign requested address      |
| 50    | ENETDOWN        | Network is down                     |
| 51    | ENETUNREACH     | Network is unreachable              |
| 52    | ENETRESET       | Network dropped connection on reset |
| 53    | ECONNABORTED    | Software caused connection abort    |
| 54    | ECONNRESET      | Connection reset by peer            |
| 55    | ENOBUFS         | No buffer space available           |
| 56    | EISCONN         | Socket is already connected         |
| 57    | ENOTCONN        | Socket is not connected             |
| 58    | ESHUTDOWN       | Can't send after socket shutdown    |
| 59    | ETOOMANYREFS    | Too many references: can't splice   |
| 60    | ETIMEDOUT       | Connection timed out                |
| 61    | EREFUSED        | Connection refused                  |
| 62    | ELOOP           | Too many levels of symbolic links   |
| 63    | ENAMETOOLONG    | File name too long                  |
| 64    | EHOSTDOWN       | Host is down                        |
| 65    | EHOSTUNREACH    | Host is unreachable                 |
| 66    | ENOTEMPTY       | Directory not empty                 |
| 67    | EPROCLIM        | Too many processes                  |
| 68    | EUSERS          | Too many users                      |
| 69    | EDQUOT          | Disc quota exceeded                 |
| 70    | ESTALE          | Stale NFS file handle               |
| 71    | EREMOTE         | Too many levels of remote in path   |
| 72    | ENOSTR          | Not a stream device                 |
| 73    | ETIME           | Timer expired                       |
| 74    | ENOSR           | Out of stream resources             |
| 75    | ENOMSG          | No message of desired type          |
| 76    | EBADMSG         | Not a data message                  |
| 77    | EIDRM           | Identifier removed                  |
| 78    | EDEADLK         | Deadlock situation detected/avoided |
| 79    | ENOLCK          | No record locks available           |
| 80    | ENOMSG          | No suitable message on queue        |
| 81    | EIDRM           | Identifier removed from system      |
| 82    | ELIBVER         | Wrong version of shared library     |
| 83    | ELIBACC         | Permission denied (shared library)  |
| 84    | ELIBLIM         | Shared libraries nested too deeply  |
| 85    | ELIBNOENT       | Shared library file not found       |
| 86    | ELIBNOEXEC      | Shared library exec format error    |
| 87    | ENOSYS          | Function not implemented            |
