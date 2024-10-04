   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  47                     ; 49 void TIM1_DeInit(void)
  47                     ; 50 {
  49                     	switch	.text
  50  0000               _TIM1_DeInit:
  54                     ; 51   TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  56  0000 725f5250      	clr	21072
  57                     ; 52   TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  59  0004 725f5251      	clr	21073
  60                     ; 53   TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  62  0008 725f5252      	clr	21074
  63                     ; 54   TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  65  000c 725f5253      	clr	21075
  66                     ; 55   TIM1->IER  = TIM1_IER_RESET_VALUE;
  68  0010 725f5254      	clr	21076
  69                     ; 56   TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  71  0014 725f5256      	clr	21078
  72                     ; 58   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  74  0018 725f525c      	clr	21084
  75                     ; 59   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  77  001c 725f525d      	clr	21085
  78                     ; 61   TIM1->CCMR1 = 0x01;
  80  0020 35015258      	mov	21080,#1
  81                     ; 62   TIM1->CCMR2 = 0x01;
  83  0024 35015259      	mov	21081,#1
  84                     ; 63   TIM1->CCMR3 = 0x01;
  86  0028 3501525a      	mov	21082,#1
  87                     ; 64   TIM1->CCMR4 = 0x01;
  89  002c 3501525b      	mov	21083,#1
  90                     ; 66   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  92  0030 725f525c      	clr	21084
  93                     ; 67   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  95  0034 725f525d      	clr	21085
  96                     ; 68   TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  98  0038 725f5258      	clr	21080
  99                     ; 69   TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
 101  003c 725f5259      	clr	21081
 102                     ; 70   TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
 104  0040 725f525a      	clr	21082
 105                     ; 71   TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
 107  0044 725f525b      	clr	21083
 108                     ; 72   TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
 110  0048 725f525e      	clr	21086
 111                     ; 73   TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
 113  004c 725f525f      	clr	21087
 114                     ; 74   TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 116  0050 725f5260      	clr	21088
 117                     ; 75   TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 119  0054 725f5261      	clr	21089
 120                     ; 76   TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 122  0058 35ff5262      	mov	21090,#255
 123                     ; 77   TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 125  005c 35ff5263      	mov	21091,#255
 126                     ; 78   TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 128  0060 725f5265      	clr	21093
 129                     ; 79   TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 131  0064 725f5266      	clr	21094
 132                     ; 80   TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 134  0068 725f5267      	clr	21095
 135                     ; 81   TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 137  006c 725f5268      	clr	21096
 138                     ; 82   TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 140  0070 725f5269      	clr	21097
 141                     ; 83   TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 143  0074 725f526a      	clr	21098
 144                     ; 84   TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 146  0078 725f526b      	clr	21099
 147                     ; 85   TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 149  007c 725f526c      	clr	21100
 150                     ; 86   TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 152  0080 725f526f      	clr	21103
 153                     ; 87   TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 155  0084 35015257      	mov	21079,#1
 156                     ; 88   TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 158  0088 725f526e      	clr	21102
 159                     ; 89   TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 161  008c 725f526d      	clr	21101
 162                     ; 90   TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 164  0090 725f5264      	clr	21092
 165                     ; 91   TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 167  0094 725f5255      	clr	21077
 168                     ; 92 }
 171  0098 81            	ret	
 280                     ; 102 void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
 280                     ; 103                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 280                     ; 104                        uint16_t TIM1_Period,
 280                     ; 105                        uint8_t TIM1_RepetitionCounter)
 280                     ; 106 {
 281                     	switch	.text
 282  0099               _TIM1_TimeBaseInit:
 284       fffffffe      OFST: set -2
 287                     ; 108   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 289                     ; 111   TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
 291  0099 7b04          	ld	a,(OFST+6,sp)
 292  009b c75262        	ld	21090,a
 293                     ; 112   TIM1->ARRL = (uint8_t)(TIM1_Period);
 295  009e 7b05          	ld	a,(OFST+7,sp)
 296  00a0 c75263        	ld	21091,a
 297                     ; 115   TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
 299  00a3 9e            	ld	a,xh
 300  00a4 c75260        	ld	21088,a
 301                     ; 116   TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
 303  00a7 9f            	ld	a,xl
 304  00a8 c75261        	ld	21089,a
 305                     ; 119   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
 305                     ; 120                         | (uint8_t)(TIM1_CounterMode));
 307  00ab c65250        	ld	a,21072
 308  00ae a48f          	and	a,#143
 309  00b0 1a03          	or	a,(OFST+5,sp)
 310  00b2 c75250        	ld	21072,a
 311                     ; 123   TIM1->RCR = TIM1_RepetitionCounter;
 313  00b5 7b06          	ld	a,(OFST+8,sp)
 314  00b7 c75264        	ld	21092,a
 315                     ; 124 }
 318  00ba 81            	ret	
 603                     ; 184 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 603                     ; 185                   TIM1_OutputState_TypeDef TIM1_OutputState,
 603                     ; 186                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 603                     ; 187                   uint16_t TIM1_Pulse,
 603                     ; 188                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 603                     ; 189                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 603                     ; 190                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 603                     ; 191                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 603                     ; 192 {
 604                     	switch	.text
 605  00bb               _TIM1_OC3Init:
 607  00bb 89            	pushw	x
 608  00bc 5203          	subw	sp,#3
 609       00000003      OFST:	set	3
 612                     ; 194   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 614                     ; 195   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 616                     ; 196   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 618                     ; 197   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 620                     ; 198   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 622                     ; 199   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 624                     ; 200   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 626                     ; 204   TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
 626                     ; 205                              TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
 628  00be c6525d        	ld	a,21085
 629  00c1 a4f0          	and	a,#240
 630  00c3 c7525d        	ld	21085,a
 631                     ; 208   TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
 631                     ; 209                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
 631                     ; 210                            (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
 631                     ; 211                                      (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
 633  00c6 7b0c          	ld	a,(OFST+9,sp)
 634  00c8 a408          	and	a,#8
 635  00ca 6b03          	ld	(OFST+0,sp),a
 637  00cc 7b0b          	ld	a,(OFST+8,sp)
 638  00ce a402          	and	a,#2
 639  00d0 1a03          	or	a,(OFST+0,sp)
 640  00d2 6b02          	ld	(OFST-1,sp),a
 642  00d4 7b08          	ld	a,(OFST+5,sp)
 643  00d6 a404          	and	a,#4
 644  00d8 6b01          	ld	(OFST-2,sp),a
 646  00da 9f            	ld	a,xl
 647  00db a401          	and	a,#1
 648  00dd 1a01          	or	a,(OFST-2,sp)
 649  00df 1a02          	or	a,(OFST-1,sp)
 650  00e1 ca525d        	or	a,21085
 651  00e4 c7525d        	ld	21085,a
 652                     ; 214   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 652                     ; 215                           (uint8_t)TIM1_OCMode);
 654  00e7 c6525a        	ld	a,21082
 655  00ea a48f          	and	a,#143
 656  00ec 1a04          	or	a,(OFST+1,sp)
 657  00ee c7525a        	ld	21082,a
 658                     ; 218   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
 660  00f1 c6526f        	ld	a,21103
 661  00f4 a4cf          	and	a,#207
 662  00f6 c7526f        	ld	21103,a
 663                     ; 220   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
 663                     ; 221                           (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
 665  00f9 7b0e          	ld	a,(OFST+11,sp)
 666  00fb a420          	and	a,#32
 667  00fd 6b03          	ld	(OFST+0,sp),a
 669  00ff 7b0d          	ld	a,(OFST+10,sp)
 670  0101 a410          	and	a,#16
 671  0103 1a03          	or	a,(OFST+0,sp)
 672  0105 ca526f        	or	a,21103
 673  0108 c7526f        	ld	21103,a
 674                     ; 224   TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
 676  010b 7b09          	ld	a,(OFST+6,sp)
 677  010d c75269        	ld	21097,a
 678                     ; 225   TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
 680  0110 7b0a          	ld	a,(OFST+7,sp)
 681  0112 c7526a        	ld	21098,a
 682                     ; 226 }
 685  0115 5b05          	addw	sp,#5
 686  0117 81            	ret	
 891                     ; 255 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
 891                     ; 256                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
 891                     ; 257                      uint8_t TIM1_DeadTime,
 891                     ; 258                      TIM1_BreakState_TypeDef TIM1_Break,
 891                     ; 259                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
 891                     ; 260                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
 891                     ; 261 {
 892                     	switch	.text
 893  0118               _TIM1_BDTRConfig:
 895  0118 89            	pushw	x
 896  0119 88            	push	a
 897       00000001      OFST:	set	1
 900                     ; 263   assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
 902                     ; 264   assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
 904                     ; 265   assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
 906                     ; 266   assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
 908                     ; 267   assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
 910                     ; 269   TIM1->DTR = (uint8_t)(TIM1_DeadTime);
 912  011a 7b06          	ld	a,(OFST+5,sp)
 913  011c c7526e        	ld	21102,a
 914                     ; 273   TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
 914                     ; 274                           (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
 914                     ; 275                           (uint8_t)TIM1_AutomaticOutput));
 916  011f 7b07          	ld	a,(OFST+6,sp)
 917  0121 1a08          	or	a,(OFST+7,sp)
 918  0123 1a09          	or	a,(OFST+8,sp)
 919  0125 6b01          	ld	(OFST+0,sp),a
 921  0127 9f            	ld	a,xl
 922  0128 1a02          	or	a,(OFST+1,sp)
 923  012a 1a01          	or	a,(OFST+0,sp)
 924  012c c7526d        	ld	21101,a
 925                     ; 276 }
 928  012f 5b03          	addw	sp,#3
 929  0131 81            	ret	
 984                     ; 297 void TIM1_Cmd(FunctionalState NewState)
 984                     ; 298 {
 985                     	switch	.text
 986  0132               _TIM1_Cmd:
 990                     ; 300   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 992                     ; 303   if (NewState != DISABLE)
 994  0132 4d            	tnz	a
 995  0133 2705          	jreq	L704
 996                     ; 305     TIM1->CR1 |= TIM1_CR1_CEN;
 998  0135 72105250      	bset	21072,#0
1001  0139 81            	ret	
1002  013a               L704:
1003                     ; 309     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
1005  013a 72115250      	bres	21072,#0
1006                     ; 311 }
1009  013e 81            	ret	
1045                     ; 319 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
1045                     ; 320 {
1046                     	switch	.text
1047  013f               _TIM1_CtrlPWMOutputs:
1051                     ; 322   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1053                     ; 326   if (NewState != DISABLE)
1055  013f 4d            	tnz	a
1056  0140 2705          	jreq	L134
1057                     ; 328     TIM1->BKR |= TIM1_BKR_MOE;
1059  0142 721e526d      	bset	21101,#7
1062  0146 81            	ret	
1063  0147               L134:
1064                     ; 332     TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
1066  0147 721f526d      	bres	21101,#7
1067                     ; 334 }
1070  014b 81            	ret	
1177                     ; 353 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
1177                     ; 354 {
1178                     	switch	.text
1179  014c               _TIM1_ITConfig:
1181  014c 89            	pushw	x
1182       00000000      OFST:	set	0
1185                     ; 356   assert_param(IS_TIM1_IT_OK(TIM1_IT));
1187                     ; 357   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1189                     ; 359   if (NewState != DISABLE)
1191  014d 9f            	ld	a,xl
1192  014e 4d            	tnz	a
1193  014f 2706          	jreq	L305
1194                     ; 362     TIM1->IER |= (uint8_t)TIM1_IT;
1196  0151 9e            	ld	a,xh
1197  0152 ca5254        	or	a,21076
1199  0155 2006          	jra	L505
1200  0157               L305:
1201                     ; 367     TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
1203  0157 7b01          	ld	a,(OFST+1,sp)
1204  0159 43            	cpl	a
1205  015a c45254        	and	a,21076
1206  015d               L505:
1207  015d c75254        	ld	21076,a
1208                     ; 369 }
1211  0160 85            	popw	x
1212  0161 81            	ret	
1236                     ; 376 void TIM1_InternalClockConfig(void)
1236                     ; 377 {
1237                     	switch	.text
1238  0162               _TIM1_InternalClockConfig:
1242                     ; 379   TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
1244  0162 c65252        	ld	a,21074
1245  0165 a4f8          	and	a,#248
1246  0167 c75252        	ld	21074,a
1247                     ; 380 }
1250  016a 81            	ret	
1367                     ; 398 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
1367                     ; 399                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
1367                     ; 400                               uint8_t ExtTRGFilter)
1367                     ; 401 {
1368                     	switch	.text
1369  016b               _TIM1_ETRClockMode1Config:
1371  016b 89            	pushw	x
1372       00000000      OFST:	set	0
1375                     ; 403   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
1377                     ; 404   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
1379                     ; 407   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
1381  016c 7b05          	ld	a,(OFST+5,sp)
1382  016e 88            	push	a
1383  016f 7b02          	ld	a,(OFST+2,sp)
1384  0171 95            	ld	xh,a
1385  0172 ad1b          	call	_TIM1_ETRConfig
1387  0174 84            	pop	a
1388                     ; 410   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
1388                     ; 411                          | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
1390  0175 c65252        	ld	a,21074
1391  0178 aa77          	or	a,#119
1392  017a c75252        	ld	21074,a
1393                     ; 412 }
1396  017d 85            	popw	x
1397  017e 81            	ret	
1455                     ; 430 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
1455                     ; 431                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
1455                     ; 432                               uint8_t ExtTRGFilter)
1455                     ; 433 {
1456                     	switch	.text
1457  017f               _TIM1_ETRClockMode2Config:
1459  017f 89            	pushw	x
1460       00000000      OFST:	set	0
1463                     ; 435   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
1465                     ; 436   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
1467                     ; 439   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
1469  0180 7b05          	ld	a,(OFST+5,sp)
1470  0182 88            	push	a
1471  0183 7b02          	ld	a,(OFST+2,sp)
1472  0185 95            	ld	xh,a
1473  0186 ad07          	call	_TIM1_ETRConfig
1475  0188 721c5253      	bset	21075,#6
1476                     ; 442   TIM1->ETR |= TIM1_ETR_ECE;
1478                     ; 443 }
1481  018c 5b03          	addw	sp,#3
1482  018e 81            	ret	
1538                     ; 461 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
1538                     ; 462                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
1538                     ; 463                     uint8_t ExtTRGFilter)
1538                     ; 464 {
1539                     	switch	.text
1540  018f               _TIM1_ETRConfig:
1542  018f 89            	pushw	x
1543       00000000      OFST:	set	0
1546                     ; 466   assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
1548                     ; 468   TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
1548                     ; 469                          (uint8_t)ExtTRGFilter );
1550  0190 9f            	ld	a,xl
1551  0191 1a01          	or	a,(OFST+1,sp)
1552  0193 1a05          	or	a,(OFST+5,sp)
1553  0195 ca5253        	or	a,21075
1554  0198 c75253        	ld	21075,a
1555                     ; 470 }
1558  019b 85            	popw	x
1559  019c 81            	ret	
1644                     ; 498 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
1644                     ; 499 {
1645                     	switch	.text
1646  019d               _TIM1_SelectInputTrigger:
1648  019d 88            	push	a
1649       00000000      OFST:	set	0
1652                     ; 501   assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
1654                     ; 504   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
1656  019e c65252        	ld	a,21074
1657  01a1 a48f          	and	a,#143
1658  01a3 1a01          	or	a,(OFST+1,sp)
1659  01a5 c75252        	ld	21074,a
1660                     ; 505 }
1663  01a8 84            	pop	a
1664  01a9 81            	ret	
1700                     ; 514 void TIM1_UpdateDisableConfig(FunctionalState NewState)
1700                     ; 515 {
1701                     	switch	.text
1702  01aa               _TIM1_UpdateDisableConfig:
1706                     ; 517   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1708                     ; 520   if (NewState != DISABLE)
1710  01aa 4d            	tnz	a
1711  01ab 2705          	jreq	L127
1712                     ; 522     TIM1->CR1 |= TIM1_CR1_UDIS;
1714  01ad 72125250      	bset	21072,#1
1717  01b1 81            	ret	
1718  01b2               L127:
1719                     ; 526     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
1721  01b2 72135250      	bres	21072,#1
1722                     ; 528 }
1725  01b6 81            	ret	
1783                     ; 538 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
1783                     ; 539 {
1784                     	switch	.text
1785  01b7               _TIM1_UpdateRequestConfig:
1789                     ; 541   assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
1791                     ; 544   if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
1793  01b7 4d            	tnz	a
1794  01b8 2705          	jreq	L357
1795                     ; 546     TIM1->CR1 |= TIM1_CR1_URS;
1797  01ba 72145250      	bset	21072,#2
1800  01be 81            	ret	
1801  01bf               L357:
1802                     ; 550     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
1804  01bf 72155250      	bres	21072,#2
1805                     ; 552 }
1808  01c3 81            	ret	
1906                     ; 567 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
1906                     ; 568 {
1907                     	switch	.text
1908  01c4               _TIM1_SelectOutputTrigger:
1910  01c4 88            	push	a
1911       00000000      OFST:	set	0
1914                     ; 570   assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
1916                     ; 573   TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
1916                     ; 574                         (uint8_t) TIM1_TRGOSource);
1918  01c5 c65251        	ld	a,21073
1919  01c8 a48f          	and	a,#143
1920  01ca 1a01          	or	a,(OFST+1,sp)
1921  01cc c75251        	ld	21073,a
1922                     ; 575 }
1925  01cf 84            	pop	a
1926  01d0 81            	ret	
2000                     ; 587 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
2000                     ; 588 {
2001                     	switch	.text
2002  01d1               _TIM1_SelectSlaveMode:
2004  01d1 88            	push	a
2005       00000000      OFST:	set	0
2008                     ; 590   assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
2010                     ; 593   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
2010                     ; 594                          (uint8_t)TIM1_SlaveMode);
2012  01d2 c65252        	ld	a,21074
2013  01d5 a4f8          	and	a,#248
2014  01d7 1a01          	or	a,(OFST+1,sp)
2015  01d9 c75252        	ld	21074,a
2016                     ; 595 }
2019  01dc 84            	pop	a
2020  01dd 81            	ret	
2056                     ; 603 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
2056                     ; 604 {
2057                     	switch	.text
2058  01de               _TIM1_SelectMasterSlaveMode:
2062                     ; 606   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2064                     ; 609   if (NewState != DISABLE)
2066  01de 4d            	tnz	a
2067  01df 2705          	jreq	L7601
2068                     ; 611     TIM1->SMCR |= TIM1_SMCR_MSM;
2070  01e1 721e5252      	bset	21074,#7
2073  01e5 81            	ret	
2074  01e6               L7601:
2075                     ; 615     TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
2077  01e6 721f5252      	bres	21074,#7
2078                     ; 617 }
2081  01ea 81            	ret	
2148                     ; 629 void TIM1_PrescalerConfig(uint16_t Prescaler,
2148                     ; 630                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
2148                     ; 631 {
2149                     	switch	.text
2150  01eb               _TIM1_PrescalerConfig:
2152       fffffffe      OFST: set -2
2155                     ; 633   assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
2157                     ; 636   TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
2159  01eb 9e            	ld	a,xh
2160  01ec c75260        	ld	21088,a
2161                     ; 637   TIM1->PSCRL = (uint8_t)(Prescaler);
2163  01ef 9f            	ld	a,xl
2164  01f0 c75261        	ld	21089,a
2165                     ; 640   TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
2167  01f3 7b03          	ld	a,(OFST+5,sp)
2168  01f5 c75257        	ld	21079,a
2169                     ; 641 }
2172  01f8 81            	ret	
2208                     ; 654 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
2208                     ; 655 {
2209                     	switch	.text
2210  01f9               _TIM1_CounterModeConfig:
2212  01f9 88            	push	a
2213       00000000      OFST:	set	0
2216                     ; 657   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
2218                     ; 661   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
2218                     ; 662                         | (uint8_t)TIM1_CounterMode);
2220  01fa c65250        	ld	a,21072
2221  01fd a48f          	and	a,#143
2222  01ff 1a01          	or	a,(OFST+1,sp)
2223  0201 c75250        	ld	21072,a
2224                     ; 663 }
2227  0204 84            	pop	a
2228  0205 81            	ret	
2286                     ; 674 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
2286                     ; 675 {
2287                     	switch	.text
2288  0206               _TIM1_ForcedOC3Config:
2290  0206 88            	push	a
2291       00000000      OFST:	set	0
2294                     ; 677   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
2296                     ; 680   TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
2296                     ; 681                             | (uint8_t)TIM1_ForcedAction);
2298  0207 c6525a        	ld	a,21082
2299  020a a48f          	and	a,#143
2300  020c 1a01          	or	a,(OFST+1,sp)
2301  020e c7525a        	ld	21082,a
2302                     ; 682 }
2305  0211 84            	pop	a
2306  0212 81            	ret	
2342                     ; 690 void TIM1_ARRPreloadConfig(FunctionalState NewState)
2342                     ; 691 {
2343                     	switch	.text
2344  0213               _TIM1_ARRPreloadConfig:
2348                     ; 693   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2350                     ; 696   if (NewState != DISABLE)
2352  0213 4d            	tnz	a
2353  0214 2705          	jreq	L7021
2354                     ; 698     TIM1->CR1 |= TIM1_CR1_ARPE;
2356  0216 721e5250      	bset	21072,#7
2359  021a 81            	ret	
2360  021b               L7021:
2361                     ; 702     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
2363  021b 721f5250      	bres	21072,#7
2364                     ; 704 }
2367  021f 81            	ret	
2403                     ; 712 void TIM1_OC3PreloadConfig(FunctionalState NewState)
2403                     ; 713 {
2404                     	switch	.text
2405  0220               _TIM1_OC3PreloadConfig:
2409                     ; 715   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2411                     ; 718   if (NewState != DISABLE)
2413  0220 4d            	tnz	a
2414  0221 2705          	jreq	L1321
2415                     ; 720     TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
2417  0223 7216525a      	bset	21082,#3
2420  0227 81            	ret	
2421  0228               L1321:
2422                     ; 724     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
2424  0228 7217525a      	bres	21082,#3
2425                     ; 726 }
2428  022c 81            	ret	
2463                     ; 735 void TIM1_OC1FastConfig(FunctionalState NewState)
2463                     ; 736 {
2464                     	switch	.text
2465  022d               _TIM1_OC1FastConfig:
2469                     ; 738   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2471                     ; 741   if (NewState != DISABLE)
2473  022d 4d            	tnz	a
2474  022e 2705          	jreq	L3521
2475                     ; 743     TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
2477  0230 72145258      	bset	21080,#2
2480  0234 81            	ret	
2481  0235               L3521:
2482                     ; 747     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
2484  0235 72155258      	bres	21080,#2
2485                     ; 749 }
2488  0239 81            	ret	
2523                     ; 757 void TIM1_OC2FastConfig(FunctionalState NewState)
2523                     ; 758 {
2524                     	switch	.text
2525  023a               _TIM1_OC2FastConfig:
2529                     ; 760   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2531                     ; 763   if (NewState != DISABLE)
2533  023a 4d            	tnz	a
2534  023b 2705          	jreq	L5721
2535                     ; 765     TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
2537  023d 72145259      	bset	21081,#2
2540  0241 81            	ret	
2541  0242               L5721:
2542                     ; 769     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
2544  0242 72155259      	bres	21081,#2
2545                     ; 771 }
2548  0246 81            	ret	
2583                     ; 779 void TIM1_OC3FastConfig(FunctionalState NewState)
2583                     ; 780 {
2584                     	switch	.text
2585  0247               _TIM1_OC3FastConfig:
2589                     ; 782   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2591                     ; 785   if (NewState != DISABLE)
2593  0247 4d            	tnz	a
2594  0248 2705          	jreq	L7131
2595                     ; 787     TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
2597  024a 7214525a      	bset	21082,#2
2600  024e 81            	ret	
2601  024f               L7131:
2602                     ; 791     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
2604  024f 7215525a      	bres	21082,#2
2605                     ; 793 }
2608  0253 81            	ret	
2713                     ; 809 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
2713                     ; 810 {
2714                     	switch	.text
2715  0254               _TIM1_GenerateEvent:
2719                     ; 812   assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
2721                     ; 815   TIM1->EGR = (uint8_t)TIM1_EventSource;
2723  0254 c75257        	ld	21079,a
2724                     ; 816 }
2727  0257 81            	ret	
2763                     ; 826 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
2763                     ; 827 {
2764                     	switch	.text
2765  0258               _TIM1_OC1PolarityConfig:
2769                     ; 829   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
2771                     ; 832   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
2773  0258 4d            	tnz	a
2774  0259 2705          	jreq	L3041
2775                     ; 834     TIM1->CCER1 |= TIM1_CCER1_CC1P;
2777  025b 7212525c      	bset	21084,#1
2780  025f 81            	ret	
2781  0260               L3041:
2782                     ; 838     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
2784  0260 7213525c      	bres	21084,#1
2785                     ; 840 }
2788  0264 81            	ret	
2824                     ; 852 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
2824                     ; 853 {
2825                     	switch	.text
2826  0265               _TIM1_OC3PolarityConfig:
2830                     ; 855   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
2832                     ; 858   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
2834  0265 4d            	tnz	a
2835  0266 2705          	jreq	L5241
2836                     ; 860     TIM1->CCER2 |= TIM1_CCER2_CC3P;
2838  0268 7212525d      	bset	21085,#1
2841  026c 81            	ret	
2842  026d               L5241:
2843                     ; 864     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
2845  026d 7213525d      	bres	21085,#1
2846                     ; 866 }
2849  0271 81            	ret	
2885                     ; 877 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
2885                     ; 878 {
2886                     	switch	.text
2887  0272               _TIM1_OC3NPolarityConfig:
2891                     ; 880   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
2893                     ; 883   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
2895  0272 4d            	tnz	a
2896  0273 2705          	jreq	L7441
2897                     ; 885     TIM1->CCER2 |= TIM1_CCER2_CC3NP;
2899  0275 7216525d      	bset	21085,#3
2902  0279 81            	ret	
2903  027a               L7441:
2904                     ; 889     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
2906  027a 7217525d      	bres	21085,#3
2907                     ; 891 }
2910  027e 81            	ret	
2944                     ; 899 void TIM1_SetCounter(uint16_t Counter)
2944                     ; 900 {
2945                     	switch	.text
2946  027f               _TIM1_SetCounter:
2950                     ; 902   TIM1->CNTRH = (uint8_t)(Counter >> 8);
2952  027f 9e            	ld	a,xh
2953  0280 c7525e        	ld	21086,a
2954                     ; 903   TIM1->CNTRL = (uint8_t)(Counter);
2956  0283 9f            	ld	a,xl
2957  0284 c7525f        	ld	21087,a
2958                     ; 904 }
2961  0287 81            	ret	
2995                     ; 912 void TIM1_SetAutoreload(uint16_t Autoreload)
2995                     ; 913 {
2996                     	switch	.text
2997  0288               _TIM1_SetAutoreload:
3001                     ; 915   TIM1->ARRH = (uint8_t)(Autoreload >> 8);
3003  0288 9e            	ld	a,xh
3004  0289 c75262        	ld	21090,a
3005                     ; 916   TIM1->ARRL = (uint8_t)(Autoreload);
3007  028c 9f            	ld	a,xl
3008  028d c75263        	ld	21091,a
3009                     ; 917  }
3012  0290 81            	ret	
3046                     ; 926 void TIM1_SetCompare3(uint16_t Compare3)
3046                     ; 927 {
3047                     	switch	.text
3048  0291               _TIM1_SetCompare3:
3052                     ; 929   TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
3054  0291 9e            	ld	a,xh
3055  0292 c75269        	ld	21097,a
3056                     ; 930   TIM1->CCR3L = (uint8_t)(Compare3);
3058  0295 9f            	ld	a,xl
3059  0296 c7526a        	ld	21098,a
3060                     ; 931 }
3063  0299 81            	ret	
3133                     ; 943 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
3133                     ; 944 {
3134                     	switch	.text
3135  029a               _TIM1_SetIC3Prescaler:
3137  029a 88            	push	a
3138       00000000      OFST:	set	0
3141                     ; 947   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
3143                     ; 950   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
3143                     ; 951                           (uint8_t)TIM1_IC3Prescaler);
3145  029b c6525a        	ld	a,21082
3146  029e a4f3          	and	a,#243
3147  02a0 1a01          	or	a,(OFST+1,sp)
3148  02a2 c7525a        	ld	21082,a
3149                     ; 952 }
3152  02a5 84            	pop	a
3153  02a6 81            	ret	
3205                     ; 959 uint16_t TIM1_GetCapture3(void)
3205                     ; 960 {
3206                     	switch	.text
3207  02a7               _TIM1_GetCapture3:
3209  02a7 5204          	subw	sp,#4
3210       00000004      OFST:	set	4
3213                     ; 962   uint16_t tmpccr3 = 0;
3215                     ; 963   uint8_t tmpccr3l=0, tmpccr3h=0;
3219                     ; 965   tmpccr3h = TIM1->CCR3H;
3221  02a9 c65269        	ld	a,21097
3222  02ac 6b02          	ld	(OFST-2,sp),a
3224                     ; 966   tmpccr3l = TIM1->CCR3L;
3226  02ae c6526a        	ld	a,21098
3227  02b1 6b01          	ld	(OFST-3,sp),a
3229                     ; 968   tmpccr3 = (uint16_t)(tmpccr3l);
3231  02b3 5f            	clrw	x
3232  02b4 97            	ld	xl,a
3233  02b5 1f03          	ldw	(OFST-1,sp),x
3235                     ; 969   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3237  02b7 5f            	clrw	x
3238  02b8 7b02          	ld	a,(OFST-2,sp)
3239  02ba 97            	ld	xl,a
3240  02bb 7b04          	ld	a,(OFST+0,sp)
3241  02bd 01            	rrwa	x,a
3242  02be 1a03          	or	a,(OFST-1,sp)
3243  02c0 01            	rrwa	x,a
3245                     ; 971   return (uint16_t)tmpccr3;
3249  02c1 5b04          	addw	sp,#4
3250  02c3 81            	ret	
3263                     	xdef	_TIM1_GetCapture3
3264                     	xdef	_TIM1_SetIC3Prescaler
3265                     	xdef	_TIM1_SetCompare3
3266                     	xdef	_TIM1_SetAutoreload
3267                     	xdef	_TIM1_SetCounter
3268                     	xdef	_TIM1_OC3NPolarityConfig
3269                     	xdef	_TIM1_OC3PolarityConfig
3270                     	xdef	_TIM1_OC1PolarityConfig
3271                     	xdef	_TIM1_GenerateEvent
3272                     	xdef	_TIM1_OC3FastConfig
3273                     	xdef	_TIM1_OC2FastConfig
3274                     	xdef	_TIM1_OC1FastConfig
3275                     	xdef	_TIM1_OC3PreloadConfig
3276                     	xdef	_TIM1_ARRPreloadConfig
3277                     	xdef	_TIM1_ForcedOC3Config
3278                     	xdef	_TIM1_CounterModeConfig
3279                     	xdef	_TIM1_PrescalerConfig
3280                     	xdef	_TIM1_SelectMasterSlaveMode
3281                     	xdef	_TIM1_SelectSlaveMode
3282                     	xdef	_TIM1_SelectOutputTrigger
3283                     	xdef	_TIM1_UpdateRequestConfig
3284                     	xdef	_TIM1_UpdateDisableConfig
3285                     	xdef	_TIM1_SelectInputTrigger
3286                     	xdef	_TIM1_ETRConfig
3287                     	xdef	_TIM1_ETRClockMode2Config
3288                     	xdef	_TIM1_ETRClockMode1Config
3289                     	xdef	_TIM1_InternalClockConfig
3290                     	xdef	_TIM1_ITConfig
3291                     	xdef	_TIM1_CtrlPWMOutputs
3292                     	xdef	_TIM1_Cmd
3293                     	xdef	_TIM1_BDTRConfig
3294                     	xdef	_TIM1_OC3Init
3295                     	xdef	_TIM1_TimeBaseInit
3296                     	xdef	_TIM1_DeInit
3315                     	end
