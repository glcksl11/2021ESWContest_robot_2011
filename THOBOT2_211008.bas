'���� �Լ��ʹ� �ٸ� ����. GOTO�� GOSUB�� ����

'******** 2�� ����κ� �ʱ� ���� ���α׷� ********

'�پ��� ����
DIM GRIP AS BYTE
DIM DOOR AS BYTE
DIM MODE AS BYTE

'���
DIM time AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE

'���̷� Ȯ��Ƚ��, ����, ���ܼ� �Ÿ�
DIM I AS BYTE
DIM LRS AS BYTE
DIM LRS_old AS BYTE
DIM FBS AS BYTE
DIM �Ѿ����˸� AS BYTE
DIM ���ܼ��Ÿ���  AS BYTE

'���� ����
DIM ������� AS BYTE
DIM ����Ƚ�� AS BYTE
DIM �԰���Ƚ�� AS BYTE
DIM ����COUNT AS BYTE

'���X
DIM J AS BYTE
DIM C AS BYTE
DIM ����ONOFF AS BYTE
DIM ����ӵ� AS BYTE
DIM �¿�ӵ� AS BYTE
DIM �¿�ӵ�2 AS BYTE
DIM �������� AS BYTE
DIM ����üũ AS BYTE
DIM ����յ� AS INTEGER
DIM �����¿� AS INTEGER
DIM ����Ȯ��Ƚ�� AS BYTE
DIM ���̷�ONOFF AS BYTE
DIM ����� AS BYTE
DIM S11  AS BYTE
DIM S16  AS BYTE
����üũ = 0
����Ȯ��Ƚ�� = 0

'���X
DIM NO_0 AS BYTE
DIM NO_1 AS BYTE
DIM NO_2 AS BYTE
DIM NO_3 AS BYTE
DIM NO_4 AS BYTE

'���X
DIM NUM AS BYTE

'���X
DIM BUTTON_NO AS INTEGER
DIM SOUND_PLAY AS BYTE
DIM TEMP_INTEGER AS INTEGER

'���̷� ����, ���ܼ� �Ÿ� ����
CONST �յڱ���AD��Ʈ = 0 '���⼾����Ʈ
CONST �¿����AD��Ʈ = 1 '���⼾����Ʈ
CONST SLOPE_MIN = 61	'�ڷγѾ������� ���Ⱚ ����
CONST SLOPE_MAX = 107	'�����γѾ������� ���Ⱚ ����
CONST COUNT_MAX = 3
CONST ����Ȯ�νð� = 20 '���� DELAY ms

CONST ���ܼ�AD��Ʈ  = 4 '�Ÿ�������Ʈ

'���� ����
CONST �Ӹ��̵��ӵ� = 10 '�Ӹ��̵� SPEED

����ONOFF = 1
������� = 0
����Ƚ�� = 2
�԰���Ƚ�� = 1
    '******************************************
    '****************************************************


'�Ҹ� - ����, ��, ����, �������� �б�
TEMPO 230
MUSIC "cdefg"
PRINT "OPEN MRSOUND.mrs !"
PRINT "VOLUME 50 !"
'PRINT "SND 9 9 !"
    '******************************************
    '****************************************************
    
    
'������ ����
'�����׷캰 ������ ���� ���� : PTP SETON
'��ü���� ������ ���� ���� : PTP ALLON
PTP SETON
PTP ALLON

'���� ���� : DIR
DIR G6A,1,0,0,1,0,0		'����0~5��
DIR G6D,0,1,1,0,1,1		'����18~23��
DIR G6B,1,1,1,1,1,1		'����6~11��
DIR G6C,0,0,0,0,1,0		'����12~17��

'�Ӹ� LED ON
'������ ��ȣ ���� : OUT ��Ʈ��ȣ, ��°�
OUT 52,0

'���� ON
GOSUB MOTOR_ON

'���� ���ǵ�
SPEED 5

'�������� ���簪 ���� : MOTORIN
S11 = MOTORIN(11)
S16 = MOTORIN(16)

'���� �ڼ�
SERVO 11, 100
SERVO 16, S16
SERVO 16, 100

'�ڼ�
GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�

'���� ���
GOSUB All_motor_mode3
    '******************************************
    '****************************************************

    
'���̷�
GOSUB ���̷�INIT
GOSUB ���̷�MID
GOSUB ���̷�ON
    '******************************************
    '****************************************************


GOTO MAIN
    '******************************************
    '****************************************************
    
    
'************************************************
' Infrared_Distance = 60 ' About 20cm
' Infrared_Distance = 50 ' About 25cm
' Infrared_Distance = 30 ' About 45cm
' Infrared_Distance = 20 ' About 65cm
' Infrared_Distance = 10 ' About 95cm
'************************************************


'������ ���� : ERX '�ʿ�x
RX_EXIT:
    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '******************************************
GOSUB_RX_EXIT:
    ERX 4800, A, GOSUB_RX_EXIT2

    GOTO GOSUB_RX_EXIT
    '******************************************
GOSUB_RX_EXIT2:
    RETURN
    '******************************************
    '****************************************************


'�Ҹ� : TEMPO / MUSIC
'GOTO, GOSUB, IF THEN / ELSE / ENDIF
������: '�ʿ�x
    TEMPO 220
    'MUSIC "O23EAB7EA>3#C"
    RETURN
    '******************************************
������:'�ʿ�x
    TEMPO 220
    'MUSIC "O38GD<BGD<BG"
    RETURN
    '******************************************
������:'�ʿ�x
    TEMPO 250
    'MUSIC "FFF"
    RETURN
    '******************************************
    
    
'���� & ���� �Ҹ����� + ����
���ʼҸ�����:
	SPEED 12
	MOVE G6A, 102,  76, 145,  93, 100,  
	MOVE G6D, 102,  76, 146,  93, 103,      
    MOVE G6B, 100,  30,  80,
    MOVE G6C, 190,  30,  80,
    WAIT
    
	PRINT "SOUND 6 !"
	GOSUB SOUND_PLAY_CHK '���� ���� Ȯ��
	
	GOTO MAIN
    '******************************************
���ʼҸ�����:
	SPEED 12
	MOVE G6A, 102,  76, 145,  93, 100,  
	MOVE G6D, 102,  76, 146,  93, 103,      
    MOVE G6B, 190,  30,  80,
    MOVE G6C, 100,  30,  80,
    WAIT
    
	PRINT "SOUND 8 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
    '******************************************
���ʼҸ�����:
	SPEED 12
	MOVE G6A, 102,  76, 145,  93, 100,  
	MOVE G6D, 102,  76, 146,  93, 103,      
    MOVE G6B, 10,  30,  80,
    MOVE G6C, 10,  30,  80,
    WAIT
    
	PRINT "SOUND 5 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
    '******************************************
���ʼҸ�����:
	SPEED 12
	MOVE G6A, 102,  76, 145,  93, 100,  
	MOVE G6D, 102,  76, 146,  93, 103,      
    MOVE G6B, 190,  30,  80,
    MOVE G6C, 190,  30,  80,
    WAIT
    
	PRINT "SOUND 7 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
    '******************************************
A�����Ҹ�����:
	PRINT "SOUND 1 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
B�����Ҹ�����:
	PRINT "SOUND 2 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
C�����Ҹ�����:
	PRINT "SOUND 3 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
D�����Ҹ�����:
	PRINT "SOUND 4 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
���������Ҹ�����:
	PRINT "SOUND 9 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
Ȯ�������Ҹ�����:
	PRINT "SOUND 10 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
    '******************************************	
    
    
