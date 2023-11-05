starts_with:
        mov    w0,  #0
        mov    w1,  #0

next_char:
        cmp    x3,  #0
        beq    done
        cmp    x5,  #0
        beq    done

        ldrb   w8,  [x2, #1]
        ldrb   w9,  [x4, #1]
        cmp    w8,  w9
        bne    done

        sub    x3,  x3,  #1
        sub    x5,  x5,  #1
        b      next_char

done:
        cmp    x5,  #0
        beq    yes

no:
        mov    x0,  #0
        ret

yes:
        mov    x0,  #1
        ret

write_cstr:
        mov    x5,  x1
        bl     strlen

        mov    x2,  x0
        mov    x0,  x6
        mov    x16, SYS_write
        svc    #0x80
        ret

strlen:
        mov    w8,  #0

next_byte:
        ldrb   w8,  [x5, #1]
        cmp    w8,  #0
        beq    done_len

        add    w8,  w8,  #1
        b      next_byte

done_len:
        mov    w0,  w8
        ret
