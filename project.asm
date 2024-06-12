.model small
.stack 010Bh
.data
;FOR NAME
    name_input_msg db      " ENTER NAME:$"
                           
    blank_line_display db  "                     $"
    welcome_msg db         ": emocleW "
                            
    game_A_msg db     "KCUD 1   A EMAG "                
    game_B_msg db     "KCUD 2   A EMAG "
    top_score_msg db  " 00021 = EROCS POT"
                        
    nintendo_msg  db  "1984 NINTENDO CO-LTD.$" 
    name_input db ?
    instruct_head db   "SNOITCURTSNI"                         ;"INSTRUCTIONS"
    instruct_1    db   "EMIT A TA KCUD ENO :A EMAG"           ;"GAME A: ONE DUCK AT A TIME"
    instruct_2    db   "EMIT A TA KCUD ELPITLUM :B EMAG"      ;"GAME A: MULTIPLE DUCK AT A TIME"  
    instruct_3    db   "EROCS 001 = KCUD 1"                   ;"1 DUCK = 100 SCORE"     
    instruct_4    db   "3 = EMAG REP SDNUOR FO ON"                    ;"NO OF ROUNDS PER GAME = 3"
    instruct_5    db   "5 = DNUOR REP SYRT FO ON"                     ;"NO OF TRYS PER ROUND = 5"
round1_msg DB "round 1 $"
round2_msg DB "round 2 $"
round3_msg DB "round 3 $"
try_msg db "TRY: $"
hit_msg db "HIT: $"
score_msg db "SCORE: $"
bullets_msg db "BULLETS: $"
round_fly_count dw 5
round_fly_count_constant dw 5
hit_count dw 0
score_count dw 0
score_counter db 0
try_5 db "IIIII$"
try_4 db "IIII $"
try_3 db "III  $"
try_2 db "II   $"
try_1 db "I    $"
try_0 db "     $"
filename db "file.txt", 0
filehandler dw ?
buffer db 40 DUP(0)   ; Initialize buffer with zeros
;04 is red color
;0Bh is black color
;15 is white color
bullets dw 10

