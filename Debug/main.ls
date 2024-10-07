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
 315  009f cd01b8        	call	_clock_setup
 317                     ; 162 	EXTI_setup();							// Setup external interrupts for button handling
 319  00a2 cd0241        	call	_EXTI_setup
 321                     ; 163 	enableInterrupts();				// Globally enable interrupts
 324  00a5 9a            	rim	
 326                     ; 171 	tim4_init();
 329  00a6 cd0259        	call	_tim4_init
 331                     ; 172 	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
 333  00a9 ae1388        	ldw	x,#5000
 334  00ac cd026d        	call	_delay_ms
 336                     ; 175 	gpio_setup();
 338  00af cd0218        	call	_gpio_setup
 340                     ; 182 	max_pwm_speed_pump = tim1_init();	
 342  00b2 cd03a1        	call	_tim1_init
 344  00b5 bf08          	ldw	_max_pwm_speed_pump,x
 345  00b7               L301:
 346                     ; 192 		switch (current_state)
 348  00b7 b618          	ld	a,_current_state
 350                     ; 375 				break;
 351  00b9 2719          	jreq	L75
 352  00bb 4a            	dec	a
 353  00bc 2729          	jreq	L16
 354  00be 4a            	dec	a
 355  00bf 277c          	jreq	L56
 356  00c1 4a            	dec	a
 357  00c2 2743          	jreq	L36
 358  00c4 4a            	dec	a
 359  00c5 2603cc0166    	jreq	L76
 360                     ; 364 			default:
 360                     ; 365 			
 360                     ; 366 				// Unexpected state: reset to SLEEP state as a failsafe
 360                     ; 367 				current_state = STATE_SLEEP;	// Reset to SLEEP state
 362  00ca 3f18          	clr	_current_state
 363                     ; 370 				duty_cycle_step = pump_off(duty_cycle_step);
 365  00cc cd01a3        	call	LC005
 366                     ; 371 				press_count = 0;
 368  00cf 3f0c          	clr	_press_count
 369                     ; 373 				TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 371                     ; 375 				break;
 373  00d1 cc019d        	jp	LC002
 374  00d4               L75:
 375                     ; 194 			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
 375                     ; 195 				
 375                     ; 196 				if (duty_cycle_step != 0)
 377  00d4 be13          	ldw	x,_duty_cycle_step
 378  00d6 2703          	jreq	L311
 379                     ; 198 					duty_cycle_step = pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
 381  00d8 cd01a3        	call	LC005
 382  00db               L311:
 383                     ; 201 				halt(); // Wait for push-button interrupt
 386  00db 8e            	halt	
 388                     ; 204 					current_state = STATE_IDLE;
 391  00dc 35010018      	mov	_current_state,#1
 392                     ; 205 					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
 394  00e0 cd035d        	call	_tim2_init
 396  00e3 bf0a          	ldw	_max_pwm_speed_LED,x
 397                     ; 207 				break;
 399  00e5 20d0          	jra	L301
 400  00e7               L16:
 401                     ; 209 			case STATE_IDLE:	// Idle state: low LED brightness and pump off
 401                     ; 210 			
 401                     ; 211 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 403  00e7 cd01ab        	call	LC006
 404  00ea cd0000        	call	_TIM2_SetCompare3
 406                     ; 212 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 408  00ed cd01ab        	call	LC006
 409  00f0 cd0000        	call	_TIM2_SetCompare2
 411                     ; 214 				pump_off(duty_cycle_step);	// Keep the pump turned off
 413  00f3 be13          	ldw	x,_duty_cycle_step
 414  00f5 cd0417        	call	_pump_off
 416                     ; 217 				if (press_count > 1)
 418  00f8 b60c          	ld	a,_press_count
 419  00fa a102          	cp	a,#2
 420  00fc 2403cc0186    	jrult	L541
 421                     ; 219 					current_state = STATE_LOW_SPEED;
 423  0101 35030018      	mov	_current_state,#3
 424                     ; 221 					TIM2_SetCompare2(0);
 426                     ; 225 				if (long_press != 0)
 427                     ; 227 					current_state = STATE_SLEEP;
 428                     ; 230 					duty_cycle_step = pump_off(duty_cycle_step);					
 430                     ; 231 					press_count = 0;
 431                     ; 232 					long_press = 0;
 432                     ; 235 					TIM2_SetCompare2(0);
 434                     ; 236 					TIM2_SetCompare3(0);
 436                     ; 238 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 438  0105 207b          	jp	LC004
 439  0107               L36:
 440                     ; 243 			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
 440                     ; 244 				
 440                     ; 245 				// Set LED brightness to 1% of maximum
 440                     ; 246 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 442  0107 cd01ab        	call	LC006
 443  010a cd0000        	call	_TIM2_SetCompare3
 445                     ; 249 				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
 447  010d cd01b1        	call	LC007
 448  0110 b313          	cpw	x,_duty_cycle_step
 449  0112 2407          	jruge	L121
 450                     ; 251 					duty_cycle_step = decelerate_pump(duty_cycle_step);
 452  0114 be13          	ldw	x,_duty_cycle_step
 453  0116 cd03fc        	call	_decelerate_pump
 456  0119 2014          	jra	L321
 457  011b               L121:
 458                     ; 253 				else if (duty_cycle_step < (max_pwm_speed_pump/3)*2)
 460  011b cd01b1        	call	LC007
 461  011e b313          	cpw	x,_duty_cycle_step
 462  0120 2307          	jrule	L521
 463                     ; 255 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 465  0122 be13          	ldw	x,_duty_cycle_step
 466  0124 cd03ea        	call	_accelerate_pump
 469  0127 2006          	jra	L321
 470  0129               L521:
 471                     ; 259 					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
 473  0129 cd01b1        	call	LC007
 474  012c cd040e        	call	_set_pump_speed
 476  012f               L321:
 477  012f bf13          	ldw	_duty_cycle_step,x
 478                     ; 263 				if (press_count > 2)
 480  0131 b60c          	ld	a,_press_count
 481  0133 a103          	cp	a,#3
 482  0135 254f          	jrult	L541
 483                     ; 265 					current_state = STATE_FULL_SPEED;
 485  0137 35020018      	mov	_current_state,#2
 486                     ; 269 				if (long_press != 0)
 487                     ; 271 					current_state = STATE_SLEEP;
 488                     ; 274 					duty_cycle_step = pump_off(duty_cycle_step);					
 490                     ; 275 					press_count = 0;
 491                     ; 276 					long_press = 0;
 492                     ; 279 					TIM2_SetCompare2(0);
 494                     ; 280 					TIM2_SetCompare3(0);
 496                     ; 282 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 498  013b 2049          	jp	L541
 499  013d               L56:
 500                     ; 286 			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
 500                     ; 287 				
 500                     ; 288 				// Set LED to maximum brightness
 500                     ; 289 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 502  013d ad6c          	call	LC006
 503  013f cd0000        	call	_TIM2_SetCompare3
 505                     ; 292 				if (duty_cycle_step < max_pwm_speed_pump)
 507  0142 be13          	ldw	x,_duty_cycle_step
 508  0144 b308          	cpw	x,_max_pwm_speed_pump
 509  0146 2407          	jruge	L531
 510                     ; 294 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 512  0148 be13          	ldw	x,_duty_cycle_step
 513  014a cd03ea        	call	_accelerate_pump
 516  014d 2005          	jra	L731
 517  014f               L531:
 518                     ; 298 					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
 520  014f be08          	ldw	x,_max_pwm_speed_pump
 521  0151 cd040e        	call	_set_pump_speed
 523  0154               L731:
 524  0154 bf13          	ldw	_duty_cycle_step,x
 525                     ; 302 				if (press_count > 3)
 527  0156 b60c          	ld	a,_press_count
 528  0158 a104          	cp	a,#4
 529  015a 252a          	jrult	L541
 530                     ; 304 					current_state = STATE_PULSE;
 532  015c 35040018      	mov	_current_state,#4
 533                     ; 305 					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
 535  0160 5f            	clrw	x
 536  0161 cd0000        	call	_TIM2_SetCompare3
 538                     ; 309 				if (long_press != 0)
 539                     ; 311 					current_state = STATE_SLEEP;
 540                     ; 314 					duty_cycle_step = pump_off(duty_cycle_step);					
 542                     ; 315 					press_count = 0;
 543                     ; 316 					long_press = 0;
 544                     ; 319 					TIM2_SetCompare2(0);
 546                     ; 320 					TIM2_SetCompare3(0);
 548                     ; 322 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 550  0164 2020          	jp	L541
 551  0166               L76:
 552                     ; 326 			case STATE_PULSE:	// Pulsed pump operation with LED indication
 552                     ; 327 			
 552                     ; 328 				// Set LED PULSE to 1% brightnes
 552                     ; 329 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 554  0166 ad43          	call	LC006
 555  0168 cd0000        	call	_TIM2_SetCompare2
 557                     ; 332 				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
 559  016b be13          	ldw	x,_duty_cycle_step
 560  016d cd0428        	call	_pump_smooth_on_off
 562  0170 bf13          	ldw	_duty_cycle_step,x
 563                     ; 335 				if (press_count > 4)
 565  0172 b60c          	ld	a,_press_count
 566  0174 a105          	cp	a,#5
 567  0176 250e          	jrult	L541
 568                     ; 337 					current_state = STATE_LOW_SPEED;	// Reset to SLEEP state
 570  0178 35030018      	mov	_current_state,#3
 571                     ; 340 					duty_cycle_step = pump_off(duty_cycle_step);
 573  017c ad25          	call	LC005
 574                     ; 341 					press_count = 2;
 576  017e 3502000c      	mov	_press_count,#2
 577                     ; 343 					TIM2_SetCompare2(0);	// Turn off LED PULSE				
 579  0182               LC004:
 581  0182 5f            	clrw	x
 582  0183 cd0000        	call	_TIM2_SetCompare2
 584  0186               L541:
 585                     ; 347 				if (long_press != 0)
 587                     ; 349 					current_state = STATE_SLEEP;
 589                     ; 352 					duty_cycle_step = pump_off(duty_cycle_step);					
 592                     ; 353 					press_count = 0;
 594                     ; 354 					long_press = 0;
 596                     ; 357 					TIM2_SetCompare2(0);
 599                     ; 358 					TIM2_SetCompare3(0);
 604  0186 3d0d          	tnz	_long_press
 605  0188 2603cc00b7    	jreq	L301
 609  018d 3f18          	clr	_current_state
 613  018f ad12          	call	LC005
 617  0191 3f0c          	clr	_press_count
 621  0193 3f0d          	clr	_long_press
 625  0195 5f            	clrw	x
 626  0196 cd0000        	call	_TIM2_SetCompare2
 630  0199 5f            	clrw	x
 631  019a cd0000        	call	_TIM2_SetCompare3
 633                     ; 360 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 635  019d               LC002:
 640  019d cd0000        	call	_TIM2_DeInit
 642  01a0 cc00b7        	jra	L301
 643                     ; 375 				break;
 644  01a3               LC005:
 645  01a3 be13          	ldw	x,_duty_cycle_step
 646  01a5 cd0417        	call	_pump_off
 647  01a8 bf13          	ldw	_duty_cycle_step,x
 648  01aa 81            	ret	
 649  01ab               LC006:
 650  01ab be0a          	ldw	x,_max_pwm_speed_LED
 651  01ad a664          	ld	a,#100
 652  01af 62            	div	x,a
 653  01b0 81            	ret	
 654  01b1               LC007:
 655  01b1 be08          	ldw	x,_max_pwm_speed_pump
 656  01b3 a603          	ld	a,#3
 657  01b5 62            	div	x,a
 658  01b6 58            	sllw	x
 659  01b7 81            	ret	
 692                     ; 387 void clock_setup(void)
 692                     ; 388 {
 693                     	switch	.text
 694  01b8               _clock_setup:
 698                     ; 389 	CLK_DeInit();		// Reset clock configuration to default state
 700  01b8 cd0000        	call	_CLK_DeInit
 702                     ; 391 	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
 704  01bb 4f            	clr	a
 705  01bc cd0000        	call	_CLK_HSECmd
 707                     ; 392 	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
 709  01bf 4f            	clr	a
 710  01c0 cd0000        	call	_CLK_LSICmd
 712                     ; 393 	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
 714  01c3 a601          	ld	a,#1
 715  01c5 cd0000        	call	_CLK_HSICmd
 718  01c8               L361:
 719                     ; 395 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
 721  01c8 ae0102        	ldw	x,#258
 722  01cb cd0000        	call	_CLK_GetFlagStatus
 724  01ce 4d            	tnz	a
 725  01cf 27f7          	jreq	L361
 726                     ; 397 	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
 728  01d1 a601          	ld	a,#1
 729  01d3 cd0000        	call	_CLK_ClockSwitchCmd
 731                     ; 398 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
 733  01d6 4f            	clr	a
 734  01d7 cd0000        	call	_CLK_HSIPrescalerConfig
 736                     ; 399 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
 738  01da a680          	ld	a,#128
 739  01dc cd0000        	call	_CLK_SYSCLKConfig
 741                     ; 401 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 741                     ; 402 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 743  01df 4b01          	push	#1
 744  01e1 4b00          	push	#0
 745  01e3 ae01e1        	ldw	x,#481
 746  01e6 cd0000        	call	_CLK_ClockSwitchConfig
 748  01e9 85            	popw	x
 749                     ; 405 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 751  01ea 5f            	clrw	x
 752  01eb cd0000        	call	_CLK_PeripheralClockConfig
 754                     ; 406 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 756  01ee ae0100        	ldw	x,#256
 757  01f1 cd0000        	call	_CLK_PeripheralClockConfig
 759                     ; 407 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 761  01f4 ae1300        	ldw	x,#4864
 762  01f7 cd0000        	call	_CLK_PeripheralClockConfig
 764                     ; 408 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 766  01fa ae1200        	ldw	x,#4608
 767  01fd cd0000        	call	_CLK_PeripheralClockConfig
 769                     ; 409 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 771  0200 ae0300        	ldw	x,#768
 772  0203 cd0000        	call	_CLK_PeripheralClockConfig
 774                     ; 410 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
 776  0206 ae0701        	ldw	x,#1793
 777  0209 cd0000        	call	_CLK_PeripheralClockConfig
 779                     ; 411 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
 781  020c ae0501        	ldw	x,#1281
 782  020f cd0000        	call	_CLK_PeripheralClockConfig
 784                     ; 412 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
 786  0212 ae0401        	ldw	x,#1025
 788                     ; 414 }
 791  0215 cc0000        	jp	_CLK_PeripheralClockConfig
 816                     ; 423 void gpio_setup(void)
 816                     ; 424 {
 817                     	switch	.text
 818  0218               _gpio_setup:
 822                     ; 425 	GPIO_DeInit(GPIOA);  // Reset Port A configuration
 824  0218 ae5000        	ldw	x,#20480
 825  021b cd0000        	call	_GPIO_DeInit
 827                     ; 426 	GPIO_DeInit(GPIOB);  // Reset Port B configuration
 829  021e ae5005        	ldw	x,#20485
 830  0221 cd0000        	call	_GPIO_DeInit
 832                     ; 427 	GPIO_DeInit(GPIOD);  // Reset Port D configuration
 834  0224 ae500f        	ldw	x,#20495
 835  0227 cd0000        	call	_GPIO_DeInit
 837                     ; 429 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_IT);					// Configure Pin D6 as an floating input with interrupt
 839  022a 4b60          	push	#96
 840  022c 4b40          	push	#64
 841  022e ae500f        	ldw	x,#20495
 842  0231 cd0000        	call	_GPIO_Init
 844  0234 85            	popw	x
 845                     ; 430 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
 847  0235 4be0          	push	#224
 848  0237 4b10          	push	#16
 849  0239 ae5005        	ldw	x,#20485
 850  023c cd0000        	call	_GPIO_Init
 852  023f 85            	popw	x
 853                     ; 431 }
 856  0240 81            	ret	
 885                     ; 440 void EXTI_setup(void)
 885                     ; 441 {
 886                     	switch	.text
 887  0241               _EXTI_setup:
 891                     ; 442 	ITC_DeInit();	// Reset interrupt controller configuration
 893  0241 cd0000        	call	_ITC_DeInit
 895                     ; 443 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
 897  0244 ae0602        	ldw	x,#1538
 898  0247 cd0000        	call	_ITC_SetSoftwarePriority
 900                     ; 445 	EXTI_DeInit(); // Reset external interrupt configuration
 902  024a cd0000        	call	_EXTI_DeInit
 904                     ; 447 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_FALL);  // Enable falling and rising-edge sensitivity for Port D
 906  024d ae0303        	ldw	x,#771
 907  0250 cd0000        	call	_EXTI_SetExtIntSensitivity
 909                     ; 448 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
 911  0253 4f            	clr	a
 912  0254 cd0000        	call	_EXTI_SetTLISensitivity
 914                     ; 450 	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
 917  0257 9a            	rim	
 919                     ; 451 }
 923  0258 81            	ret	
 950                     ; 460 void tim4_init(void) //Timer Used to count milliseconds for delay function
 950                     ; 461 {
 951                     	switch	.text
 952  0259               _tim4_init:
 956                     ; 463 	TIM4_DeInit();	// Reset Timer 4 configuration
 958  0259 cd0000        	call	_TIM4_DeInit
 960                     ; 464 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 962  025c ae077d        	ldw	x,#1917
 963  025f cd0000        	call	_TIM4_TimeBaseInit
 965                     ; 465 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
 967  0262 ae0101        	ldw	x,#257
 968  0265 cd0000        	call	_TIM4_ITConfig
 970                     ; 466 	TIM4_Cmd(ENABLE);  // Start Timer 4
 972  0268 a601          	ld	a,#1
 974                     ; 468 }
 977  026a cc0000        	jp	_TIM4_Cmd
