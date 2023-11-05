.macro  write  fd,  buf,  count
        mov    x0,  \fd
        adrp   x1,  \buf@page
        add    x1,  x1,  \buf@pageoff
        mov    x2,  \count
        mov    x16, SYS_write
        svc    #0x80

        mov    x0,  \fd
        mov    x1,  xzr
        mov    x2,  xzr
        mov    x16, SYS_write
        svc    #0x80
.endm

.macro  write_c fd, buf
        mov    x1,  \buf
        mov    x6,  \fd

        bl     write_cstr
.endm

.macro  read   fd,  buf,  count
        mov    x0,  \fd
        adrp   x1,  \buf@page
        add    x1,  x1,  \buf@pageoff
        mov    x2,  \count
        mov    x16, SYS_read
        svc    #0x80
.endm

.macro  req_ops req, req_len tmp, tmp_len
        mov    x0,  #0
        adrp   x2,  \req@page
        add    x2,  x2,  \req@pageoff
        mov    x3,  \req_len
        adrp   x4,  \tmp@page
        add    x4,  x4,  \tmp@pageoff
        mov    x5,  \tmp_len

        bl     starts_with
.endm


.macro  req_route req, req_len tmp, tmp_len method
        mov    x0,  #0
        mov    x7,  \method
        adrp   x2,  \req@page
        add    x2,  x2,  \req@pageoff
        add    x2,  x2,  x7
        mov    x3,  \req_len
        sub    x3,  x3,  x7
        adrp   x4,  \tmp@page
        add    x4,  x4,  \tmp@pageoff
        mov    x5,  \tmp_len

        bl     starts_with 
.endm

.macro  close fd
        mov    x0,  \fd
        mov    x16, SYS_close
        svc    #0x80
.endm

.macro  exit   code
        mov    x0,  \code
        mov    x16, SYS_exit
        svc    #0x80
.endm
