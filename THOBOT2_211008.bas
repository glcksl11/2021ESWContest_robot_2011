'라벨은 함수와는 다른 개념. GOTO와 GOSUB을 위함

'******** 2족 보행로봇 초기 영점 프로그램 ********

'다양한 변수
DIM GRIP AS BYTE
DIM DOOR AS BYTE
DIM MODE AS BYTE

'통신
DIM time AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE

'자이로 확인횟수, 기울기, 적외선 거리
DIM I AS BYTE
DIM LRS AS BYTE
DIM LRS_old AS BYTE
DIM FBS AS BYTE
DIM 넘어짐알림 AS BYTE
DIM 적외선거리값  AS BYTE

'모터 변수
DIM 보행순서 AS BYTE
DIM 보행횟수 AS BYTE
DIM 게걸음횟수 AS BYTE
DIM 보행COUNT AS BYTE

'사용X
DIM J AS BYTE
DIM C AS BYTE
DIM 모터ONOFF AS BYTE
DIM 보행속도 AS BYTE
DIM 좌우속도 AS BYTE
DIM 좌우속도2 AS BYTE
DIM 현재전압 AS BYTE
DIM 반전체크 AS BYTE
DIM 기울기앞뒤 AS INTEGER
DIM 기울기좌우 AS INTEGER
DIM 기울기확인횟수 AS BYTE
DIM 자이로ONOFF AS BYTE
DIM 곡선방향 AS BYTE
DIM S11  AS BYTE
DIM S16  AS BYTE
반전체크 = 0
기울기확인횟수 = 0

'사용X
DIM NO_0 AS BYTE
DIM NO_1 AS BYTE
DIM NO_2 AS BYTE
DIM NO_3 AS BYTE
DIM NO_4 AS BYTE

'사용X
DIM NUM AS BYTE

'사용X
DIM BUTTON_NO AS INTEGER
DIM SOUND_PLAY AS BYTE
DIM TEMP_INTEGER AS INTEGER

'자이로 기울기, 적외선 거리 변수
CONST 앞뒤기울기AD포트 = 0 '기울기센서포트
CONST 좌우기울기AD포트 = 1 '기울기센서포트
CONST SLOPE_MIN = 61	'뒤로넘어졌을때 기울기값 범위
CONST SLOPE_MAX = 107	'앞으로넘어졌을때 기울기값 범위
CONST COUNT_MAX = 3
CONST 기울기확인시간 = 20 '기울기 DELAY ms

CONST 적외선AD포트  = 4 '거리센서포트

'모터 변수
CONST 머리이동속도 = 10 '머리이동 SPEED

모터ONOFF = 1
보행순서 = 0
보행횟수 = 2
게걸음횟수 = 1
    '******************************************
    '****************************************************


'소리 - 템포, 음, 볼륨, 음성파일 읽기
TEMPO 230
MUSIC "cdefg"
PRINT "OPEN MRSOUND.mrs !"
PRINT "VOLUME 50 !"
'PRINT "SND 9 9 !"
    '******************************************
    '****************************************************
    
    
'점대점 동작
'단위그룹별 점대점 동작 설정 : PTP SETON
'전체모터 점대점 동작 설정 : PTP ALLON
PTP SETON
PTP ALLON

'모터 방향 : DIR
DIR G6A,1,0,0,1,0,0		'모터0~5번
DIR G6D,0,1,1,0,1,1		'모터18~23번
DIR G6B,1,1,1,1,1,1		'모터6~11번
DIR G6C,0,0,0,0,1,0		'모터12~17번

'머리 LED ON
'디지털 신호 보냄 : OUT 포트번호, 출력값
OUT 52,0

'모터 ON
GOSUB MOTOR_ON

'모터 스피드
SPEED 5

'서보모터 현재값 읽음 : MOTORIN
S11 = MOTORIN(11)
S16 = MOTORIN(16)

'서보 자세
SERVO 11, 100
SERVO 16, S16
SERVO 16, 100

'자세
GOSUB 전원초기자세
GOSUB 기본자세

'모터 모드
GOSUB All_motor_mode3
    '******************************************
    '****************************************************

    
'자이로
GOSUB 자이로INIT
GOSUB 자이로MID
GOSUB 자이로ON
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


'데이터 수신 : ERX '필요x
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


'소리 : TEMPO / MUSIC
'GOTO, GOSUB, IF THEN / ELSE / ENDIF
시작음: '필요x
    TEMPO 220
    'MUSIC "O23EAB7EA>3#C"
    RETURN
    '******************************************
종료음:'필요x
    TEMPO 220
    'MUSIC "O38GD<BGD<BG"
    RETURN
    '******************************************
에러음:'필요x
    TEMPO 250
    'MUSIC "FFF"
    RETURN
    '******************************************
    
    
'방향 & 지역 소리내기 + 동작
동쪽소리내기:
	SPEED 12
	MOVE G6A, 102,  76, 145,  93, 100,  
	MOVE G6D, 102,  76, 146,  93, 103,      
    MOVE G6B, 100,  30,  80,
    MOVE G6C, 190,  30,  80,
    WAIT
    
	PRINT "SOUND 6 !"
	GOSUB SOUND_PLAY_CHK '사운드 가동 확인
	
	GOTO MAIN
    '******************************************
서쪽소리내기:
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
남쪽소리내기:
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
북쪽소리내기:
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
A지역소리내기:
	PRINT "SOUND 1 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
B지역소리내기:
	PRINT "SOUND 2 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
C지역소리내기:
	PRINT "SOUND 3 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
D지역소리내기:
	PRINT "SOUND 4 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
안전지역소리내기:
	PRINT "SOUND 9 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
	'******************************************
확진지역소리내기:
	PRINT "SOUND 10 !"
	GOSUB SOUND_PLAY_CHK
	
	GOTO MAIN
    '******************************************	
    
    
'사운드 가동 확인 : 사운드 가동 종료까지 기다림 '이거 실험해보자@@@
SOUND_PLAY_CHK:
    DELAY 60
    SOUND_PLAY = IN(46) '46번 디지털 포트 = 사운드 포트
    IF SOUND_PLAY = 1 THEN GOTO SOUND_PLAY_CHK 'SOUND_PLAY = 1 : 사운드 가동중 / SOUND_PLAY = 0 : 사운드 가동중 아님
    DELAY 50

    RETURN
    '******************************************
    '****************************************************


'서보모터에 반영할 자이로 센서 설정 : GYROSET
자이로ON:
    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0
    
    자이로ONOFF = 1	'자이로ONOFF = 1 : 자이로ON
    RETURN
    '******************************************
자이로OFF:
    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0
    
    자이로ONOFF = 0 '자이로ONOFF = 0 : 자이로OFF
    RETURN
    '******************************************


