get:
        .ascii  "GET "
.equ    get_len, .-get

post:
        .ascii  "POST "
.equ    post_len, .-post

index_route:
        .ascii  "/ "
.equ    index_route_len, .-index_route

shutdown_route:
        .ascii  "/shutdown "
.equ    shutdown_route_len, .-shutdown_route

request:
        .space  REQUEST_CAP

error_400:
        .ascii  "HTTP/1.1 400 Bad Request\r\n"
        .ascii  "Content-Type: text/html; charset=utf-8\r\n"
        .ascii  "Connection: close\r\n\r\n"
        .ascii  "<html>\n"
        .ascii  "  <head>\n"
        .ascii  "    <title>Assembly Server</title>\n"
        .ascii  "    <style>\n"
        .ascii  "      body {\n"
        .ascii  "        background-color: #000000;\n"
        .ascii  "        display: flex;\n"
        .ascii  "        justify-content: center;\n"
        .ascii  "        flex-direction: column;\n"
        .ascii  "      }\n"
        .ascii  "      h1 {\n"
        .ascii  "        color: #ffffff;\n"
        .ascii  "      }\n"
        .ascii  "    </style>\n"
        .ascii  "  </head>\n"
        .ascii  "  <body>\n" 
        .ascii  "    <h1>Bad Request</h1>\n"
        .ascii  "    <a href='/'>Back to home</a>\n"
        .ascii  "  </body>\n"
        .ascii  "</html>\n"

        
.equ  error_400_len, .-error_400

error_404:
        .ascii  "HTTP/1.1 404 Not Found\r\n"
        .ascii  "Content-Type: text/html; charset=utf-8\r\n"
        .ascii  "Connection: close\r\n\r\n"
        .ascii  "<html>\n"
        .ascii  "  <head>\n"
        .ascii  "    <title>Assembly Server</title>\n"
        .ascii  "    <style>\n"
        .ascii  "      body {\n"
        .ascii  "        background-color: #000000;\n"
        .ascii  "        display: flex;\n"
        .ascii  "        justify-content: center;\n"
        .ascii  "        flex-direction: column;\n"
        .ascii  "      }\n"
        .ascii  "      h1 {\n"
        .ascii  "        color: #ffffff;\n"
        .ascii  "      }\n"
        .ascii  "    </style>\n"
        .ascii  "  </head>\n"
        .ascii  "  <body>\n" 
        .ascii  "    <h1>Page Not Found</h1>\n"
        .ascii  "    <a href='/'>Back to home</a>\n"
        .ascii  "  </body>\n"
        .ascii  "</html>\n"

.equ  error_404_len, .-error_404

error_405:       
        .ascii  "HTTP/1.1 405 Method Not Allowed\r\n"
        .ascii  "Content-Type: text/html; charset=utf-8\r\n"
        .ascii  "Connection: close\r\n\r\n"
        .ascii  "<html>\n"
        .ascii  "  <head>\n"
        .ascii  "    <title>Assembly Server</title>\n"
        .ascii  "    <style>\n"
        .ascii  "      body {\n"
        .ascii  "        background-color: #000000;\n"
        .ascii  "        display: flex;\n"
        .ascii  "        justify-content: center;\n"
        .ascii  "        flex-direction: column;\n"
        .ascii  "      }\n"
        .ascii  "      h1 {\n"
        .ascii  "        color: #ffffff;\n"
        .ascii  "      }\n"
        .ascii  "    </style>\n"
        .ascii  "  </head>\n"
        .ascii  "  <body>\n" 
        .ascii  "    <h1>Method not allowed</h1>\n"
        .ascii  "    <a href='/'>Back to home</a>\n"
        .ascii  "  </body>\n"
        .ascii  "</html>\n"
        
.equ  error_405_len, .-error_405

index_page_response:
        .ascii  "HTTP/1.1 200 OK\r\n"
        .ascii  "Content-Type: text/html; charset=utf-8\r\n"
        .ascii  "Connection: close\r\n\r\n"

