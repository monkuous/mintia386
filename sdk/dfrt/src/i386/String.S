.section "text", "ax", %progbits

# 4(%esp) - word
# 8(%esp) - size
# 12(%esp) - ptr
.globl _df_memset
.type _df_memset, @function
_df_memset:
    push %esi
    push %edi

    mov 12(%esp), %esi
    mov 16(%esp), %ecx
    mov 20(%esp), %edi

    test %ecx, %ecx
    jnz .Lmemset_gzero

    pop %edi
    pop %esi
    ret

.Lmemset_gzero:

    mov %edi, %edx
    xor $3, %edx
    add $1, %edx
    and $3, %edx
    jz .Lmemset_fdone

    mov %esi, %eax

    cmp %ecx, %edx
    jb .Lmemset_goodlen

    mov %ecx, %edx

.Lmemset_goodlen:
    sub %edx, %ecx

.Lmemset_fu:
    mov %al, (%edi)

    shr $8, %eax

    add $1, %edi
    sub $1, %edx
    jnz .Lmemset_fu

.Lmemset_fdone:
    # ptr is now aligned

    mov %ecx, %edx
    shr $6, %edx # do 64 bytes each loop

    jz .Lmemset_b64done

.Lmemset_b64:
    mov %esi, (%edi)
    mov %esi, 4(%edi)
    mov %esi, 8(%edi)
    mov %esi, 12(%edi)
    mov %esi, 16(%edi)
    mov %esi, 20(%edi)
    mov %esi, 24(%edi)
    mov %esi, 28(%edi)
    mov %esi, 32(%edi)
    mov %esi, 36(%edi)
    mov %esi, 40(%edi)
    mov %esi, 44(%edi)
    mov %esi, 48(%edi)
    mov %esi, 52(%edi)
    mov %esi, 56(%edi)
    mov %esi, 60(%edi)

    add $64, %edi
    sub $1, %edx
    jnz .Lmemset_b64

.Lmemset_b64done:
    mov %ecx, %edx
    and $63, %edx

    shr $2, %edx # do 4 bytes each loop

    jz .Lmemset_b4done

.Lmemset_b4:
    mov %esi, (%edi)

    add $4, %edi
    sub $1, %edx
    jnz .Lmemset_b4

.Lmemset_b4done:
    mov %ecx, %edx
    and $3, %edx # do 1 byte each loop

    jz .Lmemset_b1done

    mov %esi, %eax

.Lmemset_b1:
    mov %al, (%edi)

    shr $8, %eax

    add $1, %edi
    sub $1, %edx
    jnz .Lmemset_b1

.Lmemset_b1done:
    pop %edi
    pop %esi
    ret
.size _df_memset, . - _df_memset

# 4(%esp) - sz
# 8(%esp) - src
# 12(%esp) - dest
.globl _df_memcpy
.type _df_memcpy, @function
_df_memcpy:
    push %ebx
    push %esi
    push %edi

    mov 16(%esp), %ecx
    mov 20(%esp), %esi
    mov 24(%esp), %edi

    test %ecx, %ecx
    jz .Lmemcpy_zerosize

    mov %esi, %ebx
    xor %edi, %ebx

    mov %ebx, %edx
    and $1, %edx
    jz .Lmemcpy_aligned_with_eachother

    jmp .Lmemcpy_unaligned

.Lmemcpy_zerosize:
    pop %edi
    pop %esi
    pop %ebx
    ret

.Lmemcpy_aligned_with_eachother:
    mov %esi, %edx
    xor $3, %edx
    add $1, %edx
    and $3, %edx

    jz .Lmemcpy_fdone

    cmp %ecx, %edx
    jb .Lmemcpy_goodlen

    mov %ecx, %edx

.Lmemcpy_goodlen:
    sub %edx, %ecx

.Lmemcpy_fu:
    mov (%esi), %al
    mov %al, (%edi)

    add $1, %esi
    add $1, %edi
    sub $1, %edx
    jnz .Lmemcpy_fu