score2_count  dw 0
score2_counter dw 0
;--------------------------------------------------------------------------
;                          LOGO                                           |
;                                                                         |
;-------------------------------------------------------------------------
logo	DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 16
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 17
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 18
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 19
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 20
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 21
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 22
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 23
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 24
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 25
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,07h,07h     ; 26
        DB 07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h     ; 27
        DB 07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,06h     ; 28
        DB 06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 29
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 30
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 31
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 32
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 33
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 34
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 35
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 36
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 37
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 38
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 39
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 40
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 41
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h     ; 42
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 43
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 44
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 45
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 46
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 47
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 48
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 49
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 50
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 51
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 52
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 53
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 54
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 55
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 56
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 57
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 58
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 59
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 60
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 61
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 62
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 63
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 64
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 65
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ; 66
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 67
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 68
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ; 69
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 70
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 71
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 72
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 73
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 74
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 75
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 76
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 77
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 78
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 79
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 80
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 81
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ; 82
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 83
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 84
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 85
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 86
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 87
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 88
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 89
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 90
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 91
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 92
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 93
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 94
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ; 95
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 96
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 97
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 98
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 99
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;100
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;101
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;102
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;103
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;104
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;105
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;106
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;107
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;108
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,00h,00h,00h,00h,00h,00h,00h     ;109
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;110
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;111
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;112
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;113
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;114
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;115
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;116
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;117
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;118
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;119
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;120
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;121
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;122
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;123
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;124
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;125
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;126
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;127
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;128
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;129
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;130
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;131
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;132
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;133
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;134
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;135
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;136
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;137
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;138
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;139
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;140
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;141
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;142
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;143
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;144
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;145
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;146
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;147
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;148
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;149
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;150
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;151
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;152
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;153
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;154
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;155
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;156
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;157
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;158
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;159
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;160
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,06h,00h,00h,06h     ;161
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;162
        DB 00h,00h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h     ;163
        DB 07h,07h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,07h,07h,07h     ;164
        DB 07h,07h,07h,07h,06h,00h,00h,00h,00h,00h,00h,00h,00h,06h,06h     ;165
        DB 07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h     ;166
        DB 07h,07h,07h,07h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;167
        DB 07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h,07h     ;168
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,07h,07h,07h,07h,07h,07h     ;169
        DB 07h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;170
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;171
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;172
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;173
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;174
        DB 00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;175
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;176
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;177
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;178
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;179
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;180
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;181
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;182
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;183
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;184
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;185
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;186
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;187
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;188
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;189
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;190
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;191
        DB 00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;192
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;193
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;194
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;195
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;196
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;197
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;198
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;199
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;200
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h     ;201
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;202
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;203
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;204
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;205
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;206
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,0Eh     ;207
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;208
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;209
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;210
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;211
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;212
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;213
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;214
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;215
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;216
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;217
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,06h,0Eh     ;218
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;219
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;220
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;221
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;222
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;223
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;224
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;225
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;226
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;227
        DB 0Eh,0Eh,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;228
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;229
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;230
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;231
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;232
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;233
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;234
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;235
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;236
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;237
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;238
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;239
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;240
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;241
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;242
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;243
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;244
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;245
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;246
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;247
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;248
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;249
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;250
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;251
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;252
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;253
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;254
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;255
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;256
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;257
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;258
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;259
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;260
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;261
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;262
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;263
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;264
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;265
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;266
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;267
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;268
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;269
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;270
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;271
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;272
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh     ;273
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;274
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;275
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,00h,00h,00h     ;276
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;277
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;278
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;279
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;280
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;281
        DB 00h,00h,00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;282
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;283
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;284
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;285
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,00h,00h,00h,00h     ;286
        DB 00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;287
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;288
        DB 06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;289
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;290
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;291
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;292
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;293
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;294
        DB 00h,00h,00h,00h,00h,00h,00h,00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;295
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;296
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;297
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;298
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;299
        DB 00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;300
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;301
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;302
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;303
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;304
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;305
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;306
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;307
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;308
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;309
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;310
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;311
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;312
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,07h,0Eh,0Eh     ;313
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;314
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;315
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h     ;316
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;317
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;318
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;319
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;320
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;321
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;322
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;323
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;324
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;325
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;326
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;327
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;328
        DB 06h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;329
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;330
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;331
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;332
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;333
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;334
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;335
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;336
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;337
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;338
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;339
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;340
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;341
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;342
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;343
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;344
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;345
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;346
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;347
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;348
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;349
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;350
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;351
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;352
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,06h     ;353
        DB 06h,06h,06h,06h,06h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;354
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;355
        DB 06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;356
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;357
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;358
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;359
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;360
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;361
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;362
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;363
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;364
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;365
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;366
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;367
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;368
        DB 06h,00h,00h,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;369
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;370
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;371
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;372
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;373
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h     ;374
        DB 00h,00h,00h,00h,00h,00h,00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;375
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;376
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;377
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;378
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;379
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;380
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;381
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;382
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;383
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;384
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;385
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;386
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;387
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;388
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;389
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;390
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;391
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;392
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;393
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;394
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;395
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h     ;396
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;397
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;398
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;399
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;400
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,00h,00h,00h,00h,00h     ;401
        DB 06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;402
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;403
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;404
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;405
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;406
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;407
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;408
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;409
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;410
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;411
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;412
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;413
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;414
        DB 0Eh,06h,06h,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;415
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;416
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h     ;417
        DB 00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;418
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;419
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;420
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;421
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;422
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;423
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;424
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;425
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;426
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;427
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;428
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;429
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h     ;430
        DB 00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;431
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;432
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;433
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;434
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;435
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h     ;436
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;437
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;438
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;439
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;440
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;441
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;442
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;443
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh     ;444
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;445
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;446
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;447
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;448
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;449
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;450
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;451
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;452
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;453
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;454
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;455
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;456
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;457
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;458
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;459
        DB 07h,00h,00h,00h,00h,00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;460
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;461
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;462
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;463
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;464
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;465
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;466
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;467
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;468
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;469
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;470
        DB 06h,06h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;471
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;472
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,06h,00h,06h,07h,0Eh,0Eh,0Eh,0Eh     ;473
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;474
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;475
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,00h,00h,00h     ;476
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;477
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;478
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;479
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;480
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;481
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;482
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;483
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;484
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;485
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;486
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;487
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;488
        DB 06h,00h,00h,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;489
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;490
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;491
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;492
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;493
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;494
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;495
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;496
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;497
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;498
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;499
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;500
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;501
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh     ;502
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;503
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;504
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;505
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;506
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;507
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;508
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;509
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;510
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;511
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;512
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;513
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;514
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;515
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;516
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;517
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;518
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;519
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;520
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;521
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;522
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;523
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;524
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;525
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;526
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;527
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;528
        DB 06h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;529
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;530
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;531
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;532
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;533
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;534
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;535
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;536
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;537
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;538
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;539
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;540
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;541
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;542
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;543
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;544
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;545
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;546
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;547
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;548
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;549
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;550
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;551
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;552
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;553
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;554
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;555
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;556
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;557
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;558
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;559
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;560
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;561
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;562
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;563
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;564
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;565
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;566
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;567
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;568
        DB 06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;569
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;570
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;571
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;572
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;573
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;574
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;575
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;576
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;577
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh     ;578
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;579
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;580
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;581
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;582
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;583
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;584
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;585
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;586
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;587
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;588
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;589
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;590
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;591
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;592
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;593
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;594
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;595
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;596
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;597
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;598
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;599
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;600
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;601
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;602
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;603
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;604
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;605
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;606
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;607
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;608
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;609
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;610
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;611
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;612
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;613
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;614
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;615
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;616
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;617
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,07h,0Eh     ;618
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;619
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;620
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;621
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;622
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;623
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;624
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;625
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;626
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;627
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;628
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;629
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;630
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;631
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;632
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;633
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;634
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;635
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;636
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;637
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;638
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;639
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;640
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;641
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;642
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;643
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;644
        DB 0Eh,0Eh,0Eh,07h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;645
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;646
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh     ;647
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;648
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;649
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;650
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;651
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;652
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;653
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;654
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;655
        DB 06h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;656
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;657
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,06h     ;658
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;659
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;660
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;661
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;662
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h     ;663
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;664
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;665
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;666
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;667
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;668
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;669
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;670
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;671
        DB 00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;672
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;673
        DB 0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;674
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h     ;675
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h     ;676
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;677
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;678
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;679
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;680
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;681
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;682
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;683
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;684
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;685
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;686
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;687
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;688
        DB 06h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;689
        DB 0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;690
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;691
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;692
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h     ;693
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;694
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h     ;695
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;696
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;697
        DB 06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;698
        DB 00h,00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;699
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h     ;700
        DB 00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;701
        DB 06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;702
        DB 06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;703
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;704
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;705
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;706
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;707
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;708
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;709
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;710
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;711
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;712
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;713
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;714
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;715
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;716
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;717
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;718
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;719
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;720
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;721
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;722
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;723
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;724
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;725
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;726
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;727
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;728
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;729
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;730
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;731
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;732
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;733
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;734
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;735
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;736
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;737
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;738
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;739
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;740
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;741
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;742
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;743
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;744
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;745
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;746
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;747
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;748
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;749
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;750
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;751
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;752
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;753
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;754
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;755
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;756
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;757
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;758
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;759
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;760
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;761
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;762
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;763
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;764
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;765
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;766
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;767
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;768
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;769
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;770
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;771
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;772
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;773
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;774
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;775
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;776
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;777
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;778
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;779
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;780
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;781
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;782
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;783
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;784
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;785
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;786
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;787
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;788
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;789
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;790
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;791
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;792
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;793
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;794
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;795
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;796
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;797
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;798
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;799
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;800
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;801
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;802
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;803
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;804
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;805
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;806
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;807
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;808
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;809
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;810
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;811
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;812
        DB 00h,00h,00h,00h,00h,00h,00h,03h,03h,03h,03h,03h,03h,03h,03h     ;813
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;814
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;815
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;816
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;817
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;818
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;819
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;820
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;821
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;822
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;823
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;824
        DB 03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h,03h     ;825
        DB 03h,03h,03h,03h,03h,03h,03h,03h,00h,00h,00h,00h,03h,0Bh,0Bh     ;826
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;827
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;828
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;829
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;830
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;831
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;832
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;833
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;834
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;835
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;836
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;837
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;838
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,03h,00h,00h     ;839
        DB 00h,00h,03h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;840
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;841
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;842
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;843
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;844
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;845
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;846
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;847
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;848
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;849
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;850
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;851
        DB 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh     ;852
        DB 0Bh,0Bh,03h,00h,00h,00h,00h,00h,01h,01h,01h,01h,01h,01h,01h     ;853
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;854
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;855
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;856
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;857
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;858
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;859
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;860
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;861
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;862
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;863
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;864
        DB 01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h     ;865
        DB 01h,01h,01h,01h,01h,01h,01h,00h,00h,00h,00h,00h,00h,00h,00h     ;866
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;867
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;868
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;869
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;870
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;871
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;872
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;873
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;874
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;875
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;876
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;877
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;878
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;879
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;880
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;881
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;882
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;883
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;884
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;885
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;886
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;887
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;888
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;889
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;890
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;891
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;892
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;893
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;894
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;895
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;896
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;897
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;898
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;899
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;900
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;901
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;902
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;903
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;904
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;905
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;906
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;907
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;908
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;909
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;910
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;911
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;912
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;913
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;914
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;915
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;916
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;917
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;918
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;919
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;920
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;921
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;922
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;923
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;924
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;925
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;926
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;927
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;928
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;929
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;930
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;931
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;932
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;933
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;934
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;935
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;936
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;937
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;938
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;939
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;940
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;941
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;942
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;943
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;944
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;945
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;946
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;947
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;948
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;949
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;950
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;951
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;952
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;953
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;954
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;955
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;956
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;957
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;958
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;959
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;960
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;961
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;962
        DB 00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;963
        DB 06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h     ;964
        DB 00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,00h     ;965
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;966
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;967
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;968
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;969
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;970
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;971
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;972
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;973
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;974
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;975
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;976
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;977
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;978
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;979
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;980
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;981
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;982
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;983
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;984
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;985
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;986
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;987
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;988
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;989
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;990
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;991
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;992
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;993
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;994
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;995
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;996
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;997
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;998
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;999
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1000
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1001
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1002
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1003
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1004
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1005
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1006
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1007
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1008
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1009
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1010
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1011
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1012
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1013
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1014
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1015
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1016
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1017
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1018
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1019
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1020
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1021
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1022
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1023
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1024
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1025
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1026
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1027
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1028
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1029
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1030
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1031
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1032
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1033
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1034
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1035
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1036
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1037
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1038
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1039
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1040
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1041
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1042
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1043
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1044
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1045
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1046
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1047
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1048
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1049
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1050
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1051
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1052
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1053
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1054
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1055
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1056
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1057
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1058
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1059
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1060
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1061
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1062
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1063
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1064
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1065
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1066
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1067
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1068
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1069
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1070
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1071
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1072
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1073
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1074
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1075
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1076
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1077
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1078
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1079
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1080
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1081
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1082
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1083
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1084
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1085
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1086
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1087
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1088
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1089
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1090
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1091
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1092
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1093
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1094
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1095
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1096
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1097
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1098
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h     ;1099
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h     ;1100
        DB 00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,06h     ;1101
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1102
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,06h,06h,06h,06h,06h     ;1103
        DB 06h,00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1104
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1105
        DB 06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h     ;1106
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1107
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1108
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1109
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1110
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1111
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1112
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1113
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1114
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1115
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1116
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh     ;1117
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1118
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;1119
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1120
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1121
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1122
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1123
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1124
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1125
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1126
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1127
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1128
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1129
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1130
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1131
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1132
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1133
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1134
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1135
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1136
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1137
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1138
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1139
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1140
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1141
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1142
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1143
        DB 0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1144
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1145
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;1146
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1147
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1148
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1149
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1150
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1151
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1152
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1153
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1154
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1155
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1156
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh     ;1157
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1158
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;1159
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1160
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1161
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1162
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1163
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,06h,06h,06h,06h,06h,06h     ;1164
        DB 06h,06h,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1165
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1166
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1167
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1168
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1169
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1170
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1171
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1172
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1173
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1174
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1175
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1176
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1177
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1178
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1179
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1180
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1181
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1182
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1183
        DB 0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1184
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1185
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h     ;1186
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1187
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1188
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1189
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1190
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1191
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1192
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1193
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1194
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1195
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1196
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh     ;1197
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1198
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h     ;1199
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1200
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1201
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1202
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1203
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1204
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1205
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1206
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1207
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1208
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,07h,06h,00h,00h     ;1209
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1210
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1211
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1212
        DB 0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1213
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1214
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1215
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1216
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1217
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1218
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1219
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1220
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1221
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1222
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1223
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1224
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1225
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1226
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1227
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1228
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1229
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1230
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1231
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1232
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1233
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1234
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1235
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,06h,0Eh     ;1236
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1237
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1238
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1239
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1240
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1241
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1242
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1243
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1244
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1245
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1246
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1247
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1248
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1249
        DB 0Eh,0Eh,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1250
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1251
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1252
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1253
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1254
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1255
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1256
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1257
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1258
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1259
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1260
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1261
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1262
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1263
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1264
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1265
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1266
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1267
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1268
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1269
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1270
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1271
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1272
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1273
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1274
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1275
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,0Eh     ;1276
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1277
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1278
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1279
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1280
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1281
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1282
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1283
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1284
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1285
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1286
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1287
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1288
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1289
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1290
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1291
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1292
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1293
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1294
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1295
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1296
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1297
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1298
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1299
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1300
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1301
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1302
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1303
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1304
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1305
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1306
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1307
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1308
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1309
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1310
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1311
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1312
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1313
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1314
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1315
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1316
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1317
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1318
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1319
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1320
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1321
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1322
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1323
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1324
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1325
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1326
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1327
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1328
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1329
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1330
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1331
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1332
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1333
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1334
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1335
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1336
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1337
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1338
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1339
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h     ;1340
        DB 00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1341
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1342
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1343
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1344
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1345
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1346
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1347
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1348
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1349
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1350
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1351
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1352
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1353
        DB 00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1354
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1355
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1356
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1357
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1358
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1359
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1360
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1361
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1362
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1363
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1364
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1365
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1366
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh     ;1367
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1368
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1369
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1370
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1371
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1372
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1373
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1374
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1375
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1376
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1377
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1378
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1379
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1380
        DB 00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1381
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1382
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1383
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1384
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1385
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1386
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1387
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1388
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1389
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1390
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1391
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1392
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1393
        DB 06h,00h,00h,00h,00h,00h,07h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1394
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1395
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1396
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1397
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1398
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1399
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1400
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1401
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1402
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1403
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1404
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1405
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1406
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh     ;1407
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1408
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1409
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1410
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1411
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1412
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1413
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1414
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1415
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1416
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1417
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1418
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1419
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1420
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1421
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1422
        DB 06h,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1423
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1424
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1425
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1426
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1427
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1428
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1429
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1430
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1431
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1432
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1433
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1434
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1435
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh     ;1436
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1437
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1438
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1439
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1440
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1441
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1442
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1443
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1444
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1445
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1446
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1447
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1448
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1449
        DB 00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1450
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1451
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1452
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1453
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1454
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1455
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1456
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1457
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1458
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1459
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1460
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1461
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1462
        DB 00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1463
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1464
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1465
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1466
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1467
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1468
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1469
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1470
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1471
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1472
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1473
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1474
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1475
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh     ;1476
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1477
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1478
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1479
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1480
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1481
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1482
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1483
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1484
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1485
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1486
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1487
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1488
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1489
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1490
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1491
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1492
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1493
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1494
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1495
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1496
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1497
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1498
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1499
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1500
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1501
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1502
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1503
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1504
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1505
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1506
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1507
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1508
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1509
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1510
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1511
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1512
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1513
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1514
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1515
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1516
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1517
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1518
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1519
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1520
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1521
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1522
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1523
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1524
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1525
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1526
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1527
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1528
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1529
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1530
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1531
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1532
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1533
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1534
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1535
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1536
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1537
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1538
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1539
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1540
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,0Eh     ;1541
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1542
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1543
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1544
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1545
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1546
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1547
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1548
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1549
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1550
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1551
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh     ;1552
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1553
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1554
        DB 06h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1555
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1556
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1557
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1558
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1559
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1560
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1561
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1562
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1563
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1564
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1565
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1566
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1567
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1568
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1569
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1570
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1571
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1572
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1573
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1574
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1575
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1576
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1577
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1578
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1579
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1580
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Eh     ;1581
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1582
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1583
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1584
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1585
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1586
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1587
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1588
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh     ;1589
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1590
        DB 0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh     ;1591
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,0Eh     ;1592
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1593
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1594
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1595
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1596
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1597
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1598
        DB 0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1599
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1600
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1601
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1602
        DB 00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1603
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h     ;1604
        DB 00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;1605
        DB 00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1606
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1607
        DB 0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1608
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h     ;1609
        DB 00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h     ;1610
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1611
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h     ;1612
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1613
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1614
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1615
        DB 00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1616
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h     ;1617
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1618
        DB 0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh     ;1619
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1620
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,00h,00h,00h,00h,00h,00h,0Eh     ;1621
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1622
        DB 00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;1623
        DB 0Eh,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,0Eh     ;1624
        DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h     ;1625
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1626
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1627
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1628
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,06h     ;1629
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1630
        DB 06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;1631
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h     ;1632
        DB 00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1633
        DB 06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h     ;1634
        DB 00h,00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1635
        DB 06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h     ;1636
        DB 06h,06h,06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h     ;1637
        DB 00h,00h,00h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h,06h     ;1638
        DB 06h,06h,06h,06h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1639
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1640
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1641
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1642
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1643
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1644
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1645
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1646
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1647
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1648
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1649
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1650
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1651
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1652
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1653
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1654
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1655
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1656
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1657
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1658
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1659
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1660
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1661
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1662
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1663
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1664
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1665
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1666
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1667
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1668
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1669
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1670
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1671
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1672
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1673
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1674
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1675
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1676
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1677
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1678
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1679
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1680
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1681
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1682
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1683
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1684
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1685
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1686
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1687
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1688
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1689
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1690
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1691
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1692
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1693
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1694
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1695
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1696
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1697
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1698
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1699
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1700
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1701
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1702
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1703
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1704
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;1705
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0  	 1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15   
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0   	 2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0   	  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0   	  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		15
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		16
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		17
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		18
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		19
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		20
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		21
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		22
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		23
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		24
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  0		25
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  1
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  2
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  3
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  4
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  5
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  6
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  7
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  8
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ;  9
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 10
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 11
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 12
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 13
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 14
        DB 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h     ; 15 
		
 