'자이로 동작 방향 설정 : GYRODIR (1일때 자이로 입력값 증가하면 현재 서보모터 값 증가)
'자이로 감도 설정 : GYROSENSE (값 클수록 센서 입력값에 대한 빠른 반응)
자이로INIT:
    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0
    
    RETURN
    '******************************************
자이로MAX:
    GYROSENSE G6A,250,180,30,180,0
    GYROSENSE G6D,250,180,30,180,0
    
    RETURN
    '******************************************
자이로MID:
    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0
    
    RETURN
    '******************************************
자이로MIN:
    GYROSENSE G6A,200,100,30,100,0
    GYROSENSE G6D,200,100,30,100,0

    RETURN
    '******************************************

'기울기 측정
앞뒤기울기측정:
    FOR i = 0 TO COUNT_MAX
        FBS = AD(앞뒤기울기AD포트)	'기울기 앞뒤
        IF FBS > 250 OR FBS < 5 THEN RETURN
        IF FBS > SLOPE_MIN AND FBS < SLOPE_MAX THEN RETURN
        DELAY 기울기확인시간
    NEXT i

    IF FBS < SLOPE_MIN THEN
        GOSUB 기울기앞
    ELSEIF FBS > SLOPE_MAX THEN
        GOSUB 기울기뒤
    ENDIF

    RETURN
    '******************************************
기울기앞:
    FBS = AD(앞뒤기울기AD포트)
    'IF FBS < SLOPE_MIN THEN GOSUB 앞으로일어나기
    IF FBS < SLOPE_MIN THEN
        'ETX  4800,41
        GOSUB 뒤로일어나기
    ENDIF
    
    RETURN
    '******************************************
기울기뒤:
    FBS = AD(앞뒤기울기AD포트)
    'IF FBS > SLOPE_MAX THEN GOSUB 뒤로일어나기
    IF FBS > SLOPE_MAX THEN
        'ETX  4800,40
        GOSUB 앞으로일어나기
    ENDIF
    
    RETURN
    '******************************************
좌우기울기측정:
    FOR i = 0 TO COUNT_MAX
        LRS = AD(좌우기울기AD포트)	'기울기 좌우
        IF LRS > 250 OR LRS < 5 THEN RETURN
        IF LRS > SLOPE_MIN AND LRS < SLOPE_MAX THEN RETURN
        DELAY 기울기확인시간
    NEXT i

    IF LRS < SLOPE_MIN OR LRS > SLOPE_MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        
        GOSUB 기본자세	
    ENDIF
    
    RETURN
    '******************************************
적외선거리센서측정:
    적외선거리값 = AD(적외선AD포트)
    
    IF 적외선거리값 > 50 THEN '50 = 적외선거리값 = 25cm
        'MUSIC "C"
        DELAY 2
    ENDIF

    RETURN
    '******************************************
    '****************************************************


'모터 ON OFF : MOTOR / MOTOROFF
'시간 지연 : DELAY ms
MOTOR_ON:
    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    모터ONOFF = 1 '모터ONOFF = 1 : 모터 ON
    GOSUB 시작음			
    RETURN
    '******************************************
MOTOR_OFF: '필요x
    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    
    모터ONOFF = 0	'모터ONOFF = 0 : 모터 OFF
    GOSUB MOTOR_GET	
    GOSUB 종료음	
    RETURN
    '******************************************
    
    
'모터 위치값피드백 : GETMOTORSET
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN
    '******************************************


'모터 모드 설정 : MOTORMODE
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
Leg_motor_mode4: '사용X
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '******************************************
Leg_motor_mode5: '사용X
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '******************************************
Arm_motor_mode1: '사용X
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1
    RETURN
    '******************************************
Arm_motor_mode2: '사용X
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2
    RETURN
    '******************************************
Arm_motor_mode3: '사용X
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3
    RETURN
    '******************************************
	
	
'일어나기
뒤로일어나기:
    PTP SETON 		'필요x
    PTP ALLON		'필요x

    GOSUB 자이로OFF'뒤로 일어나기 - 자이로OFF

    GOSUB All_motor_Reset
	HIGHSPEED SETOFF
    SPEED 15
    GOSUB 기본자세

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
    
    GOSUB 기본자세
    DELAY 200

    넘어짐알림 = 1 '넘어짐 알림
    GOSUB 자이로ON'뒤로 일어나기 마침 - 자이로ON

    RETURN
    '******************************************
앞으로일어나기:
    PTP SETON '필요x
    PTP ALLON '필요x

    GOSUB 자이로OFF'앞으로 일어나기 - 자이로OFF
    
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
    GOSUB 기본자세
    DELAY 200
    
    넘어짐알림 = 1 '넘어짐 알림
    GOSUB 자이로ON'앞으로 일어나기 마침 - 자이로ON
    
    RETURN
    '******************************************
    

' - 기본자세 / 안정화자세
	'모터 모드 : MOTORMODE
	'모터 속도 최대로 : HIGHSPEED SETON
	'모터 속도 기본 : HIGHSPEED SETOFF
	'모터 속도 : SPEED (1~15)
	'모터 움직임 : MOVE 
	'서보 모터 움직임 : SERVO
	'모든 모터 움직임 완료까지 대기 : WAIT
전원초기자세:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    'mode = 0
    RETURN
    '******************************************
안정화자세:
    MOVE G6A, 98,  76, 145,  93, 100, 100
    MOVE G6D, 98,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    'mode = 0
    RETURN
    '******************************************
기본자세:
	MOVE G6A, 100,  76, 145,  93, 100,  
	MOVE G6D, 100,  76, 145,  93, 100,  
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
    'mode = 0
    RETURN
    '******************************************
집고안정화자세:
	SPEED 15
    MOVE G6A,  98,  76, 145,  90, 100, 100
    MOVE G6D,  98,  76, 145,  90, 100, 100
    WAIT
    'mode = 0
    RETURN
    '******************************************
집고기본자세:
	SPEED 12
	MOVE G6A, 100,  76, 145,  90, 100, 100
    MOVE G6D, 100,  76, 145,  90, 100, 100
    WAIT    
    
    RETURN
    '******************************************
차렷자세: '사용X
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 2 '필요X
    
    RETURN
    '******************************************
앉은자세: '필요X
    GOSUB 자이로OFF'앉기 자세 - 자이로OFF
    MOVE G6A,100, 145,  28, 145, 100, 100
    MOVE G6D,100, 145,  28, 145, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 1'필요X
    
    RETURN
    '******************************************
	
	
'머리 좌우
머리왼쪽90도: '사용X
    SPEED 머리이동속도
    SERVO 11,10
    
    GOTO MAIN
    '******************************************
머리왼쪽60도: '사용X
    SPEED 머리이동속도
    SERVO 11,40
    
    GOTO MAIN
    '******************************************