'���� ���� Ȯ�� : ���� ���� ������� ��ٸ� '�̰� �����غ���@@@
SOUND_PLAY_CHK:
    DELAY 60
    SOUND_PLAY = IN(46) '46�� ������ ��Ʈ = ���� ��Ʈ
    IF SOUND_PLAY = 1 THEN GOTO SOUND_PLAY_CHK 'SOUND_PLAY = 1 : ���� ������ / SOUND_PLAY = 0 : ���� ������ �ƴ�
    DELAY 50

    RETURN
    '******************************************
    '****************************************************


'�������Ϳ� �ݿ��� ���̷� ���� ���� : GYROSET
���̷�ON:
    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0
    
    ���̷�ONOFF = 1	'���̷�ONOFF = 1 : ���̷�ON
    RETURN
    '******************************************
���̷�OFF:
    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0
    
    ���̷�ONOFF = 0 '���̷�ONOFF = 0 : ���̷�OFF
    RETURN
    '******************************************


'���̷� ���� ���� ���� : GYRODIR (1�϶� ���̷� �Է°� �����ϸ� ���� �������� �� ����)
'���̷� ���� ���� : GYROSENSE (�� Ŭ���� ���� �Է°��� ���� ���� ����)
���̷�INIT:
    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0
    
    RETURN
    '******************************************
���̷�MAX:
    GYROSENSE G6A,250,180,30,180,0
    GYROSENSE G6D,250,180,30,180,0
    
    RETURN
    '******************************************
���̷�MID:
    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0
    
    RETURN
    '******************************************
���̷�MIN:
    GYROSENSE G6A,200,100,30,100,0
    GYROSENSE G6D,200,100,30,100,0

    RETURN
    '******************************************

'���� ����
�յڱ�������:
    FOR i = 0 TO COUNT_MAX
        FBS = AD(�յڱ���AD��Ʈ)	'���� �յ�
        IF FBS > 250 OR FBS < 5 THEN RETURN
        IF FBS > SLOPE_MIN AND FBS < SLOPE_MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF FBS < SLOPE_MIN THEN
        GOSUB �����
    ELSEIF FBS > SLOPE_MAX THEN
        GOSUB �����
    ENDIF

    RETURN
    '******************************************
�����:
    FBS = AD(�յڱ���AD��Ʈ)
    'IF FBS < SLOPE_MIN THEN GOSUB �������Ͼ��
    IF FBS < SLOPE_MIN THEN
        'ETX  4800,41
        GOSUB �ڷ��Ͼ��
    ENDIF
    
    RETURN
    '******************************************
�����:
    FBS = AD(�յڱ���AD��Ʈ)
    'IF FBS > SLOPE_MAX THEN GOSUB �ڷ��Ͼ��
    IF FBS > SLOPE_MAX THEN
        'ETX  4800,40
        GOSUB �������Ͼ��
    ENDIF
    
    RETURN
    '******************************************
�¿��������:
    FOR i = 0 TO COUNT_MAX
        LRS = AD(�¿����AD��Ʈ)	'���� �¿�
        IF LRS > 250 OR LRS < 5 THEN RETURN
        IF LRS > SLOPE_MIN AND LRS < SLOPE_MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF LRS < SLOPE_MIN OR LRS > SLOPE_MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        
        GOSUB �⺻�ڼ�	
    ENDIF
    
    RETURN
    '******************************************
���ܼ��Ÿ���������:
    ���ܼ��Ÿ��� = AD(���ܼ�AD��Ʈ)
    
    IF ���ܼ��Ÿ��� > 50 THEN '50 = ���ܼ��Ÿ��� = 25cm
        'MUSIC "C"
        DELAY 2
    ENDIF

    RETURN
    '******************************************
    '****************************************************


'���� ON OFF : MOTOR / MOTOROFF
'�ð� ���� : DELAY ms
MOTOR_ON:
    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    ����ONOFF = 1 '����ONOFF = 1 : ���� ON
    GOSUB ������			
    RETURN
    '******************************************
MOTOR_OFF: '�ʿ�x
    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    
    ����ONOFF = 0	'����ONOFF = 0 : ���� OFF
    GOSUB MOTOR_GET	
    GOSUB ������	
    RETURN
    '******************************************
    
    
'���� ��ġ���ǵ�� : GETMOTORSET
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN
    '******************************************


'���� ��� ���� : MOTORMODE
All_motor_Reset:
    MOTORMODE G6A,1,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1,1
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1
    RETURN
    '******************************************
All_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2
    RETURN
    '******************************************
All_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3
    RETURN
    '******************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '******************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN
    '******************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '******************************************
Leg_motor_mode4: '���X
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '******************************************
Leg_motor_mode5: '���X
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '******************************************
Arm_motor_mode1: '���X
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1
    RETURN
    '******************************************
Arm_motor_mode2: '���X
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2
    RETURN
    '******************************************
Arm_motor_mode3: '���X
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3
    RETURN
    '******************************************
	
	
'�Ͼ��
�ڷ��Ͼ��:
    PTP SETON 		'�ʿ�x
    PTP ALLON		'�ʿ�x

    GOSUB ���̷�OFF'�ڷ� �Ͼ�� - ���̷�OFF

    GOSUB All_motor_Reset
	HIGHSPEED SETOFF
    SPEED 15
    GOSUB �⺻�ڼ�

    MOVE G6A,90, 130, ,  80, 110, 100
    MOVE G6D,90, 130, 120,  80, 110, 100
    MOVE G6B,150, 160,  10, 100, 100, 100
    MOVE G6C,150, 160,  10, 100, 100, 100
    WAIT

    MOVE G6B,170, 140,  10, 100, 100, 100
    MOVE G6C,170, 140,  10, 100, 100, 100
    WAIT

    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT
    
    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT

    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    
    GOSUB Leg_motor_mode3
    
	SPEED 10
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    
    GOSUB �⺻�ڼ�
    DELAY 200

    �Ѿ����˸� = 1 '�Ѿ��� �˸�
    GOSUB ���̷�ON'�ڷ� �Ͼ�� ��ħ - ���̷�ON

    RETURN
    '******************************************
�������Ͼ��:
    PTP SETON '�ʿ�x
    PTP ALLON '�ʿ�x

    GOSUB ���̷�OFF'������ �Ͼ�� - ���̷�OFF
    
    GOSUB All_motor_Reset
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,100, 15,  70, 140, 100,
    MOVE G6D,100, 15,  70, 140, 100,
    MOVE G6B,20,  140,  15
    MOVE G6C,20,  140,  15
    WAIT

    SPEED 12
    MOVE G6A,100, 136,  35, 80, 100,
    MOVE G6D,100, 136,  35, 80, 100,
    MOVE G6B,20,  30,  80
    MOVE G6C,20,  30,  80
    WAIT

    SPEED 12
    MOVE G6A,100, 165,  70, 30, 100,
    MOVE G6D,100, 165,  70, 30, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 165,  45, 90, 100,
    MOVE G6D,100, 165,  45, 90, 100,
    MOVE G6B,130,  50,  60
    MOVE G6C,130,  50,  60
    WAIT

    SPEED 6
    MOVE G6A,100, 145,  45, 130, 100,
    MOVE G6D,100, 145,  45, 130, 100,
    WAIT

    GOSUB All_motor_mode2
    SPEED 8
    GOSUB �⺻�ڼ�
    DELAY 200
    
    �Ѿ����˸� = 1 '�Ѿ��� �˸�
    GOSUB ���̷�ON'������ �Ͼ�� ��ħ - ���̷�ON
    
    RETURN
    '******************************************
    

' - �⺻�ڼ� / ����ȭ�ڼ�
	'���� ��� : MOTORMODE
	'���� �ӵ� �ִ�� : HIGHSPEED SETON
	'���� �ӵ� �⺻ : HIGHSPEED SETOFF
	'���� �ӵ� : SPEED (1~15)
	'���� ������ : MOVE 
	'���� ���� ������ : SERVO
	'��� ���� ������ �Ϸ���� ��� : WAIT