duck db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh ;17+1+1
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,15d,00h,0Eh,15d,00h,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,00h,00h,0Eh,00h,00h,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,06h,06h,06h,06h,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,06h,06h,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,0Bh,0Bh,06h,06h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,06h,0Bh,0Bh,06h,06H,06h,0Bh,0Bh,0Bh,0Bh,0Bh ;19+1

duckflap db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh ;17+1+1
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,15d,00h,0Eh,15d,00h,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,00h,00h,0Eh,00h,00h,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,06h,06h,06h,06h,0Eh,0Eh,0Eh,00h,00h,00h,0Bh
    db 00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,06h,06h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h
    db 0Bh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,0Bh,0Bh,06h,06h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,06h,0Bh,0Bh,06h,06H,06h,0Bh,0Bh,0Bh,0Bh,0Bh ;19+1	

deadduck db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh ;17+1+1
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,00h,00h,0Eh,00h,00h,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Bh,0Bh,0Eh,0Bh,0Bh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Bh,0Bh,0Eh,0Bh,0Bh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Bh,0Bh,0Eh,0Bh,0Bh,0Eh,0Eh,00h,0Bh,0Bh,0Bh
    db 0Bh,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,06h,06h,06h,06h,0Eh,0Eh,0Eh,00h,00h,00h,0Bh
    db 00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h
    db 0Bh,00h,00h,00h,00h,0Eh,0Eh,0Eh,0Eh,06h,06h,0Eh,0Eh,0Eh,00h,00h,00h,00h,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
    db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,0Bh,0Bh,06h,06h,0Bh,0Bh,0Bh,0Bh,0Bh,0Bh
	db 0Bh,0Bh,0Bh,0Bh,0Bh,0Bh,06h,06h,06h,0Bh,0Bh,06h,06H,06h,0Bh,0Bh,0Bh,0Bh,0Bh ;19+1


