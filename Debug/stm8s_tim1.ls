   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.3 - 22 Aug 2024
   4                     ; Optimizer V4.6.3 - 22 Aug 2024
  47                     ; 58 void TIM1_DeInit(void)
  47                     ; 59 {
  49                     	switch	.text
  50  0000               _TIM1_DeInit:
  54                     ; 60   TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  56  0000 725f5250      	clr	21072
  57                     ; 61   TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  59  0004 725f5251      	clr	21073
  60                     ; 62   TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  62  0008 725f5252      	clr	21074
  63                     ; 63   TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  65  000c 725f5253      	clr	21075
  66                     ; 64   TIM1->IER  = TIM1_IER_RESET_VALUE;
  68  0010 725f5254      	clr	21076
  69                     ; 65   TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  71  0014 725f5256      	clr	21078
  72                     ; 67   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  74  0018 725f525c      	clr	21084
  75                     ; 68   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  77  001c 725f525d      	clr	21085
  78                     ; 70   TIM1->CCMR1 = 0x01;
  80  0020 35015258      	mov	21080,#1
  81                     ; 71   TIM1->CCMR2 = 0x01;
  83  0024 35015259      	mov	21081,#1
  84                     ; 72   TIM1->CCMR3 = 0x01;
  86  0028 3501525a      	mov	21082,#1
  87                     ; 73   TIM1->CCMR4 = 0x01;
  89  002c 3501525b      	mov	21083,#1
  90                     ; 75   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  92  0030 725f525c      	clr	21084
  93                     ; 76   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  95  0034 725f525d      	clr	21085
  96                     ; 77   TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  98  0038 725f5258      	clr	21080
  99                     ; 78   TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
 101  003c 725f5259      	clr	21081
 102                     ; 79   TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
 104  0040 725f525a      	clr	21082
 105                     ; 80   TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
 107  0044 725f525b      	clr	21083
 108                     ; 81   TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
 110  0048 725f525e      	clr	21086
 111                     ; 82   TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
 113  004c 725f525f      	clr	21087
 114                     ; 83   TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 116  0050 725f5260      	clr	21088
 117                     ; 84   TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 119  0054 725f5261      	clr	21089
 120                     ; 85   TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 122  0058 35ff5262      	mov	21090,#255
 123                     ; 86   TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 125  005c 35ff5263      	mov	21091,#255
 126                     ; 87   TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 128  0060 725f5265      	clr	21093
 129                     ; 88   TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 131  0064 725f5266      	clr	21094
 132                     ; 89   TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 134  0068 725f5267      	clr	21095
 135                     ; 90   TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 137  006c 725f5268      	clr	21096
 138                     ; 91   TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 140  0070 725f5269      	clr	21097
 141                     ; 92   TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 143  0074 725f526a      	clr	21098
 144                     ; 93   TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 146  0078 725f526b      	clr	21099
 147                     ; 94   TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 149  007c 725f526c      	clr	21100
 150                     ; 95   TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 152  0080 725f526f      	clr	21103
 153                     ; 96   TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 155  0084 35015257      	mov	21079,#1
 156                     ; 97   TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 158  0088 725f526e      	clr	21102
 159                     ; 98   TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 161  008c 725f526d      	clr	21101
 162                     ; 99   TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 164  0090 725f5264      	clr	21092
 165                     ; 100   TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 167  0094 725f5255      	clr	21077
 168                     ; 101 }
 171  0098 81            	ret	
 280                     ; 111 void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
 280                     ; 112                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 280                     ; 113                        uint16_t TIM1_Period,
 280                     ; 114                        uint8_t TIM1_RepetitionCounter)
 280                     ; 115 {
 281                     	switch	.text
 282  0099               _TIM1_TimeBaseInit:
 284       fffffffe      OFST: set -2
 287                     ; 117   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 289                     ; 120   TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
 291  0099 7b04          	ld	a,(OFST+6,sp)
 292  009b c75262        	ld	21090,a
 293                     ; 121   TIM1->ARRL = (uint8_t)(TIM1_Period);
 295  009e 7b05          	ld	a,(OFST+7,sp)
 296  00a0 c75263        	ld	21091,a
 297                     ; 124   TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
 299  00a3 9e            	ld	a,xh
 300  00a4 c75260        	ld	21088,a
 301                     ; 125   TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
 303  00a7 9f            	ld	a,xl
 304  00a8 c75261        	ld	21089,a
 305                     ; 128   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
 305                     ; 129                         | (uint8_t)(TIM1_CounterMode));
 307  00ab c65250        	ld	a,21072
 308  00ae a48f          	and	a,#143
 309  00b0 1a03          	or	a,(OFST+5,sp)
 310  00b2 c75250        	ld	21072,a
 311                     ; 132   TIM1->RCR = TIM1_RepetitionCounter;
 313  00b5 7b06          	ld	a,(OFST+8,sp)
 314  00b7 c75264        	ld	21092,a
 315                     ; 133 }
 318  00ba 81            	ret	
 603                     ; 193 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 603                     ; 194                   TIM1_OutputState_TypeDef TIM1_OutputState,
 603                     ; 195                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 603                     ; 196                   uint16_t TIM1_Pulse,
 603                     ; 197                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 603                     ; 198                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 603                     ; 199                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 603                     ; 200                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 603                     ; 201 {
 604                     	switch	.text
 605  00bb               _TIM1_OC3Init:
 607  00bb 89            	pushw	x
 608  00bc 5203          	subw	sp,#3
 609       00000003      OFST:	set	3
 612                     ; 203   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 614                     ; 204   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 616                     ; 205   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 618                     ; 206   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 620                     ; 207   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 622                     ; 208   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 624                     ; 209   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 626                     ; 213   TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
 626                     ; 214                              TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
 628  00be c6525d        	ld	a,21085
 629  00c1 a4f0          	and	a,#240
 630  00c3 c7525d        	ld	21085,a
 631                     ; 217   TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
 631                     ; 218                                      (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
 631                     ; 219                            (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
 631                     ; 220                                      (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
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
 652                     ; 223   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 652                     ; 224                           (uint8_t)TIM1_OCMode);
 654  00e7 c6525a        	ld	a,21082
 655  00ea a48f          	and	a,#143
 656  00ec 1a04          	or	a,(OFST+1,sp)
 657  00ee c7525a        	ld	21082,a
 658                     ; 227   TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
 660  00f1 c6526f        	ld	a,21103
 661  00f4 a4cf          	and	a,#207
 662  00f6 c7526f        	ld	21103,a
 663                     ; 229   TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
 663                     ; 230                           (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
 665  00f9 7b0e          	ld	a,(OFST+11,sp)
 666  00fb a420          	and	a,#32
 667  00fd 6b03          	ld	(OFST+0,sp),a
 669  00ff 7b0d          	ld	a,(OFST+10,sp)
 670  0101 a410          	and	a,#16
 671  0103 1a03          	or	a,(OFST+0,sp)
 672  0105 ca526f        	or	a,21103
 673  0108 c7526f        	ld	21103,a
 674                     ; 233   TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
 676  010b 7b09          	ld	a,(OFST+6,sp)
 677  010d c75269        	ld	21097,a
 678                     ; 234   TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
 680  0110 7b0a          	ld	a,(OFST+7,sp)
 681  0112 c7526a        	ld	21098,a
 682                     ; 235 }
 685  0115 5b05          	addw	sp,#5
 686  0117 81            	ret	
 760                     ; 250 void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 760                     ; 251                   TIM1_OutputState_TypeDef TIM1_OutputState,
 760                     ; 252                   uint16_t TIM1_Pulse,
 760                     ; 253                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 760                     ; 254                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
 760                     ; 255 {
 761                     	switch	.text
 762  0118               _TIM1_OC4Init:
 764  0118 89            	pushw	x
 765  0119 88            	push	a
 766       00000001      OFST:	set	1
 769                     ; 257   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 771                     ; 258   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 773                     ; 259   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 775                     ; 260   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 777                     ; 263   TIM1->CCER2 &= (uint8_t)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
 779  011a c6525d        	ld	a,21085
 780  011d a4cf          	and	a,#207
 781  011f c7525d        	ld	21085,a
 782                     ; 265   TIM1->CCER2 |= (uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER2_CC4E ) |  
 782                     ; 266                            (uint8_t)(TIM1_OCPolarity  & TIM1_CCER2_CC4P ));
 784  0122 7b08          	ld	a,(OFST+7,sp)
 785  0124 a420          	and	a,#32
 786  0126 6b01          	ld	(OFST+0,sp),a
 788  0128 9f            	ld	a,xl
 789  0129 a410          	and	a,#16
 790  012b 1a01          	or	a,(OFST+0,sp)
 791  012d ca525d        	or	a,21085
 792  0130 c7525d        	ld	21085,a
 793                     ; 269   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 793                     ; 270                           TIM1_OCMode);
 795  0133 c6525b        	ld	a,21083
 796  0136 a48f          	and	a,#143
 797  0138 1a02          	or	a,(OFST+1,sp)
 798  013a c7525b        	ld	21083,a
 799                     ; 273   if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
 801  013d 7b09          	ld	a,(OFST+8,sp)
 802  013f 270a          	jreq	L113
 803                     ; 275     TIM1->OISR |= (uint8_t)(~TIM1_CCER2_CC4P);
 805  0141 c6526f        	ld	a,21103
 806  0144 aadf          	or	a,#223
 807  0146 c7526f        	ld	21103,a
 809  0149 2004          	jra	L313
 810  014b               L113:
 811                     ; 279     TIM1->OISR &= (uint8_t)(~TIM1_OISR_OIS4);
 813  014b 721d526f      	bres	21103,#6
 814  014f               L313:
 815                     ; 283   TIM1->CCR4H = (uint8_t)(TIM1_Pulse >> 8);
 817  014f 7b06          	ld	a,(OFST+5,sp)
 818  0151 c7526b        	ld	21099,a
 819                     ; 284   TIM1->CCR4L = (uint8_t)(TIM1_Pulse);
 821  0154 7b07          	ld	a,(OFST+6,sp)
 822  0156 c7526c        	ld	21100,a
 823                     ; 285 }
 826  0159 5b03          	addw	sp,#3
 827  015b 81            	ret	
1032                     ; 300 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
1032                     ; 301                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
1032                     ; 302                      uint8_t TIM1_DeadTime,
1032                     ; 303                      TIM1_BreakState_TypeDef TIM1_Break,
1032                     ; 304                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
1032                     ; 305                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
1032                     ; 306 {
1033                     	switch	.text
1034  015c               _TIM1_BDTRConfig:
1036  015c 89            	pushw	x
1037  015d 88            	push	a
1038       00000001      OFST:	set	1
1041                     ; 308   assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
1043                     ; 309   assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
1045                     ; 310   assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
1047                     ; 311   assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
1049                     ; 312   assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
1051                     ; 314   TIM1->DTR = (uint8_t)(TIM1_DeadTime);
1053  015e 7b06          	ld	a,(OFST+5,sp)
1054  0160 c7526e        	ld	21102,a
1055                     ; 318   TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
1055                     ; 319                           (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
1055                     ; 320                           (uint8_t)TIM1_AutomaticOutput));
1057  0163 7b07          	ld	a,(OFST+6,sp)
1058  0165 1a08          	or	a,(OFST+7,sp)
1059  0167 1a09          	or	a,(OFST+8,sp)
1060  0169 6b01          	ld	(OFST+0,sp),a
1062  016b 9f            	ld	a,xl
1063  016c 1a02          	or	a,(OFST+1,sp)
1064  016e 1a01          	or	a,(OFST+0,sp)
1065  0170 c7526d        	ld	21101,a
1066                     ; 321 }
1069  0173 5b03          	addw	sp,#3
1070  0175 81            	ret	
1272                     ; 335 void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel,
1272                     ; 336                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1272                     ; 337                  TIM1_ICSelection_TypeDef TIM1_ICSelection,
1272                     ; 338                  TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1272                     ; 339                  uint8_t TIM1_ICFilter)
1272                     ; 340 {
1273                     	switch	.text
1274  0176               _TIM1_ICInit:
1276  0176 89            	pushw	x
1277       00000000      OFST:	set	0
1280                     ; 342   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
1282                     ; 343   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1284                     ; 344   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1286                     ; 345   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1288                     ; 346   assert_param(IS_TIM1_IC_FILTER_OK(TIM1_ICFilter));
1290                     ; 348   if (TIM1_Channel == TIM1_CHANNEL_1)
1292  0177 9e            	ld	a,xh
1293  0178 4d            	tnz	a
1294  0179 2614          	jrne	L345
1295                     ; 351     TI1_Config((uint8_t)TIM1_ICPolarity,
1295                     ; 352                (uint8_t)TIM1_ICSelection,
1295                     ; 353                (uint8_t)TIM1_ICFilter);
1297  017b 7b07          	ld	a,(OFST+7,sp)
1298  017d 88            	push	a
1299  017e 7b06          	ld	a,(OFST+6,sp)
1300  0180 97            	ld	xl,a
1301  0181 7b03          	ld	a,(OFST+3,sp)
1302  0183 95            	ld	xh,a
1303  0184 cd06e9        	call	L3_TI1_Config
1305  0187 84            	pop	a
1306                     ; 355     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1308  0188 7b06          	ld	a,(OFST+6,sp)
1309  018a cd05c6        	call	_TIM1_SetIC1Prescaler
1312  018d 2044          	jra	L545
1313  018f               L345:
1314                     ; 357   else if (TIM1_Channel == TIM1_CHANNEL_2)
1316  018f 7b01          	ld	a,(OFST+1,sp)
1317  0191 a101          	cp	a,#1
1318  0193 2614          	jrne	L745
1319                     ; 360     TI2_Config((uint8_t)TIM1_ICPolarity,
1319                     ; 361                (uint8_t)TIM1_ICSelection,
1319                     ; 362                (uint8_t)TIM1_ICFilter);
1321  0195 7b07          	ld	a,(OFST+7,sp)
1322  0197 88            	push	a
1323  0198 7b06          	ld	a,(OFST+6,sp)
1324  019a 97            	ld	xl,a
1325  019b 7b03          	ld	a,(OFST+3,sp)
1326  019d 95            	ld	xh,a
1327  019e cd0719        	call	L5_TI2_Config
1329  01a1 84            	pop	a
1330                     ; 364     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1332  01a2 7b06          	ld	a,(OFST+6,sp)
1333  01a4 cd05d3        	call	_TIM1_SetIC2Prescaler
1336  01a7 202a          	jra	L545
1337  01a9               L745:
1338                     ; 366   else if (TIM1_Channel == TIM1_CHANNEL_3)
1340  01a9 a102          	cp	a,#2
1341  01ab 2614          	jrne	L355
1342                     ; 369     TI3_Config((uint8_t)TIM1_ICPolarity,
1342                     ; 370                (uint8_t)TIM1_ICSelection,
1342                     ; 371                (uint8_t)TIM1_ICFilter);
1344  01ad 7b07          	ld	a,(OFST+7,sp)
1345  01af 88            	push	a
1346  01b0 7b06          	ld	a,(OFST+6,sp)
1347  01b2 97            	ld	xl,a
1348  01b3 7b03          	ld	a,(OFST+3,sp)
1349  01b5 95            	ld	xh,a
1350  01b6 cd0749        	call	L7_TI3_Config
1352  01b9 84            	pop	a
1353                     ; 373     TIM1_SetIC3Prescaler(TIM1_ICPrescaler);
1355  01ba 7b06          	ld	a,(OFST+6,sp)
1356  01bc cd05e0        	call	_TIM1_SetIC3Prescaler
1359  01bf 2012          	jra	L545
1360  01c1               L355:
1361                     ; 378     TI4_Config((uint8_t)TIM1_ICPolarity,
1361                     ; 379                (uint8_t)TIM1_ICSelection,
1361                     ; 380                (uint8_t)TIM1_ICFilter);
1363  01c1 7b07          	ld	a,(OFST+7,sp)
1364  01c3 88            	push	a
1365  01c4 7b06          	ld	a,(OFST+6,sp)
1366  01c6 97            	ld	xl,a
1367  01c7 7b03          	ld	a,(OFST+3,sp)
1368  01c9 95            	ld	xh,a
1369  01ca cd0779        	call	L11_TI4_Config
1371  01cd 84            	pop	a
1372                     ; 382     TIM1_SetIC4Prescaler(TIM1_ICPrescaler);
1374  01ce 7b06          	ld	a,(OFST+6,sp)
1375  01d0 cd05ed        	call	_TIM1_SetIC4Prescaler
1377  01d3               L545:
1378                     ; 384 }
1381  01d3 85            	popw	x
1382  01d4 81            	ret	
1478                     ; 400 void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
1478                     ; 401                      TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1478                     ; 402                      TIM1_ICSelection_TypeDef TIM1_ICSelection,
1478                     ; 403                      TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1478                     ; 404                      uint8_t TIM1_ICFilter)
1478                     ; 405 {
1479                     	switch	.text
1480  01d5               _TIM1_PWMIConfig:
1482  01d5 89            	pushw	x
1483  01d6 89            	pushw	x
1484       00000002      OFST:	set	2
1487                     ; 406   uint8_t icpolarity = TIM1_ICPOLARITY_RISING;
1489                     ; 407   uint8_t icselection = TIM1_ICSELECTION_DIRECTTI;
1491                     ; 410   assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
1493                     ; 411   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1495                     ; 412   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1497                     ; 413   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1499                     ; 416   if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
1501  01d7 9f            	ld	a,xl
1502  01d8 4a            	dec	a
1503  01d9 2702          	jreq	L526
1504                     ; 418     icpolarity = TIM1_ICPOLARITY_FALLING;
1506  01db a601          	ld	a,#1
1508  01dd               L526:
1509                     ; 422     icpolarity = TIM1_ICPOLARITY_RISING;
1511  01dd 6b01          	ld	(OFST-1,sp),a
1513                     ; 426   if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
1515  01df 7b07          	ld	a,(OFST+5,sp)
1516  01e1 4a            	dec	a
1517  01e2 2604          	jrne	L136
1518                     ; 428     icselection = TIM1_ICSELECTION_INDIRECTTI;
1520  01e4 a602          	ld	a,#2
1522  01e6 2002          	jra	L336
1523  01e8               L136:
1524                     ; 432     icselection = TIM1_ICSELECTION_DIRECTTI;
1526  01e8 a601          	ld	a,#1
1527  01ea               L336:
1528  01ea 6b02          	ld	(OFST+0,sp),a
1530                     ; 435   if (TIM1_Channel == TIM1_CHANNEL_1)
1532  01ec 7b03          	ld	a,(OFST+1,sp)
1533  01ee 2626          	jrne	L536
1534                     ; 438     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1534                     ; 439                (uint8_t)TIM1_ICFilter);
1536  01f0 7b09          	ld	a,(OFST+7,sp)
1537  01f2 88            	push	a
1538  01f3 7b08          	ld	a,(OFST+6,sp)
1539  01f5 97            	ld	xl,a
1540  01f6 7b05          	ld	a,(OFST+3,sp)
1541  01f8 95            	ld	xh,a
1542  01f9 cd06e9        	call	L3_TI1_Config
1544  01fc 84            	pop	a
1545                     ; 442     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1547  01fd 7b08          	ld	a,(OFST+6,sp)
1548  01ff cd05c6        	call	_TIM1_SetIC1Prescaler
1550                     ; 445     TI2_Config(icpolarity, icselection, TIM1_ICFilter);
1552  0202 7b09          	ld	a,(OFST+7,sp)
1553  0204 88            	push	a
1554  0205 7b03          	ld	a,(OFST+1,sp)
1555  0207 97            	ld	xl,a
1556  0208 7b02          	ld	a,(OFST+0,sp)
1557  020a 95            	ld	xh,a
1558  020b cd0719        	call	L5_TI2_Config
1560  020e 84            	pop	a
1561                     ; 448     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1563  020f 7b08          	ld	a,(OFST+6,sp)
1564  0211 cd05d3        	call	_TIM1_SetIC2Prescaler
1567  0214 2024          	jra	L736
1568  0216               L536:
1569                     ; 453     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1569                     ; 454                (uint8_t)TIM1_ICFilter);
1571  0216 7b09          	ld	a,(OFST+7,sp)
1572  0218 88            	push	a
1573  0219 7b08          	ld	a,(OFST+6,sp)
1574  021b 97            	ld	xl,a
1575  021c 7b05          	ld	a,(OFST+3,sp)
1576  021e 95            	ld	xh,a
1577  021f cd0719        	call	L5_TI2_Config
1579  0222 84            	pop	a
1580                     ; 457     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1582  0223 7b08          	ld	a,(OFST+6,sp)
1583  0225 cd05d3        	call	_TIM1_SetIC2Prescaler
1585                     ; 460     TI1_Config(icpolarity, icselection, TIM1_ICFilter);
1587  0228 7b09          	ld	a,(OFST+7,sp)
1588  022a 88            	push	a
1589  022b 7b03          	ld	a,(OFST+1,sp)
1590  022d 97            	ld	xl,a
1591  022e 7b02          	ld	a,(OFST+0,sp)
1592  0230 95            	ld	xh,a
1593  0231 cd06e9        	call	L3_TI1_Config
1595  0234 84            	pop	a
1596                     ; 463     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1598  0235 7b08          	ld	a,(OFST+6,sp)
1599  0237 cd05c6        	call	_TIM1_SetIC1Prescaler
1601  023a               L736:
1602                     ; 465 }
1605  023a 5b04          	addw	sp,#4
1606  023c 81            	ret	
1661                     ; 473 void TIM1_Cmd(FunctionalState NewState)
1661                     ; 474 {
1662                     	switch	.text
1663  023d               _TIM1_Cmd:
1667                     ; 476   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1669                     ; 479   if (NewState != DISABLE)
1671  023d 4d            	tnz	a
1672  023e 2705          	jreq	L766
1673                     ; 481     TIM1->CR1 |= TIM1_CR1_CEN;
1675  0240 72105250      	bset	21072,#0
1678  0244 81            	ret	
1679  0245               L766:
1680                     ; 485     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
1682  0245 72115250      	bres	21072,#0
1683                     ; 487 }
1686  0249 81            	ret	
1722                     ; 495 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
1722                     ; 496 {
1723                     	switch	.text
1724  024a               _TIM1_CtrlPWMOutputs:
1728                     ; 498   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1730                     ; 502   if (NewState != DISABLE)
1732  024a 4d            	tnz	a
1733  024b 2705          	jreq	L117
1734                     ; 504     TIM1->BKR |= TIM1_BKR_MOE;
1736  024d 721e526d      	bset	21101,#7
1739  0251 81            	ret	
1740  0252               L117:
1741                     ; 508     TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
1743  0252 721f526d      	bres	21101,#7
1744                     ; 510 }
1747  0256 81            	ret	
1854                     ; 529 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
1854                     ; 530 {
1855                     	switch	.text
1856  0257               _TIM1_ITConfig:
1858  0257 89            	pushw	x
1859       00000000      OFST:	set	0
1862                     ; 532   assert_param(IS_TIM1_IT_OK(TIM1_IT));
1864                     ; 533   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1866                     ; 535   if (NewState != DISABLE)
1868  0258 9f            	ld	a,xl
1869  0259 4d            	tnz	a
1870  025a 2706          	jreq	L367
1871                     ; 538     TIM1->IER |= (uint8_t)TIM1_IT;
1873  025c 9e            	ld	a,xh
1874  025d ca5254        	or	a,21076
1876  0260 2006          	jra	L567
1877  0262               L367:
1878                     ; 543     TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
1880  0262 7b01          	ld	a,(OFST+1,sp)
1881  0264 43            	cpl	a
1882  0265 c45254        	and	a,21076
1883  0268               L567:
1884  0268 c75254        	ld	21076,a
1885                     ; 545 }
1888  026b 85            	popw	x
1889  026c 81            	ret	
1913                     ; 552 void TIM1_InternalClockConfig(void)
1913                     ; 553 {
1914                     	switch	.text
1915  026d               _TIM1_InternalClockConfig:
1919                     ; 555   TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
1921  026d c65252        	ld	a,21074
1922  0270 a4f8          	and	a,#248
1923  0272 c75252        	ld	21074,a
1924                     ; 556 }
1927  0275 81            	ret	
2044                     ; 574 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2044                     ; 575                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2044                     ; 576                               uint8_t ExtTRGFilter)
2044                     ; 577 {
2045                     	switch	.text
2046  0276               _TIM1_ETRClockMode1Config:
2048  0276 89            	pushw	x
2049       00000000      OFST:	set	0
2052                     ; 579   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2054                     ; 580   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2056                     ; 583   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2058  0277 7b05          	ld	a,(OFST+5,sp)
2059  0279 88            	push	a
2060  027a 7b02          	ld	a,(OFST+2,sp)
2061  027c 95            	ld	xh,a
2062  027d ad1b          	call	_TIM1_ETRConfig
2064  027f 84            	pop	a
2065                     ; 586   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
2065                     ; 587                          | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
2067  0280 c65252        	ld	a,21074
2068  0283 aa77          	or	a,#119
2069  0285 c75252        	ld	21074,a
2070                     ; 588 }
2073  0288 85            	popw	x
2074  0289 81            	ret	
2132                     ; 606 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2132                     ; 607                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2132                     ; 608                               uint8_t ExtTRGFilter)
2132                     ; 609 {
2133                     	switch	.text
2134  028a               _TIM1_ETRClockMode2Config:
2136  028a 89            	pushw	x
2137       00000000      OFST:	set	0
2140                     ; 611   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2142                     ; 612   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2144                     ; 615   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2146  028b 7b05          	ld	a,(OFST+5,sp)
2147  028d 88            	push	a
2148  028e 7b02          	ld	a,(OFST+2,sp)
2149  0290 95            	ld	xh,a
2150  0291 ad07          	call	_TIM1_ETRConfig
2152  0293 721c5253      	bset	21075,#6
2153                     ; 618   TIM1->ETR |= TIM1_ETR_ECE;
2155                     ; 619 }
2158  0297 5b03          	addw	sp,#3
2159  0299 81            	ret	
2215                     ; 637 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2215                     ; 638                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2215                     ; 639                     uint8_t ExtTRGFilter)
2215                     ; 640 {
2216                     	switch	.text
2217  029a               _TIM1_ETRConfig:
2219  029a 89            	pushw	x
2220       00000000      OFST:	set	0
2223                     ; 642   assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
2225                     ; 644   TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
2225                     ; 645                          (uint8_t)ExtTRGFilter );
2227  029b 9f            	ld	a,xl
2228  029c 1a01          	or	a,(OFST+1,sp)
2229  029e 1a05          	or	a,(OFST+5,sp)
2230  02a0 ca5253        	or	a,21075
2231  02a3 c75253        	ld	21075,a
2232                     ; 646 }
2235  02a6 85            	popw	x
2236  02a7 81            	ret	
2325                     ; 663 void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource,
2325                     ; 664                                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
2325                     ; 665                                  uint8_t ICFilter)
2325                     ; 666 {
2326                     	switch	.text
2327  02a8               _TIM1_TIxExternalClockConfig:
2329  02a8 89            	pushw	x
2330       00000000      OFST:	set	0
2333                     ; 668   assert_param(IS_TIM1_TIXCLK_SOURCE_OK(TIM1_TIxExternalCLKSource));
2335                     ; 669   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
2337                     ; 670   assert_param(IS_TIM1_IC_FILTER_OK(ICFilter));
2339                     ; 673   if (TIM1_TIxExternalCLKSource == TIM1_TIXEXTERNALCLK1SOURCE_TI2)
2341  02a9 9e            	ld	a,xh
2342  02aa a160          	cp	a,#96
2343  02ac 260d          	jrne	L5611
2344                     ; 675     TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2346  02ae 7b05          	ld	a,(OFST+5,sp)
2347  02b0 88            	push	a
2348  02b1 9f            	ld	a,xl
2349  02b2 ae0001        	ldw	x,#1
2350  02b5 95            	ld	xh,a
2351  02b6 cd0719        	call	L5_TI2_Config
2354  02b9 200c          	jra	L7611
2355  02bb               L5611:
2356                     ; 679     TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2358  02bb 7b05          	ld	a,(OFST+5,sp)
2359  02bd 88            	push	a
2360  02be 7b03          	ld	a,(OFST+3,sp)
2361  02c0 ae0001        	ldw	x,#1
2362  02c3 95            	ld	xh,a
2363  02c4 cd06e9        	call	L3_TI1_Config
2365  02c7               L7611:
2366  02c7 84            	pop	a
2367                     ; 683   TIM1_SelectInputTrigger((TIM1_TS_TypeDef)TIM1_TIxExternalCLKSource);
2369  02c8 7b01          	ld	a,(OFST+1,sp)
2370  02ca ad0a          	call	_TIM1_SelectInputTrigger
2372                     ; 686   TIM1->SMCR |= (uint8_t)(TIM1_SLAVEMODE_EXTERNAL1);
2374  02cc c65252        	ld	a,21074
2375  02cf aa07          	or	a,#7
2376  02d1 c75252        	ld	21074,a
2377                     ; 687 }
2380  02d4 85            	popw	x
2381  02d5 81            	ret	
2466                     ; 699 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
2466                     ; 700 {
2467                     	switch	.text
2468  02d6               _TIM1_SelectInputTrigger:
2470  02d6 88            	push	a
2471       00000000      OFST:	set	0
2474                     ; 702   assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
2476                     ; 705   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
2478  02d7 c65252        	ld	a,21074
2479  02da a48f          	and	a,#143
2480  02dc 1a01          	or	a,(OFST+1,sp)
2481  02de c75252        	ld	21074,a
2482                     ; 706 }
2485  02e1 84            	pop	a
2486  02e2 81            	ret	
2522                     ; 715 void TIM1_UpdateDisableConfig(FunctionalState NewState)
2522                     ; 716 {
2523                     	switch	.text
2524  02e3               _TIM1_UpdateDisableConfig:
2528                     ; 718   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2530                     ; 721   if (NewState != DISABLE)
2532  02e3 4d            	tnz	a
2533  02e4 2705          	jreq	L5421
2534                     ; 723     TIM1->CR1 |= TIM1_CR1_UDIS;
2536  02e6 72125250      	bset	21072,#1
2539  02ea 81            	ret	
2540  02eb               L5421:
2541                     ; 727     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
2543  02eb 72135250      	bres	21072,#1
2544                     ; 729 }
2547  02ef 81            	ret	
2605                     ; 739 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
2605                     ; 740 {
2606                     	switch	.text
2607  02f0               _TIM1_UpdateRequestConfig:
2611                     ; 742   assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
2613                     ; 745   if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
2615  02f0 4d            	tnz	a
2616  02f1 2705          	jreq	L7721
2617                     ; 747     TIM1->CR1 |= TIM1_CR1_URS;
2619  02f3 72145250      	bset	21072,#2
2622  02f7 81            	ret	
2623  02f8               L7721:
2624                     ; 751     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
2626  02f8 72155250      	bres	21072,#2
2627                     ; 753 }
2630  02fc 81            	ret	
2666                     ; 761 void TIM1_SelectHallSensor(FunctionalState NewState)
2666                     ; 762 {
2667                     	switch	.text
2668  02fd               _TIM1_SelectHallSensor:
2672                     ; 764   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2674                     ; 767   if (NewState != DISABLE)
2676  02fd 4d            	tnz	a
2677  02fe 2705          	jreq	L1231
2678                     ; 769     TIM1->CR2 |= TIM1_CR2_TI1S;
2680  0300 721e5251      	bset	21073,#7
2683  0304 81            	ret	
2684  0305               L1231:
2685                     ; 773     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_TI1S);
2687  0305 721f5251      	bres	21073,#7
2688                     ; 775 }
2691  0309 81            	ret	
2748                     ; 785 void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode)
2748                     ; 786 {
2749                     	switch	.text
2750  030a               _TIM1_SelectOnePulseMode:
2754                     ; 788   assert_param(IS_TIM1_OPM_MODE_OK(TIM1_OPMode));
2756                     ; 791   if (TIM1_OPMode != TIM1_OPMODE_REPETITIVE)
2758  030a 4d            	tnz	a
2759  030b 2705          	jreq	L3531
2760                     ; 793     TIM1->CR1 |= TIM1_CR1_OPM;
2762  030d 72165250      	bset	21072,#3
2765  0311 81            	ret	
2766  0312               L3531:
2767                     ; 797     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_OPM);
2769  0312 72175250      	bres	21072,#3
2770                     ; 800 }
2773  0316 81            	ret	
2871                     ; 815 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
2871                     ; 816 {
2872                     	switch	.text
2873  0317               _TIM1_SelectOutputTrigger:
2875  0317 88            	push	a
2876       00000000      OFST:	set	0
2879                     ; 818   assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
2881                     ; 821   TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
2881                     ; 822                         (uint8_t) TIM1_TRGOSource);
2883  0318 c65251        	ld	a,21073
2884  031b a48f          	and	a,#143
2885  031d 1a01          	or	a,(OFST+1,sp)
2886  031f c75251        	ld	21073,a
2887                     ; 823 }
2890  0322 84            	pop	a
2891  0323 81            	ret	
2965                     ; 835 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
2965                     ; 836 {
2966                     	switch	.text
2967  0324               _TIM1_SelectSlaveMode:
2969  0324 88            	push	a
2970       00000000      OFST:	set	0
2973                     ; 838   assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
2975                     ; 841   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
2975                     ; 842                          (uint8_t)TIM1_SlaveMode);
2977  0325 c65252        	ld	a,21074
2978  0328 a4f8          	and	a,#248
2979  032a 1a01          	or	a,(OFST+1,sp)
2980  032c c75252        	ld	21074,a
2981                     ; 843 }
2984  032f 84            	pop	a
2985  0330 81            	ret	
3021                     ; 851 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
3021                     ; 852 {
3022                     	switch	.text
3023  0331               _TIM1_SelectMasterSlaveMode:
3027                     ; 854   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3029                     ; 857   if (NewState != DISABLE)
3031  0331 4d            	tnz	a
3032  0332 2705          	jreq	L7641
3033                     ; 859     TIM1->SMCR |= TIM1_SMCR_MSM;
3035  0334 721e5252      	bset	21074,#7
3038  0338 81            	ret	
3039  0339               L7641:
3040                     ; 863     TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
3042  0339 721f5252      	bres	21074,#7
3043                     ; 865 }
3046  033d 81            	ret	
3132                     ; 887 void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode,
3132                     ; 888                                  TIM1_ICPolarity_TypeDef TIM1_IC1Polarity,
3132                     ; 889                                  TIM1_ICPolarity_TypeDef TIM1_IC2Polarity)
3132                     ; 890 {
3133                     	switch	.text
3134  033e               _TIM1_EncoderInterfaceConfig:
3136  033e 89            	pushw	x
3137       00000000      OFST:	set	0
3140                     ; 892   assert_param(IS_TIM1_ENCODER_MODE_OK(TIM1_EncoderMode));
3142                     ; 893   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC1Polarity));
3144                     ; 894   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC2Polarity));
3146                     ; 897   if (TIM1_IC1Polarity != TIM1_ICPOLARITY_RISING)
3148  033f 9f            	ld	a,xl
3149  0340 4d            	tnz	a
3150  0341 2706          	jreq	L3351
3151                     ; 899     TIM1->CCER1 |= TIM1_CCER1_CC1P;
3153  0343 7212525c      	bset	21084,#1
3155  0347 2004          	jra	L5351
3156  0349               L3351:
3157                     ; 903     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
3159  0349 7213525c      	bres	21084,#1
3160  034d               L5351:
3161                     ; 906   if (TIM1_IC2Polarity != TIM1_ICPOLARITY_RISING)
3163  034d 7b05          	ld	a,(OFST+5,sp)
3164  034f 2706          	jreq	L7351
3165                     ; 908     TIM1->CCER1 |= TIM1_CCER1_CC2P;
3167  0351 721a525c      	bset	21084,#5
3169  0355 2004          	jra	L1451
3170  0357               L7351:
3171                     ; 912     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
3173  0357 721b525c      	bres	21084,#5
3174  035b               L1451:
3175                     ; 915   TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(TIM1_SMCR_MSM | TIM1_SMCR_TS))
3175                     ; 916                          | (uint8_t) TIM1_EncoderMode);
3177  035b c65252        	ld	a,21074
3178  035e a4f0          	and	a,#240
3179  0360 1a01          	or	a,(OFST+1,sp)
3180  0362 c75252        	ld	21074,a
3181                     ; 919   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_CCxS)) 
3181                     ; 920                           | (uint8_t) CCMR_TIxDirect_Set);
3183  0365 c65258        	ld	a,21080
3184  0368 a4fc          	and	a,#252
3185  036a aa01          	or	a,#1
3186  036c c75258        	ld	21080,a
3187                     ; 921   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_CCxS))
3187                     ; 922                           | (uint8_t) CCMR_TIxDirect_Set);
3189  036f c65259        	ld	a,21081
3190  0372 a4fc          	and	a,#252
3191  0374 aa01          	or	a,#1
3192  0376 c75259        	ld	21081,a
3193                     ; 923 }
3196  0379 85            	popw	x
3197  037a 81            	ret	
3264                     ; 935 void TIM1_PrescalerConfig(uint16_t Prescaler,
3264                     ; 936                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
3264                     ; 937 {
3265                     	switch	.text
3266  037b               _TIM1_PrescalerConfig:
3268       fffffffe      OFST: set -2
3271                     ; 939   assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
3273                     ; 942   TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
3275  037b 9e            	ld	a,xh
3276  037c c75260        	ld	21088,a
3277                     ; 943   TIM1->PSCRL = (uint8_t)(Prescaler);
3279  037f 9f            	ld	a,xl
3280  0380 c75261        	ld	21089,a
3281                     ; 946   TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
3283  0383 7b03          	ld	a,(OFST+5,sp)
3284  0385 c75257        	ld	21079,a
3285                     ; 947 }
3288  0388 81            	ret	
3324                     ; 960 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
3324                     ; 961 {
3325                     	switch	.text
3326  0389               _TIM1_CounterModeConfig:
3328  0389 88            	push	a
3329       00000000      OFST:	set	0
3332                     ; 963   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
3334                     ; 967   TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
3334                     ; 968                         | (uint8_t)TIM1_CounterMode);
3336  038a c65250        	ld	a,21072
3337  038d a48f          	and	a,#143
3338  038f 1a01          	or	a,(OFST+1,sp)
3339  0391 c75250        	ld	21072,a
3340                     ; 969 }
3343  0394 84            	pop	a
3344  0395 81            	ret	
3402                     ; 979 void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3402                     ; 980 {
3403                     	switch	.text
3404  0396               _TIM1_ForcedOC1Config:
3406  0396 88            	push	a
3407       00000000      OFST:	set	0
3410                     ; 982   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3412                     ; 985   TIM1->CCMR1 =  (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM))|
3412                     ; 986                            (uint8_t)TIM1_ForcedAction);
3414  0397 c65258        	ld	a,21080
3415  039a a48f          	and	a,#143
3416  039c 1a01          	or	a,(OFST+1,sp)
3417  039e c75258        	ld	21080,a
3418                     ; 987 }
3421  03a1 84            	pop	a
3422  03a2 81            	ret	
3458                     ; 997 void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3458                     ; 998 {
3459                     	switch	.text
3460  03a3               _TIM1_ForcedOC2Config:
3462  03a3 88            	push	a
3463       00000000      OFST:	set	0
3466                     ; 1000   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3468                     ; 1003   TIM1->CCMR2  =  (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
3468                     ; 1004                             | (uint8_t)TIM1_ForcedAction);
3470  03a4 c65259        	ld	a,21081
3471  03a7 a48f          	and	a,#143
3472  03a9 1a01          	or	a,(OFST+1,sp)
3473  03ab c75259        	ld	21081,a
3474                     ; 1005 }
3477  03ae 84            	pop	a
3478  03af 81            	ret	
3514                     ; 1016 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3514                     ; 1017 {
3515                     	switch	.text
3516  03b0               _TIM1_ForcedOC3Config:
3518  03b0 88            	push	a
3519       00000000      OFST:	set	0
3522                     ; 1019   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3524                     ; 1022   TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
3524                     ; 1023                             | (uint8_t)TIM1_ForcedAction);
3526  03b1 c6525a        	ld	a,21082
3527  03b4 a48f          	and	a,#143
3528  03b6 1a01          	or	a,(OFST+1,sp)
3529  03b8 c7525a        	ld	21082,a
3530                     ; 1024 }
3533  03bb 84            	pop	a
3534  03bc 81            	ret	
3570                     ; 1035 void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3570                     ; 1036 {
3571                     	switch	.text
3572  03bd               _TIM1_ForcedOC4Config:
3574  03bd 88            	push	a
3575       00000000      OFST:	set	0
3578                     ; 1038   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3580                     ; 1041   TIM1->CCMR4  =  (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
3580                     ; 1042                             | (uint8_t)TIM1_ForcedAction);
3582  03be c6525b        	ld	a,21083
3583  03c1 a48f          	and	a,#143
3584  03c3 1a01          	or	a,(OFST+1,sp)
3585  03c5 c7525b        	ld	21083,a
3586                     ; 1043 }
3589  03c8 84            	pop	a
3590  03c9 81            	ret	
3626                     ; 1051 void TIM1_ARRPreloadConfig(FunctionalState NewState)
3626                     ; 1052 {
3627                     	switch	.text
3628  03ca               _TIM1_ARRPreloadConfig:
3632                     ; 1054   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3634                     ; 1057   if (NewState != DISABLE)
3636  03ca 4d            	tnz	a
3637  03cb 2705          	jreq	L1371
3638                     ; 1059     TIM1->CR1 |= TIM1_CR1_ARPE;
3640  03cd 721e5250      	bset	21072,#7
3643  03d1 81            	ret	
3644  03d2               L1371:
3645                     ; 1063     TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
3647  03d2 721f5250      	bres	21072,#7
3648                     ; 1065 }
3651  03d6 81            	ret	
3686                     ; 1073 void TIM1_SelectCOM(FunctionalState NewState)
3686                     ; 1074 {
3687                     	switch	.text
3688  03d7               _TIM1_SelectCOM:
3692                     ; 1076   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3694                     ; 1079   if (NewState != DISABLE)
3696  03d7 4d            	tnz	a
3697  03d8 2705          	jreq	L3571
3698                     ; 1081     TIM1->CR2 |= TIM1_CR2_COMS;
3700  03da 72145251      	bset	21073,#2
3703  03de 81            	ret	
3704  03df               L3571:
3705                     ; 1085     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_COMS);
3707  03df 72155251      	bres	21073,#2
3708                     ; 1087 }
3711  03e3 81            	ret	
3747                     ; 1095 void TIM1_CCPreloadControl(FunctionalState NewState)
3747                     ; 1096 {
3748                     	switch	.text
3749  03e4               _TIM1_CCPreloadControl:
3753                     ; 1098   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3755                     ; 1101   if (NewState != DISABLE)
3757  03e4 4d            	tnz	a
3758  03e5 2705          	jreq	L5771
3759                     ; 1103     TIM1->CR2 |= TIM1_CR2_CCPC;
3761  03e7 72105251      	bset	21073,#0
3764  03eb 81            	ret	
3765  03ec               L5771:
3766                     ; 1107     TIM1->CR2 &= (uint8_t)(~TIM1_CR2_CCPC);
3768  03ec 72115251      	bres	21073,#0
3769                     ; 1109 }
3772  03f0 81            	ret	
3808                     ; 1117 void TIM1_OC1PreloadConfig(FunctionalState NewState)
3808                     ; 1118 {
3809                     	switch	.text
3810  03f1               _TIM1_OC1PreloadConfig:
3814                     ; 1120   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3816                     ; 1123   if (NewState != DISABLE)
3818  03f1 4d            	tnz	a
3819  03f2 2705          	jreq	L7102
3820                     ; 1125     TIM1->CCMR1 |= TIM1_CCMR_OCxPE;
3822  03f4 72165258      	bset	21080,#3
3825  03f8 81            	ret	
3826  03f9               L7102:
3827                     ; 1129     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxPE);
3829  03f9 72175258      	bres	21080,#3
3830                     ; 1131 }
3833  03fd 81            	ret	
3869                     ; 1139 void TIM1_OC2PreloadConfig(FunctionalState NewState)
3869                     ; 1140 {
3870                     	switch	.text
3871  03fe               _TIM1_OC2PreloadConfig:
3875                     ; 1142   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3877                     ; 1145   if (NewState != DISABLE)
3879  03fe 4d            	tnz	a
3880  03ff 2705          	jreq	L1402
3881                     ; 1147     TIM1->CCMR2 |= TIM1_CCMR_OCxPE;
3883  0401 72165259      	bset	21081,#3
3886  0405 81            	ret	
3887  0406               L1402:
3888                     ; 1151     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxPE);
3890  0406 72175259      	bres	21081,#3
3891                     ; 1153 }
3894  040a 81            	ret	
3930                     ; 1161 void TIM1_OC3PreloadConfig(FunctionalState NewState)
3930                     ; 1162 {
3931                     	switch	.text
3932  040b               _TIM1_OC3PreloadConfig:
3936                     ; 1164   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3938                     ; 1167   if (NewState != DISABLE)
3940  040b 4d            	tnz	a
3941  040c 2705          	jreq	L3602
3942                     ; 1169     TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
3944  040e 7216525a      	bset	21082,#3
3947  0412 81            	ret	
3948  0413               L3602:
3949                     ; 1173     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
3951  0413 7217525a      	bres	21082,#3
3952                     ; 1175 }
3955  0417 81            	ret	
3991                     ; 1183 void TIM1_OC4PreloadConfig(FunctionalState NewState)
3991                     ; 1184 {
3992                     	switch	.text
3993  0418               _TIM1_OC4PreloadConfig:
3997                     ; 1186   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3999                     ; 1189   if (NewState != DISABLE)
4001  0418 4d            	tnz	a
4002  0419 2705          	jreq	L5012
4003                     ; 1191     TIM1->CCMR4 |= TIM1_CCMR_OCxPE;
4005  041b 7216525b      	bset	21083,#3
4008  041f 81            	ret	
4009  0420               L5012:
4010                     ; 1195     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4012  0420 7217525b      	bres	21083,#3
4013                     ; 1197 }
4016  0424 81            	ret	
4051                     ; 1205 void TIM1_OC1FastConfig(FunctionalState NewState)
4051                     ; 1206 {
4052                     	switch	.text
4053  0425               _TIM1_OC1FastConfig:
4057                     ; 1208   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4059                     ; 1211   if (NewState != DISABLE)
4061  0425 4d            	tnz	a
4062  0426 2705          	jreq	L7212
4063                     ; 1213     TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
4065  0428 72145258      	bset	21080,#2
4068  042c 81            	ret	
4069  042d               L7212:
4070                     ; 1217     TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4072  042d 72155258      	bres	21080,#2
4073                     ; 1219 }
4076  0431 81            	ret	
4111                     ; 1227 void TIM1_OC2FastConfig(FunctionalState NewState)
4111                     ; 1228 {
4112                     	switch	.text
4113  0432               _TIM1_OC2FastConfig:
4117                     ; 1230   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4119                     ; 1233   if (NewState != DISABLE)
4121  0432 4d            	tnz	a
4122  0433 2705          	jreq	L1512
4123                     ; 1235     TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
4125  0435 72145259      	bset	21081,#2
4128  0439 81            	ret	
4129  043a               L1512:
4130                     ; 1239     TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4132  043a 72155259      	bres	21081,#2
4133                     ; 1241 }
4136  043e 81            	ret	
4171                     ; 1249 void TIM1_OC3FastConfig(FunctionalState NewState)
4171                     ; 1250 {
4172                     	switch	.text
4173  043f               _TIM1_OC3FastConfig:
4177                     ; 1252   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4179                     ; 1255   if (NewState != DISABLE)
4181  043f 4d            	tnz	a
4182  0440 2705          	jreq	L3712
4183                     ; 1257     TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
4185  0442 7214525a      	bset	21082,#2
4188  0446 81            	ret	
4189  0447               L3712:
4190                     ; 1261     TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4192  0447 7215525a      	bres	21082,#2
4193                     ; 1263 }
4196  044b 81            	ret	
4231                     ; 1271 void TIM1_OC4FastConfig(FunctionalState NewState)
4231                     ; 1272 {
4232                     	switch	.text
4233  044c               _TIM1_OC4FastConfig:
4237                     ; 1274   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4239                     ; 1277   if (NewState != DISABLE)
4241  044c 4d            	tnz	a
4242  044d 2705          	jreq	L5122
4243                     ; 1279     TIM1->CCMR4 |= TIM1_CCMR_OCxFE;
4245  044f 7214525b      	bset	21083,#2
4248  0453 81            	ret	
4249  0454               L5122:
4250                     ; 1283     TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4252  0454 7215525b      	bres	21083,#2
4253                     ; 1285 }
4256  0458 81            	ret	
4361                     ; 1301 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
4361                     ; 1302 {
4362                     	switch	.text
4363  0459               _TIM1_GenerateEvent:
4367                     ; 1304   assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
4369                     ; 1307   TIM1->EGR = (uint8_t)TIM1_EventSource;
4371  0459 c75257        	ld	21079,a
4372                     ; 1308 }
4375  045c 81            	ret	
4411                     ; 1318 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4411                     ; 1319 {
4412                     	switch	.text
4413  045d               _TIM1_OC1PolarityConfig:
4417                     ; 1321   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4419                     ; 1324   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4421  045d 4d            	tnz	a
4422  045e 2705          	jreq	L1032
4423                     ; 1326     TIM1->CCER1 |= TIM1_CCER1_CC1P;
4425  0460 7212525c      	bset	21084,#1
4428  0464 81            	ret	
4429  0465               L1032:
4430                     ; 1330     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
4432  0465 7213525c      	bres	21084,#1
4433                     ; 1332 }
4436  0469 81            	ret	
4472                     ; 1342 void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4472                     ; 1343 {
4473                     	switch	.text
4474  046a               _TIM1_OC1NPolarityConfig:
4478                     ; 1345   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4480                     ; 1348   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4482  046a 4d            	tnz	a
4483  046b 2705          	jreq	L3232
4484                     ; 1350     TIM1->CCER1 |= TIM1_CCER1_CC1NP;
4486  046d 7216525c      	bset	21084,#3
4489  0471 81            	ret	
4490  0472               L3232:
4491                     ; 1354     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NP);
4493  0472 7217525c      	bres	21084,#3
4494                     ; 1356 }
4497  0476 81            	ret	
4533                     ; 1366 void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4533                     ; 1367 {
4534                     	switch	.text
4535  0477               _TIM1_OC2PolarityConfig:
4539                     ; 1369   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4541                     ; 1372   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4543  0477 4d            	tnz	a
4544  0478 2705          	jreq	L5432
4545                     ; 1374     TIM1->CCER1 |= TIM1_CCER1_CC2P;
4547  047a 721a525c      	bset	21084,#5
4550  047e 81            	ret	
4551  047f               L5432:
4552                     ; 1378     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
4554  047f 721b525c      	bres	21084,#5
4555                     ; 1380 }
4558  0483 81            	ret	
4594                     ; 1390 void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4594                     ; 1391 {
4595                     	switch	.text
4596  0484               _TIM1_OC2NPolarityConfig:
4600                     ; 1393   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4602                     ; 1396   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4604  0484 4d            	tnz	a
4605  0485 2705          	jreq	L7632
4606                     ; 1398     TIM1->CCER1 |= TIM1_CCER1_CC2NP;
4608  0487 721e525c      	bset	21084,#7
4611  048b 81            	ret	
4612  048c               L7632:
4613                     ; 1402     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NP);
4615  048c 721f525c      	bres	21084,#7
4616                     ; 1404 }
4619  0490 81            	ret	
4655                     ; 1414 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4655                     ; 1415 {
4656                     	switch	.text
4657  0491               _TIM1_OC3PolarityConfig:
4661                     ; 1417   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4663                     ; 1420   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4665  0491 4d            	tnz	a
4666  0492 2705          	jreq	L1142
4667                     ; 1422     TIM1->CCER2 |= TIM1_CCER2_CC3P;
4669  0494 7212525d      	bset	21085,#1
4672  0498 81            	ret	
4673  0499               L1142:
4674                     ; 1426     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
4676  0499 7213525d      	bres	21085,#1
4677                     ; 1428 }
4680  049d 81            	ret	
4716                     ; 1439 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4716                     ; 1440 {
4717                     	switch	.text
4718  049e               _TIM1_OC3NPolarityConfig:
4722                     ; 1442   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4724                     ; 1445   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4726  049e 4d            	tnz	a
4727  049f 2705          	jreq	L3342
4728                     ; 1447     TIM1->CCER2 |= TIM1_CCER2_CC3NP;
4730  04a1 7216525d      	bset	21085,#3
4733  04a5 81            	ret	
4734  04a6               L3342:
4735                     ; 1451     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
4737  04a6 7217525d      	bres	21085,#3
4738                     ; 1453 }
4741  04aa 81            	ret	
4777                     ; 1463 void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4777                     ; 1464 {
4778                     	switch	.text
4779  04ab               _TIM1_OC4PolarityConfig:
4783                     ; 1466   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4785                     ; 1469   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4787  04ab 4d            	tnz	a
4788  04ac 2705          	jreq	L5542
4789                     ; 1471     TIM1->CCER2 |= TIM1_CCER2_CC4P;
4791  04ae 721a525d      	bset	21085,#5
4794  04b2 81            	ret	
4795  04b3               L5542:
4796                     ; 1475     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
4798  04b3 721b525d      	bres	21085,#5
4799                     ; 1477 }
4802  04b7 81            	ret	
4847                     ; 1491 void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
4847                     ; 1492 {
4848                     	switch	.text
4849  04b8               _TIM1_CCxCmd:
4851  04b8 89            	pushw	x
4852       00000000      OFST:	set	0
4855                     ; 1494   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
4857                     ; 1495   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4859                     ; 1497   if (TIM1_Channel == TIM1_CHANNEL_1)
4861  04b9 9e            	ld	a,xh
4862  04ba 4d            	tnz	a
4863  04bb 2610          	jrne	L3052
4864                     ; 1500     if (NewState != DISABLE)
4866  04bd 9f            	ld	a,xl
4867  04be 4d            	tnz	a
4868  04bf 2706          	jreq	L5052
4869                     ; 1502       TIM1->CCER1 |= TIM1_CCER1_CC1E;
4871  04c1 7210525c      	bset	21084,#0
4873  04c5 203e          	jra	L1152
4874  04c7               L5052:
4875                     ; 1506       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
4877  04c7 7211525c      	bres	21084,#0
4878  04cb 2038          	jra	L1152
4879  04cd               L3052:
4880                     ; 1510   else if (TIM1_Channel == TIM1_CHANNEL_2)
4882  04cd 7b01          	ld	a,(OFST+1,sp)
4883  04cf a101          	cp	a,#1
4884  04d1 2610          	jrne	L3152
4885                     ; 1513     if (NewState != DISABLE)
4887  04d3 7b02          	ld	a,(OFST+2,sp)
4888  04d5 2706          	jreq	L5152
4889                     ; 1515       TIM1->CCER1 |= TIM1_CCER1_CC2E;
4891  04d7 7218525c      	bset	21084,#4
4893  04db 2028          	jra	L1152
4894  04dd               L5152:
4895                     ; 1519       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
4897  04dd 7219525c      	bres	21084,#4
4898  04e1 2022          	jra	L1152
4899  04e3               L3152:
4900                     ; 1522   else if (TIM1_Channel == TIM1_CHANNEL_3)
4902  04e3 a102          	cp	a,#2
4903  04e5 2610          	jrne	L3252
4904                     ; 1525     if (NewState != DISABLE)
4906  04e7 7b02          	ld	a,(OFST+2,sp)
4907  04e9 2706          	jreq	L5252
4908                     ; 1527       TIM1->CCER2 |= TIM1_CCER2_CC3E;
4910  04eb 7210525d      	bset	21085,#0
4912  04ef 2014          	jra	L1152
4913  04f1               L5252:
4914                     ; 1531       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
4916  04f1 7211525d      	bres	21085,#0
4917  04f5 200e          	jra	L1152
4918  04f7               L3252:
4919                     ; 1537     if (NewState != DISABLE)
4921  04f7 7b02          	ld	a,(OFST+2,sp)
4922  04f9 2706          	jreq	L3352
4923                     ; 1539       TIM1->CCER2 |= TIM1_CCER2_CC4E;
4925  04fb 7218525d      	bset	21085,#4
4927  04ff 2004          	jra	L1152
4928  0501               L3352:
4929                     ; 1543       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
4931  0501 7219525d      	bres	21085,#4
4932  0505               L1152:
4933                     ; 1546 }
4936  0505 85            	popw	x
4937  0506 81            	ret	
4982                     ; 1559 void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
4982                     ; 1560 {
4983                     	switch	.text
4984  0507               _TIM1_CCxNCmd:
4986  0507 89            	pushw	x
4987       00000000      OFST:	set	0
4990                     ; 1562   assert_param(IS_TIM1_COMPLEMENTARY_CHANNEL_OK(TIM1_Channel));
4992                     ; 1563   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4994                     ; 1565   if (TIM1_Channel == TIM1_CHANNEL_1)
4996  0508 9e            	ld	a,xh
4997  0509 4d            	tnz	a
4998  050a 2610          	jrne	L1652
4999                     ; 1568     if (NewState != DISABLE)
5001  050c 9f            	ld	a,xl
5002  050d 4d            	tnz	a
5003  050e 2706          	jreq	L3652
5004                     ; 1570       TIM1->CCER1 |= TIM1_CCER1_CC1NE;
5006  0510 7214525c      	bset	21084,#2
5008  0514 2029          	jra	L7652
5009  0516               L3652:
5010                     ; 1574       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NE);
5012  0516 7215525c      	bres	21084,#2
5013  051a 2023          	jra	L7652
5014  051c               L1652:
5015                     ; 1577   else if (TIM1_Channel == TIM1_CHANNEL_2)
5017  051c 7b01          	ld	a,(OFST+1,sp)
5018  051e 4a            	dec	a
5019  051f 2610          	jrne	L1752
5020                     ; 1580     if (NewState != DISABLE)
5022  0521 7b02          	ld	a,(OFST+2,sp)
5023  0523 2706          	jreq	L3752
5024                     ; 1582       TIM1->CCER1 |= TIM1_CCER1_CC2NE;
5026  0525 721c525c      	bset	21084,#6
5028  0529 2014          	jra	L7652
5029  052b               L3752:
5030                     ; 1586       TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NE);
5032  052b 721d525c      	bres	21084,#6
5033  052f 200e          	jra	L7652
5034  0531               L1752:
5035                     ; 1592     if (NewState != DISABLE)
5037  0531 7b02          	ld	a,(OFST+2,sp)
5038  0533 2706          	jreq	L1062
5039                     ; 1594       TIM1->CCER2 |= TIM1_CCER2_CC3NE;
5041  0535 7214525d      	bset	21085,#2
5043  0539 2004          	jra	L7652
5044  053b               L1062:
5045                     ; 1598       TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NE);
5047  053b 7215525d      	bres	21085,#2
5048  053f               L7652:
5049                     ; 1601 }
5052  053f 85            	popw	x
5053  0540 81            	ret	
5098                     ; 1624 void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode)
5098                     ; 1625 {
5099                     	switch	.text
5100  0541               _TIM1_SelectOCxM:
5102  0541 89            	pushw	x
5103       00000000      OFST:	set	0
5106                     ; 1627   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5108                     ; 1628   assert_param(IS_TIM1_OCM_OK(TIM1_OCMode));
5110                     ; 1630   if (TIM1_Channel == TIM1_CHANNEL_1)
5112  0542 9e            	ld	a,xh
5113  0543 4d            	tnz	a
5114  0544 2610          	jrne	L7262
5115                     ; 1633     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5117  0546 7211525c      	bres	21084,#0
5118                     ; 1636     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) 
5118                     ; 1637                             | (uint8_t)TIM1_OCMode);
5120  054a c65258        	ld	a,21080
5121  054d a48f          	and	a,#143
5122  054f 1a02          	or	a,(OFST+2,sp)
5123  0551 c75258        	ld	21080,a
5125  0554 2038          	jra	L1362
5126  0556               L7262:
5127                     ; 1639   else if (TIM1_Channel == TIM1_CHANNEL_2)
5129  0556 7b01          	ld	a,(OFST+1,sp)
5130  0558 a101          	cp	a,#1
5131  055a 2610          	jrne	L3362
5132                     ; 1642     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5134  055c 7219525c      	bres	21084,#4
5135                     ; 1645     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
5135                     ; 1646                             | (uint8_t)TIM1_OCMode);
5137  0560 c65259        	ld	a,21081
5138  0563 a48f          	and	a,#143
5139  0565 1a02          	or	a,(OFST+2,sp)
5140  0567 c75259        	ld	21081,a
5142  056a 2022          	jra	L1362
5143  056c               L3362:
5144                     ; 1648   else if (TIM1_Channel == TIM1_CHANNEL_3)
5146  056c a102          	cp	a,#2
5147  056e 2610          	jrne	L7362
5148                     ; 1651     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5150  0570 7211525d      	bres	21085,#0
5151                     ; 1654     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) 
5151                     ; 1655                             | (uint8_t)TIM1_OCMode);
5153  0574 c6525a        	ld	a,21082
5154  0577 a48f          	and	a,#143
5155  0579 1a02          	or	a,(OFST+2,sp)
5156  057b c7525a        	ld	21082,a
5158  057e 200e          	jra	L1362
5159  0580               L7362:
5160                     ; 1660     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5162  0580 7219525d      	bres	21085,#4
5163                     ; 1663     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
5163                     ; 1664                             | (uint8_t)TIM1_OCMode);
5165  0584 c6525b        	ld	a,21083
5166  0587 a48f          	and	a,#143
5167  0589 1a02          	or	a,(OFST+2,sp)
5168  058b c7525b        	ld	21083,a
5169  058e               L1362:
5170                     ; 1666 }
5173  058e 85            	popw	x
5174  058f 81            	ret	
5208                     ; 1674 void TIM1_SetCounter(uint16_t Counter)
5208                     ; 1675 {
5209                     	switch	.text
5210  0590               _TIM1_SetCounter:
5214                     ; 1677   TIM1->CNTRH = (uint8_t)(Counter >> 8);
5216  0590 9e            	ld	a,xh
5217  0591 c7525e        	ld	21086,a
5218                     ; 1678   TIM1->CNTRL = (uint8_t)(Counter);
5220  0594 9f            	ld	a,xl
5221  0595 c7525f        	ld	21087,a
5222                     ; 1679 }
5225  0598 81            	ret	
5259                     ; 1687 void TIM1_SetAutoreload(uint16_t Autoreload)
5259                     ; 1688 {
5260                     	switch	.text
5261  0599               _TIM1_SetAutoreload:
5265                     ; 1690   TIM1->ARRH = (uint8_t)(Autoreload >> 8);
5267  0599 9e            	ld	a,xh
5268  059a c75262        	ld	21090,a
5269                     ; 1691   TIM1->ARRL = (uint8_t)(Autoreload);
5271  059d 9f            	ld	a,xl
5272  059e c75263        	ld	21091,a
5273                     ; 1692  }
5276  05a1 81            	ret	
5310                     ; 1700 void TIM1_SetCompare1(uint16_t Compare1)
5310                     ; 1701 {
5311                     	switch	.text
5312  05a2               _TIM1_SetCompare1:
5316                     ; 1703   TIM1->CCR1H = (uint8_t)(Compare1 >> 8);
5318  05a2 9e            	ld	a,xh
5319  05a3 c75265        	ld	21093,a
5320                     ; 1704   TIM1->CCR1L = (uint8_t)(Compare1);
5322  05a6 9f            	ld	a,xl
5323  05a7 c75266        	ld	21094,a
5324                     ; 1705 }
5327  05aa 81            	ret	
5361                     ; 1713 void TIM1_SetCompare2(uint16_t Compare2)
5361                     ; 1714 {
5362                     	switch	.text
5363  05ab               _TIM1_SetCompare2:
5367                     ; 1716   TIM1->CCR2H = (uint8_t)(Compare2 >> 8);
5369  05ab 9e            	ld	a,xh
5370  05ac c75267        	ld	21095,a
5371                     ; 1717   TIM1->CCR2L = (uint8_t)(Compare2);
5373  05af 9f            	ld	a,xl
5374  05b0 c75268        	ld	21096,a
5375                     ; 1718 }
5378  05b3 81            	ret	
5412                     ; 1726 void TIM1_SetCompare3(uint16_t Compare3)
5412                     ; 1727 {
5413                     	switch	.text
5414  05b4               _TIM1_SetCompare3:
5418                     ; 1729   TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
5420  05b4 9e            	ld	a,xh
5421  05b5 c75269        	ld	21097,a
5422                     ; 1730   TIM1->CCR3L = (uint8_t)(Compare3);
5424  05b8 9f            	ld	a,xl
5425  05b9 c7526a        	ld	21098,a
5426                     ; 1731 }
5429  05bc 81            	ret	
5463                     ; 1739 void TIM1_SetCompare4(uint16_t Compare4)
5463                     ; 1740 {
5464                     	switch	.text
5465  05bd               _TIM1_SetCompare4:
5469                     ; 1742   TIM1->CCR4H = (uint8_t)(Compare4 >> 8);
5471  05bd 9e            	ld	a,xh
5472  05be c7526b        	ld	21099,a
5473                     ; 1743   TIM1->CCR4L = (uint8_t)(Compare4);
5475  05c1 9f            	ld	a,xl
5476  05c2 c7526c        	ld	21100,a
5477                     ; 1744 }
5480  05c5 81            	ret	
5516                     ; 1756 void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
5516                     ; 1757 {
5517                     	switch	.text
5518  05c6               _TIM1_SetIC1Prescaler:
5520  05c6 88            	push	a
5521       00000000      OFST:	set	0
5524                     ; 1759   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));
5526                     ; 1762   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
5526                     ; 1763                           | (uint8_t)TIM1_IC1Prescaler);
5528  05c7 c65258        	ld	a,21080
5529  05ca a4f3          	and	a,#243
5530  05cc 1a01          	or	a,(OFST+1,sp)
5531  05ce c75258        	ld	21080,a
5532                     ; 1764 }
5535  05d1 84            	pop	a
5536  05d2 81            	ret	
5572                     ; 1776 void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
5572                     ; 1777 {
5573                     	switch	.text
5574  05d3               _TIM1_SetIC2Prescaler:
5576  05d3 88            	push	a
5577       00000000      OFST:	set	0
5580                     ; 1780   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));
5582                     ; 1783   TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_ICxPSC))
5582                     ; 1784                           | (uint8_t)TIM1_IC2Prescaler);
5584  05d4 c65259        	ld	a,21081
5585  05d7 a4f3          	and	a,#243
5586  05d9 1a01          	or	a,(OFST+1,sp)
5587  05db c75259        	ld	21081,a
5588                     ; 1785 }
5591  05de 84            	pop	a
5592  05df 81            	ret	
5628                     ; 1797 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
5628                     ; 1798 {
5629                     	switch	.text
5630  05e0               _TIM1_SetIC3Prescaler:
5632  05e0 88            	push	a
5633       00000000      OFST:	set	0
5636                     ; 1801   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
5638                     ; 1804   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
5638                     ; 1805                           (uint8_t)TIM1_IC3Prescaler);
5640  05e1 c6525a        	ld	a,21082
5641  05e4 a4f3          	and	a,#243
5642  05e6 1a01          	or	a,(OFST+1,sp)
5643  05e8 c7525a        	ld	21082,a
5644                     ; 1806 }
5647  05eb 84            	pop	a
5648  05ec 81            	ret	
5684                     ; 1818 void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
5684                     ; 1819 {
5685                     	switch	.text
5686  05ed               _TIM1_SetIC4Prescaler:
5688  05ed 88            	push	a
5689       00000000      OFST:	set	0
5692                     ; 1822   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));
5694                     ; 1825   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_ICxPSC)) |
5694                     ; 1826                           (uint8_t)TIM1_IC4Prescaler);
5696  05ee c6525b        	ld	a,21083
5697  05f1 a4f3          	and	a,#243
5698  05f3 1a01          	or	a,(OFST+1,sp)
5699  05f5 c7525b        	ld	21083,a
5700                     ; 1827 }
5703  05f8 84            	pop	a
5704  05f9 81            	ret	
5756                     ; 1834 uint16_t TIM1_GetCapture1(void)
5756                     ; 1835 {
5757                     	switch	.text
5758  05fa               _TIM1_GetCapture1:
5760  05fa 5204          	subw	sp,#4
5761       00000004      OFST:	set	4
5764                     ; 1838   uint16_t tmpccr1 = 0;
5766                     ; 1839   uint8_t tmpccr1l=0, tmpccr1h=0;
5770                     ; 1841   tmpccr1h = TIM1->CCR1H;
5772  05fc c65265        	ld	a,21093
5773  05ff 6b02          	ld	(OFST-2,sp),a
5775                     ; 1842   tmpccr1l = TIM1->CCR1L;
5777  0601 c65266        	ld	a,21094
5778  0604 6b01          	ld	(OFST-3,sp),a
5780                     ; 1844   tmpccr1 = (uint16_t)(tmpccr1l);
5782  0606 5f            	clrw	x
5783  0607 97            	ld	xl,a
5784  0608 1f03          	ldw	(OFST-1,sp),x
5786                     ; 1845   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
5788  060a 5f            	clrw	x
5789  060b 7b02          	ld	a,(OFST-2,sp)
5790  060d 97            	ld	xl,a
5791  060e 7b04          	ld	a,(OFST+0,sp)
5792  0610 01            	rrwa	x,a
5793  0611 1a03          	or	a,(OFST-1,sp)
5794  0613 01            	rrwa	x,a
5796                     ; 1847   return (uint16_t)tmpccr1;
5800  0614 5b04          	addw	sp,#4
5801  0616 81            	ret	
5853                     ; 1855 uint16_t TIM1_GetCapture2(void)
5853                     ; 1856 {
5854                     	switch	.text
5855  0617               _TIM1_GetCapture2:
5857  0617 5204          	subw	sp,#4
5858       00000004      OFST:	set	4
5861                     ; 1859   uint16_t tmpccr2 = 0;
5863                     ; 1860   uint8_t tmpccr2l=0, tmpccr2h=0;
5867                     ; 1862   tmpccr2h = TIM1->CCR2H;
5869  0619 c65267        	ld	a,21095
5870  061c 6b02          	ld	(OFST-2,sp),a
5872                     ; 1863   tmpccr2l = TIM1->CCR2L;
5874  061e c65268        	ld	a,21096
5875  0621 6b01          	ld	(OFST-3,sp),a
5877                     ; 1865   tmpccr2 = (uint16_t)(tmpccr2l);
5879  0623 5f            	clrw	x
5880  0624 97            	ld	xl,a
5881  0625 1f03          	ldw	(OFST-1,sp),x
5883                     ; 1866   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
5885  0627 5f            	clrw	x
5886  0628 7b02          	ld	a,(OFST-2,sp)
5887  062a 97            	ld	xl,a
5888  062b 7b04          	ld	a,(OFST+0,sp)
5889  062d 01            	rrwa	x,a
5890  062e 1a03          	or	a,(OFST-1,sp)
5891  0630 01            	rrwa	x,a
5893                     ; 1868   return (uint16_t)tmpccr2;
5897  0631 5b04          	addw	sp,#4
5898  0633 81            	ret	
5950                     ; 1876 uint16_t TIM1_GetCapture3(void)
5950                     ; 1877 {
5951                     	switch	.text
5952  0634               _TIM1_GetCapture3:
5954  0634 5204          	subw	sp,#4
5955       00000004      OFST:	set	4
5958                     ; 1879   uint16_t tmpccr3 = 0;
5960                     ; 1880   uint8_t tmpccr3l=0, tmpccr3h=0;
5964                     ; 1882   tmpccr3h = TIM1->CCR3H;
5966  0636 c65269        	ld	a,21097
5967  0639 6b02          	ld	(OFST-2,sp),a
5969                     ; 1883   tmpccr3l = TIM1->CCR3L;
5971  063b c6526a        	ld	a,21098
5972  063e 6b01          	ld	(OFST-3,sp),a
5974                     ; 1885   tmpccr3 = (uint16_t)(tmpccr3l);
5976  0640 5f            	clrw	x
5977  0641 97            	ld	xl,a
5978  0642 1f03          	ldw	(OFST-1,sp),x
5980                     ; 1886   tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
5982  0644 5f            	clrw	x
5983  0645 7b02          	ld	a,(OFST-2,sp)
5984  0647 97            	ld	xl,a
5985  0648 7b04          	ld	a,(OFST+0,sp)
5986  064a 01            	rrwa	x,a
5987  064b 1a03          	or	a,(OFST-1,sp)
5988  064d 01            	rrwa	x,a
5990                     ; 1888   return (uint16_t)tmpccr3;
5994  064e 5b04          	addw	sp,#4
5995  0650 81            	ret	
6047                     ; 1896 uint16_t TIM1_GetCapture4(void)
6047                     ; 1897 {
6048                     	switch	.text
6049  0651               _TIM1_GetCapture4:
6051  0651 5204          	subw	sp,#4
6052       00000004      OFST:	set	4
6055                     ; 1899   uint16_t tmpccr4 = 0;
6057                     ; 1900   uint8_t tmpccr4l=0, tmpccr4h=0;
6061                     ; 1902   tmpccr4h = TIM1->CCR4H;
6063  0653 c6526b        	ld	a,21099
6064  0656 6b02          	ld	(OFST-2,sp),a
6066                     ; 1903   tmpccr4l = TIM1->CCR4L;
6068  0658 c6526c        	ld	a,21100
6069  065b 6b01          	ld	(OFST-3,sp),a
6071                     ; 1905   tmpccr4 = (uint16_t)(tmpccr4l);
6073  065d 5f            	clrw	x
6074  065e 97            	ld	xl,a
6075  065f 1f03          	ldw	(OFST-1,sp),x
6077                     ; 1906   tmpccr4 |= (uint16_t)((uint16_t)tmpccr4h << 8);
6079  0661 5f            	clrw	x
6080  0662 7b02          	ld	a,(OFST-2,sp)
6081  0664 97            	ld	xl,a
6082  0665 7b04          	ld	a,(OFST+0,sp)
6083  0667 01            	rrwa	x,a
6084  0668 1a03          	or	a,(OFST-1,sp)
6085  066a 01            	rrwa	x,a
6087                     ; 1908   return (uint16_t)tmpccr4;
6091  066b 5b04          	addw	sp,#4
6092  066d 81            	ret	
6126                     ; 1916 uint16_t TIM1_GetCounter(void)
6126                     ; 1917 {
6127                     	switch	.text
6128  066e               _TIM1_GetCounter:
6130  066e 89            	pushw	x
6131       00000002      OFST:	set	2
6134                     ; 1918   uint16_t tmpcntr = 0;
6136                     ; 1920   tmpcntr = ((uint16_t)TIM1->CNTRH << 8);
6138  066f c6525e        	ld	a,21086
6139  0672 97            	ld	xl,a
6140  0673 4f            	clr	a
6141  0674 02            	rlwa	x,a
6142  0675 1f01          	ldw	(OFST-1,sp),x
6144                     ; 1923   return (uint16_t)(tmpcntr | (uint16_t)(TIM1->CNTRL));
6146  0677 c6525f        	ld	a,21087
6147  067a 5f            	clrw	x
6148  067b 97            	ld	xl,a
6149  067c 01            	rrwa	x,a
6150  067d 1a02          	or	a,(OFST+0,sp)
6151  067f 01            	rrwa	x,a
6152  0680 1a01          	or	a,(OFST-1,sp)
6153  0682 01            	rrwa	x,a
6156  0683 5b02          	addw	sp,#2
6157  0685 81            	ret	
6191                     ; 1931 uint16_t TIM1_GetPrescaler(void)
6191                     ; 1932 {
6192                     	switch	.text
6193  0686               _TIM1_GetPrescaler:
6195  0686 89            	pushw	x
6196       00000002      OFST:	set	2
6199                     ; 1933   uint16_t temp = 0;
6201                     ; 1935   temp = ((uint16_t)TIM1->PSCRH << 8);
6203  0687 c65260        	ld	a,21088
6204  068a 97            	ld	xl,a
6205  068b 4f            	clr	a
6206  068c 02            	rlwa	x,a
6207  068d 1f01          	ldw	(OFST-1,sp),x
6209                     ; 1938   return (uint16_t)( temp | (uint16_t)(TIM1->PSCRL));
6211  068f c65261        	ld	a,21089
6212  0692 5f            	clrw	x
6213  0693 97            	ld	xl,a
6214  0694 01            	rrwa	x,a
6215  0695 1a02          	or	a,(OFST+0,sp)
6216  0697 01            	rrwa	x,a
6217  0698 1a01          	or	a,(OFST-1,sp)
6218  069a 01            	rrwa	x,a
6221  069b 5b02          	addw	sp,#2
6222  069d 81            	ret	
6396                     ; 1959 FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG)
6396                     ; 1960 {
6397                     	switch	.text
6398  069e               _TIM1_GetFlagStatus:
6400  069e 89            	pushw	x
6401  069f 89            	pushw	x
6402       00000002      OFST:	set	2
6405                     ; 1961   FlagStatus bitstatus = RESET;
6407                     ; 1962   uint8_t tim1_flag_l = 0, tim1_flag_h = 0;
6411                     ; 1965   assert_param(IS_TIM1_GET_FLAG_OK(TIM1_FLAG));
6413                     ; 1967   tim1_flag_l = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_FLAG);
6415  06a0 9f            	ld	a,xl
6416  06a1 c45255        	and	a,21077
6417  06a4 6b01          	ld	(OFST-1,sp),a
6419                     ; 1968   tim1_flag_h = (uint8_t)((uint16_t)TIM1_FLAG >> 8);
6421  06a6 7b03          	ld	a,(OFST+1,sp)
6422  06a8 6b02          	ld	(OFST+0,sp),a
6424                     ; 1970   if ((tim1_flag_l | (uint8_t)(TIM1->SR2 & tim1_flag_h)) != 0)
6426  06aa c45256        	and	a,21078
6427  06ad 1a01          	or	a,(OFST-1,sp)
6428  06af 2702          	jreq	L1433
6429                     ; 1972     bitstatus = SET;
6431  06b1 a601          	ld	a,#1
6434  06b3               L1433:
6435                     ; 1976     bitstatus = RESET;
6438                     ; 1978   return (FlagStatus)(bitstatus);
6442  06b3 5b04          	addw	sp,#4
6443  06b5 81            	ret	
6478                     ; 1999 void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG)
6478                     ; 2000 {
6479                     	switch	.text
6480  06b6               _TIM1_ClearFlag:
6482  06b6 89            	pushw	x
6483       00000000      OFST:	set	0
6486                     ; 2002   assert_param(IS_TIM1_CLEAR_FLAG_OK(TIM1_FLAG));
6488                     ; 2005   TIM1->SR1 = (uint8_t)(~(uint8_t)(TIM1_FLAG));
6490  06b7 9f            	ld	a,xl
6491  06b8 43            	cpl	a
6492  06b9 c75255        	ld	21077,a
6493                     ; 2006   TIM1->SR2 = (uint8_t)((uint8_t)(~((uint8_t)((uint16_t)TIM1_FLAG >> 8))) & 
6493                     ; 2007                         (uint8_t)0x1E);
6495  06bc 7b01          	ld	a,(OFST+1,sp)
6496  06be 43            	cpl	a
6497  06bf a41e          	and	a,#30
6498  06c1 c75256        	ld	21078,a
6499                     ; 2008 }
6502  06c4 85            	popw	x
6503  06c5 81            	ret	
6567                     ; 2024 ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
6567                     ; 2025 {
6568                     	switch	.text
6569  06c6               _TIM1_GetITStatus:
6571  06c6 88            	push	a
6572  06c7 89            	pushw	x
6573       00000002      OFST:	set	2
6576                     ; 2026   ITStatus bitstatus = RESET;
6578                     ; 2027   uint8_t TIM1_itStatus = 0, TIM1_itEnable = 0;
6582                     ; 2030   assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));
6584                     ; 2032   TIM1_itStatus = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_IT);
6586  06c8 c45255        	and	a,21077
6587  06cb 6b01          	ld	(OFST-1,sp),a
6589                     ; 2034   TIM1_itEnable = (uint8_t)(TIM1->IER & (uint8_t)TIM1_IT);
6591  06cd c65254        	ld	a,21076
6592  06d0 1403          	and	a,(OFST+1,sp)
6593  06d2 6b02          	ld	(OFST+0,sp),a
6595                     ; 2036   if ((TIM1_itStatus != (uint8_t)RESET ) && (TIM1_itEnable != (uint8_t)RESET ))
6597  06d4 7b01          	ld	a,(OFST-1,sp)
6598  06d6 2708          	jreq	L5143
6600  06d8 7b02          	ld	a,(OFST+0,sp)
6601  06da 2704          	jreq	L5143
6602                     ; 2038     bitstatus = SET;
6604  06dc a601          	ld	a,#1
6607  06de 2001          	jra	L7143
6608  06e0               L5143:
6609                     ; 2042     bitstatus = RESET;
6611  06e0 4f            	clr	a
6613  06e1               L7143:
6614                     ; 2044   return (ITStatus)(bitstatus);
6618  06e1 5b03          	addw	sp,#3
6619  06e3 81            	ret	
6655                     ; 2061 void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
6655                     ; 2062 {
6656                     	switch	.text
6657  06e4               _TIM1_ClearITPendingBit:
6661                     ; 2064   assert_param(IS_TIM1_IT_OK(TIM1_IT));
6663                     ; 2067   TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT);
6665  06e4 43            	cpl	a
6666  06e5 c75255        	ld	21077,a
6667                     ; 2068 }
6670  06e8 81            	ret	
6722                     ; 2086 static void TI1_Config(uint8_t TIM1_ICPolarity,
6722                     ; 2087                        uint8_t TIM1_ICSelection,
6722                     ; 2088                        uint8_t TIM1_ICFilter)
6722                     ; 2089 {
6723                     	switch	.text
6724  06e9               L3_TI1_Config:
6726  06e9 89            	pushw	x
6727  06ea 88            	push	a
6728       00000001      OFST:	set	1
6731                     ; 2091   TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
6733  06eb 7211525c      	bres	21084,#0
6734                     ; 2094   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
6734                     ; 2095                           (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
6736  06ef 7b06          	ld	a,(OFST+5,sp)
6737  06f1 97            	ld	xl,a
6738  06f2 a610          	ld	a,#16
6739  06f4 42            	mul	x,a
6740  06f5 9f            	ld	a,xl
6741  06f6 1a03          	or	a,(OFST+2,sp)
6742  06f8 6b01          	ld	(OFST+0,sp),a
6744  06fa c65258        	ld	a,21080
6745  06fd a40c          	and	a,#12
6746  06ff 1a01          	or	a,(OFST+0,sp)
6747  0701 c75258        	ld	21080,a
6748                     ; 2098   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
6750  0704 7b02          	ld	a,(OFST+1,sp)
6751  0706 2706          	jreq	L5643
6752                     ; 2100     TIM1->CCER1 |= TIM1_CCER1_CC1P;
6754  0708 7212525c      	bset	21084,#1
6756  070c 2004          	jra	L7643
6757  070e               L5643:
6758                     ; 2104     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
6760  070e 7213525c      	bres	21084,#1
6761  0712               L7643:
6762                     ; 2108   TIM1->CCER1 |=  TIM1_CCER1_CC1E;
6764  0712 7210525c      	bset	21084,#0
6765                     ; 2109 }
6768  0716 5b03          	addw	sp,#3
6769  0718 81            	ret	
6821                     ; 2127 static void TI2_Config(uint8_t TIM1_ICPolarity,
6821                     ; 2128                        uint8_t TIM1_ICSelection,
6821                     ; 2129                        uint8_t TIM1_ICFilter)
6821                     ; 2130 {
6822                     	switch	.text
6823  0719               L5_TI2_Config:
6825  0719 89            	pushw	x
6826  071a 88            	push	a
6827       00000001      OFST:	set	1
6830                     ; 2132   TIM1->CCER1 &=  (uint8_t)(~TIM1_CCER1_CC2E);
6832  071b 7219525c      	bres	21084,#4
6833                     ; 2135   TIM1->CCMR2  = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) 
6833                     ; 2136                            | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
6835  071f 7b06          	ld	a,(OFST+5,sp)
6836  0721 97            	ld	xl,a
6837  0722 a610          	ld	a,#16
6838  0724 42            	mul	x,a
6839  0725 9f            	ld	a,xl
6840  0726 1a03          	or	a,(OFST+2,sp)
6841  0728 6b01          	ld	(OFST+0,sp),a
6843  072a c65259        	ld	a,21081
6844  072d a40c          	and	a,#12
6845  072f 1a01          	or	a,(OFST+0,sp)
6846  0731 c75259        	ld	21081,a
6847                     ; 2138   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
6849  0734 7b02          	ld	a,(OFST+1,sp)
6850  0736 2706          	jreq	L7153
6851                     ; 2140     TIM1->CCER1 |= TIM1_CCER1_CC2P;
6853  0738 721a525c      	bset	21084,#5
6855  073c 2004          	jra	L1253
6856  073e               L7153:
6857                     ; 2144     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
6859  073e 721b525c      	bres	21084,#5
6860  0742               L1253:
6861                     ; 2147   TIM1->CCER1 |=  TIM1_CCER1_CC2E;
6863  0742 7218525c      	bset	21084,#4
6864                     ; 2148 }
6867  0746 5b03          	addw	sp,#3
6868  0748 81            	ret	
6920                     ; 2166 static void TI3_Config(uint8_t TIM1_ICPolarity,
6920                     ; 2167                        uint8_t TIM1_ICSelection,
6920                     ; 2168                        uint8_t TIM1_ICFilter)
6920                     ; 2169 {
6921                     	switch	.text
6922  0749               L7_TI3_Config:
6924  0749 89            	pushw	x
6925  074a 88            	push	a
6926       00000001      OFST:	set	1
6929                     ; 2171   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC3E);
6931  074b 7211525d      	bres	21085,#0
6932                     ; 2174   TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF))) 
6932                     ; 2175                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
6934  074f 7b06          	ld	a,(OFST+5,sp)
6935  0751 97            	ld	xl,a
6936  0752 a610          	ld	a,#16
6937  0754 42            	mul	x,a
6938  0755 9f            	ld	a,xl
6939  0756 1a03          	or	a,(OFST+2,sp)
6940  0758 6b01          	ld	(OFST+0,sp),a
6942  075a c6525a        	ld	a,21082
6943  075d a40c          	and	a,#12
6944  075f 1a01          	or	a,(OFST+0,sp)
6945  0761 c7525a        	ld	21082,a
6946                     ; 2178   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
6948  0764 7b02          	ld	a,(OFST+1,sp)
6949  0766 2706          	jreq	L1553
6950                     ; 2180     TIM1->CCER2 |= TIM1_CCER2_CC3P;
6952  0768 7212525d      	bset	21085,#1
6954  076c 2004          	jra	L3553
6955  076e               L1553:
6956                     ; 2184     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
6958  076e 7213525d      	bres	21085,#1
6959  0772               L3553:
6960                     ; 2187   TIM1->CCER2 |=  TIM1_CCER2_CC3E;
6962  0772 7210525d      	bset	21085,#0
6963                     ; 2188 }
6966  0776 5b03          	addw	sp,#3
6967  0778 81            	ret	
7019                     ; 2206 static void TI4_Config(uint8_t TIM1_ICPolarity,
7019                     ; 2207                        uint8_t TIM1_ICSelection,
7019                     ; 2208                        uint8_t TIM1_ICFilter)
7019                     ; 2209 {
7020                     	switch	.text
7021  0779               L11_TI4_Config:
7023  0779 89            	pushw	x
7024  077a 88            	push	a
7025       00000001      OFST:	set	1
7028                     ; 2211   TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC4E);
7030  077b 7219525d      	bres	21085,#4
7031                     ; 2214   TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF )))
7031                     ; 2215                           | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7033  077f 7b06          	ld	a,(OFST+5,sp)
7034  0781 97            	ld	xl,a
7035  0782 a610          	ld	a,#16
7036  0784 42            	mul	x,a
7037  0785 9f            	ld	a,xl
7038  0786 1a03          	or	a,(OFST+2,sp)
7039  0788 6b01          	ld	(OFST+0,sp),a
7041  078a c6525b        	ld	a,21083
7042  078d a40c          	and	a,#12
7043  078f 1a01          	or	a,(OFST+0,sp)
7044  0791 c7525b        	ld	21083,a
7045                     ; 2218   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7047  0794 7b02          	ld	a,(OFST+1,sp)
7048  0796 2706          	jreq	L3063
7049                     ; 2220     TIM1->CCER2 |= TIM1_CCER2_CC4P;
7051  0798 721a525d      	bset	21085,#5
7053  079c 2004          	jra	L5063
7054  079e               L3063:
7055                     ; 2224     TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
7057  079e 721b525d      	bres	21085,#5
7058  07a2               L5063:
7059                     ; 2228   TIM1->CCER2 |=  TIM1_CCER2_CC4E;
7061  07a2 7218525d      	bset	21085,#4
7062                     ; 2229 }
7065  07a6 5b03          	addw	sp,#3
7066  07a8 81            	ret	
7079                     	xdef	_TIM1_ClearITPendingBit
7080                     	xdef	_TIM1_GetITStatus
7081                     	xdef	_TIM1_ClearFlag
7082                     	xdef	_TIM1_GetFlagStatus
7083                     	xdef	_TIM1_GetPrescaler
7084                     	xdef	_TIM1_GetCounter
7085                     	xdef	_TIM1_GetCapture4
7086                     	xdef	_TIM1_GetCapture3
7087                     	xdef	_TIM1_GetCapture2
7088                     	xdef	_TIM1_GetCapture1
7089                     	xdef	_TIM1_SetIC4Prescaler
7090                     	xdef	_TIM1_SetIC3Prescaler
7091                     	xdef	_TIM1_SetIC2Prescaler
7092                     	xdef	_TIM1_SetIC1Prescaler
7093                     	xdef	_TIM1_SetCompare4
7094                     	xdef	_TIM1_SetCompare3
7095                     	xdef	_TIM1_SetCompare2
7096                     	xdef	_TIM1_SetCompare1
7097                     	xdef	_TIM1_SetAutoreload
7098                     	xdef	_TIM1_SetCounter
7099                     	xdef	_TIM1_SelectOCxM
7100                     	xdef	_TIM1_CCxNCmd
7101                     	xdef	_TIM1_CCxCmd
7102                     	xdef	_TIM1_OC4PolarityConfig
7103                     	xdef	_TIM1_OC3NPolarityConfig
7104                     	xdef	_TIM1_OC3PolarityConfig
7105                     	xdef	_TIM1_OC2NPolarityConfig
7106                     	xdef	_TIM1_OC2PolarityConfig
7107                     	xdef	_TIM1_OC1NPolarityConfig
7108                     	xdef	_TIM1_OC1PolarityConfig
7109                     	xdef	_TIM1_GenerateEvent
7110                     	xdef	_TIM1_OC4FastConfig
7111                     	xdef	_TIM1_OC3FastConfig
7112                     	xdef	_TIM1_OC2FastConfig
7113                     	xdef	_TIM1_OC1FastConfig
7114                     	xdef	_TIM1_OC4PreloadConfig
7115                     	xdef	_TIM1_OC3PreloadConfig
7116                     	xdef	_TIM1_OC2PreloadConfig
7117                     	xdef	_TIM1_OC1PreloadConfig
7118                     	xdef	_TIM1_CCPreloadControl
7119                     	xdef	_TIM1_SelectCOM
7120                     	xdef	_TIM1_ARRPreloadConfig
7121                     	xdef	_TIM1_ForcedOC4Config
7122                     	xdef	_TIM1_ForcedOC3Config
7123                     	xdef	_TIM1_ForcedOC2Config
7124                     	xdef	_TIM1_ForcedOC1Config
7125                     	xdef	_TIM1_CounterModeConfig
7126                     	xdef	_TIM1_PrescalerConfig
7127                     	xdef	_TIM1_EncoderInterfaceConfig
7128                     	xdef	_TIM1_SelectMasterSlaveMode
7129                     	xdef	_TIM1_SelectSlaveMode
7130                     	xdef	_TIM1_SelectOutputTrigger
7131                     	xdef	_TIM1_SelectOnePulseMode
7132                     	xdef	_TIM1_SelectHallSensor
7133                     	xdef	_TIM1_UpdateRequestConfig
7134                     	xdef	_TIM1_UpdateDisableConfig
7135                     	xdef	_TIM1_SelectInputTrigger
7136                     	xdef	_TIM1_TIxExternalClockConfig
7137                     	xdef	_TIM1_ETRConfig
7138                     	xdef	_TIM1_ETRClockMode2Config
7139                     	xdef	_TIM1_ETRClockMode1Config
7140                     	xdef	_TIM1_InternalClockConfig
7141                     	xdef	_TIM1_ITConfig
7142                     	xdef	_TIM1_CtrlPWMOutputs
7143                     	xdef	_TIM1_Cmd
7144                     	xdef	_TIM1_PWMIConfig
7145                     	xdef	_TIM1_ICInit
7146                     	xdef	_TIM1_BDTRConfig
7147                     	xdef	_TIM1_OC4Init
7148                     	xdef	_TIM1_OC3Init
7149                     	xdef	_TIM1_TimeBaseInit
7150                     	xdef	_TIM1_DeInit
7169                     	end