�����ʱ��ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    'mode = 0
    RETURN
    '******************************************
����ȭ�ڼ�:
    MOVE G6A, 98,  76, 145,  93, 100, 100
    MOVE G6D, 98,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    'mode = 0
    RETURN
    '******************************************
�⺻�ڼ�:
	MOVE G6A, 100,  76, 145,  93, 100,  
	MOVE G6D, 100,  76, 145,  93, 100,  
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
    'mode = 0
    RETURN
    '******************************************
�������ȭ�ڼ�:
	SPEED 15
    MOVE G6A,  98,  76, 145,  90, 100, 100
    MOVE G6D,  98,  76, 145,  90, 100, 100
    WAIT
    'mode = 0
    RETURN
    '******************************************
����⺻�ڼ�:
	SPEED 12
	MOVE G6A, 100,  76, 145,  90, 100, 100
    MOVE G6D, 100,  76, 145,  90, 100, 100
    WAIT    
    
    RETURN
    '******************************************
�����ڼ�: '���X
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 2 '�ʿ�X
    
    RETURN
    '******************************************
�����ڼ�: '�ʿ�X
    GOSUB ���̷�OFF'�ɱ� �ڼ� - ���̷�OFF
    MOVE G6A,100, 145,  28, 145, 100, 100
    MOVE G6D,100, 145,  28, 145, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 1'�ʿ�X
    
    RETURN
    '******************************************
	
	
'�Ӹ� �¿�
�Ӹ�����90��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,10
    
    GOTO MAIN
    '******************************************
�Ӹ�����60��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,40
    
    GOTO MAIN
    '******************************************
�Ӹ�����45��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,55
    
    GOTO MAIN
    '******************************************
�Ӹ�����30��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,70
    
    GOTO MAIN
    '******************************************
�Ӹ��¿��߾�:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,100
    
    GOTO MAIN
    '******************************************
�Ӹ�������30��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,130
    
    GOTO MAIN
    '******************************************
�Ӹ�������45��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,145
    
    GOTO MAIN	
    '******************************************
�Ӹ�������60��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,160
    
    GOTO MAIN
    '******************************************
�Ӹ�������90��: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,190
    
    GOTO MAIN
    '******************************************
�Ӹ���������: '���X
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,100	
    
    SPEED 5
    GOSUB �⺻�ڼ�
    
    GOTO RX_EXIT
    '******************************************
�Ӹ��¿�Ŀ����:
	SPEED �Ӹ��̵��ӵ�
    SERVO 11,115
    
    GOTO MAIN
    '******************************************


'�Ӹ� ����
�Ӹ������߾�:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,100
    WAIT
    'ETX  4800,0
	GOTO MAIN
    '******************************************
�Ӹ�����50��:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,70
    WAIT
    'ETX  4800,0
    GOTO MAIN '!!! ���� MAIN_2�� �Ǿ��־���. ������ ����
    '******************************************
�Ӹ�����60��:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,60
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
�Ӹ�����70��:
	SPEED �Ӹ��̵��ӵ�
	MOVE G6C,,,,,40
	WAIT
	GOTO MAIN
    '******************************************
�Ӹ�����80��:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,20
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
�Ӹ�����85��:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,15
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
�Ӹ�����Ŀ����:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,74
    WAIT
    'ETX  4800,0
	GOTO MAIN
    '******************************************
�Ӹ�70: '�Ʒ� �Ӹ� �κ� ���� ���X
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,70
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�68:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,68
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�66:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,66
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�64:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,64
    WAIT
    'ETX  4800,0
    '******************************************
�Ӹ�62:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,62
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�60:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,60
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�58:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,58
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�56:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,56
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�54:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,54
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�52:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,52
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�50:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,50
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�48:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,48
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�46:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,46
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�44:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,44
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�42:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,42
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�40:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,40
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�38:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,38
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�36:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,36
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�34:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,34
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�32:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,32
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�30:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,30
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�28:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,28
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�26:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,26
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�24:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,24
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�22:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,22
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************
�Ӹ�20:
    SPEED �Ӹ��̵��ӵ�
    MOVE G6C,,,,,20
    WAIT
    'ETX  4800,0
	GOTO ����Ʈ��
    '******************************************


'��
�Ⱦ�����:
	SPEED 7
	MOVE G6B,180
    MOVE G6C,180
        
    RETURN
    '******************************************
    

'�¿� ��
������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������3_LOOP:
        SPEED 15
        MOVE G6D,100,  73, 145,  93, 100, 100
        MOVE G6A,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6D,100,  84, 145,  78, 100, 100
        MOVE G6A,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6D,90,  90, 145,  78, 102, 100
        MOVE G6A,104,  71, 145,  105, 100, 100
        WAIT
        
        SPEED 7
        MOVE G6D,90,  80, 130, 102, 104
        MOVE G6A,105,  76, 146,  93,  100
        WAIT

    SPEED 12
    GOSUB �⺻�ڼ�

    GOTO MAIN
    '******************************************
��������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
��������3_LOOP:
        SPEED 15
        MOVE G6A,100,  73, 145,  93, 100, 100
        MOVE G6D,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6A,100,  84, 145,  78, 100, 100
        MOVE G6D,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6A,90,  90, 145,  78, 102, 100
        MOVE G6D,104,  71, 145,  105, 100, 100
        WAIT
        
        SPEED 7
        MOVE G6A,90,  80, 130, 102, 104
        MOVE G6D,105,  76, 146,  93,  100
        WAIT
	
    SPEED 12
    GOSUB �⺻�ڼ�
	
    GOTO MAIN
    '******************************************
������4:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������4_LOOP:
    IF ������� = 0 THEN
        ������� = 1
        SPEED 15
        MOVE G6D,100,  73, 145,  93, 100, 100
        MOVE G6A,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6D,100,  84, 145,  78, 100, 100
        MOVE G6A,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6D,90,  90, 145,  78, 102, 100
        MOVE G6A,104,  71, 145,  105, 100, 100
        WAIT
        
        SPEED 7
        MOVE G6D,90,  80, 130, 102, 104
        MOVE G6A,105,  76, 146,  93,  100
        WAIT
    ELSE
        ������� = 0
        SPEED 15
        MOVE G6D,100,  73, 145,  93, 100, 100
        MOVE G6A,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6D,100,  88, 145,  78, 100, 100
        MOVE G6A,100,  65, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6D,104,  86, 146,  80, 100, 100
        MOVE G6A,90,  58, 145,  110, 100, 100
        WAIT

        SPEED 7
        MOVE G6A,90,  85, 130, 98, 104
        MOVE G6D,105,  77, 146,  93,  100
        WAIT
    ENDIF

    SPEED 12
    GOSUB �⺻�ڼ�
	'ETX  4800,0

    GOTO MAIN
    '******************************************
��������4:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
��������4_LOOP:
    IF ������� = 0 THEN
        ������� = 1
        SPEED 15
        MOVE G6A,100,  73, 145,  93, 100, 100
        MOVE G6D,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6A,100,  84, 145,  78, 100, 100
        MOVE G6D,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6A,90,  90, 145,  78, 102, 100
        MOVE G6D,104,  71, 145,  105, 100, 100
        WAIT
        
        SPEED 7
        MOVE G6A,90,  80, 130, 102, 104
        MOVE G6D,105,  76, 146,  93,  100
        WAIT
    ELSE
        ������� = 0
        SPEED 15
        MOVE G6A,100,  73, 145,  93, 100, 100
        MOVE G6D,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6A,100,  88, 145,  78, 100, 100
        MOVE G6D,100,  65, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6A,104,  86, 146,  80, 100, 100
        MOVE G6D,90,  58, 145,  110, 100, 100
        WAIT

        SPEED 7
        MOVE G6D,90,  85, 130, 98, 104
        MOVE G6A,105,  77, 146,  93,  100
        WAIT
    ENDIF
    
    SPEED 12
    GOSUB �⺻�ڼ�
	'ETX  4800,0
	
    GOTO MAIN
    '******************************************