머리왼쪽45도: '사용X
    SPEED 머리이동속도
    SERVO 11,55
    
    GOTO MAIN
    '******************************************
머리왼쪽30도: '사용X
    SPEED 머리이동속도
    SERVO 11,70
    
    GOTO MAIN
    '******************************************
머리좌우중앙:
    SPEED 머리이동속도
    SERVO 11,100
    
    GOTO MAIN
    '******************************************
머리오른쪽30도: '사용X
    SPEED 머리이동속도
    SERVO 11,130
    
    GOTO MAIN
    '******************************************
머리오른쪽45도: '사용X
    SPEED 머리이동속도
    SERVO 11,145
    
    GOTO MAIN	
    '******************************************
머리오른쪽60도: '사용X
    SPEED 머리이동속도
    SERVO 11,160
    
    GOTO MAIN
    '******************************************
머리오른쪽90도: '사용X
    SPEED 머리이동속도
    SERVO 11,190
    
    GOTO MAIN
    '******************************************
머리상하정면: '사용X
    SPEED 머리이동속도
    SERVO 11,100	
    
    SPEED 5
    GOSUB 기본자세
    
    GOTO RX_EXIT
    '******************************************
머리좌우커스텀:
	SPEED 머리이동속도
    SERVO 11,115
    
    GOTO MAIN
    '******************************************


'머리 상하
머리상하중앙:
    SPEED 머리이동속도
    MOVE G6C,,,,,100
    WAIT
    'ETX  4800,0
	GOTO MAIN
    '******************************************
머리하향50도:
    SPEED 머리이동속도
    MOVE G6C,,,,,70
    WAIT
    'ETX  4800,0
    GOTO MAIN '!!! 원래 MAIN_2로 되어있었음. 문제시 수정
    '******************************************
머리하향60도:
    SPEED 머리이동속도
    MOVE G6C,,,,,60
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
머리하향70도:
	SPEED 머리이동속도
	MOVE G6C,,,,,40
	WAIT
	GOTO MAIN
    '******************************************
머리하향80도:
    SPEED 머리이동속도
    MOVE G6C,,,,,20
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
머리하향85도:
    SPEED 머리이동속도
    MOVE G6C,,,,,15
    WAIT
    'ETX  4800,0
    GOTO MAIN
    '******************************************
머리하향커스텀:
    SPEED 머리이동속도
    MOVE G6C,,,,,74
    WAIT
    'ETX  4800,0
	GOTO MAIN
    '******************************************
머리70: '아래 머리 부분 전부 사용X
    SPEED 머리이동속도
    MOVE G6C,,,,,70
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리68:
    SPEED 머리이동속도
    MOVE G6C,,,,,68
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리66:
    SPEED 머리이동속도
    MOVE G6C,,,,,66
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리64:
    SPEED 머리이동속도
    MOVE G6C,,,,,64
    WAIT
    'ETX  4800,0
    '******************************************
머리62:
    SPEED 머리이동속도
    MOVE G6C,,,,,62
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리60:
    SPEED 머리이동속도
    MOVE G6C,,,,,60
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리58:
    SPEED 머리이동속도
    MOVE G6C,,,,,58
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리56:
    SPEED 머리이동속도
    MOVE G6C,,,,,56
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리54:
    SPEED 머리이동속도
    MOVE G6C,,,,,54
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리52:
    SPEED 머리이동속도
    MOVE G6C,,,,,52
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리50:
    SPEED 머리이동속도
    MOVE G6C,,,,,50
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리48:
    SPEED 머리이동속도
    MOVE G6C,,,,,48
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리46:
    SPEED 머리이동속도
    MOVE G6C,,,,,46
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리44:
    SPEED 머리이동속도
    MOVE G6C,,,,,44
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리42:
    SPEED 머리이동속도
    MOVE G6C,,,,,42
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리40:
    SPEED 머리이동속도
    MOVE G6C,,,,,40
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리38:
    SPEED 머리이동속도
    MOVE G6C,,,,,38
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리36:
    SPEED 머리이동속도
    MOVE G6C,,,,,36
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리34:
    SPEED 머리이동속도
    MOVE G6C,,,,,34
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리32:
    SPEED 머리이동속도
    MOVE G6C,,,,,32
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리30:
    SPEED 머리이동속도
    MOVE G6C,,,,,30
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리28:
    SPEED 머리이동속도
    MOVE G6C,,,,,28
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리26:
    SPEED 머리이동속도
    MOVE G6C,,,,,26
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리24:
    SPEED 머리이동속도
    MOVE G6C,,,,,24
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리22:
    SPEED 머리이동속도
    MOVE G6C,,,,,22
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************
머리20:
    SPEED 머리이동속도
    MOVE G6C,,,,,20
    WAIT
    'ETX  4800,0
	GOTO 고개컨트롤
    '******************************************


'팔
팔앞으로:
	SPEED 7
	MOVE G6B,180
    MOVE G6C,180
        
    RETURN
    '******************************************
    

'좌우 턴
왼쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴3_LOOP:
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
    GOSUB 기본자세

    GOTO MAIN
    '******************************************
오른쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽턴3_LOOP:
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
    GOSUB 기본자세
	
    GOTO MAIN
    '******************************************
왼쪽턴4:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴4_LOOP:
    IF 보행순서 = 0 THEN
        보행순서 = 1
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
        보행순서 = 0
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
    GOSUB 기본자세
	'ETX  4800,0

    GOTO MAIN
    '******************************************
오른쪽턴4:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽턴4_LOOP:
    IF 보행순서 = 0 THEN
        보행순서 = 1
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
        보행순서 = 0
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
    GOSUB 기본자세
	'ETX  4800,0
	
    GOTO MAIN
    '******************************************
왼쪽턴10: '사용X
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
    GOSUB 기본자세
    
    GOTO MAIN
    '******************************************
오른쪽턴10: '사용X
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
    GOSUB 기본자세

    GOTO MAIN
    '******************************************
왼쪽턴20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 4 '기존의 2분의 1!!!
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 6 '기존의 2분의 1!!!
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    
    SPEED 3 '기존의 2분의 1!!!
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    RETURN
    '******************************************
오른쪽턴20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 4 '기존의 2분의 1!!!
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 6 '기존의 2분의 1!!!
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 3 '기존의 2분의 1!!!
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    RETURN
    '******************************************
왼쪽턴45:
	'ETX  4800,0
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    DELAY 10
왼쪽턴45_LOOP:
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
    GOSUB 기본자세

    RETURN
    '******************************************
오른쪽턴45:
	'ETX  4800,0
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    DELAY 10
오른쪽턴45_LOOP:
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
    GOSUB 기본자세
    
	RETURN
    '******************************************
왼쪽턴60: '사용X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴60_LOOP:
    SPEED 15
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 12
    GOSUB 기본자세

    GOTO MAIN
    '******************************************
