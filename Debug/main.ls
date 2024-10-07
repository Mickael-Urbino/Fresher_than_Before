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
  34  000d               _long_press:
  35  000d 00            	dc.b	0
  36  000e               _button_pressed:
  37  000e 00            	dc.b	0
  38  000f               _button_press_start:
  39  000f 0000          	dc.w	0
  40  0011               _button_press_duration:
  41  0011 0000          	dc.w	0
  42  0013               _duty_cycle_step:
  43  0013 0000          	dc.w	0
  44  0015               _pulse_flag:
  45  0015 00            	dc.b	0
  46  0016               _last_interrupt_time:
  47  0016 0000          	dc.w	0
  48  0018               _current_state:
  49  0018 00            	dc.b	0
  81                     ; 106 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) {
  82                     	switch	.text
  83  0000               f_TIM4_UPD_OVF_IRQHandler:
  85  0000 8a            	push	cc
  86  0001 84            	pop	a
  87  0002 a4bf          	and	a,#191
  88  0004 88            	push	a
  89  0005 86            	pop	cc
  90  0006 3b0002        	push	c_x+2
  91  0009 be00          	ldw	x,c_x
  92  000b 89            	pushw	x
  93  000c 3b0002        	push	c_y+2
  94  000f be00          	ldw	x,c_y
  95  0011 89            	pushw	x
  98                     ; 107     ms_count++;  // Increment milliseconds count
 100  0012 be00          	ldw	x,_ms_count
 101  0014 5c            	incw	x
 102  0015 bf00          	ldw	_ms_count,x
 103                     ; 108     TIM4_ClearITPendingBit(TIM4_IT_UPDATE); // Clear interrupt pending bit for Timer 4
 105  0017 a601          	ld	a,#1
 106  0019 cd0000        	call	_TIM4_ClearITPendingBit
 108                     ; 109 }
 111  001c 85            	popw	x
 112  001d bf00          	ldw	c_y,x
 113  001f 320002        	pop	c_y+2
 114  0022 85            	popw	x
 115  0023 bf00          	ldw	c_x,x
 116  0025 320002        	pop	c_x+2
 117  0028 80            	iret	
 159                     ; 118 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
 160                     	switch	.text
 161  0029               f_EXTI_PORTD_IRQHandler:
 163  0029 8a            	push	cc
 164  002a 84            	pop	a
 165  002b a4bf          	and	a,#191
 166  002d 88            	push	a
 167  002e 86            	pop	cc
 168       00000002      OFST:	set	2
 169  002f 3b0002        	push	c_x+2
 170  0032 be00          	ldw	x,c_x
 171  0034 89            	pushw	x
 172  0035 3b0002        	push	c_y+2
 173  0038 be00          	ldw	x,c_y
 174  003a 89            	pushw	x
 175  003b 89            	pushw	x
 178                     ; 119 	uint16_t current_time = ms_count; // Get current time
 180  003c be00          	ldw	x,_ms_count
 181  003e 1f01          	ldw	(OFST-1,sp),x
 183                     ; 122 	if (current_time - last_interrupt_time < DEBOUNCE_DELAY) {
 185  0040 72b00016      	subw	x,_last_interrupt_time
 186  0044 a30032        	cpw	x,#50
 187  0047 253b          	jrult	L54
 188                     ; 123 			return; // Return if debounce delay is not elapsed
 190                     ; 125 	last_interrupt_time = current_time; // Update last interrupt
 192  0049 1e01          	ldw	x,(OFST-1,sp)
 193  004b bf16          	ldw	_last_interrupt_time,x
 194                     ; 128 	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0) // Check if the button is pressed
 196  004d 8d930093      	callf	LC001
 197  0051 260e          	jrne	L14
 198                     ; 131 		if (!button_pressed)
 200  0053 3d0e          	tnz	_button_pressed
 201  0055 262d          	jrne	L54
 202                     ; 133 			button_pressed = 1;
 204  0057 3501000e      	mov	_button_pressed,#1
 205                     ; 134 			button_press_start = ms_count;
 207  005b be00          	ldw	x,_ms_count
 208  005d bf0f          	ldw	_button_press_start,x
 209  005f 2023          	jra	L54
 210  0061               L14:
 211                     ; 137 	else if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) != 0)// When button is released, compute the duration of the press 
 213  0061 8d930093      	callf	LC001
 214  0065 271d          	jreq	L54
 215                     ; 139 		if (button_pressed) // Check if we reach this step with a proper button press, and not some noise event.
 217  0067 3d0e          	tnz	_button_pressed
 218  0069 2719          	jreq	L54
 219                     ; 141 			button_press_duration = ms_count - button_press_start; // Calculate the duration of the press.
 221  006b be00          	ldw	x,_ms_count
 222  006d 72b0000f      	subw	x,_button_press_start
 223  0071 bf11          	ldw	_button_press_duration,x
 224                     ; 143 			if (button_press_duration < LONG_PRESS_DURATION) // Short press detected
 226  0073 be11          	ldw	x,_button_press_duration
 227  0075 a305dc        	cpw	x,#1500
 228  0078 2404          	jruge	L35
 229                     ; 145 				press_count++;
 231  007a 3c0c          	inc	_press_count
 233  007c 2004          	jra	L55
 234  007e               L35:
 235                     ; 149 				long_press = 1;
 237  007e 3501000d      	mov	_long_press,#1
 238  0082               L55:
 239                     ; 151 			button_pressed = 0; //Release button press flag
 241  0082 3f0e          	clr	_button_pressed
 242  0084               L54:
 243                     ; 155 }
 246  0084 5b02          	addw	sp,#2
 247  0086 85            	popw	x
 248  0087 bf00          	ldw	c_y,x
 249  0089 320002        	pop	c_y+2
 250  008c 85            	popw	x
 251  008d bf00          	ldw	c_x,x
 252  008f 320002        	pop	c_x+2
 253  0092 80            	iret	
 254  0093               LC001:
 255  0093 4b40          	push	#64
 256  0095 ae500f        	ldw	x,#20495
 257  0098 cd0000        	call	_GPIO_ReadInputPin
 259  009b 5b01          	addw	sp,#1
 260  009d 4d            	tnz	a
 261  009e 87            	retf	
 306                     ; 158 main()
 306                     ; 159 {
 308                     	switch	.text
 309  009f               _main:
 313                     ; 161 	clock_setup();						// Configure system clock and timing
 315  009f cd01b6        	call	_clock_setup
 317                     ; 162 	EXTI_setup();							// Setup external interrupts for button handling
 319  00a2 cd023f        	call	_EXTI_setup
 321                     ; 163 	enableInterrupts();				// Globally enable interrupts
 324  00a5 9a            	rim	
 326                     ; 171 	tim4_init();
 329  00a6 cd0257        	call	_tim4_init
 331                     ; 172 	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
 333  00a9 ae1388        	ldw	x,#5000
 334  00ac cd026b        	call	_delay_ms
 336                     ; 175 	gpio_setup();
 338  00af cd0216        	call	_gpio_setup
 340                     ; 182 	max_pwm_speed_pump = tim1_init();	
 342  00b2 cd039f        	call	_tim1_init
 344  00b5 bf08          	ldw	_max_pwm_speed_pump,x
 345  00b7               L301:
 346                     ; 192 		switch (current_state)
 348  00b7 b618          	ld	a,_current_state
 350                     ; 375 				break;
 351  00b9 271c          	jreq	L511
 352  00bb 4a            	dec	a
 353  00bc 2729          	jreq	L16
 354  00be 4a            	dec	a
 355  00bf 277a          	jreq	L56
 356  00c1 4a            	dec	a
 357  00c2 2741          	jreq	L36
 358  00c4 4a            	dec	a
 359  00c5 2603cc0164    	jreq	L76
 360                     ; 364 			default:
 360                     ; 365 			
 360                     ; 366 				// Unexpected state: reset to SLEEP state as a failsafe
 360                     ; 367 				current_state = STATE_SLEEP;	// Reset to SLEEP state
 362  00ca 3f18          	clr	_current_state
 363                     ; 370 				duty_cycle_step = pump_off(duty_cycle_step);
 365  00cc cd01a1        	call	LC005
 366                     ; 371 				press_count = 0;
 368  00cf 3f0c          	clr	_press_count
 369                     ; 373 				TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 371                     ; 375 				break;
 373  00d1 cc019b        	jp	LC002
 374  00d4               L311:
 375                     ; 198 					duty_cycle_step = pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
 377  00d4 cd01a1        	call	LC005
 378  00d7               L511:
 379                     ; 194 			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
 379                     ; 195 				
 379                     ; 196 				while (duty_cycle_step != 0)
 381  00d7 be13          	ldw	x,_duty_cycle_step
 382  00d9 26f9          	jrne	L311
 383                     ; 201 				halt(); // Wait for push-button interrupt
 386  00db 8e            	halt	
 388                     ; 204 					current_state = STATE_IDLE;
 391  00dc 35010018      	mov	_current_state,#1
 392                     ; 205 					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
 394  00e0 cd035b        	call	_tim2_init
 396  00e3 bf0a          	ldw	_max_pwm_speed_LED,x
 397                     ; 207 				break;
 399  00e5 20d0          	jra	L301
 400  00e7               L16:
 401                     ; 209 			case STATE_IDLE:	// Idle state: low LED brightness and pump off
 401                     ; 210 			
 401                     ; 211 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 403  00e7 cd01a9        	call	LC006
 404  00ea cd0000        	call	_TIM2_SetCompare3
 406                     ; 212 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 408  00ed cd01a9        	call	LC006
 409  00f0 cd0000        	call	_TIM2_SetCompare2
 411                     ; 214 				duty_cycle_step = pump_off(duty_cycle_step);	// Keep the pump turned off
 413  00f3 cd01a1        	call	LC005
 414                     ; 217 				if (press_count > 1)
 416  00f6 b60c          	ld	a,_press_count
 417  00f8 a102          	cp	a,#2
 418  00fa 2403cc0184    	jrult	L151
 419                     ; 219 					current_state = STATE_LOW_SPEED;
 421  00ff 35030018      	mov	_current_state,#3
 422                     ; 221 					TIM2_SetCompare2(0);
 424                     ; 225 				if (long_press != 0)
 425                     ; 227 					current_state = STATE_SLEEP;
 426                     ; 230 					duty_cycle_step = pump_off(duty_cycle_step);					
 428                     ; 231 					press_count = 0;
 429                     ; 232 					long_press = 0;
 430                     ; 235 					TIM2_SetCompare2(0);
 432                     ; 236 					TIM2_SetCompare3(0);
 434                     ; 238 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 436  0103 207b          	jp	LC004
 437  0105               L36:
 438                     ; 243 			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
 438                     ; 244 				
 438                     ; 245 				// Set LED brightness to 1% of maximum
 438                     ; 246 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 440  0105 cd01a9        	call	LC006
 441  0108 cd0000        	call	_TIM2_SetCompare3
 443                     ; 249 				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
 445  010b cd01af        	call	LC007
 446  010e b313          	cpw	x,_duty_cycle_step
 447  0110 2407          	jruge	L521
 448                     ; 251 					duty_cycle_step = decelerate_pump(duty_cycle_step);
 450  0112 be13          	ldw	x,_duty_cycle_step
 451  0114 cd03fa        	call	_decelerate_pump
 454  0117 2014          	jra	L721
 455  0119               L521:
 456                     ; 253 				else if (duty_cycle_step < (max_pwm_speed_pump/3)*2)
 458  0119 cd01af        	call	LC007
 459  011c b313          	cpw	x,_duty_cycle_step
 460  011e 2307          	jrule	L131
 461                     ; 255 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 463  0120 be13          	ldw	x,_duty_cycle_step
 464  0122 cd03e8        	call	_accelerate_pump
 467  0125 2006          	jra	L721
 468  0127               L131:
 469                     ; 259 					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
 471  0127 cd01af        	call	LC007
 472  012a cd040c        	call	_set_pump_speed
 474  012d               L721:
 475  012d bf13          	ldw	_duty_cycle_step,x
 476                     ; 263 				if (press_count > 2)
 478  012f b60c          	ld	a,_press_count
 479  0131 a103          	cp	a,#3
 480  0133 254f          	jrult	L151
 481                     ; 265 					current_state = STATE_FULL_SPEED;
 483  0135 35020018      	mov	_current_state,#2
 484                     ; 269 				if (long_press != 0)
 485                     ; 271 					current_state = STATE_SLEEP;
 486                     ; 274 					duty_cycle_step = pump_off(duty_cycle_step);					
 488                     ; 275 					press_count = 0;
 489                     ; 276 					long_press = 0;
 490                     ; 279 					TIM2_SetCompare2(0);
 492                     ; 280 					TIM2_SetCompare3(0);
 494                     ; 282 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 496  0139 2049          	jp	L151
 497  013b               L56:
 498                     ; 286 			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
 498                     ; 287 				
 498                     ; 288 				// Set LED to maximum brightness
 498                     ; 289 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 500  013b ad6c          	call	LC006
 501  013d cd0000        	call	_TIM2_SetCompare3
 503                     ; 292 				if (duty_cycle_step < max_pwm_speed_pump)
 505  0140 be13          	ldw	x,_duty_cycle_step
 506  0142 b308          	cpw	x,_max_pwm_speed_pump
 507  0144 2407          	jruge	L141
 508                     ; 294 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 510  0146 be13          	ldw	x,_duty_cycle_step
 511  0148 cd03e8        	call	_accelerate_pump
 514  014b 2005          	jra	L341
 515  014d               L141:
 516                     ; 298 					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
 518  014d be08          	ldw	x,_max_pwm_speed_pump
 519  014f cd040c        	call	_set_pump_speed
 521  0152               L341:
 522  0152 bf13          	ldw	_duty_cycle_step,x
 523                     ; 302 				if (press_count > 3)
 525  0154 b60c          	ld	a,_press_count
 526  0156 a104          	cp	a,#4
 527  0158 252a          	jrult	L151
 528                     ; 304 					current_state = STATE_PULSE;
 530  015a 35040018      	mov	_current_state,#4
 531                     ; 305 					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
 533  015e 5f            	clrw	x
 534  015f cd0000        	call	_TIM2_SetCompare3
 536                     ; 309 				if (long_press != 0)
 537                     ; 311 					current_state = STATE_SLEEP;
 538                     ; 314 					duty_cycle_step = pump_off(duty_cycle_step);					
 540                     ; 315 					press_count = 0;
 541                     ; 316 					long_press = 0;
 542                     ; 319 					TIM2_SetCompare2(0);
 544                     ; 320 					TIM2_SetCompare3(0);
 546                     ; 322 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 548  0162 2020          	jp	L151
 549  0164               L76:
 550                     ; 326 			case STATE_PULSE:	// Pulsed pump operation with LED indication
 550                     ; 327 			
 550                     ; 328 				// Set LED PULSE to 1% brightnes
 550                     ; 329 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 552  0164 ad43          	call	LC006
 553  0166 cd0000        	call	_TIM2_SetCompare2
 555                     ; 332 				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
 557  0169 be13          	ldw	x,_duty_cycle_step
 558  016b cd0426        	call	_pump_smooth_on_off
 560  016e bf13          	ldw	_duty_cycle_step,x
 561                     ; 335 				if (press_count > 4)
 563  0170 b60c          	ld	a,_press_count
 564  0172 a105          	cp	a,#5
 565  0174 250e          	jrult	L151
 566                     ; 337 					current_state = STATE_LOW_SPEED;	// Reset to SLEEP state
 568  0176 35030018      	mov	_current_state,#3
 569                     ; 340 					duty_cycle_step = pump_off(duty_cycle_step);
 571  017a ad25          	call	LC005
 572                     ; 341 					press_count = 2;
 574  017c 3502000c      	mov	_press_count,#2
 575                     ; 343 					TIM2_SetCompare2(0);	// Turn off LED PULSE				
 577  0180               LC004:
 579  0180 5f            	clrw	x
 580  0181 cd0000        	call	_TIM2_SetCompare2
 582  0184               L151:
 583                     ; 347 				if (long_press != 0)
 585                     ; 349 					current_state = STATE_SLEEP;
 587                     ; 352 					duty_cycle_step = pump_off(duty_cycle_step);					
 590                     ; 353 					press_count = 0;
 592                     ; 354 					long_press = 0;
 594                     ; 357 					TIM2_SetCompare2(0);
 597                     ; 358 					TIM2_SetCompare3(0);
 602  0184 3d0d          	tnz	_long_press
 603  0186 2603cc00b7    	jreq	L301
 607  018b 3f18          	clr	_current_state
 611  018d ad12          	call	LC005
 615  018f 3f0c          	clr	_press_count
 619  0191 3f0d          	clr	_long_press
 623  0193 5f            	clrw	x
 624  0194 cd0000        	call	_TIM2_SetCompare2
 628  0197 5f            	clrw	x
 629  0198 cd0000        	call	_TIM2_SetCompare3
 631                     ; 360 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 633  019b               LC002:
 638  019b cd0000        	call	_TIM2_DeInit
 640  019e cc00b7        	jra	L301
 641                     ; 375 				break;
 642  01a1               LC005:
 643  01a1 be13          	ldw	x,_duty_cycle_step
 644  01a3 cd0415        	call	_pump_off
 645  01a6 bf13          	ldw	_duty_cycle_step,x
 646  01a8 81            	ret	
 647  01a9               LC006:
 648  01a9 be0a          	ldw	x,_max_pwm_speed_LED
 649  01ab a664          	ld	a,#100
 650  01ad 62            	div	x,a
 651  01ae 81            	ret	
 652  01af               LC007:
 653  01af be08          	ldw	x,_max_pwm_speed_pump
 654  01b1 a603          	ld	a,#3
 655  01b3 62            	div	x,a
 656  01b4 58            	sllw	x
 657  01b5 81            	ret	
 690                     ; 387 void clock_setup(void)
 690                     ; 388 {
 691                     	switch	.text
 692  01b6               _clock_setup:
 696                     ; 389 	CLK_DeInit();		// Reset clock configuration to default state
 698  01b6 cd0000        	call	_CLK_DeInit
 700                     ; 391 	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
 702  01b9 4f            	clr	a
 703  01ba cd0000        	call	_CLK_HSECmd
 705                     ; 392 	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
 707  01bd 4f            	clr	a
 708  01be cd0000        	call	_CLK_LSICmd
 710                     ; 393 	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
 712  01c1 a601          	ld	a,#1
 713  01c3 cd0000        	call	_CLK_HSICmd
 716  01c6               L761:
 717                     ; 395 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
 719  01c6 ae0102        	ldw	x,#258
 720  01c9 cd0000        	call	_CLK_GetFlagStatus
 722  01cc 4d            	tnz	a
 723  01cd 27f7          	jreq	L761
 724                     ; 397 	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
 726  01cf a601          	ld	a,#1
 727  01d1 cd0000        	call	_CLK_ClockSwitchCmd
 729                     ; 398 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
 731  01d4 4f            	clr	a
 732  01d5 cd0000        	call	_CLK_HSIPrescalerConfig
 734                     ; 399 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
 736  01d8 a680          	ld	a,#128
 737  01da cd0000        	call	_CLK_SYSCLKConfig
 739                     ; 401 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 739                     ; 402 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 741  01dd 4b01          	push	#1
 742  01df 4b00          	push	#0
 743  01e1 ae01e1        	ldw	x,#481
 744  01e4 cd0000        	call	_CLK_ClockSwitchConfig
 746  01e7 85            	popw	x
 747                     ; 405 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 749  01e8 5f            	clrw	x
 750  01e9 cd0000        	call	_CLK_PeripheralClockConfig
 752                     ; 406 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 754  01ec ae0100        	ldw	x,#256
 755  01ef cd0000        	call	_CLK_PeripheralClockConfig
 757                     ; 407 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 759  01f2 ae1300        	ldw	x,#4864
 760  01f5 cd0000        	call	_CLK_PeripheralClockConfig
 762                     ; 408 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 764  01f8 ae1200        	ldw	x,#4608
 765  01fb cd0000        	call	_CLK_PeripheralClockConfig
 767                     ; 409 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 769  01fe ae0300        	ldw	x,#768
 770  0201 cd0000        	call	_CLK_PeripheralClockConfig
 772                     ; 410 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
 774  0204 ae0701        	ldw	x,#1793
 775  0207 cd0000        	call	_CLK_PeripheralClockConfig
 777                     ; 411 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
 779  020a ae0501        	ldw	x,#1281
 780  020d cd0000        	call	_CLK_PeripheralClockConfig
 782                     ; 412 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
 784  0210 ae0401        	ldw	x,#1025
 786                     ; 414 }
 789  0213 cc0000        	jp	_CLK_PeripheralClockConfig
 814                     ; 423 void gpio_setup(void)
 814                     ; 424 {
 815                     	switch	.text
 816  0216               _gpio_setup:
 820                     ; 425 	GPIO_DeInit(GPIOA);  // Reset Port A configuration
 822  0216 ae5000        	ldw	x,#20480
 823  0219 cd0000        	call	_GPIO_DeInit
 825                     ; 426 	GPIO_DeInit(GPIOB);  // Reset Port B configuration
 827  021c ae5005        	ldw	x,#20485
 828  021f cd0000        	call	_GPIO_DeInit
 830                     ; 427 	GPIO_DeInit(GPIOD);  // Reset Port D configuration
 832  0222 ae500f        	ldw	x,#20495
 833  0225 cd0000        	call	_GPIO_DeInit
 835                     ; 429 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_IT);					// Configure Pin D6 as an floating input with interrupt
 837  0228 4b60          	push	#96
 838  022a 4b40          	push	#64
 839  022c ae500f        	ldw	x,#20495
 840  022f cd0000        	call	_GPIO_Init
 842  0232 85            	popw	x
 843                     ; 430 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
 845  0233 4be0          	push	#224
 846  0235 4b10          	push	#16
 847  0237 ae5005        	ldw	x,#20485
 848  023a cd0000        	call	_GPIO_Init
 850  023d 85            	popw	x
 851                     ; 431 }
 854  023e 81            	ret	
 883                     ; 440 void EXTI_setup(void)
 883                     ; 441 {
 884                     	switch	.text
 885  023f               _EXTI_setup:
 889                     ; 442 	ITC_DeInit();	// Reset interrupt controller configuration
 891  023f cd0000        	call	_ITC_DeInit
 893                     ; 443 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
 895  0242 ae0602        	ldw	x,#1538
 896  0245 cd0000        	call	_ITC_SetSoftwarePriority
 898                     ; 445 	EXTI_DeInit(); // Reset external interrupt configuration
 900  0248 cd0000        	call	_EXTI_DeInit
 902                     ; 447 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_FALL);  // Enable falling and rising-edge sensitivity for Port D
 904  024b ae0303        	ldw	x,#771
 905  024e cd0000        	call	_EXTI_SetExtIntSensitivity
 907                     ; 448 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
 909  0251 4f            	clr	a
 910  0252 cd0000        	call	_EXTI_SetTLISensitivity
 912                     ; 450 	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
 915  0255 9a            	rim	
 917                     ; 451 }
 921  0256 81            	ret	
 948                     ; 460 void tim4_init(void) //Timer Used to count milliseconds for delay function
 948                     ; 461 {
 949                     	switch	.text
 950  0257               _tim4_init:
 954                     ; 463 	TIM4_DeInit();	// Reset Timer 4 configuration
 956  0257 cd0000        	call	_TIM4_DeInit
 958                     ; 464 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 960  025a ae077d        	ldw	x,#1917
 961  025d cd0000        	call	_TIM4_TimeBaseInit
 963                     ; 465 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
 965  0260 ae0101        	ldw	x,#257
 966  0263 cd0000        	call	_TIM4_ITConfig
 968                     ; 466 	TIM4_Cmd(ENABLE);  // Start Timer 4
 970  0266 a601          	ld	a,#1
 972                     ; 468 }
 975  0268 cc0000        	jp	_TIM4_Cmd
