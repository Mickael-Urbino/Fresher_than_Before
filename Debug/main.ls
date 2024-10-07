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
 305                     ; 158 main()
 305                     ; 159 {
 307                     	switch	.text
 308  009f               _main:
 312                     ; 161 	clock_setup();						// Configure system clock and timing
 314  009f cd01be        	call	_clock_setup
 316                     ; 162 	EXTI_setup();							// Setup external interrupts for button handling
 318  00a2 cd0247        	call	_EXTI_setup
 320                     ; 163 	enableInterrupts();				// Globally enable interrupts
 323  00a5 9a            	rim	
 325                     ; 171 	tim4_init();
 328  00a6 cd025f        	call	_tim4_init
 330                     ; 172 	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
 332  00a9 ae1388        	ldw	x,#5000
 333  00ac cd0273        	call	_delay_ms
 335                     ; 175 	gpio_setup();
 337  00af cd021e        	call	_gpio_setup
 339                     ; 182 	max_pwm_speed_pump = tim1_init();	
 341  00b2 cd03a7        	call	_tim1_init
 343  00b5 bf08          	ldw	_max_pwm_speed_pump,x
 344  00b7               L301:
 345                     ; 192 		switch (current_state)
 347  00b7 b618          	ld	a,_current_state
 349                     ; 374 				break;
 350  00b9 271c          	jreq	L75
 351  00bb 4a            	dec	a
 352  00bc 272f          	jreq	L16
 353  00be 4a            	dec	a
 354  00bf 2603cc0143    	jreq	L56
 355  00c4 4a            	dec	a
 356  00c5 2746          	jreq	L36
 357  00c7 4a            	dec	a
 358  00c8 2603cc016c    	jreq	L76
 359                     ; 363 			default:
 359                     ; 364 			
 359                     ; 365 				// Unexpected state: reset to SLEEP state as a failsafe
 359                     ; 366 				current_state = STATE_SLEEP;	// Reset to SLEEP state
 361  00cd 3f18          	clr	_current_state
 362                     ; 369 				duty_cycle_step = pump_off(duty_cycle_step);
 364  00cf cd01a9        	call	LC005
 365                     ; 370 				press_count = 0;
 367  00d2 3f0c          	clr	_press_count
 368                     ; 372 				TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 370                     ; 374 				break;
 372  00d4 cc01a3        	jp	LC002
 373  00d7               L75:
 374                     ; 194 			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
 374                     ; 195 				
 374                     ; 196 				if (duty_cycle_step != 0)
 376  00d7 be13          	ldw	x,_duty_cycle_step
 377  00d9 2703          	jreq	L311
 378                     ; 198 					duty_cycle_step = pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
 380  00db cd01a9        	call	LC005
 381  00de               L311:
 382                     ; 201 				if (press_count > 0)
 384  00de 3d0c          	tnz	_press_count
 385  00e0 27d5          	jreq	L301
 386                     ; 203 					current_state = STATE_IDLE;
 388  00e2 35010018      	mov	_current_state,#1
 389                     ; 204 					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
 391  00e6 cd0363        	call	_tim2_init
 393  00e9 bf0a          	ldw	_max_pwm_speed_LED,x
 394  00eb 20ca          	jra	L301
 395  00ed               L16:
 396                     ; 208 			case STATE_IDLE:	// Idle state: low LED brightness and pump off
 396                     ; 209 			
 396                     ; 210 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 398  00ed cd01b1        	call	LC006
 399  00f0 cd0000        	call	_TIM2_SetCompare3
 401                     ; 211 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 403  00f3 cd01b1        	call	LC006
 404  00f6 cd0000        	call	_TIM2_SetCompare2
 406                     ; 213 				pump_off(duty_cycle_step);	// Keep the pump turned off
 408  00f9 be13          	ldw	x,_duty_cycle_step
 409  00fb cd041d        	call	_pump_off
 411                     ; 216 				if (press_count > 1)
 413  00fe b60c          	ld	a,_press_count
 414  0100 a102          	cp	a,#2
 415  0102 2403cc018c    	jrult	L741
 416                     ; 218 					current_state = STATE_LOW_SPEED;
 418  0107 35030018      	mov	_current_state,#3
 419                     ; 220 					TIM2_SetCompare2(0);
 421                     ; 224 				if (long_press != 0)
 422                     ; 226 					current_state = STATE_SLEEP;
 423                     ; 229 					duty_cycle_step = pump_off(duty_cycle_step);					
 425                     ; 230 					press_count = 0;
 426                     ; 231 					long_press = 0;
 427                     ; 234 					TIM2_SetCompare2(0);
 429                     ; 235 					TIM2_SetCompare3(0);
 431                     ; 237 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 433  010b 207b          	jp	LC004
 434  010d               L36:
 435                     ; 242 			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
 435                     ; 243 				
 435                     ; 244 				// Set LED brightness to 1% of maximum
 435                     ; 245 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 437  010d cd01b1        	call	LC006
 438  0110 cd0000        	call	_TIM2_SetCompare3
 440                     ; 248 				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
 442  0113 cd01b7        	call	LC007
 443  0116 b313          	cpw	x,_duty_cycle_step
 444  0118 2407          	jruge	L321
 445                     ; 250 					duty_cycle_step = decelerate_pump(duty_cycle_step);
 447  011a be13          	ldw	x,_duty_cycle_step
 448  011c cd0402        	call	_decelerate_pump
 451  011f 2014          	jra	L521
 452  0121               L321:
 453                     ; 252 				else if (duty_cycle_step < (max_pwm_speed_pump/3)*2)
 455  0121 cd01b7        	call	LC007
 456  0124 b313          	cpw	x,_duty_cycle_step
 457  0126 2307          	jrule	L721
 458                     ; 254 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 460  0128 be13          	ldw	x,_duty_cycle_step
 461  012a cd03f0        	call	_accelerate_pump
 464  012d 2006          	jra	L521
 465  012f               L721:
 466                     ; 258 					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
 468  012f cd01b7        	call	LC007
 469  0132 cd0414        	call	_set_pump_speed
 471  0135               L521:
 472  0135 bf13          	ldw	_duty_cycle_step,x
 473                     ; 262 				if (press_count > 2)
 475  0137 b60c          	ld	a,_press_count
 476  0139 a103          	cp	a,#3
 477  013b 254f          	jrult	L741
 478                     ; 264 					current_state = STATE_FULL_SPEED;
 480  013d 35020018      	mov	_current_state,#2
 481                     ; 268 				if (long_press != 0)
 482                     ; 270 					current_state = STATE_SLEEP;
 483                     ; 273 					duty_cycle_step = pump_off(duty_cycle_step);					
 485                     ; 274 					press_count = 0;
 486                     ; 275 					long_press = 0;
 487                     ; 278 					TIM2_SetCompare2(0);
 489                     ; 279 					TIM2_SetCompare3(0);
 491                     ; 281 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 493  0141 2049          	jp	L741
 494  0143               L56:
 495                     ; 285 			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
 495                     ; 286 				
 495                     ; 287 				// Set LED to maximum brightness
 495                     ; 288 				TIM2_SetCompare3(max_pwm_speed_LED/100);
 497  0143 ad6c          	call	LC006
 498  0145 cd0000        	call	_TIM2_SetCompare3
 500                     ; 291 				if (duty_cycle_step < max_pwm_speed_pump)
 502  0148 be13          	ldw	x,_duty_cycle_step
 503  014a b308          	cpw	x,_max_pwm_speed_pump
 504  014c 2407          	jruge	L731
 505                     ; 293 					duty_cycle_step = accelerate_pump(duty_cycle_step);
 507  014e be13          	ldw	x,_duty_cycle_step
 508  0150 cd03f0        	call	_accelerate_pump
 511  0153 2005          	jra	L141
 512  0155               L731:
 513                     ; 297 					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
 515  0155 be08          	ldw	x,_max_pwm_speed_pump
 516  0157 cd0414        	call	_set_pump_speed
 518  015a               L141:
 519  015a bf13          	ldw	_duty_cycle_step,x
 520                     ; 301 				if (press_count > 3)
 522  015c b60c          	ld	a,_press_count
 523  015e a104          	cp	a,#4
 524  0160 252a          	jrult	L741
 525                     ; 303 					current_state = STATE_PULSE;
 527  0162 35040018      	mov	_current_state,#4
 528                     ; 304 					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
 530  0166 5f            	clrw	x
 531  0167 cd0000        	call	_TIM2_SetCompare3
 533                     ; 308 				if (long_press != 0)
 534                     ; 310 					current_state = STATE_SLEEP;
 535                     ; 313 					duty_cycle_step = pump_off(duty_cycle_step);					
 537                     ; 314 					press_count = 0;
 538                     ; 315 					long_press = 0;
 539                     ; 318 					TIM2_SetCompare2(0);
 541                     ; 319 					TIM2_SetCompare3(0);
 543                     ; 321 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 545  016a 2020          	jp	L741
 546  016c               L76:
 547                     ; 325 			case STATE_PULSE:	// Pulsed pump operation with LED indication
 547                     ; 326 			
 547                     ; 327 				// Set LED PULSE to 1% brightnes
 547                     ; 328 				TIM2_SetCompare2(max_pwm_speed_LED/100);
 549  016c ad43          	call	LC006
 550  016e cd0000        	call	_TIM2_SetCompare2
 552                     ; 331 				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
 554  0171 be13          	ldw	x,_duty_cycle_step
 555  0173 cd042e        	call	_pump_smooth_on_off
 557  0176 bf13          	ldw	_duty_cycle_step,x
 558                     ; 334 				if (press_count > 4)
 560  0178 b60c          	ld	a,_press_count
 561  017a a105          	cp	a,#5
 562  017c 250e          	jrult	L741
 563                     ; 336 					current_state = STATE_LOW_SPEED;	// Reset to SLEEP state
 565  017e 35030018      	mov	_current_state,#3
 566                     ; 339 					duty_cycle_step = pump_off(duty_cycle_step);
 568  0182 ad25          	call	LC005
 569                     ; 340 					press_count = 2;
 571  0184 3502000c      	mov	_press_count,#2
 572                     ; 342 					TIM2_SetCompare2(0);	// Turn off LED PULSE				
 574  0188               LC004:
 576  0188 5f            	clrw	x
 577  0189 cd0000        	call	_TIM2_SetCompare2
 579  018c               L741:
 580                     ; 346 				if (long_press != 0)
 582                     ; 348 					current_state = STATE_SLEEP;
 584                     ; 351 					duty_cycle_step = pump_off(duty_cycle_step);					
 587                     ; 352 					press_count = 0;
 589                     ; 353 					long_press = 0;
 591                     ; 356 					TIM2_SetCompare2(0);
 594                     ; 357 					TIM2_SetCompare3(0);
 599  018c 3d0d          	tnz	_long_press
 600  018e 2603cc00b7    	jreq	L301
 604  0193 3f18          	clr	_current_state
 608  0195 ad12          	call	LC005
 612  0197 3f0c          	clr	_press_count
 616  0199 3f0d          	clr	_long_press
 620  019b 5f            	clrw	x
 621  019c cd0000        	call	_TIM2_SetCompare2
 625  019f 5f            	clrw	x
 626  01a0 cd0000        	call	_TIM2_SetCompare3
 628                     ; 359 					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
 630  01a3               LC002:
 635  01a3 cd0000        	call	_TIM2_DeInit
 637  01a6 cc00b7        	jra	L301
 638                     ; 374 				break;
 639  01a9               LC005:
 640  01a9 be13          	ldw	x,_duty_cycle_step
 641  01ab cd041d        	call	_pump_off
 642  01ae bf13          	ldw	_duty_cycle_step,x
 643  01b0 81            	ret	
 644  01b1               LC006:
 645  01b1 be0a          	ldw	x,_max_pwm_speed_LED
 646  01b3 a664          	ld	a,#100
 647  01b5 62            	div	x,a
 648  01b6 81            	ret	
 649  01b7               LC007:
 650  01b7 be08          	ldw	x,_max_pwm_speed_pump
 651  01b9 a603          	ld	a,#3
 652  01bb 62            	div	x,a
 653  01bc 58            	sllw	x
 654  01bd 81            	ret	
 687                     ; 386 void clock_setup(void)
 687                     ; 387 {
 688                     	switch	.text
 689  01be               _clock_setup:
 693                     ; 388 	CLK_DeInit();		// Reset clock configuration to default state
 695  01be cd0000        	call	_CLK_DeInit
 697                     ; 390 	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
 699  01c1 4f            	clr	a
 700  01c2 cd0000        	call	_CLK_HSECmd
 702                     ; 391 	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
 704  01c5 4f            	clr	a
 705  01c6 cd0000        	call	_CLK_LSICmd
 707                     ; 392 	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
 709  01c9 a601          	ld	a,#1
 710  01cb cd0000        	call	_CLK_HSICmd
 713  01ce               L561:
 714                     ; 394 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
 716  01ce ae0102        	ldw	x,#258
 717  01d1 cd0000        	call	_CLK_GetFlagStatus
 719  01d4 4d            	tnz	a
 720  01d5 27f7          	jreq	L561
 721                     ; 396 	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
 723  01d7 a601          	ld	a,#1
 724  01d9 cd0000        	call	_CLK_ClockSwitchCmd
 726                     ; 397 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
 728  01dc 4f            	clr	a
 729  01dd cd0000        	call	_CLK_HSIPrescalerConfig
 731                     ; 398 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
 733  01e0 a680          	ld	a,#128
 734  01e2 cd0000        	call	_CLK_SYSCLKConfig
 736                     ; 400 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 736                     ; 401 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 738  01e5 4b01          	push	#1
 739  01e7 4b00          	push	#0
 740  01e9 ae01e1        	ldw	x,#481
 741  01ec cd0000        	call	_CLK_ClockSwitchConfig
 743  01ef 85            	popw	x
 744                     ; 404 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 746  01f0 5f            	clrw	x
 747  01f1 cd0000        	call	_CLK_PeripheralClockConfig
 749                     ; 405 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 751  01f4 ae0100        	ldw	x,#256
 752  01f7 cd0000        	call	_CLK_PeripheralClockConfig
 754                     ; 406 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 756  01fa ae1300        	ldw	x,#4864
 757  01fd cd0000        	call	_CLK_PeripheralClockConfig
 759                     ; 407 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 761  0200 ae1200        	ldw	x,#4608
 762  0203 cd0000        	call	_CLK_PeripheralClockConfig
 764                     ; 408 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
 766  0206 ae0300        	ldw	x,#768
 767  0209 cd0000        	call	_CLK_PeripheralClockConfig
 769                     ; 409 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
 771  020c ae0701        	ldw	x,#1793
 772  020f cd0000        	call	_CLK_PeripheralClockConfig
 774                     ; 410 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
 776  0212 ae0501        	ldw	x,#1281
 777  0215 cd0000        	call	_CLK_PeripheralClockConfig
 779                     ; 411 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
 781  0218 ae0401        	ldw	x,#1025
 783                     ; 413 }
 786  021b cc0000        	jp	_CLK_PeripheralClockConfig
 811                     ; 422 void gpio_setup(void)
 811                     ; 423 {
 812                     	switch	.text
 813  021e               _gpio_setup:
 817                     ; 424 	GPIO_DeInit(GPIOA);  // Reset Port A configuration
 819  021e ae5000        	ldw	x,#20480
 820  0221 cd0000        	call	_GPIO_DeInit
 822                     ; 425 	GPIO_DeInit(GPIOB);  // Reset Port B configuration
 824  0224 ae5005        	ldw	x,#20485
 825  0227 cd0000        	call	_GPIO_DeInit
 827                     ; 426 	GPIO_DeInit(GPIOD);  // Reset Port D configuration
 829  022a ae500f        	ldw	x,#20495
 830  022d cd0000        	call	_GPIO_DeInit
 832                     ; 428 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);					// Configure Pin D6 as an floating input with interrupt
 834  0230 4b20          	push	#32
 835  0232 4b40          	push	#64
 836  0234 ae500f        	ldw	x,#20495
 837  0237 cd0000        	call	_GPIO_Init
 839  023a 85            	popw	x
 840                     ; 429 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
 842  023b 4be0          	push	#224
 843  023d 4b10          	push	#16
 844  023f ae5005        	ldw	x,#20485
 845  0242 cd0000        	call	_GPIO_Init
 847  0245 85            	popw	x
 848                     ; 430 }
 851  0246 81            	ret	
 880                     ; 439 void EXTI_setup(void)
 880                     ; 440 {
 881                     	switch	.text
 882  0247               _EXTI_setup:
 886                     ; 441 	ITC_DeInit();	// Reset interrupt controller configuration
 888  0247 cd0000        	call	_ITC_DeInit
 890                     ; 442 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
 892  024a ae0602        	ldw	x,#1538
 893  024d cd0000        	call	_ITC_SetSoftwarePriority
 895                     ; 444 	EXTI_DeInit(); // Reset external interrupt configuration
 897  0250 cd0000        	call	_EXTI_DeInit
 899                     ; 446 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_FALL);  // Enable falling and rising-edge sensitivity for Port D
 901  0253 ae0303        	ldw	x,#771
 902  0256 cd0000        	call	_EXTI_SetExtIntSensitivity
 904                     ; 447 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
 906  0259 4f            	clr	a
 907  025a cd0000        	call	_EXTI_SetTLISensitivity
 909                     ; 449 	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
 912  025d 9a            	rim	
 914                     ; 450 }
 918  025e 81            	ret	
 945                     ; 459 void tim4_init(void) //Timer Used to count milliseconds for delay function
 945                     ; 460 {
 946                     	switch	.text
 947  025f               _tim4_init:
 951                     ; 462 	TIM4_DeInit();	// Reset Timer 4 configuration
 953  025f cd0000        	call	_TIM4_DeInit
 955                     ; 463 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
 957  0262 ae077d        	ldw	x,#1917
 958  0265 cd0000        	call	_TIM4_TimeBaseInit
 960                     ; 464 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
 962  0268 ae0101        	ldw	x,#257
 963  026b cd0000        	call	_TIM4_ITConfig
 965                     ; 465 	TIM4_Cmd(ENABLE);  // Start Timer 4
 967  026e a601          	ld	a,#1
 969                     ; 467 }
 972  0270 cc0000        	jp	_TIM4_Cmd
