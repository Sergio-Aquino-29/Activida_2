;Gonzalez Aquino Sergio
;Actividad 2

    LD D, B       ; Vamos a guardar el valor de B en D
    LD E, C       ; Tambien guardaremos valor de C en E :)

    ; Primero convertiremos B (D) a BCD
    ; Dividimos el valor en D entre 10 para obtener las decenas y unidades
    LD H, 0       ; Inicializamos H (decenas) en 0
ConvBCD_B:
    CP D, 0Ah     ; Compara si D >= 10
    JR C, BCD_B    ; Si D < 10, salta a BCD_B
    DEC D         ; Decrementa D
    INC H         ; Incrementa H (decenas)
    JR ConvBCD_B  ; Repite el ciclo hasta que D < 10
BCD_B:
    LD L, D       ; Las unidades están en L

    ; Ahora convertiremos C (E) a BCD 
    LD D, E       ; Cargamos E en D para dividirlo
    LD E, 0       ; Inicializamos E (decenas) en 0
ConvBCD_C:
    CP D, 0Ah     ; Compara si D >= 10
    JR C, BCD_C    ; Si D < 10, salta a BCD_C
    DEC D         ; Decrementa D
    INC E         ; Incrementa E (decenas)
    JR ConvBCD_C  ; Repite el ciclo hasta que D < 10
BCD_C:
    ; E tiene las decenas y D las unidades de C

    ; Suma de  BCD
    LD A, H       ; Cargamos las decenas de B en A
    ADD A, E      ; Sumamos las decenas de C
    DAA           ; Ajusta A al formato BCD
    LD H, A       ; Guardamos el resultado en H (decenas)

    LD A, L       ; Cargamos las unidades de B en A
    ADD A, D      ; Sumamos las unidades de C
    DAA           ; Ajusta A al formato BCD
    LD L, A       ; Guardamos el resultado en L (unidades)

    ; --- Ajuste de centenas ---
    LD A, 0       ; Inicializamos A (centenas) en 0
    CP H, 0Ah     ; Compara si H >= 10
    JR C, Fin     ; Si H < 10, termina
    SUB 0Ah       ; Resta 10 de H
    INC A         ; Incrementa A (centenas)
    LD H, A       ;  se ajusta las centenas
Fin:
    NOP           ; Fin del programa
