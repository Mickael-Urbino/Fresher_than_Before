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
  71                     ; 96 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) {
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
  88                     ; 97     ms_count++;  // Increment milliseconds count
  90  0012 be00          	ldw	x,_ms_count
  91  0014 5c            	incw	x
  92  0015 bf00          	ldw	_ms_count,x
  93                     ; 98     TIM4_ClearITPendingBit(TIM4_IT_UPDATE); // Clear interrupt pending bit for Timer 4
  95  0017 a601          	ld	a,#1
  96  0019 cd0000        	call	_TIM4_ClearITPendingBit
  98                     ; 99 }
 101  001c 85            	popw	x
 102  001d bf00          	ldw	c_y,x
 103  001f 320002        	pop	c_y+2
 104  0022 85            	popw	x
 105  0023 bf00          	ldw	c_x,x
 106  0025 320002        	pop	c_x+2
 107  0028 80            	iret	
 133                     ; 108 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
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
 150                     ; 109 	delay_ms(50); // Debounce delay to ensure stable button press detection
 152  003b ae0032        	ldw	x,#50
 153  003e cd01f8        	call	_delay_ms
 155                     ; 111 	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0) // Check if the button is pressed
 157  0041 4b40          	push	#64
 158  0043 ae500f        	ldw	x,#20495
 159  0046 cd0000        	call	_GPIO_ReadInputPin
 161  0049 5b01          	addw	sp,#1
 162  004b 4d            	tnz	a
 163  004c 2602          	jrne	L13
 164                     ; 113 		press_count++; // Increment press count if the button is pressed
 166  004e 3c0c          	inc	_press_count
 167  0050               L13:
 168                     ; 115 }
 171  0050 85            	popw	x
 172  0051 bf00          	ldw	c_y,x
 173  0053 320002        	pop	c_y+2
 174  0056 85            	popw	x
 175  0057 bf00          	ldw	c_x,x
 176  0059 320002        	pop	c_x+2
 177  005c 80            	iret	
 220                     ; 118 main()
 220                     ; 119 {
 222                     	switch	.text
 223  005d               _main:
 227                     ; 121 	clock_setup();						// Configure system clock and timing
 229  005d cd0143        	call	_clock_setup
 231                     ; 122 	EXTI_setup();							// Setup external interrupts for button handling
 233  0060 cd01cc        	call	_EXTI_setup
 235                     ; 123 	enableInterrupts();				// Globally enable interrupts
 238  0063 9a            	rim	
 240                     ; 131 	tim4_init();
 243  0064 cd01e4        	call	_tim4_init
 245                     ; 132 	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
 247  0067 ae1388        	ldw	x,#5000
 248  006a cd01f8        	call	_delay_ms
 250                     ; 135 	gpio_setup();
 252  006d cd01a3        	call	_gpio_setup
 254                     ; 142 	max_pwm_speed_pump = tim1_init();	
 256  0070 cd032c        	call	_tim1_init
 258  0073 bf08          	ldw	_max_pwm_speed_pump,x
 259  0075               L75:
 260                     ; 152 		switch (current_state)
 262  0075 b610          	ld	a,_current_state
 264                     ; 256 				break;
 265  0077 2713          	jreq	L33
 266  0079 4a            	dec	a
 267  007a 2724          	jreq	L53
 268  007c 4a            	dec	a
 269  007d 2746          	jreq	L73
 270  007f 4a            	dec	a
 271  0080 2768          	jreq	L14
 272  0082 4a            	dec	a
 273  0083 2603cc011d    	jreq	L34
 274                     ; 252 			default:
 274                     ; 253 			
 274                     ; 254 				// Unexpected state: reset to SLEEP state as a failsafe
 274                     ; 255 				current_state = STATE_SLEEP;
 276  0088 3f10          	clr	_current_state
 277                     ; 256 				break;
 279  008a 20e9          	jra	L75
 280  008c               L33:
 281                     ; 154 			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
 281                     ; 155 
 281                     ; 156 				pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
 283  008c be0d          	ldw	x,_duty_cycle_step
 284  008e cd03a2        	call	_pump_off
 286                     ; 159 				if (press_count > 0)
 288  0091 3d0c          	tnz	_press_count
 289  0093 27e0          	jreq	L75
 290                     ; 161 					current_state = STATE_IDLE;
 292  0095 35010010      	mov	_current_state,#1
 293                     ; 162 					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
 295  0099 cd02e8        	call	_tim2_init
 297  009c bf0a          	ldw	_max_pwm_speed_LED,x
 298  009e 20d5          	jra	L75
 299  00a0               L53:
 300                     ; 166 			case STATE_IDLE:	// Idle state: low LED brightness and pump off
 300                     ; 167 			
 300                     ; 168 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 302  00a0 be0a          	ldw	x,_max_pwm_speed_LED
 303  00a2 a664          	ld	a,#100
 304  00a4 62            	div	x,a
 305  00a5 cd0000        	call	_TIM2_SetCompare3
 307                     ; 169 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 309  00a8 be0a          	ldw	x,_max_pwm_speed_LED
 310  00aa a664          	ld	a,#100
 311  00ac 62            	div	x,a
 312  00ad cd0000        	call	_TIM2_SetCompare2
 314                     ; 171 				pump_off(duty_cycle_step);	// Keep the pump turned off
 316  00b0 be0d          	ldw	x,_duty_cycle_step
 317  00b2 cd03a2        	call	_pump_off
 319                     ; 174 				if (press_count > 1)
 321  00b5 b60c          	ld	a,_press_count
 322  00b7 a102          	cp	a,#2
 323  00b9 25ba          	jrult	L75
 324                     ; 176 					current_state = STATE_FULL_SPEED;
 326  00bb 35020010      	mov	_current_state,#2
 327                     ; 178 					TIM2_SetCompare2(0);
 329  00bf 5f            	clrw	x
 330  00c0 cd0000        	call	_TIM2_SetCompare2
 332  00c3 20b0          	jra	L75
 333  00c5               L73:
 334                     ; 183 			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
 334                     ; 184 				
 334                     ; 185 				// Set LED to maximum brightness
 334                     ; 186 				TIM2_SetCompare3(max_pwm_speed_LED);
 336  00c5 be0a          	ldw	x,_max_pwm_speed_LED
 337  00c7 cd0000        	call	_TIM2_SetCompare3
 339                     ; 189 				if (duty_cycle_step < max_pwm_speed_pump)
 341  00ca be0d          	ldw	x,_duty_cycle_step
 342  00cc b308          	cpw	x,_max_pwm_speed_pump
 343  00ce 2407          	jruge	L37
 344                     ; 191 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 346  00d0 be0d          	ldw	x,_duty_cycle_step
 347  00d2 cd0375        	call	_accelerate_pump
 350  00d5 2005          	jra	L57
 351  00d7               L37:
 352                     ; 195 					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
 354  00d7 be08          	ldw	x,_max_pwm_speed_pump
 355  00d9 cd0399        	call	_set_pump_speed
 357  00dc               L57:
 358  00dc bf0d          	ldw	_duty_cycle_step,x
 359                     ; 199 				if (press_count > 2)
 361  00de b60c          	ld	a,_press_count
 362  00e0 a103          	cp	a,#3
 363  00e2 2591          	jrult	L75
 364                     ; 201 					current_state = STATE_LOW_SPEED;
 366  00e4 35030010      	mov	_current_state,#3
 367  00e8 208b          	jra	L75
 368  00ea               L14:
 369                     ; 206 			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
 369                     ; 207 				
 369                     ; 208 				// Set LED brightness to 50% of maximum
 369                     ; 209 				TIM2_SetCompare3(max_pwm_speed_LED/2);
 371  00ea be0a          	ldw	x,_max_pwm_speed_LED
 372  00ec 54            	srlw	x
 373  00ed cd0000        	call	_TIM2_SetCompare3
 375                     ; 212 				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
 377  00f0 be08          	ldw	x,_max_pwm_speed_pump
 378  00f2 a603          	ld	a,#3
 379  00f4 62            	div	x,a
 380  00f5 58            	sllw	x
 381  00f6 b30d          	cpw	x,_duty_cycle_step
 382  00f8 2407          	jruge	L101
 383                     ; 214 					duty_cycle_step = decelerate_pump(duty_cycle_step);
 385  00fa be0d          	ldw	x,_duty_cycle_step
 386  00fc cd0387        	call	_decelerate_pump
 389  00ff 2009          	jra	L301
 390  0101               L101:
 391                     ; 218 					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
 393  0101 be08          	ldw	x,_max_pwm_speed_pump
 394  0103 a603          	ld	a,#3
 395  0105 62            	div	x,a
 396  0106 58            	sllw	x
 397  0107 cd0399        	call	_set_pump_speed
 399  010a               L301:
 400  010a bf0d          	ldw	_duty_cycle_step,x
 401                     ; 222 				if (press_count > 3)
 403  010c b60c          	ld	a,_press_count
 404  010e a104          	cp	a,#4
 405  0110 25d6          	jrult	L75
 406                     ; 224 					current_state = STATE_PULSE;
 408  0112 35040010      	mov	_current_state,#4
 409                     ; 225 					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
 411  0116 5f            	clrw	x
 412  0117 cd0000        	call	_TIM2_SetCompare3
 414  011a cc0075        	jra	L75
 415  011d               L34:
 416                     ; 229 			case STATE_PULSE:	// Pulsed pump operation with LED indication
 416                     ; 230 			
 416                     ; 231 				// Set LED PULSE to 50% brightnes
 416                     ; 232 				TIM2_SetCompare2(max_pwm_speed_LED/2);
 418  011d be0a          	ldw	x,_max_pwm_speed_LED
 419  011f 54            	srlw	x
 420  0120 cd0000        	call	_TIM2_SetCompare2
 422                     ; 235 				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
 424  0123 be0d          	ldw	x,_duty_cycle_step
 425  0125 cd03b0        	call	_pump_smooth_on_off
 427  0128 bf0d          	ldw	_duty_cycle_step,x
 428                     ; 238 				if (press_count > 4)
 430  012a b60c          	ld	a,_press_count
 431  012c a105          	cp	a,#5
 432  012e 25ea          	jrult	L75
 433                     ; 240 					current_state = STATE_SLEEP;	// Reset to SLEEP state
 435  0130 3f10          	clr	_current_state
 436                     ; 243 					pump_off(duty_cycle_step);
 438  0132 be0d          	ldw	x,_duty_cycle_step
 439  0134 cd03a2        	call	_pump_off
 441                     ; 244 					press_count = 0;
 443  0137 3f0c          	clr	_press_count
 444                     ; 247 					TIM2_SetCompare2(0);	// Turn off LED PULSE				
 446  0139 5f            	clrw	x
 447  013a cd0000        	call	_TIM2_SetCompare2
 449                     ; 248 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 451  013d cd0000        	call	_TIM2_DeInit
 453  0140 cc0075        	jra	L75
 454                     ; 256 				break;
 487                     ; 268 void clock_setup(void)
 487                     ; 269 {
 488                     	switch	.text
 489  0143               _clock_setup:
 493                     ; 270 	CLK_DeInit();		// Reset clock configuration to default state
 495  0143 cd0000        	call	_CLK_DeInit
 497                     ; 272 	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
 499  0146 4f            	clr	a
 500  0147 cd0000        	call	_CLK_HSECmd
 502                     ; 273 	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
 504  014a 4f            	clr	a
 505  014b cd0000        	call	_CLK_LSICmd
 507                     ; 274 	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
 509  014e a601          	ld	a,#1
 510  0150 cd0000        	call	_CLK_HSICmd
 513  0153               L321:
 514                     ; 276 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
 516  0153 ae0102        	ldw	x,#258
 517  0156 cd0000        	call	_CLK_GetFlagStatus
 519  0159 4d            	tnz	a
 520  015a 27f7          	jreq	L321
 521                     ; 278 	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
 523  015c a601          	ld	a,#1
 524  015e cd0000        	call	_CLK_ClockSwitchCmd
 526                     ; 279 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
 528  0161 4f            	clr	a
 529  0162 cd0000        	call	_CLK_HSIPrescalerConfig
 531                     ; 280 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
 533  0165 a680          	ld	a,#128
 534  0167 cd0000        	call	_CLK_SYSCLKConfig
 536                     ; 282 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 536                     ; 283 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 538  016a 4b01          	push	#1
 539  016c 4b00          	push	#0
 540  016e ae01e1        	ldw	x,#481
 541  0171 cd0000        	call	_CLK_ClockSwitchConfig
 543  0174 85            	popw	x
 544                     ; 286 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 546  0175 5f            	clrw	x
 547  0176 cd0000        	call	_CLK_PeripheralClockConfig
 549                     ; 287 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 551  0179 ae0100        	ldw	x,#256
 552  017c cd0000        	call	_CLK_PeripheralClockConfig
 554                     ; 288 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 556  017f ae1300        	ldw	x,#4864
 557  0182 cd0000        	call	_CLK_PeripheralClockConfig
 559                     ; 289 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 561  0185 ae1200        	ldw	x,#4608
 562  0188 cd0000        	call	_CLK_PeripheralClockConfig
 564                     ; 290 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 566  018b ae0300        	ldw	x,#768
 567  018e cd0000        	call	_CLK_PeripheralClockConfig
 569                     ; 291 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
 571  0191 ae0701        	ldw	x,#1793
 572  0194 cd0000        	call	_CLK_PeripheralClockConfig
 574                     ; 292 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
 576  0197 ae0501        	ldw	x,#1281
 577  019a cd0000        	call	_CLK_PeripheralClockConfig
 579                     ; 293 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
 581  019d ae0401        	ldw	x,#1025
 583                     ; 295 }
 586  01a0 cc0000        	jp	_CLK_PeripheralClockConfig
 611                     ; 304 void gpio_setup(void)
 611                     ; 305 {
 612                     	switch	.text
 613  01a3               _gpio_setup:
 617                     ; 306 	GPIO_DeInit(GPIOA);  // Reset Port A configuration
 619  01a3 ae5000        	ldw	x,#20480
 620  01a6 cd0000        	call	_GPIO_DeInit
 622                     ; 307 	GPIO_DeInit(GPIOB);  // Reset Port B configuration
 624  01a9 ae5005        	ldw	x,#20485
 625  01ac cd0000        	call	_GPIO_DeInit
 627                     ; 308 	GPIO_DeInit(GPIOD);  // Reset Port D configuration
 629  01af ae500f        	ldw	x,#20495
 630  01b2 cd0000        	call	_GPIO_DeInit
 632                     ; 310 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);					// Configure Pin D6 as an floating input with interrupt
 634  01b5 4b20          	push	#32
 635  01b7 4b40          	push	#64
 636  01b9 ae500f        	ldw	x,#20495
 637  01bc cd0000        	call	_GPIO_Init
 639  01bf 85            	popw	x
 640                     ; 311 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
 642  01c0 4be0          	push	#224
 643  01c2 4b10          	push	#16
 644  01c4 ae5005        	ldw	x,#20485
 645  01c7 cd0000        	call	_GPIO_Init
 647  01ca 85            	popw	x
 648                     ; 312 }
 651  01cb 81            	ret	
 680                     ; 321 void EXTI_setup(void)
 680                     ; 322 {
 681                     	switch	.text
 682  01cc               _EXTI_setup:
 686                     ; 323 	ITC_DeInit();	// Reset interrupt controller configuration
 688  01cc cd0000        	call	_ITC_DeInit
 690                     ; 324 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
 692  01cf ae0602        	ldw	x,#1538
 693  01d2 cd0000        	call	_ITC_SetSoftwarePriority
 695                     ; 326 	EXTI_DeInit(); // Reset external interrupt configuration
 697  01d5 cd0000        	call	_EXTI_DeInit
 699                     ; 328 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);  // Enable falling-edge sensitivity for Port D
 701  01d8 ae0302        	ldw	x,#770
 702  01db cd0000        	call	_EXTI_SetExtIntSensitivity
 704                     ; 329 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
 706  01de 4f            	clr	a
 707  01df cd0000        	call	_EXTI_SetTLISensitivity
 709                     ; 331 	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
 712  01e2 9a            	rim	
 714                     ; 332 }
 718  01e3 81            	ret	
 745                     ; 341 void tim4_init(void) //Timer Used to count milliseconds for delay function
 745                     ; 342 {
 746                     	switch	.text
 747  01e4               _tim4_init:
 751                     ; 344 	TIM4_DeInit();	// Reset Timer 4 configuration
 753  01e4 cd0000        	call	_TIM4_DeInit
 755                     ; 345 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 757  01e7 ae077d        	ldw	x,#1917
 758  01ea cd0000        	call	_TIM4_TimeBaseInit
 760                     ; 346 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
 762  01ed ae0101        	ldw	x,#257
 763  01f0 cd0000        	call	_TIM4_ITConfig
 765                     ; 347 	TIM4_Cmd(ENABLE);  // Start Timer 4
 767  01f3 a601          	ld	a,#1
 769                     ; 349 }
 772  01f5 cc0000        	jp	_TIM4_Cmd
 816                     ; 359 void delay_ms(int delay)
 816                     ; 360 {
 817                     	switch	.text
 818  01f8               _delay_ms:
 820  01f8 89            	pushw	x
 821  01f9 89            	pushw	x
 822       00000002      OFST:	set	2
 825                     ; 361     int start = ms_count;	// Record the current timer count
 827  01fa be00          	ldw	x,_ms_count
 828  01fc 1f01          	ldw	(OFST-1,sp),x
 831  01fe               L502:
 832                     ; 362     while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
 834  01fe be00          	ldw	x,_ms_count
 835  0200 72f001        	subw	x,(OFST-1,sp)
 836  0203 1303          	cpw	x,(OFST+1,sp)
 837  0205 2ff7          	jrslt	L502
 838                     ; 364 }
 841  0207 5b04          	addw	sp,#4
 842  0209 81            	ret	
 913                     .const:	section	.text
 914  0000               L612:
 915  0000 00010000      	dc.l	65536
 916                     ; 379 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
 916                     ; 380 {
 917                     	switch	.text
 918  020a               _set_pwm_frequency:
 920  020a 88            	push	a
 921  020b 520c          	subw	sp,#12
 922       0000000c      OFST:	set	12
 925                     ; 381 	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
 927                     ; 382 	switch (hsi_prescaler)
 929  020d 7b12          	ld	a,(OFST+6,sp)
 931                     ; 398 			break;
 932  020f 270e          	jreq	L112
 933  0211 a008          	sub	a,#8
 934  0213 270d          	jreq	L312
 935  0215 a008          	sub	a,#8
 936  0217 270d          	jreq	L512
 937  0219 a008          	sub	a,#8
 938  021b 270d          	jreq	L712
 939  021d 200f          	jra	L162
 940  021f               L112:
 941                     ; 384 		case 0x00:
 941                     ; 385 			hsi_prescaler = 1;
 943  021f 4c            	inc	a
 944                     ; 386 			break;
 946  0220 200a          	jp	LC001
 947  0222               L312:
 948                     ; 388 		case 0x08:
 948                     ; 389 			hsi_prescaler = 2;
 950  0222 a602          	ld	a,#2
 951                     ; 390 			break;
 953  0224 2006          	jp	LC001
 954  0226               L512:
 955                     ; 392 		case 0x10:
 955                     ; 393 			hsi_prescaler = 4;
 957  0226 a604          	ld	a,#4
 958                     ; 394 			break;
 960  0228 2002          	jp	LC001
 961  022a               L712:
 962                     ; 396 		case 0x18:
 962                     ; 397 			hsi_prescaler = 8;
 964  022a a608          	ld	a,#8
 965  022c               LC001:
 966  022c 6b12          	ld	(OFST+6,sp),a
 967                     ; 398 			break;
 969  022e               L162:
 970                     ; 401 	if (timer !=  1)
 972  022e 7b0d          	ld	a,(OFST+1,sp)
 973  0230 4a            	dec	a
 974  0231 275f          	jreq	L362
 975                     ; 403 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
 992  0233 2005          	jra	L113
 993  0235               L503:
 994                     ; 407 			frequency++;
 996  0235 1e10          	ldw	x,(OFST+4,sp)
 997  0237 5c            	incw	x
 998  0238 1f10          	ldw	(OFST+4,sp),x
 999                     ; 408 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1016  023a               L113:
1018  023a 7b13          	ld	a,(OFST+7,sp)
1019  023c 5f            	clrw	x
1020  023d 97            	ld	xl,a
1021  023e cd0000        	call	c_itof
1022  0241 be02          	ldw	x,c_lreg+2
1023  0243 89            	pushw	x
1024  0244 be00          	ldw	x,c_lreg
1025  0246 89            	pushw	x
1026  0247 ce000a        	ldw	x,L172+2
1027  024a 89            	pushw	x
1028  024b ce0008        	ldw	x,L172
1029  024e 89            	pushw	x
1030  024f cd0000        	call	_pow
1031  0252 5b08          	addw	sp,#8
1032  0254 96            	ldw	x,sp
1033  0255 1c0005        	addw	x,#OFST-7
1034  0258 cd0000        	call	c_rtol
1035  025b 1e10          	ldw	x,(OFST+4,sp)
1036  025d 7b12          	ld	a,(OFST+6,sp)
1037  025f cd0000        	call	c_bmulx
1038  0262 cd0000        	call	c_uitof
1039  0265 96            	ldw	x,sp
1040  0266 1c0005        	addw	x,#OFST-7
1041  0269 cd0000        	call	c_fmul
1042  026c 96            	ldw	x,sp
1043  026d 5c            	incw	x
1044  026e ad5e          	call	LC002
1045  0270 cd0000        	call	c_ltof
1046  0273 96            	ldw	x,sp
1047  0274 5c            	incw	x
1048  0275 cd0000        	call	c_fdiv
1049  0278 ae0004        	ldw	x,#L103
1050  027b cd0000        	call	c_fsub
1051  027e cd0000        	call	c_ftol
1052  0281 96            	ldw	x,sp
1053  0282 1c0009        	addw	x,#OFST-3
1054  0285 cd0000        	call	c_rtol
1055                     ; 405 		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
1057  0288 96            	ldw	x,sp
1058  0289 ad51          	call	LC003
1060  028b 24a8          	jruge	L503
1062  028d               L513:
1063                     ; 423 	return (uint16_t)arr;
1065  028d 1e0b          	ldw	x,(OFST-1,sp)
1068  028f 5b0d          	addw	sp,#13
1069  0291 81            	ret	
1070  0292               L362:
1071                     ; 413 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1073  0292 1e10          	ldw	x,(OFST+4,sp)
1084  0294 2005          	jra	L323
1085  0296               L713:
1086                     ; 417 			frequency++;
1088  0296 1e10          	ldw	x,(OFST+4,sp)
1089  0298 5c            	incw	x
1090  0299 1f10          	ldw	(OFST+4,sp),x
1091                     ; 418 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1102  029b               L323:
1103  029b 7b12          	ld	a,(OFST+6,sp)
1104  029d cd0000        	call	c_bmulx
1105  02a0 7b13          	ld	a,(OFST+7,sp)
1106  02a2 905f          	clrw	y
1107  02a4 9097          	ld	yl,a
1108  02a6 905c          	incw	y
1109  02a8 cd0000        	call	c_imul
1110  02ab cd0000        	call	c_uitolx
1111  02ae 96            	ldw	x,sp
1112  02af 1c0005        	addw	x,#OFST-7
1113  02b2 ad1a          	call	LC002
1114  02b4 96            	ldw	x,sp
1115  02b5 1c0005        	addw	x,#OFST-7
1116  02b8 cd0000        	call	c_ldiv
1117  02bb a601          	ld	a,#1
1118  02bd cd0000        	call	c_lsbc
1119  02c0 96            	ldw	x,sp
1120  02c1 1c0009        	addw	x,#OFST-3
1121  02c4 cd0000        	call	c_rtol
1122                     ; 415 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1124  02c7 96            	ldw	x,sp
1125  02c8 ad12          	call	LC003
1127  02ca 24ca          	jruge	L713
1128  02cc 20bf          	jra	L513
1129  02ce               LC002:
1130  02ce cd0000        	call	c_rtol
1131  02d1 ae2400        	ldw	x,#9216
1132  02d4 bf02          	ldw	c_lreg+2,x
1133  02d6 ae00f4        	ldw	x,#244
1134  02d9 bf00          	ldw	c_lreg,x
1135  02db 81            	ret	
1136  02dc               LC003:
1137  02dc 1c0009        	addw	x,#OFST-3
1138  02df cd0000        	call	c_ltor
1140  02e2 ae0000        	ldw	x,#L612
1141  02e5 cc0000        	jp	c_lcmp
1182                     ; 434 uint16_t tim2_init(void)
1182                     ; 435 {
1183                     	switch	.text
1184  02e8               _tim2_init:
1186  02e8 89            	pushw	x
1187       00000002      OFST:	set	2
1190                     ; 437 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1192  02e9 4b00          	push	#0
1193  02eb 4b00          	push	#0
1194  02ed ae4e20        	ldw	x,#20000
1195  02f0 89            	pushw	x
1196  02f1 a602          	ld	a,#2
1197  02f3 cd020a        	call	_set_pwm_frequency
1199  02f6 5b04          	addw	sp,#4
1200  02f8 1f01          	ldw	(OFST-1,sp),x
1202                     ; 440 	OCR = 0;
1204  02fa 5f            	clrw	x
1205  02fb bf02          	ldw	_OCR,x
1206                     ; 443 	TIM2_DeInit();
1208  02fd cd0000        	call	_TIM2_DeInit
1210                     ; 446 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1212  0300 1e01          	ldw	x,(OFST-1,sp)
1213  0302 89            	pushw	x
1214  0303 4f            	clr	a
1215  0304 cd0000        	call	_TIM2_TimeBaseInit
1217  0307 85            	popw	x
1218                     ; 449 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
1220  0308 4b00          	push	#0
1221  030a be02          	ldw	x,_OCR
1222  030c 89            	pushw	x
1223  030d ae6011        	ldw	x,#24593
1224  0310 cd0000        	call	_TIM2_OC3Init
1226  0313 5b03          	addw	sp,#3
1227                     ; 450 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
1229  0315 4b00          	push	#0
1230  0317 be02          	ldw	x,_OCR
1231  0319 89            	pushw	x
1232  031a ae6011        	ldw	x,#24593
1233  031d cd0000        	call	_TIM2_OC2Init
1235  0320 5b03          	addw	sp,#3
1236                     ; 453 	TIM2_Cmd(ENABLE);
1238  0322 a601          	ld	a,#1
1239  0324 cd0000        	call	_TIM2_Cmd
1241                     ; 456 	return ARR;
1243  0327 1e01          	ldw	x,(OFST-1,sp)
1246  0329 5b02          	addw	sp,#2
1247  032b 81            	ret	
1288                     ; 470 uint16_t tim1_init(void)
1288                     ; 471 {
1289                     	switch	.text
1290  032c               _tim1_init:
1292  032c 89            	pushw	x
1293       00000002      OFST:	set	2
1296                     ; 473 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1298  032d 4b00          	push	#0
1299  032f 4b00          	push	#0
1300  0331 ae4e20        	ldw	x,#20000
1301  0334 89            	pushw	x
1302  0335 a601          	ld	a,#1
1303  0337 cd020a        	call	_set_pwm_frequency
1305  033a 5b04          	addw	sp,#4
1306  033c 1f01          	ldw	(OFST-1,sp),x
1308                     ; 476 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1310  033e 5f            	clrw	x
1311  033f bf02          	ldw	_OCR,x
1312                     ; 479 	TIM1_DeInit();
1314  0341 cd0000        	call	_TIM1_DeInit
1316                     ; 482 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1318  0344 4b00          	push	#0
1319  0346 1e02          	ldw	x,(OFST+0,sp)
1320  0348 89            	pushw	x
1321  0349 4b00          	push	#0
1322  034b 5f            	clrw	x
1323  034c cd0000        	call	_TIM1_TimeBaseInit
1325  034f 5b04          	addw	sp,#4
1326                     ; 485 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1328  0351 4b00          	push	#0
1329  0353 4b00          	push	#0
1330  0355 4b88          	push	#136
1331  0357 4b00          	push	#0
1332  0359 be02          	ldw	x,_OCR
1333  035b 89            	pushw	x
1334  035c 4b00          	push	#0
1335  035e ae6011        	ldw	x,#24593
1336  0361 cd0000        	call	_TIM1_OC3Init
1338  0364 5b07          	addw	sp,#7
1339                     ; 488 	TIM1_Cmd(ENABLE);
1341  0366 a601          	ld	a,#1
1342  0368 cd0000        	call	_TIM1_Cmd
1344                     ; 491 	TIM1_CtrlPWMOutputs(ENABLE);
1346  036b a601          	ld	a,#1
1347  036d cd0000        	call	_TIM1_CtrlPWMOutputs
1349                     ; 494 	return ARR;
1351  0370 1e01          	ldw	x,(OFST-1,sp)
1354  0372 5b02          	addw	sp,#2
1355  0374 81            	ret	
1391                     ; 508 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1391                     ; 509 {	
1392                     	switch	.text
1393  0375               _accelerate_pump:
1395  0375 89            	pushw	x
1396       00000000      OFST:	set	0
1399                     ; 510 	delay_ms(1); // Short delay to smooth out the ramp-up.
1401  0376 ae0001        	ldw	x,#1
1402  0379 cd01f8        	call	_delay_ms
1404                     ; 511 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1406  037c 1e01          	ldw	x,(OFST+1,sp)
1407  037e cd0000        	call	_TIM1_SetCompare3
1409                     ; 512 	duty_cycle_step++; // Increment the duty cycle value.
1411  0381 1e01          	ldw	x,(OFST+1,sp)
1412  0383 5c            	incw	x
1413                     ; 514 	return duty_cycle_step; // Return the updated duty cycle.
1417  0384 5b02          	addw	sp,#2
1418  0386 81            	ret	
1454                     ; 527 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1454                     ; 528 {	
1455                     	switch	.text
1456  0387               _decelerate_pump:
1458  0387 89            	pushw	x
1459       00000000      OFST:	set	0
1462                     ; 529 	delay_ms(1); // Short delay to smooth out the ramp-down.
1464  0388 ae0001        	ldw	x,#1
1465  038b cd01f8        	call	_delay_ms
1467                     ; 530 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1469  038e 1e01          	ldw	x,(OFST+1,sp)
1470  0390 cd0000        	call	_TIM1_SetCompare3
1472                     ; 531 	duty_cycle_step--; // Decrement the duty cycle value.
1474  0393 1e01          	ldw	x,(OFST+1,sp)
1475  0395 5a            	decw	x
1476                     ; 533 	return duty_cycle_step; // Return the updated duty cycle.
1480  0396 5b02          	addw	sp,#2
1481  0398 81            	ret	
1516                     ; 545 uint16_t set_pump_speed(uint16_t duty_cycle_step)
1516                     ; 546 {	
1517                     	switch	.text
1518  0399               _set_pump_speed:
1520  0399 89            	pushw	x
1521       00000000      OFST:	set	0
1524                     ; 547 	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
1526  039a cd0000        	call	_TIM1_SetCompare3
1528                     ; 548 	return duty_cycle_step; // Return the specified duty cycle.
1530  039d 1e01          	ldw	x,(OFST+1,sp)
1533  039f 5b02          	addw	sp,#2
1534  03a1 81            	ret	
1570                     ; 563 void pump_off(uint16_t duty_cycle_step)
1570                     ; 564 {
1571                     	switch	.text
1572  03a2               _pump_off:
1574  03a2 89            	pushw	x
1575       00000000      OFST:	set	0
1578                     ; 565 	if (duty_cycle_step > 0)
1580  03a3 5d            	tnzw	x
1581  03a4 2704          	jreq	L354
1582                     ; 568 		duty_cycle_step = decelerate_pump(duty_cycle_step);
1584  03a6 addf          	call	_decelerate_pump
1587  03a8 2004          	jra	L554
1588  03aa               L354:
1589                     ; 573 		TIM1_SetCompare3(0);
1591  03aa 5f            	clrw	x
1592  03ab cd0000        	call	_TIM1_SetCompare3
1594  03ae               L554:
1595                     ; 575 }
1598  03ae 85            	popw	x
1599  03af 81            	ret	
1637                     ; 590 uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
1637                     ; 591 {
1638                     	switch	.text
1639  03b0               _pump_smooth_on_off:
1641  03b0 89            	pushw	x
1642       00000000      OFST:	set	0
1645                     ; 593 	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
1647  03b1 b308          	cpw	x,_max_pwm_speed_pump
1648  03b3 240a          	jruge	L574
1650  03b5 3d0f          	tnz	_pulse_flag
1651  03b7 2606          	jrne	L574
1652                     ; 595 		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
1654  03b9 adba          	call	_accelerate_pump
1656  03bb 1f01          	ldw	(OFST+1,sp),x
1658  03bd 2004          	jra	L774
1659  03bf               L574:
1660                     ; 599 		pulse_flag = 1;	// Switch to deceleration mode
1662  03bf 3501000f      	mov	_pulse_flag,#1
1663  03c3               L774:
1664                     ; 603 	if ((duty_cycle_step > 0) && (pulse_flag == 1))
1666  03c3 1e01          	ldw	x,(OFST+1,sp)
1667  03c5 2709          	jreq	L105
1669  03c7 b60f          	ld	a,_pulse_flag
1670  03c9 4a            	dec	a
1671  03ca 2604          	jrne	L105
1672                     ; 605 		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
1674  03cc adb9          	call	_decelerate_pump
1677  03ce 2002          	jra	L305
1678  03d0               L105:
1679                     ; 609 		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
1681  03d0 3f0f          	clr	_pulse_flag
1682  03d2               L305:
1683                     ; 611 	return duty_cycle_step;	// Return the updated duty cycle value
1687  03d2 5b02          	addw	sp,#2
1688  03d4 81            	ret	
1856                     	xdef	_main
1857                     	xdef	_current_state
1858                     	xdef	_pump_off
1859                     	xdef	_decelerate_pump
1860                     	xdef	_accelerate_pump
1861                     	xdef	_set_pump_speed
1862                     	xdef	_pump_smooth_on_off
1863                     	xdef	_tim1_init
1864                     	xdef	_tim2_init
1865                     	xdef	_set_pwm_frequency
1866                     	xdef	_delay_ms
1867                     	xdef	_tim4_init
1868                     	xdef	_EXTI_setup
1869                     	xdef	_gpio_setup
1870                     	xdef	_clock_setup
1871                     	xdef	_pulse_flag
1872                     	xdef	_duty_cycle_step
1873                     	xdef	_press_count
1874                     	xdef	_max_pwm_speed_LED
1875                     	xdef	_max_pwm_speed_pump
1876                     	xdef	_arr_tim2
1877                     	xdef	_arr_tim1
1878                     	xdef	_OCR
1879                     	xref	_pow
1880                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1881                     	xdef	f_EXTI_PORTD_IRQHandler
1882                     	xdef	_ms_count
1883                     	xref	_TIM4_ClearITPendingBit
1884                     	xref	_TIM4_ITConfig
1885                     	xref	_TIM4_Cmd
1886                     	xref	_TIM4_TimeBaseInit
1887                     	xref	_TIM4_DeInit
1888                     	xref	_TIM2_SetCompare3
1889                     	xref	_TIM2_SetCompare2
1890                     	xref	_TIM2_Cmd
1891                     	xref	_TIM2_OC3Init
1892                     	xref	_TIM2_OC2Init
1893                     	xref	_TIM2_TimeBaseInit
1894                     	xref	_TIM2_DeInit
1895                     	xref	_TIM1_SetCompare3
1896                     	xref	_TIM1_CtrlPWMOutputs
1897                     	xref	_TIM1_Cmd
1898                     	xref	_TIM1_OC3Init
1899                     	xref	_TIM1_TimeBaseInit
1900                     	xref	_TIM1_DeInit
1901                     	xref	_ITC_SetSoftwarePriority
1902                     	xref	_ITC_DeInit
1903                     	xref	_GPIO_ReadInputPin
1904                     	xref	_GPIO_Init
1905                     	xref	_GPIO_DeInit
1906                     	xref	_EXTI_SetTLISensitivity
1907                     	xref	_EXTI_SetExtIntSensitivity
1908                     	xref	_EXTI_DeInit
1909                     	xref	_CLK_GetFlagStatus
1910                     	xref	_CLK_SYSCLKConfig
1911                     	xref	_CLK_HSIPrescalerConfig
1912                     	xref	_CLK_ClockSwitchConfig
1913                     	xref	_CLK_PeripheralClockConfig
1914                     	xref	_CLK_ClockSwitchCmd
1915                     	xref	_CLK_LSICmd
1916                     	xref	_CLK_HSICmd
1917                     	xref	_CLK_HSECmd
1918                     	xref	_CLK_DeInit
1919                     	switch	.const
1920  0004               L103:
1921  0004 3f800000      	dc.w	16256,0
1922  0008               L172:
1923  0008 40000000      	dc.w	16384,0
1924                     	xref.b	c_lreg
1925                     	xref.b	c_x
1926                     	xref.b	c_y
1946                     	xref	c_lsbc
1947                     	xref	c_ldiv
1948                     	xref	c_uitolx
1949                     	xref	c_imul
1950                     	xref	c_lcmp
1951                     	xref	c_ltor
1952                     	xref	c_ftol
1953                     	xref	c_fsub
1954                     	xref	c_fdiv
1955                     	xref	c_fmul
1956                     	xref	c_rtol
1957                     	xref	c_itof
1958                     	xref	c_uitof
1959                     	xref	c_bmulx
1960                     	xref	c_ltof
1961                     	end