1016                     ; 477 void delay_ms(uint16_t delay)
1016                     ; 478 {
1017                     	switch	.text
1018  0273               _delay_ms:
1020  0273 89            	pushw	x
1021  0274 89            	pushw	x
1022       00000002      OFST:	set	2
1025                     ; 479     uint16_t start = ms_count;	// Record the current timer count
1027  0275 be00          	ldw	x,_ms_count
1028  0277 1f01          	ldw	(OFST-1,sp),x
1031  0279               L742:
1032                     ; 480     while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
1034  0279 be00          	ldw	x,_ms_count
1035  027b 72f001        	subw	x,(OFST-1,sp)
1036  027e 1303          	cpw	x,(OFST+1,sp)
1037  0280 25f7          	jrult	L742
1038                     ; 482 }
1041  0282 5b04          	addw	sp,#4
1042  0284 81            	ret	
1113                     .const:	section	.text
1114  0000               L462:
1115  0000 00010000      	dc.l	65536
1116                     ; 498 uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
1116                     ; 499 {
1117                     	switch	.text
1118  0285               _set_pwm_frequency:
1120  0285 88            	push	a
1121  0286 520c          	subw	sp,#12
1122       0000000c      OFST:	set	12
1125                     ; 500 	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
1127                     ; 501 	switch (hsi_prescaler)
1129  0288 7b12          	ld	a,(OFST+6,sp)
1131                     ; 517 			break;
1132  028a 270e          	jreq	L352
1133  028c a008          	sub	a,#8
1134  028e 270d          	jreq	L552
1135  0290 a008          	sub	a,#8
1136  0292 270d          	jreq	L752
1137  0294 a008          	sub	a,#8
1138  0296 270d          	jreq	L162
1139  0298 200f          	jra	L323
1140  029a               L352:
1141                     ; 503 		case 0x00:
1141                     ; 504 			hsi_prescaler = 1;
1143  029a 4c            	inc	a
1144                     ; 505 			break;
1146  029b 200a          	jp	LC008
1147  029d               L552:
1148                     ; 507 		case 0x08:
1148                     ; 508 			hsi_prescaler = 2;
1150  029d a602          	ld	a,#2
1151                     ; 509 			break;
1153  029f 2006          	jp	LC008
1154  02a1               L752:
1155                     ; 511 		case 0x10:
1155                     ; 512 			hsi_prescaler = 4;
1157  02a1 a604          	ld	a,#4
1158                     ; 513 			break;
1160  02a3 2002          	jp	LC008
1161  02a5               L162:
1162                     ; 515 		case 0x18:
1162                     ; 516 			hsi_prescaler = 8;
1164  02a5 a608          	ld	a,#8
1165  02a7               LC008:
1166  02a7 6b12          	ld	(OFST+6,sp),a
1167                     ; 517 			break;
1169  02a9               L323:
1170                     ; 520 	if (timer !=  1)
1172  02a9 7b0d          	ld	a,(OFST+1,sp)
1173  02ab 4a            	dec	a
1174  02ac 275f          	jreq	L523
1175                     ; 522 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
1192  02ae 2005          	jra	L353
1193  02b0               L743:
1194                     ; 526 			frequency++;
1196  02b0 1e10          	ldw	x,(OFST+4,sp)
1197  02b2 5c            	incw	x
1198  02b3 1f10          	ldw	(OFST+4,sp),x
1199                     ; 527 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
1216  02b5               L353:
1218  02b5 7b13          	ld	a,(OFST+7,sp)
1219  02b7 5f            	clrw	x
1220  02b8 97            	ld	xl,a
1221  02b9 cd0000        	call	c_itof
1222  02bc be02          	ldw	x,c_lreg+2
1223  02be 89            	pushw	x
1224  02bf be00          	ldw	x,c_lreg
1225  02c1 89            	pushw	x
1226  02c2 ce000a        	ldw	x,L333+2
1227  02c5 89            	pushw	x
1228  02c6 ce0008        	ldw	x,L333
1229  02c9 89            	pushw	x
1230  02ca cd0000        	call	_pow
1231  02cd 5b08          	addw	sp,#8
1232  02cf 96            	ldw	x,sp
1233  02d0 1c0005        	addw	x,#OFST-7
1234  02d3 cd0000        	call	c_rtol
1235  02d6 1e10          	ldw	x,(OFST+4,sp)
1236  02d8 7b12          	ld	a,(OFST+6,sp)
1237  02da cd0000        	call	c_bmulx
1238  02dd cd0000        	call	c_uitof
1239  02e0 96            	ldw	x,sp
1240  02e1 1c0005        	addw	x,#OFST-7
1241  02e4 cd0000        	call	c_fmul
1242  02e7 96            	ldw	x,sp
1243  02e8 5c            	incw	x
1244  02e9 ad5e          	call	LC009
1245  02eb cd0000        	call	c_ltof
1246  02ee 96            	ldw	x,sp
1247  02ef 5c            	incw	x
1248  02f0 cd0000        	call	c_fdiv
1249  02f3 ae0004        	ldw	x,#L343
1250  02f6 cd0000        	call	c_fsub
1251  02f9 cd0000        	call	c_ftol
1252  02fc 96            	ldw	x,sp
1253  02fd 1c0009        	addw	x,#OFST-3
1254  0300 cd0000        	call	c_rtol
1255                     ; 524 		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
1257  0303 96            	ldw	x,sp
1258  0304 ad51          	call	LC010
1260  0306 24a8          	jruge	L743
1262  0308               L753:
1263                     ; 542 	return (uint16_t)arr;
1265  0308 1e0b          	ldw	x,(OFST-1,sp)
1268  030a 5b0d          	addw	sp,#13
1269  030c 81            	ret	
1270  030d               L523:
1271                     ; 532 		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
1273  030d 1e10          	ldw	x,(OFST+4,sp)
1284  030f 2005          	jra	L563
1285  0311               L163:
1286                     ; 536 			frequency++;
1288  0311 1e10          	ldw	x,(OFST+4,sp)
1289  0313 5c            	incw	x
1290  0314 1f10          	ldw	(OFST+4,sp),x
1291                     ; 537 			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
1302  0316               L563:
1303  0316 7b12          	ld	a,(OFST+6,sp)
1304  0318 cd0000        	call	c_bmulx
1305  031b 7b13          	ld	a,(OFST+7,sp)
1306  031d 905f          	clrw	y
1307  031f 9097          	ld	yl,a
1308  0321 905c          	incw	y
1309  0323 cd0000        	call	c_imul
1310  0326 cd0000        	call	c_uitolx
1311  0329 96            	ldw	x,sp
1312  032a 1c0005        	addw	x,#OFST-7
1313  032d ad1a          	call	LC009
1314  032f 96            	ldw	x,sp
1315  0330 1c0005        	addw	x,#OFST-7
1316  0333 cd0000        	call	c_ldiv
1317  0336 a601          	ld	a,#1
1318  0338 cd0000        	call	c_lsbc
1319  033b 96            	ldw	x,sp
1320  033c 1c0009        	addw	x,#OFST-3
1321  033f cd0000        	call	c_rtol
1322                     ; 534 		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
1324  0342 96            	ldw	x,sp
1325  0343 ad12          	call	LC010
1327  0345 24ca          	jruge	L163
1328  0347 20bf          	jra	L753
1329  0349               LC009:
1330  0349 cd0000        	call	c_rtol
1331  034c ae2400        	ldw	x,#9216
1332  034f bf02          	ldw	c_lreg+2,x
1333  0351 ae00f4        	ldw	x,#244
1334  0354 bf00          	ldw	c_lreg,x
1335  0356 81            	ret	
1336  0357               LC010:
1337  0357 1c0009        	addw	x,#OFST-3
1338  035a cd0000        	call	c_ltor
1340  035d ae0000        	ldw	x,#L462
1341  0360 cc0000        	jp	c_lcmp
1382                     ; 553 uint16_t tim2_init(void)
1382                     ; 554 {
1383                     	switch	.text
1384  0363               _tim2_init:
1386  0363 89            	pushw	x
1387       00000002      OFST:	set	2
1390                     ; 556 	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
1392  0364 4b00          	push	#0
1393  0366 4b00          	push	#0
1394  0368 ae4e20        	ldw	x,#20000
1395  036b 89            	pushw	x
1396  036c a602          	ld	a,#2
1397  036e cd0285        	call	_set_pwm_frequency
1399  0371 5b04          	addw	sp,#4
1400  0373 1f01          	ldw	(OFST-1,sp),x
1402                     ; 559 	OCR = 0;
1404  0375 5f            	clrw	x
1405  0376 bf02          	ldw	_OCR,x
1406                     ; 562 	TIM2_DeInit();
1408  0378 cd0000        	call	_TIM2_DeInit
1410                     ; 565 	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
1412  037b 1e01          	ldw	x,(OFST-1,sp)
1413  037d 89            	pushw	x
1414  037e 4f            	clr	a
1415  037f cd0000        	call	_TIM2_TimeBaseInit
1417  0382 85            	popw	x
1418                     ; 568 	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
1420  0383 4b00          	push	#0
1421  0385 be02          	ldw	x,_OCR
1422  0387 89            	pushw	x
1423  0388 ae6011        	ldw	x,#24593
1424  038b cd0000        	call	_TIM2_OC3Init
1426  038e 5b03          	addw	sp,#3
1427                     ; 569 	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
1429  0390 4b00          	push	#0
1430  0392 be02          	ldw	x,_OCR
1431  0394 89            	pushw	x
1432  0395 ae6011        	ldw	x,#24593
1433  0398 cd0000        	call	_TIM2_OC2Init
1435  039b 5b03          	addw	sp,#3
1436                     ; 572 	TIM2_Cmd(ENABLE);
1438  039d a601          	ld	a,#1
1439  039f cd0000        	call	_TIM2_Cmd
1441                     ; 575 	return ARR;
1443  03a2 1e01          	ldw	x,(OFST-1,sp)
1446  03a4 5b02          	addw	sp,#2
1447  03a6 81            	ret	
1488                     ; 589 uint16_t tim1_init(void)
1488                     ; 590 {
1489                     	switch	.text
1490  03a7               _tim1_init:
1492  03a7 89            	pushw	x
1493       00000002      OFST:	set	2
1496                     ; 592 	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
1498  03a8 4b00          	push	#0
1499  03aa 4b00          	push	#0
1500  03ac ae4e20        	ldw	x,#20000
1501  03af 89            	pushw	x
1502  03b0 a601          	ld	a,#1
1503  03b2 cd0285        	call	_set_pwm_frequency
1505  03b5 5b04          	addw	sp,#4
1506  03b7 1f01          	ldw	(OFST-1,sp),x
1508                     ; 595 	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
1510  03b9 5f            	clrw	x
1511  03ba bf02          	ldw	_OCR,x
1512                     ; 598 	TIM1_DeInit();
1514  03bc cd0000        	call	_TIM1_DeInit
1516                     ; 601 	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
1518  03bf 4b00          	push	#0
1519  03c1 1e02          	ldw	x,(OFST+0,sp)
1520  03c3 89            	pushw	x
1521  03c4 4b00          	push	#0
1522  03c6 5f            	clrw	x
1523  03c7 cd0000        	call	_TIM1_TimeBaseInit
1525  03ca 5b04          	addw	sp,#4
1526                     ; 604 	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
1528  03cc 4b00          	push	#0
1529  03ce 4b00          	push	#0
1530  03d0 4b88          	push	#136
1531  03d2 4b00          	push	#0
1532  03d4 be02          	ldw	x,_OCR
1533  03d6 89            	pushw	x
1534  03d7 4b00          	push	#0
1535  03d9 ae6011        	ldw	x,#24593
1536  03dc cd0000        	call	_TIM1_OC3Init
1538  03df 5b07          	addw	sp,#7
1539                     ; 607 	TIM1_Cmd(ENABLE);
1541  03e1 a601          	ld	a,#1
1542  03e3 cd0000        	call	_TIM1_Cmd
1544                     ; 610 	TIM1_CtrlPWMOutputs(ENABLE);
1546  03e6 a601          	ld	a,#1
1547  03e8 cd0000        	call	_TIM1_CtrlPWMOutputs
1549                     ; 613 	return ARR;
1551  03eb 1e01          	ldw	x,(OFST-1,sp)
1554  03ed 5b02          	addw	sp,#2
1555  03ef 81            	ret	
1591                     ; 627 uint16_t accelerate_pump(uint16_t duty_cycle_step)
1591                     ; 628 {	
1592                     	switch	.text
1593  03f0               _accelerate_pump:
1595  03f0 89            	pushw	x
1596       00000000      OFST:	set	0
1599                     ; 629 	delay_ms(1); // Short delay to smooth out the ramp-up.
1601  03f1 ae0001        	ldw	x,#1
1602  03f4 cd0273        	call	_delay_ms
1604                     ; 630 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1606  03f7 1e01          	ldw	x,(OFST+1,sp)
1607  03f9 cd0000        	call	_TIM1_SetCompare3
1609                     ; 631 	duty_cycle_step++; // Increment the duty cycle value.
1611  03fc 1e01          	ldw	x,(OFST+1,sp)
1612  03fe 5c            	incw	x
1613                     ; 633 	return duty_cycle_step; // Return the updated duty cycle.
1617  03ff 5b02          	addw	sp,#2
1618  0401 81            	ret	
1654                     ; 646 uint16_t decelerate_pump(uint16_t duty_cycle_step)
1654                     ; 647 {	
1655                     	switch	.text
1656  0402               _decelerate_pump:
1658  0402 89            	pushw	x
1659       00000000      OFST:	set	0
1662                     ; 648 	delay_ms(1); // Short delay to smooth out the ramp-down.
1664  0403 ae0001        	ldw	x,#1
1665  0406 cd0273        	call	_delay_ms
1667                     ; 649 	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
1669  0409 1e01          	ldw	x,(OFST+1,sp)
1670  040b cd0000        	call	_TIM1_SetCompare3
1672                     ; 650 	duty_cycle_step--; // Decrement the duty cycle value.
1674  040e 1e01          	ldw	x,(OFST+1,sp)
1675  0410 5a            	decw	x
1676                     ; 652 	return duty_cycle_step; // Return the updated duty cycle.
1680  0411 5b02          	addw	sp,#2
1681  0413 81            	ret	
1716                     ; 664 uint16_t set_pump_speed(uint16_t duty_cycle_step)
1716                     ; 665 {	
1717                     	switch	.text
1718  0414               _set_pump_speed:
1720  0414 89            	pushw	x
1721       00000000      OFST:	set	0
1724                     ; 666 	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
1726  0415 cd0000        	call	_TIM1_SetCompare3
1728                     ; 667 	return duty_cycle_step; // Return the specified duty cycle.
1730  0418 1e01          	ldw	x,(OFST+1,sp)
1733  041a 5b02          	addw	sp,#2
1734  041c 81            	ret	
1770                     ; 682 uint16_t pump_off(uint16_t duty_cycle_step)
1770                     ; 683 {
1771                     	switch	.text
1772  041d               _pump_off:
1774  041d 89            	pushw	x
1775       00000000      OFST:	set	0
1778                     ; 684 	if (duty_cycle_step > 0)
1780  041e 5d            	tnzw	x
1781  041f 2704          	jreq	L515
1782                     ; 687 		duty_cycle_step = decelerate_pump(duty_cycle_step);
1784  0421 addf          	call	_decelerate_pump
1787  0423 2006          	jra	L715
1788  0425               L515:
1789                     ; 692 		TIM1_SetCompare3(0);
1791  0425 5f            	clrw	x
1792  0426 cd0000        	call	_TIM1_SetCompare3
1794  0429 1e01          	ldw	x,(OFST+1,sp)
1795  042b               L715:
1796                     ; 695 	return duty_cycle_step;
1800  042b 5b02          	addw	sp,#2
1801  042d 81            	ret	
1839                     ; 711 uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
1839                     ; 712 {
1840                     	switch	.text
1841  042e               _pump_smooth_on_off:
1843  042e 89            	pushw	x
1844       00000000      OFST:	set	0
1847                     ; 714 	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
1849  042f b308          	cpw	x,_max_pwm_speed_pump
1850  0431 240a          	jruge	L735
1852  0433 3d15          	tnz	_pulse_flag
1853  0435 2606          	jrne	L735
1854                     ; 716 		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
1856  0437 adb7          	call	_accelerate_pump
1858  0439 1f01          	ldw	(OFST+1,sp),x
1860  043b 2004          	jra	L145
1861  043d               L735:
1862                     ; 720 		pulse_flag = 1;	// Switch to deceleration mode
1864  043d 35010015      	mov	_pulse_flag,#1
1865  0441               L145:
1866                     ; 724 	if ((duty_cycle_step > 0) && (pulse_flag == 1))
1868  0441 1e01          	ldw	x,(OFST+1,sp)
1869  0443 2709          	jreq	L345
1871  0445 b615          	ld	a,_pulse_flag
1872  0447 4a            	dec	a
1873  0448 2604          	jrne	L345
1874                     ; 726 		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
1876  044a adb6          	call	_decelerate_pump
1879  044c 2002          	jra	L545
1880  044e               L345:
1881                     ; 730 		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
1883  044e 3f15          	clr	_pulse_flag
1884  0450               L545:
1885                     ; 732 	return duty_cycle_step;	// Return the updated duty cycle value
1889  0450 5b02          	addw	sp,#2
1890  0452 81            	ret	
2107                     	xdef	_main
2108                     	xdef	_current_state
2109                     	xdef	_pump_off
2110                     	xdef	_decelerate_pump
2111                     	xdef	_accelerate_pump
2112                     	xdef	_set_pump_speed
2113                     	xdef	_pump_smooth_on_off
2114                     	xdef	_tim1_init
2115                     	xdef	_tim2_init
2116                     	xdef	_set_pwm_frequency
2117                     	xdef	_delay_ms
2118                     	xdef	_tim4_init
2119                     	xdef	_EXTI_setup
2120                     	xdef	_gpio_setup
2121                     	xdef	_clock_setup
2122                     	xdef	_last_interrupt_time
2123                     	xdef	_pulse_flag
2124                     	xdef	_duty_cycle_step
2125                     	xdef	_button_press_duration
2126                     	xdef	_button_press_start
2127                     	xdef	_button_pressed
2128                     	xdef	_long_press
2129                     	xdef	_press_count
2130                     	xdef	_max_pwm_speed_LED
2131                     	xdef	_max_pwm_speed_pump
2132                     	xdef	_arr_tim2
2133                     	xdef	_arr_tim1
2134                     	xdef	_OCR
2135                     	xref	_pow
2136                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2137                     	xdef	f_EXTI_PORTD_IRQHandler
2138                     	xdef	_ms_count
2139                     	xref	_TIM4_ClearITPendingBit
2140                     	xref	_TIM4_ITConfig
2141                     	xref	_TIM4_Cmd
2142                     	xref	_TIM4_TimeBaseInit
2143                     	xref	_TIM4_DeInit
2144                     	xref	_TIM2_SetCompare3
2145                     	xref	_TIM2_SetCompare2
2146                     	xref	_TIM2_Cmd
2147                     	xref	_TIM2_OC3Init
2148                     	xref	_TIM2_OC2Init
2149                     	xref	_TIM2_TimeBaseInit
2150                     	xref	_TIM2_DeInit
2151                     	xref	_TIM1_SetCompare3
2152                     	xref	_TIM1_CtrlPWMOutputs
2153                     	xref	_TIM1_Cmd
2154                     	xref	_TIM1_OC3Init
2155                     	xref	_TIM1_TimeBaseInit
2156                     	xref	_TIM1_DeInit
2157                     	xref	_ITC_SetSoftwarePriority
2158                     	xref	_ITC_DeInit
2159                     	xref	_GPIO_ReadInputPin
2160                     	xref	_GPIO_Init
2161                     	xref	_GPIO_DeInit
2162                     	xref	_EXTI_SetTLISensitivity
2163                     	xref	_EXTI_SetExtIntSensitivity
2164                     	xref	_EXTI_DeInit
2165                     	xref	_CLK_GetFlagStatus
2166                     	xref	_CLK_SYSCLKConfig
2167                     	xref	_CLK_HSIPrescalerConfig
2168                     	xref	_CLK_ClockSwitchConfig
2169                     	xref	_CLK_PeripheralClockConfig
2170                     	xref	_CLK_ClockSwitchCmd
2171                     	xref	_CLK_LSICmd
2172                     	xref	_CLK_HSICmd
2173                     	xref	_CLK_HSECmd
2174                     	xref	_CLK_DeInit
2175                     	switch	.const
2176  0004               L343:
2177  0004 3f800000      	dc.w	16256,0
2178  0008               L333:
2179  0008 40000000      	dc.w	16384,0
2180                     	xref.b	c_lreg
2181                     	xref.b	c_x
2182                     	xref.b	c_y
2202                     	xref	c_lsbc
2203                     	xref	c_ldiv
2204                     	xref	c_uitolx
2205                     	xref	c_imul
2206                     	xref	c_lcmp
2207                     	xref	c_ltor
2208                     	xref	c_ftol
2209                     	xref	c_fsub
2210                     	xref	c_fdiv
2211                     	xref	c_fmul
2212                     	xref	c_rtol
2213                     	xref	c_itof
2214                     	xref	c_uitof
2215                     	xref	c_bmulx
2216                     	xref	c_ltof
2217                     	end