오른쪽턴60: '사용X
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽턴60_LOOP:
    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100
    WAIT

    SPEED 12
    GOSUB 기본자세
    ' DELAY 50
    '    GOSUB 앞뒤기울기측정
    '    IF 넘어짐알림 = 1 THEN
    '        넘어짐알림 = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,오른쪽턴60_LOOP
    '    IF A_old = A THEN GOTO 오른쪽턴60_LOOP

    GOTO MAIN
    '******************************************
	

'집기
집고일어서기:
	GRIP = 1 '물건 잡고 있을 때
	
	HIGHSPEED SETOFF
	SPEED 12
	
	'팔벌리기' 
	MOVE G6B, 100,  87,  81,  ,  ,  
	MOVE G6C, 100,  87,  81,  ,  ,  
	WAIT

	'숙이기'
	MOVE G6A, 100, 146,  40, 139, 100,  
	MOVE G6D, 100, 146,  40, 139, 100,  
	MOVE G6B, 145,  90,  81,  ,  ,  
	MOVE G6C, 145,  90,  81,  ,  ,  
	WAIT
	
	'물건 집기'
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

	'일어서기'
	MOVE G6A, 100,  76, 145,  90, 100,  
	MOVE G6D, 100,  76, 145,  90, 100,  
	MOVE G6B, 160,  10,  61,  ,  ,  
	MOVE G6C, 160,  10,  61,  ,  ,  
	WAIT
    
    GOTO MAIN
    '******************************************	
내려놓기:
	GRIP = 0 '물건 잡고 있지 않을 때
	
	HIGHSPEED SETOFF
	SPEED 12

	'숙이기'
	MOVE G6A, 100, 146,  40, 139, 100,  
	MOVE G6D, 100, 146,  40, 139, 100,   
	WAIT
	
	'물건 내려놓기'
	MOVE G6A, 100, 146,  25, 154, 100,  
	MOVE G6D, 100, 146,  25, 154, 100,  
	WAIT
	
	MOVE G6B, 100,  87,  81,  ,  ,  
	MOVE G6C, 100,  87,  81,  ,  ,  
	WAIT

	'일어서기'
	MOVE G6A, 98,  76, 145,  93, 100, 100
    MOVE G6D, 98,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    
    GOTO MAIN
    '******************************************	
    

'집고 턴
집고왼쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
집고왼쪽턴3_LOOP:
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

    GOSUB 집고기본자세

    GOTO MAIN
    '******************************************
집고오른쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
집고오른쪽턴3_LOOP:
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
	
    GOSUB 집고기본자세
	'ETX  4800,0
	
    GOTO MAIN
    '******************************************
집고왼쪽턴20: '사용X
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
집고오른쪽턴20: '사용X
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
집고왼쪽턴45: '사용X
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
집고오른쪽턴45: '사용X
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
집고왼쪽턴60: '사용X
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
집고오른쪽턴60: '사용X
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
    

'전진종종걸음(걸음 무한)
전진종종걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF 보행순서= 0 THEN
        보행순서 = 1
        MOVE G6A,95, 76, 147, 93, 101
        MOVE G6D,101, 76, 147, 93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT
        
        GOTO 전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT
        
        GOTO 전진종종걸음_4
    ENDIF
    '******************************************
전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT
    
    GOSUB 앞뒤기울기측정'넘어졌는지 판단
    IF 넘어짐알림 = 1 THEN '넘어진 후 상태면 통신대기
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    ERX 4800,A, 전진종종걸음_4 '통신해서 같으면 걷고, 다르면 멈춘 후 MAIN으로
    IF A <> A_old THEN
전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
		
		GOTO MAIN
	ENDIF
    '******************************************
전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정'넘어졌는지 판단
    IF 넘어짐알림 = 1 THEN '넘어진 후 상태면 통신대기
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    ERX 4800,A, 전진종종걸음_1 '통신해서 같으면 걷고, 다르면 멈춘 후 MAIN으로
    IF A <> A_old THEN
전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		GOTO MAIN '원래 ON A GOTO KEY1, ....!!!
	ENDIF

    GOTO 전진종종걸음_1
    '******************************************
    

'횟수전진종종걸음
횟수_전진종종걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_전진종종걸음_4
    ENDIF
    '******************************************
횟수_전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
횟수_전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_전진종종걸음_2_stop
	
    ERX 4800,A, 횟수_전진종종걸음_4
    IF A <> A_old THEN
횟수_전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        GOTO MAIN
    ENDIF
    '******************************************
횟수_전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
횟수_전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정 '넘어졌는지 판단
    IF 넘어짐알림 = 1 THEN '넘어진 후 상태면 통신대기
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_전진종종걸음_5_stop '보행횟수 초과 시 멈춘 후 MAIN으로
	
    ERX 4800,A, 횟수_전진종종걸음_1 '통신해서 같으면 걷고, 다르면 멈춘 후 MAIN으로
    IF A <> A_old THEN
횟수_전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
		GOTO MAIN
    ENDIF

    GOTO 횟수_전진종종걸음_1
    '******************************************


'후진종종걸음
후진종종걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화

    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 후진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 후진종종걸음_4
    ENDIF
    '******************************************
후진종종걸음_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT
후진종종걸음_2:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 후진종종걸음_2_stop
    
    ERX 4800,A, 후진종종걸음_4
    IF A <> A_old THEN
후진종종걸음_2_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        GOTO MAIN '원래 RX_EXIT
    ENDIF
    '******************************************
후진종종걸음_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT
후진종종걸음_5:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    
    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 후진종종걸음_5_stop

    ERX 4800,A, 후진종종걸음_1
    IF A <> A_old THEN 
후진종종걸음_5_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        GOTO MAIN '원래 RX_EXIT
    ENDIF

    GOTO 후진종종걸음_1
    '******************************************
    

'횟수_후진종종걸음
횟수_후진종종걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_후진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_후진종종걸음_4
    ENDIF
    '******************************************
횟수_후진종종걸음_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT
횟수_후진종종걸음_2:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO MAIN
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_후진종종걸음_2_stop
    
    ERX 4800,A, 횟수_후진종종걸음_4
    
    IF A <> A_old THEN
횟수_후진종종걸음_2_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        GOTO MAIN
    ENDIF
    '******************************************
횟수_후진종종걸음_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT
횟수_후진종종걸음_5:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    
    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO MAIN
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_후진종종걸음_5_stop

    ERX 4800,A, 횟수_후진종종걸음_1
    
    IF A <> A_old THEN 
횟수_후진종종걸음_5_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        GOTO MAIN
    ENDIF

    GOTO 횟수_후진종종걸음_1
    '******************************************


