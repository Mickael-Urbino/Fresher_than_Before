   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  19                     	bsct
  20  0000               _ms_count:
  21  0000 0000          	dc.w	0
  22  0002               _OCR:
  23  0002 0000          	dc.w	0
  24  0004               _arr_tim1:
  25  0004 0000          	dc.w	0
  26  0006               _arr_tim2:
  27  0006 0000          	dc.w	0
  28  0008               _press_count:
  29  0008 00            	dc.b	0
  61                     ; 46 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler,23) {
  62                     	switch	.text
  63  0000               f_TIM4_UPD_OVF_IRQHandler:
  65  0000 8a            	push	cc
  66  0001 84            	pop	a
  67  0002 a4bf          	and	a,#191
  68  0004 88            	push	a
  69  0005 86            	pop	cc
  70  0006 3b0002        	push	c_x+2
  71  0009 be00          	ldw	x,c_x
  72  000b 89            	pushw	x
  73  000c 3b0002        	push	c_y+2
  74  000f be00          	ldw	x,c_y
  75  0011 89            	pushw	x
  78                     ; 47     ms_count++; 
  80  0012 be00          	ldw	x,_ms_count
  81  0014 5c            	incw	x
  82  0015 bf00          	ldw	_ms_count,x
  83                     ; 48     TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  85  0017 a601          	ld	a,#1
  86  0019 cd0000        	call	_TIM4_ClearITPendingBit
  88                     ; 49 }
  91  001c 85            	popw	x
  92  001d bf00          	ldw	c_y,x
  93  001f 320002        	pop	c_y+2
  94  0022 85            	popw	x
  95  0023 bf00          	ldw	c_x,x
  96  0025 320002        	pop	c_x+2
  97  0028 80            	iret	
 133                     ; 52 main()
 133                     ; 53 {
 135                     	switch	.text
 136  0029               _main:
 140                     ; 54 	clock_setup();
 142  0029 ad36          	call	_clock_setup
 144                     ; 55 	gpio_setup();	
 146  002b cd00c1        	call	_gpio_setup
 148                     ; 56 	enableInterrupts();	
 151  002e 9a            	rim	
 153                     ; 57 	tim4_init();
 156  002f cd00df        	call	_tim4_init
 158                     ; 58 	arr_tim1 = tim1_init();	
 160  0032 cd021a        	call	_tim1_init
 162  0035 bf04          	ldw	_arr_tim1,x
 163                     ; 59 	arr_tim2 = tim2_init();	
 165  0037 cd01e3        	call	_tim2_init
 167  003a bf06          	ldw	_arr_tim2,x
 168  003c               L13:
 169                     ; 67 		if (GPIO_ReadInputPin(GPIOA, GPIO_PIN_1) == 0)
 171  003c 4b02          	push	#2
 172  003e ae5000        	ldw	x,#20480
 173  0041 cd0000        	call	_GPIO_ReadInputPin
 175  0044 5b01          	addw	sp,#1
 176  0046 4d            	tnz	a
 177  0047 260e          	jrne	L53
 178                     ; 69 			led_smooth_blink();
 180  0049 cd0260        	call	_led_smooth_blink
 182                     ; 70 			delay_ms(10);
 184  004c ae000a        	ldw	x,#10
 185  004f cd00f3        	call	_delay_ms
 187                     ; 71 			pump_smooth_on_off();
 189  0052 cd02a5        	call	_pump_smooth_on_off
 192  0055 20e5          	jra	L13
 193  0057               L53:
 194                     ; 76 			TIM2_SetCompare3(0);
 196  0057 5f            	clrw	x
 197  0058 cd0000        	call	_TIM2_SetCompare3
 199                     ; 77 			TIM1_SetCompare3(0);
 201  005b 5f            	clrw	x
 202  005c cd0000        	call	_TIM1_SetCompare3
 204  005f 20db          	jra	L13
 237                     ; 86 void clock_setup(void)
 237                     ; 87 {
 238                     	switch	.text
 239  0061               _clock_setup:
 243                     ; 88 	CLK_DeInit();
 245  0061 cd0000        	call	_CLK_DeInit
 247                     ; 90 	CLK_HSECmd(DISABLE);
 249  0064 4f            	clr	a
 250  0065 cd0000        	call	_CLK_HSECmd
 252                     ; 91 	CLK_LSICmd(DISABLE);
 254  0068 4f            	clr	a
 255  0069 cd0000        	call	_CLK_LSICmd
 257                     ; 92 	CLK_HSICmd(ENABLE); //Enable HSI clock (16MHz)
 259  006c a601          	ld	a,#1
 260  006e cd0000        	call	_CLK_HSICmd
 263  0071               L35:
 264                     ; 94 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 266  0071 ae0102        	ldw	x,#258
 267  0074 cd0000        	call	_CLK_GetFlagStatus
 269  0077 4d            	tnz	a
 270  0078 27f7          	jreq	L35
 271                     ; 96 	CLK_ClockSwitchCmd(ENABLE);
 273  007a a601          	ld	a,#1
 274  007c cd0000        	call	_CLK_ClockSwitchCmd
 276                     ; 97 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Peripheral Clock is 16MHz
 278  007f 4f            	clr	a
 279  0080 cd0000        	call	_CLK_HSIPrescalerConfig
 281                     ; 98 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1); //CPU Clock is 16MHz
 283  0083 a680          	ld	a,#128
 284  0085 cd0000        	call	_CLK_SYSCLKConfig
 286                     ; 100 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 286                     ; 101 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 288  0088 4b01          	push	#1
 289  008a 4b00          	push	#0
 290  008c ae01e1        	ldw	x,#481
 291  008f cd0000        	call	_CLK_ClockSwitchConfig
 293  0092 85            	popw	x
 294                     ; 103 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 296  0093 5f            	clrw	x
 297  0094 cd0000        	call	_CLK_PeripheralClockConfig
 299                     ; 104 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 301  0097 ae0100        	ldw	x,#256
 302  009a cd0000        	call	_CLK_PeripheralClockConfig
 304                     ; 105 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 306  009d ae1300        	ldw	x,#4864
 307  00a0 cd0000        	call	_CLK_PeripheralClockConfig
 309                     ; 106 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 311  00a3 ae1200        	ldw	x,#4608
 312  00a6 cd0000        	call	_CLK_PeripheralClockConfig
 314                     ; 107 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 316  00a9 ae0300        	ldw	x,#768
 317  00ac cd0000        	call	_CLK_PeripheralClockConfig
 319                     ; 108 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE); //Enable Timer 1
 321  00af ae0701        	ldw	x,#1793
 322  00b2 cd0000        	call	_CLK_PeripheralClockConfig
 324                     ; 109 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE); //Enable Timer 2
 326  00b5 ae0501        	ldw	x,#1281
 327  00b8 cd0000        	call	_CLK_PeripheralClockConfig
 329                     ; 110 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE); //Enable Timer 4 to use as reference for Delay Function
 331  00bb ae0401        	ldw	x,#1025
 333                     ; 112 }
 336  00be cc0000        	jp	_CLK_PeripheralClockConfig
 361                     ; 114 void gpio_setup(void)
 361                     ; 115 {
 362                     	switch	.text
 363  00c1               _gpio_setup:
 367                     ; 116 	GPIO_DeInit(GPIOB); //Prepare Port B for operation
 369  00c1 ae5005        	ldw	x,#20485
 370  00c4 cd0000        	call	_GPIO_DeInit
 372                     ; 117 	GPIO_DeInit(GPIOA); //Prepare Port A for operation
 374  00c7 ae5000        	ldw	x,#20480
 375  00ca cd0000        	call	_GPIO_DeInit
 377                     ; 118 	GPIO_DeInit(GPIOC); //Prepare Port C for operation
 379  00cd ae500a        	ldw	x,#20490
 380  00d0 cd0000        	call	_GPIO_DeInit
 382                     ; 122 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
 384  00d3 4b00          	push	#0
 385  00d5 4b02          	push	#2
 386  00d7 ae5000        	ldw	x,#20480
 387  00da cd0000        	call	_GPIO_Init
 389  00dd 85            	popw	x
 390                     ; 124 }
 393  00de 81            	ret	
 420                     ; 126 void tim4_init(void) //Timer Used to count milliseconds for delay function
 420                     ; 127 {
 421                     	switch	.text
 422  00df               _tim4_init:
 426                     ; 129 	TIM4_DeInit();
 428  00df cd0000        	call	_TIM4_DeInit
 430                     ; 130 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 432  00e2 ae077d        	ldw	x,#1917
 433  00e5 cd0000        	call	_TIM4_TimeBaseInit
 435                     ; 131 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 437  00e8 ae0101        	ldw	x,#257
 438  00eb cd0000        	call	_TIM4_ITConfig
 440                     ; 132 	TIM4_Cmd(ENABLE);
 442  00ee a601          	ld	a,#1
 444                     ; 134 }
 447  00f0 cc0000        	jp	_TIM4_Cmd
 491                     ; 136 void delay_ms(int delay)
 491                     ; 137 {
 492                     	switch	.text
 493  00f3               _delay_ms:
 495  00f3 89            	pushw	x
 496  00f4 89            	pushw	x
 497       00000002      OFST:	set	2
 500                     ; 138     int start = ms_count;
 502  00f5 be00          	ldw	x,_ms_count
 503  00f7 1f01          	ldw	(OFST-1,sp),x
 506  00f9               L521:
 507                     ; 139     while ((ms_count - start) < delay);
 509  00f9 be00          	ldw	x,_ms_count
 510  00fb 72f001        	subw	x,(OFST-1,sp)
 511  00fe 1303          	cpw	x,(OFST+1,sp)
 512  0100 2ff7          	jrslt	L521
 513                     ; 141 }
 516  0102 5b04          	addw	sp,#4
 517  0104 81            	ret	
 588                     .const:	section	.text
 589  0000               L041:
 590  0000 00010000      	dc.l	65536
 591                     ; 143 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler) //Set PWM frequency based on HSI speed, the HSI prescaler, and the timer prescaler
 591                     ; 144 {
 592                     	switch	.text
 593  0105               _set_pwm_frequency:
 595  0105 88            	push	a
 596  0106 520c          	subw	sp,#12
 597       0000000c      OFST:	set	12
 600                     ; 145 	uint32_t arr = 0; //Declared as uint32_t to avoid overflow issue during calculation
 602                     ; 146 	switch (hsi_prescaler)
 604  0108 7b12          	ld	a,(OFST+6,sp)
 606                     ; 162 			break;
 607  010a 270e          	jreq	L131
 608  010c a008          	sub	a,#8
 609  010e 270d          	jreq	L331
 610  0110 a008          	sub	a,#8
 611  0112 270d          	jreq	L531
 612  0114 a008          	sub	a,#8
 613  0116 270d          	jreq	L731
 614  0118 200f          	jra	L102
 615  011a               L131:
 616                     ; 148 		case 0x00:
 616                     ; 149 			hsi_prescaler = 1;
 618  011a 4c            	inc	a
 619                     ; 150 			break;
 621  011b 200a          	jp	LC001
 622  011d               L331:
 623                     ; 152 		case 0x08:
 623                     ; 153 			hsi_prescaler = 2;
 625  011d a602          	ld	a,#2
 626                     ; 154 			break;
 628  011f 2006          	jp	LC001
 629  0121               L531:
 630                     ; 156 		case 0x10:
 630                     ; 157 			hsi_prescaler = 4;
 632  0121 a604          	ld	a,#4
 633                     ; 158 			break;
 635  0123 2002          	jp	LC001
 636  0125               L731:
 637                     ; 160 		case 0x18:
 637                     ; 161 			hsi_prescaler = 8;
 639  0125 a608          	ld	a,#8
 640  0127               LC001:
 641  0127 6b12          	ld	(OFST+6,sp),a
 642                     ; 162 			break;
 644  0129               L102:
 645                     ; 165 	if (timer !=  1)
 647  0129 7b0d          	ld	a,(OFST+1,sp)
 648  012b 4a            	dec	a
 649  012c 275f          	jreq	L302
 650                     ; 167 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
 667  012e 2005          	jra	L132
 668  0130               L522:
 669                     ; 171 			frequency++;
 671  0130 1e10          	ldw	x,(OFST+4,sp)
 672  0132 5c            	incw	x
 673  0133 1f10          	ldw	(OFST+4,sp),x
 674                     ; 172 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
 691  0135               L132:
 693  0135 7b13          	ld	a,(OFST+7,sp)
 694  0137 5f            	clrw	x
 695  0138 97            	ld	xl,a
 696  0139 cd0000        	call	c_itof
 697  013c be02          	ldw	x,c_lreg+2
 698  013e 89            	pushw	x
 699  013f be00          	ldw	x,c_lreg
 700  0141 89            	pushw	x
 701  0142 ce000a        	ldw	x,L112+2
 702  0145 89            	pushw	x
 703  0146 ce0008        	ldw	x,L112
 704  0149 89            	pushw	x
 705  014a cd0000        	call	_pow
 706  014d 5b08          	addw	sp,#8
 707  014f 96            	ldw	x,sp
 708  0150 1c0005        	addw	x,#OFST-7
 709  0153 cd0000        	call	c_rtol
 710  0156 1e10          	ldw	x,(OFST+4,sp)
 711  0158 7b12          	ld	a,(OFST+6,sp)
 712  015a cd0000        	call	c_bmulx
 713  015d cd0000        	call	c_uitof
 714  0160 96            	ldw	x,sp
 715  0161 1c0005        	addw	x,#OFST-7
 716  0164 cd0000        	call	c_fmul
 717  0167 96            	ldw	x,sp
 718  0168 5c            	incw	x
 719  0169 ad5e          	call	LC002
 720  016b cd0000        	call	c_ltof
 721  016e 96            	ldw	x,sp
 722  016f 5c            	incw	x
 723  0170 cd0000        	call	c_fdiv
 724  0173 ae0004        	ldw	x,#L122
 725  0176 cd0000        	call	c_fsub
 726  0179 cd0000        	call	c_ftol
 727  017c 96            	ldw	x,sp
 728  017d 1c0009        	addw	x,#OFST-3
 729  0180 cd0000        	call	c_rtol
 730                     ; 169 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
 732  0183 96            	ldw	x,sp
 733  0184 ad51          	call	LC003
 735  0186 24a8          	jruge	L522
 737  0188               L532:
 738                     ; 187 	return (uint16_t)arr;
 740  0188 1e0b          	ldw	x,(OFST-1,sp)
 743  018a 5b0d          	addw	sp,#13
 744  018c 81            	ret	
 745  018d               L302:
 746                     ; 177 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
 748  018d 1e10          	ldw	x,(OFST+4,sp)
 759  018f 2005          	jra	L342
 760  0191               L732:
 761                     ; 181 			frequency++;
 763  0191 1e10          	ldw	x,(OFST+4,sp)
 764  0193 5c            	incw	x
 765  0194 1f10          	ldw	(OFST+4,sp),x
 766                     ; 182 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
 777  0196               L342:
 778  0196 7b12          	ld	a,(OFST+6,sp)
 779  0198 cd0000        	call	c_bmulx
 780  019b 7b13          	ld	a,(OFST+7,sp)
 781  019d 905f          	clrw	y
 782  019f 9097          	ld	yl,a
 783  01a1 905c          	incw	y
 784  01a3 cd0000        	call	c_imul
 785  01a6 cd0000        	call	c_uitolx
 786  01a9 96            	ldw	x,sp
 787  01aa 1c0005        	addw	x,#OFST-7
 788  01ad ad1a          	call	LC002
 789  01af 96            	ldw	x,sp
 790  01b0 1c0005        	addw	x,#OFST-7
 791  01b3 cd0000        	call	c_ldiv
 792  01b6 a601          	ld	a,#1
 793  01b8 cd0000        	call	c_lsbc
 794  01bb 96            	ldw	x,sp
 795  01bc 1c0009        	addw	x,#OFST-3
 796  01bf cd0000        	call	c_rtol
 797                     ; 179 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
 799  01c2 96            	ldw	x,sp
 800  01c3 ad12          	call	LC003
 802  01c5 24ca          	jruge	L732
 803  01c7 20bf          	jra	L532
 804  01c9               LC002:
 805  01c9 cd0000        	call	c_rtol
 806  01cc ae2400        	ldw	x,#9216
 807  01cf bf02          	ldw	c_lreg+2,x
 808  01d1 ae00f4        	ldw	x,#244
 809  01d4 bf00          	ldw	c_lreg,x
 810  01d6 81            	ret	
 811  01d7               LC003:
 812  01d7 1c0009        	addw	x,#OFST-3
 813  01da cd0000        	call	c_ltor
 815  01dd ae0000        	ldw	x,#L041
 816  01e0 cc0000        	jp	c_lcmp
 856                     ; 190 uint16_t tim2_init(void)
 856                     ; 191 {
 857                     	switch	.text
 858  01e3               _tim2_init:
 860  01e3 89            	pushw	x
 861       00000002      OFST:	set	2
 864                     ; 193 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
 866  01e4 4b00          	push	#0
 867  01e6 4b00          	push	#0
 868  01e8 ae4e20        	ldw	x,#20000
 869  01eb 89            	pushw	x
 870  01ec a602          	ld	a,#2
 871  01ee cd0105        	call	_set_pwm_frequency
 873  01f1 5b04          	addw	sp,#4
 874  01f3 1f01          	ldw	(OFST-1,sp),x
 876                     ; 194 	OCR = 0; //To force PWM Low to avoid driving things unintentionally when it's enabled
 878  01f5 5f            	clrw	x
 879  01f6 bf02          	ldw	_OCR,x
 880                     ; 196 	TIM2_DeInit(); //DeInit TIM2
 882  01f8 cd0000        	call	_TIM2_DeInit
 884                     ; 197 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
 886  01fb 1e01          	ldw	x,(OFST-1,sp)
 887  01fd 89            	pushw	x
 888  01fe 4f            	clr	a
 889  01ff cd0000        	call	_TIM2_TimeBaseInit
 891  0202 85            	popw	x
 892                     ; 198 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
 894  0203 4b00          	push	#0
 895  0205 be02          	ldw	x,_OCR
 896  0207 89            	pushw	x
 897  0208 ae6011        	ldw	x,#24593
 898  020b cd0000        	call	_TIM2_OC3Init
 900  020e 5b03          	addw	sp,#3
 901                     ; 199 	TIM2_Cmd(ENABLE);
 903  0210 a601          	ld	a,#1
 904  0212 cd0000        	call	_TIM2_Cmd
 906                     ; 201 	return ARR;
 908  0215 1e01          	ldw	x,(OFST-1,sp)
 911  0217 5b02          	addw	sp,#2
 912  0219 81            	ret	
 953                     ; 205 uint16_t tim1_init(void)
 953                     ; 206 {
 954                     	switch	.text
 955  021a               _tim1_init:
 957  021a 89            	pushw	x
 958       00000002      OFST:	set	2
 961                     ; 207 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
 963  021b 4b00          	push	#0
 964  021d 4b00          	push	#0
 965  021f ae4e20        	ldw	x,#20000
 966  0222 89            	pushw	x
 967  0223 a601          	ld	a,#1
 968  0225 cd0105        	call	_set_pwm_frequency
 970  0228 5b04          	addw	sp,#4
 971  022a 1f01          	ldw	(OFST-1,sp),x
 973                     ; 208 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
 975  022c 5f            	clrw	x
 976  022d bf02          	ldw	_OCR,x
 977                     ; 210 	TIM1_DeInit();
 979  022f cd0000        	call	_TIM1_DeInit
 981                     ; 211 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
 983  0232 4b00          	push	#0
 984  0234 1e02          	ldw	x,(OFST+0,sp)
 985  0236 89            	pushw	x
 986  0237 4b00          	push	#0
 987  0239 5f            	clrw	x
 988  023a cd0000        	call	_TIM1_TimeBaseInit
 990  023d 5b04          	addw	sp,#4
 991                     ; 212 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
 993  023f 4b00          	push	#0
 994  0241 4b00          	push	#0
 995  0243 4b88          	push	#136
 996  0245 4b00          	push	#0
 997  0247 be02          	ldw	x,_OCR
 998  0249 89            	pushw	x
 999  024a 4b00          	push	#0
1000  024c ae6011        	ldw	x,#24593
1001  024f cd0000        	call	_TIM1_OC3Init
1003  0252 5b07          	addw	sp,#7
1004                     ; 213 	TIM1_Cmd(ENABLE);
1006  0254 a601          	ld	a,#1
1007  0256 cd0000        	call	_TIM1_Cmd
1009                     ; 215 	TIM1_CtrlPWMOutputs(ENABLE);
1011  0259 a601          	ld	a,#1
1012  025b cd0000        	call	_TIM1_CtrlPWMOutputs
1014                     ; 217 }
1017  025e 85            	popw	x
1018  025f 81            	ret	
1055                     ; 219 void led_smooth_blink(void)
1055                     ; 220 {
1056                     	switch	.text
1057  0260               _led_smooth_blink:
1059  0260 5204          	subw	sp,#4
1060       00000004      OFST:	set	4
1063                     ; 222 	uint32_t duty_cycle_step = 0;
1065  0262 5f            	clrw	x
1066  0263 1f03          	ldw	(OFST-1,sp),x
1067  0265 1f01          	ldw	(OFST-3,sp),x
1070  0267 2012          	jra	L523
1071  0269               L123:
1072                     ; 226 		delay_ms(1);
1074  0269 ae0001        	ldw	x,#1
1075  026c cd00f3        	call	_delay_ms
1077                     ; 227 		TIM2_SetCompare3(duty_cycle_step);
1079  026f 1e03          	ldw	x,(OFST-1,sp)
1080  0271 cd0000        	call	_TIM2_SetCompare3
1082                     ; 228 		duty_cycle_step++;			
1084  0274 96            	ldw	x,sp
1085  0275 5c            	incw	x
1086  0276 a601          	ld	a,#1
1087  0278 cd0000        	call	c_lgadc
1090  027b               L523:
1091                     ; 224 	while (duty_cycle_step <= arr_tim2)
1093  027b be06          	ldw	x,_arr_tim2
1094  027d cd0000        	call	c_uitolx
1096  0280 96            	ldw	x,sp
1097  0281 5c            	incw	x
1098  0282 cd0000        	call	c_lcmp
1100  0285 24e2          	jruge	L123
1102  0287 2012          	jra	L333
1103  0289               L133:
1104                     ; 233 		delay_ms(1);
1106  0289 ae0001        	ldw	x,#1
1107  028c cd00f3        	call	_delay_ms
1109                     ; 234 		TIM2_SetCompare3(duty_cycle_step);
1111  028f 1e03          	ldw	x,(OFST-1,sp)
1112  0291 cd0000        	call	_TIM2_SetCompare3
1114                     ; 235 		duty_cycle_step--;
1116  0294 96            	ldw	x,sp
1117  0295 5c            	incw	x
1118  0296 a601          	ld	a,#1
1119  0298 cd0000        	call	c_lgsbc
1122  029b               L333:
1123                     ; 231 	while (duty_cycle_step)
1125  029b 96            	ldw	x,sp
1126  029c 5c            	incw	x
1127  029d cd0000        	call	c_lzmp
1129  02a0 26e7          	jrne	L133
1130                     ; 238 }
1133  02a2 5b04          	addw	sp,#4
1134  02a4 81            	ret	
1171                     ; 240 void pump_smooth_on_off(void)
1171                     ; 241 {
1172                     	switch	.text
1173  02a5               _pump_smooth_on_off:
1175  02a5 5204          	subw	sp,#4
1176       00000004      OFST:	set	4
1179                     ; 243 	uint32_t duty_cycle_step = 0;
1181  02a7 5f            	clrw	x
1182  02a8 1f03          	ldw	(OFST-1,sp),x
1183  02aa 1f01          	ldw	(OFST-3,sp),x
1186  02ac 2012          	jra	L163
1187  02ae               L553:
1188                     ; 247 		delay_ms(1);
1190  02ae ae0001        	ldw	x,#1
1191  02b1 cd00f3        	call	_delay_ms
1193                     ; 248 		TIM1_SetCompare3(duty_cycle_step);
1195  02b4 1e03          	ldw	x,(OFST-1,sp)
1196  02b6 cd0000        	call	_TIM1_SetCompare3
1198                     ; 249 		duty_cycle_step++;			
1200  02b9 96            	ldw	x,sp
1201  02ba 5c            	incw	x
1202  02bb a601          	ld	a,#1
1203  02bd cd0000        	call	c_lgadc
1206  02c0               L163:
1207                     ; 245 	while (duty_cycle_step <= arr_tim1)
1209  02c0 be04          	ldw	x,_arr_tim1
1210  02c2 cd0000        	call	c_uitolx
1212  02c5 96            	ldw	x,sp
1213  02c6 5c            	incw	x
1214  02c7 cd0000        	call	c_lcmp
1216  02ca 24e2          	jruge	L553
1218  02cc 2012          	jra	L763
1219  02ce               L563:
1220                     ; 254 		delay_ms(1);
1222  02ce ae0001        	ldw	x,#1
1223  02d1 cd00f3        	call	_delay_ms
1225                     ; 255 		TIM1_SetCompare3(duty_cycle_step);
1227  02d4 1e03          	ldw	x,(OFST-1,sp)
1228  02d6 cd0000        	call	_TIM1_SetCompare3
1230                     ; 256 		duty_cycle_step--;
1232  02d9 96            	ldw	x,sp
1233  02da 5c            	incw	x
1234  02db a601          	ld	a,#1
1235  02dd cd0000        	call	c_lgsbc
1238  02e0               L763:
1239                     ; 252 	while (duty_cycle_step)
1241  02e0 96            	ldw	x,sp
1242  02e1 5c            	incw	x
1243  02e2 cd0000        	call	c_lzmp
1245  02e5 26e7          	jrne	L563
1246                     ; 259 }
1249  02e7 5b04          	addw	sp,#4
1250  02e9 81            	ret	
1310                     	xdef	_main
1311                     	xdef	_pump_smooth_on_off
1312                     	xdef	_led_smooth_blink
1313                     	xdef	_tim1_init
1314                     	xdef	_tim2_init
1315                     	xdef	_set_pwm_frequency
1316                     	xdef	_delay_ms
1317                     	xdef	_tim4_init
1318                     	xdef	_gpio_setup
1319                     	xdef	_clock_setup
1320                     	xdef	_press_count
1321                     	xdef	_arr_tim2
1322                     	xdef	_arr_tim1
1323                     	xdef	_OCR
1324                     	xref	_pow
1325                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1326                     	xdef	_ms_count
1327                     	xref	_TIM4_ClearITPendingBit
1328                     	xref	_TIM4_ITConfig
1329                     	xref	_TIM4_Cmd
1330                     	xref	_TIM4_TimeBaseInit
1331                     	xref	_TIM4_DeInit
1332                     	xref	_TIM2_SetCompare3
1333                     	xref	_TIM2_Cmd
1334                     	xref	_TIM2_OC3Init
1335                     	xref	_TIM2_TimeBaseInit
1336                     	xref	_TIM2_DeInit
1337                     	xref	_TIM1_SetCompare3
1338                     	xref	_TIM1_CtrlPWMOutputs
1339                     	xref	_TIM1_Cmd
1340                     	xref	_TIM1_OC3Init
1341                     	xref	_TIM1_TimeBaseInit
1342                     	xref	_TIM1_DeInit
1343                     	xref	_GPIO_ReadInputPin
1344                     	xref	_GPIO_Init
1345                     	xref	_GPIO_DeInit
1346                     	xref	_CLK_GetFlagStatus
1347                     	xref	_CLK_SYSCLKConfig
1348                     	xref	_CLK_HSIPrescalerConfig
1349                     	xref	_CLK_ClockSwitchConfig
1350                     	xref	_CLK_PeripheralClockConfig
1351                     	xref	_CLK_ClockSwitchCmd
1352                     	xref	_CLK_LSICmd
1353                     	xref	_CLK_HSICmd
1354                     	xref	_CLK_HSECmd
1355                     	xref	_CLK_DeInit
1356                     	switch	.const
1357  0004               L122:
1358  0004 3f800000      	dc.w	16256,0
1359  0008               L112:
1360  0008 40000000      	dc.w	16384,0
1361                     	xref.b	c_lreg
1362                     	xref.b	c_x
1363                     	xref.b	c_y
1383                     	xref	c_lzmp
1384                     	xref	c_lgsbc
1385                     	xref	c_lgadc
1386                     	xref	c_lsbc
1387                     	xref	c_ldiv
1388                     	xref	c_uitolx
1389                     	xref	c_imul
1390                     	xref	c_lcmp
1391                     	xref	c_ltor
1392                     	xref	c_ftol
1393                     	xref	c_fsub
1394                     	xref	c_fdiv
1395                     	xref	c_fmul
1396                     	xref	c_rtol
1397                     	xref	c_itof
1398                     	xref	c_uitof
1399                     	xref	c_bmulx
1400                     	xref	c_ltof
1401                     	end
