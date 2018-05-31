;主引导程序
;------------------------------------------------------------------------------

%include "boot.inc"

SECTION MBR vstart=0x7c00
mov ax, cs
mov ds, ax
mov es, ax
mov ss, ax
mov fs, ax
mov sp, 0x7c00

;请屏利用0x10中断的0x6号功能
;------------------------------------------------------------------------------
mov ax, 0x600
mov bx, 0x700
mov cx, 0
mov dx, 0x184f

int  0x10

;获取光标位置
;------------------------------------------------------------------------------
mov ah, 3
mov bh, 1
int 0x10

;打印字符串
;------------------------------------------------------------------------------
mov ax, message
mov bp, ax

mov cx, 12 
mov ax, 0x1301 
mov bx, 0x2

int 0x10

jmp $

message db "Hello, World"
mov eax, LOADER_START_SECTION
mov bx, LOADER_BASE_ADDR
mov cx, 1
call rd_disk_m_16

jmp LOADER_BASE_ADDR

;读取n个扇区
;------------------------------------------------------------------------------
rd_disk_m_16:
    mov esi, eax
    mov di, cx

    ;设置要读取的扇区数
    mov dx, 0x1f2
    mov al, al
    out dx, al
    mov eax, esi