'좌우 걸음
오른쪽옆으로20: '사용 X
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽옆으로_2:
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
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT < 게걸음횟수 THEN GOTO 오른쪽옆으로_2

    SPEED 8
    GOSUB 기본자세
    
    GOTO RX_EXIT
    '******************************************
오른쪽옆으로70연속: '사용 X
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽옆으로70연속_loop:
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

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT < 게걸음횟수 THEN GOTO 오른쪽옆으로70연속_loop
    
    SPEED 8
    GOSUB 기본자세
    
    RETURN
    '******************************************
왼쪽옆으로70연속: '사용 X
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
	
	MOVE G6B, 186, 100,  81, 100, 100, 101
	MOVE G6C, 189,  73,  55, 100,  98, 100
	WAIT
	
	MOVE G6B, 158, 103,  77, 100, 100, 101
	MOVE G6C, 152,  94,  93, 100,  98, 100
	WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽옆으로70연속_loop:
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

    '   ERX 4800, A ,왼쪽옆으로70연속_loop	
    '    IF A = A_OLD THEN  GOTO 왼쪽옆으로70연속_loop
    '왼쪽옆으로70연속_stop:
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT < 게걸음횟수 THEN GOTO 오른쪽옆으로_2

    SPEED 8
    GOSUB 기본자세

    GOTO RX_EXIT
    '******************************************
오른쪽옆으로70연속_바닥_커스텀:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
	
	'MOVE G6B, 186, 100,  81, 100, 100, 101
	'MOVE G6C, 189,  73,  55, 100,  98, 100
	'WAIT
	
	'MOVE G6B, 158, 103,  77, 100, 100, 101
	'MOVE G6C, 152,  94,  93, 100,  98, 100
	'WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽옆으로70연속_loop_바닥_커스텀:
    DELAY  10

	SPEED 머리이동속도
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

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT < 게걸음횟수 THEN GOTO 오른쪽옆으로70연속_loop
    
    SPEED 8
    GOSUB 기본자세
    
    RETURN
    '******************************************
왼쪽옆으로70연속_바닥_커스텀:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
	
	'MOVE G6B, 186, 100,  81, 100, 100, 101
	'MOVE G6C, 189,  73,  55, 100,  98, 100
	'WAIT
	
	'MOVE G6B, 158, 103,  77, 100, 100, 101
	'MOVE G6C, 152,  94,  93, 100,  98, 100
	'WAIT
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽옆으로70연속_loop_바닥_커스텀:
    DELAY  10

	SPEED 머리이동속도
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

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT < 게걸음횟수 THEN GOTO 오른쪽옆으로_2 '게걸음 10회 진행

    SPEED 8
    GOSUB 기본자세

    GOTO RX_EXIT
    '******************************************
	

'문 열기
문열기전진종종걸음:
    DOOR = 0
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    보행횟수 = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기전진종종걸음_4
    ENDIF
    '******************************************
문열기전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
문열기전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB 적외선거리센서측정 '적외선 거리값 측정
	IF 적외선거리값 > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        SPEED 7
        GOTO 문열기전진종종걸음0
    ENDIF
	
	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기전진종종걸음_2_stop

    ERX 4800,A, 문열기전진종종걸음_4
    IF A <> A_old THEN
문열기전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
문열기전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
문열기전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB 적외선거리센서측정
	IF 적외선거리값 > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        GOTO 문열기전진종종걸음0
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기전진종종걸음_5_stop
    
    ERX 4800,A, 문열기전진종종걸음_1
    IF A <> A_old THEN
문열기전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO 문열기전진종종걸음_1
    '******************************************	
문열기전진종종걸음0:
    보행COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기전진종종걸음_7
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기전진종종걸음_9
    ENDIF
    '******************************************	
문열기전진종종걸음_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
문열기전진종종걸음_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
	IF 보행COUNT > 보행횟수 THEN  GOTO 문열기전진종종걸음_8_stop
	
	ERX 4800,A, 문열기전진종종걸음_9

    GOTO 문열기전진종종걸음_9
문열기전진종종걸음_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        GOTO 문열기전진종종걸음
    '******************************************
문열기전진종종걸음_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
문열기전진종종걸음_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
	
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기전진종종걸음_0_stop
    
    ERX 4800,A, 문열기전진종종걸음_7
    
    GOTO 문열기전진종종걸음_7
문열기전진종종걸음_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        GOTO 문열기전진종종걸음
    '******************************************	
    
    
'벽 열기
벽열기전진종종걸음:
    DOOR = 0
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    보행횟수 = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 벽열기전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 벽열기전진종종걸음_4
    ENDIF
    '******************************************
벽열기전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
벽열기전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB 적외선거리센서측정 '적외선 거리값 측정
	IF 적외선거리값 > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        SPEED 7
        GOTO 벽열기전진종종걸음0
    ENDIF
	
	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 벽열기전진종종걸음_2_stop

    ERX 4800,A, 벽열기전진종종걸음_4
    IF A <> A_old THEN
벽열기전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
벽열기전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
벽열기전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB 적외선거리센서측정
	IF 적외선거리값 > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        GOTO 벽열기전진종종걸음0
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 벽열기전진종종걸음_5_stop
    
    ERX 4800,A, 벽열기전진종종걸음_1
    IF A <> A_old THEN
벽열기전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO 벽열기전진종종걸음_1
    '******************************************	
벽열기전진종종걸음0:
    보행COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 벽열기전진종종걸음_7
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 벽열기전진종종걸음_9
    ENDIF
    '******************************************	
벽열기전진종종걸음_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
벽열기전진종종걸음_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
	IF 보행COUNT > 보행횟수 THEN  GOTO 벽열기전진종종걸음_8_stop
	
	ERX 4800,A, 벽열기전진종종걸음_9

    GOTO 벽열기전진종종걸음_9
벽열기전진종종걸음_8_stop:
	    MOVE G6D,95,  90, 125, 95, 104
	    MOVE G6A,104,  76, 145,  91,  102
	    MOVE G6B, 100
	    MOVE G6C,100
	    WAIT
	    
	    HIGHSPEED SETOFF
	    SPEED 15
	    GOSUB 안정화자세
	    
	    SPEED 5
	    GOSUB 기본자세
	    
		DOOR  = 0
	    GOTO 벽열기전진종종걸음_2_stop
    '******************************************
벽열기전진종종걸음_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
벽열기전진종종걸음_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
	
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 벽열기전진종종걸음_0_stop
    
    ERX 4800,A, 벽열기전진종종걸음_7
    
    GOTO 벽열기전진종종걸음_7
벽열기전진종종걸음_0_stop:
	    MOVE G6A,95,  90, 125, 95, 104
	    MOVE G6D,104,  76, 145,  91,  102
	    MOVE G6B, 100
	    MOVE G6C, 100
	    WAIT
	    
	    HIGHSPEED SETOFF
	    SPEED 15
	    GOSUB 안정화자세
	    
	    SPEED 5
	    GOSUB 기본자세
	    
		DOOR  = 0
	    GOTO 벽열기전진종종걸음_5_stop
    '******************************************	
    
    
