## ToDo Web App
 * written in arm64 assembly
 * tested on apple silicon
 * uses unix libc functions
 * enforces stack integrity

### instructions

 * clone and cd into directory
 * compile and run
```shell
as -arch arm64 -o server.o server.s
ld -o server server.o -lSystem -syslibroot $(xcrun -sdk macosx --show-sdk-path) -e _start
./server
```
 * now server will be listening on port 6969
 * you can visit http://localhost:6969 or http://127.0.01:6969

### functions
 
 [x] support get requests
 [ ] support post requests
 [ ] add persitant state
 [ ] ability to add/remove items
 [x] able to shutdown server from browser

**Extension of [WebServer](https://github.com/junaadh/WebServer)**