.equ index_page_response_len, .-index_page_response

index_page_header:
        .ascii  "<html>\n"
        .ascii  "  <head>\n"
        .ascii  "    <title>Assembly Server</title>\n"
        .ascii  "    <style>\n"
        .ascii  "      body {\n"
        .ascii  "        background-color: #000000;\n"
        .ascii  "        display: flex;\n"
        .ascii  "        justify-content: center;\n"
        .ascii  "        flex-direction: column;\n"
        .ascii  "      }\n"
        .ascii  "      h1 {\n"
        .ascii  "        color: #ffffff;\n"
        .ascii  "      }\n"
        .ascii  "    </style>\n"
        .ascii  "  </head>\n"
        .ascii  "  <body>\n"
        .ascii  "    <h1>Hello from Arm64 Assembly Server</h1>\n"
        .ascii  "    <h1>To Do:</h1>\n"
        .ascii  "    <ul>\n"
        
.equ index_page_header_len, .-index_page_header

index_page_footer:
        .ascii  "      <li>\n"
        .ascii  "        <form style='display: inline' method='post' action='/' enctype='text/plain'>\n"
        .ascii  "          <input style='width: 25px' type='submit' value='+'>\n"
        .ascii  "          <input type='text' name='todo' autofocus>\n"
        .ascii  "        </form>\n"
        .ascii  "      </li>\n"
        .ascii  "    </ul>\n"
        .ascii  "    <form method='post' action='/shutdown'>\n"
        .ascii  "      <input type='submit' value='shutdown'>\n"
        .ascii  "    </form>\n"
        .ascii  "  </body>\n"
        .ascii  "</html>\n"
        
.equ index_page_footer_len, .-index_page_footer

todo_header:
        .ascii  "      <li>\n"
.equ    todo_header_len, .-todo_header

todo_footer:
        .ascii  "      </li>\n"
.equ    todo_footer_len, .-todo_footer 
        
delete_button_prefix:
        .ascii  "<form style='display: inline' method='post' action='/'>"
        .ascii  "<button style='width: 25px' type='submit' name='delete' value='"
.equ    delete_button_prefix_len, .-delete_button_prefix

delete_button_suffix:
        .ascii  "'>x</button></form>\n"
.equ    delete_button_suffix_len, .-delete_button_suffix

shutdown_response:
        .ascii  "HTTP/1.1 200 OK\r\n"
        .ascii  "Content-Type: text/html; charset=utf-8\r\n"
        .ascii  "Connection: close\r\n\r\n"
        .ascii  "<h1>Shutting down the server...</h1>\n"
        .ascii  "Please close this tab\n"
        .ascii  "<html>\n"
        .ascii  "  <head>\n"
        .ascii  "    <title>Assembly Server</title>\n"
        .ascii  "    <style>\n"
        .ascii  "      body {\n"
        .ascii  "        background-color: #000000;\n"
        .ascii  "        display: flex;\n"
        .ascii  "        justify-content: center;\n"
        .ascii  "        flex-direction: column;\n"
        .ascii  "      }\n"
        .ascii  "      h1 {\n"
        .ascii  "        color: #ffffff;\n"
        .ascii  "      }\n"
        .ascii  "    </style>\n"
        .ascii  "  </head>\n"
        .ascii  "  <body>\n" 
        .ascii  "    <h1>Shutting down Assembly Server</h1>\n"
        .ascii  "    Please close this tab\n"
        .ascii  "  </body>\n"
        .ascii  "</html>\n"

.equ    shutdown_response_len, .-shutdown_response

todo_form_data_prefix:
        .ascii  "todo="
        
.equ    todo_form_data_prefix_len, .-todo_form_data_prefix

delete_form_data_prefix:
        .ascii  "delete="

.equ    delete_form_data_prefix_len, .-delete_form_data_prefix