'문 열기2
문열기2전진종종걸음:
    DOOR = 0
문열기2전진커스텀라벨:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    보행횟수 = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7
    'ETX  4800,0

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기2전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기2전진종종걸음_4
    ENDIF
    '******************************************
문열기2전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
문열기2전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

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
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		SPEED 11 '!!!
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        SPEED 7
        GOTO 문열기2전진종종걸음0
    ENDIF
	
	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기2전진종종걸음_2_stop

    ERX 4800,A, 문열기2전진종종걸음_4
    IF A <> A_old THEN
문열기2전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
문열기2전진커스텀stop:
		DOOR  = 0
        GOTO MAIN
    ENDIF
    '******************************************
문열기2전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
문열기2전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB 적외선거리센서측정
	IF DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
        SPEED 11 '!!!
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        SPEED 7
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        GOTO 문열기2전진종종걸음0
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기2전진종종걸음_5_stop
    
    ERX 4800,A, 문열기2전진종종걸음_1
    IF A <> A_old THEN
문열기2전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
		DOOR  = 0
		
        GOTO MAIN
    ENDIF

    GOTO 문열기2전진종종걸음_1
    '******************************************	
문열기2전진종종걸음0:
    보행COUNT = 0
    
    GOSUB All_motor_mode3
    SPEED 9 '!!!
    
	IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기2전진종종걸음_7
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 문열기2전진종종걸음_9
    ENDIF
    '******************************************	
문열기2전진종종걸음_7:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
문열기2전진종종걸음_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
	IF 보행COUNT > 보행횟수 THEN  GOTO 문열기2전진종종걸음_8_stop
	
	ERX 4800,A, 문열기2전진종종걸음_9

    GOTO 문열기2전진종종걸음_9
문열기2전진종종걸음_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 1
        GOTO 문열기2전진커스텀stop
    '******************************************
문열기2전진종종걸음_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
문열기2전진종종걸음_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
	
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 문열기2전진종종걸음_0_stop
    
    ERX 4800,A, 문열기2전진종종걸음_7
    
    GOTO 문열기2전진종종걸음_7
문열기2전진종종걸음_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 1
        GOTO 문열기2전진커스텀stop
	
    GOTO 문열기2전진종종걸음_7
    '******************************************	


'퇴장전진종종걸음
퇴장전진종종걸음:
    DOOR = 0
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    보행횟수 = 1
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 퇴장전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 퇴장전진종종걸음_4
    ENDIF
    '******************************************
퇴장전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
	MOVE G6B, 85
    MOVE G6C,115
퇴장전진종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	GOSUB 적외선거리센서측정
	IF 적외선거리값 > 100  AND DOOR = 0 THEN
		MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        SPEED 7
        GOTO 퇴장전진종종걸음0
    ENDIF

    ERX 4800,A, 퇴장전진종종걸음_4
    IF A <> A_old THEN
퇴장전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
    ENDIF
    '******************************************
퇴장전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
퇴장전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

	GOSUB 적외선거리센서측정
	IF 적외선거리값 > 100 AND DOOR = 0 THEN
		MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
        SPEED 4
		MOVE G6B,160
        MOVE G6C,160
        WAIT
        
        적외선거리값= 0
        DOOR  = 1
        보행횟수 = 6
        
        SPEED 7
        GOTO 퇴장전진종종걸음0
    ENDIF
    
    ERX 4800,A, 퇴장전진종종걸음_1
    IF A <> A_old THEN
퇴장전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
        A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO 퇴장전진종종걸음_1
    '******************************************
퇴장전진종종걸음0:
    보행COUNT = 0
    
	GOSUB All_motor_mode3
    SPEED 7
    
	IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        WAIT

        GOTO 퇴장전진종종걸음_7
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        WAIT

        GOTO 퇴장전진종종걸음_9
    ENDIF
    '******************************************
퇴장전진종종걸음_7:
	    MOVE G6A,95,  90, 125, 100, 104
	    MOVE G6D,104,  77, 147,  93,  102
퇴장전진종종걸음_8:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
	IF 보행COUNT > 보행횟수 THEN  GOTO 퇴장전진종종걸음_8_stop '!!!
	
	ERX 4800,A, 퇴장전진종종걸음_9
    IF A <> A_old THEN
    	A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO 문열기전진종종걸음_9
퇴장전진종종걸음_8_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
		
        GOTO 퇴장전진종종걸음
    '******************************************
퇴장전진종종걸음_9:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    WAIT
퇴장전진종종걸음_0:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
	
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 퇴장전진종종걸음_0_stop
    
    ERX 4800,A, 퇴장전진종종걸음_7
    IF A <> A_old THEN
    	A_old = A
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO 퇴장전진종종걸음_7
퇴장전진종종걸음_0_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		DOOR  = 0
		
        GOTO 퇴장전진종종걸음
    '******************************************
    
    
'집고걸음
집고걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기
    
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  90, 101
        MOVE G6D,101, 76, 147,  90, 98
        MOVE G6B,160
        MOVE G6C,160
        WAIT

        GOTO 집고걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D, 100, 76, 147, 90, 105
        MOVE G6A,101, 76, 147, 90, 96
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT

        GOTO 집고걸음_4
    ENDIF
    '******************************************
집고걸음_1:
    MOVE G6A,95,  90, 125, 97, 104
    MOVE G6D,104, 77, 147, 90, 102
집고걸음_2:
    MOVE G6A,103,  73, 140, 100, 100
    MOVE G6D, 95,  85, 147, 82, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
		넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 집고걸음_2_stop
    
    ERX 4800,A, 집고걸음_4
    IF A <> A_old THEN
집고걸음_2_stop:
        MOVE G6D,95,  90, 125, 93, 104
        MOVE G6A,104, 76, 145, 88, 102
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT
        
		HIGHSPEED SETOFF
		GOSUB 집고안정화자세
		GOSUB 집고기본자세
        'DELAY 400
        
        GOTO MAIN
    ENDIF
    '******************************************
집고걸음_4:
    MOVE G6D, 95,  95, 120, 97, 104
    MOVE G6A,104,  77, 147, 90, 102
    WAIT
집고걸음_5:
    MOVE G6D,103,  73, 140,  100,  100
    MOVE G6A, 95,  85, 147,  82, 102
    WAIT

    GOSUB 앞뒤기울기측정
    
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 집고걸음_5_stop
    
    ERX 4800,A, 집고걸음_1
    IF A <> A_old THEN