.Lmemcpy_fdone:
    mov %ebx, %edx
    and $3, %edx
    jz .Lmemcpy_aligned32

.Lmemcpy_aligned16:
    mov %ecx, %edx
    shr $6, %edx # do 64 bytes each loop

    jz .Lmemcpy_copy_16_by_64done

.Lmemcpy_copy_16_by_64:
    mov (%esi), %ax
    mov 2(%esi), %bx

    mov %ax, (%edi)
    mov %bx, 2(%edi)

    mov 4(%esi), %ax
    mov 6(%esi), %bx

    mov %ax, 4(%edi)
    mov %bx, 6(%edi)

    mov 8(%esi), %ax
    mov 10(%esi), %bx

    mov %ax, 8(%edi)
    mov %bx, 10(%edi)

    mov 12(%esi), %ax
    mov 14(%esi), %bx

    mov %ax, 12(%edi)
    mov %bx, 14(%edi)

    mov 16(%esi), %ax
    mov 18(%esi), %bx

    mov %ax, 16(%edi)
    mov %bx, 18(%edi)

    mov 20(%esi), %ax
    mov 22(%esi), %bx

    mov %ax, 20(%edi)
    mov %bx, 22(%edi)

    mov 24(%esi), %ax
    mov 26(%esi), %bx

    mov %ax, 24(%edi)
    mov %bx, 26(%edi)

    mov 28(%esi), %ax
    mov 30(%esi), %bx

    mov %ax, 28(%edi)
    mov %bx, 30(%edi)

    mov 32(%esi), %ax
    mov 34(%esi), %bx

    mov %ax, 32(%edi)
    mov %bx, 34(%edi)

    mov 36(%esi), %ax
    mov 38(%esi), %bx

    mov %ax, 36(%edi)
    mov %bx, 38(%edi)

    mov 40(%esi), %ax
    mov 42(%esi), %bx

    mov %ax, 40(%edi)
    mov %bx, 42(%edi)

    mov 44(%esi), %ax
    mov 46(%esi), %bx

    mov %ax, 44(%edi)
    mov %bx, 46(%edi)

    mov 48(%esi), %ax
    mov 50(%esi), %bx

    mov %ax, 48(%edi)
    mov %bx, 50(%edi)

    mov 52(%esi), %ax
    mov 54(%esi), %bx

    mov %ax, 52(%edi)
    mov %bx, 54(%edi)

    mov 56(%esi), %ax
    mov 58(%esi), %bx

    mov %ax, 56(%edi)
    mov %bx, 58(%edi)

    mov 60(%esi), %ax
    mov 62(%esi), %bx

    mov %ax, 60(%edi)
    mov %bx, 62(%edi)

    add $64, %edi
    add $64, %esi
    sub $1, %edx
    jnz .Lmemcpy_copy_16_by_64

.Lmemcpy_copy_16_by_64done:
    mov %ecx, %edx
    and $63, %edx

    jmp .Lmemcpy_copy_last_bytes

.Lmemcpy_aligned32:
    mov %ecx, %edx
    shr $6, %edx # do 64 bytes each loop

    jz .Lmemcpy_copy_32_by_64done

.Lmemcpy_copy_32_by_64:
    mov (%esi), %eax
    mov 4(%esi), %ebx

    mov %eax, (%edi)
    mov %ebx, 4(%edi)

    mov 8(%esi), %eax
    mov 12(%esi), %ebx

    mov %eax, 8(%edi)
    mov %ebx, 12(%edi)

    mov 16(%esi), %eax
    mov 20(%esi), %ebx

    mov %eax, 16(%edi)
    mov %ebx, 20(%edi)

    mov 24(%esi), %eax
    mov 28(%esi), %ebx

    mov %eax, 24(%edi)
    mov %ebx, 28(%edi)

    mov 32(%esi), %eax
    mov 36(%esi), %ebx

    mov %eax, 32(%edi)
    mov %ebx, 36(%edi)

    mov 40(%esi), %eax
    mov 44(%esi), %ebx

    mov %eax, 40(%edi)
    mov %ebx, 44(%edi)

    mov 48(%esi), %eax
    mov 52(%esi), %ebx

    mov %eax, 48(%edi)
    mov %ebx, 52(%edi)

    mov 56(%esi), %eax
    mov 60(%esi), %ebx

    mov %eax, 56(%edi)
    mov %ebx, 60(%edi)

    add $64, %edi
    add $64, %esi
    sub $1, %edx
    jnz .Lmemcpy_copy_32_by_64

