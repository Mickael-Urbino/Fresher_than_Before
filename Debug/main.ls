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
  28  0008               _max_pwm_speed_pump:
  29  0008 0000          	dc.w	0
  30  000a               _max_pwm_speed_LED:
  31  000a 0000          	dc.w	0
  32  000c               _press_count:
  33  000c 00            	dc.b	0
  34  000d               _duty_cycle_step:
  35  000d 0000          	dc.w	0
  36  000f               _pulse_flag:
  37  000f 00            	dc.b	0
  38  0010               _current_state:
  39  0010 00            	dc.b	0
  71                     ; 71 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler,23) {
  72                     	switch	.text
  73  0000               f_TIM4_UPD_OVF_IRQHandler:
  75  0000 8a            	push	cc
  76  0001 84            	pop	a
  77  0002 a4bf          	and	a,#191
  78  0004 88            	push	a
  79  0005 86            	pop	cc
  80  0006 3b0002        	push	c_x+2
  81  0009 be00          	ldw	x,c_x
  82  000b 89            	pushw	x
  83  000c 3b0002        	push	c_y+2
  84  000f be00          	ldw	x,c_y
  85  0011 89            	pushw	x
  88                     ; 72     ms_count++; 
  90  0012 be00          	ldw	x,_ms_count
  91  0014 5c            	incw	x
  92  0015 bf00          	ldw	_ms_count,x
  93                     ; 73     TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  95  0017 a601          	ld	a,#1
  96  0019 cd0000        	call	_TIM4_ClearITPendingBit
  98                     ; 74 }
 101  001c 85            	popw	x
 102  001d bf00          	ldw	c_y,x
 103  001f 320002        	pop	c_y+2
 104  0022 85            	popw	x
 105  0023 bf00          	ldw	c_x,x
 106  0025 320002        	pop	c_x+2
 107  0028 80            	iret	
 133                     ; 76 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
 134                     	switch	.text
 135  0029               f_EXTI_PORTD_IRQHandler:
 137  0029 8a            	push	cc
 138  002a 84            	pop	a
 139  002b a4bf          	and	a,#191
 140  002d 88            	push	a
 141  002e 86            	pop	cc
 142  002f 3b0002        	push	c_x+2
 143  0032 be00          	ldw	x,c_x
 144  0034 89            	pushw	x
 145  0035 3b0002        	push	c_y+2
 146  0038 be00          	ldw	x,c_y
 147  003a 89            	pushw	x
 150                     ; 78 	delay_ms(50);
 152  003b ae0032        	ldw	x,#50
 153  003e cd01f3        	call	_delay_ms
 155                     ; 80 	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0)
 157  0041 4b40          	push	#64
 158  0043 ae500f        	ldw	x,#20495
 159  0046 cd0000        	call	_GPIO_ReadInputPin
 161  0049 5b01          	addw	sp,#1
 162  004b 4d            	tnz	a
 163  004c 2602          	jrne	L13
 164                     ; 82 		 press_count++;
 166  004e 3c0c          	inc	_press_count
 167  0050               L13:
 168                     ; 84 }
 171  0050 85            	popw	x
 172  0051 bf00          	ldw	c_y,x
 173  0053 320002        	pop	c_y+2
 174  0056 85            	popw	x
 175  0057 bf00          	ldw	c_x,x
 176  0059 320002        	pop	c_x+2
 177  005c 80            	iret	
 220                     ; 87 main()
 220                     ; 88 {
 222                     	switch	.text
 223  005d               _main:
 227                     ; 89 	clock_setup();
 229  005d cd0132        	call	_clock_setup
 231                     ; 90 	EXTI_setup();
 233  0060 cd01c7        	call	_EXTI_setup
 235                     ; 92 	enableInterrupts();
 238  0063 9a            	rim	
 240                     ; 100 	tim4_init();
 243  0064 cd01df        	call	_tim4_init
 245                     ; 101 	delay_ms(5000);
 247  0067 ae1388        	ldw	x,#5000
 248  006a cd01f3        	call	_delay_ms
 250                     ; 104 	gpio_setup();
 252  006d cd0192        	call	_gpio_setup
 254                     ; 107 	max_pwm_speed_pump = tim1_init();	
 256  0070 cd0327        	call	_tim1_init
 258  0073 bf08          	ldw	_max_pwm_speed_pump,x
 259  0075               L55:
 260                     ; 114 		switch (current_state)
 262  0075 b610          	ld	a,_current_state
 264                     ; 200 				break;
 265  0077 2711          	jreq	L33
 266  0079 4a            	dec	a
 267  007a 2720          	jreq	L53
 268  007c 4a            	dec	a
 269  007d 2740          	jreq	L73
 270  007f 4a            	dec	a
 271  0080 2760          	jreq	L14
 272  0082 4a            	dec	a
 273  0083 2603cc0112    	jreq	L34
 274  0088 20eb          	jra	L55
 275  008a               L33:
 276                     ; 116 			case STATE_SLEEP: //Default State, no consumption, waiting for a button press to wake up.
 276                     ; 117 
 276                     ; 118 				pump_off();
 278  008a cd03e7        	call	_pump_off
 280                     ; 120 				if (press_count > 0)
 282  008d 3d0c          	tnz	_press_count
 283  008f 27e4          	jreq	L55
 284                     ; 122 					current_state = STATE_IDLE;
 286  0091 35010010      	mov	_current_state,#1
 287                     ; 123 					max_pwm_speed_LED = tim2_init();
 289  0095 cd02e3        	call	_tim2_init
 291  0098 bf0a          	ldw	_max_pwm_speed_LED,x
 292  009a 20d9          	jra	L55
 293  009c               L53:
 294                     ; 127 			case STATE_IDLE:
 294                     ; 128 			
 294                     ; 129 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 296  009c be0a          	ldw	x,_max_pwm_speed_LED
 297  009e a664          	ld	a,#100
 298  00a0 62            	div	x,a
 299  00a1 cd0000        	call	_TIM2_SetCompare3
 301                     ; 130 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 303  00a4 be0a          	ldw	x,_max_pwm_speed_LED
 304  00a6 a664          	ld	a,#100
 305  00a8 62            	div	x,a
 306  00a9 cd0000        	call	_TIM2_SetCompare2
 308                     ; 132 				pump_off();
 310  00ac cd03e7        	call	_pump_off
 312                     ; 134 				if (press_count > 1)
 314  00af b60c          	ld	a,_press_count
 315  00b1 a102          	cp	a,#2
 316  00b3 25c0          	jrult	L55
 317                     ; 136 					current_state = STATE_FULL_SPEED;
 319  00b5 35020010      	mov	_current_state,#2
 320                     ; 137 					TIM2_SetCompare2(0);
 322  00b9 5f            	clrw	x
 323  00ba cd0000        	call	_TIM2_SetCompare2
 325  00bd 20b6          	jra	L55
 326  00bf               L73:
 327                     ; 142 			case STATE_FULL_SPEED:
 327                     ; 143 			
 327                     ; 144 				TIM2_SetCompare3(max_pwm_speed_LED);
 329  00bf be0a          	ldw	x,_max_pwm_speed_LED
 330  00c1 cd0000        	call	_TIM2_SetCompare3
 332                     ; 146 				if (duty_cycle_step < max_pwm_speed_pump)
 334  00c4 be0d          	ldw	x,_duty_cycle_step
 335  00c6 b308          	cpw	x,_max_pwm_speed_pump
 336  00c8 2407          	jruge	L17
 337                     ; 148 					accelerate_pump(duty_cycle_step);
 339  00ca be0d          	ldw	x,_duty_cycle_step
 340  00cc cd03c0        	call	_accelerate_pump
 343  00cf 2005          	jra	L37
 344  00d1               L17:
 345                     ; 152 					set_pump_speed(max_pwm_speed_pump);
 347  00d1 be08          	ldw	x,_max_pwm_speed_pump
 348  00d3 cd03e4        	call	_set_pump_speed
 350  00d6               L37:
 351                     ; 155 				if (press_count > 2)
 353  00d6 b60c          	ld	a,_press_count
 354  00d8 a103          	cp	a,#3
 355  00da 2599          	jrult	L55
 356                     ; 157 					current_state = STATE_LOW_SPEED;
 358  00dc 35030010      	mov	_current_state,#3
 359  00e0 2093          	jra	L55
 360  00e2               L14:
 361                     ; 162 			case STATE_LOW_SPEED:
 361                     ; 163 			
 361                     ; 164 				TIM2_SetCompare3(max_pwm_speed_LED/2);
 363  00e2 be0a          	ldw	x,_max_pwm_speed_LED
 364  00e4 54            	srlw	x
 365  00e5 cd0000        	call	_TIM2_SetCompare3
 367                     ; 166 				if (duty_cycle_step > 0)
 369  00e8 be0d          	ldw	x,_duty_cycle_step
 370  00ea 2707          	jreq	L77
 371                     ; 168 					decelerate_pump(duty_cycle_step);
 373  00ec be0d          	ldw	x,_duty_cycle_step
 374  00ee cd03d2        	call	_decelerate_pump
 377  00f1 2004          	jra	L101
 378  00f3               L77:
 379                     ; 172 					set_pump_speed(0);
 381  00f3 5f            	clrw	x
 382  00f4 cd03e4        	call	_set_pump_speed
 384  00f7               L101:
 385                     ; 175 				if (press_count > 2)
 387  00f7 b60c          	ld	a,_press_count
 388  00f9 a103          	cp	a,#3
 389  00fb 2504          	jrult	L301
 390                     ; 177 					current_state = STATE_LOW_SPEED;
 392  00fd 35030010      	mov	_current_state,#3
 393  0101               L301:
 394                     ; 181 				if (press_count > 3)
 396  0101 b60c          	ld	a,_press_count
 397  0103 a104          	cp	a,#4
 398  0105 25d9          	jrult	L55
 399                     ; 183 					current_state = STATE_PULSE;
 401  0107 35040010      	mov	_current_state,#4
 402                     ; 184 					TIM2_SetCompare3(0);					
 404  010b 5f            	clrw	x
 405  010c cd0000        	call	_TIM2_SetCompare3
 407  010f cc0075        	jra	L55
 408  0112               L34:
 409                     ; 188 			case STATE_PULSE:
 409                     ; 189 				TIM2_SetCompare2(max_pwm_speed_LED/2);
 411  0112 be0a          	ldw	x,_max_pwm_speed_LED
 412  0114 54            	srlw	x
 413  0115 cd0000        	call	_TIM2_SetCompare2
 415                     ; 190 				pump_smooth_on_off();
 417  0118 cd039d        	call	_pump_smooth_on_off
 419                     ; 192 				if (press_count > 4)
 421  011b b60c          	ld	a,_press_count
 422  011d a105          	cp	a,#5
 423  011f 25ee          	jrult	L55
 424                     ; 194 					current_state = STATE_SLEEP;
 426  0121 3f10          	clr	_current_state
 427                     ; 195 					pump_off();
 429  0123 cd03e7        	call	_pump_off
 431                     ; 196 					press_count = 0;
 433  0126 3f0c          	clr	_press_count
 434                     ; 197 					TIM2_SetCompare2(0);					
 436  0128 5f            	clrw	x
 437  0129 cd0000        	call	_TIM2_SetCompare2
 439                     ; 198 					TIM2_DeInit();
 441  012c cd0000        	call	_TIM2_DeInit
 443  012f cc0075        	jra	L55
 444                     ; 200 				break;
 477                     ; 206 void clock_setup(void)
 477                     ; 207 {
 478                     	switch	.text
 479  0132               _clock_setup:
 483                     ; 208 	CLK_DeInit();
 485  0132 cd0000        	call	_CLK_DeInit
 487                     ; 210 	CLK_HSECmd(DISABLE);
 489  0135 4f            	clr	a
 490  0136 cd0000        	call	_CLK_HSECmd
 492                     ; 211 	CLK_LSICmd(DISABLE);
 494  0139 4f            	clr	a
 495  013a cd0000        	call	_CLK_LSICmd
 497                     ; 212 	CLK_HSICmd(ENABLE); //Enable HSI clock (16MHz)
 499  013d a601          	ld	a,#1
 500  013f cd0000        	call	_CLK_HSICmd
 503  0142               L321:
 504                     ; 214 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 506  0142 ae0102        	ldw	x,#258
 507  0145 cd0000        	call	_CLK_GetFlagStatus
 509  0148 4d            	tnz	a
 510  0149 27f7          	jreq	L321
 511                     ; 216 	CLK_ClockSwitchCmd(ENABLE);
 513  014b a601          	ld	a,#1
 514  014d cd0000        	call	_CLK_ClockSwitchCmd
 516                     ; 217 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Peripheral Clock is 16MHz
 518  0150 4f            	clr	a
 519  0151 cd0000        	call	_CLK_HSIPrescalerConfig
 521                     ; 218 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1); //CPU Clock is 16MHz
 523  0154 a680          	ld	a,#128
 524  0156 cd0000        	call	_CLK_SYSCLKConfig
 526                     ; 220 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 526                     ; 221 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 528  0159 4b01          	push	#1
 529  015b 4b00          	push	#0
 530  015d ae01e1        	ldw	x,#481
 531  0160 cd0000        	call	_CLK_ClockSwitchConfig
 533  0163 85            	popw	x
 534                     ; 223 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 536  0164 5f            	clrw	x
 537  0165 cd0000        	call	_CLK_PeripheralClockConfig
 539                     ; 224 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 541  0168 ae0100        	ldw	x,#256
 542  016b cd0000        	call	_CLK_PeripheralClockConfig
 544                     ; 225 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 546  016e ae1300        	ldw	x,#4864
 547  0171 cd0000        	call	_CLK_PeripheralClockConfig
 549                     ; 226 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 551  0174 ae1200        	ldw	x,#4608
 552  0177 cd0000        	call	_CLK_PeripheralClockConfig
 554                     ; 227 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 556  017a ae0300        	ldw	x,#768
 557  017d cd0000        	call	_CLK_PeripheralClockConfig
 559                     ; 228 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE); //Enable Timer 1
 561  0180 ae0701        	ldw	x,#1793
 562  0183 cd0000        	call	_CLK_PeripheralClockConfig
 564                     ; 229 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE); //Enable Timer 2
 566  0186 ae0501        	ldw	x,#1281
 567  0189 cd0000        	call	_CLK_PeripheralClockConfig
 569                     ; 230 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE); //Enable Timer 4 to use as reference for Delay Function
 571  018c ae0401        	ldw	x,#1025
 573                     ; 232 }
 576  018f cc0000        	jp	_CLK_PeripheralClockConfig
 601                     ; 235 void gpio_setup(void)
 601                     ; 236 {
 602                     	switch	.text
 603  0192               _gpio_setup:
 607                     ; 237 	GPIO_DeInit(GPIOA); //Prepare Port A for operation
 609  0192 ae5000        	ldw	x,#20480
 610  0195 cd0000        	call	_GPIO_DeInit
 612                     ; 238 	GPIO_DeInit(GPIOB); //Prepare Port B for operation	
 614  0198 ae5005        	ldw	x,#20485
 615  019b cd0000        	call	_GPIO_DeInit
 617                     ; 239 	GPIO_DeInit(GPIOD); //Prepare Port D for operation
 619  019e ae500f        	ldw	x,#20495
 620  01a1 cd0000        	call	_GPIO_DeInit
 622                     ; 241 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);
 624  01a4 4b20          	push	#32
 625  01a6 4b40          	push	#64
 626  01a8 ae500f        	ldw	x,#20495
 627  01ab cd0000        	call	_GPIO_Init
 629  01ae 85            	popw	x
 630                     ; 242 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 632  01af 4be0          	push	#224
 633  01b1 4b10          	push	#16
 634  01b3 ae5005        	ldw	x,#20485
 635  01b6 cd0000        	call	_GPIO_Init
 637  01b9 85            	popw	x
 638                     ; 243 }
 641  01ba 81            	ret	
 665                     ; 245 void gpio_setup_SWIM(void)
 665                     ; 246 {
 666                     	switch	.text
 667  01bb               _gpio_setup_SWIM:
 671                     ; 249 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 673  01bb 4be0          	push	#224
 674  01bd 4b02          	push	#2
 675  01bf ae500f        	ldw	x,#20495
 676  01c2 cd0000        	call	_GPIO_Init
 678  01c5 85            	popw	x
 679                     ; 251 }
 682  01c6 81            	ret	
 711                     ; 253 void EXTI_setup(void)
 711                     ; 254 {
 712                     	switch	.text
 713  01c7               _EXTI_setup:
 717                     ; 255 	ITC_DeInit();
 719  01c7 cd0000        	call	_ITC_DeInit
 721                     ; 256 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 723  01ca ae0602        	ldw	x,#1538
 724  01cd cd0000        	call	_ITC_SetSoftwarePriority
 726                     ; 258 	EXTI_DeInit();
 728  01d0 cd0000        	call	_EXTI_DeInit
 730                     ; 260 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 732  01d3 ae0302        	ldw	x,#770
 733  01d6 cd0000        	call	_EXTI_SetExtIntSensitivity
 735                     ; 261 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 737  01d9 4f            	clr	a
 738  01da cd0000        	call	_EXTI_SetTLISensitivity
 740                     ; 263 	enableInterrupts();
 743  01dd 9a            	rim	
 745                     ; 264 }
 749  01de 81            	ret	
 776                     ; 266 void tim4_init(void) //Timer Used to count milliseconds for delay function
 776                     ; 267 {
 777                     	switch	.text
 778  01df               _tim4_init:
 782                     ; 269 	TIM4_DeInit();
 784  01df cd0000        	call	_TIM4_DeInit
 786                     ; 270 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 788  01e2 ae077d        	ldw	x,#1917
 789  01e5 cd0000        	call	_TIM4_TimeBaseInit
 791                     ; 271 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 793  01e8 ae0101        	ldw	x,#257
 794  01eb cd0000        	call	_TIM4_ITConfig
 796                     ; 272 	TIM4_Cmd(ENABLE);
 798  01ee a601          	ld	a,#1
 800                     ; 274 }
 803  01f0 cc0000        	jp	_TIM4_Cmd
 847                     ; 276 void delay_ms(int delay)
 847                     ; 277 {
 848                     	switch	.text
 849  01f3               _delay_ms:
 851  01f3 89            	pushw	x
 852  01f4 89            	pushw	x
 853       00000002      OFST:	set	2
 856                     ; 278     int start = ms_count;
 858  01f5 be00          	ldw	x,_ms_count
 859  01f7 1f01          	ldw	(OFST-1,sp),x
 862  01f9               L512:
 863                     ; 279     while ((ms_count - start) < delay);
 865  01f9 be00          	ldw	x,_ms_count
 866  01fb 72f001        	subw	x,(OFST-1,sp)
 867  01fe 1303          	cpw	x,(OFST+1,sp)
 868  0200 2ff7          	jrslt	L512
 869                     ; 281 }
 872  0202 5b04          	addw	sp,#4
 873  0204 81            	ret	
 944                     .const:	section	.text
 945  0000               L222:
 946  0000 00010000      	dc.l	65536
 947                     ; 283 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler) //Set PWM frequency based on HSI speed, the HSI prescaler, and the timer prescaler
 947                     ; 284 {
 948                     	switch	.text
 949  0205               _set_pwm_frequency:
 951  0205 88            	push	a
 952  0206 520c          	subw	sp,#12
 953       0000000c      OFST:	set	12
 956                     ; 285 	uint32_t arr = 0; //Declared as uint32_t to avoid overflow issue during calculation
 958                     ; 286 	switch (hsi_prescaler)
 960  0208 7b12          	ld	a,(OFST+6,sp)
 962                     ; 302 			break;
 963  020a 270e          	jreq	L122
 964  020c a008          	sub	a,#8
 965  020e 270d          	jreq	L322
 966  0210 a008          	sub	a,#8
 967  0212 270d          	jreq	L522
 968  0214 a008          	sub	a,#8
 969  0216 270d          	jreq	L722
 970  0218 200f          	jra	L172
 971  021a               L122:
 972                     ; 288 		case 0x00:
 972                     ; 289 			hsi_prescaler = 1;
 974  021a 4c            	inc	a
 975                     ; 290 			break;
 977  021b 200a          	jp	LC001
 978  021d               L322:
 979                     ; 292 		case 0x08:
 979                     ; 293 			hsi_prescaler = 2;
 981  021d a602          	ld	a,#2
 982                     ; 294 			break;
 984  021f 2006          	jp	LC001
 985  0221               L522:
 986                     ; 296 		case 0x10:
 986                     ; 297 			hsi_prescaler = 4;
 988  0221 a604          	ld	a,#4
 989                     ; 298 			break;
 991  0223 2002          	jp	LC001
 992  0225               L722:
 993                     ; 300 		case 0x18:
 993                     ; 301 			hsi_prescaler = 8;
 995  0225 a608          	ld	a,#8
 996  0227               LC001:
 997  0227 6b12          	ld	(OFST+6,sp),a
 998                     ; 302 			break;
1000  0229               L172:
1001                     ; 305 	if (timer !=  1)
1003  0229 7b0d          	ld	a,(OFST+1,sp)
1004  022b 4a            	dec	a
1005  022c 275f          	jreq	L372
1006                     ; 307 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
1023  022e 2005          	jra	L123
1024  0230               L513:
1025                     ; 311 			frequency++;
1027  0230 1e10          	ldw	x,(OFST+4,sp)
1028  0232 5c            	incw	x
1029  0233 1f10          	ldw	(OFST+4,sp),x
1030                     ; 312 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1047  0235               L123:
1049  0235 7b13          	ld	a,(OFST+7,sp)
1050  0237 5f            	clrw	x
1051  0238 97            	ld	xl,a
1052  0239 cd0000        	call	c_itof
1053  023c be02          	ldw	x,c_lreg+2
1054  023e 89            	pushw	x
1055  023f be00          	ldw	x,c_lreg
1056  0241 89            	pushw	x
1057  0242 ce000a        	ldw	x,L103+2
1058  0245 89            	pushw	x
1059  0246 ce0008        	ldw	x,L103
1060  0249 89            	pushw	x
1061  024a cd0000        	call	_pow
1062  024d 5b08          	addw	sp,#8
1063  024f 96            	ldw	x,sp
1064  0250 1c0005        	addw	x,#OFST-7
1065  0253 cd0000        	call	c_rtol
1066  0256 1e10          	ldw	x,(OFST+4,sp)
1067  0258 7b12          	ld	a,(OFST+6,sp)
1068  025a cd0000        	call	c_bmulx
1069  025d cd0000        	call	c_uitof
1070  0260 96            	ldw	x,sp
1071  0261 1c0005        	addw	x,#OFST-7
1072  0264 cd0000        	call	c_fmul
1073  0267 96            	ldw	x,sp
1074  0268 5c            	incw	x
1075  0269 ad5e          	call	LC002
1076  026b cd0000        	call	c_ltof
1077  026e 96            	ldw	x,sp
1078  026f 5c            	incw	x
1079  0270 cd0000        	call	c_fdiv
1080  0273 ae0004        	ldw	x,#L113
1081  0276 cd0000        	call	c_fsub
1082  0279 cd0000        	call	c_ftol
1083  027c 96            	ldw	x,sp
1084  027d 1c0009        	addw	x,#OFST-3
1085  0280 cd0000        	call	c_rtol
1086                     ; 309 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1088  0283 96            	ldw	x,sp
1089  0284 ad51          	call	LC003
1091  0286 24a8          	jruge	L513
1093  0288               L523:
1094                     ; 327 	return (uint16_t)arr;
1096  0288 1e0b          	ldw	x,(OFST-1,sp)
1099  028a 5b0d          	addw	sp,#13
1100  028c 81            	ret	
1101  028d               L372:
1102                     ; 317 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1104  028d 1e10          	ldw	x,(OFST+4,sp)
1115  028f 2005          	jra	L333
1116  0291               L723:
1117                     ; 321 			frequency++;
1119  0291 1e10          	ldw	x,(OFST+4,sp)
1120  0293 5c            	incw	x
1121  0294 1f10          	ldw	(OFST+4,sp),x
1122                     ; 322 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1133  0296               L333:
1134  0296 7b12          	ld	a,(OFST+6,sp)
1135  0298 cd0000        	call	c_bmulx
1136  029b 7b13          	ld	a,(OFST+7,sp)
1137  029d 905f          	clrw	y
1138  029f 9097          	ld	yl,a
1139  02a1 905c          	incw	y
1140  02a3 cd0000        	call	c_imul
1141  02a6 cd0000        	call	c_uitolx
1142  02a9 96            	ldw	x,sp
1143  02aa 1c0005        	addw	x,#OFST-7
1144  02ad ad1a          	call	LC002
1145  02af 96            	ldw	x,sp
1146  02b0 1c0005        	addw	x,#OFST-7
1147  02b3 cd0000        	call	c_ldiv
1148  02b6 a601          	ld	a,#1
1149  02b8 cd0000        	call	c_lsbc
1150  02bb 96            	ldw	x,sp
1151  02bc 1c0009        	addw	x,#OFST-3
1152  02bf cd0000        	call	c_rtol
1153                     ; 319 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1155  02c2 96            	ldw	x,sp
1156  02c3 ad12          	call	LC003
1158  02c5 24ca          	jruge	L723
1159  02c7 20bf          	jra	L523
1160  02c9               LC002:
1161  02c9 cd0000        	call	c_rtol
1162  02cc ae2400        	ldw	x,#9216
1163  02cf bf02          	ldw	c_lreg+2,x
1164  02d1 ae00f4        	ldw	x,#244
1165  02d4 bf00          	ldw	c_lreg,x
1166  02d6 81            	ret	
1167  02d7               LC003:
1168  02d7 1c0009        	addw	x,#OFST-3
1169  02da cd0000        	call	c_ltor
1171  02dd ae0000        	ldw	x,#L222
1172  02e0 cc0000        	jp	c_lcmp
1213                     ; 330 uint16_t tim2_init(void)
1213                     ; 331 {
1214                     	switch	.text
1215  02e3               _tim2_init:
1217  02e3 89            	pushw	x
1218       00000002      OFST:	set	2
1221                     ; 333 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1223  02e4 4b00          	push	#0
1224  02e6 4b00          	push	#0
1225  02e8 ae4e20        	ldw	x,#20000
1226  02eb 89            	pushw	x
1227  02ec a602          	ld	a,#2
1228  02ee cd0205        	call	_set_pwm_frequency
1230  02f1 5b04          	addw	sp,#4
1231  02f3 1f01          	ldw	(OFST-1,sp),x
1233                     ; 334 	OCR = 0; //To force PWM Low to avoid driving things unintentionally when it's enabled
1235  02f5 5f            	clrw	x
1236  02f6 bf02          	ldw	_OCR,x
1237                     ; 336 	TIM2_DeInit(); //DeInit TIM2
1239  02f8 cd0000        	call	_TIM2_DeInit
1241                     ; 337 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1243  02fb 1e01          	ldw	x,(OFST-1,sp)
1244  02fd 89            	pushw	x
1245  02fe 4f            	clr	a
1246  02ff cd0000        	call	_TIM2_TimeBaseInit
1248  0302 85            	popw	x
1249                     ; 338 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
1251  0303 4b00          	push	#0
1252  0305 be02          	ldw	x,_OCR
1253  0307 89            	pushw	x
1254  0308 ae6011        	ldw	x,#24593
1255  030b cd0000        	call	_TIM2_OC3Init
1257  030e 5b03          	addw	sp,#3
1258                     ; 339 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
1260  0310 4b00          	push	#0
1261  0312 be02          	ldw	x,_OCR
1262  0314 89            	pushw	x
1263  0315 ae6011        	ldw	x,#24593
1264  0318 cd0000        	call	_TIM2_OC2Init
1266  031b 5b03          	addw	sp,#3
1267                     ; 340 	TIM2_Cmd(ENABLE);
1269  031d a601          	ld	a,#1
1270  031f cd0000        	call	_TIM2_Cmd
1272                     ; 342 	return ARR;
1274  0322 1e01          	ldw	x,(OFST-1,sp)
1277  0324 5b02          	addw	sp,#2
1278  0326 81            	ret	
1319                     ; 346 uint16_t tim1_init(void)
1319                     ; 347 {
1320                     	switch	.text
1321  0327               _tim1_init:
1323  0327 89            	pushw	x
1324       00000002      OFST:	set	2
1327                     ; 348 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1329  0328 4b00          	push	#0
1330  032a 4b00          	push	#0
1331  032c ae4e20        	ldw	x,#20000
1332  032f 89            	pushw	x
1333  0330 a601          	ld	a,#1
1334  0332 cd0205        	call	_set_pwm_frequency
1336  0335 5b04          	addw	sp,#4
1337  0337 1f01          	ldw	(OFST-1,sp),x
1339                     ; 349 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1341  0339 5f            	clrw	x
1342  033a bf02          	ldw	_OCR,x
1343                     ; 351 	TIM1_DeInit();
1345  033c cd0000        	call	_TIM1_DeInit
1347                     ; 352 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1349  033f 4b00          	push	#0
1350  0341 1e02          	ldw	x,(OFST+0,sp)
1351  0343 89            	pushw	x
1352  0344 4b00          	push	#0
1353  0346 5f            	clrw	x
1354  0347 cd0000        	call	_TIM1_TimeBaseInit
1356  034a 5b04          	addw	sp,#4
1357                     ; 353 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1359  034c 4b00          	push	#0
1360  034e 4b00          	push	#0
1361  0350 4b88          	push	#136
1362  0352 4b00          	push	#0
1363  0354 be02          	ldw	x,_OCR
1364  0356 89            	pushw	x
1365  0357 4b00          	push	#0
1366  0359 ae6011        	ldw	x,#24593
1367  035c cd0000        	call	_TIM1_OC3Init
1369  035f 5b07          	addw	sp,#7
1370                     ; 354 	TIM1_Cmd(ENABLE);
1372  0361 a601          	ld	a,#1
1373  0363 cd0000        	call	_TIM1_Cmd
1375                     ; 356 	TIM1_CtrlPWMOutputs(ENABLE);
1377  0366 a601          	ld	a,#1
1378  0368 cd0000        	call	_TIM1_CtrlPWMOutputs
1380                     ; 358 }
1383  036b 85            	popw	x
1384  036c 81            	ret	
1421                     ; 360 void led_smooth_blink(void)
1421                     ; 361 {
1422                     	switch	.text
1423  036d               _led_smooth_blink:
1425  036d 89            	pushw	x
1426       00000002      OFST:	set	2
1429                     ; 363 	uint16_t duty_cycle_step = 0;
1431  036e 5f            	clrw	x
1433  036f 200e          	jra	L514
1434  0371               L114:
1435                     ; 367 		delay_ms(1);
1437  0371 ae0001        	ldw	x,#1
1438  0374 cd01f3        	call	_delay_ms
1440                     ; 368 		TIM2_SetCompare3(duty_cycle_step);
1442  0377 1e01          	ldw	x,(OFST-1,sp)
1443  0379 cd0000        	call	_TIM2_SetCompare3
1445                     ; 369 		duty_cycle_step++;			
1447  037c 1e01          	ldw	x,(OFST-1,sp)
1448  037e 5c            	incw	x
1449  037f               L514:
1450  037f 1f01          	ldw	(OFST-1,sp),x
1452                     ; 365 	while (duty_cycle_step <= arr_tim2)
1454  0381 b306          	cpw	x,_arr_tim2
1455  0383 23ec          	jrule	L114
1457  0385 2010          	jra	L324
1458  0387               L124:
1459                     ; 374 		delay_ms(1);
1461  0387 ae0001        	ldw	x,#1
1462  038a cd01f3        	call	_delay_ms
1464                     ; 375 		TIM2_SetCompare3(duty_cycle_step);
1466  038d 1e01          	ldw	x,(OFST-1,sp)
1467  038f cd0000        	call	_TIM2_SetCompare3
1469                     ; 376 		duty_cycle_step--;
1471  0392 1e01          	ldw	x,(OFST-1,sp)
1472  0394 5a            	decw	x
1473  0395 1f01          	ldw	(OFST-1,sp),x
1475  0397               L324:
1476                     ; 372 	while (duty_cycle_step)
1478  0397 1e01          	ldw	x,(OFST-1,sp)
1479  0399 26ec          	jrne	L124
1480                     ; 379 }
1483  039b 85            	popw	x
1484  039c 81            	ret	
1512                     ; 381 void pump_smooth_on_off(void)
1512                     ; 382 {
1513                     	switch	.text
1514  039d               _pump_smooth_on_off:
1518                     ; 383 	if ((duty_cycle_step < arr_tim1) && (!pulse_flag))
1520  039d be0d          	ldw	x,_duty_cycle_step
1521  039f b304          	cpw	x,_arr_tim1
1522  03a1 240a          	jruge	L734
1524  03a3 3d0f          	tnz	_pulse_flag
1525  03a5 2606          	jrne	L734
1526                     ; 385 		accelerate_pump(duty_cycle_step);			
1528  03a7 be0d          	ldw	x,_duty_cycle_step
1529  03a9 ad15          	call	_accelerate_pump
1532  03ab 2004          	jra	L144
1533  03ad               L734:
1534                     ; 389 		pulse_flag = TRUE;
1536  03ad 3501000f      	mov	_pulse_flag,#1
1537  03b1               L144:
1538                     ; 392 	if ((duty_cycle_step > 0) && (pulse_flag))
1540  03b1 be0d          	ldw	x,_duty_cycle_step
1541  03b3 2708          	jreq	L344
1543  03b5 3d0f          	tnz	_pulse_flag
1544  03b7 2704          	jreq	L344
1545                     ; 394 		decelerate_pump(duty_cycle_step);			
1547  03b9 be0d          	ldw	x,_duty_cycle_step
1551  03bb 2015          	jp	_decelerate_pump
1552  03bd               L344:
1553                     ; 398 		pulse_flag = FALSE;
1555  03bd 3f0f          	clr	_pulse_flag
1556                     ; 401 }
1559  03bf 81            	ret	
1595                     ; 403 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1595                     ; 404 {	
1596                     	switch	.text
1597  03c0               _accelerate_pump:
1599  03c0 89            	pushw	x
1600       00000000      OFST:	set	0
1603                     ; 405 	delay_ms(1);
1605  03c1 ae0001        	ldw	x,#1
1606  03c4 cd01f3        	call	_delay_ms
1608                     ; 406 	TIM1_SetCompare3(duty_cycle_step);
1610  03c7 1e01          	ldw	x,(OFST+1,sp)
1611  03c9 cd0000        	call	_TIM1_SetCompare3
1613                     ; 407 	duty_cycle_step++;			
1615  03cc 1e01          	ldw	x,(OFST+1,sp)
1616  03ce 5c            	incw	x
1617                     ; 409 	return duty_cycle_step;
1621  03cf 5b02          	addw	sp,#2
1622  03d1 81            	ret	
1658                     ; 412 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1658                     ; 413 {	
1659                     	switch	.text
1660  03d2               _decelerate_pump:
1662  03d2 89            	pushw	x
1663       00000000      OFST:	set	0
1666                     ; 414 	delay_ms(1);
1668  03d3 ae0001        	ldw	x,#1
1669  03d6 cd01f3        	call	_delay_ms
1671                     ; 415 	TIM1_SetCompare3(duty_cycle_step);
1673  03d9 1e01          	ldw	x,(OFST+1,sp)
1674  03db cd0000        	call	_TIM1_SetCompare3
1676                     ; 416 	duty_cycle_step--;			
1678  03de 1e01          	ldw	x,(OFST+1,sp)
1679  03e0 5a            	decw	x
1680                     ; 418 	return duty_cycle_step;
1684  03e1 5b02          	addw	sp,#2
1685  03e3 81            	ret	
1720                     ; 421 void set_pump_speed(uint16_t duty_cycle_step)
1720                     ; 422 {	
1721                     	switch	.text
1722  03e4               _set_pump_speed:
1726                     ; 423 	TIM1_SetCompare3(duty_cycle_step);
1729                     ; 425 }
1732  03e4 cc0000        	jp	_TIM1_SetCompare3
1756                     ; 427 void pump_off(void)
1756                     ; 428 {
1757                     	switch	.text
1758  03e7               _pump_off:
1762                     ; 429 	TIM1_SetCompare3(0);
1764  03e7 5f            	clrw	x
1766                     ; 430 }
1769  03e8 cc0000        	jp	_TIM1_SetCompare3
1937                     	xdef	_main
1938                     	xdef	_current_state
1939                     	xdef	_pump_off
1940                     	xdef	_decelerate_pump
1941                     	xdef	_accelerate_pump
1942                     	xdef	_set_pump_speed
1943                     	xdef	_pump_smooth_on_off
1944                     	xdef	_led_smooth_blink
1945                     	xdef	_tim1_init
1946                     	xdef	_tim2_init
1947                     	xdef	_set_pwm_frequency
1948                     	xdef	_delay_ms
1949                     	xdef	_tim4_init
1950                     	xdef	_EXTI_setup
1951                     	xdef	_gpio_setup_SWIM
1952                     	xdef	_gpio_setup
1953                     	xdef	_clock_setup
1954                     	xdef	_pulse_flag
1955                     	xdef	_duty_cycle_step
1956                     	xdef	_press_count
1957                     	xdef	_max_pwm_speed_LED
1958                     	xdef	_max_pwm_speed_pump
1959                     	xdef	_arr_tim2
1960                     	xdef	_arr_tim1
1961                     	xdef	_OCR
1962                     	xref	_pow
1963                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1964                     	xdef	f_EXTI_PORTD_IRQHandler
1965                     	xdef	_ms_count
1966                     	xref	_TIM4_ClearITPendingBit
1967                     	xref	_TIM4_ITConfig
1968                     	xref	_TIM4_Cmd
1969                     	xref	_TIM4_TimeBaseInit
1970                     	xref	_TIM4_DeInit
1971                     	xref	_TIM2_SetCompare3
1972                     	xref	_TIM2_SetCompare2
1973                     	xref	_TIM2_Cmd
1974                     	xref	_TIM2_OC3Init
1975                     	xref	_TIM2_OC2Init
1976                     	xref	_TIM2_TimeBaseInit
1977                     	xref	_TIM2_DeInit
1978                     	xref	_TIM1_SetCompare3
1979                     	xref	_TIM1_CtrlPWMOutputs
1980                     	xref	_TIM1_Cmd
1981                     	xref	_TIM1_OC3Init
1982                     	xref	_TIM1_TimeBaseInit
1983                     	xref	_TIM1_DeInit
1984                     	xref	_ITC_SetSoftwarePriority
1985                     	xref	_ITC_DeInit
1986                     	xref	_GPIO_ReadInputPin
1987                     	xref	_GPIO_Init
1988                     	xref	_GPIO_DeInit
1989                     	xref	_EXTI_SetTLISensitivity
1990                     	xref	_EXTI_SetExtIntSensitivity
1991                     	xref	_EXTI_DeInit
1992                     	xref	_CLK_GetFlagStatus
1993                     	xref	_CLK_SYSCLKConfig
1994                     	xref	_CLK_HSIPrescalerConfig
1995                     	xref	_CLK_ClockSwitchConfig
1996                     	xref	_CLK_PeripheralClockConfig
1997                     	xref	_CLK_ClockSwitchCmd
1998                     	xref	_CLK_LSICmd
1999                     	xref	_CLK_HSICmd
2000                     	xref	_CLK_HSECmd
2001                     	xref	_CLK_DeInit
2002                     	switch	.const
2003  0004               L113:
2004  0004 3f800000      	dc.w	16256,0
2005  0008               L103:
2006  0008 40000000      	dc.w	16384,0
2007                     	xref.b	c_lreg
2008                     	xref.b	c_x
2009                     	xref.b	c_y
2029                     	xref	c_lsbc
2030                     	xref	c_ldiv
2031                     	xref	c_uitolx
2032                     	xref	c_imul
2033                     	xref	c_lcmp
2034                     	xref	c_ltor
2035                     	xref	c_ftol
2036                     	xref	c_fsub
2037                     	xref	c_fdiv
2038                     	xref	c_fmul
2039                     	xref	c_rtol
2040                     	xref	c_itof
2041                     	xref	c_uitof
2042                     	xref	c_bmulx
2043                     	xref	c_ltof
2044                     	end