shoot db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh ;12
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h 
	  db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh 
	  db 0Bh,0Bh,0Bh,0Bh,0Bh,00h,00h,0Bh,0Bh,0Bh,0Bh,0Bh   ;12	

		
xi dw 0
xf dw 0
yi dw 0
yf dw 0

x1i dw 0
x1f dw 0
y1i dw 0
y1f dw 0

counter dw 0

x2i dw 0
x2f dw 0
y2i dw 0
y2f dw 0

.code
	main proc
mov ax,@data
mov ds,ax
    ; setting video mode                                                                                  
    mov al, 13h            
    mov ah, 00h
    int 10H
call page1

mov ah,04ch
int 21h
main endp

page1 PROC
    ;After we are done calling clearing screen
        mov ah, 6     ; Scroll window function
        mov al, 0     ; Number of rows to scroll(0 means entire screen)
        mov ch, 0     ; Top-left corner row
        mov cl, 0     ; Top-left corner column
        mov dh, 24    ; Bottom-right corner row
        mov dl, 79    ; Bottom-right corner column
        mov bh, 0h  ; Attribute for blank area color
        int 10h       ; BIOS interrupt

    ;DISPLAYING IMAGE
       call draw_logo

    ;Asking for name input
      call asking_name

    ;TAKING INPUT TO MOVE TO NEXT PAGE
      page_movement_1:
        mov ah,1
        int 16h
        jz page_movement_1
        mov ah,0
        int 16h
        cmp ah,4Dh
        je call_page_2
        cmp al,0Dh
        je return_pg1
        jmp page_movement_1

    call_page_2:
      call page2
    return_pg1:
     ret 
page1 ENDP

;------------------------PAGE1 PROC END----------------------------

;------------------------PAGE2 PROC START-------------------------------
page2 PROC
;FOR Black BG
    ; calling clearing screen
        mov ah, 6     ; Scroll window function
        mov al, 0     ; Number of rows to scroll(0 means entire screen)
        mov ch, 0     ; Top-left corner row
        mov cl, 0     ; Top-left corner column
        mov dh, 24    ; Bottom-right corner row
        mov dl, 79    ; Bottom-right corner column
        mov bh, 0h  ; Attribute for blank area color
        int 10h       ; BIOS interrupt

; Display INSTRUCTIONS HEADING
    mov si, offset instruct_head
    mov cx, lengthof instruct_head
    ; Setting cursor position for INSTRUCTIONS HEADING
      mov ah, 2
      mov dh, 2      ; row
      mov dl, 14      ; column
      int 10h

    display_instruct_heading:
        mov al, [si]
        mov bx, 0
        mov bl, 52   ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_heading


; Display INSTRUCTION 1
    mov si, offset instruct_1
    mov cx, lengthof instruct_1
    ; Setting cursor position for INSTRUCTION 1
      mov ah, 2
      mov dh, 5      ; row
      mov dl, 5      ; column
      int 10h

    display_instruct_1:
        mov al, [si]
        mov bx, 0
        mov bl, 6    ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_1

; Display INSTRUCTION 2
    mov si, offset instruct_2
    mov cx, lengthof instruct_2
    ; Setting cursor position for INSTRUCTION 2
      mov ah, 2
      mov dh, 7      ; row
      mov dl, 5      ; column
      int 10h

    display_instruct_2:
        mov al, [si]
        mov bx, 0
        mov bl, 44    ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_2

; Display INSTRUCTION 3
    mov si, offset instruct_3
    mov cx, lengthof instruct_3
    ; Setting cursor position for INSTRUCTION 3
      mov ah, 2
      mov dh, 9      ; row
      mov dl, 5      ; column
      int 10h

    display_instruct_3:
        mov al, [si]
        mov bx, 0
        mov bl, 48    ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_3
        
; Display INSTRUCTION 4
    mov si, offset instruct_4
    mov cx, lengthof instruct_4
    ; Setting cursor position for INSTRUCTION 4
      mov ah, 2
      mov dh, 11      ; row
      mov dl, 5      ; column
      int 10h

    display_instruct_4:
        mov al, [si]
        mov bx, 0
        mov bl, 41    ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_4

; Display INSTRUCTION 5
    mov si, offset instruct_5
    mov cx, lengthof instruct_5
    ; Setting cursor position for INSTRUCTION 5
      mov ah, 2
      mov dh, 13      ; row
      mov dl, 5      ; column
      int 10h

    display_instruct_5:
        mov al, [si]
        mov bx, 0
        mov bl, 40    ;Color
        mov ah, 09h
        int 10h
        inc si
        loop display_instruct_5
    ;MOVING BETWEEN PAGES
    page_movement_2:
      mov ah,1
      int 16h
      jz page_movement_2
      mov ah,0
      int 16h
      cmp ah,4Bh   ;left
      je prev_page_1
      cmp ah,4Dh   ;right
      je next_page_3
      cmp al,0Dh
      je return_pg2
      jmp page_movement_2
    prev_page_1:
      call page1
    next_page_3:
      call page3
    return_pg2:
      ret 
page2 ENDP
;------------------------PAGE2 PROC ENDS--------------------------------
;------------------------PAGE3 PROC START-------------------------------
page3 PROC
    ;After we are done calling clearing screen
    mov ah, 6     ; Scroll window function
    mov al, 0     ; Number of rows to scroll(0 means entire screen)
    mov ch, 0     ; Top-left corner row
    mov cl, 0     ; Top-left corner column
    mov dh, 24    ; Bottom-right corner row
    mov dl, 79    ; Bottom-right corner column
    mov bh, 0h  ; Attribute for blank area color
    int 10h       ; BIOS interrupt
   ;DISPLAYING IMAGE
     call draw_logo 


   ; Display WELCOME MSG
    mov si, offset welcome_msg
    mov cx, lengthof welcome_msg
    ; Setting cursor position for NAME DISPLAY
      mov ah, 2
      mov dh, 20      ; row
      mov dl, 10      ; column
      int 10h

    display_welcome:
        mov al, [si]
        mov bx, 0
        mov bl, 0Bh
        mov ah, 09h
        int 10h
        inc si
        loop display_welcome
   ; Setting cursor position for name_display
      mov ah, 2
      mov dh, 20      ; row
      mov dl, 20      ; column
      int 10h   

   ; Display NAME DISPLAY     
      mov dx, offset  name_input
      mov ah,09h
      int 21h

   ; Setting cursor position for GAME A MSG 
     mov ah, 2
    mov bh, 0
    mov dh, 22
    mov dl, 10
    int 10h

    mov si, offset game_A_msg
    mov cx, lengthof game_A_msg

    display_game_A:
        mov al, [si]
        mov bx, 0
        mov bl, 06h
        mov ah, 09h
        int 10h
        inc si
        loop display_game_A

   ; Setting cursor position for GAME B MSG
      mov ah, 2
      mov dh, 23     ; row
      mov dl, 10      ; column
      int 10h

    mov si, offset game_B_msg
    mov cx, lengthof game_B_msg

    display_game_B:
        mov al, [si]
        mov bx, 0
        mov bl, 0Eh
        mov ah, 09h
        int 10h
        inc si
        loop display_game_B
    
   ; Setting cursor position for TOP SCORE
      mov ah, 2
      mov dh, 24      ; row
      mov dl, 9     ; column
      int 10h

   ; Display TOP SCORE MSG
     mov si, offset top_score_msg
    mov cx, lengthof top_score_msg

    display_top_score:
        mov al, [si]
        mov bx, 0
        mov bl, 0Ah
        mov ah, 09h
        int 10h
        inc si
        loop display_top_score
    page_movement_3:
     mov si,0
      mov ah,1
      int 16h
      jz page_movement_3
      mov ah,0
      int 16h
      cmp ah,4Bh   ;left
      je prev_page_2
      cmp ah,4Dh   ;right
      je next_page_4
      cmp al,0Dh
      je return_pg3
      jmp page_movement_3
    prev_page_2:
