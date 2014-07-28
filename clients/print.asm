; print a message
print:
    mov ah, 0Eh

.printchar:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .printchar

.done:
    ret