������10: '���X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�
    
    GOTO MAIN
    '******************************************
��������10: '���X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�

    GOTO MAIN
    '******************************************
������20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 4 '������ 2���� 1!!!
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 6 '������ 2���� 1!!!
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    
    SPEED 3 '������ 2���� 1!!!
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    RETURN
    '******************************************
��������20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 4 '������ 2���� 1!!!
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 6 '������ 2���� 1!!!
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 3 '������ 2���� 1!!!
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    RETURN
    '******************************************
������45:
	'ETX  4800,0
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    DELAY 10
������45_LOOP:
    SPEED 6
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    WAIT
    DELAY 10

    SPEED 6
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT
    DELAY 10

    SPEED 6
    GOSUB �⺻�ڼ�

    RETURN
    '******************************************
��������45:
	'ETX  4800,0
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    DELAY 10
��������45_LOOP:
    SPEED 6
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT
    DELAY 10

    SPEED 6
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT
    DELAY 10

    SPEED 6
    GOSUB �⺻�ڼ�
    
	RETURN
    '******************************************
������60: '���X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������60_LOOP:
    SPEED 15
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�

    GOTO MAIN
    '******************************************
��������60: '���X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
��������60_LOOP:
    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100
    WAIT

    SPEED 12
    GOSUB �⺻�ڼ�
    ' DELAY 50
    '    GOSUB �յڱ�������
    '    IF �Ѿ����˸� = 1 THEN
    '        �Ѿ����˸� = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,��������60_LOOP
    '    IF A_old = A THEN GOTO ��������60_LOOP

    GOTO MAIN
    '******************************************
	

'����
�����Ͼ��:
	GRIP = 1 '���� ��� ���� ��
	
	HIGHSPEED SETOFF
	SPEED 12
	
	'�ȹ�����' 
	MOVE G6B, 100,  87,  81,  ,  ,  
	MOVE G6C, 100,  87,  81,  ,  ,  
	WAIT

	'���̱�'
	MOVE G6A, 100, 146,  40, 139, 100,  
	MOVE G6D, 100, 146,  40, 139, 100,  
	MOVE G6B, 145,  90,  81,  ,  ,  
	MOVE G6C, 145,  90,  81,  ,  ,  
	WAIT
	
	'���� ����'
	MOVE G6A, 100, 146,  25, 154, 100,  
	MOVE G6D, 100, 146,  25, 154, 100,  
	WAIT
	
	'MOVE G6B, 145,  10,  61,  ,  ,  
	'MOVE G6C, 145,  10,  61,  ,  ,  
	'WAIT
	
	MOVE G6A, 100, 165,  25, 138, 100,  
	MOVE G6D, 100, 165,  23, 138, 100,  
	WAIT
	
	MOVE G6A,  79, 167,  25, 140, 117,  
	MOVE G6D,  79, 163,  21, 140, 117,  
	WAIT
	
	MOVE G6B, 145,  10,  61,  ,  ,  
	MOVE G6C, 145,  14,  61,  ,  ,  
	WAIT

	'�Ͼ��'
	MOVE G6A, 100,  76, 145,  90, 100,  
	MOVE G6D, 100,  76, 145,  90, 100,  
	MOVE G6B, 160,  10,  61,  ,  ,  
	MOVE G6C, 160,  10,  61,  ,  ,  
	WAIT
    
    GOTO MAIN
    '******************************************	
��������:
	GRIP = 0 '���� ��� ���� ���� ��
	
	HIGHSPEED SETOFF
	SPEED 12

	'���̱�'
	MOVE G6A, 100, 146,  40, 139, 100,  
	MOVE G6D, 100, 146,  40, 139, 100,   
	WAIT
	
	'���� ��������'
	MOVE G6A, 100, 146,  25, 154, 100,  
	MOVE G6D, 100, 146,  25, 154, 100,  
	WAIT
	
	MOVE G6B, 100,  87,  81,  ,  ,  
	MOVE G6C, 100,  87,  81,  ,  ,  
	WAIT

	'�Ͼ��'
	MOVE G6A, 98,  76, 145,  93, 100, 100
    MOVE G6D, 98,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    
    GOTO MAIN
    '******************************************	
    

'���� ��
���������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
���������3_LOOP:
    SPEED 15
    MOVE G6D,100,  73, 145,  93, 100, 100
    MOVE G6A,100,  79, 145,  93, 100, 100
    WAIT

    SPEED 6
    MOVE G6D,100,  84, 145,  78, 100, 100
    MOVE G6A,100,  68, 145,  108, 100, 100
    WAIT

    SPEED 9
    MOVE G6D,90,  90, 145,  78, 102, 100
    MOVE G6A,104,  71, 145,  105, 100, 100
    WAIT
    
    SPEED 7
    MOVE G6D,90,  80, 130, 102, 104
    MOVE G6A,105,  76, 146,  93,  100
    WAIT

    GOSUB ����⺻�ڼ�

    GOTO MAIN
    '******************************************
�����������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
�����������3_LOOP:
    SPEED 15
    MOVE G6A,100,  73, 145,  93, 100, 100
    MOVE G6D,100,  79, 145,  93, 100, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  84, 145,  78, 100, 100
    MOVE G6D,100,  68, 145,  108, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,90,  90, 145,  78, 102, 100
    MOVE G6D,104,  71, 145,  105, 100, 100
    WAIT
    
    SPEED 7
    MOVE G6A,90,  80, 130, 102, 104
    MOVE G6D,105,  76, 146,  93,  100
    WAIT
	
    GOSUB ����⺻�ڼ�
	'ETX  4800,0
	
    GOTO MAIN
    '******************************************
���������20: '���X
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  65, 105, 100
    MOVE G6D,95,  56, 145,  105, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  65, 105, 100
    MOVE G6D,93,  56, 145,  105, 105, 100
    WAIT
    
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    
    GOSUB Leg_motor_mode1
    
    GOTO RX_EXIT
    '******************************************
�����������20: '���X
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  105, 105, 100
    MOVE G6D,95,  96, 145,  65, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  105, 105, 100
    MOVE G6D,93,  96, 145,  65, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB Leg_motor_mode1
    
    GOTO RX_EXIT
    '******************************************
���������45: '���X
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  55, 105, 100
    MOVE G6D,95,  46, 145,  115, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  55, 105, 100
    MOVE G6D,93,  46, 145,  115, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    
    GOSUB Leg_motor_mode1
    
    GOTO RX_EXIT
    '******************************************
�����������45: '���X
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  115, 105, 100
    MOVE G6D,95,  106, 145,  55, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  115, 105, 100
    MOVE G6D,93,  106, 145,  55, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    
    GOSUB Leg_motor_mode1
    
    GOTO RX_EXIT
    '******************************************
���������60: '���X
    SPEED 15
    MOVE G6A,95,  116, 145,  45, 105, 100
    MOVE G6D,95,  36, 145,  125, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  45, 105, 100
    MOVE G6D,90,  36, 145,  125, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    
    GOTO RX_EXIT
    '******************************************
�����������60: '���X
    SPEED 15
    MOVE G6A,95,  36, 145,  125, 105, 100
    MOVE G6D,95,  116, 145,  45, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  125, 105, 100
    MOVE G6D,90,  116, 145,  45, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    
    GOTO RX_EXIT
    '******************************************
    