.Lmemcpy_copy_32_by_64done:
    mov %ecx, %edx
    and $63, %edx

    jmp .Lmemcpy_copy_last_bytes

.Lmemcpy_unaligned:
    mov %ecx, %edx
    shr $5, %edx # do 32 bytes each loop

    jz .Lmemcpy_copy_8_by_32done

.Lmemcpy_copy_8_by_32:
    mov (%esi), %al
    mov 1(%esi), %ah
    mov 2(%esi), %bl
    mov 3(%esi), %bh

    mov %al, (%edi)
    mov %ah, 1(%edi)
    mov %bl, 2(%edi)
    mov %bh, 3(%edi)

    mov 4(%esi), %al
    mov 5(%esi), %ah
    mov 6(%esi), %bl
    mov 7(%esi), %bh

    mov %al, 4(%edi)
    mov %ah, 5(%edi)
    mov %bl, 6(%edi)
    mov %bh, 7(%edi)

    mov 8(%esi), %al
    mov 9(%esi), %ah
    mov 10(%esi), %bl
    mov 11(%esi), %bh

    mov %al, 8(%edi)
    mov %ah, 9(%edi)
    mov %bl, 10(%edi)
    mov %bh, 11(%edi)

    mov 12(%esi), %al
    mov 13(%esi), %ah
    mov 14(%esi), %bl
    mov 15(%esi), %bh

    mov %al, 12(%edi)
    mov %ah, 13(%edi)
    mov %bl, 14(%edi)
    mov %bh, 15(%edi)

    mov 16(%esi), %al
    mov 17(%esi), %ah
    mov 18(%esi), %bl
    mov 19(%esi), %bh

    mov %al, 16(%edi)
    mov %ah, 17(%edi)
    mov %bl, 18(%edi)
    mov %bh, 19(%edi)

    mov 20(%esi), %al
    mov 21(%esi), %ah
    mov 22(%esi), %bl
    mov 23(%esi), %bh

    mov %al, 20(%edi)
    mov %ah, 21(%edi)
    mov %bl, 22(%edi)
    mov %bh, 23(%edi)

    mov 24(%esi), %al
    mov 25(%esi), %ah
    mov 26(%esi), %bl
    mov 27(%esi), %bh

    mov %al, 24(%edi)
    mov %ah, 25(%edi)
    mov %bl, 26(%edi)
    mov %bh, 27(%edi)

    mov 28(%esi), %al
    mov 29(%esi), %ah
    mov 30(%esi), %bl
    mov 31(%esi), %bh

    mov %al, 28(%edi)
    mov %ah, 29(%edi)
    mov %bl, 30(%edi)
    mov %bh, 31(%edi)

    add $32, %edi
    add $32, %esi
    sub $1, %edx
    jnz .Lmemcpy_copy_8_by_32

.Lmemcpy_copy_8_by_32done:
    mov %ecx, %edx
    and $31, %edx # do 1 byte each loop

.Lmemcpy_copy_last_bytes:
    jz .Lmemcpy_done

.Lmemcpy_b1:
    mov (%esi), %al
    mov %al, (%edi)

    add $1, %edi
    add $1, %esi
    sub $1, %edx
    jnz .Lmemcpy_b1

