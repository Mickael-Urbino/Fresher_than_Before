   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
  42                     ; 66 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  42                     ; 67 {
  43                     	switch	.text
  44  0000               f_TRAP_IRQHandler:
  48                     ; 71 }
  51  0000 80            	iret
  73                     ; 78 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  73                     ; 79 
  73                     ; 80 {
  74                     	switch	.text
  75  0001               f_TLI_IRQHandler:
  79                     ; 84 }
  82  0001 80            	iret
 104                     ; 91 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 104                     ; 92 {
 105                     	switch	.text
 106  0002               f_AWU_IRQHandler:
 110                     ; 96 }
 113  0002 80            	iret
 135                     ; 103 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 135                     ; 104 {
 136                     	switch	.text
 137  0003               f_CLK_IRQHandler:
 141                     ; 108 }
 144  0003 80            	iret
 167                     ; 115 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 167                     ; 116 {
 168                     	switch	.text
 169  0004               f_EXTI_PORTA_IRQHandler:
 173                     ; 120 }
 176  0004 80            	iret
 199                     ; 127 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 199                     ; 128 {
 200                     	switch	.text
 201  0005               f_EXTI_PORTB_IRQHandler:
 205                     ; 132 }
 208  0005 80            	iret
 231                     ; 139 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 231                     ; 140 {
 232                     	switch	.text
 233  0006               f_EXTI_PORTC_IRQHandler:
 237                     ; 144 }
 240  0006 80            	iret
 263                     ; 151 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 263                     ; 152 {
 264                     	switch	.text
 265  0007               f_EXTI_PORTD_IRQHandler:
 269                     ; 156 }
 272  0007 80            	iret
 295                     ; 163 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 295                     ; 164 {
 296                     	switch	.text
 297  0008               f_EXTI_PORTE_IRQHandler:
 301                     ; 168 }
 304  0008 80            	iret
 326                     ; 215 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 326                     ; 216 {
 327                     	switch	.text
 328  0009               f_SPI_IRQHandler:
 332                     ; 220 }
 335  0009 80            	iret
 358                     ; 227 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 358                     ; 228 {
 359                     	switch	.text
 360  000a               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 364                     ; 232 }
 367  000a 80            	iret
 390                     ; 239 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 390                     ; 240 {
 391                     	switch	.text
 392  000b               f_TIM1_CAP_COM_IRQHandler:
 396                     ; 244 }
 399  000b 80            	iret
 422                     ; 277  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 422                     ; 278  {
 423                     	switch	.text
 424  000c               f_TIM2_UPD_OVF_BRK_IRQHandler:
 428                     ; 282  }
 431  000c 80            	iret
 454                     ; 289  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 454                     ; 290  {
 455                     	switch	.text
 456  000d               f_TIM2_CAP_COM_IRQHandler:
 460                     ; 294  }
 463  000d 80            	iret
 486                     ; 331  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 486                     ; 332  {
 487                     	switch	.text
 488  000e               f_UART1_TX_IRQHandler:
 492                     ; 336  }
 495  000e 80            	iret
 518                     ; 343  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 518                     ; 344  {
 519                     	switch	.text
 520  000f               f_UART1_RX_IRQHandler:
 524                     ; 348  }
 527  000f 80            	iret
 549                     ; 382 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 549                     ; 383 {
 550                     	switch	.text
 551  0010               f_I2C_IRQHandler:
 555                     ; 387 }
 558  0010 80            	iret
 580                     ; 461  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 580                     ; 462  {
 581                     	switch	.text
 582  0011               f_ADC1_IRQHandler:
 586                     ; 466  }
 589  0011 80            	iret
 614                     ; 487  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 614                     ; 488  {
 615                     	switch	.text
 616  0012               f_TIM4_UPD_OVF_IRQHandler:
 618  0012 8a            	push	cc
 619  0013 84            	pop	a
 620  0014 a4bf          	and	a,#191
 621  0016 88            	push	a
 622  0017 86            	pop	cc
 623  0018 3b0002        	push	c_x+2
 624  001b be00          	ldw	x,c_x
 625  001d 89            	pushw	x
 626  001e 3b0002        	push	c_y+2
 627  0021 be00          	ldw	x,c_y
 628  0023 89            	pushw	x
 631                     ; 492 		TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 633  0024 a601          	ld	a,#1
 634  0026 cd0000        	call	_TIM4_ClearITPendingBit
 636                     ; 493     ms_count++;
 638  0029 be00          	ldw	x,_ms_count
 639  002b 1c0001        	addw	x,#1
 640  002e bf00          	ldw	_ms_count,x
 641                     ; 494  }
 644  0030 85            	popw	x
 645  0031 bf00          	ldw	c_y,x
 646  0033 320002        	pop	c_y+2
 647  0036 85            	popw	x
 648  0037 bf00          	ldw	c_x,x
 649  0039 320002        	pop	c_x+2
 650  003c 80            	iret
 673                     ; 502 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 673                     ; 503 {
 674                     	switch	.text
 675  003d               f_EEPROM_EEC_IRQHandler:
 679                     ; 507 }
 682  003d 80            	iret
 694                     	xdef	f_EEPROM_EEC_IRQHandler
 695                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 696                     	xdef	f_ADC1_IRQHandler
 697                     	xdef	f_I2C_IRQHandler
 698                     	xdef	f_UART1_RX_IRQHandler
 699                     	xdef	f_UART1_TX_IRQHandler
 700                     	xdef	f_TIM2_CAP_COM_IRQHandler
 701                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 702                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 703                     	xdef	f_TIM1_CAP_COM_IRQHandler
 704                     	xdef	f_SPI_IRQHandler
 705                     	xdef	f_EXTI_PORTE_IRQHandler
 706                     	xdef	f_EXTI_PORTD_IRQHandler
 707                     	xdef	f_EXTI_PORTC_IRQHandler
 708                     	xdef	f_EXTI_PORTB_IRQHandler
 709                     	xdef	f_EXTI_PORTA_IRQHandler
 710                     	xdef	f_CLK_IRQHandler
 711                     	xdef	f_AWU_IRQHandler
 712                     	xdef	f_TLI_IRQHandler
 713                     	xdef	f_TRAP_IRQHandler
 714                     	xref.b	_ms_count
 715                     	xref	_TIM4_ClearITPendingBit
 716                     	xref.b	c_x
 717                     	xref.b	c_y
 736                     	end
