.data
start:         .asciz  "INFO: Starting Web Server!\n"
.equ           start_len,  . - start
socket_trace:  .asciz  "INFO: Creating a socket..."
.equ           socket_trace_len, . - socket_trace
bind_trace:    .asciz  "INFO: Binding to socket..."
.equ           bind_trace_len,  . - bind_trace
listen_trace:  .asciz  "INFO: Listening to socket..."
.equ           listen_trace_len,  . - listen_trace
accept_trace:  .asciz  "INFO: Waiting for clients..."
.equ           accept_trace_len,  . - accept_trace
ok:            .asciz  "...[OK]\n"
.equ           ok_len,  . - ok
error_msg:     .asciz  "...[FAILED]\n"
.equ           error_msg_len,  . - error_msg
shutdown_trace:
               .asciz  "INFO: Shutting down server..."
.equ           shutdown_trace_len,  .-shutdown_trace

.include "http.s"

statbuf:
               .space  sizeof_stat64

todo_db_file_path:
               .asciz  "todo.db"