.Lmemcpy_done:
    pop %edi
    pop %esi
    pop %ebx
    ret
.size _df_memcpy, . - _df_memcpy

# 4(%esp) - sz
# 8(%esp) - src
# 12(%esp) - dest
.type memcpy_backwards, @function
memcpy_backwards:
    push %ebx
    push %esi
    push %edi

    mov 16(%esp), %ecx
    mov 20(%esp), %esi
    mov 24(%esp), %edi

    test %ecx, %ecx
    jz .Lmemcpyb_zerosize

    add %ecx, %esi
    add %ecx, %edi

    mov %esi, %ebx
    xor %edi, %ebx

    mov %ebx, %edx
    and $1, %edx
    jz .Lmemcpyb_aligned_with_eachother

    jmp .Lmemcpyb_unaligned

.Lmemcpyb_zerosize:
    pop %edi
    pop %esi
    pop %ebx
    ret

.Lmemcpyb_aligned_with_eachother:
    mov %esi, %edx
    and $3, %edx

    jz .Lmemcpyb_fdone

    cmp %ecx, %edx
    jb .Lmemcpyb_goodlen

    mov %ecx, %edx

.Lmemcpyb_goodlen:
    sub %edx, %ecx

.Lmemcpyb_fu:
    sub $1, %esi
    sub $1, %edi

    mov (%esi), %al
    mov %al, (%edi)

    sub $1, %edx
    jnz .Lmemcpyb_fu

.Lmemcpyb_fdone:
    mov %ebx, %edx
    and $3, %edx
    jz .Lmemcpyb_aligned32

.Lmemcpyb_aligned16:
    mov %ecx, %edx
    shr $6, %edx # do 64 bytes each loop

    jz .Lmemcpyb_copy_16_by_64done

.Lmemcpyb_copy_16_by_64:
    sub $64, %edi
    sub $64, %esi

    mov (%esi), %ax
    mov 2(%esi), %bx

    mov %ax, (%edi)
    mov %bx, 2(%edi)

    mov 4(%esi), %ax
    mov 6(%esi), %bx

    mov %ax, 4(%edi)
    mov %bx, 6(%edi)

    mov 8(%esi), %ax
    mov 10(%esi), %bx

    mov %ax, 8(%edi)
    mov %bx, 10(%edi)

    mov 12(%esi), %ax
    mov 14(%esi), %bx

    mov %ax, 12(%edi)
    mov %bx, 14(%edi)

    mov 16(%esi), %ax
    mov 18(%esi), %bx

    mov %ax, 16(%edi)
    mov %bx, 18(%edi)

    mov 20(%esi), %ax
    mov 22(%esi), %bx

    mov %ax, 20(%edi)
    mov %bx, 22(%edi)

    mov 24(%esi), %ax
    mov 26(%esi), %bx

    mov %ax, 24(%edi)
    mov %bx, 26(%edi)

    mov 28(%esi), %ax
    mov 30(%esi), %bx

    mov %ax, 28(%edi)
    mov %bx, 30(%edi)

    mov 32(%esi), %ax
    mov 34(%esi), %bx

    mov %ax, 32(%edi)
    mov %bx, 34(%edi)

    mov 36(%esi), %ax
    mov 38(%esi), %bx

    mov %ax, 36(%edi)
    mov %bx, 38(%edi)

    mov 40(%esi), %ax
    mov 42(%esi), %bx

    mov %ax, 40(%edi)
    mov %bx, 42(%edi)

    mov 44(%esi), %ax
    mov 46(%esi), %bx

    mov %ax, 44(%edi)
    mov %bx, 46(%edi)

    mov 48(%esi), %ax
    mov 50(%esi), %bx

    mov %ax, 48(%edi)
    mov %bx, 50(%edi)

    mov 52(%esi), %ax
    mov 54(%esi), %bx

    mov %ax, 52(%edi)
    mov %bx, 54(%edi)

    mov 56(%esi), %ax
    mov 58(%esi), %bx

    mov %ax, 56(%edi)
    mov %bx, 58(%edi)

    mov 60(%esi), %ax
    mov 62(%esi), %bx

    mov %ax, 60(%edi)
    mov %bx, 62(%edi)

    sub $1, %edx
    jnz .Lmemcpyb_copy_16_by_64

