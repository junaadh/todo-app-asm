.include "constants.s"
.include "macros.s"
.include "functions.s"

.global _start
.align 2

_start:
        write  STDOUT, start, start_len
        sub    sp,  sp,  #80

        stp    x29, x30, [sp,  #64]
        add    x29, sp,  #64

        adrp   x8,  ___stack_chk_guard@gotpage
        ldr    x8,  [x8,  ___stack_chk_guard@gotpageoff]
        ldr    x8,  [x8]
        stur   x8,  [x29,  #-8]

        write  STDOUT, socket_trace, socket_trace_len
        str    wzr, [sp,  #20]
        mov    w2,  #0
        mov    w1,  SOCK_STREAM
        mov    w0,  PF_INET
        bl     _socket
        str    w0,  [sp,  #16]
        ldr    w8,  [sp,  #16]
        adds   w8,  w8,  #1
        cmp    w8,  #0
        beq    error_any
        write  STDOUT, ok, ok_len

        write  STDOUT, bind_trace, bind_trace_len
        sub    x1,  x29,  #24
        stur   xzr, [x29,  #-24]
        stur   xzr, [x29,  #-16]
        mov    w8,  PF_INET
        sturb  w8,  [x29,  #-23]
        stur   wzr, [x29,  #-20]
        mov    w8,  PORT
        sturh  w8,  [x29,  #-22]
        ldr    w0,  [sp,   #16] 
        mov    w2,  #16
        bl     _bind
        subs   w8, w0, #0
        cset   w8, eq
        tbnz   w8, #0, pass
        b      error_any
pass:
        write  STDOUT, ok, ok_len

        write  STDOUT, listen_trace, listen_trace_len
        ldr    w0, [sp, #16]
        mov    w1, BACKLOG
        bl     _listen
        adds   w8, w0, #1
        cmp    w8, #0
        beq    error_any
        write  STDOUT, ok, ok_len

next_req:
        write  STDOUT, accept_trace, accept_trace_len
        add    x2,  sp,  #8
        mov    w8,  #16
        str    w8,  [sp, #8]
        ldr    w0,  [sp, #16]
        add    x1,  sp,  #24
        bl     _accept
        str    w0,  [sp, #12]
        ldr    w8,  [sp, #12]
        adds   w8,  w8,  #1
        cmp    w8,  #0
        beq    error_any

        add    x2, sp,   #8
        mov    w8, #16
        str    w8, [sp, #30]        
        ldr    w0, [sp,  #12]
        read   x0, request, REQUEST_CAP
        str    w0, [sp,  #30]
        cmp    w8, #0
        beq    error_any
        write  STDOUT, ok, ok_len

        ldr    w8, [sp, #30]
        write  STDOUT, request, x8

        req_ops request, x8, get, get_len
        cmp    x0, #0
        bgt    handle_get
        
        ldr    w8,  [sp, #30]
        req_ops request, x8, post, post_len
        cmp    x0, #0
        bgt    handle_post

handle_get:
        ldr    x3,  [sp, #30]
        req_route request, x3, index_route, index_route_len, get_len

        cmp    x0,  #0
        bgt    serve_index_page

        b      serve_error_404    

handle_post:
        ldr    x3,  [sp, #30]
        req_route request, x3, shutdown_route, shutdown_route_len, post_len

        cmp    x0,  #0
        bgt    process_shutdown
        
        b      serve_error_404    

serve_index_page:
        ldr    x8, [sp, #12]
        
        write  x8, index_page_response, index_page_response_len
        write  x8, index_page_header, index_page_header_len
        write  x8, index_page_footer, index_page_footer_len
        
        ldr    w0,  [sp, #12]
        bl     _close
        b      next_req

serve_error_404:
        ldr    x8, [sp, #12]
        
        write  x8, error_404, error_404_len
        
        ldr    w0,  [sp, #12]
        bl     _close
        b      next_req

process_shutdown:
        ldr    x8, [sp, #12]

        write  x8, shutdown_response, shutdown_response_len
        b      shutdown

shutdown:
        write  STDOUT, shutdown_trace, shutdown_trace_len
        ldr    x8,  [sp, #16]
        close  x8
        ldr    x8,  [sp, #12]
        close  x8
        b      stack_integ_prot

stack_integ_prot:
        str    wzr, [sp, #20]
        ldr    w8,  [sp, #20]
        str    w8,  [sp,  #4]
        ldur   x9,  [x29, #-8]
        adrp   x8,  ___stack_chk_guard@gotpage
        ldr    x8,  [x8,  ___stack_chk_guard@gotpageoff]
        ldr    x8,  [x8]
        subs   x8,  x8,  x9
        cset   w8,  eq
        tbnz   w8,  #0,  chk_pass
        b      chk_fail

chk_fail:
        bl     ___stack_chk_fail
        b      error_any

chk_pass:
        ldr    w0,  [sp,  #4]
        ldp    x29, x30, [sp,  #64]
        add    sp,  sp,  #80
        write  STDOUT, ok, ok_len
        exit   0

error_any:
        write  STDERR, error_msg, error_msg_len

        ldr    w0,  [sp, #12]
        bl     _close
        ldr    w0,  [sp, #16]
        bl     _close
        
        exit  1

.data
.include "data.s"