1019                     ; 478 void delay_ms(uint16_t delay)
1019                     ; 479 {
1020                     	switch	.text
1021  026b               _delay_ms:
1023  026b 89            	pushw	x
1024  026c 89            	pushw	x
1025       00000002      OFST:	set	2
1028                     ; 480     uint16_t start = ms_count;	// Record the current timer count
1030  026d be00          	ldw	x,_ms_count
1031  026f 1f01          	ldw	(OFST-1,sp),x
1034  0271               L152:
1035                     ; 481     while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
1037  0271 be00          	ldw	x,_ms_count
1038  0273 72f001        	subw	x,(OFST-1,sp)
1039  0276 1303          	cpw	x,(OFST+1,sp)
1040  0278 25f7          	jrult	L152
1041                     ; 483 }
1044  027a 5b04          	addw	sp,#4
1045  027c 81            	ret	
1116                     .const:	section	.text
1117  0000               L462:
1118  0000 00010000      	dc.l	65536
1119                     ; 499 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
1119                     ; 500 {
1120                     	switch	.text
1121  027d               _set_pwm_frequency:
1123  027d 88            	push	a
1124  027e 520c          	subw	sp,#12
1125       0000000c      OFST:	set	12
1128                     ; 501 	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
1130                     ; 502 	switch (hsi_prescaler)
1132  0280 7b12          	ld	a,(OFST+6,sp)
1134                     ; 518 			break;
1135  0282 270e          	jreq	L552
1136  0284 a008          	sub	a,#8
1137  0286 270d          	jreq	L752
1138  0288 a008          	sub	a,#8
1139  028a 270d          	jreq	L162
1140  028c a008          	sub	a,#8
1141  028e 270d          	jreq	L362
1142  0290 200f          	jra	L523
1143  0292               L552:
1144                     ; 504 		case 0x00:
1144                     ; 505 			hsi_prescaler = 1;
1146  0292 4c            	inc	a
1147                     ; 506 			break;
1149  0293 200a          	jp	LC008
1150  0295               L752:
1151                     ; 508 		case 0x08:
1151                     ; 509 			hsi_prescaler = 2;
1153  0295 a602          	ld	a,#2
1154                     ; 510 			break;
1156  0297 2006          	jp	LC008
1157  0299               L162:
1158                     ; 512 		case 0x10:
1158                     ; 513 			hsi_prescaler = 4;
1160  0299 a604          	ld	a,#4
1161                     ; 514 			break;
1163  029b 2002          	jp	LC008
1164  029d               L362:
1165                     ; 516 		case 0x18:
1165                     ; 517 			hsi_prescaler = 8;
1167  029d a608          	ld	a,#8
1168  029f               LC008:
1169  029f 6b12          	ld	(OFST+6,sp),a
1170                     ; 518 			break;
1172  02a1               L523:
1173                     ; 521 	if (timer !=  1)
1175  02a1 7b0d          	ld	a,(OFST+1,sp)
1176  02a3 4a            	dec	a
1177  02a4 275f          	jreq	L723
1178                     ; 523 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
1195  02a6 2005          	jra	L553
1196  02a8               L153:
1197                     ; 527 			frequency++;
1199  02a8 1e10          	ldw	x,(OFST+4,sp)
1200  02aa 5c            	incw	x
1201  02ab 1f10          	ldw	(OFST+4,sp),x
1202                     ; 528 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1219  02ad               L553:
1221  02ad 7b13          	ld	a,(OFST+7,sp)
1222  02af 5f            	clrw	x
1223  02b0 97            	ld	xl,a
1224  02b1 cd0000        	call	c_itof
1225  02b4 be02          	ldw	x,c_lreg+2
1226  02b6 89            	pushw	x
1227  02b7 be00          	ldw	x,c_lreg
1228  02b9 89            	pushw	x
1229  02ba ce000a        	ldw	x,L533+2
1230  02bd 89            	pushw	x
1231  02be ce0008        	ldw	x,L533
1232  02c1 89            	pushw	x
1233  02c2 cd0000        	call	_pow
1234  02c5 5b08          	addw	sp,#8
1235  02c7 96            	ldw	x,sp
1236  02c8 1c0005        	addw	x,#OFST-7
1237  02cb cd0000        	call	c_rtol
1238  02ce 1e10          	ldw	x,(OFST+4,sp)
1239  02d0 7b12          	ld	a,(OFST+6,sp)
1240  02d2 cd0000        	call	c_bmulx
1241  02d5 cd0000        	call	c_uitof
1242  02d8 96            	ldw	x,sp
1243  02d9 1c0005        	addw	x,#OFST-7
1244  02dc cd0000        	call	c_fmul
1245  02df 96            	ldw	x,sp
1246  02e0 5c            	incw	x
1247  02e1 ad5e          	call	LC009
1248  02e3 cd0000        	call	c_ltof
1249  02e6 96            	ldw	x,sp
1250  02e7 5c            	incw	x
1251  02e8 cd0000        	call	c_fdiv
1252  02eb ae0004        	ldw	x,#L543
1253  02ee cd0000        	call	c_fsub
1254  02f1 cd0000        	call	c_ftol
1255  02f4 96            	ldw	x,sp
1256  02f5 1c0009        	addw	x,#OFST-3
1257  02f8 cd0000        	call	c_rtol
1258                     ; 525 		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
1260  02fb 96            	ldw	x,sp
1261  02fc ad51          	call	LC010
1263  02fe 24a8          	jruge	L153
1265  0300               L163:
1266                     ; 543 	return (uint16_t)arr;
1268  0300 1e0b          	ldw	x,(OFST-1,sp)
1271  0302 5b0d          	addw	sp,#13
1272  0304 81            	ret	
1273  0305               L723:
1274                     ; 533 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1276  0305 1e10          	ldw	x,(OFST+4,sp)
1287  0307 2005          	jra	L763
1288  0309               L363:
1289                     ; 537 			frequency++;
1291  0309 1e10          	ldw	x,(OFST+4,sp)
1292  030b 5c            	incw	x
1293  030c 1f10          	ldw	(OFST+4,sp),x
1294                     ; 538 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1305  030e               L763:
1306  030e 7b12          	ld	a,(OFST+6,sp)
1307  0310 cd0000        	call	c_bmulx
1308  0313 7b13          	ld	a,(OFST+7,sp)
1309  0315 905f          	clrw	y
1310  0317 9097          	ld	yl,a
1311  0319 905c          	incw	y
1312  031b cd0000        	call	c_imul
1313  031e cd0000        	call	c_uitolx
1314  0321 96            	ldw	x,sp
1315  0322 1c0005        	addw	x,#OFST-7
1316  0325 ad1a          	call	LC009
1317  0327 96            	ldw	x,sp
1318  0328 1c0005        	addw	x,#OFST-7
1319  032b cd0000        	call	c_ldiv
1320  032e a601          	ld	a,#1
1321  0330 cd0000        	call	c_lsbc
1322  0333 96            	ldw	x,sp
1323  0334 1c0009        	addw	x,#OFST-3
1324  0337 cd0000        	call	c_rtol
1325                     ; 535 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1327  033a 96            	ldw	x,sp
1328  033b ad12          	call	LC010
1330  033d 24ca          	jruge	L363
1331  033f 20bf          	jra	L163
1332  0341               LC009:
1333  0341 cd0000        	call	c_rtol
1334  0344 ae2400        	ldw	x,#9216
1335  0347 bf02          	ldw	c_lreg+2,x
1336  0349 ae00f4        	ldw	x,#244
1337  034c bf00          	ldw	c_lreg,x
1338  034e 81            	ret	
1339  034f               LC010:
1340  034f 1c0009        	addw	x,#OFST-3
1341  0352 cd0000        	call	c_ltor
1343  0355 ae0000        	ldw	x,#L462
1344  0358 cc0000        	jp	c_lcmp
1385                     ; 554 uint16_t tim2_init(void)
1385                     ; 555 {
1386                     	switch	.text
1387  035b               _tim2_init:
1389  035b 89            	pushw	x
1390       00000002      OFST:	set	2
1393                     ; 557 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1395  035c 4b00          	push	#0
1396  035e 4b00          	push	#0
1397  0360 ae4e20        	ldw	x,#20000
1398  0363 89            	pushw	x
1399  0364 a602          	ld	a,#2
1400  0366 cd027d        	call	_set_pwm_frequency
1402  0369 5b04          	addw	sp,#4
1403  036b 1f01          	ldw	(OFST-1,sp),x
1405                     ; 560 	OCR = 0;
1407  036d 5f            	clrw	x
1408  036e bf02          	ldw	_OCR,x
1409                     ; 563 	TIM2_DeInit();
1411  0370 cd0000        	call	_TIM2_DeInit
1413                     ; 566 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1415  0373 1e01          	ldw	x,(OFST-1,sp)
1416  0375 89            	pushw	x
1417  0376 4f            	clr	a
1418  0377 cd0000        	call	_TIM2_TimeBaseInit
1420  037a 85            	popw	x
1421                     ; 569 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
1423  037b 4b00          	push	#0
1424  037d be02          	ldw	x,_OCR
1425  037f 89            	pushw	x
1426  0380 ae6011        	ldw	x,#24593
1427  0383 cd0000        	call	_TIM2_OC3Init
1429  0386 5b03          	addw	sp,#3
1430                     ; 570 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
1432  0388 4b00          	push	#0
1433  038a be02          	ldw	x,_OCR
1434  038c 89            	pushw	x
1435  038d ae6011        	ldw	x,#24593
1436  0390 cd0000        	call	_TIM2_OC2Init
1438  0393 5b03          	addw	sp,#3
1439                     ; 573 	TIM2_Cmd(ENABLE);
1441  0395 a601          	ld	a,#1
1442  0397 cd0000        	call	_TIM2_Cmd
1444                     ; 576 	return ARR;
1446  039a 1e01          	ldw	x,(OFST-1,sp)
1449  039c 5b02          	addw	sp,#2
1450  039e 81            	ret	
1491                     ; 590 uint16_t tim1_init(void)
1491                     ; 591 {
1492                     	switch	.text
1493  039f               _tim1_init:
1495  039f 89            	pushw	x
1496       00000002      OFST:	set	2
1499                     ; 593 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1501  03a0 4b00          	push	#0
1502  03a2 4b00          	push	#0
1503  03a4 ae4e20        	ldw	x,#20000
1504  03a7 89            	pushw	x
1505  03a8 a601          	ld	a,#1
1506  03aa cd027d        	call	_set_pwm_frequency
1508  03ad 5b04          	addw	sp,#4
1509  03af 1f01          	ldw	(OFST-1,sp),x
1511                     ; 596 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1513  03b1 5f            	clrw	x
1514  03b2 bf02          	ldw	_OCR,x
1515                     ; 599 	TIM1_DeInit();
1517  03b4 cd0000        	call	_TIM1_DeInit
1519                     ; 602 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1521  03b7 4b00          	push	#0
1522  03b9 1e02          	ldw	x,(OFST+0,sp)
1523  03bb 89            	pushw	x
1524  03bc 4b00          	push	#0
1525  03be 5f            	clrw	x
1526  03bf cd0000        	call	_TIM1_TimeBaseInit
1528  03c2 5b04          	addw	sp,#4
1529                     ; 605 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1531  03c4 4b00          	push	#0
1532  03c6 4b00          	push	#0
1533  03c8 4b88          	push	#136
1534  03ca 4b00          	push	#0
1535  03cc be02          	ldw	x,_OCR
1536  03ce 89            	pushw	x
1537  03cf 4b00          	push	#0
1538  03d1 ae6011        	ldw	x,#24593
1539  03d4 cd0000        	call	_TIM1_OC3Init
1541  03d7 5b07          	addw	sp,#7
1542                     ; 608 	TIM1_Cmd(ENABLE);
1544  03d9 a601          	ld	a,#1
1545  03db cd0000        	call	_TIM1_Cmd
1547                     ; 611 	TIM1_CtrlPWMOutputs(ENABLE);
1549  03de a601          	ld	a,#1
1550  03e0 cd0000        	call	_TIM1_CtrlPWMOutputs
1552                     ; 614 	return ARR;
1554  03e3 1e01          	ldw	x,(OFST-1,sp)
1557  03e5 5b02          	addw	sp,#2
1558  03e7 81            	ret	
1594                     ; 628 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1594                     ; 629 {	
1595                     	switch	.text
1596  03e8               _accelerate_pump:
1598  03e8 89            	pushw	x
1599       00000000      OFST:	set	0
1602                     ; 630 	delay_ms(1); // Short delay to smooth out the ramp-up.
1604  03e9 ae0001        	ldw	x,#1
1605  03ec cd026b        	call	_delay_ms
1607                     ; 631 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1609  03ef 1e01          	ldw	x,(OFST+1,sp)
1610  03f1 cd0000        	call	_TIM1_SetCompare3
1612                     ; 632 	duty_cycle_step++; // Increment the duty cycle value.
1614  03f4 1e01          	ldw	x,(OFST+1,sp)
1615  03f6 5c            	incw	x
1616                     ; 634 	return duty_cycle_step; // Return the updated duty cycle.
1620  03f7 5b02          	addw	sp,#2
1621  03f9 81            	ret	
1657                     ; 647 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1657                     ; 648 {	
1658                     	switch	.text
1659  03fa               _decelerate_pump:
1661  03fa 89            	pushw	x
1662       00000000      OFST:	set	0
1665                     ; 649 	delay_ms(1); // Short delay to smooth out the ramp-down.
1667  03fb ae0001        	ldw	x,#1
1668  03fe cd026b        	call	_delay_ms
1670                     ; 650 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1672  0401 1e01          	ldw	x,(OFST+1,sp)
1673  0403 cd0000        	call	_TIM1_SetCompare3
1675                     ; 651 	duty_cycle_step--; // Decrement the duty cycle value.
1677  0406 1e01          	ldw	x,(OFST+1,sp)
1678  0408 5a            	decw	x
1679                     ; 653 	return duty_cycle_step; // Return the updated duty cycle.
1683  0409 5b02          	addw	sp,#2
1684  040b 81            	ret	
1719                     ; 665 uint16_t set_pump_speed(uint16_t duty_cycle_step)
1719                     ; 666 {	
1720                     	switch	.text
1721  040c               _set_pump_speed:
1723  040c 89            	pushw	x
1724       00000000      OFST:	set	0
1727                     ; 667 	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
1729  040d cd0000        	call	_TIM1_SetCompare3
1731                     ; 668 	return duty_cycle_step; // Return the specified duty cycle.
1733  0410 1e01          	ldw	x,(OFST+1,sp)
1736  0412 5b02          	addw	sp,#2
1737  0414 81            	ret	
1773                     ; 683 uint16_t pump_off(uint16_t duty_cycle_step)
1773                     ; 684 {
1774                     	switch	.text
1775  0415               _pump_off:
1777  0415 89            	pushw	x
1778       00000000      OFST:	set	0
1781                     ; 685 	if (duty_cycle_step > 0)
1783  0416 5d            	tnzw	x
1784  0417 2704          	jreq	L715
1785                     ; 688 		duty_cycle_step = decelerate_pump(duty_cycle_step);
1787  0419 addf          	call	_decelerate_pump
1790  041b 2006          	jra	L125
1791  041d               L715:
1792                     ; 693 		TIM1_SetCompare3(0);
1794  041d 5f            	clrw	x
1795  041e cd0000        	call	_TIM1_SetCompare3
1797  0421 1e01          	ldw	x,(OFST+1,sp)
1798  0423               L125:
1799                     ; 696 	return duty_cycle_step;
1803  0423 5b02          	addw	sp,#2
1804  0425 81            	ret	
1842                     ; 712 uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
1842                     ; 713 {
1843                     	switch	.text
1844  0426               _pump_smooth_on_off:
1846  0426 89            	pushw	x
1847       00000000      OFST:	set	0
1850                     ; 715 	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
1852  0427 b308          	cpw	x,_max_pwm_speed_pump
1853  0429 240a          	jruge	L145
1855  042b 3d15          	tnz	_pulse_flag
1856  042d 2606          	jrne	L145
1857                     ; 717 		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
1859  042f adb7          	call	_accelerate_pump
1861  0431 1f01          	ldw	(OFST+1,sp),x
1863  0433 2004          	jra	L345
1864  0435               L145:
1865                     ; 721 		pulse_flag = 1;	// Switch to deceleration mode
1867  0435 35010015      	mov	_pulse_flag,#1
1868  0439               L345:
1869                     ; 725 	if ((duty_cycle_step > 0) && (pulse_flag == 1))
1871  0439 1e01          	ldw	x,(OFST+1,sp)
1872  043b 2709          	jreq	L545
1874  043d b615          	ld	a,_pulse_flag
1875  043f 4a            	dec	a
1876  0440 2604          	jrne	L545
1877                     ; 727 		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
1879  0442 adb6          	call	_decelerate_pump
1882  0444 2002          	jra	L745
1883  0446               L545:
1884                     ; 731 		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
1886  0446 3f15          	clr	_pulse_flag
1887  0448               L745:
1888                     ; 733 	return duty_cycle_step;	// Return the updated duty cycle value
1892  0448 5b02          	addw	sp,#2
1893  044a 81            	ret	
2110                     	xdef	_main
2111                     	xdef	_current_state
2112                     	xdef	_pump_off
2113                     	xdef	_decelerate_pump
2114                     	xdef	_accelerate_pump
2115                     	xdef	_set_pump_speed
2116                     	xdef	_pump_smooth_on_off
2117                     	xdef	_tim1_init
2118                     	xdef	_tim2_init
2119                     	xdef	_set_pwm_frequency
2120                     	xdef	_delay_ms
2121                     	xdef	_tim4_init
2122                     	xdef	_EXTI_setup
2123                     	xdef	_gpio_setup
2124                     	xdef	_clock_setup
2125                     	xdef	_last_interrupt_time
2126                     	xdef	_pulse_flag
2127                     	xdef	_duty_cycle_step
2128                     	xdef	_button_press_duration
2129                     	xdef	_button_press_start
2130                     	xdef	_button_pressed
2131                     	xdef	_long_press
2132                     	xdef	_press_count
2133                     	xdef	_max_pwm_speed_LED
2134                     	xdef	_max_pwm_speed_pump
2135                     	xdef	_arr_tim2
2136                     	xdef	_arr_tim1
2137                     	xdef	_OCR
2138                     	xref	_pow
2139                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2140                     	xdef	f_EXTI_PORTD_IRQHandler
2141                     	xdef	_ms_count
2142                     	xref	_TIM4_ClearITPendingBit
2143                     	xref	_TIM4_ITConfig
2144                     	xref	_TIM4_Cmd
2145                     	xref	_TIM4_TimeBaseInit
2146                     	xref	_TIM4_DeInit
2147                     	xref	_TIM2_SetCompare3
2148                     	xref	_TIM2_SetCompare2
2149                     	xref	_TIM2_Cmd
2150                     	xref	_TIM2_OC3Init
2151                     	xref	_TIM2_OC2Init
2152                     	xref	_TIM2_TimeBaseInit
2153                     	xref	_TIM2_DeInit
2154                     	xref	_TIM1_SetCompare3
2155                     	xref	_TIM1_CtrlPWMOutputs
2156                     	xref	_TIM1_Cmd
2157                     	xref	_TIM1_OC3Init
2158                     	xref	_TIM1_TimeBaseInit
2159                     	xref	_TIM1_DeInit
2160                     	xref	_ITC_SetSoftwarePriority
2161                     	xref	_ITC_DeInit
2162                     	xref	_GPIO_ReadInputPin
2163                     	xref	_GPIO_Init
2164                     	xref	_GPIO_DeInit
2165                     	xref	_EXTI_SetTLISensitivity
2166                     	xref	_EXTI_SetExtIntSensitivity
2167                     	xref	_EXTI_DeInit
2168                     	xref	_CLK_GetFlagStatus
2169                     	xref	_CLK_SYSCLKConfig
2170                     	xref	_CLK_HSIPrescalerConfig
2171                     	xref	_CLK_ClockSwitchConfig
2172                     	xref	_CLK_PeripheralClockConfig
2173                     	xref	_CLK_ClockSwitchCmd
2174                     	xref	_CLK_LSICmd
2175                     	xref	_CLK_HSICmd
2176                     	xref	_CLK_HSECmd
2177                     	xref	_CLK_DeInit
2178                     	switch	.const
2179  0004               L543:
2180  0004 3f800000      	dc.w	16256,0
2181  0008               L533:
2182  0008 40000000      	dc.w	16384,0
2183                     	xref.b	c_lreg
2184                     	xref.b	c_x
2185                     	xref.b	c_y
2205                     	xref	c_lsbc
2206                     	xref	c_ldiv
2207                     	xref	c_uitolx
2208                     	xref	c_imul
2209                     	xref	c_lcmp
2210                     	xref	c_ltor
2211                     	xref	c_ftol
2212                     	xref	c_fsub
2213                     	xref	c_fdiv
2214                     	xref	c_fmul
2215                     	xref	c_rtol
2216                     	xref	c_itof
2217                     	xref	c_uitof
2218                     	xref	c_bmulx
2219                     	xref	c_ltof
2220                     	end
