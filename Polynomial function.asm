; Polynomials Functions
; by ShahroOz

; the name of functions says the work of
; them

data segment 
    x dw 7
    ;array dw 2,2,0,-2
    array dw 3,1,4,1,-6 
    roots dw 0,20 dup(?)
    array1 dw 2,1,0,-1
    array2 dw 3,1,-6,11,-6
    sum_res dw 4 dup(?)
    mul_res dw 200 dup(0)
    q_res dw 200 dup(0)
    r_res dw 200 dup(?)
    takjomle dw 2 dup(?) 
    poly_tak dw 200 dup(?)
    temp dw 200 dup(0)
    temp2 dw 200 dup(0)
    
data ends

stack segment
    mystack db 100 dup(?)
stack ends

myprog segment
    main proc far
        assume cs: myprog, ds: data, ss: stack
        mov ax, data
        mov ds, ax
        lea sp, mystack+100
        
        ;a
        lea si, array
        mov bx, x
        call calx; return ans in ax
        push ax
        push di
        mov di, ax; ans in di
        mov ah, 1
        int 21h
        pop di
        pop ax       
        
        ;b
        lea si, array
        lea di, roots
        mov ax, -10
        mov bx, 10
        call findroots
        
        push ax
        push di
        mov di, ax; ans in di
        mov ah, 1
        int 21h
        pop di
        pop ax 
        
        mov cx, [di]  
        add di, 2
loop133: mov ax, [di]
        add di, 2
        loop loop133
        
        ;c
        lea si, array1
        lea di, array2
        lea bx, sum_res
        call sum_poly
        
        push ax
        push di
        mov di, ax; ans in di
        mov ah, 1
        int 21h
        pop di
        pop ax 
        
        lea bx, sum_res
        mov cx, [bx]  
        add bx, 2
        inc cx
 loop144: mov ax, [bx]
        add bx, 2
        loop loop144
        
        ;d
        lea si, array1
        lea di, array2
        lea bx, mul_res
        call mul_poly
        
        push ax
        push di
        mov di, ax; ans in di
        mov ah, 1
        int 21h
        pop di
        pop ax 
        
        lea bx, mul_res
        mov cx, [bx]  
        add bx, 2
        inc cx
 loop145: mov ax, [bx]
        add bx, 2
        loop loop145
       
       
         ; si as array1, di as array2, bx as q, dx as r
         ;e
         lea di, array1
         lea si, array2
         lea bx, q_res
         lea dx, r_res
         call div_poly
         
         push ax
         push di
         mov di, ax; ans in di
         mov ah, 1
         int 21h
         pop di
         pop ax
         
         lea bx, q_res
         mov cx, [bx]
         inc cx  
         add bx, 2
loop134: mov ax, [bx]
         add bx, 2
         loop loop134
         
         
         lea bx, r_res
         mov cx, [bx]
         inc cx  
         add bx, 2
loop135: mov ax, [bx]
         add bx, 2
         loop loop135
        
          
         
        
        hlt
        
    main endp
    
    calx proc near;inputs: si as array, bx as x; output: ans in ax
        push cx
        push dx 
        push si
        mov cx, [si]
        add si, 2
        xor dx, dx
        xor ax, ax
 loop1: add ax, [si]
        add si, 2
        imul bx
        loop loop1
        add ax, [si]
        pop si
        pop dx
        pop cx
        
        ret     
    calx endp
    
findroots proc near;inputs: si as array, di as roots, baze:[ax,bx]; output: return roots in roots
         
 loop2: push bx
        mov bx, ax
        push ax
        call calx
        cmp ax, 0
        jne out1
        push di
        add [di], 1
        push bp;
        mov bp, [di]
        add di, bp
        add di, bp
        pop bp
        mov [di], bx
        pop di
  out1: pop ax
        add ax, 1
        pop bx
        cmp ax, bx      
        jle loop2
        
        ret
findroots endp

sum_poly proc near;si as array1, di as array2, bx as ans        
        push ax
        push cx
        mov ax, [si]
        cmp ax, [di]
        jne out20
        mov [bx], ax
        mov cx, ax
        inc cx
        add si,2
        add di,2
        add bx,2
loop10: mov ax, [si]
        add ax, [di]
        mov [bx], ax
        add si,2
        add di,2
        add bx,2
        loop loop10
        
        pop cx
        pop ax
        ret
        
 out20: jl out21
        mov [bx], ax
        add si,2 
        add bx,2
loop11: mov cx, [si]
        mov [bx], cx
        add si, 2
        add bx, 2
        dec ax
        cmp ax, [di]
        jne loop11
        mov cx, [di]
        inc cx
        add di,2
loop12: mov ax, [si]
        add ax, [di]
        mov [bx], ax
        add si,2
        add di,2
        add bx,2
        loop loop12 
        pop cx
        pop ax
        ret
        
        
 out21: mov ax, [di]
        mov [bx], ax
        add di,2 
        add bx,2
loop13: mov cx, [di]
        mov [bx], cx
        add di, 2
        add bx, 2
        dec ax
        cmp ax, [si]
        jne loop13
        mov cx, [si]
        inc cx
        add si,2
loop14: mov ax, [di]
        add ax, [si]
        mov [bx], ax
        add si,2
        add di,2
        add bx,2
        loop loop14       
        pop cx
        pop ax
        ret
        
sum_poly endp        
          