'������������(���� ����)
������������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF �������= 0 THEN
        ������� = 1
        MOVE G6A,95, 76, 147, 93, 101
        MOVE G6D,101, 76, 147, 93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT
        
        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT
        
        GOTO ������������_4
    ENDIF
    '******************************************
������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT
    
    GOSUB �յڱ�������'�Ѿ������� �Ǵ�
    IF �Ѿ����˸� = 1 THEN '�Ѿ��� �� ���¸� ��Ŵ��
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ERX 4800,A, ������������_4 '����ؼ� ������ �Ȱ�, �ٸ��� ���� �� MAIN����
    IF A <> A_old THEN
������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
		
		GOTO MAIN
	ENDIF
    '******************************************
������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������'�Ѿ������� �Ǵ�
    IF �Ѿ����˸� = 1 THEN '�Ѿ��� �� ���¸� ��Ŵ��
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ERX 4800,A, ������������_1 '����ؼ� ������ �Ȱ�, �ٸ��� ���� �� MAIN����
    IF A <> A_old THEN
������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		GOTO MAIN '���� ON A GOTO KEY1, ....!!!
	ENDIF

    GOTO ������������_1
    '******************************************
    

'Ƚ��������������
Ƚ��_������������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_4
    ENDIF
    '******************************************
Ƚ��_������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
Ƚ��_������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_2_stop
	
    ERX 4800,A, Ƚ��_������������_4
    IF A <> A_old THEN
Ƚ��_������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO MAIN
    ENDIF
    '******************************************
Ƚ��_������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
Ƚ��_������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ������� '�Ѿ������� �Ǵ�
    IF �Ѿ����˸� = 1 THEN '�Ѿ��� �� ���¸� ��Ŵ��
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_5_stop '����Ƚ�� �ʰ� �� ���� �� MAIN����
	
    ERX 4800,A, Ƚ��_������������_1 '����ؼ� ������ �Ȱ�, �ٸ��� ���� �� MAIN����
    IF A <> A_old THEN
Ƚ��_������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
		GOTO MAIN
    ENDIF

    GOTO Ƚ��_������������_1
    '******************************************


'������������
������������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ

    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO ������������_4
    ENDIF
    '******************************************
������������_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT
������������_2:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_2_stop
    
    ERX 4800,A, ������������_4
    IF A <> A_old THEN
������������_2_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO MAIN '���� RX_EXIT
    ENDIF
    '******************************************
������������_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT
������������_5:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    
    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_5_stop

    ERX 4800,A, ������������_1
    IF A <> A_old THEN 
������������_5_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO MAIN '���� RX_EXIT
    ENDIF

    GOTO ������������_1
    '******************************************
    

'Ƚ��_������������
Ƚ��_������������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_4
    ENDIF
    '******************************************
Ƚ��_������������_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT
Ƚ��_������������_2:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO MAIN
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_2_stop
    
    ERX 4800,A, Ƚ��_������������_4
    
    IF A <> A_old THEN
Ƚ��_������������_2_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO MAIN
    ENDIF
    '******************************************
Ƚ��_������������_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT
Ƚ��_������������_5:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    
    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO MAIN
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_5_stop

    ERX 4800,A, Ƚ��_������������_1
    
    IF A <> A_old THEN 
Ƚ��_������������_5_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        GOTO MAIN
    ENDIF

    GOTO Ƚ��_������������_1
    '******************************************


'�¿� ����
�����ʿ�����20: '��� X
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
�����ʿ�����_2:
    SPEED 12
    MOVE G6D, 95,  90, 125, 100, 104, 100
    MOVE G6A,105,  76, 146,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6D,95,  76, 145,  93, 102, 100
    MOVE G6A,95,  76, 145,  93, 102, 100
    WAIT
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT < �԰���Ƚ�� THEN GOTO �����ʿ�����_2

    SPEED 8
    GOSUB �⺻�ڼ�
    
    GOTO RX_EXIT
    '******************************************
�����ʿ�����70����: '��� X
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
�����ʿ�����70����_loop:
    DELAY  10

    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 145,  93, 107, 100
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6D, 102,  76, 145, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    ����COUNT = ����COUNT + 1
    IF ����COUNT < �԰���Ƚ�� THEN GOTO �����ʿ�����70����_loop
    
    SPEED 8
    GOSUB �⺻�ڼ�
    
    RETURN
    '******************************************
���ʿ�����70����: '��� X
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
���ʿ�����70����_loop:
    DELAY  10

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 145,  93, 107, 100	
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    '   ERX 4800, A ,���ʿ�����70����_loop	
    '    IF A = A_OLD THEN  GOTO ���ʿ�����70����_loop
    '���ʿ�����70����_stop:
    ����COUNT = ����COUNT + 1
    IF ����COUNT < �԰���Ƚ�� THEN GOTO �����ʿ�����_2

    SPEED 8
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '******************************************
�����ʿ�����70����_�ٴ�_Ŀ����:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
	
	'MOVE G6B, 186, 100,  81, 100, 100, 101
	'MOVE G6C, 189,  73,  55, 100,  98, 100
	'WAIT
	
	'MOVE G6B, 158, 103,  77, 100, 100, 101
	'MOVE G6C, 152,  94,  93, 100,  98, 100
	'WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
�����ʿ�����70����_loop_�ٴ�_Ŀ����:
    DELAY  10

	SPEED �Ӹ��̵��ӵ�
	WAIT

    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 145,  93, 107, 100
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6D, 102,  76, 145, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    ����COUNT = ����COUNT + 1
    IF ����COUNT < �԰���Ƚ�� THEN GOTO �����ʿ�����70����_loop
    
    SPEED 8
    GOSUB �⺻�ڼ�
    
    RETURN
    '******************************************
���ʿ�����70����_�ٴ�_Ŀ����:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
	
	'MOVE G6B, 186, 100,  81, 100, 100, 101
	'MOVE G6C, 189,  73,  55, 100,  98, 100
	'WAIT
	
	'MOVE G6B, 158, 103,  77, 100, 100, 101
	'MOVE G6C, 152,  94,  93, 100,  98, 100
	'WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
���ʿ�����70����_loop_�ٴ�_Ŀ����:
    DELAY  10

	SPEED �Ӹ��̵��ӵ�
	WAIT

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 145,  93, 107, 100	
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    ����COUNT = ����COUNT + 1
    IF ����COUNT < �԰���Ƚ�� THEN GOTO �����ʿ�����_2 '�԰��� 10ȸ ����

    SPEED 8
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '******************************************
	

'�� ����
������������������:
    DOOR = 0
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    ����Ƚ�� = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_4
    ENDIF
    '******************************************
������������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
������������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB ���ܼ��Ÿ��������� '���ܼ� �Ÿ��� ����
	IF ���ܼ��Ÿ��� > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        SPEED 7
        GOTO ������������������0
    ENDIF
	
	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_2_stop

    ERX 4800,A, ������������������_4
    IF A <> A_old THEN
������������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
������������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
������������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB ���ܼ��Ÿ���������
	IF ���ܼ��Ÿ��� > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        GOTO ������������������0
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_5_stop
    
    ERX 4800,A, ������������������_1
    IF A <> A_old THEN
������������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO ������������������_1
    '******************************************	
������������������0:
    ����COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_7
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_9
    ENDIF
    '******************************************	
������������������_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
������������������_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
	IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_8_stop
	
	ERX 4800,A, ������������������_9

    GOTO ������������������_9
������������������_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        GOTO ������������������
    '******************************************
������������������_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
������������������_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
	
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_0_stop
    
    ERX 4800,A, ������������������_7
    
    GOTO ������������������_7
