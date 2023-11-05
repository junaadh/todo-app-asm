.equ    SYS_exit,     1
.equ    SYS_read,     3
.equ    SYS_write,    4
.equ    SYS_close,    6
.equ    SYS_accept,   30
.equ    SYS_socket,   97
.equ    SYS_bind,     104
.equ    SYS_listen,   106

.equ    STDOUT,       1
.equ    STDERR,       2

.equ    INADDR_ANY,   0
.equ    SOCK_STREAM,  1 
.equ    PF_INET,      2

.equ    BACKLOG,      5
; /* port number 6969 in lil endian */
.equ    PORT,         14619

.equ    REQUEST_CAP,  128*1024
.equ    sizeof_stat64, 144