mul_poly proc near;si as array1, di as array2, bx as result
        push cx
        push bp
        push dx
        push ax
        push si
        push di
        push bx
        mov cx, [si]
        add cx, [di]
        ;dec cx
        mov [bx], cx
        add bx, 2
        mov cx, [si]
        inc cx
        add si, 2
        mov bp, [di]
        inc bp
        add di, 2        
        xor ax, ax;as i          
loop31: cmp ax, cx 
        jge out30 
        xor dx, dx; as j
loop32: cmp dx, bp
        jge out31
        push si
        push di
        push bx
        push ax
        push dx
        add si, ax
        add si, ax
        add di, dx
        add di, dx
        add bx, ax
        add bx, ax
        add bx, dx
        add bx, dx
        xor dx, dx
        mov ax, [si]
        imul [di] 
        
        
        push cx
        mov cx, [bx]
        pop cx
        
        
        
        add [bx], ax
        mov ax, [bx]
        pop dx
        pop ax
        pop bx
        pop di
        pop si
        inc dx
        jmp loop32
 out31: inc ax
        jmp loop31      
        
 out30: pop bx
        pop di
        pop si 
        pop ax
        pop dx
        pop bp
        pop cx
        ret
        
mul_poly endp
        

mosavi proc near;si ra dar di mirizad
        push si
        push di
        push cx
        push ax
        mov cx, [si]
        mov [di], cx
        add si,2
        add di,2
        inc cx
 loopa: mov ax, [si] 
        mov [di], ax 
        add si, 2
        add di, 2
        loop loopa
        
        pop ax
        pop cx
        pop di
        pop si
        
        ret
mosavi endp 

maxdeg proc near; si as array, return max deg in cx
        push si
        push ax
        mov cx, [si]
        inc cx
        add si, 2
 loopb: mov ax, [si]
        cmp ax ,0
        je outa
        dec cx
        pop ax
        pop si
        ret
  outa: add si,2
        loop loopb
        
        mov cx, -1
        pop ax
        pop si
        ret             
maxdeg endp
        
div_poly proc near; si as array1, di as array2, bx as q, dx as r
        push si
        push di
        push bx
        push cx
        push ax
        push bp
        
        push di
        mov di, dx
        call mosavi; r=arr1
        pop di
        
        mov si, dx
        
        push cx
        call maxdeg
        mov ax, cx; as n
        push si
        mov si, di
        call maxdeg
        mov bp, cx; as m
        pop si
        pop cx
        
        cmp ax, bp
        jge outc
        mov [bx], 0
        add bx, 2
        mov [bx], 0 
        pop bp
        pop ax
        pop cx
        pop bx
        pop di
        pop si
        ret
  outc: push ax
        sub ax, bp
        mov [bx], ax
        pop ax       
        
loop51: cmp ax ,bp
        jl outd
        push ax
        sub ax, bp
        push bx
        mov bx, 2
        mov takjomle[bx], ax
        pop bx
        pop ax
        
        push cx
        call maxdeg
        push si
        push bp
        mov bp, [si]
        sub bp, cx
        add si, bp
        add si, bp
        add si, 2
        pop bp
        push di
        add di, 2
        push ax
        mov ax, [si]
        xor dx, dx
        cwd
        idiv word ptr [di]
        mov takjomle, ax
        pop ax
        pop di
        pop si
        pop cx
        
        push si
        lea si, poly_tak
        call makepolyFtak
        push bx
        lea bx, temp
        push bx
        push cx
        mov cx, 20
 loop0: mov [bx], 0
        add bx, 1
        loop loop0    
        pop cx
        pop bx
        call mul_poly
        pop bx
        pop si
        
        push si
        lea si, temp 
        call manfi
        pop si 
        
        push si
        push di
        lea di, temp
        push bx
        lea bx, temp2
        call sum_poly
        pop bx
        pop di
        pop si
        
        push si
        push di
        mov di, si
        lea si,temp2
        call mosavi
        pop di
        pop si
        
        push cx
        call maxdeg
        mov ax, cx
        pop cx
        
        push si
        mov si, bx
        call addq 
        pop si
        
        jmp loop51
        
  outd: pop bp
        pop ax
        pop cx
        pop bx
        pop di
        pop si            
        ret
        
div_poly endp  

makepolyFtak proc near;si as arr
        push ax
        push cx
        push bx
        push si
        mov bx, 2
        mov ax, takjomle[bx]
        mov [si], ax
        mov cx, ax
        add si,2
        push bp
        mov bp,word ptr takjomle
        mov [si], bp
        pop bp
        add si, 2
        cmp cx, 0
        je outt
 loopf: mov [si], 0
        add si, 2
        loop loopf
        
  outt: pop si
        pop bx
        pop cx
        pop ax
        ret
    
makepolyFtak endp 

manfi proc near;si as arr
        push si
        push ax
        push cx
        push bp
        mov bp, -1
        mov cx, [si]
        add si, 2
        inc cx
 loopg: mov ax, [si]
        imul bp
        mov [si], ax
        add si, 2
        loop loopg
        
        pop bp
        pop cx
        pop ax
        pop si
        ret
        
manfi endp

addq proc near; si as q
        push ax
        push cx
        push si
        push bx
        push bp
               
        mov bx, 2
        mov ax,takjomle;zarib
        mov cx, takjomle[bx];
        mov bp, [si]
        add si, 2
        sub bp, cx
        add si, bp
        add si, bp
        mov [si], ax
        
        pop bp
        pop bx
        pop si
        pop cx
        pop ax
        ret
        
addq endp        
          
myprog ends   
    end main