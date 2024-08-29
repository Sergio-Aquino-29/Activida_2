;Gonzalez Aquino Sergio
;Actividad 2
;Microprocesadores
     ; Asume que los números hexadecimales están en los registros B y C
    ; Los números deben estar en el rango de 00h a 63h (0 a 99 decimal)

    LD A, B          ; Cargar el valor de B en A
    CALL HEX_TO_BCD  ; Convertir B (en A) a BCD
    LD B, A          ; Guardar el resultado BCD en B
    LD A, C          ; Cargar el valor de C en A
    CALL HEX_TO_BCD  ; Convertir C (en A) a BCD
    LD C, A          ; Guardar el resultado BCD en C

    ; Ahora B y C contienen los números en formato BCD
    LD D, 0          ; Inicializar el registro D (llevando)
    LD E, B          ; Mover B a E
    ADD HL, DE       ; Agregar DE (valor en E) a HL

    LD D, 0          ; Inicializar el registro D (llevando)
    LD E, C          ; Mover C a E
    ADD HL, DE       ; Agregar DE (valor en E) a HL

    ; Después de la suma en BCD, A contiene las unidades, H las centenas, L las decenas
    ; Así que debemos realizar la suma BCD

    DAA              ; Ajuste decimal después de la suma
    LD L, A          ; Almacenar unidades en L

    ; Ajustar las decenas
    LD A, H          ; Cargar centenas en A
    ADD A, 0x00      ; Ajustar A
    DAA              ; Ajuste decimal
    LD H, A          ; Almacenar centenas en H

    ; Ajustar las centenas
    LD A, L          ; Cargar decenas en A
    ADD A, 0x00      ; Ajustar A
    DAA              ; Ajuste decimal
    LD L, A          ; Almacenar decenas en L

    ; Resultado final está en H, L y A
    ; H contiene las centenas, L contiene las decenas, A contiene las unidades

HEX_TO_BCD:
    ; Aquí se implementa la conversión de hex a BCD
    ; El registro A contiene el número en hexadecimal
    ; Devuelve el valor en BCD en A

    LD L, A          ; Guardar el valor de A en L
    LD H, 0x00       ; Inicializar H en 0

    SRL A            ; Dividir A por 2 (A / 2)
    SRL A            ; Dividir A por 2 (A / 4)
    SRL A            ; Dividir A por 2 (A / 8)
    SRL A            ; Dividir A por 2 (A / 16)
    LD H, A          ; Guardar A en H
    LD A, L          ; Recuperar el valor original de A
    AND 0x0F         ; A = A mod 16 (nibble bajo)
    ADD A, H         ; Sumar el valor de H a A (A + H)
    RET              ; Retornar con el resultado BCD en A