집고걸음_5_stop:
        MOVE G6A,95,  90, 125, 92, 104
        MOVE G6D,104, 76, 145, 88, 102
        'MOVE G6B,160
        'MOVE G6C,160        
        WAIT
        
        HIGHSPEED SETOFF
		GOSUB 집고안정화자세
		GOSUB 집고기본자세
        'DELAY 400
        
        GOTO MAIN
    ENDIF

	GOTO 집고걸음_1
    '******************************************
    
    
집고후진종종걸음:
    A_old = A '과거 통신값에 현재 통신값 동기화
    보행COUNT = 0 '보행 횟수 초기화
    보행횟수 = 1

    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 3

    IF 보행순서 = 0 THEN
        보행순서 = 1
        
        MOVE G6A,95,  76, 145,  88, 101
        MOVE G6D,101,  76, 145,  88, 98
        WAIT

        GOTO 집고후진종종걸음_1
    ELSE
        보행순서 = 0
        
        MOVE G6D,95,  76, 145,  88, 101
        MOVE G6A,101,  76, 145,  88, 98
        WAIT

        GOTO 집고후진종종걸음_4
    ENDIF
    '******************************************
집고후진종종걸음_1:
    MOVE G6D,104,  76, 147,  88,  102
    MOVE G6A,95,  95, 120, 90, 104
    WAIT
집고후진종종걸음_2:
    MOVE G6A, 103,  79, 147,  84, 100
    MOVE G6D,95,   65, 147, 98,  102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
    
    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 집고후진종종걸음_2_stop
    
    ERX 4800,A, 집고후진종종걸음_4
    IF A <> A_old THEN
집고후진종종걸음_2_stop:
        MOVE G6D,95,  85, 130, 95, 104
        MOVE G6A,104,  77, 146,  88,  102
        WAIT

        HIGHSPEED SETOFF
        GOSUB 집고안정화자세
        GOSUB 집고기본자세

        GOTO MAIN
    ENDIF
    '******************************************
집고후진종종걸음_4:
    MOVE G6A,104,  76, 147,  88,  102
    MOVE G6D,95,  95, 120, 90, 104
    WAIT
집고후진종종걸음_5:
    MOVE G6D, 103,  79, 147,  84, 100
    MOVE G6A,95,   65, 147, 98,  102
    WAIT
    
    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF
	
	보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 집고후진종종걸음_5_stop
    
    ERX 4800,A, 집고후진종종걸음_1
    IF A <> A_old THEN 
집고후진종종걸음_5_stop:
        MOVE G6A,95,  85, 130, 95, 104
        MOVE G6D,104,  77, 146,  88,  102
        WAIT

        HIGHSPEED SETOFF
        GOSUB 집고안정화자세
        GOSUB 집고기본자세

        GOTO MAIN
    ENDIF

    GOTO 집고후진종종걸음_1
    '******************************************
    

'필요X
횟수_종종걸음:
	보행횟수 = 1
	보행COUNT = 0
	
    GOSUB All_motor_mode3
    HIGHSPEED SETON
    SPEED 7

    IF 보행순서 = 0 THEN
        보행순서 = 1
        
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_종종걸음_1
    ELSE
        보행순서 = 0
        
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_종종걸음_4
    ENDIF
    '******************************************
횟수_종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT
횟수_종종걸음_2:
    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0

        GOTO RX_EXIT
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_종종걸음_2_stop
	
    ERX 4800,A, 횟수_종종걸음_4
    IF A <> A_old THEN
횟수_종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세

        RETURN
    ENDIF
    '******************************************
횟수_종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT
횟수_종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어짐알림 = 1 THEN
        넘어짐알림 = 0
        
        GOTO RX_EXIT
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_종종걸음_5_stop
	
    ERX 4800,A, 횟수_종종걸음_1
    IF A <> A_old THEN
횟수_종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        
        SPEED 5
        GOSUB 기본자세
        
		RETURN
    ENDIF
    '******************************************
    

' 사용X
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
    

' 사용X
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
    

' 사용X
Number_Play: '  BUTTON_NO = 숫자대입
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
    '		MAIN 반복 루틴
    '************************************************
MAIN:
	'통신 주기 타이머 초기화
    J = 0 '사용X
    time = 0
    '******************************************
    
MAIN_2:
    GOSUB 앞뒤기울기측정
    GOSUB 좌우기울기측정
    GOSUB 적외선거리센서측정
    
    '통신 주기 타이머 가동 - 라즈베리파이에서 오는 연속적 통신값을 계속해서 실행하지 않기 위함
    time = time + 1
	
	IF time = 180 THEN
		A_old = 10000 '과거 통신값 조정
		time = 0 '통신 주기 타이머 초기화
	ENDIF
	
	'통신
    ERX 4800,A,MAIN_2
    
    '과거 통신값과 현재 통신값이 다르면 동작
    IF A <> A_old THEN
    	time = 0 '통신 주기 타이머 초기화
    	A_old = A '과거 통신값과 현재 통신값 동일화
		ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32,KEY33,KEY34,KEY35,KEY36,KEY37,KEY38,KEY39,KEY40,KEY41,KEY42,KEY43,KEY44,KEY45,KEY46,KEY47,KEY48,KEY49,KEY50,KEY51,KEY52,KEY53,KEY54,KEY55,KEY56,KEY57,KEY58,KEY59,KEY60,KEY61, KEY62, KEY63, KEY64, KEY65, KEY66
	ENDIF
	
    GOTO MAIN_2
    '************************************************
    '		MAIN 라벨로 가기
    '************************************************
KEY1:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO MAIN
    '******************************************
KEY2:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
   
    GOTO 전진종종걸음
    '******************************************
KEY3:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
	
    GOTO 집고일어서기
    '******************************************
KEY4:
    GRIP = 1
    
	보행횟수 = 6
    GOSUB 집고걸음
    
    GOTO MAIN
    '******************************************
KEY5:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOSUB 기본자세
	
    GOTO MAIN
    '******************************************
KEY6:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 왼쪽턴3
    '******************************************
KEY7:
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 오른쪽턴3
    '******************************************
KEY8:
    GOTO 머리하향60도
    '******************************************
KEY9:
    GOTO 머리상하중앙
    '******************************************
KEY10: '0
    GOSUB 집고기본자세

    GOTO MAIN
    '******************************************
KEY11: ' ▲
	GOTO 내려놓기
    '******************************************
KEY12: ' ▼
	GRIP = 1

	GOSUB 남쪽소리내기

    GOTO MAIN
    '******************************************
KEY13: '▶
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF

    GOTO 왼쪽턴4
    '******************************************
KEY14: ' ◀
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 오른쪽턴4
    '******************************************