mov bullets,10
mov round_fly_count, 5
mov round_fly_count_constant,5
mov hit_count,0
mov score_count, 0
mov score_counter,0
mov score2_count,0
mov score2_counter,0

      call page5
      call page3
    
    next_page_4:
mov bullets,10
mov round_fly_count, 5
mov round_fly_count_constant,5
mov hit_count,0
mov score_count, 0
mov score_counter,0
mov score2_count,0
mov score2_counter,0
      call page4
call page3
    return_pg3:
      ret             ; Return from page2
page3 ENDP
;------------------PAGE 3 END HERE-----------------------
;-----------------PAGE 4--------------------------------
page4 PROC
    ;After we are done calling clearing screen
    mov ah, 6     ; Scroll window function
    mov al, 0     ; Number of rows to scroll(0 means entire screen)
    mov ch, 0     ; Top-left corner row
    mov cl, 0     ; Top-left corner column
    mov dh, 24    ; Bottom-right corner row
    mov dl, 79    ; Bottom-right corner column
    mov bh, 0h  ; Attribute for blank area color
    int 10h       ; BIOS interrupt
  mov ax, 0
  int 33h
  call bg_page4
  ;THIS IS ROUND 1
   round1:
    ;FOR  BLACK BOX BEHIND ROUND 1
       call black_box
    ; Display ROUND DISPLAY  
        mov dx, offset round1_msg
        mov ah,09h
        int 21h
    call sky_screen

    ;MAKING 5 TRYS  FOR ROUND 1   
    round_1_loop:
        cmp round_fly_count,0
        je round2
        call display_duck 
        dec round_fly_count
        JMP round_1_loop
  ;THIS IS ROUND 2
   round2:
   ;AS LAST IS NOT BEING DISPLAY
   call hit 
   call try
   call score
    ;FIXING FLY COUNT  and HIT COUNT
       mov cx,0
       mov cx,round_fly_count_constant
       mov round_fly_count,cx
       mov hit_count,0
    ;FOR  BLACK BOX BEHIND ROUND 2
       call black_box
    ;Display ROUND DISPLAY  
        mov dx, offset round2_msg
        mov ah,09h
        int 21h
    call sky_screen
    ;MAKING 5 TRYS  FOR ROUND 2  
    round_2_loop:
        cmp round_fly_count,0
        je round3
        call display_duck 
        dec round_fly_count
        jmp round_2_loop 

    ;THIS IS ROUND 3
   round3:
   ;AS LAST IS NOT BEING DISPLAY
     call hit 
     call try
    call score
    ;FIXING FLY COUNT and HIT COUNT
      mov cx,0
      mov cx,round_fly_count_constant
      mov round_fly_count,cx
      mov hit_count,0
    ;FOR  BLACK BOX BEHIND ROUND 3
       call black_box
    ;Display ROUND DISPLAY  
        mov dx, offset round3_msg
        mov ah,09h
        int 21h
    call sky_screen
    ;MAKING 5 TRYS  FOR ROUND 3   
       round_3_loop:
         cmp round_fly_count,0
         je exit_pg3
         call display_duck 
         dec round_fly_count
         jmp round_3_loop
    exit_pg3:
   ;AS LAST IS NOT BEING DISPLAY
     call hit 
     call try
     call score
     call score_file
     ;call page3
     ret
page4 ENDP
;------------------------------------------------------------PAGE 5 ------------------------------------------
page5 PROC
    ;After we are done calling clearing screen
    mov ah, 6     ; Scroll window function
    mov al, 0     ; Number of rows to scroll(0 means entire screen)
    mov ch, 0     ; Top-left corner row
    mov cl, 0     ; Top-left corner column
    mov dh, 24    ; Bottom-right corner row
    mov dl, 79    ; Bottom-right corner column
    mov bh, 0h  ; Attribute for blank area color
    int 10h       ; BIOS interrupt

mov ax, 0
int 33h


call bg_page5
call display_duck2

;call page3
ret
page5 ENDP
;------------------------------------------------------------PAGE 5 ENDS--------------------------------------

;//////////////////////////////add delay/////////////////////////////
add_delay proc
        mov cx, 1H            ;High End
        mov dx, 0A120h        ;Low End
        mov ah, 86H            ;Wait function
        int 15H
ret

add_delay endp



;/////////////////////////////duck display//////////////////////////////////////
display_duck proc

mov yi, 100
mov yf, 120
mov xi, 150
mov xf, 169

mov counter,0
mov counter,500
;////////////////////////////////////////up///////////////////////////////////////////
up:

mov si, offset duck	;draw 
call draw_duck
call add_delay
mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press:
mov ah,1
int 16h
jnz pause
jmp continue

pause:
call play
jmp press 

continue:

mov ax,3
int 33h

cmp bl,1

je check_range
jmp time_delay_up

check_range:
mov cx,x1i
cmp cx,xi
jb time_delay_up  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_up   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_up  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_up   ;b

jmp killed_duck


time_delay_up:   
      call add_delay

call bg_page4
;WE HAVE TO ADD STICKS LOGIC HERE         -----------------------------TRY LOGIC--------------------------------
 call try
 call hit
 call score

dec yi
dec yf
dec xi
dec xf

cmp xf,75
jbe right
dec counter
jnz up	

jmp dec_try

;/////////////////////////right////////////////////////////
right:

mov si, offset duck	;draw 
call draw_duck
call add_delay

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press2:
mov ah,1
int 16h
jnz pause2
jmp continue2

pause2:
call play
jmp press2 

continue2:

mov ax,3
int 33h

cmp bl,1

je check_range_right
jmp time_delay_right

check_range_right:
mov cx,x1i
cmp cx,xi
jb time_delay_right  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_right   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_right  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_right   ;b

jmp killed_duck


time_delay_right:   
      call add_delay

call bg_page4
call try
call hit
call score

dec yi
dec yf
inc xi
inc xf

cmp xf, 85
je down
dec counter
jnz right

jmp dec_try


;///////////////////////////////////////down/////////////////////////////////////////////
down:

mov si, offset duck	;draw 
call draw_duck
call add_delay

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press3:
mov ah,1
int 16h
jnz pause3
jmp continue3

pause3:
call play
jmp press3 

continue3:

mov ax,3
int 33h

cmp bl,1

je check_range_down
jmp time_delay_down

check_range_down:
mov cx,x1i
cmp cx,xi
jb time_delay_down  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_down   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_down  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_down   ;b

jmp killed_duck


time_delay_down:   
      call add_delay

call bg_page4
call try
call hit
call score


inc yi
inc yf
inc xi
inc xf

cmp xf, 150
je left
dec counter
jnz down

jmp dec_try

;/////////////////////////////left///////////////////////////////////////
left:

mov si, offset duck	;draw 
call draw_duck
call add_delay

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press4:
mov ah,1
int 16h
jnz pause4
jmp continue4

pause4:
call play
jmp press4 

continue4:

mov ax,3
int 33h

cmp bl,1

je check_range_left
jmp time_delay_left

check_range_left:
mov cx,x1i
cmp cx,xi
jb time_delay_left  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_left   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_left  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_left   ;b

jmp killed_duck


time_delay_left:   
      call add_delay

call bg_page4
call try
call hit
call score

inc yi
inc yf
dec xi
dec xf

cmp xf,125
je up2
dec counter
jnz left


jmp dec_try

;////////////////up2/////////////////////////
up2:

mov si, offset duck	;draw 
call draw_duck
call add_delay

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press5:
mov ah,1
int 16h
jnz pause5
jmp continue5

pause5:
call play
jmp press5 

continue5:

mov ax,3
int 33h

cmp bl,1

je check_range_up2
jmp time_delay_up2

check_range_up2:
mov cx,x1i
cmp cx,xi
jb time_delay_up2  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_up2   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_up2  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_up2   ;b

jmp killed_duck


