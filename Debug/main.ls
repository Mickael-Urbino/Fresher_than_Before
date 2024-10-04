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
  30  0009               _duty_cycle_step:
  31  0009 0000          	dc.w	0
  32  000b               _current_state:
  33  000b 00            	dc.b	0
  65                     ; 60 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler,23) {
  66                     	switch	.text
  67  0000               f_TIM4_UPD_OVF_IRQHandler:
  69  0000 8a            	push	cc
  70  0001 84            	pop	a
  71  0002 a4bf          	and	a,#191
  72  0004 88            	push	a
  73  0005 86            	pop	cc
  74  0006 3b0002        	push	c_x+2
  75  0009 be00          	ldw	x,c_x
  76  000b 89            	pushw	x
  77  000c 3b0002        	push	c_y+2
  78  000f be00          	ldw	x,c_y
  79  0011 89            	pushw	x
  82                     ; 61     ms_count++; 
  84  0012 be00          	ldw	x,_ms_count
  85  0014 5c            	incw	x
  86  0015 bf00          	ldw	_ms_count,x
  87                     ; 62     TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  89  0017 a601          	ld	a,#1
  90  0019 cd0000        	call	_TIM4_ClearITPendingBit
  92                     ; 63 }
  95  001c 85            	popw	x
  96  001d bf00          	ldw	c_y,x
  97  001f 320002        	pop	c_y+2
  98  0022 85            	popw	x
  99  0023 bf00          	ldw	c_x,x
 100  0025 320002        	pop	c_x+2
 101  0028 80            	iret	
 127                     ; 65 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
 128                     	switch	.text
 129  0029               f_EXTI_PORTD_IRQHandler:
 131  0029 8a            	push	cc
 132  002a 84            	pop	a
 133  002b a4bf          	and	a,#191
 134  002d 88            	push	a
 135  002e 86            	pop	cc
 136  002f 3b0002        	push	c_x+2
 137  0032 be00          	ldw	x,c_x
 138  0034 89            	pushw	x
 139  0035 3b0002        	push	c_y+2
 140  0038 be00          	ldw	x,c_y
 141  003a 89            	pushw	x
 144                     ; 67 	delay_ms(50);
 146  003b ae0032        	ldw	x,#50
 147  003e cd01b9        	call	_delay_ms
 149                     ; 69 	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0)
 151  0041 4b40          	push	#64
 152  0043 ae500f        	ldw	x,#20495
 153  0046 cd0000        	call	_GPIO_ReadInputPin
 155  0049 5b01          	addw	sp,#1
 156  004b 4d            	tnz	a
 157  004c 2602          	jrne	L13
 158                     ; 71 		 press_count++;
 160  004e 3c08          	inc	_press_count
 161  0050               L13:
 162                     ; 73 }
 165  0050 85            	popw	x
 166  0051 bf00          	ldw	c_y,x
 167  0053 320002        	pop	c_y+2
 168  0056 85            	popw	x
 169  0057 bf00          	ldw	c_x,x
 170  0059 320002        	pop	c_x+2
 171  005c 80            	iret	
 212                     ; 76 main()
 212                     ; 77 {
 214                     	switch	.text
 215  005d               _main:
 219                     ; 78 	clock_setup();
 221  005d cd0104        	call	_clock_setup
 223                     ; 79 	EXTI_setup();
 225  0060 cd018d        	call	_EXTI_setup
 227                     ; 81 	enableInterrupts();
 230  0063 9a            	rim	
 232                     ; 89 	tim4_init();
 235  0064 cd01a5        	call	_tim4_init
 237                     ; 90 	delay_ms(5000);
 239  0067 ae1388        	ldw	x,#5000
 240  006a cd01b9        	call	_delay_ms
 242                     ; 92 	gpio_setup();	
 244  006d cd0164        	call	_gpio_setup
 246                     ; 94 	arr_tim1 = tim1_init();	
 248  0070 cd02e0        	call	_tim1_init
 250  0073 bf04          	ldw	_arr_tim1,x
 251                     ; 95 	arr_tim2 = tim2_init();	
 253  0075 cd02a9        	call	_tim2_init
 255  0078 bf06          	ldw	_arr_tim2,x
 256  007a               L55:
 257                     ; 101 		switch (current_state)
 259  007a b60b          	ld	a,_current_state
 261                     ; 160 				break;
 262  007c 270e          	jreq	L33
 263  007e 4a            	dec	a
 264  007f 271d          	jreq	L53
 265  0081 4a            	dec	a
 266  0082 2733          	jreq	L73
 267  0084 4a            	dec	a
 268  0085 2746          	jreq	L14
 269  0087 4a            	dec	a
 270  0088 275a          	jreq	L34
 271  008a 20ee          	jra	L55
 272  008c               L33:
 273                     ; 103 			case STATE_SLEEP:
 273                     ; 104 			
 273                     ; 105 				led_smooth_blink();
 275  008c cd0326        	call	_led_smooth_blink
 277                     ; 106 				pump_off(duty_cycle_step);
 279  008f be09          	ldw	x,_duty_cycle_step
 280  0091 cd03bf        	call	_pump_off
 282                     ; 108 				if (press_count > 0)
 284  0094 3d08          	tnz	_press_count
 285  0096 27e2          	jreq	L55
 286                     ; 110 					current_state = STATE_IDLE;
 288  0098 3501000b      	mov	_current_state,#1
 289  009c 20dc          	jra	L55
 290  009e               L53:
 291                     ; 115 			case STATE_IDLE:
 291                     ; 116 			
 291                     ; 117 				TIM2_SetCompare3(arr_tim2/100);
 293  009e be06          	ldw	x,_arr_tim2
 294  00a0 a664          	ld	a,#100
 295  00a2 62            	div	x,a
 296  00a3 cd0000        	call	_TIM2_SetCompare3
 298                     ; 118 				pump_off(duty_cycle_step);
 300  00a6 be09          	ldw	x,_duty_cycle_step
 301  00a8 cd03bf        	call	_pump_off
 303                     ; 120 				if (press_count > 1)
 305  00ab b608          	ld	a,_press_count
 306  00ad a102          	cp	a,#2
 307  00af 25c9          	jrult	L55
 308                     ; 122 					current_state = STATE_FULL_SPEED;
 310  00b1 3502000b      	mov	_current_state,#2
 311  00b5 20c3          	jra	L55
 312  00b7               L73:
 313                     ; 127 			case STATE_FULL_SPEED:
 313                     ; 128 			
 313                     ; 129 				TIM2_SetCompare3(arr_tim2);
 315  00b7 be06          	ldw	x,_arr_tim2
 316  00b9 cd0000        	call	_TIM2_SetCompare3
 318                     ; 130 				pump_max_speed(duty_cycle_step);
 320  00bc be09          	ldw	x,_duty_cycle_step
 321  00be cd0386        	call	_pump_max_speed
 323                     ; 132 				if (press_count > 2)
 325  00c1 b608          	ld	a,_press_count
 326  00c3 a103          	cp	a,#3
 327  00c5 25b3          	jrult	L55
 328                     ; 134 					current_state = STATE_LOW_SPEED;
 330  00c7 3503000b      	mov	_current_state,#3
 331  00cb 20ad          	jra	L55
 332  00cd               L14:
 333                     ; 139 			case STATE_LOW_SPEED:
 333                     ; 140 			
 333                     ; 141 				TIM2_SetCompare3(arr_tim2/2);
 335  00cd be06          	ldw	x,_arr_tim2
 336  00cf 54            	srlw	x
 337  00d0 cd0000        	call	_TIM2_SetCompare3
 339                     ; 142 				pump_low_speed(duty_cycle_step);
 341  00d3 be09          	ldw	x,_duty_cycle_step
 342  00d5 cd03a0        	call	_pump_low_speed
 344                     ; 144 				if (press_count > 3)
 346  00d8 b608          	ld	a,_press_count
 347  00da a104          	cp	a,#4
 348  00dc 259c          	jrult	L55
 349                     ; 146 					current_state = STATE_PULSE;			
 351  00de 3504000b      	mov	_current_state,#4
 352  00e2 2096          	jra	L55
 353  00e4               L34:
 354                     ; 150 			case STATE_PULSE:
 354                     ; 151 				TIM2_SetCompare3(arr_tim2/2);
 356  00e4 be06          	ldw	x,_arr_tim2
 357  00e6 54            	srlw	x
 358  00e7 cd0000        	call	_TIM2_SetCompare3
 360                     ; 152 				pump_smooth_on_off();
 362  00ea cd0356        	call	_pump_smooth_on_off
 364                     ; 153 				TIM2_SetCompare3(0);
 366  00ed 5f            	clrw	x
 367  00ee cd0000        	call	_TIM2_SetCompare3
 369                     ; 154 				delay_ms(500);
 371  00f1 ae01f4        	ldw	x,#500
 372  00f4 cd01b9        	call	_delay_ms
 374                     ; 155 				if (press_count > 4)
 376  00f7 b608          	ld	a,_press_count
 377  00f9 a105          	cp	a,#5
 378  00fb 25e5          	jrult	L55
 379                     ; 157 					current_state = STATE_SLEEP;
 381  00fd 3f0b          	clr	_current_state
 382                     ; 158 					press_count = 0;
 384  00ff 3f08          	clr	_press_count
 385  0101 cc007a        	jra	L55
 386                     ; 160 				break;
 419                     ; 166 void clock_setup(void)
 419                     ; 167 {
 420                     	switch	.text
 421  0104               _clock_setup:
 425                     ; 168 	CLK_DeInit();
 427  0104 cd0000        	call	_CLK_DeInit
 429                     ; 170 	CLK_HSECmd(DISABLE);
 431  0107 4f            	clr	a
 432  0108 cd0000        	call	_CLK_HSECmd
 434                     ; 171 	CLK_LSICmd(DISABLE);
 436  010b 4f            	clr	a
 437  010c cd0000        	call	_CLK_LSICmd
 439                     ; 172 	CLK_HSICmd(ENABLE); //Enable HSI clock (16MHz)
 441  010f a601          	ld	a,#1
 442  0111 cd0000        	call	_CLK_HSICmd
 445  0114               L111:
 446                     ; 174 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 448  0114 ae0102        	ldw	x,#258
 449  0117 cd0000        	call	_CLK_GetFlagStatus
 451  011a 4d            	tnz	a
 452  011b 27f7          	jreq	L111
 453                     ; 176 	CLK_ClockSwitchCmd(ENABLE);
 455  011d a601          	ld	a,#1
 456  011f cd0000        	call	_CLK_ClockSwitchCmd
 458                     ; 177 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Peripheral Clock is 16MHz
 460  0122 4f            	clr	a
 461  0123 cd0000        	call	_CLK_HSIPrescalerConfig
 463                     ; 178 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1); //CPU Clock is 16MHz
 465  0126 a680          	ld	a,#128
 466  0128 cd0000        	call	_CLK_SYSCLKConfig
 468                     ; 180 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 468                     ; 181 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 470  012b 4b01          	push	#1
 471  012d 4b00          	push	#0
 472  012f ae01e1        	ldw	x,#481
 473  0132 cd0000        	call	_CLK_ClockSwitchConfig
 475  0135 85            	popw	x
 476                     ; 183 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 478  0136 5f            	clrw	x
 479  0137 cd0000        	call	_CLK_PeripheralClockConfig
 481                     ; 184 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 483  013a ae0100        	ldw	x,#256
 484  013d cd0000        	call	_CLK_PeripheralClockConfig
 486                     ; 185 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 488  0140 ae1300        	ldw	x,#4864
 489  0143 cd0000        	call	_CLK_PeripheralClockConfig
 491                     ; 186 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 493  0146 ae1200        	ldw	x,#4608
 494  0149 cd0000        	call	_CLK_PeripheralClockConfig
 496                     ; 187 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 498  014c ae0300        	ldw	x,#768
 499  014f cd0000        	call	_CLK_PeripheralClockConfig
 501                     ; 188 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE); //Enable Timer 1
 503  0152 ae0701        	ldw	x,#1793
 504  0155 cd0000        	call	_CLK_PeripheralClockConfig
 506                     ; 189 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE); //Enable Timer 2
 508  0158 ae0501        	ldw	x,#1281
 509  015b cd0000        	call	_CLK_PeripheralClockConfig
 511                     ; 190 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE); //Enable Timer 4 to use as reference for Delay Function
 513  015e ae0401        	ldw	x,#1025
 515                     ; 192 }
 518  0161 cc0000        	jp	_CLK_PeripheralClockConfig
 543                     ; 195 void gpio_setup(void)
 543                     ; 196 {
 544                     	switch	.text
 545  0164               _gpio_setup:
 549                     ; 197 	GPIO_DeInit(GPIOA); //Prepare Port A for operation
 551  0164 ae5000        	ldw	x,#20480
 552  0167 cd0000        	call	_GPIO_DeInit
 554                     ; 198 	GPIO_DeInit(GPIOB); //Prepare Port B for operation	
 556  016a ae5005        	ldw	x,#20485
 557  016d cd0000        	call	_GPIO_DeInit
 559                     ; 199 	GPIO_DeInit(GPIOD); //Prepare Port D for operation
 561  0170 ae500f        	ldw	x,#20495
 562  0173 cd0000        	call	_GPIO_DeInit
 564                     ; 201 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);
 566  0176 4b20          	push	#32
 567  0178 4b40          	push	#64
 568  017a ae500f        	ldw	x,#20495
 569  017d cd0000        	call	_GPIO_Init
 571  0180 85            	popw	x
 572                     ; 202 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 574  0181 4be0          	push	#224
 575  0183 4b10          	push	#16
 576  0185 ae5005        	ldw	x,#20485
 577  0188 cd0000        	call	_GPIO_Init
 579  018b 85            	popw	x
 580                     ; 203 }
 583  018c 81            	ret	
 612                     ; 205 void EXTI_setup(void)
 612                     ; 206 {
 613                     	switch	.text
 614  018d               _EXTI_setup:
 618                     ; 207 	ITC_DeInit();
 620  018d cd0000        	call	_ITC_DeInit
 622                     ; 208 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 624  0190 ae0602        	ldw	x,#1538
 625  0193 cd0000        	call	_ITC_SetSoftwarePriority
 627                     ; 210 	EXTI_DeInit();
 629  0196 cd0000        	call	_EXTI_DeInit
 631                     ; 212 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 633  0199 ae0302        	ldw	x,#770
 634  019c cd0000        	call	_EXTI_SetExtIntSensitivity
 636                     ; 213 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 638  019f 4f            	clr	a
 639  01a0 cd0000        	call	_EXTI_SetTLISensitivity
 641                     ; 215 	enableInterrupts();
 644  01a3 9a            	rim	
 646                     ; 216 }
 650  01a4 81            	ret	
 677                     ; 218 void tim4_init(void) //Timer Used to count milliseconds for delay function
 677                     ; 219 {
 678                     	switch	.text
 679  01a5               _tim4_init:
 683                     ; 221 	TIM4_DeInit();
 685  01a5 cd0000        	call	_TIM4_DeInit
 687                     ; 222 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 689  01a8 ae077d        	ldw	x,#1917
 690  01ab cd0000        	call	_TIM4_TimeBaseInit
 692                     ; 223 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 694  01ae ae0101        	ldw	x,#257
 695  01b1 cd0000        	call	_TIM4_ITConfig
 697                     ; 224 	TIM4_Cmd(ENABLE);
 699  01b4 a601          	ld	a,#1
 701                     ; 226 }
 704  01b6 cc0000        	jp	_TIM4_Cmd
 748                     ; 228 void delay_ms(int delay)
 748                     ; 229 {
 749                     	switch	.text
 750  01b9               _delay_ms:
 752  01b9 89            	pushw	x
 753  01ba 89            	pushw	x
 754       00000002      OFST:	set	2
 757                     ; 230     int start = ms_count;
 759  01bb be00          	ldw	x,_ms_count
 760  01bd 1f01          	ldw	(OFST-1,sp),x
 763  01bf               L371:
 764                     ; 231     while ((ms_count - start) < delay);
 766  01bf be00          	ldw	x,_ms_count
 767  01c1 72f001        	subw	x,(OFST-1,sp)
 768  01c4 1303          	cpw	x,(OFST+1,sp)
 769  01c6 2ff7          	jrslt	L371
 770                     ; 233 }
 773  01c8 5b04          	addw	sp,#4
 774  01ca 81            	ret	
 845                     .const:	section	.text
 846  0000               L402:
 847  0000 00010000      	dc.l	65536
 848                     ; 235 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler) //Set PWM frequency based on HSI speed, the HSI prescaler, and the timer prescaler
 848                     ; 236 {
 849                     	switch	.text
 850  01cb               _set_pwm_frequency:
 852  01cb 88            	push	a
 853  01cc 520c          	subw	sp,#12
 854       0000000c      OFST:	set	12
 857                     ; 237 	uint32_t arr = 0; //Declared as uint32_t to avoid overflow issue during calculation
 859                     ; 238 	switch (hsi_prescaler)
 861  01ce 7b12          	ld	a,(OFST+6,sp)
 863                     ; 254 			break;
 864  01d0 270e          	jreq	L771
 865  01d2 a008          	sub	a,#8
 866  01d4 270d          	jreq	L102
 867  01d6 a008          	sub	a,#8
 868  01d8 270d          	jreq	L302
 869  01da a008          	sub	a,#8
 870  01dc 270d          	jreq	L502
 871  01de 200f          	jra	L742
 872  01e0               L771:
 873                     ; 240 		case 0x00:
 873                     ; 241 			hsi_prescaler = 1;
 875  01e0 4c            	inc	a
 876                     ; 242 			break;
 878  01e1 200a          	jp	LC001
 879  01e3               L102:
 880                     ; 244 		case 0x08:
 880                     ; 245 			hsi_prescaler = 2;
 882  01e3 a602          	ld	a,#2
 883                     ; 246 			break;
 885  01e5 2006          	jp	LC001
 886  01e7               L302:
 887                     ; 248 		case 0x10:
 887                     ; 249 			hsi_prescaler = 4;
 889  01e7 a604          	ld	a,#4
 890                     ; 250 			break;
 892  01e9 2002          	jp	LC001
 893  01eb               L502:
 894                     ; 252 		case 0x18:
 894                     ; 253 			hsi_prescaler = 8;
 896  01eb a608          	ld	a,#8
 897  01ed               LC001:
 898  01ed 6b12          	ld	(OFST+6,sp),a
 899                     ; 254 			break;
 901  01ef               L742:
 902                     ; 257 	if (timer !=  1)
 904  01ef 7b0d          	ld	a,(OFST+1,sp)
 905  01f1 4a            	dec	a
 906  01f2 275f          	jreq	L152
 907                     ; 259 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
 924  01f4 2005          	jra	L772
 925  01f6               L372:
 926                     ; 263 			frequency++;
 928  01f6 1e10          	ldw	x,(OFST+4,sp)
 929  01f8 5c            	incw	x
 930  01f9 1f10          	ldw	(OFST+4,sp),x
 931                     ; 264 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
 948  01fb               L772:
 950  01fb 7b13          	ld	a,(OFST+7,sp)
 951  01fd 5f            	clrw	x
 952  01fe 97            	ld	xl,a
 953  01ff cd0000        	call	c_itof
 954  0202 be02          	ldw	x,c_lreg+2
 955  0204 89            	pushw	x
 956  0205 be00          	ldw	x,c_lreg
 957  0207 89            	pushw	x
 958  0208 ce000a        	ldw	x,L752+2
 959  020b 89            	pushw	x
 960  020c ce0008        	ldw	x,L752
 961  020f 89            	pushw	x
 962  0210 cd0000        	call	_pow
 963  0213 5b08          	addw	sp,#8
 964  0215 96            	ldw	x,sp
 965  0216 1c0005        	addw	x,#OFST-7
 966  0219 cd0000        	call	c_rtol
 967  021c 1e10          	ldw	x,(OFST+4,sp)
 968  021e 7b12          	ld	a,(OFST+6,sp)
 969  0220 cd0000        	call	c_bmulx
 970  0223 cd0000        	call	c_uitof
 971  0226 96            	ldw	x,sp
 972  0227 1c0005        	addw	x,#OFST-7
 973  022a cd0000        	call	c_fmul
 974  022d 96            	ldw	x,sp
 975  022e 5c            	incw	x
 976  022f ad5e          	call	LC002
 977  0231 cd0000        	call	c_ltof
 978  0234 96            	ldw	x,sp
 979  0235 5c            	incw	x
 980  0236 cd0000        	call	c_fdiv
 981  0239 ae0004        	ldw	x,#L762
 982  023c cd0000        	call	c_fsub
 983  023f cd0000        	call	c_ftol
 984  0242 96            	ldw	x,sp
 985  0243 1c0009        	addw	x,#OFST-3
 986  0246 cd0000        	call	c_rtol
 987                     ; 261 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
 989  0249 96            	ldw	x,sp
 990  024a ad51          	call	LC003
 992  024c 24a8          	jruge	L372
 994  024e               L303:
 995                     ; 279 	return (uint16_t)arr;
 997  024e 1e0b          	ldw	x,(OFST-1,sp)
1000  0250 5b0d          	addw	sp,#13
1001  0252 81            	ret	
1002  0253               L152:
1003                     ; 269 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1005  0253 1e10          	ldw	x,(OFST+4,sp)
1016  0255 2005          	jra	L113
1017  0257               L503:
1018                     ; 273 			frequency++;
1020  0257 1e10          	ldw	x,(OFST+4,sp)
1021  0259 5c            	incw	x
1022  025a 1f10          	ldw	(OFST+4,sp),x
1023                     ; 274 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1034  025c               L113:
1035  025c 7b12          	ld	a,(OFST+6,sp)
1036  025e cd0000        	call	c_bmulx
1037  0261 7b13          	ld	a,(OFST+7,sp)
1038  0263 905f          	clrw	y
1039  0265 9097          	ld	yl,a
1040  0267 905c          	incw	y
1041  0269 cd0000        	call	c_imul
1042  026c cd0000        	call	c_uitolx
1043  026f 96            	ldw	x,sp
1044  0270 1c0005        	addw	x,#OFST-7
1045  0273 ad1a          	call	LC002
1046  0275 96            	ldw	x,sp
1047  0276 1c0005        	addw	x,#OFST-7
1048  0279 cd0000        	call	c_ldiv
1049  027c a601          	ld	a,#1
1050  027e cd0000        	call	c_lsbc
1051  0281 96            	ldw	x,sp
1052  0282 1c0009        	addw	x,#OFST-3
1053  0285 cd0000        	call	c_rtol
1054                     ; 271 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1056  0288 96            	ldw	x,sp
1057  0289 ad12          	call	LC003
1059  028b 24ca          	jruge	L503
1060  028d 20bf          	jra	L303
1061  028f               LC002:
1062  028f cd0000        	call	c_rtol
1063  0292 ae2400        	ldw	x,#9216
1064  0295 bf02          	ldw	c_lreg+2,x
1065  0297 ae00f4        	ldw	x,#244
1066  029a bf00          	ldw	c_lreg,x
1067  029c 81            	ret	
1068  029d               LC003:
1069  029d 1c0009        	addw	x,#OFST-3
1070  02a0 cd0000        	call	c_ltor
1072  02a3 ae0000        	ldw	x,#L402
1073  02a6 cc0000        	jp	c_lcmp
1113                     ; 282 uint16_t tim2_init(void)
1113                     ; 283 {
1114                     	switch	.text
1115  02a9               _tim2_init:
1117  02a9 89            	pushw	x
1118       00000002      OFST:	set	2
1121                     ; 285 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1123  02aa 4b00          	push	#0
1124  02ac 4b00          	push	#0
1125  02ae ae4e20        	ldw	x,#20000
1126  02b1 89            	pushw	x
1127  02b2 a602          	ld	a,#2
1128  02b4 cd01cb        	call	_set_pwm_frequency
1130  02b7 5b04          	addw	sp,#4
1131  02b9 1f01          	ldw	(OFST-1,sp),x
1133                     ; 286 	OCR = 0; //To force PWM Low to avoid driving things unintentionally when it's enabled
1135  02bb 5f            	clrw	x
1136  02bc bf02          	ldw	_OCR,x
1137                     ; 288 	TIM2_DeInit(); //DeInit TIM2
1139  02be cd0000        	call	_TIM2_DeInit
1141                     ; 289 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1143  02c1 1e01          	ldw	x,(OFST-1,sp)
1144  02c3 89            	pushw	x
1145  02c4 4f            	clr	a
1146  02c5 cd0000        	call	_TIM2_TimeBaseInit
1148  02c8 85            	popw	x
1149                     ; 290 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
1151  02c9 4b00          	push	#0
1152  02cb be02          	ldw	x,_OCR
1153  02cd 89            	pushw	x
1154  02ce ae6011        	ldw	x,#24593
1155  02d1 cd0000        	call	_TIM2_OC3Init
1157  02d4 5b03          	addw	sp,#3
1158                     ; 291 	TIM2_Cmd(ENABLE);
1160  02d6 a601          	ld	a,#1
1161  02d8 cd0000        	call	_TIM2_Cmd
1163                     ; 293 	return ARR;
1165  02db 1e01          	ldw	x,(OFST-1,sp)
1168  02dd 5b02          	addw	sp,#2
1169  02df 81            	ret	
1210                     ; 297 uint16_t tim1_init(void)
1210                     ; 298 {
1211                     	switch	.text
1212  02e0               _tim1_init:
1214  02e0 89            	pushw	x
1215       00000002      OFST:	set	2
1218                     ; 299 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1220  02e1 4b00          	push	#0
1221  02e3 4b00          	push	#0
1222  02e5 ae4e20        	ldw	x,#20000
1223  02e8 89            	pushw	x
1224  02e9 a601          	ld	a,#1
1225  02eb cd01cb        	call	_set_pwm_frequency
1227  02ee 5b04          	addw	sp,#4
1228  02f0 1f01          	ldw	(OFST-1,sp),x
1230                     ; 300 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1232  02f2 5f            	clrw	x
1233  02f3 bf02          	ldw	_OCR,x
1234                     ; 302 	TIM1_DeInit();
1236  02f5 cd0000        	call	_TIM1_DeInit
1238                     ; 303 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1240  02f8 4b00          	push	#0
1241  02fa 1e02          	ldw	x,(OFST+0,sp)
1242  02fc 89            	pushw	x
1243  02fd 4b00          	push	#0
1244  02ff 5f            	clrw	x
1245  0300 cd0000        	call	_TIM1_TimeBaseInit
1247  0303 5b04          	addw	sp,#4
1248                     ; 304 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1250  0305 4b00          	push	#0
1251  0307 4b00          	push	#0
1252  0309 4b88          	push	#136
1253  030b 4b00          	push	#0
1254  030d be02          	ldw	x,_OCR
1255  030f 89            	pushw	x
1256  0310 4b00          	push	#0
1257  0312 ae6011        	ldw	x,#24593
1258  0315 cd0000        	call	_TIM1_OC3Init
1260  0318 5b07          	addw	sp,#7
1261                     ; 305 	TIM1_Cmd(ENABLE);
1263  031a a601          	ld	a,#1
1264  031c cd0000        	call	_TIM1_Cmd
1266                     ; 307 	TIM1_CtrlPWMOutputs(ENABLE);
1268  031f a601          	ld	a,#1
1269  0321 cd0000        	call	_TIM1_CtrlPWMOutputs
1271                     ; 309 }
1274  0324 85            	popw	x
1275  0325 81            	ret	
1312                     ; 311 void led_smooth_blink(void)
1312                     ; 312 {
1313                     	switch	.text
1314  0326               _led_smooth_blink:
1316  0326 89            	pushw	x
1317       00000002      OFST:	set	2
1320                     ; 314 	uint16_t duty_cycle_step = 0;
1322  0327 5f            	clrw	x
1324  0328 200e          	jra	L373
1325  032a               L763:
1326                     ; 318 		delay_ms(1);
1328  032a ae0001        	ldw	x,#1
1329  032d cd01b9        	call	_delay_ms
1331                     ; 319 		TIM2_SetCompare3(duty_cycle_step);
1333  0330 1e01          	ldw	x,(OFST-1,sp)
1334  0332 cd0000        	call	_TIM2_SetCompare3
1336                     ; 320 		duty_cycle_step++;			
1338  0335 1e01          	ldw	x,(OFST-1,sp)
1339  0337 5c            	incw	x
1340  0338               L373:
1341  0338 1f01          	ldw	(OFST-1,sp),x
1343                     ; 316 	while (duty_cycle_step <= arr_tim2)
1345  033a b306          	cpw	x,_arr_tim2
1346  033c 23ec          	jrule	L763
1348  033e 2010          	jra	L104
1349  0340               L773:
1350                     ; 325 		delay_ms(1);
1352  0340 ae0001        	ldw	x,#1
1353  0343 cd01b9        	call	_delay_ms
1355                     ; 326 		TIM2_SetCompare3(duty_cycle_step);
1357  0346 1e01          	ldw	x,(OFST-1,sp)
1358  0348 cd0000        	call	_TIM2_SetCompare3
1360                     ; 327 		duty_cycle_step--;
1362  034b 1e01          	ldw	x,(OFST-1,sp)
1363  034d 5a            	decw	x
1364  034e 1f01          	ldw	(OFST-1,sp),x
1366  0350               L104:
1367                     ; 323 	while (duty_cycle_step)
1369  0350 1e01          	ldw	x,(OFST-1,sp)
1370  0352 26ec          	jrne	L773
1371                     ; 330 }
1374  0354 85            	popw	x
1375  0355 81            	ret	
1412                     ; 332 void pump_smooth_on_off(void)
1412                     ; 333 {
1413                     	switch	.text
1414  0356               _pump_smooth_on_off:
1416  0356 89            	pushw	x
1417       00000002      OFST:	set	2
1420                     ; 335 	uint16_t duty_cycle_step = 0;
1422  0357 5f            	clrw	x
1424  0358 200e          	jra	L724
1425  035a               L324:
1426                     ; 339 		delay_ms(1);
1428  035a ae0001        	ldw	x,#1
1429  035d cd01b9        	call	_delay_ms
1431                     ; 340 		TIM1_SetCompare3(duty_cycle_step);
1433  0360 1e01          	ldw	x,(OFST-1,sp)
1434  0362 cd0000        	call	_TIM1_SetCompare3
1436                     ; 341 		duty_cycle_step++;			
1438  0365 1e01          	ldw	x,(OFST-1,sp)
1439  0367 5c            	incw	x
1440  0368               L724:
1441  0368 1f01          	ldw	(OFST-1,sp),x
1443                     ; 337 	while (duty_cycle_step <= arr_tim1)
1445  036a b304          	cpw	x,_arr_tim1
1446  036c 23ec          	jrule	L324
1448  036e 2010          	jra	L534
1449  0370               L334:
1450                     ; 346 		delay_ms(1);
1452  0370 ae0001        	ldw	x,#1
1453  0373 cd01b9        	call	_delay_ms
1455                     ; 347 		TIM1_SetCompare3(duty_cycle_step);
1457  0376 1e01          	ldw	x,(OFST-1,sp)
1458  0378 cd0000        	call	_TIM1_SetCompare3
1460                     ; 348 		duty_cycle_step--;
1462  037b 1e01          	ldw	x,(OFST-1,sp)
1463  037d 5a            	decw	x
1464  037e 1f01          	ldw	(OFST-1,sp),x
1466  0380               L534:
1467                     ; 344 	while (duty_cycle_step)
1469  0380 1e01          	ldw	x,(OFST-1,sp)
1470  0382 26ec          	jrne	L334
1471                     ; 351 }
1474  0384 85            	popw	x
1475  0385 81            	ret	
1512                     ; 353 uint16_t pump_max_speed(uint16_t duty_cycle_step)
1512                     ; 354 {
1513                     	switch	.text
1514  0386               _pump_max_speed:
1516  0386 89            	pushw	x
1517       00000000      OFST:	set	0
1520  0387 2010          	jra	L164
1521  0389               L754:
1522                     ; 358 		delay_ms(1);
1524  0389 ae0001        	ldw	x,#1
1525  038c cd01b9        	call	_delay_ms
1527                     ; 359 		TIM1_SetCompare3(duty_cycle_step);
1529  038f 1e01          	ldw	x,(OFST+1,sp)
1530  0391 cd0000        	call	_TIM1_SetCompare3
1532                     ; 360 		duty_cycle_step++;			
1534  0394 1e01          	ldw	x,(OFST+1,sp)
1535  0396 5c            	incw	x
1536  0397 1f01          	ldw	(OFST+1,sp),x
1537  0399               L164:
1538                     ; 356 	while (duty_cycle_step <= arr_tim1)
1540  0399 b304          	cpw	x,_arr_tim1
1541  039b 23ec          	jrule	L754
1542                     ; 362 	return duty_cycle_step;
1546  039d 5b02          	addw	sp,#2
1547  039f 81            	ret	
1584                     ; 365 uint16_t pump_low_speed(uint16_t duty_cycle_step)
1584                     ; 366 {
1585                     	switch	.text
1586  03a0               _pump_low_speed:
1588  03a0 89            	pushw	x
1589       00000000      OFST:	set	0
1592  03a1 2010          	jra	L505
1593  03a3               L305:
1594                     ; 369 		delay_ms(1);
1596  03a3 ae0001        	ldw	x,#1
1597  03a6 cd01b9        	call	_delay_ms
1599                     ; 370 		TIM1_SetCompare3(duty_cycle_step);
1601  03a9 1e01          	ldw	x,(OFST+1,sp)
1602  03ab cd0000        	call	_TIM1_SetCompare3
1604                     ; 371 		duty_cycle_step--;
1606  03ae 1e01          	ldw	x,(OFST+1,sp)
1607  03b0 5a            	decw	x
1608  03b1 1f01          	ldw	(OFST+1,sp),x
1609  03b3               L505:
1610                     ; 367 	while (duty_cycle_step != (arr_tim1/2))
1612  03b3 be04          	ldw	x,_arr_tim1
1613  03b5 54            	srlw	x
1614  03b6 1301          	cpw	x,(OFST+1,sp)
1615  03b8 26e9          	jrne	L305
1616                     ; 373 	return duty_cycle_step;
1618  03ba 1e01          	ldw	x,(OFST+1,sp)
1621  03bc 5b02          	addw	sp,#2
1622  03be 81            	ret	
1658                     ; 376 void pump_off(uint16_t duty_cycle_step)
1658                     ; 377 {
1659                     	switch	.text
1660  03bf               _pump_off:
1662  03bf 89            	pushw	x
1663       00000000      OFST:	set	0
1666  03c0 2010          	jra	L135
1667  03c2               L725:
1668                     ; 380 		delay_ms(1);
1670  03c2 ae0001        	ldw	x,#1
1671  03c5 cd01b9        	call	_delay_ms
1673                     ; 381 		TIM1_SetCompare3(duty_cycle_step);
1675  03c8 1e01          	ldw	x,(OFST+1,sp)
1676  03ca cd0000        	call	_TIM1_SetCompare3
1678                     ; 382 		duty_cycle_step--;
1680  03cd 1e01          	ldw	x,(OFST+1,sp)
1681  03cf 5a            	decw	x
1682  03d0 1f01          	ldw	(OFST+1,sp),x
1683  03d2               L135:
1684                     ; 378 	while (duty_cycle_step)
1686  03d2 1e01          	ldw	x,(OFST+1,sp)
1687  03d4 26ec          	jrne	L725
1688                     ; 384 }
1691  03d6 85            	popw	x
1692  03d7 81            	ret	
1812                     	xdef	_main
1813                     	xdef	_current_state
1814                     	xdef	_pump_off
1815                     	xdef	_pump_low_speed
1816                     	xdef	_pump_max_speed
1817                     	xdef	_pump_smooth_on_off
1818                     	xdef	_led_smooth_blink
1819                     	xdef	_tim1_init
1820                     	xdef	_tim2_init
1821                     	xdef	_set_pwm_frequency
1822                     	xdef	_delay_ms
1823                     	xdef	_tim4_init
1824                     	xdef	_EXTI_setup
1825                     	xdef	_gpio_setup
1826                     	xdef	_clock_setup
1827                     	xdef	_duty_cycle_step
1828                     	xdef	_press_count
1829                     	xdef	_arr_tim2
1830                     	xdef	_arr_tim1
1831                     	xdef	_OCR
1832                     	xref	_pow
1833                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1834                     	xdef	f_EXTI_PORTD_IRQHandler
1835                     	xdef	_ms_count
1836                     	xref	_TIM4_ClearITPendingBit
1837                     	xref	_TIM4_ITConfig
1838                     	xref	_TIM4_Cmd
1839                     	xref	_TIM4_TimeBaseInit
1840                     	xref	_TIM4_DeInit
1841                     	xref	_TIM2_SetCompare3
1842                     	xref	_TIM2_Cmd
1843                     	xref	_TIM2_OC3Init
1844                     	xref	_TIM2_TimeBaseInit
1845                     	xref	_TIM2_DeInit
1846                     	xref	_TIM1_SetCompare3
1847                     	xref	_TIM1_CtrlPWMOutputs
1848                     	xref	_TIM1_Cmd
1849                     	xref	_TIM1_OC3Init
1850                     	xref	_TIM1_TimeBaseInit
1851                     	xref	_TIM1_DeInit
1852                     	xref	_ITC_SetSoftwarePriority
1853                     	xref	_ITC_DeInit
1854                     	xref	_GPIO_ReadInputPin
1855                     	xref	_GPIO_Init
1856                     	xref	_GPIO_DeInit
1857                     	xref	_EXTI_SetTLISensitivity
1858                     	xref	_EXTI_SetExtIntSensitivity
1859                     	xref	_EXTI_DeInit
1860                     	xref	_CLK_GetFlagStatus
1861                     	xref	_CLK_SYSCLKConfig
1862                     	xref	_CLK_HSIPrescalerConfig
1863                     	xref	_CLK_ClockSwitchConfig
1864                     	xref	_CLK_PeripheralClockConfig
1865                     	xref	_CLK_ClockSwitchCmd
1866                     	xref	_CLK_LSICmd
1867                     	xref	_CLK_HSICmd
1868                     	xref	_CLK_HSECmd
1869                     	xref	_CLK_DeInit
1870                     	switch	.const
1871  0004               L762:
1872  0004 3f800000      	dc.w	16256,0
1873  0008               L752:
1874  0008 40000000      	dc.w	16384,0
1875                     	xref.b	c_lreg
1876                     	xref.b	c_x
1877                     	xref.b	c_y
1897                     	xref	c_lsbc
1898                     	xref	c_ldiv
1899                     	xref	c_uitolx
1900                     	xref	c_imul
1901                     	xref	c_lcmp
1902                     	xref	c_ltor
1903                     	xref	c_ftol
1904                     	xref	c_fsub
1905                     	xref	c_fdiv
1906                     	xref	c_fmul
1907                     	xref	c_rtol
1908                     	xref	c_itof
1909                     	xref	c_uitof
1910                     	xref	c_bmulx
1911                     	xref	c_ltof
1912                     	end