1021                     ; 478 void delay_ms(uint16_t delay)
1021                     ; 479 {
1022                     	switch	.text
1023  026d               _delay_ms:
1025  026d 89            	pushw	x
1026  026e 89            	pushw	x
1027       00000002      OFST:	set	2
1030                     ; 480     uint16_t start = ms_count;	// Record the current timer count
1032  026f be00          	ldw	x,_ms_count
1033  0271 1f01          	ldw	(OFST-1,sp),x
1036  0273               L542:
1037                     ; 481     while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
1039  0273 be00          	ldw	x,_ms_count
1040  0275 72f001        	subw	x,(OFST-1,sp)
1041  0278 1303          	cpw	x,(OFST+1,sp)
1042  027a 25f7          	jrult	L542
1043                     ; 483 }
1046  027c 5b04          	addw	sp,#4
1047  027e 81            	ret	
1118                     .const:	section	.text
1119  0000               L462:
1120  0000 00010000      	dc.l	65536
1121                     ; 499 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
1121                     ; 500 {
1122                     	switch	.text
1123  027f               _set_pwm_frequency:
1125  027f 88            	push	a
1126  0280 520c          	subw	sp,#12
1127       0000000c      OFST:	set	12
1130                     ; 501 	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
1132                     ; 502 	switch (hsi_prescaler)
1134  0282 7b12          	ld	a,(OFST+6,sp)
1136                     ; 518 			break;
1137  0284 270e          	jreq	L152
1138  0286 a008          	sub	a,#8
1139  0288 270d          	jreq	L352
1140  028a a008          	sub	a,#8
1141  028c 270d          	jreq	L552
1142  028e a008          	sub	a,#8
1143  0290 270d          	jreq	L752
1144  0292 200f          	jra	L123
1145  0294               L152:
1146                     ; 504 		case 0x00:
1146                     ; 505 			hsi_prescaler = 1;
1148  0294 4c            	inc	a
1149                     ; 506 			break;
1151  0295 200a          	jp	LC008
1152  0297               L352:
1153                     ; 508 		case 0x08:
1153                     ; 509 			hsi_prescaler = 2;
1155  0297 a602          	ld	a,#2
1156                     ; 510 			break;
1158  0299 2006          	jp	LC008
1159  029b               L552:
1160                     ; 512 		case 0x10:
1160                     ; 513 			hsi_prescaler = 4;
1162  029b a604          	ld	a,#4
1163                     ; 514 			break;
1165  029d 2002          	jp	LC008
1166  029f               L752:
1167                     ; 516 		case 0x18:
1167                     ; 517 			hsi_prescaler = 8;
1169  029f a608          	ld	a,#8
1170  02a1               LC008:
1171  02a1 6b12          	ld	(OFST+6,sp),a
1172                     ; 518 			break;
1174  02a3               L123:
1175                     ; 521 	if (timer !=  1)
1177  02a3 7b0d          	ld	a,(OFST+1,sp)
1178  02a5 4a            	dec	a
1179  02a6 275f          	jreq	L323
1180                     ; 523 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
1197  02a8 2005          	jra	L153
1198  02aa               L543:
1199                     ; 527 			frequency++;
1201  02aa 1e10          	ldw	x,(OFST+4,sp)
1202  02ac 5c            	incw	x
1203  02ad 1f10          	ldw	(OFST+4,sp),x
1204                     ; 528 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1221  02af               L153:
1223  02af 7b13          	ld	a,(OFST+7,sp)
1224  02b1 5f            	clrw	x
1225  02b2 97            	ld	xl,a
1226  02b3 cd0000        	call	c_itof
1227  02b6 be02          	ldw	x,c_lreg+2
1228  02b8 89            	pushw	x
1229  02b9 be00          	ldw	x,c_lreg
1230  02bb 89            	pushw	x
1231  02bc ce000a        	ldw	x,L133+2
1232  02bf 89            	pushw	x
1233  02c0 ce0008        	ldw	x,L133
1234  02c3 89            	pushw	x
1235  02c4 cd0000        	call	_pow
1236  02c7 5b08          	addw	sp,#8
1237  02c9 96            	ldw	x,sp
1238  02ca 1c0005        	addw	x,#OFST-7
1239  02cd cd0000        	call	c_rtol
1240  02d0 1e10          	ldw	x,(OFST+4,sp)
1241  02d2 7b12          	ld	a,(OFST+6,sp)
1242  02d4 cd0000        	call	c_bmulx
1243  02d7 cd0000        	call	c_uitof
1244  02da 96            	ldw	x,sp
1245  02db 1c0005        	addw	x,#OFST-7
1246  02de cd0000        	call	c_fmul
1247  02e1 96            	ldw	x,sp
1248  02e2 5c            	incw	x
1249  02e3 ad5e          	call	LC009
1250  02e5 cd0000        	call	c_ltof
1251  02e8 96            	ldw	x,sp
1252  02e9 5c            	incw	x
1253  02ea cd0000        	call	c_fdiv
1254  02ed ae0004        	ldw	x,#L143
1255  02f0 cd0000        	call	c_fsub
1256  02f3 cd0000        	call	c_ftol
1257  02f6 96            	ldw	x,sp
1258  02f7 1c0009        	addw	x,#OFST-3
1259  02fa cd0000        	call	c_rtol
1260                     ; 525 		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
1262  02fd 96            	ldw	x,sp
1263  02fe ad51          	call	LC010
1265  0300 24a8          	jruge	L543
1267  0302               L553:
1268                     ; 543 	return (uint16_t)arr;
1270  0302 1e0b          	ldw	x,(OFST-1,sp)
1273  0304 5b0d          	addw	sp,#13
1274  0306 81            	ret	
1275  0307               L323:
1276                     ; 533 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1278  0307 1e10          	ldw	x,(OFST+4,sp)
1289  0309 2005          	jra	L363
1290  030b               L753:
1291                     ; 537 			frequency++;
1293  030b 1e10          	ldw	x,(OFST+4,sp)
1294  030d 5c            	incw	x
1295  030e 1f10          	ldw	(OFST+4,sp),x
1296                     ; 538 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1307  0310               L363:
1308  0310 7b12          	ld	a,(OFST+6,sp)
1309  0312 cd0000        	call	c_bmulx
1310  0315 7b13          	ld	a,(OFST+7,sp)
1311  0317 905f          	clrw	y
1312  0319 9097          	ld	yl,a
1313  031b 905c          	incw	y
1314  031d cd0000        	call	c_imul
1315  0320 cd0000        	call	c_uitolx
1316  0323 96            	ldw	x,sp
1317  0324 1c0005        	addw	x,#OFST-7
1318  0327 ad1a          	call	LC009
1319  0329 96            	ldw	x,sp
1320  032a 1c0005        	addw	x,#OFST-7
1321  032d cd0000        	call	c_ldiv
1322  0330 a601          	ld	a,#1
1323  0332 cd0000        	call	c_lsbc
1324  0335 96            	ldw	x,sp
1325  0336 1c0009        	addw	x,#OFST-3
1326  0339 cd0000        	call	c_rtol
1327                     ; 535 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1329  033c 96            	ldw	x,sp
1330  033d ad12          	call	LC010
1332  033f 24ca          	jruge	L753
1333  0341 20bf          	jra	L553
1334  0343               LC009:
1335  0343 cd0000        	call	c_rtol
1336  0346 ae2400        	ldw	x,#9216
1337  0349 bf02          	ldw	c_lreg+2,x
1338  034b ae00f4        	ldw	x,#244
1339  034e bf00          	ldw	c_lreg,x
1340  0350 81            	ret	
1341  0351               LC010:
1342  0351 1c0009        	addw	x,#OFST-3
1343  0354 cd0000        	call	c_ltor
1345  0357 ae0000        	ldw	x,#L462
1346  035a cc0000        	jp	c_lcmp
1387                     ; 554 uint16_t tim2_init(void)
1387                     ; 555 {
1388                     	switch	.text
1389  035d               _tim2_init:
1391  035d 89            	pushw	x
1392       00000002      OFST:	set	2
1395                     ; 557 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1397  035e 4b00          	push	#0
1398  0360 4b00          	push	#0
1399  0362 ae4e20        	ldw	x,#20000
1400  0365 89            	pushw	x
1401  0366 a602          	ld	a,#2
1402  0368 cd027f        	call	_set_pwm_frequency
1404  036b 5b04          	addw	sp,#4
1405  036d 1f01          	ldw	(OFST-1,sp),x
1407                     ; 560 	OCR = 0;
1409  036f 5f            	clrw	x
1410  0370 bf02          	ldw	_OCR,x
1411                     ; 563 	TIM2_DeInit();
1413  0372 cd0000        	call	_TIM2_DeInit
1415                     ; 566 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1417  0375 1e01          	ldw	x,(OFST-1,sp)
1418  0377 89            	pushw	x
1419  0378 4f            	clr	a
1420  0379 cd0000        	call	_TIM2_TimeBaseInit
1422  037c 85            	popw	x
1423                     ; 569 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
1425  037d 4b00          	push	#0
1426  037f be02          	ldw	x,_OCR
1427  0381 89            	pushw	x
1428  0382 ae6011        	ldw	x,#24593
1429  0385 cd0000        	call	_TIM2_OC3Init
1431  0388 5b03          	addw	sp,#3
1432                     ; 570 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
1434  038a 4b00          	push	#0
1435  038c be02          	ldw	x,_OCR
1436  038e 89            	pushw	x
1437  038f ae6011        	ldw	x,#24593
1438  0392 cd0000        	call	_TIM2_OC2Init
1440  0395 5b03          	addw	sp,#3
1441                     ; 573 	TIM2_Cmd(ENABLE);
1443  0397 a601          	ld	a,#1
1444  0399 cd0000        	call	_TIM2_Cmd
1446                     ; 576 	return ARR;
1448  039c 1e01          	ldw	x,(OFST-1,sp)
1451  039e 5b02          	addw	sp,#2
1452  03a0 81            	ret	
1493                     ; 590 uint16_t tim1_init(void)
1493                     ; 591 {
1494                     	switch	.text
1495  03a1               _tim1_init:
1497  03a1 89            	pushw	x
1498       00000002      OFST:	set	2
1501                     ; 593 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1503  03a2 4b00          	push	#0
1504  03a4 4b00          	push	#0
1505  03a6 ae4e20        	ldw	x,#20000
1506  03a9 89            	pushw	x
1507  03aa a601          	ld	a,#1
1508  03ac cd027f        	call	_set_pwm_frequency
1510  03af 5b04          	addw	sp,#4
1511  03b1 1f01          	ldw	(OFST-1,sp),x
1513                     ; 596 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1515  03b3 5f            	clrw	x
1516  03b4 bf02          	ldw	_OCR,x
1517                     ; 599 	TIM1_DeInit();
1519  03b6 cd0000        	call	_TIM1_DeInit
1521                     ; 602 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1523  03b9 4b00          	push	#0
1524  03bb 1e02          	ldw	x,(OFST+0,sp)
1525  03bd 89            	pushw	x
1526  03be 4b00          	push	#0
1527  03c0 5f            	clrw	x
1528  03c1 cd0000        	call	_TIM1_TimeBaseInit
1530  03c4 5b04          	addw	sp,#4
1531                     ; 605 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1533  03c6 4b00          	push	#0
1534  03c8 4b00          	push	#0
1535  03ca 4b88          	push	#136
1536  03cc 4b00          	push	#0
1537  03ce be02          	ldw	x,_OCR
1538  03d0 89            	pushw	x
1539  03d1 4b00          	push	#0
1540  03d3 ae6011        	ldw	x,#24593
1541  03d6 cd0000        	call	_TIM1_OC3Init
1543  03d9 5b07          	addw	sp,#7
1544                     ; 608 	TIM1_Cmd(ENABLE);
1546  03db a601          	ld	a,#1
1547  03dd cd0000        	call	_TIM1_Cmd
1549                     ; 611 	TIM1_CtrlPWMOutputs(ENABLE);
1551  03e0 a601          	ld	a,#1
1552  03e2 cd0000        	call	_TIM1_CtrlPWMOutputs
1554                     ; 614 	return ARR;
1556  03e5 1e01          	ldw	x,(OFST-1,sp)
1559  03e7 5b02          	addw	sp,#2
1560  03e9 81            	ret	
1596                     ; 628 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1596                     ; 629 {	
1597                     	switch	.text
1598  03ea               _accelerate_pump:
1600  03ea 89            	pushw	x
1601       00000000      OFST:	set	0
1604                     ; 630 	delay_ms(1); // Short delay to smooth out the ramp-up.
1606  03eb ae0001        	ldw	x,#1
1607  03ee cd026d        	call	_delay_ms
1609                     ; 631 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1611  03f1 1e01          	ldw	x,(OFST+1,sp)
1612  03f3 cd0000        	call	_TIM1_SetCompare3
1614                     ; 632 	duty_cycle_step++; // Increment the duty cycle value.
1616  03f6 1e01          	ldw	x,(OFST+1,sp)
1617  03f8 5c            	incw	x
1618                     ; 634 	return duty_cycle_step; // Return the updated duty cycle.
1622  03f9 5b02          	addw	sp,#2
1623  03fb 81            	ret	
1659                     ; 647 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1659                     ; 648 {	
1660                     	switch	.text
1661  03fc               _decelerate_pump:
1663  03fc 89            	pushw	x
1664       00000000      OFST:	set	0
1667                     ; 649 	delay_ms(1); // Short delay to smooth out the ramp-down.
1669  03fd ae0001        	ldw	x,#1
1670  0400 cd026d        	call	_delay_ms
1672                     ; 650 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1674  0403 1e01          	ldw	x,(OFST+1,sp)
1675  0405 cd0000        	call	_TIM1_SetCompare3
1677                     ; 651 	duty_cycle_step--; // Decrement the duty cycle value.
1679  0408 1e01          	ldw	x,(OFST+1,sp)
1680  040a 5a            	decw	x
1681                     ; 653 	return duty_cycle_step; // Return the updated duty cycle.
1685  040b 5b02          	addw	sp,#2
1686  040d 81            	ret	
1721                     ; 665 uint16_t set_pump_speed(uint16_t duty_cycle_step)
1721                     ; 666 {	
1722                     	switch	.text
1723  040e               _set_pump_speed:
1725  040e 89            	pushw	x
1726       00000000      OFST:	set	0
1729                     ; 667 	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
1731  040f cd0000        	call	_TIM1_SetCompare3
1733                     ; 668 	return duty_cycle_step; // Return the specified duty cycle.
1735  0412 1e01          	ldw	x,(OFST+1,sp)
1738  0414 5b02          	addw	sp,#2
1739  0416 81            	ret	
1775                     ; 683 uint16_t pump_off(uint16_t duty_cycle_step)
1775                     ; 684 {
1776                     	switch	.text
1777  0417               _pump_off:
1779  0417 89            	pushw	x
1780       00000000      OFST:	set	0
1783                     ; 685 	if (duty_cycle_step > 0)
1785  0418 5d            	tnzw	x
1786  0419 2704          	jreq	L315
1787                     ; 688 		duty_cycle_step = decelerate_pump(duty_cycle_step);
1789  041b addf          	call	_decelerate_pump
1792  041d 2006          	jra	L515
1793  041f               L315:
1794                     ; 693 		TIM1_SetCompare3(0);
1796  041f 5f            	clrw	x
1797  0420 cd0000        	call	_TIM1_SetCompare3
1799  0423 1e01          	ldw	x,(OFST+1,sp)
1800  0425               L515:
1801                     ; 696 	return duty_cycle_step;
1805  0425 5b02          	addw	sp,#2
1806  0427 81            	ret	
1844                     ; 712 uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
1844                     ; 713 {
1845                     	switch	.text
1846  0428               _pump_smooth_on_off:
1848  0428 89            	pushw	x
1849       00000000      OFST:	set	0
1852                     ; 715 	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
1854  0429 b308          	cpw	x,_max_pwm_speed_pump
1855  042b 240a          	jruge	L535
1857  042d 3d15          	tnz	_pulse_flag
1858  042f 2606          	jrne	L535
1859                     ; 717 		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
1861  0431 adb7          	call	_accelerate_pump
1863  0433 1f01          	ldw	(OFST+1,sp),x
1865  0435 2004          	jra	L735
1866  0437               L535:
1867                     ; 721 		pulse_flag = 1;	// Switch to deceleration mode
1869  0437 35010015      	mov	_pulse_flag,#1
1870  043b               L735:
1871                     ; 725 	if ((duty_cycle_step > 0) && (pulse_flag == 1))
1873  043b 1e01          	ldw	x,(OFST+1,sp)
1874  043d 2709          	jreq	L145
1876  043f b615          	ld	a,_pulse_flag
1877  0441 4a            	dec	a
1878  0442 2604          	jrne	L145
1879                     ; 727 		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
1881  0444 adb6          	call	_decelerate_pump
1884  0446 2002          	jra	L345
1885  0448               L145:
1886                     ; 731 		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
1888  0448 3f15          	clr	_pulse_flag
1889  044a               L345:
1890                     ; 733 	return duty_cycle_step;	// Return the updated duty cycle value
1894  044a 5b02          	addw	sp,#2
1895  044c 81            	ret	
2112                     	xdef	_main
2113                     	xdef	_current_state
2114                     	xdef	_pump_off
2115                     	xdef	_decelerate_pump
2116                     	xdef	_accelerate_pump
2117                     	xdef	_set_pump_speed
2118                     	xdef	_pump_smooth_on_off
2119                     	xdef	_tim1_init
2120                     	xdef	_tim2_init
2121                     	xdef	_set_pwm_frequency
2122                     	xdef	_delay_ms
2123                     	xdef	_tim4_init
2124                     	xdef	_EXTI_setup
2125                     	xdef	_gpio_setup
2126                     	xdef	_clock_setup
2127                     	xdef	_last_interrupt_time
2128                     	xdef	_pulse_flag
2129                     	xdef	_duty_cycle_step
2130                     	xdef	_button_press_duration
2131                     	xdef	_button_press_start
2132                     	xdef	_button_pressed
2133                     	xdef	_long_press
2134                     	xdef	_press_count
2135                     	xdef	_max_pwm_speed_LED
2136                     	xdef	_max_pwm_speed_pump
2137                     	xdef	_arr_tim2
2138                     	xdef	_arr_tim1
2139                     	xdef	_OCR
2140                     	xref	_pow
2141                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2142                     	xdef	f_EXTI_PORTD_IRQHandler
2143                     	xdef	_ms_count
2144                     	xref	_TIM4_ClearITPendingBit
2145                     	xref	_TIM4_ITConfig
2146                     	xref	_TIM4_Cmd
2147                     	xref	_TIM4_TimeBaseInit
2148                     	xref	_TIM4_DeInit
2149                     	xref	_TIM2_SetCompare3
2150                     	xref	_TIM2_SetCompare2
2151                     	xref	_TIM2_Cmd
2152                     	xref	_TIM2_OC3Init
2153                     	xref	_TIM2_OC2Init
2154                     	xref	_TIM2_TimeBaseInit
2155                     	xref	_TIM2_DeInit
2156                     	xref	_TIM1_SetCompare3
2157                     	xref	_TIM1_CtrlPWMOutputs
2158                     	xref	_TIM1_Cmd
2159                     	xref	_TIM1_OC3Init
2160                     	xref	_TIM1_TimeBaseInit
2161                     	xref	_TIM1_DeInit
2162                     	xref	_ITC_SetSoftwarePriority
2163                     	xref	_ITC_DeInit
2164                     	xref	_GPIO_ReadInputPin
2165                     	xref	_GPIO_Init
2166                     	xref	_GPIO_DeInit
2167                     	xref	_EXTI_SetTLISensitivity
2168                     	xref	_EXTI_SetExtIntSensitivity
2169                     	xref	_EXTI_DeInit
2170                     	xref	_CLK_GetFlagStatus
2171                     	xref	_CLK_SYSCLKConfig
2172                     	xref	_CLK_HSIPrescalerConfig
2173                     	xref	_CLK_ClockSwitchConfig
2174                     	xref	_CLK_PeripheralClockConfig
2175                     	xref	_CLK_ClockSwitchCmd
2176                     	xref	_CLK_LSICmd
2177                     	xref	_CLK_HSICmd
2178                     	xref	_CLK_HSECmd
2179                     	xref	_CLK_DeInit
2180                     	switch	.const
2181  0004               L143:
2182  0004 3f800000      	dc.w	16256,0
2183  0008               L133:
2184  0008 40000000      	dc.w	16384,0
2185                     	xref.b	c_lreg
2186                     	xref.b	c_x
2187                     	xref.b	c_y
2207                     	xref	c_lsbc
2208                     	xref	c_ldiv
2209                     	xref	c_uitolx
2210                     	xref	c_imul
2211                     	xref	c_lcmp
2212                     	xref	c_ltor
2213                     	xref	c_ftol
2214                     	xref	c_fsub
2215                     	xref	c_fdiv
2216                     	xref	c_fmul
2217                     	xref	c_rtol
2218                     	xref	c_itof
2219                     	xref	c_uitof
2220                     	xref	c_bmulx
2221                     	xref	c_ltof
2222                     	end