time_delay_up2:   
      call add_delay

call bg_page4
call try
call hit
call score

dec yi
dec yf
dec xi
dec xf

cmp xf, 100
je right2
dec counter
jnz up2

jmp dec_try

;//////////////////right2///////////////////////////////////////
right2:

mov si, offset duck	;draw 
call draw_duck
call add_delay

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press6:
mov ah,1
int 16h
jnz pause6
jmp continue6

pause6:
call play
jmp press6 

continue6:

mov ax,3
int 33h

cmp bl,1

je check_range_right2
jmp time_delay_right2

check_range_right2:
mov cx,x1i
cmp cx,xi
jb time_delay_right2  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_right2   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_right2 ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_right2  ;b

jmp killed_duck


time_delay_right2:   
      call add_delay

call bg_page4
call try
call hit
call score
dec yi
dec yf
inc xi
inc xf

cmp xf,180
je dec_try
dec counter
jnz right2

jmp dec_try


killed_duck:
mov si, offset deadduck	;draw 
inc hit_count
inc score_count
call draw
; Adding Time Delay (1 second i think)
       
        mov cx, 15H            ;High End
        mov dx, 0A120h        ;Low End
        mov ah, 86H            ;Wait function
        int 15H
;''''''''''''''''''''''''''''''HIT KI LOGIC YAHAN HAI''''''''''''''''''''''''''''''''''''''''''''''''''
dec_try:				
ret
display_duck endp


;//////////////////////////////draw shoot////////////
draw_shoot proc

mov ax,3
int 33h

mov x1i,cx
mov y1i,dx

add cx,12
add dx,12
mov x1f,cx
mov y1f,dx


    mov ah, 0Ch          ; Set up AH for plotting pixel
    mov dx, y1i           ; Initialize y-coordinate

y1:
    mov cx, x1i           ; Initialize x-coordinate

x1:
    mov al, [di]         ; Load pixel value from memory
    cmp al, 0Bh          ; Compare pixel value to 0Bh
    je skip_pixel        ; If equal, skip plotting this pixel
    int 10h              ; Plot pixel
skip_pixel:
    inc di               ; Move to next pixel
    inc cx               ; Move to next column
    cmp cx, x1f           ; Check if end of row reached
    jb x1                 

    inc dx               ; Move to next row
    cmp dx, y1f           ; Check if end of screen reached
    jb y1
ret
draw_shoot endp



draw proc
	mov ah,0ch
	mov dx, yi		; y coordinate initial( up down)
y:
	mov cx, xi		;x coordinate initial (left right)
x:
	mov al,[si]			; start array
	int 10h
	inc si				; increment full row  (x axis)
	inc cx
	cmp cx, xf		; x coordinate final( left right)
	jb x
	inc dx				; jump to next row
	cmp dx, yf		; y coordinate final( up down)
	jb y
ret
draw endp

					
draw_duck proc
    mov ah, 0ch
    mov dx, yi       ; y coordinate initial( up down)
y:
    mov cx, xi       ; x coordinate initial (left right)
x:
    mov al, [si]     ; start array
    int 10h
    inc si           ; increment full row  (x axis)
    inc cx
    cmp cx, xf       ; x coordinate final( left right)
    jb x

    ; Introduce a delay loop here
    mov cx, 300h        ; Adjust this value for desired delay
delay_loop:
    nop              ; No operation, just consumes CPU cycles
    loop delay_loop

    inc dx           ; jump to next row
    cmp dx, yf       ; y coordinate final( up down)
    jb y
ret
draw_duck endp

;-------------------bg_page4---------------------------------------------------
bg_page4 PROC
;FOR SKY BG
mov ah, 6
mov al, 0
mov bh, 0Bh     ;color
 mov ch, 0     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 15    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR  GRASS
mov ah, 6
mov al, 0
mov bh, 0Ah     ;color
 mov ch, 15     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 20    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR  MUD
mov ah, 6
mov al, 0
mov bh, 06h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 24    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR TRY BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 2     ; Top-left corner column
 mov dh, 23    ; Bottom-right corner row
 mov dl, 13    ; Bottom-right corner column
int 10h
; Setting cursor position for TRY MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 2     ; column
  int 10h
; Display TRY MESSAGE DISPLAY  
      mov dx, offset try_msg
      mov ah,09h
      int 21h

;FOR HIT BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 19     ; Top-left corner column
 mov dh, 23    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h
; Setting cursor position for HIT MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 20     ; column
  int 10h
; Display HIT MESSAGE DISPLAY  
      mov dx, offset hit_msg
      mov ah,09h
      int 21h

;FOR SCORE BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 01     ; Top-left corner row
 mov cl, 19     ; Top-left corner column
 mov dh, 03    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h
; Setting cursor position for SCORE MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  02      ; row
  mov dl, 20     ; column
  int 10h
; Display SCORE MESSAGE DISPLAY  
      mov dx, offset score_msg
      mov ah,09h
      int 21h

ret
bg_page4 ENDP
;------------------TRY ------------------------------------
try PROC
  ;yahan mei try ka laga du
  ;DISPLAY HIT STICKS
  cmp round_fly_count, 5
  je try_5_display
  cmp round_fly_count, 4
  je try_4_display
  cmp round_fly_count, 3
  je try_3_display
  cmp round_fly_count, 2
  je try_2_display
  cmp round_fly_count, 1
  je try_1_display
  cmp round_fly_count,0
  je try_0_display
  jmp exit_round   ; If none of the above conditions matched, jump to flying duck part



;FOR 5 STICKS
try_5_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 5 
      mov dx, offset try_5
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 4 STICKS
try_4_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 4
      mov dx, offset try_4
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 3 STICKS
try_3_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 3 
      mov dx, offset try_3
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 2 STICKS
try_2_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 2 
      mov dx, offset try_2
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 1 STICKS
try_1_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 1 
      mov dx, offset try_1
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 0 STICKS
try_0_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 7     ; column
  int 10h
  ; Display ROUND try 0 
      mov dx, offset try_0
      mov ah,09h
      int 21h
	  jmp exit_round
  	  
exit_round:
ret
try ENDP
;--------------HIT PROC-------------------------------------------------------------
hit PROC
  ;yahan mei try ka laga du
  ;DISPLAY HIT STICKS
  cmp hit_count, 5
  je try_5_display
  cmp hit_count, 4
  je try_4_display
  cmp hit_count, 3
  je try_3_display
  cmp hit_count, 2
  je try_2_display
  cmp hit_count, 1
  je try_1_display
  jmp exit_round   ; If none of the above conditions matched, jump to flying duck part



;FOR 5 STICKS
try_5_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 24     ; column
  int 10h
  ; Display ROUND hit 5 
      mov dx, offset try_5
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 4 STICKS
try_4_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 24     ; column
  int 10h
  ; Display ROUND hit 4
      mov dx, offset try_4
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 3 STICKS
try_3_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 24     ; column
  int 10h
  ; Display ROUND hit 3 
      mov dx, offset try_3
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 2 STICKS
try_2_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 24     ; column
  int 10h
  ; Display ROUND hit 2 
      mov dx, offset try_2
      mov ah,09h
      int 21h
	  jmp exit_round

;FOR 1 STICKS
try_1_display:
  ; Setting cursor position for HIT DANDIAN
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 24     ; column
  int 10h
  ; Display ROUND hit 1 
      mov dx, offset try_1
      mov ah,09h
      int 21h
	  jmp exit_round

  	  
exit_round:
ret
hit ENDP
;--------------------------------------------SCORE PROC-----------------------------------------------
score PROC

 ; Setting cursor position for SCORE
  mov ah, 02h
  mov bh,00h
  mov dh,  02      ; row
  mov dl, 28     ; column
  int 10h
 mov dx, 0
	MOV AX, score_count
	MOV Bx, 10
	L1:
          mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc score_counter
		MOV AH, 0
		JMP L1

DISP:
	CMP score_counter, 0
	JE EXIT
	POP DX
	ADD DX, 48
	MOV AH, 02H
	INT 21H
	dec score_counter
	JMP DISP