������������������_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        GOTO ������������������
    '******************************************	
    
    
'�� ����
������������������:
    DOOR = 0
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    ����Ƚ�� = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_4
    ENDIF
    '******************************************
������������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
������������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB ���ܼ��Ÿ��������� '���ܼ� �Ÿ��� ����
	IF ���ܼ��Ÿ��� > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        SPEED 7
        GOTO ������������������0
    ENDIF
	
	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_2_stop

    ERX 4800,A, ������������������_4
    IF A <> A_old THEN
������������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
������������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
������������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB ���ܼ��Ÿ���������
	IF ���ܼ��Ÿ��� > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        GOTO ������������������0
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_5_stop
    
    ERX 4800,A, ������������������_1
    IF A <> A_old THEN
������������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO ������������������_1
    '******************************************	
������������������0:
    ����COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_7
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������������������_9
    ENDIF
    '******************************************	
������������������_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
������������������_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
	IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_8_stop
	
	ERX 4800,A, ������������������_9

    GOTO ������������������_9
������������������_8_stop:
	    MOVE G6D,95,  90, 125, 95, 104
	    MOVE G6A,104,  76, 145,  91,  102
	    MOVE G6B, 100
	    MOVE G6C,100
	    WAIT
	    
	    HIGHSPEED SETOFF
	    SPEED 15
	    GOSUB ����ȭ�ڼ�
	    
	    SPEED 5
	    GOSUB �⺻�ڼ�
	    
		DOOR  = 0
	    GOTO ������������������_2_stop
    '******************************************
������������������_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
������������������_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
	
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������������������_0_stop
    
    ERX 4800,A, ������������������_7
    
    GOTO ������������������_7
������������������_0_stop:
	    MOVE G6A,95,  90, 125, 95, 104
	    MOVE G6D,104,  76, 145,  91,  102
	    MOVE G6B, 100
	    MOVE G6C, 100
	    WAIT
	    
	    HIGHSPEED SETOFF
	    SPEED 15
	    GOSUB ����ȭ�ڼ�
	    
	    SPEED 5
	    GOSUB �⺻�ڼ�
	    
		DOOR  = 0
	    GOTO ������������������_5_stop
    '******************************************	
    
    
'�� ����2
������2������������:
    DOOR = 0
������2����Ŀ���Ҷ�:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    ����Ƚ�� = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������2������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������2������������_4
    ENDIF
    '******************************************
������2������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
������2������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	IF DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		SPEED 11 '!!!
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        SPEED 7
        GOTO ������2������������0
    ENDIF
	
	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������2������������_2_stop

    ERX 4800,A, ������2������������_4
    IF A <> A_old THEN
������2������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
������2����Ŀ����stop:
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
������2������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
������2������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB ���ܼ��Ÿ���������
	IF DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
        SPEED 11 '!!!
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        GOTO ������2������������0
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������2������������_5_stop
    
    ERX 4800,A, ������2������������_1
    IF A <> A_old THEN
������2������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO ������2������������_1
    '******************************************	
������2������������0:
    ����COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ������2������������_7
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ������2������������_9
    ENDIF
    '******************************************	
������2������������_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
������2������������_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
	IF ����COUNT > ����Ƚ�� THEN  GOTO ������2������������_8_stop
	
	ERX 4800,A, ������2������������_9

    GOTO ������2������������_9
������2������������_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 1
        GOTO ������2����Ŀ����stop
    '******************************************
������2������������_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
������2������������_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
	
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ������2������������_0_stop
    
    ERX 4800,A, ������2������������_7
    
    GOTO ������2������������_7
������2������������_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 1
        GOTO ������2����Ŀ����stop
	
    GOTO ������2������������_7
    '******************************************	


'����������������
����������������:
    DOOR = 0
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    ����Ƚ�� = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ����������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ����������������_4
    ENDIF
    '******************************************
����������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
����������������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB ���ܼ��Ÿ���������
	IF ���ܼ��Ÿ��� > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        SPEED 7
        GOTO ����������������0
    ENDIF

    ERX 4800,A, ����������������_4
    IF A <> A_old THEN
����������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
    ENDIF
    '******************************************
����������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
����������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB ���ܼ��Ÿ���������
	IF ���ܼ��Ÿ��� > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        ���ܼ��Ÿ���= 0
        DOOR  = 1
        ����Ƚ�� = 6
        
        SPEED 7
        GOTO ����������������0
    ENDIF
    
    ERX 4800,A, ����������������_1
    IF A <> A_old THEN
����������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
        A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO ����������������_1
    '******************************************
����������������0:
    ����COUNT = 0
    
	GOSUB All_motor_mode3
    SPEED 7
    
	IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO ����������������_7
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO ����������������_9
    ENDIF
    '******************************************
����������������_7:
	    MOVE G6A,95,  90, 125, 100, 104
	    MOVE G6D,104,  77, 147,  93,  102
����������������_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
	IF ����COUNT > ����Ƚ�� THEN  GOTO ����������������_8_stop '!!!
	
	ERX 4800,A, ����������������_9
    IF A <> A_old THEN
    	A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO ������������������_9
����������������_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
		
        GOTO ����������������
    '******************************************
����������������_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
����������������_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
	
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ����������������_0_stop
    
    ERX 4800,A, ����������������_7
    IF A <> A_old THEN
    	A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO ����������������_7
����������������_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		DOOR  = 0
		
        GOTO ����������������
    '******************************************
    
    
'�������
�������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 3

    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  90, 101
        MOVE G6D,101, 76, 147,  90, 98
        MOVE G6B,160
        MOVE G6C,160
        WAIT

        GOTO �������_1
    ELSE
        ������� = 0
        MOVE G6D, 100, 76, 147, 90, 105
        MOVE G6A,101, 76, 147, 90, 96
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT

        GOTO �������_4
    ENDIF
    '******************************************
�������_1:
    MOVE G6A,95,  90, 125, 97, 104
    MOVE G6D,104, 77, 147, 90, 102
�������_2:
    MOVE G6A,103,  73, 140, 100, 100
    MOVE G6D, 95,  85, 147, 82, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
		�Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO �������_2_stop
    
    ERX 4800,A, �������_4
    IF A <> A_old THEN
�������_2_stop:
        MOVE G6D,95,  90, 125, 93, 104
        MOVE G6A,104, 76, 145, 88, 102
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT
        
		HIGHSPEED SETOFF
		GOSUB �������ȭ�ڼ�
		GOSUB ����⺻�ڼ�
        'DELAY 400
        
        GOTO MAIN
    ENDIF
    '******************************************
�������_4:
    MOVE G6D, 95,  95, 120, 97, 104
    MOVE G6A,104,  77, 147, 90, 102
    WAIT
�������_5:
    MOVE G6D,103,  73, 140,  100,  100
    MOVE G6A, 95,  85, 147,  82, 102
    WAIT

    GOSUB �յڱ�������
    
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO �������_5_stop
    
    ERX 4800,A, �������_1
    IF A <> A_old THEN
�������_5_stop:
        MOVE G6A,95,  90, 125, 92, 104
        MOVE G6D,104, 76, 145, 88, 102
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT
        
        HIGHSPEED SETOFF
		GOSUB �������ȭ�ڼ�
		GOSUB ����⺻�ڼ�
        'DELAY 400
        
        GOTO MAIN
    ENDIF

	GOTO �������_1
    '******************************************
    
    
����������������:
    A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
    ����COUNT = 0 '���� Ƚ�� �ʱ�ȭ
    ����Ƚ�� = 1

    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 3

    IF ������� = 0 THEN
        ������� = 1
        
        MOVE G6A,95,  76, 145,  88, 101
        MOVE G6D,101,  76, 145,  88, 98
        WAIT

        GOTO ����������������_1
    ELSE
        ������� = 0
        
        MOVE G6D,95,  76, 145,  88, 101
        MOVE G6A,101,  76, 145,  88, 98
        WAIT

        GOTO ����������������_4
    ENDIF
    '******************************************