.Lmemcpyb_copy_16_by_64done:
    mov %ecx, %edx
    and $63, %edx

    jmp .Lmemcpyb_copy_last_bytes

.Lmemcpyb_aligned32:
    mov %ecx, %edx
    shr $6, %edx # do 64 bytes each loop

    jz .Lmemcpyb_copy_32_by_64done

.Lmemcpyb_copy_32_by_64:
    sub $64, %edi
    sub $64, %esi

    mov (%esi), %eax
    mov 4(%esi), %ebx

    mov %eax, (%edi)
    mov %ebx, 4(%edi)

    mov 8(%esi), %eax
    mov 12(%esi), %ebx

    mov %eax, 8(%edi)
    mov %ebx, 12(%edi)

    mov 16(%esi), %eax
    mov 20(%esi), %ebx

    mov %eax, 16(%edi)
    mov %ebx, 20(%edi)

    mov 24(%esi), %eax
    mov 28(%esi), %ebx

    mov %eax, 24(%edi)
    mov %ebx, 28(%edi)

    mov 32(%esi), %eax
    mov 36(%esi), %ebx

    mov %eax, 32(%edi)
    mov %ebx, 36(%edi)

    mov 40(%esi), %eax
    mov 44(%esi), %ebx

    mov %eax, 40(%edi)
    mov %ebx, 44(%edi)

    mov 48(%esi), %eax
    mov 52(%esi), %ebx

    mov %eax, 48(%edi)
    mov %ebx, 52(%edi)

    mov 56(%esi), %eax
    mov 60(%esi), %ebx

    mov %eax, 56(%edi)
    mov %ebx, 60(%edi)

    sub $1, %edx
    jnz .Lmemcpyb_copy_32_by_64

.Lmemcpyb_copy_32_by_64done:
    mov %ecx, %edx
    and $63, %edx

    jmp .Lmemcpyb_copy_last_bytes

.Lmemcpyb_unaligned:
    mov %ecx, %edx
    shr $5, %edx # do 32 bytes each loop

    jz .Lmemcpyb_copy_8_by_32done

.Lmemcpyb_copy_8_by_32:
    sub $32, %edi
    sub $32, %esi

    mov (%esi), %al
    mov 1(%esi), %ah
    mov 2(%esi), %bl
    mov 3(%esi), %bh

    mov %al, (%edi)
    mov %ah, 1(%edi)
    mov %bl, 2(%edi)
    mov %bh, 3(%edi)

    mov 4(%esi), %al
    mov 5(%esi), %ah
    mov 6(%esi), %bl
    mov 7(%esi), %bh

    mov %al, 4(%edi)
    mov %ah, 5(%edi)
    mov %bl, 6(%edi)
    mov %bh, 7(%edi)

    mov 8(%esi), %al
    mov 9(%esi), %ah
    mov 10(%esi), %bl
    mov 11(%esi), %bh

    mov %al, 8(%edi)
    mov %ah, 9(%edi)
    mov %bl, 10(%edi)
    mov %bh, 11(%edi)

    mov 12(%esi), %al
    mov 13(%esi), %ah
    mov 14(%esi), %bl
    mov 15(%esi), %bh

    mov %al, 12(%edi)
    mov %ah, 13(%edi)
    mov %bl, 14(%edi)
    mov %bh, 15(%edi)

    mov 16(%esi), %al
    mov 17(%esi), %ah
    mov 18(%esi), %bl
    mov 19(%esi), %bh

    mov %al, 16(%edi)
    mov %ah, 17(%edi)
    mov %bl, 18(%edi)
    mov %bh, 19(%edi)

    mov 20(%esi), %al
    mov 21(%esi), %ah
    mov 22(%esi), %bl
    mov 23(%esi), %bh

    mov %al, 20(%edi)
    mov %ah, 21(%edi)
    mov %bl, 22(%edi)
    mov %bh, 23(%edi)

    mov 24(%esi), %al
    mov 25(%esi), %ah
    mov 26(%esi), %bl
    mov 27(%esi), %bh

    mov %al, 24(%edi)
    mov %ah, 25(%edi)
    mov %bl, 26(%edi)
    mov %bh, 27(%edi)

    mov 28(%esi), %al
    mov 29(%esi), %ah
    mov 30(%esi), %bl
    mov 31(%esi), %bh

    mov %al, 28(%edi)
    mov %ah, 29(%edi)
    mov %bl, 30(%edi)
    mov %bh, 31(%edi)

    sub $1, %edx
    jnz .Lmemcpyb_copy_8_by_32

