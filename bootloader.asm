; Taken from https://github.com/joesavage/bare-bones-bootloader/blob/master/bootloader.asm
BITS 16

start:
    ; Setup a 4k stack after the bootloader.
    mov ax, 07c0h
    ; Skip over the bootloader (200H).
    add ax, 20h
    mov ss, ax
    mov sp, 4096

    ; Setup data segment.
    mov ax, 07c0h
    mov ds, ax

    ; TODO load other program from clients.
    ; Display a message.
    mov si, message
    call print
    cli
    hlt

data:
    message db 'Hello, world', 0


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


times 510-($-$$) db 0
; Mark this bootable.
dw 0xAA55