����������������_1:
    MOVE G6D,104,  76, 147,  88,  102
    MOVE G6A,95,  95, 120, 90, 104
    WAIT
����������������_2:
    MOVE G6A, 103,  79, 147,  84, 100
    MOVE G6D,95,   65, 147, 98,  102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
    
    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ����������������_2_stop
    
    ERX 4800,A, ����������������_4
    IF A <> A_old THEN
����������������_2_stop:
        MOVE G6D,95,  85, 130, 95, 104
        MOVE G6A,104,  77, 146,  88,  102
        WAIT

        HIGHSPEED SETOFF
        GOSUB �������ȭ�ڼ�
        GOSUB ����⺻�ڼ�

        GOTO MAIN
    ENDIF
    '******************************************
����������������_4:
    MOVE G6A,104,  76, 147,  88,  102
    MOVE G6D,95,  95, 120, 90, 104
    WAIT
����������������_5:
    MOVE G6D, 103,  79, 147,  84, 100
    MOVE G6A,95,   65, 147, 98,  102
    WAIT
    
    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF
	
	����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO ����������������_5_stop
    
    ERX 4800,A, ����������������_1
    IF A <> A_old THEN 
����������������_5_stop:
        MOVE G6A,95,  85, 130, 95, 104
        MOVE G6D,104,  77, 146,  88,  102
        WAIT

        HIGHSPEED SETOFF
        GOSUB �������ȭ�ڼ�
        GOSUB ����⺻�ڼ�

        GOTO MAIN
    ENDIF

    GOTO ����������������_1
    '******************************************
    

'�ʿ�X
Ƚ��_��������:
	����Ƚ�� = 1
	����COUNT = 0
	
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF ������� = 0 THEN
        ������� = 1
        
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_��������_1
    ELSE
        ������� = 0
        
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_��������_4
    ENDIF
    '******************************************
Ƚ��_��������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
Ƚ��_��������_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0

        GOTO RX_EXIT
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_��������_2_stop
	
    ERX 4800,A, Ƚ��_��������_4
    IF A <> A_old THEN
Ƚ��_��������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�

        RETURN
    ENDIF
    '******************************************
Ƚ��_��������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
Ƚ��_��������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ����˸� = 1 THEN
        �Ѿ����˸� = 0
        
        GOTO RX_EXIT
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_��������_5_stop
	
    ERX 4800,A, Ƚ��_��������_1
    IF A <> A_old THEN
Ƚ��_��������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        
        SPEED 5
        GOSUB �⺻�ڼ�
        
		RETURN
    ENDIF
    '******************************************
    

' ���X
NUM_1_9:
    IF NUM = 1 THEN
        GOTO KEY1
    ELSEIF NUM = 2 THEN
        GOTO KEY2
    ELSEIF NUM = 3 THEN
        GOTO KEY3
    ELSEIF NUM = 4 THEN
        GOTO KEY4
    ELSEIF NUM = 5 THEN
        GOTO KEY5
    ELSEIF NUM = 6 THEN
        GOTO KEY6
    ELSEIF NUM = 7 THEN
        GOTO KEY7
    ELSEIF NUM = 8 THEN
        GOTO KEY8
    ELSEIF NUM = 9 THEN
        GOTO KEY9
    ELSEIF NUM = 0 THEN
        GOTO KEY10
    ENDIF

    RETURN
    '******************************************
    

' ���X
NUM_TO_ARR:

    NO_4 =  BUTTON_NO / 10000
    TEMP_INTEGER = BUTTON_NO MOD 10000

    NO_3 =  TEMP_INTEGER / 1000
    TEMP_INTEGER = BUTTON_NO MOD 1000

    NO_2 =  TEMP_INTEGER / 100
    TEMP_INTEGER = BUTTON_NO MOD 100

    NO_1 =  TEMP_INTEGER / 10
    TEMP_INTEGER = BUTTON_NO MOD 10

    NO_0 =  TEMP_INTEGER

    RETURN
    '******************************************
    

' ���X
Number_Play: '  BUTTON_NO = ���ڴ���
    'GOSUB NUM_TO_ARR

    'PRINT "NPL "
    '*************

    NUM = NO_4
    GOSUB NUM_1_9

    '*************
    NUM = NO_3
    GOSUB NUM_1_9

    '*************
    NUM = NO_2
    GOSUB NUM_1_9
    '*************
    NUM = NO_1
    GOSUB NUM_1_9
    '*************
    NUM = NO_0
    GOSUB NUM_1_9
    'PRINT " !"

    'GOSUB SOUND_PLAY_CHK
    'PRINT "SND 16 !"
    'GOSUB SOUND_PLAY_CHK
    RETURN
    '******************************************


    '************************************************
    '		MAIN �ݺ� ��ƾ
    '************************************************
MAIN:
	'��� �ֱ� Ÿ�̸� �ʱ�ȭ
    J = 0 '���X
    time = 0
    '******************************************
    
MAIN_2:
    GOSUB �յڱ�������
    GOSUB �¿��������
    GOSUB ���ܼ��Ÿ���������
    
    '��� �ֱ� Ÿ�̸� ���� - ��������̿��� ���� ������ ��Ű��� ����ؼ� �������� �ʱ� ����
    time = time + 1
	
	IF time = 180 THEN
		A_old = 10000 '���� ��Ű� ����
		time = 0 '��� �ֱ� Ÿ�̸� �ʱ�ȭ
	ENDIF
	
	'���
    ERX 4800,A,MAIN_2
    
    '���� ��Ű��� ���� ��Ű��� �ٸ��� ����
    IF A <> A_old THEN
    	time = 0 '��� �ֱ� Ÿ�̸� �ʱ�ȭ
    	A_old = A '���� ��Ű��� ���� ��Ű� ����ȭ
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO MAIN_2
    '************************************************
    '		MAIN �󺧷� ����
    '************************************************
KEY1:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO MAIN
    '******************************************
KEY2:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
   
    GOTO ������������
    '******************************************
KEY3:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
	
    GOTO �����Ͼ��
    '******************************************
KEY4:
    GRIP = 1
    
	����Ƚ�� = 6
    GOSUB �������
    
    GOTO MAIN
    '******************************************
KEY5:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOSUB �⺻�ڼ�
	
    GOTO MAIN
    '******************************************
KEY6:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ������3
    '******************************************
KEY7:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ��������3
    '******************************************
KEY8:
    GOTO �Ӹ�����60��
    '******************************************
KEY9:
    GOTO �Ӹ������߾�
    '******************************************
KEY10: '0
    GOSUB ����⺻�ڼ�

    GOTO MAIN
    '******************************************
KEY11: ' ��
	GOTO ��������
    '******************************************
KEY12: ' ��
	GRIP = 1

	GOSUB ���ʼҸ�����

    GOTO MAIN
    '******************************************
KEY13: '��
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF

    GOTO ������4
    '******************************************
KEY14: ' ��
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ��������4
    '******************************************
KEY15: ' A '�·� 90��
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    GOSUB ������45
    GOSUB ������45
    GOSUB ������45
    GOSUB ������45
    ����Ƚ�� = 2
    GOSUB Ƚ��_������������

    GOTO MAIN
    '******************************************