EXIT:
ret
score ENDP
;--------------BLACK BOX------------------------------------------------------------
black_box PROC
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 6     ; Top-left corner row
 mov cl, 14     ; Top-left corner column
 mov dh, 10    ; Bottom-right corner row
 mov dl, 22    ; Bottom-right corner column
int 10h
; Setting cursor position for ROUND 1
box_position:
  mov ah, 02h
  mov bh,00h
  mov dh,  8      ; row
  mov dl, 15     ; column
  int 10h
ret
black_box ENDP

sky_screen PROC
;WE HAVE TO ADD TIME DELAY HERE 
time_delay:       
        mov cx, 20H            ;High End
        mov dx, 0A120h        ;Low End
        mov ah, 86H            ;Wait function
        int 15H
blue_box:
;NOW BLUE BOX WHICH COMES ON TOP OF ROUND 1 TO GIVE VANISHING EFFECT  
mov ah, 6
mov al, 0
mov bh, 0Bh     ;color
 mov ch, 6     ; Top-left corner row
 mov cl, 14     ; Top-left corner column
 mov dh, 10    ; Bottom-right corner row
 mov dl, 22    ; Bottom-right corner column
int 10h
ret
sky_screen ENDP
;---------------------------------------------------STORING SCORE----------------------------------------------
score_file PROC
    ; Open the file for writing
    mov ah, 3Dh
    mov al, 2               ; Open for writing (create if not exist)
    mov dx, offset filename
    int 21h
    mov filehandler, ax

    mov ax, score_count
    mov bx, 10

    ; Second digit (remainder)
    mov dx, 0
    div bx
    add dl, '0'             ; Convert digit to ASCII character
    mov [buffer+1], dl        ; Store the second digit in the buffer

    ; First digit (quotient)
    mov dx, ax              ; Get the quotient (first digit)
    add dl, '0'             ; Convert digit to ASCII character
    mov [buffer], dl      ; Store the first digit in the buffer

    ; Write the buffer to the file
    mov ah, 40h
    mov bx, filehandler
    mov dx, offset buffer
    mov cx, 2               ; Length of the data to write (two bytes for two ASCII characters)
    int 21h

    ; Close the file
    mov ah, 3Eh
    mov bx, filehandler
    int 21h
ret
score_file ENDP


;-----------------------DRAW LOGO PROC----------------------------
draw_logo PROC
      ; Drawing the logo
    mov si, offset logo
    mov yi, 30
    mov yf, 186
    mov xi, 30
    mov xf, 230
   mov ax,0
   mov bx,0
   mov cx,0
   mov dx,0
    mov ah, 0ch
    mov dx, yi   ; y coordinate initial (up down)
y_loop:
    mov cx, xi  ; x coordinate initial (left right)
x_loop:
    mov al, [si] ; start array
    int 10h
    inc si      ; increment full row (x axis)
    inc cx      ; increment x coordinate
    cmp cx, xf  ; x coordinate final (left right)
    jb x_loop   ; loop while less than final x coordinate
    inc dx      ; jump to next row
    cmp dx, yf  ; y coordinate final (up down)
    jb y_loop   ; loop while less than final y coordinate
    ret
draw_logo ENDP

;-------------------------NAME PROC----------------------------------
asking_name PROC
    ; Setting cursor position
    mov ah, 02h
    mov bh, 00h     ; page number
    mov dh, 21      ; row
    mov dl, 10      ; column
    int 10h
    
    ; Displaying NAME_MSG
         
     mov dx, offset name_input_msg
     mov ah,09h
     int 21h    

    ; Emptying AX register
    mov ax, 0
    mov si, OFFSET name_input

    ; Taking name input
name_input_loop:
    mov ah, 01h       ; DOS function to read a character from standard input
    int 21h           ; Call interrupt 21h to read a character
    cmp al, 0Dh       ; Compare with carriage return (Enter key)
    je exit_print      ; If Enter key is pressed, jump to exit
    mov [si], al      ; Store the entered character in memory
    inc si            ; Move to the next memory location
    jmp name_input_loop ; Continue looping for more input
    

exit_print:
    mov byte ptr [si], '$'  ; Store dollar sign ('$') at the end of the string
    mov si,0

    ; Opening the file for writing
    mov ah, 3DH         ; Service to open a file
    mov al, 1           ; Open for writing
    mov dx, offset filename ; Load file name
    int 21h             ; Call DOS interrupt
    jc open_error       ; Jump if carry flag is set (error)
    mov filehandler, ax ; Store file handler
    jmp write_to_file

open_error:
    mov ah, 09h         ; Display error message
    mov dx, offset open_error_msg
    int 21h             ; Call DOS interrupt

    ; Display error code
    mov ah, 09h         ; Display error code
    mov dx, offset error_code_msg
    int 21h             ; Call DOS interrupt

    jmp exit_program    ; Jump to exit program

write_to_file:
    ; Write the variable value (20) into the file
    mov ah, 40H         ; Service to write to a file
    mov bx, filehandler ; Load file handler
    mov cx, 5           ; Number of characters to write (word variable)
    mov dx, offset name_input ; Load offset of the variable
    int 21h             ; Call DOS interrupt
    jc write_error      ; Jump if carry flag is set (error)

    ; Close the file
    mov ah, 3Eh         ; Service to close a file
    mov bx, filehandler ; Load file handler
    int 21h             ; Call DOS interrupt
  write_error:
    mov ah, 09h         ; Display error message
    mov dx, offset write_error_msg
    int 21h             ; Call DOS interrupt
    jmp exit_program    ; Jump to exit program

open_error_msg db "Error opening file. Error code: $", 0
write_error_msg db "Error writing to file. Error code: $", 0
error_code_msg db "Error code: $", 0
exit_program :
    ret
asking_name ENDP

;////////////play//////////

play proc

press:
mov ah,1
int 16h
jz press

ret
play endp

;/////////////////////////////duck display2//////////////////////////////////////
display_duck2 proc


.WHILE (bullets!= 0)

mov yi, 100
mov yf, 120
mov xi, 150
mov xf, 169


mov y2i, 100
mov y2f, 120
mov x2i, 60
mov x2f, 79
mov counter,0
mov counter,500
;////////////////////////////////////////up///////////////////////////////////////////
up:
;/////////for first duck//////////////
mov si, offset duck	;draw 
call draw_duck


mov si, offset duck	;draw
call draw_duck2

mov si, offset duckflap
call draw_duck

mov si, offset duckflap
call draw_duck2

mov di, offset shoot	;draw 
call draw_shoot

press:
mov ah,1
int 16h
jnz pause
jmp continue

pause:
call play
jmp press 

continue:

mov ax,3
int 33h

cmp bl,1

je check_range
jmp time_delay_up

check_range:
dec bullets
cmp bullets,0
je dec_try
mov cx,x1i
cmp cx,xi
jb check_range2  ;ae

mov cx,x1f
cmp cx,xf
ja check_range2   ;b

mov cx,y1i
cmp cx,yi
jb check_range2  ;ae

mov cx,y1f
cmp cx,yf
ja check_range2   ;b

jmp killed_duck

;///////////check for duck2///////////
check_range2:
mov cx,x1i
cmp cx,x2i
jb time_delay_up  ;ae

mov cx,x1f
cmp cx,x2f
ja time_delay_up   ;b

mov cx,y1i
cmp cx,y2i
jb time_delay_up  ;ae

mov cx,y1f
cmp cx,y2f
ja time_delay_up   ;b

jmp killed_duck2


time_delay_up:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

dec yi
dec yf
dec xi
dec xf


dec y2i
dec y2f
inc x2i
inc x2f

cmp xf,75
jbe right
dec counter
jnz up	

jmp dec_try

;/////////////////////////right////////////////////////////
right:

mov si, offset duck	;draw 
call draw_duck

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press2:
mov ah,1
int 16h
jnz pause2
jmp continue2

pause2:
call play
jmp press2 

continue2:

mov ax,3
int 33h

cmp bl,1

je check_range_right
jmp time_delay_right

check_range_right:
dec bullets
cmp bullets,0
je dec_try
mov cx,x1i
cmp cx,xi
jb time_delay_right  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_right   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_right  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_right   ;b

jmp killed_duck


time_delay_right:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

dec yi
dec yf
inc xi
inc xf

