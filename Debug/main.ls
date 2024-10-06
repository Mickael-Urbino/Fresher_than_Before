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
  71                     ; 98 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) {
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
  88                     ; 99     ms_count++;  // Increment milliseconds count
  90  0012 be00          	ldw	x,_ms_count
  91  0014 5c            	incw	x
  92  0015 bf00          	ldw	_ms_count,x
  93                     ; 100     TIM4_ClearITPendingBit(TIM4_IT_UPDATE); // Clear interrupt pending bit for Timer 4
  95  0017 a601          	ld	a,#1
  96  0019 cd0000        	call	_TIM4_ClearITPendingBit
  98                     ; 101 }
 101  001c 85            	popw	x
 102  001d bf00          	ldw	c_y,x
 103  001f 320002        	pop	c_y+2
 104  0022 85            	popw	x
 105  0023 bf00          	ldw	c_x,x
 106  0025 320002        	pop	c_x+2
 107  0028 80            	iret	
 133                     ; 110 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
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
 150                     ; 111 	delay_ms(50); // Debounce delay to ensure stable button press detection
 152  003b ae0032        	ldw	x,#50
 153  003e cd0216        	call	_delay_ms
 155                     ; 113 	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0) // Check if the button is pressed
 157  0041 4b40          	push	#64
 158  0043 ae500f        	ldw	x,#20495
 159  0046 cd0000        	call	_GPIO_ReadInputPin
 161  0049 5b01          	addw	sp,#1
 162  004b 4d            	tnz	a
 163  004c 2602          	jrne	L13
 164                     ; 115 		press_count++; // Increment press count if the button is pressed
 166  004e 3c0c          	inc	_press_count
 167  0050               L13:
 168                     ; 117 }
 171  0050 85            	popw	x
 172  0051 bf00          	ldw	c_y,x
 173  0053 320002        	pop	c_y+2
 174  0056 85            	popw	x
 175  0057 bf00          	ldw	c_x,x
 176  0059 320002        	pop	c_x+2
 177  005c 80            	iret	
 220                     ; 120 main()
 220                     ; 121 {
 222                     	switch	.text
 223  005d               _main:
 227                     ; 123 	clock_setup();						// Configure system clock and timing
 229  005d cd0161        	call	_clock_setup
 231                     ; 124 	EXTI_setup();							// Setup external interrupts for button handling
 233  0060 cd01ea        	call	_EXTI_setup
 235                     ; 125 	enableInterrupts();				// Globally enable interrupts
 238  0063 9a            	rim	
 240                     ; 133 	tim4_init();
 243  0064 cd0202        	call	_tim4_init
 245                     ; 134 	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
 247  0067 ae1388        	ldw	x,#5000
 248  006a cd0216        	call	_delay_ms
 250                     ; 137 	gpio_setup();
 252  006d cd01c1        	call	_gpio_setup
 254                     ; 144 	max_pwm_speed_pump = tim1_init();	
 256  0070 cd034a        	call	_tim1_init
 258  0073 bf08          	ldw	_max_pwm_speed_pump,x
 259  0075               L75:
 260                     ; 154 		switch (current_state)
 262  0075 b610          	ld	a,_current_state
 264                     ; 273 				break;
 265  0077 271c          	jreq	L33
 266  0079 4a            	dec	a
 267  007a 272f          	jreq	L53
 268  007c 4a            	dec	a
 269  007d 2603cc0105    	jreq	L14
 270  0082 4a            	dec	a
 271  0083 274b          	jreq	L73
 272  0085 4a            	dec	a
 273  0086 2603cc012f    	jreq	L34
 274                     ; 262 			default:
 274                     ; 263 			
 274                     ; 264 				// Unexpected state: reset to SLEEP state as a failsafe
 274                     ; 265 				current_state = STATE_SLEEP;	// Reset to SLEEP state
 276  008b 3f10          	clr	_current_state
 277                     ; 268 				duty_cycle_step = pump_off(duty_cycle_step);
 279  008d cd0152        	call	LC002
 280                     ; 269 				press_count = 0;
 282  0090 3f0c          	clr	_press_count
 283                     ; 271 				TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 285                     ; 273 				break;
 287  0092 cc014c        	jp	LC001
 288  0095               L33:
 289                     ; 156 			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
 289                     ; 157 				
 289                     ; 158 				if (duty_cycle_step != 0)
 291  0095 be0d          	ldw	x,_duty_cycle_step
 292  0097 2703          	jreq	L76
 293                     ; 160 					duty_cycle_step = pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
 295  0099 cd0152        	call	LC002
 296  009c               L76:
 297                     ; 163 				if (press_count > 0)
 299  009c 3d0c          	tnz	_press_count
 300  009e 27d5          	jreq	L75
 301                     ; 165 					current_state = STATE_IDLE;
 303  00a0 35010010      	mov	_current_state,#1
 304                     ; 166 					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
 306  00a4 cd0306        	call	_tim2_init
 308  00a7 bf0a          	ldw	_max_pwm_speed_LED,x
 309  00a9 20ca          	jra	L75
 310  00ab               L53:
 311                     ; 170 			case STATE_IDLE:	// Idle state: low LED brightness and pump off
 311                     ; 171 			
 311                     ; 172 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 313  00ab be0a          	ldw	x,_max_pwm_speed_LED
 314  00ad a664          	ld	a,#100
 315  00af 62            	div	x,a
 316  00b0 cd0000        	call	_TIM2_SetCompare3
 318                     ; 173 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 320  00b3 be0a          	ldw	x,_max_pwm_speed_LED
 321  00b5 a664          	ld	a,#100
 322  00b7 62            	div	x,a
 323  00b8 cd0000        	call	_TIM2_SetCompare2
 325                     ; 175 				pump_off(duty_cycle_step);	// Keep the pump turned off
 327  00bb be0d          	ldw	x,_duty_cycle_step
 328  00bd cd03c0        	call	_pump_off
 330                     ; 178 				if (press_count > 1)
 332  00c0 b60c          	ld	a,_press_count
 333  00c2 a102          	cp	a,#2
 334  00c4 25af          	jrult	L75
 335                     ; 180 					current_state = STATE_LOW_SPEED;
 337  00c6 35030010      	mov	_current_state,#3
 338                     ; 182 					TIM2_SetCompare2(0);
 340  00ca 5f            	clrw	x
 341  00cb cd0000        	call	_TIM2_SetCompare2
 343  00ce 20a5          	jra	L75
 344  00d0               L73:
 345                     ; 187 			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
 345                     ; 188 				
 345                     ; 189 				// Set LED brightness to 50% of maximum
 345                     ; 190 				TIM2_SetCompare3(max_pwm_speed_LED/2);
 347  00d0 be0a          	ldw	x,_max_pwm_speed_LED
 348  00d2 54            	srlw	x
 349  00d3 cd0000        	call	_TIM2_SetCompare3
 351                     ; 193 				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
 353  00d6 cd015a        	call	LC003
 354  00d9 b30d          	cpw	x,_duty_cycle_step
 355  00db 2407          	jruge	L57
 356                     ; 195 					duty_cycle_step = decelerate_pump(duty_cycle_step);
 358  00dd be0d          	ldw	x,_duty_cycle_step
 359  00df cd03a5        	call	_decelerate_pump
 362  00e2 2012          	jra	L77
 363  00e4               L57:
 364                     ; 197 				else if (duty_cycle_step < (max_pwm_speed_pump/3)*2)
 366  00e4 ad74          	call	LC003
 367  00e6 b30d          	cpw	x,_duty_cycle_step
 368  00e8 2307          	jrule	L101
 369                     ; 199 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 371  00ea be0d          	ldw	x,_duty_cycle_step
 372  00ec cd0393        	call	_accelerate_pump
 375  00ef 2005          	jra	L77
 376  00f1               L101:
 377                     ; 203 					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
 379  00f1 ad67          	call	LC003
 380  00f3 cd03b7        	call	_set_pump_speed
 382  00f6               L77:
 383  00f6 bf0d          	ldw	_duty_cycle_step,x
 384                     ; 207 				if (press_count > 2)
 386  00f8 b60c          	ld	a,_press_count
 387  00fa a103          	cp	a,#3
 388  00fc 25d0          	jrult	L75
 389                     ; 209 					current_state = STATE_FULL_SPEED;
 391  00fe 35020010      	mov	_current_state,#2
 392  0102 cc0075        	jra	L75
 393  0105               L14:
 394                     ; 213 			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
 394                     ; 214 				
 394                     ; 215 				// Set LED to maximum brightness
 394                     ; 216 				TIM2_SetCompare3(max_pwm_speed_LED);
 396  0105 be0a          	ldw	x,_max_pwm_speed_LED
 397  0107 cd0000        	call	_TIM2_SetCompare3
 399                     ; 219 				if (duty_cycle_step < max_pwm_speed_pump)
 401  010a be0d          	ldw	x,_duty_cycle_step
 402  010c b308          	cpw	x,_max_pwm_speed_pump
 403  010e 2407          	jruge	L701
 404                     ; 221 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 406  0110 be0d          	ldw	x,_duty_cycle_step
 407  0112 cd0393        	call	_accelerate_pump
 410  0115 2005          	jra	L111
 411  0117               L701:
 412                     ; 225 					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
 414  0117 be08          	ldw	x,_max_pwm_speed_pump
 415  0119 cd03b7        	call	_set_pump_speed
 417  011c               L111:
 418  011c bf0d          	ldw	_duty_cycle_step,x
 419                     ; 229 				if (press_count > 3)
 421  011e b60c          	ld	a,_press_count
 422  0120 a104          	cp	a,#4
 423  0122 25de          	jrult	L75
 424                     ; 231 					current_state = STATE_PULSE;
 426  0124 35040010      	mov	_current_state,#4
 427                     ; 232 					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
 429  0128 5f            	clrw	x
 430  0129 cd0000        	call	_TIM2_SetCompare3
 432  012c cc0075        	jra	L75
 433  012f               L34:
 434                     ; 237 			case STATE_PULSE:	// Pulsed pump operation with LED indication
 434                     ; 238 			
 434                     ; 239 				// Set LED PULSE to 50% brightnes
 434                     ; 240 				TIM2_SetCompare2(max_pwm_speed_LED/2);
 436  012f be0a          	ldw	x,_max_pwm_speed_LED
 437  0131 54            	srlw	x
 438  0132 cd0000        	call	_TIM2_SetCompare2
 440                     ; 243 				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
 442  0135 be0d          	ldw	x,_duty_cycle_step
 443  0137 cd03d1        	call	_pump_smooth_on_off
 445  013a bf0d          	ldw	_duty_cycle_step,x
 446                     ; 246 				if (press_count > 4)
 448  013c b60c          	ld	a,_press_count
 449  013e a105          	cp	a,#5
 450  0140 25ea          	jrult	L75
 451                     ; 250 					current_state = STATE_SLEEP;	// Reset to SLEEP state
 453  0142 3f10          	clr	_current_state
 454                     ; 253 					duty_cycle_step = pump_off(duty_cycle_step);
 456  0144 ad0c          	call	LC002
 457                     ; 254 					press_count = 0;
 459  0146 3f0c          	clr	_press_count
 460                     ; 257 					TIM2_SetCompare2(0);	// Turn off LED PULSE				
 462  0148 5f            	clrw	x
 463  0149 cd0000        	call	_TIM2_SetCompare2
 465                     ; 258 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 467  014c               LC001:
 469  014c cd0000        	call	_TIM2_DeInit
 471  014f cc0075        	jra	L75
 472                     ; 273 				break;
 473  0152               LC002:
 474  0152 be0d          	ldw	x,_duty_cycle_step
 475  0154 cd03c0        	call	_pump_off
 477  0157 bf0d          	ldw	_duty_cycle_step,x
 478  0159 81            	ret	
 479  015a               LC003:
 480  015a be08          	ldw	x,_max_pwm_speed_pump
 481  015c a603          	ld	a,#3
 482  015e 62            	div	x,a
 483  015f 58            	sllw	x
 484  0160 81            	ret	
 517                     ; 285 void clock_setup(void)
 517                     ; 286 {
 518                     	switch	.text
 519  0161               _clock_setup:
 523                     ; 287 	CLK_DeInit();		// Reset clock configuration to default state
 525  0161 cd0000        	call	_CLK_DeInit
 527                     ; 289 	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
 529  0164 4f            	clr	a
 530  0165 cd0000        	call	_CLK_HSECmd
 532                     ; 290 	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
 534  0168 4f            	clr	a
 535  0169 cd0000        	call	_CLK_LSICmd
 537                     ; 291 	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
 539  016c a601          	ld	a,#1
 540  016e cd0000        	call	_CLK_HSICmd
 543  0171               L131:
 544                     ; 293 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
 546  0171 ae0102        	ldw	x,#258
 547  0174 cd0000        	call	_CLK_GetFlagStatus
 549  0177 4d            	tnz	a
 550  0178 27f7          	jreq	L131
 551                     ; 295 	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
 553  017a a601          	ld	a,#1
 554  017c cd0000        	call	_CLK_ClockSwitchCmd
 556                     ; 296 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
 558  017f 4f            	clr	a
 559  0180 cd0000        	call	_CLK_HSIPrescalerConfig
 561                     ; 297 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
 563  0183 a680          	ld	a,#128
 564  0185 cd0000        	call	_CLK_SYSCLKConfig
 566                     ; 299 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 566                     ; 300 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 568  0188 4b01          	push	#1
 569  018a 4b00          	push	#0
 570  018c ae01e1        	ldw	x,#481
 571  018f cd0000        	call	_CLK_ClockSwitchConfig
 573  0192 85            	popw	x
 574                     ; 303 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 576  0193 5f            	clrw	x
 577  0194 cd0000        	call	_CLK_PeripheralClockConfig
 579                     ; 304 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 581  0197 ae0100        	ldw	x,#256
 582  019a cd0000        	call	_CLK_PeripheralClockConfig
 584                     ; 305 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 586  019d ae1300        	ldw	x,#4864
 587  01a0 cd0000        	call	_CLK_PeripheralClockConfig
 589                     ; 306 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 591  01a3 ae1200        	ldw	x,#4608
 592  01a6 cd0000        	call	_CLK_PeripheralClockConfig
 594                     ; 307 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 596  01a9 ae0300        	ldw	x,#768
 597  01ac cd0000        	call	_CLK_PeripheralClockConfig
 599                     ; 308 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
 601  01af ae0701        	ldw	x,#1793
 602  01b2 cd0000        	call	_CLK_PeripheralClockConfig
 604                     ; 309 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
 606  01b5 ae0501        	ldw	x,#1281
 607  01b8 cd0000        	call	_CLK_PeripheralClockConfig
 609                     ; 310 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
 611  01bb ae0401        	ldw	x,#1025
 613                     ; 312 }
 616  01be cc0000        	jp	_CLK_PeripheralClockConfig
 641                     ; 321 void gpio_setup(void)
 641                     ; 322 {
 642                     	switch	.text
 643  01c1               _gpio_setup:
 647                     ; 323 	GPIO_DeInit(GPIOA);  // Reset Port A configuration
 649  01c1 ae5000        	ldw	x,#20480
 650  01c4 cd0000        	call	_GPIO_DeInit
 652                     ; 324 	GPIO_DeInit(GPIOB);  // Reset Port B configuration
 654  01c7 ae5005        	ldw	x,#20485
 655  01ca cd0000        	call	_GPIO_DeInit
 657                     ; 325 	GPIO_DeInit(GPIOD);  // Reset Port D configuration
 659  01cd ae500f        	ldw	x,#20495
 660  01d0 cd0000        	call	_GPIO_DeInit
 662                     ; 327 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);					// Configure Pin D6 as an floating input with interrupt
 664  01d3 4b20          	push	#32
 665  01d5 4b40          	push	#64
 666  01d7 ae500f        	ldw	x,#20495
 667  01da cd0000        	call	_GPIO_Init
 669  01dd 85            	popw	x
 670                     ; 328 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
 672  01de 4be0          	push	#224
 673  01e0 4b10          	push	#16
 674  01e2 ae5005        	ldw	x,#20485
 675  01e5 cd0000        	call	_GPIO_Init
 677  01e8 85            	popw	x
 678                     ; 329 }
 681  01e9 81            	ret	
 710                     ; 338 void EXTI_setup(void)
 710                     ; 339 {
 711                     	switch	.text
 712  01ea               _EXTI_setup:
 716                     ; 340 	ITC_DeInit();	// Reset interrupt controller configuration
 718  01ea cd0000        	call	_ITC_DeInit
 720                     ; 341 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
 722  01ed ae0602        	ldw	x,#1538
 723  01f0 cd0000        	call	_ITC_SetSoftwarePriority
 725                     ; 343 	EXTI_DeInit(); // Reset external interrupt configuration
 727  01f3 cd0000        	call	_EXTI_DeInit
 729                     ; 345 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);  // Enable falling-edge sensitivity for Port D
 731  01f6 ae0302        	ldw	x,#770
 732  01f9 cd0000        	call	_EXTI_SetExtIntSensitivity
 734                     ; 346 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
 736  01fc 4f            	clr	a
 737  01fd cd0000        	call	_EXTI_SetTLISensitivity
 739                     ; 348 	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
 742  0200 9a            	rim	
 744                     ; 349 }
 748  0201 81            	ret	
 775                     ; 358 void tim4_init(void) //Timer Used to count milliseconds for delay function
 775                     ; 359 {
 776                     	switch	.text
 777  0202               _tim4_init:
 781                     ; 361 	TIM4_DeInit();	// Reset Timer 4 configuration
 783  0202 cd0000        	call	_TIM4_DeInit
 785                     ; 362 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 787  0205 ae077d        	ldw	x,#1917
 788  0208 cd0000        	call	_TIM4_TimeBaseInit
 790                     ; 363 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
 792  020b ae0101        	ldw	x,#257
 793  020e cd0000        	call	_TIM4_ITConfig
 795                     ; 364 	TIM4_Cmd(ENABLE);  // Start Timer 4
 797  0211 a601          	ld	a,#1
 799                     ; 366 }
 802  0213 cc0000        	jp	_TIM4_Cmd
 846                     ; 376 void delay_ms(int delay)
 846                     ; 377 {
 847                     	switch	.text
 848  0216               _delay_ms:
 850  0216 89            	pushw	x
 851  0217 89            	pushw	x
 852       00000002      OFST:	set	2
 855                     ; 378     int start = ms_count;	// Record the current timer count
 857  0218 be00          	ldw	x,_ms_count
 858  021a 1f01          	ldw	(OFST-1,sp),x
 861  021c               L312:
 862                     ; 379     while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
 864  021c be00          	ldw	x,_ms_count
 865  021e 72f001        	subw	x,(OFST-1,sp)
 866  0221 1303          	cpw	x,(OFST+1,sp)
 867  0223 2ff7          	jrslt	L312
 868                     ; 381 }
 871  0225 5b04          	addw	sp,#4
 872  0227 81            	ret	
 943                     .const:	section	.text
 944  0000               L422:
 945  0000 00010000      	dc.l	65536
 946                     ; 396 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
 946                     ; 397 {
 947                     	switch	.text
 948  0228               _set_pwm_frequency:
 950  0228 88            	push	a
 951  0229 520c          	subw	sp,#12
 952       0000000c      OFST:	set	12
 955                     ; 398 	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
 957                     ; 399 	switch (hsi_prescaler)
 959  022b 7b12          	ld	a,(OFST+6,sp)
 961                     ; 415 			break;
 962  022d 270e          	jreq	L712
 963  022f a008          	sub	a,#8
 964  0231 270d          	jreq	L122
 965  0233 a008          	sub	a,#8
 966  0235 270d          	jreq	L322
 967  0237 a008          	sub	a,#8
 968  0239 270d          	jreq	L522
 969  023b 200f          	jra	L762
 970  023d               L712:
 971                     ; 401 		case 0x00:
 971                     ; 402 			hsi_prescaler = 1;
 973  023d 4c            	inc	a
 974                     ; 403 			break;
 976  023e 200a          	jp	LC004
 977  0240               L122:
 978                     ; 405 		case 0x08:
 978                     ; 406 			hsi_prescaler = 2;
 980  0240 a602          	ld	a,#2
 981                     ; 407 			break;
 983  0242 2006          	jp	LC004
 984  0244               L322:
 985                     ; 409 		case 0x10:
 985                     ; 410 			hsi_prescaler = 4;
 987  0244 a604          	ld	a,#4
 988                     ; 411 			break;
 990  0246 2002          	jp	LC004
 991  0248               L522:
 992                     ; 413 		case 0x18:
 992                     ; 414 			hsi_prescaler = 8;
 994  0248 a608          	ld	a,#8
 995  024a               LC004:
 996  024a 6b12          	ld	(OFST+6,sp),a
 997                     ; 415 			break;
 999  024c               L762:
1000                     ; 418 	if (timer !=  1)
1002  024c 7b0d          	ld	a,(OFST+1,sp)
1003  024e 4a            	dec	a
1004  024f 275f          	jreq	L172
1005                     ; 420 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
1022  0251 2005          	jra	L713
1023  0253               L313:
1024                     ; 424 			frequency++;
1026  0253 1e10          	ldw	x,(OFST+4,sp)
1027  0255 5c            	incw	x
1028  0256 1f10          	ldw	(OFST+4,sp),x
1029                     ; 425 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1046  0258               L713:
1048  0258 7b13          	ld	a,(OFST+7,sp)
1049  025a 5f            	clrw	x
1050  025b 97            	ld	xl,a
1051  025c cd0000        	call	c_itof
1052  025f be02          	ldw	x,c_lreg+2
1053  0261 89            	pushw	x
1054  0262 be00          	ldw	x,c_lreg
1055  0264 89            	pushw	x
1056  0265 ce000a        	ldw	x,L772+2
1057  0268 89            	pushw	x
1058  0269 ce0008        	ldw	x,L772
1059  026c 89            	pushw	x
1060  026d cd0000        	call	_pow
1061  0270 5b08          	addw	sp,#8
1062  0272 96            	ldw	x,sp
1063  0273 1c0005        	addw	x,#OFST-7
1064  0276 cd0000        	call	c_rtol
1065  0279 1e10          	ldw	x,(OFST+4,sp)
1066  027b 7b12          	ld	a,(OFST+6,sp)
1067  027d cd0000        	call	c_bmulx
1068  0280 cd0000        	call	c_uitof
1069  0283 96            	ldw	x,sp
1070  0284 1c0005        	addw	x,#OFST-7
1071  0287 cd0000        	call	c_fmul
1072  028a 96            	ldw	x,sp
1073  028b 5c            	incw	x
1074  028c ad5e          	call	LC005
1075  028e cd0000        	call	c_ltof
1076  0291 96            	ldw	x,sp
1077  0292 5c            	incw	x
1078  0293 cd0000        	call	c_fdiv
1079  0296 ae0004        	ldw	x,#L703
1080  0299 cd0000        	call	c_fsub
1081  029c cd0000        	call	c_ftol
1082  029f 96            	ldw	x,sp
1083  02a0 1c0009        	addw	x,#OFST-3
1084  02a3 cd0000        	call	c_rtol
1085                     ; 422 		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
1087  02a6 96            	ldw	x,sp
1088  02a7 ad51          	call	LC006
1090  02a9 24a8          	jruge	L313
1092  02ab               L323:
1093                     ; 440 	return (uint16_t)arr;
1095  02ab 1e0b          	ldw	x,(OFST-1,sp)
1098  02ad 5b0d          	addw	sp,#13
1099  02af 81            	ret	
1100  02b0               L172:
1101                     ; 430 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1103  02b0 1e10          	ldw	x,(OFST+4,sp)
1114  02b2 2005          	jra	L133
1115  02b4               L523:
1116                     ; 434 			frequency++;
1118  02b4 1e10          	ldw	x,(OFST+4,sp)
1119  02b6 5c            	incw	x
1120  02b7 1f10          	ldw	(OFST+4,sp),x
1121                     ; 435 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1132  02b9               L133:
1133  02b9 7b12          	ld	a,(OFST+6,sp)
1134  02bb cd0000        	call	c_bmulx
1135  02be 7b13          	ld	a,(OFST+7,sp)
1136  02c0 905f          	clrw	y
1137  02c2 9097          	ld	yl,a
1138  02c4 905c          	incw	y
1139  02c6 cd0000        	call	c_imul
1140  02c9 cd0000        	call	c_uitolx
1141  02cc 96            	ldw	x,sp
1142  02cd 1c0005        	addw	x,#OFST-7
1143  02d0 ad1a          	call	LC005
1144  02d2 96            	ldw	x,sp
1145  02d3 1c0005        	addw	x,#OFST-7
1146  02d6 cd0000        	call	c_ldiv
1147  02d9 a601          	ld	a,#1
1148  02db cd0000        	call	c_lsbc
1149  02de 96            	ldw	x,sp
1150  02df 1c0009        	addw	x,#OFST-3
1151  02e2 cd0000        	call	c_rtol
1152                     ; 432 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1154  02e5 96            	ldw	x,sp
1155  02e6 ad12          	call	LC006
1157  02e8 24ca          	jruge	L523
1158  02ea 20bf          	jra	L323
1159  02ec               LC005:
1160  02ec cd0000        	call	c_rtol
1161  02ef ae2400        	ldw	x,#9216
1162  02f2 bf02          	ldw	c_lreg+2,x
1163  02f4 ae00f4        	ldw	x,#244
1164  02f7 bf00          	ldw	c_lreg,x
1165  02f9 81            	ret	
1166  02fa               LC006:
1167  02fa 1c0009        	addw	x,#OFST-3
1168  02fd cd0000        	call	c_ltor
1170  0300 ae0000        	ldw	x,#L422
1171  0303 cc0000        	jp	c_lcmp
1212                     ; 451 uint16_t tim2_init(void)
1212                     ; 452 {
1213                     	switch	.text
1214  0306               _tim2_init:
1216  0306 89            	pushw	x
1217       00000002      OFST:	set	2
1220                     ; 454 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1222  0307 4b00          	push	#0
1223  0309 4b00          	push	#0
1224  030b ae4e20        	ldw	x,#20000
1225  030e 89            	pushw	x
1226  030f a602          	ld	a,#2
1227  0311 cd0228        	call	_set_pwm_frequency
1229  0314 5b04          	addw	sp,#4
1230  0316 1f01          	ldw	(OFST-1,sp),x
1232                     ; 457 	OCR = 0;
1234  0318 5f            	clrw	x
1235  0319 bf02          	ldw	_OCR,x
1236                     ; 460 	TIM2_DeInit();
1238  031b cd0000        	call	_TIM2_DeInit
1240                     ; 463 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1242  031e 1e01          	ldw	x,(OFST-1,sp)
1243  0320 89            	pushw	x
1244  0321 4f            	clr	a
1245  0322 cd0000        	call	_TIM2_TimeBaseInit
1247  0325 85            	popw	x
1248                     ; 466 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
1250  0326 4b00          	push	#0
1251  0328 be02          	ldw	x,_OCR
1252  032a 89            	pushw	x
1253  032b ae6011        	ldw	x,#24593
1254  032e cd0000        	call	_TIM2_OC3Init
1256  0331 5b03          	addw	sp,#3
1257                     ; 467 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
1259  0333 4b00          	push	#0
1260  0335 be02          	ldw	x,_OCR
1261  0337 89            	pushw	x
1262  0338 ae6011        	ldw	x,#24593
1263  033b cd0000        	call	_TIM2_OC2Init
1265  033e 5b03          	addw	sp,#3
1266                     ; 470 	TIM2_Cmd(ENABLE);
1268  0340 a601          	ld	a,#1
1269  0342 cd0000        	call	_TIM2_Cmd
1271                     ; 473 	return ARR;
1273  0345 1e01          	ldw	x,(OFST-1,sp)
1276  0347 5b02          	addw	sp,#2
1277  0349 81            	ret	
1318                     ; 487 uint16_t tim1_init(void)
1318                     ; 488 {
1319                     	switch	.text
1320  034a               _tim1_init:
1322  034a 89            	pushw	x
1323       00000002      OFST:	set	2
1326                     ; 490 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1328  034b 4b00          	push	#0
1329  034d 4b00          	push	#0
1330  034f ae4e20        	ldw	x,#20000
1331  0352 89            	pushw	x
1332  0353 a601          	ld	a,#1
1333  0355 cd0228        	call	_set_pwm_frequency
1335  0358 5b04          	addw	sp,#4
1336  035a 1f01          	ldw	(OFST-1,sp),x
1338                     ; 493 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1340  035c 5f            	clrw	x
1341  035d bf02          	ldw	_OCR,x
1342                     ; 496 	TIM1_DeInit();
1344  035f cd0000        	call	_TIM1_DeInit
1346                     ; 499 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1348  0362 4b00          	push	#0
1349  0364 1e02          	ldw	x,(OFST+0,sp)
1350  0366 89            	pushw	x
1351  0367 4b00          	push	#0
1352  0369 5f            	clrw	x
1353  036a cd0000        	call	_TIM1_TimeBaseInit
1355  036d 5b04          	addw	sp,#4
1356                     ; 502 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1358  036f 4b00          	push	#0
1359  0371 4b00          	push	#0
1360  0373 4b88          	push	#136
1361  0375 4b00          	push	#0
1362  0377 be02          	ldw	x,_OCR
1363  0379 89            	pushw	x
1364  037a 4b00          	push	#0
1365  037c ae6011        	ldw	x,#24593
1366  037f cd0000        	call	_TIM1_OC3Init
1368  0382 5b07          	addw	sp,#7
1369                     ; 505 	TIM1_Cmd(ENABLE);
1371  0384 a601          	ld	a,#1
1372  0386 cd0000        	call	_TIM1_Cmd
1374                     ; 508 	TIM1_CtrlPWMOutputs(ENABLE);
1376  0389 a601          	ld	a,#1
1377  038b cd0000        	call	_TIM1_CtrlPWMOutputs
1379                     ; 511 	return ARR;
1381  038e 1e01          	ldw	x,(OFST-1,sp)
1384  0390 5b02          	addw	sp,#2
1385  0392 81            	ret	
1421                     ; 525 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1421                     ; 526 {	
1422                     	switch	.text
1423  0393               _accelerate_pump:
1425  0393 89            	pushw	x
1426       00000000      OFST:	set	0
1429                     ; 527 	delay_ms(1); // Short delay to smooth out the ramp-up.
1431  0394 ae0001        	ldw	x,#1
1432  0397 cd0216        	call	_delay_ms
1434                     ; 528 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1436  039a 1e01          	ldw	x,(OFST+1,sp)
1437  039c cd0000        	call	_TIM1_SetCompare3
1439                     ; 529 	duty_cycle_step++; // Increment the duty cycle value.
1441  039f 1e01          	ldw	x,(OFST+1,sp)
1442  03a1 5c            	incw	x
1443                     ; 531 	return duty_cycle_step; // Return the updated duty cycle.
1447  03a2 5b02          	addw	sp,#2
1448  03a4 81            	ret	
1484                     ; 544 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1484                     ; 545 {	
1485                     	switch	.text
1486  03a5               _decelerate_pump:
1488  03a5 89            	pushw	x
1489       00000000      OFST:	set	0
1492                     ; 546 	delay_ms(1); // Short delay to smooth out the ramp-down.
1494  03a6 ae0001        	ldw	x,#1
1495  03a9 cd0216        	call	_delay_ms
1497                     ; 547 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1499  03ac 1e01          	ldw	x,(OFST+1,sp)
1500  03ae cd0000        	call	_TIM1_SetCompare3
1502                     ; 548 	duty_cycle_step--; // Decrement the duty cycle value.
1504  03b1 1e01          	ldw	x,(OFST+1,sp)
1505  03b3 5a            	decw	x
1506                     ; 550 	return duty_cycle_step; // Return the updated duty cycle.
1510  03b4 5b02          	addw	sp,#2
1511  03b6 81            	ret	
1546                     ; 562 uint16_t set_pump_speed(uint16_t duty_cycle_step)
1546                     ; 563 {	
1547                     	switch	.text
1548  03b7               _set_pump_speed:
1550  03b7 89            	pushw	x
1551       00000000      OFST:	set	0
1554                     ; 564 	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
1556  03b8 cd0000        	call	_TIM1_SetCompare3
1558                     ; 565 	return duty_cycle_step; // Return the specified duty cycle.
1560  03bb 1e01          	ldw	x,(OFST+1,sp)
1563  03bd 5b02          	addw	sp,#2
1564  03bf 81            	ret	
1600                     ; 580 uint16_t pump_off(uint16_t duty_cycle_step)
1600                     ; 581 {
1601                     	switch	.text
1602  03c0               _pump_off:
1604  03c0 89            	pushw	x
1605       00000000      OFST:	set	0
1608                     ; 582 	if (duty_cycle_step > 0)
1610  03c1 5d            	tnzw	x
1611  03c2 2704          	jreq	L164
1612                     ; 585 		duty_cycle_step = decelerate_pump(duty_cycle_step);
1614  03c4 addf          	call	_decelerate_pump
1617  03c6 2006          	jra	L364
1618  03c8               L164:
1619                     ; 590 		TIM1_SetCompare3(0);
1621  03c8 5f            	clrw	x
1622  03c9 cd0000        	call	_TIM1_SetCompare3
1624  03cc 1e01          	ldw	x,(OFST+1,sp)
1625  03ce               L364:
1626                     ; 593 	return duty_cycle_step;
1630  03ce 5b02          	addw	sp,#2
1631  03d0 81            	ret	
1669                     ; 609 uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
1669                     ; 610 {
1670                     	switch	.text
1671  03d1               _pump_smooth_on_off:
1673  03d1 89            	pushw	x
1674       00000000      OFST:	set	0
1677                     ; 612 	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
1679  03d2 b308          	cpw	x,_max_pwm_speed_pump
1680  03d4 240a          	jruge	L305
1682  03d6 3d0f          	tnz	_pulse_flag
1683  03d8 2606          	jrne	L305
1684                     ; 614 		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
1686  03da adb7          	call	_accelerate_pump
1688  03dc 1f01          	ldw	(OFST+1,sp),x
1690  03de 2004          	jra	L505
1691  03e0               L305:
1692                     ; 618 		pulse_flag = 1;	// Switch to deceleration mode
1694  03e0 3501000f      	mov	_pulse_flag,#1
1695  03e4               L505:
1696                     ; 622 	if ((duty_cycle_step > 0) && (pulse_flag == 1))
1698  03e4 1e01          	ldw	x,(OFST+1,sp)
1699  03e6 2709          	jreq	L705
1701  03e8 b60f          	ld	a,_pulse_flag
1702  03ea 4a            	dec	a
1703  03eb 2604          	jrne	L705
1704                     ; 624 		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
1706  03ed adb6          	call	_decelerate_pump
1709  03ef 2002          	jra	L115
1710  03f1               L705:
1711                     ; 628 		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
1713  03f1 3f0f          	clr	_pulse_flag
1714  03f3               L115:
1715                     ; 630 	return duty_cycle_step;	// Return the updated duty cycle value
1719  03f3 5b02          	addw	sp,#2
1720  03f5 81            	ret	
1888                     	xdef	_main
1889                     	xdef	_current_state
1890                     	xdef	_pump_off
1891                     	xdef	_decelerate_pump
1892                     	xdef	_accelerate_pump
1893                     	xdef	_set_pump_speed
1894                     	xdef	_pump_smooth_on_off
1895                     	xdef	_tim1_init
1896                     	xdef	_tim2_init
1897                     	xdef	_set_pwm_frequency
1898                     	xdef	_delay_ms
1899                     	xdef	_tim4_init
1900                     	xdef	_EXTI_setup
1901                     	xdef	_gpio_setup
1902                     	xdef	_clock_setup
1903                     	xdef	_pulse_flag
1904                     	xdef	_duty_cycle_step
1905                     	xdef	_press_count
1906                     	xdef	_max_pwm_speed_LED
1907                     	xdef	_max_pwm_speed_pump
1908                     	xdef	_arr_tim2
1909                     	xdef	_arr_tim1
1910                     	xdef	_OCR
1911                     	xref	_pow
1912                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1913                     	xdef	f_EXTI_PORTD_IRQHandler
1914                     	xdef	_ms_count
1915                     	xref	_TIM4_ClearITPendingBit
1916                     	xref	_TIM4_ITConfig
1917                     	xref	_TIM4_Cmd
1918                     	xref	_TIM4_TimeBaseInit
1919                     	xref	_TIM4_DeInit
1920                     	xref	_TIM2_SetCompare3
1921                     	xref	_TIM2_SetCompare2
1922                     	xref	_TIM2_Cmd
1923                     	xref	_TIM2_OC3Init
1924                     	xref	_TIM2_OC2Init
1925                     	xref	_TIM2_TimeBaseInit
1926                     	xref	_TIM2_DeInit
1927                     	xref	_TIM1_SetCompare3
1928                     	xref	_TIM1_CtrlPWMOutputs
1929                     	xref	_TIM1_Cmd
1930                     	xref	_TIM1_OC3Init
1931                     	xref	_TIM1_TimeBaseInit
1932                     	xref	_TIM1_DeInit
1933                     	xref	_ITC_SetSoftwarePriority
1934                     	xref	_ITC_DeInit
1935                     	xref	_GPIO_ReadInputPin
1936                     	xref	_GPIO_Init
1937                     	xref	_GPIO_DeInit
1938                     	xref	_EXTI_SetTLISensitivity
1939                     	xref	_EXTI_SetExtIntSensitivity
1940                     	xref	_EXTI_DeInit
1941                     	xref	_CLK_GetFlagStatus
1942                     	xref	_CLK_SYSCLKConfig
1943                     	xref	_CLK_HSIPrescalerConfig
1944                     	xref	_CLK_ClockSwitchConfig
1945                     	xref	_CLK_PeripheralClockConfig
1946                     	xref	_CLK_ClockSwitchCmd
1947                     	xref	_CLK_LSICmd
1948                     	xref	_CLK_HSICmd
1949                     	xref	_CLK_HSECmd
1950                     	xref	_CLK_DeInit
1951                     	switch	.const
1952  0004               L703:
1953  0004 3f800000      	dc.w	16256,0
1954  0008               L772:
1955  0008 40000000      	dc.w	16384,0
1956                     	xref.b	c_lreg
1957                     	xref.b	c_x
1958                     	xref.b	c_y
1978                     	xref	c_lsbc
1979                     	xref	c_ldiv
1980                     	xref	c_uitolx
1981                     	xref	c_imul
1982                     	xref	c_lcmp
1983                     	xref	c_ltor
1984                     	xref	c_ftol
1985                     	xref	c_fsub
1986                     	xref	c_fdiv
1987                     	xref	c_fmul
1988                     	xref	c_rtol
1989                     	xref	c_itof
1990                     	xref	c_uitof
1991                     	xref	c_bmulx
1992                     	xref	c_ltof
1993                     	end