KEY15: ' A '좌로 90도
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    GOSUB 왼쪽턴45
    GOSUB 왼쪽턴45
    GOSUB 왼쪽턴45
    GOSUB 왼쪽턴45
    보행횟수 = 2
    GOSUB 횟수_전진종종걸음

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
    'GOSUB 앉은자세	
    '
    'GOSUB MOTOR_GET
    'GOSUB MOTOR_OFF
	'
    'GOSUB GOSUB_RX_EXIT
	GOSUB 팔앞으로
        
    GOTO MAIN
    '******************************************
KEY16_1:
    IF 모터ONOFF = 0  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    
    ERX 4800,A,KEY16_1
    'ETX  4800,A
    '**** RX DATA Number Sound ********
    BUTTON_NO = A
  
    
    IF  A = 16 THEN 	'다시 파워버튼을 눌러야만 복귀
    	GOSUB MOTOR_ON
        SPEED 10
        MOVE G6A,100, 140,  37, 145, 100, 100
        MOVE G6D,100, 140,  37, 145, 100, 100
        WAIT
       
        GOSUB 기본자세
        GOSUB 자이로ON
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOSUB GOSUB_RX_EXIT
    GOTO KEY16_1

    GOTO RX_EXIT
    '******************************************
KEY17: ' C ' 우로 90도
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
	GOSUB 오른쪽턴45
	GOSUB 오른쪽턴45
	GOSUB 오른쪽턴45
	GOSUB 오른쪽턴45
	보행횟수 = 2
	GOSUB 횟수_전진종종걸음

    GOTO MAIN
    '******************************************
KEY18: ' E
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 문열기2전진종종걸음	
KEY19: ' P2
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
	GOSUB 횟수_전진종종걸음

    GOTO MAIN
    '******************************************
KEY20: ' B	
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
	GOTO 후진종종걸음
	
    GOTO RX_EXIT
    '******************************************
KEY21: ' △
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 왼쪽턴10
    '******************************************
KEY22: ' *	
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 오른쪽턴10
    '******************************************
KEY23: ' G
    GOSUB 에러음
    
    GOSUB All_motor_mode2
    '******************************************
KEY23_wait:
    ERX 4800,A,KEY23_wait	

    IF  A = 26 THEN
        GOSUB 시작음
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOTO KEY23_wait

    GOTO RX_EXIT
    '******************************************
KEY24: ' #
	IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO MAIN
    '******************************************
KEY25: ' P1
    GOSUB 머리하향70도
    
    GOTO MAIN
    '******************************************
KEY26: ' ■
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    보행횟수 = 1
    GOTO 횟수_후진종종걸음
    '******************************************
KEY27: ' D
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    보행횟수 = 1
    GOTO 횟수_전진종종걸음
    
    GOTO MAIN
    '******************************************
KEY28: ' ◁
    GOTO 집고왼쪽턴3
    '******************************************
KEY29: ' □
    GOSUB 머리하향80도
    
    GOTO MAIN
    '******************************************
KEY30: ' ▷
    GOTO 집고오른쪽턴3
    '******************************************
KEY31: ' ▽
    GOTO 집고후진종종걸음
    '******************************************
KEY32: ' F
	GRIP = 1
	
    MOVE G6B, 190,  20,  80
    MOVE G6C, 190,  20,  80
    WAIT
    
    GOTO 집고걸음
    '******************************************
KEY33: 
    GOTO 머리하향60도
    '******************************************
KEY34: 
    GOTO 머리하향70도
    '******************************************
KEY35:
    GOTO 머리하향80도
    '******************************************
KEY36:
	GOSUB 적외선거리센서측정
	적외선거리값 = 적외선거리값 + 100
	ETX  4800,적외선거리값
	적외선거리값 = 적외선거리값 - 100
	
	GOTO MAIN
    '******************************************
KEY37: 
	GRIP = 1
	
    GOTO 동쪽소리내기
    '******************************************
KEY38: 
	GRIP = 1
	
	GOTO 서쪽소리내기
    '******************************************
KEY39: 
	GRIP = 1
	
	GOTO 남쪽소리내기
    '******************************************
KEY40: 
	GRIP = 1
	
    GOTO 북쪽소리내기
    '******************************************
KEY41: 
    GOTO A지역소리내기
    '******************************************
KEY42: 
    GOTO B지역소리내기
    '******************************************
KEY43: 
    GOTO C지역소리내기
    '******************************************
KEY44: 
    GOTO D지역소리내기
    '****************************************** 
KEY45:     
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOSUB 왼쪽턴45
    
    GOTO MAIN
    '******************************************
KEY46:     
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOSUB 오른쪽턴45
    
    GOTO MAIN
    '******************************************
KEY47: 
    GOTO 확진지역소리내기
    '******************************************
KEY48: 
    GOTO 안전지역소리내기
    '******************************************
KEY49: 
	GRIP = 1
	
    GOTO 퇴장전진종종걸음
    '******************************************
KEY50: 
	GOTO 내려놓기
    '******************************************
KEY51: '사용X
	C = 1
	J = 0
고개컨트롤:'사용X
	ERX 4800,LRS,고개컨트롤
	
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
			GOSUB 횟수_종종걸음
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
    
    ON C GOTO 머리70, 머리68, 머리66, 머리64,머리62, 머리60, 머리58, 머리56, 머리54,머리52, 머리50, 머리48, 머리46, 머리44,머리42, 머리40, 머리38, 머리36,머리34, 머리32, 머리30, 머리28,머리26, 머리24, 머리22, 머리20
	
	GOTO 고개컨트롤
	'******************************************
KEY52:
	GOTO 머리하향50도
	'******************************************
KEY53:
	GOTO 머리하향커스텀
	'******************************************
KEY54:
	GOTO 머리좌우중앙
	'******************************************
KEY55:
	GOTO 머리상하중앙
	'******************************************
KEY56:
	GOTO 머리좌우중앙
	'******************************************
KEY57:
	GOTO 머리좌우커스텀
	'******************************************
KEY58:
	GOSUB 왼쪽턴45
	
	GOTO MAIN
	'******************************************
KEY59:
	GOSUB 오른쪽턴45
	
	GOTO MAIN
	'******************************************
KEY60:
	GOSUB 왼쪽옆으로70연속_바닥_커스텀
	
	GOTO MAIN
	'******************************************
KEY61:
	GOSUB 오른쪽옆으로70연속_바닥_커스텀
	
	GOTO MAIN
	'******************************************
KEY62: 
    IF GRIP = 1 THEN
		GRIP = 0
		GOSUB 집고기본자세
		GOSUB 기본자세
    ENDIF
    
    GOTO 벽열기전진종종걸음
    '******************************************
KEY63:
	GOTO 머리하향85도
	'******************************************
KEY64:
	GOSUB 왼쪽턴20
	
	GOTO MAIN
	'******************************************
KEY65:
	GOSUB 오른쪽턴20
	
	GOTO MAIN
	'******************************************
KEY66:
	GOTO 머리하향50도
	'******************************************