.Lmemcpyb_copy_8_by_32done:
    mov %ecx, %edx
    and $31, %edx # do 1 byte each loop

.Lmemcpyb_copy_last_bytes:
    jz .Lmemcpyb_done

.Lmemcpyb_b1:
    sub $1, %edi
    sub $1, %esi

    mov (%esi), %al
    mov %al, (%edi)

    sub $1, %edx
    jnz .Lmemcpyb_b1

.Lmemcpyb_done:
    pop %edi
    pop %esi
    pop %ebx
    ret
.size memcpy_backwards, . - memcpy_backwards

.globl _df_memmove
.type _df_memmove, @function
_df_memmove:
    mov 8(%esp), %eax
    cmp 12(%esp), %eax
    jb .Lmemmove_backwards
    jmp _df_memcpy
.Lmemmove_backwards:
    jmp memcpy_backwards
.size _df_memmove, . - _df_memmove

# 4(%esp) - src
# 8(%esp) - dest
.globl strcpy
.type strcpy, @function
strcpy:
    push %esi

    mov 8(%esp), %esi
    mov 12(%esp), %edx
    xor %ecx, %ecx

.Lstrcpy_loop:
    mov (%esi,%ecx,1), %al
    mov %al, (%edx,%ecx,1)
    add $1, %ecx
    test %al, %al
    jnz .Lstrcpy_loop

    pop %esi
    ret
.size strcpy, . - strcpy

# 4(%esp) - max
# 8(%esp) - src
# 12(%esp) - dest
.globl strncpy
.type strncpy, @function
strncpy:
    push %esi
    push %edi

    mov 12(%esp), %edx
    mov 16(%esp), %esi
    mov 20(%esp), %edi
    xor %ecx, %ecx

.Lstrncpy_loop:
    test %edx, %edx
    jz .Lstrncpy_done
    mov (%esi,%ecx), %al
    mov %al, (%edi,%ecx)
    add $1, %ecx
    sub $1, %edx
    test %al, %al
    jnz .Lstrncpy_loop

    pop %edi
    pop %esi
    ret

.Lstrncpy_done:
    movb $0, (%edi,%ecx)

    pop %edi
    pop %esi
    ret
.size strncpy, . - strncpy

# 4(%esp) - str2
# 8(%esp) - str1
# returns:
# %eax - eq
.globl strcmp
.type strcmp, @function
strcmp:
    push %esi

    mov 8(%esp), %esi
    mov 12(%esp), %edx
    xor %ecx, %ecx

.Lstrcmp_loop:
    mov (%esi,%ecx,1), %al
    cmp (%edx,%ecx,1), %al
    jne .Lstrcmp_notequal
    add $1, %ecx
    test %al, %al
    jnz .Lstrcmp_loop

    mov $1, %eax

    pop %esi
    ret

.Lstrcmp_notequal:
    xor %eax, %eax

    pop %esi
    ret
.size strcmp, . - strcmp