cmp xf, 85
je down
dec counter
jnz right

jmp dec_try


;///////////////////////////////////////down/////////////////////////////////////////////
down:

mov si, offset duck	;draw 
call draw_duck

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press3:
mov ah,1
int 16h
jnz pause3
jmp continue3

pause3:
call play
jmp press3

continue3:

mov ax,3
int 33h

cmp bl,1

je check_range_down
jmp time_delay_down

check_range_down:
dec bullets
cmp bullets,0
je dec_try
mov cx,x1i
cmp cx,xi
jb time_delay_down  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_down   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_down  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_down   ;b

jmp killed_duck


time_delay_down:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

inc yi
inc yf
inc xi
inc xf

cmp xf, 150
je left
dec counter
jnz down

jmp dec_try

;/////////////////////////////left///////////////////////////////////////
left:

mov si, offset duck	;draw 
call draw_duck

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press4:
mov ah,1
int 16h
jnz pause4
jmp continue4

pause4:
call play
jmp press4 

continue4:

mov ax,3
int 33h

cmp bl,1

je check_range_left
jmp time_delay_left

check_range_left:
dec bullets
cmp bullets,0
je dec_try
mov cx,x1i
cmp cx,xi
jb time_delay_left  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_left   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_left  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_left   ;b

jmp killed_duck


time_delay_left:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

inc yi
inc yf
dec xi
dec xf

cmp xf,125
je up2
dec counter
jnz left


jmp dec_try

;////////////////up2/////////////////////////
up2:

mov si, offset duck	;draw 
call draw_duck

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press5:
mov ah,1
int 16h
jnz pause5
jmp continue5

pause5:
call play
jmp press5 

continue5:

mov ax,3
int 33h

cmp bl,1

je check_range_up2
jmp time_delay_up2

check_range_up2:
dec bullets
cmp bullets,0
je dec_try
mov cx,x1i
cmp cx,xi
jb time_delay_up2  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_up2   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_up2  ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_up2   ;b

jmp killed_duck


time_delay_up2:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

dec yi
dec yf
dec xi
dec xf

cmp xf, 100
je right2
dec counter
jnz up2

jmp dec_try

;//////////////////right2///////////////////////////////////////
right2:

mov si, offset duck	;draw 
call draw_duck

mov si, offset duckflap
call draw_duck

mov di, offset shoot	;draw 
call draw_shoot

press6:
mov ah,1
int 16h
jnz pause6
jmp continue6

pause6:
call play
jmp press6 

continue6:

mov ax,3
int 33h

cmp bl,1

je check_range_right2
jmp time_delay_right2

check_range_right2:
dec bullets
cmp bullets,0
je dec_try

mov cx,x1i
cmp cx,xi
jb time_delay_right2  ;ae

mov cx,x1f
cmp cx,xf
ja time_delay_right2   ;b

mov cx,y1i
cmp cx,yi
jb time_delay_right2 ;ae

mov cx,y1f
cmp cx,yf
ja time_delay_right2  ;b

jmp killed_duck


time_delay_right2:   
      call add_delay

call bg_page5
call score2
call hit2
call bullet

dec yi
dec yf
inc xi
inc xf

cmp xf,180
je dec_try
dec counter
jnz right2

jmp dec_try


killed_duck:
mov si, offset deadduck	;draw 
call draw
inc score2_count
jmp dec_try
killed_duck2:
mov si, offset deadduck	;draw
call draw_duck2
inc score2_count
dec_try:
; Adding Time Delay (1 second i think)
       
        mov cx, 15H            ;High End
        mov dx, 0A120h        ;Low End
        mov ah, 86H            ;Wait function
        int 15H

.ENDW				
ret
display_duck2 endp

draw_duck2 proc
    mov ah, 0ch
    mov dx, y2i       ; y coordinate initial(up down)
y:
    mov cx, x2i       ; x coordinate initial (left right)
x:
    mov al, [si]     ; start array
    int 10h
    inc si           ; increment full row  (x axis)
    inc cx
    cmp cx, x2f       ; x coordinate final(left right)
    jb x

    ; Introduce a delay loop here
    mov cx, 300h        ; Adjust this value for desired delay
delay_loop:
    nop              ; No operation, just consumes CPU cycles
    loop delay_loop

    inc dx           ; jump to next row
    cmp dx, y2f       ; y coordinate final( up down)
    jb y
ret
draw_duck2 endp
;-------------------bg_page5---------------------------------------------------
bg_page5 PROC
;FOR SKY BG
mov ah, 6
mov al, 0
mov bh, 0Bh     ;color
 mov ch, 0     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 15    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR  GRASS
mov ah, 6
mov al, 0
mov bh, 0Ah     ;color
 mov ch, 15     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 20    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR  MUD
mov ah, 6
mov al, 0
mov bh, 06h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 7     ; Top-left corner column
 mov dh, 24    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h

;FOR BULLETS BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 2     ; Top-left corner column
 mov dh, 23    ; Bottom-right corner row
 mov dl, 13    ; Bottom-right corner column
int 10h
; Setting cursor position for BULLETS MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 2     ; column
  int 10h
; Display BULLETS MESSAGE DISPLAY  
      mov dx, offset bullets_msg
      mov ah,09h
      int 21h
;FOR HIT BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 21     ; Top-left corner row
 mov cl, 19     ; Top-left corner column
 mov dh, 23    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h
; Setting cursor position for HIT MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 20     ; column
  int 10h
; Display HIT MESSAGE DISPLAY  
      mov dx, offset hit_msg
      mov ah,09h
      int 21h

;FOR SCORE BOX
mov ah, 6
mov al, 0
mov bh, 00h     ;color
 mov ch, 01     ; Top-left corner row
 mov cl, 19     ; Top-left corner column
 mov dh, 03    ; Bottom-right corner row
 mov dl, 31    ; Bottom-right corner column
int 10h
; Setting cursor position for SCORE MESSAGE
  mov ah, 02h
  mov bh,00h
  mov dh,  02      ; row
  mov dl, 20     ; column
  int 10h
; Display SCORE MESSAGE DISPLAY  
      mov dx, offset score_msg
      mov ah,09h
      int 21h

ret
bg_page5 ENDP
;--------------------------------------------SCORE PROC-----------------------------------------------
score2 PROC

 ; Setting cursor position for SCORE
  mov ah, 02h
  mov bh,00h
  mov dh,  02      ; row
  mov dl, 28     ; column
  int 10h
 mov dx, 0
	MOV AX, score2_count
	MOV Bx, 10
	L1:
          mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc score2_counter
		MOV AH, 0
		JMP L1

DISP:
	CMP score2_counter, 0
	JE EXIT
	POP DX
	ADD DX, 48
	MOV AH, 02H
	INT 21H
	dec score2_counter
	JMP DISP

EXIT:
ret
score2 ENDP

;--------------------------------------------HIT2 PROC-----------------------------------------------
hit2 PROC

 ; Setting cursor position for SCORE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 25     ; column
  int 10h
 mov dx, 0
	MOV AX, score2_count
	MOV Bx, 10
	L1:
          mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc score2_counter
		MOV AH, 0
		JMP L1

DISP:
	CMP score2_counter, 0
	JE EXIT
	POP DX
	ADD DX, 48
	MOV AH, 02H
	INT 21H
	dec score2_counter
	JMP DISP

EXIT:
ret
hit2 ENDP
;--------------------------------------------BULLETS PROC-----------------------------------------------
bullet PROC

 ; Setting cursor position for SCORE
  mov ah, 02h
  mov bh,00h
  mov dh,  22      ; row
  mov dl, 11     ; column
  int 10h
 mov dx, 0
	MOV AX, bullets
	MOV Bx, 10
	L1:
          mov dx, 0
		CMP Ax, 0
		JE DISP
		DIV Bx
		MOV cx, dx
		PUSH CX
		inc score2_counter
		MOV AH, 0
		JMP L1

DISP:
	CMP score2_counter, 0
	JE EXIT
	POP DX
	ADD DX, 48
	MOV AH, 02H
	INT 21H
	dec score2_counter
	JMP DISP

EXIT:
ret
bullet ENDP





end main