KEY16: ' POWER
    'GOSUB Leg_motor_mode3 '!!!!!!!!!!!!!!!!!!!!!
    '
    'IF MODE = 0 THEN
    '    SPEED 10
    '    MOVE G6A,100, 140,  37, 145, 100, 100
    '    MOVE G6D,100, 140,  37, 145, 100, 100
    '    WAIT
    'ENDIF
    '
    'SPEED 4
    'GOSUB �����ڼ�	
    '
    'GOSUB MOTOR_GET
    'GOSUB MOTOR_OFF
	'
    'GOSUB GOSUB_RX_EXIT
	GOSUB �Ⱦ�����
        
    GOTO MAIN
    '******************************************
KEY16_1:
    IF ����ONOFF = 0  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    
    ERX 4800,A,KEY16_1
    'ETX  4800,A
    '**** RX DATA Number Sound ********
    BUTTON_NO = A
  
    
    IF  A = 16 THEN 	'�ٽ� �Ŀ���ư�� �����߸� ����
    	GOSUB MOTOR_ON
        SPEED 10
        MOVE G6A,100, 140,  37, 145, 100, 100
        MOVE G6D,100, 140,  37, 145, 100, 100
        WAIT
       
        GOSUB �⺻�ڼ�
        GOSUB ���̷�ON
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOSUB GOSUB_RX_EXIT
    GOTO KEY16_1

    GOTO RX_EXIT
    '******************************************
KEY17: ' C ' ��� 90��
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
	GOSUB ��������45
	GOSUB ��������45
	GOSUB ��������45
	GOSUB ��������45
	����Ƚ�� = 2
	GOSUB Ƚ��_������������

    GOTO MAIN
    '******************************************
KEY18: ' E
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ������2������������	
KEY19: ' P2
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
	GOSUB Ƚ��_������������

    GOTO MAIN
    '******************************************
KEY20: ' B	
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
	GOTO ������������
	
    GOTO RX_EXIT
    '******************************************
KEY21: ' ��
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ������10
    '******************************************
KEY22: ' *	
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ��������10
    '******************************************
KEY23: ' G
    GOSUB ������
    
    GOSUB All_motor_mode2
    '******************************************
KEY23_wait:
    ERX 4800,A,KEY23_wait	

    IF  A = 26 THEN
        GOSUB ������
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOTO KEY23_wait

    GOTO RX_EXIT
    '******************************************
KEY24: ' #
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO MAIN
    '******************************************
KEY25: ' P1
    GOSUB �Ӹ�����70��
    
    GOTO MAIN
    '******************************************
KEY26: ' ��
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    ����Ƚ�� = 1
    GOTO Ƚ��_������������
    '******************************************
KEY27: ' D
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    ����Ƚ�� = 1
    GOTO Ƚ��_������������
    
    GOTO MAIN
    '******************************************
KEY28: ' ��
    GOTO ���������3
    '******************************************
KEY29: ' ��
    GOSUB �Ӹ�����80��
    
    GOTO MAIN
    '******************************************
KEY30: ' ��
    GOTO �����������3
    '******************************************
KEY31: ' ��
    GOTO ����������������
    '******************************************
KEY32: ' F
	GRIP = 1
	
    MOVE G6B, 190,  20,  80
    MOVE G6C, 190,  20,  80
    WAIT
    
    GOTO �������
    '******************************************
KEY33: 
    GOTO �Ӹ�����60��
    '******************************************
KEY34: 
    GOTO �Ӹ�����70��
    '******************************************
KEY35:
    GOTO �Ӹ�����80��
    '******************************************
KEY36:
	GOSUB ���ܼ��Ÿ���������
	���ܼ��Ÿ��� = ���ܼ��Ÿ��� + 100
	ETX  4800,���ܼ��Ÿ���
	���ܼ��Ÿ��� = ���ܼ��Ÿ��� - 100
	
	GOTO MAIN
    '******************************************
KEY37: 
	GRIP = 1
	
    GOTO ���ʼҸ�����
    '******************************************
KEY38: 
	GRIP = 1
	
	GOTO ���ʼҸ�����
    '******************************************
KEY39: 
	GRIP = 1
	
	GOTO ���ʼҸ�����
    '******************************************
KEY40: 
	GRIP = 1
	
    GOTO ���ʼҸ�����
    '******************************************
KEY41: 
    GOTO A�����Ҹ�����
    '******************************************
KEY42: 
    GOTO B�����Ҹ�����
    '******************************************
KEY43: 
    GOTO C�����Ҹ�����
    '******************************************
KEY44: 
    GOTO D�����Ҹ�����
    '****************************************** 
KEY45:     
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOSUB ������45
    
    GOTO MAIN
    '******************************************
KEY46:     
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOSUB ��������45
    
    GOTO MAIN
    '******************************************
KEY47: 
    GOTO Ȯ�������Ҹ�����
    '******************************************
KEY48: 
    GOTO ���������Ҹ�����
    '******************************************
KEY49: 
	GRIP = 1
	
    GOTO ����������������
    '******************************************
KEY50: 
	GOTO ��������
    '******************************************
KEY51: '���X
	C = 1
	J = 0
����Ʈ��:'���X
	ERX 4800,LRS,����Ʈ��
	
	IF LRS = LRS_old THEN
		J = J + 1
	ENDIF
	
	IF J > 180 THEN
		LRS_old = 0
		J = 0
	ENDIF
	
	IF LRS <> LRS_old THEN
		LRS_old = LRS
		
		IF LRS >= 60 THEN
			C = C + 1
		ENDIF
		
		IF LRS >= 0 AND LRS < 60 THEN
			GOSUB Ƚ��_��������
		ENDIF
		
		IF LRS = 255 THEN
			ETX  4800,1
			DELAY 2000
			GOTO MAIN
		ENDIF
	ENDIF
	
	IF C >= 24 THEN
		ETX  4800,1
		DELAY 2000
    	GOTO MAIN
    ENDIF
    
    ON C GOTO �Ӹ�70, �Ӹ�68, �Ӹ�66, �Ӹ�64,�Ӹ�62, �Ӹ�60, �Ӹ�58, �Ӹ�56, �Ӹ�54,�Ӹ�52, �Ӹ�50, �Ӹ�48, �Ӹ�46, �Ӹ�44,�Ӹ�42, �Ӹ�40, �Ӹ�38, �Ӹ�36,�Ӹ�34, �Ӹ�32, �Ӹ�30, �Ӹ�28,�Ӹ�26, �Ӹ�24, �Ӹ�22, �Ӹ�20
	
	GOTO ����Ʈ��
	'******************************************
KEY52:
	GOTO �Ӹ�����50��
	'******************************************
KEY53:
	GOTO �Ӹ�����Ŀ����
	'******************************************
KEY54:
	GOTO �Ӹ��¿��߾�
	'******************************************
KEY55:
	GOTO �Ӹ������߾�
	'******************************************
KEY56:
	GOTO �Ӹ��¿��߾�
	'******************************************
KEY57:
	GOTO �Ӹ��¿�Ŀ����
	'******************************************
KEY58:
	GOSUB ������45
	
	GOTO MAIN
	'******************************************
KEY59:
	GOSUB ��������45
	
	GOTO MAIN
	'******************************************
KEY60:
	GOSUB ���ʿ�����70����_�ٴ�_Ŀ����
	
	GOTO MAIN
	'******************************************
KEY61:
	GOSUB �����ʿ�����70����_�ٴ�_Ŀ����
	
	GOTO MAIN
	'******************************************
KEY62: 
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB ����⺻�ڼ�
		GOSUB �⺻�ڼ�
    ENDIF
    
    GOTO ������������������
    '******************************************
KEY63:
	GOTO �Ӹ�����85��
	'******************************************
KEY64:
	GOSUB ������20
	
	GOTO MAIN
	'******************************************
KEY65:
	GOSUB ��������20
	
	GOTO MAIN
	'******************************************
KEY66:
	GOTO �Ӹ�����50��
	'******************************************