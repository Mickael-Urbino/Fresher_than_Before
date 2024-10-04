/**
  ******************************************************************************
  * @file    stm8s_tim1.c
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all the functions for the TIM1 peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s_tim1.h"

/** @addtogroup STM8S_StdPeriph_Driver
  * @{
  */
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/**
  * @addtogroup TIM1_Public_Functions
  * @{
  */

/**
  * @brief  Deinitializes the TIM1 peripheral registers to their default reset values.
  * @param  None
  * @retval None
  */
void TIM1_DeInit(void)
{
  TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  TIM1->IER  = TIM1_IER_RESET_VALUE;
  TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  /* Disable channels */
  TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  /* Configure channels as inputs: it is necessary if lock level is equal to 2 or 3 */
  TIM1->CCMR1 = 0x01;
  TIM1->CCMR2 = 0x01;
  TIM1->CCMR3 = 0x01;
  TIM1->CCMR4 = 0x01;
  /* Then reset channel registers: it also works if lock level is equal to 2 or 3 */
  TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
  TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
  TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
  TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
  TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
  TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
  TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
  TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
  TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
  TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
  TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
  TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
  TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
  TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
  TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
  TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
  TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
  TIM1->OISR  = TIM1_OISR_RESET_VALUE;
  TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
  TIM1->DTR   = TIM1_DTR_RESET_VALUE;
  TIM1->BKR   = TIM1_BKR_RESET_VALUE;
  TIM1->RCR   = TIM1_RCR_RESET_VALUE;
  TIM1->SR1   = TIM1_SR1_RESET_VALUE;
}

/**
  * @brief  Initializes the TIM1 Time Base Unit according to the specified parameters.
  * @param  TIM1_Prescaler specifies the Prescaler value.
  * @param  TIM1_CounterMode specifies the counter mode  from @ref TIM1_CounterMode_TypeDef .
  * @param  TIM1_Period specifies the Period value.
  * @param  TIM1_RepetitionCounter specifies the Repetition counter value
  * @retval None
  */
void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
                       TIM1_CounterMode_TypeDef TIM1_CounterMode,
                       uint16_t TIM1_Period,
                       uint8_t TIM1_RepetitionCounter)
{
  /* Check parameters */
  assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
  
  /* Set the Autoreload value */
  TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
  TIM1->ARRL = (uint8_t)(TIM1_Period);
  
  /* Set the Prescaler value */
  TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
  TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
  
  /* Select the Counter Mode */
  TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
                        | (uint8_t)(TIM1_CounterMode));
  
  /* Set the Repetition Counter value */
  TIM1->RCR = TIM1_RepetitionCounter;
}

/**
  * @brief  Initializes the TIM1 Channel1 according to the specified parameters.
  * @param  TIM1_OCMode specifies the Output Compare mode from 
  *         @ref TIM1_OCMode_TypeDef.
  * @param  TIM1_OutputState specifies the Output State from 
  *         @ref TIM1_OutputState_TypeDef.
  * @param  TIM1_OutputNState specifies the Complementary Output State 
  *         from @ref TIM1_OutputNState_TypeDef.
  * @param  TIM1_Pulse specifies the Pulse width value.
  * @param  TIM1_OCPolarity specifies the Output Compare Polarity from 
  *         @ref TIM1_OCPolarity_TypeDef.
  * @param  TIM1_OCNPolarity specifies the Complementary Output Compare Polarity
  *         from @ref TIM1_OCNPolarity_TypeDef.
  * @param  TIM1_OCIdleState specifies the Output Compare Idle State from 
  *         @ref TIM1_OCIdleState_TypeDef.
  * @param  TIM1_OCNIdleState specifies the Complementary Output Compare Idle 
  *         State from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */
/**
  * @brief  Initializes the TIM1 Channel2 according to the specified parameters.
  * @param  TIM1_OCMode specifies the Output Compare mode from
  *         @ref TIM1_OCMode_TypeDef.
  * @param  TIM1_OutputState specifies the Output State from 
  *         @ref TIM1_OutputState_TypeDef.
  * @param  TIM1_OutputNState specifies the Complementary Output State from 
  *         @ref TIM1_OutputNState_TypeDef.
  * @param  TIM1_Pulse specifies the Pulse width value.
  * @param  TIM1_OCPolarity specifies the Output Compare Polarity from 
  *         @ref TIM1_OCPolarity_TypeDef.
  * @param  TIM1_OCNPolarity specifies the Complementary Output Compare Polarity
  *         from @ref TIM1_OCNPolarity_TypeDef.
  * @param  TIM1_OCIdleState specifies the Output Compare Idle State from 
  *         @ref TIM1_OCIdleState_TypeDef.
  * @param  TIM1_OCNIdleState specifies the Complementary Output Compare Idle 
  *         State from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */

/**
  * @brief  Initializes the TIM1 Channel3 according to the specified parameters.
  * @param  TIM1_OCMode specifies the Output Compare mode  from 
  *         @ref TIM1_OCMode_TypeDef.
  * @param  TIM1_OutputState specifies the Output State  
  *         from @ref TIM1_OutputState_TypeDef.
  * @param  TIM1_OutputNState specifies the Complementary Output State
  *         from @ref TIM1_OutputNState_TypeDef.
  * @param  TIM1_Pulse specifies the Pulse width value.
  * @param  TIM1_OCPolarity specifies the Output Compare Polarity  from 
  *         @ref TIM1_OCPolarity_TypeDef.
  * @param  TIM1_OCNPolarity specifies the Complementary  Output Compare 
  *         Polarity from @ref TIM1_OCNPolarity_TypeDef.
  * @param  TIM1_OCIdleState specifies the Output Compare Idle State
  *         from @ref TIM1_OCIdleState_TypeDef.
  * @param  TIM1_OCNIdleState specifies the Complementary Output Compare 
  *         Idle State  from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */
void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
                  TIM1_OutputState_TypeDef TIM1_OutputState,
                  TIM1_OutputNState_TypeDef TIM1_OutputNState,
                  uint16_t TIM1_Pulse,
                  TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
                  TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
                  TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
{
  /* Check the parameters */
  assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
  assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
  assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
  assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
  assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
  assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
  assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
  
  /* Disable the Channel 1: Reset the CCE Bit, Set the Output State , 
  the Output N State, the Output Polarity & the Output N Polarity*/
  TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
                             TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
  /* Set the Output State & Set the Output N State & Set the Output Polarity &
  Set the Output N Polarity */
  TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
                                     (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
                           (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
                                     (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
  
  /* Reset the Output Compare Bits & Set the Output Compare Mode */
  TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
                          (uint8_t)TIM1_OCMode);
  
  /* Reset the Output Idle state & the Output N Idle state bits */
  TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
  /* Set the Output Idle state & the Output N Idle state configuration */
  TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
                          (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
  
  /* Set the Pulse value */
  TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
  TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
}

/**
  * @brief  Initializes the TIM1 Channel4 according to the specified parameters.
  * @param  TIM1_OCMode specifies the Output Compare mode  from 
  *         @ref TIM1_OCMode_TypeDef.
  * @param  TIM1_OutputState specifies the Output State
  *         from @ref TIM1_OutputState_TypeDef.
  * @param  TIM1_Pulse specifies the Pulse width  value.
  * @param  TIM1_OCPolarity specifies the Output Compare Polarity
  *         from @ref TIM1_OCPolarity_TypeDef.
  * @param  TIM1_OCIdleState specifies the Output Compare Idle State
  *         from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */

/**
  * @brief  Configures the Break feature, dead time, Lock level, the OSSI,
  *         and the AOE(automatic output enable).
  * @param  TIM1_OSSIState specifies the OSSIS State from @ref TIM1_OSSIState_TypeDef.
  * @param  TIM1_LockLevel specifies the lock level from @ref TIM1_LockLevel_TypeDef.
  * @param  TIM1_DeadTime specifies the dead time value.
  * @param  TIM1_Break specifies the Break state @ref TIM1_BreakState_TypeDef.
  * @param  TIM1_BreakPolarity specifies the Break polarity from 
  *         @ref TIM1_BreakPolarity_TypeDef.
  * @param  TIM1_AutomaticOutput specifies the Automatic Output configuration 
  *         from @ref TIM1_AutomaticOutput_TypeDef.
  * @retval None
  */
void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
                     TIM1_LockLevel_TypeDef TIM1_LockLevel,
                     uint8_t TIM1_DeadTime,
                     TIM1_BreakState_TypeDef TIM1_Break,
                     TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
                     TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
{
  /* Check the parameters */
  assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
  assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
  assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
  assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
  assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
  
  TIM1->DTR = (uint8_t)(TIM1_DeadTime);
  /* Set the Lock level, the Break enable Bit and the Polarity, the OSSI State,
  the dead time value  and the Automatic Output Enable Bit */
  
  TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
                          (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
                          (uint8_t)TIM1_AutomaticOutput));
}

/**
  * @brief  Initializes the TIM1 peripheral according to the specified parameters.
  * @param  TIM1_Channel specifies the input capture channel from TIM1_Channel_TypeDef.
  * @param  TIM1_ICPolarity specifies the Input capture polarity from  
  *         TIM1_ICPolarity_TypeDef .
  * @param  TIM1_ICSelection specifies the Input capture source selection from 
  *         TIM1_ICSelection_TypeDef.
  * @param  TIM1_ICPrescaler specifies the Input capture Prescaler from
  *         TIM1_ICPSC_TypeDef.
  * @param  TIM1_ICFilter specifies the Input capture filter value.
  * @retval None
  */

/**
  * @brief  Enables or disables the TIM1 peripheral.
  * @param  NewState new state of the TIM1 peripheral.
  *         This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_Cmd(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* set or Reset the CEN Bit */
  if (NewState != DISABLE)
  {
    TIM1->CR1 |= TIM1_CR1_CEN;
  }
  else
  {
    TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
  }
}

/**
  * @brief  Enables or disables the TIM1 peripheral Main Outputs.
  * @param  NewState new state of the TIM1 peripheral.
  *         This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_CtrlPWMOutputs(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the MOE Bit */
  
  if (NewState != DISABLE)
  {
    TIM1->BKR |= TIM1_BKR_MOE;
  }
  else
  {
    TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
  }
}

/**
  * @brief  Enables or disables the specified TIM1 interrupts.
  * @param  NewState new state of the TIM1 peripheral.
  *         This parameter can be: ENABLE or DISABLE.
  * @param  TIM1_IT specifies the TIM1 interrupts sources to be enabled or disabled.
  *         This parameter can be any combination of the following values:
  *           - TIM1_IT_UPDATE: TIM1 update Interrupt source
  *           - TIM1_IT_CC1: TIM1 Capture Compare 1 Interrupt source
  *           - TIM1_IT_CC2: TIM1 Capture Compare 2 Interrupt source
  *           - TIM1_IT_CC3: TIM1 Capture Compare 3 Interrupt source
  *           - TIM1_IT_CC4: TIM1 Capture Compare 4 Interrupt source
  *           - TIM1_IT_CCUpdate: TIM1 Capture Compare Update Interrupt source
  *           - TIM1_IT_TRIGGER: TIM1 Trigger Interrupt source
  *           - TIM1_IT_BREAK: TIM1 Break Interrupt source
  * @param  NewState new state of the TIM1 peripheral.
  * @retval None
  */
void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_TIM1_IT_OK(TIM1_IT));
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  if (NewState != DISABLE)
  {
    /* Enable the Interrupt sources */
    TIM1->IER |= (uint8_t)TIM1_IT;
  }
  else
  {
    /* Disable the Interrupt sources */
    TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
  }
}

/**
  * @brief  Configures the TIM1 internal Clock.
  * @param  None
  * @retval None
  */
void TIM1_InternalClockConfig(void)
{
  /* Disable slave mode to clock the prescaler directly with the internal clock */
  TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
}

/**
  * @brief  Configures the TIM1 External clock Mode1.
  * @param  TIM1_ExtTRGPrescaler specifies the external Trigger Prescaler.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPSC_OFF
  *                       - TIM1_EXTTRGPSC_DIV2
  *                       - TIM1_EXTTRGPSC_DIV4
  *                       - TIM1_EXTTRGPSC_DIV8.
  * @param  TIM1_ExtTRGPolarity specifies the external Trigger Polarity.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPOLARITY_INVERTED
  *                       - TIM1_EXTTRGPOLARITY_NONINVERTED
  * @param  ExtTRGFilter specifies the External Trigger Filter.
  *         This parameter must be a value between 0x00 and 0x0F
  * @retval None
  */
void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
                              TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
                              uint8_t ExtTRGFilter)
{
  /* Check the parameters */
  assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
  assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
  
  /* Configure the ETR Clock source */
  TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
  
  /* Select the External clock mode1 & Select the Trigger selection : ETRF */
  TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
                         | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
}

/**
  * @brief  Configures the TIM1 External clock Mode2.
  * @param  TIM1_ExtTRGPrescaler specifies the external Trigger Prescaler.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPSC_OFF
  *                       - TIM1_EXTTRGPSC_DIV2
  *                       - TIM1_EXTTRGPSC_DIV4
  *                       - TIM1_EXTTRGPSC_DIV8.
  * @param  TIM1_ExtTRGPolarity specifies the external Trigger Polarity.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPOLARITY_INVERTED
  *                       - TIM1_EXTTRGPOLARITY_NONINVERTED
  * @param  ExtTRGFilter specifies the External Trigger Filter.
  *         This parameter must be a value between 0x00 and 0x0F
  * @retval None
  */
void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
                              TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
                              uint8_t ExtTRGFilter)
{
  /* Check the parameters */
  assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
  assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
  
  /* Configure the ETR Clock source */
  TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
  
  /* Enable the External clock mode2 */
  TIM1->ETR |= TIM1_ETR_ECE;
}

/**
  * @brief  Configures the TIM1 External Trigger.
  * @param  TIM1_ExtTRGPrescaler specifies the external Trigger Prescaler.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPSC_OFF
  *                       - TIM1_EXTTRGPSC_DIV2
  *                       - TIM1_EXTTRGPSC_DIV4
  *                       - TIM1_EXTTRGPSC_DIV8.
  * @param  TIM1_ExtTRGPolarity specifies the external Trigger Polarity.
  *         This parameter can be one of the following values:
  *                       - TIM1_EXTTRGPOLARITY_INVERTED
  *                       - TIM1_EXTTRGPOLARITY_NONINVERTED
  * @param  ExtTRGFilter specifies the External Trigger Filter.
  *         This parameter must be a value between 0x00 and 0x0F
  * @retval None
  */
void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
                    TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
                    uint8_t ExtTRGFilter)
{
  /* Check the parameters */
  assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
  /* Set the Prescaler, the Filter value and the Polarity */
  TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
                         (uint8_t)ExtTRGFilter );
}

/**
  * @brief  Configures the TIM1 Trigger as External Clock.
  * @param  TIM1_TIxExternalCLKSource specifies Trigger source.
  *         This parameter can be one of the following values:
  *                     - TIM1_TIXEXTERNALCLK1SOURCE_TI1: TI1 Edge Detector
  *                     - TIM1_TIXEXTERNALCLK1SOURCE_TI2: Filtered TIM1 Input 1
  *                     - TIM1_TIXEXTERNALCLK1SOURCE_TI1ED: Filtered TIM1 Input 2
  * @param  TIM1_ICPolarity specifies the TIx Polarity.
  *         This parameter can be:
  *                     - TIM1_ICPOLARITY_RISING
  *                     - TIM1_ICPOLARITY_FALLING
  * @param  ICFilter specifies the filter value.
  *         This parameter must be a value between 0x00 and 0x0F
  * @retval None
  */

/**
  * @brief  Selects the TIM1 Input Trigger source.
  * @param   TIM1_InputTriggerSource specifies Input Trigger source.
  * This parameter can be one of the following values:
  *                       - TIM1_TS_TI1F_ED: TI1 Edge Detector
  *                       - TIM1_TS_TI1FP1: Filtered Timer Input 1
  *                       - TIM1_TS_TI2FP2: Filtered Timer Input 2
  *                       - TIM1_TS_ETRF: External Trigger input
  * @retval None
  */
void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
{
  /* Check the parameters */
  assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
  
  /* Select the Tgigger Source */
  TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
}

/**
  * @brief  Enables or Disables the TIM1 Update event.
  * @param   NewState new state of the TIM1 peripheral Preload register. This parameter can
  * be ENABLE or DISABLE.
  * @retval None
  */

void TIM1_UpdateDisableConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the UDIS Bit */
  if (NewState != DISABLE)
  {
    TIM1->CR1 |= TIM1_CR1_UDIS;
  }
  else
  {
    TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
  }
}

/**
  * @brief  Selects the TIM1 Update Request Interrupt source.
  * @param   TIM1_UpdateSource specifies the Update source.
  * This parameter can be one of the following values
  *                       - TIM1_UPDATESOURCE_REGULAR
  *                       - TIM1_UPDATESOURCE_GLOBAL
  * @retval None
  */
void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
{
  /* Check the parameters */
  assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
  
  /* Set or Reset the URS Bit */
  if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
  {
    TIM1->CR1 |= TIM1_CR1_URS;
  }
  else
  {
    TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
  }
}

/**
  * @brief  Selects the TIM1 Trigger Output Mode.
  * @param   TIM1_TRGOSource specifies the Trigger Output source.
  * This parameter can be one of the following values
  *                       - TIM1_TRGOSOURCE_RESET
  *                       - TIM1_TRGOSOURCE_ENABLE
  *                       - TIM1_TRGOSOURCE_UPDATE
  *                       - TIM1_TRGOSource_OC1
  *                       - TIM1_TRGOSOURCE_OC1REF
  *                       - TIM1_TRGOSOURCE_OC2REF
  *                       - TIM1_TRGOSOURCE_OC3REF
  * @retval None
  */
void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
{
  /* Check the parameters */
  assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
  
  /* Reset the MMS Bits & Select the TRGO source */
  TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
                        (uint8_t) TIM1_TRGOSource);
}

/**
  * @brief  Selects the TIM1 Slave Mode.
  * @param   TIM1_SlaveMode specifies the TIM1 Slave Mode.
  * This parameter can be one of the following values
  *                       - TIM1_SLAVEMODE_RESET
  *                       - TIM1_SLAVEMODE_GATED
  *                       - TIM1_SLAVEMODE_TRIGGER
  *                       - TIM1_SLAVEMODE_EXTERNAL1
  * @retval None
  */
void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
{
  /* Check the parameters */
  assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
  
  /* Reset the SMS Bits */ /* Select the Slave Mode */
  TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
                         (uint8_t)TIM1_SlaveMode);
}

/**
  * @brief  Sets or Resets the TIM1 Master/Slave Mode.
  * @param   NewState new state of the synchronization between TIM1 and its slaves
  *  (through TRGO). This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the MSM Bit */
  if (NewState != DISABLE)
  {
    TIM1->SMCR |= TIM1_SMCR_MSM;
  }
  else
  {
    TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
  }
}

/**
  * @brief  Configures the TIM1 Prescaler.
  * @param   Prescaler specifies the Prescaler Register value
  * This parameter must be a value between 0x0000 and 0xFFFF
  * @param   TIM1_PSCReloadMode specifies the TIM1 Prescaler Reload mode.
  * This parameter can be one of the following values
  * - TIM1_PSCRELOADMODE_IMMEDIATE: The Prescaler is loaded immediately.
  * - TIM1_PSCRELOADMODE_UPDATE: The Prescaler is loaded at the update event.
  * @retval None
  */
void TIM1_PrescalerConfig(uint16_t Prescaler,
                          TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
{
  /* Check the parameters */
  assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
  
  /* Set the Prescaler value */
  TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
  TIM1->PSCRL = (uint8_t)(Prescaler);
  
  /* Set or reset the UG Bit */
  TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
}

/**
  * @brief  Specifies the TIM1 Counter Mode to be used.
  * @param   TIM1_CounterMode specifies the Counter Mode to be used
  * This parameter can be one of the following values:
  * - TIM1_COUNTERMODE_UP: TIM1 Up Counting Mode
  * - TIM1_COUNTERMODE_DOWN: TIM1 Down Counting Mode
  * - TIM1_COUNTERMODE_CENTERALIGNED1: TIM1 Center Aligned Mode1
  * - TIM1_CounterMode_CenterAligned2: TIM1 Center Aligned Mode2
  * - TIM1_COUNTERMODE_CENTERALIGNED3: TIM1 Center Aligned Mode3
  * @retval None
  */
void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
{
  /* Check the parameters */
  assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
  
  
  /* Reset the CMS and DIR Bits & Set the Counter Mode */
  TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
                        | (uint8_t)TIM1_CounterMode);
}

/**
  * @brief  Forces the TIM1 Channel3 output waveform to active or inactive level.
  * @param   TIM1_ForcedAction specifies the forced Action to be set to the output waveform.
  * This parameter can be one of the following values:
  *                       - TIM1_FORCEDACTION_ACTIVE: Force active level on OC3REF
  *                       - TIM1_FORCEDACTION_INACTIVE: Force inactive level on
  *                         OC3REF.
  * @retval None
  */
void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
{
  /* Check the parameters */
  assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
  
  /* Reset the OCM Bits */ /* Configure The Forced output Mode */
  TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
                            | (uint8_t)TIM1_ForcedAction);
}

/**
  * @brief  Enables or disables TIM1 peripheral Preload register on ARR.
  * @param   NewState new state of the TIM1 peripheral Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_ARRPreloadConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the ARPE Bit */
  if (NewState != DISABLE)
  {
    TIM1->CR1 |= TIM1_CR1_ARPE;
  }
  else
  {
    TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
  }
}

/**
  * @brief  Enables or disables the TIM1 peripheral Preload Register on CCR3.
  * @param   NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_OC3PreloadConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the OC3PE Bit */
  if (NewState != DISABLE)
  {
    TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
  }
  else
  {
    TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
  }
}


/**
  * @brief  Configures the TIM1 Capture Compare 1 Fast feature.
  * @param   NewState new state of the Output Compare Fast Enable bit.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_OC1FastConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the OC1FE Bit */
  if (NewState != DISABLE)
  {
    TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
  }
  else
  {
    TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
  }
}

/**
  * @brief  Configures the TIM1 Capture Compare 2 Fast feature.
  * @param   NewState new state of the Output Compare Fast Enable bit.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_OC2FastConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the OC2FE Bit */
  if (NewState != DISABLE)
  {
    TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
  }
  else
  {
    TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
  }
}

/**
  * @brief  Configures the TIM1 Capture Compare 3 Fast feature.
  * @param   NewState new state of the Output Compare Fast Enable bit.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_OC3FastConfig(FunctionalState NewState)
{
  /* Check the parameters */
  assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  
  /* Set or Reset the OC3FE Bit */
  if (NewState != DISABLE)
  {
    TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
  }
  else
  {
    TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
  }
}

/**
  * @brief  Configures the TIM1 event to be generated by software.
  * @param   TIM1_EventSource specifies the event source.
  * This parameter can be one of the following values:
  *                       - TIM1_EVENTSOURCE_UPDATE: TIM1 update Event source
  *                       - TIM1_EVENTSOURCE_CC1: TIM1 Capture Compare 1 Event source
  *                       - TIM1_EVENTSOURCE_CC2: TIM1 Capture Compare 2 Event source
  *                       - TIM1_EVENTSOURCE_CC3: TIM1 Capture Compare 3 Event source
  *                       - TIM1_EVENTSOURCE_CC4: TIM1 Capture Compare 4 Event source
  *                       - TIM1_EVENTSOURCE_COM: TIM1 COM Event source
  *                       - TIM1_EVENTSOURCE_TRIGGER: TIM1 Trigger Event source
  *                       - TIM1_EventSourceBreak: TIM1 Break Event source
  * @retval None
  */
void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
{
  /* Check the parameters */
  assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
  
  /* Set the event sources */
  TIM1->EGR = (uint8_t)TIM1_EventSource;
}

/**
  * @brief  Configures the TIM1 Channel 1 polarity.
  * @param   TIM1_OCPolarity specifies the OC1 Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_OCPOLARITY_LOW: Output Compare active low
  *                       - TIM1_OCPOLARITY_HIGH: Output Compare active high
  * @retval None
  */
void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
{
  /* Check the parameters */
  assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
  
  /* Set or Reset the CC1P Bit */
  if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
  {
    TIM1->CCER1 |= TIM1_CCER1_CC1P;
  }
  else
  {
    TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
  }
}



/**
  * @brief  Configures the TIM1 Channel 3 polarity.
  * @param   TIM1_OCPolarity specifies the OC3 Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_OCPOLARITY_LOW: Output Compare active low
  *                       - TIM1_OCPOLARITY_HIGH: Output Compare active high
  * @retval None
  */
void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
{
  /* Check the parameters */
  assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
  
  /* Set or Reset the CC3P Bit */
  if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
  {
    TIM1->CCER2 |= TIM1_CCER2_CC3P;
  }
  else
  {
    TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
  }
}


/**
  * @brief  Configures the TIM1 Channel 3N polarity.
  * @param   TIM1_OCNPolarity specifies the OC3N Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_OCNPOLARITY_LOW: Output Compare active low
  *                       - TIM1_OCNPOLARITY_HIGH: Output Compare active high
  * @retval None
  */
void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
{
  /* Check the parameters */
  assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
  
  /* Set or Reset the CC3P Bit */
  if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
  {
    TIM1->CCER2 |= TIM1_CCER2_CC3NP;
  }
  else
  {
    TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
  }
}

/**
  * @brief  Sets the TIM1 Counter Register value.
  * @param   Counter specifies the Counter register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval None
  */
void TIM1_SetCounter(uint16_t Counter)
{
  /* Set the Counter Register value */
  TIM1->CNTRH = (uint8_t)(Counter >> 8);
  TIM1->CNTRL = (uint8_t)(Counter);
}

/**
  * @brief  Sets the TIM1 Autoreload Register value.
  * @param   Autoreload specifies the Autoreload register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval None
  */
void TIM1_SetAutoreload(uint16_t Autoreload)
{
  /* Set the Autoreload Register value */
  TIM1->ARRH = (uint8_t)(Autoreload >> 8);
  TIM1->ARRL = (uint8_t)(Autoreload);
 }


/**
  * @brief  Sets the TIM1 Capture Compare3 Register value.
  * @param   Compare3 specifies the Capture Compare3 register new value.
  * This parameter is between 0x0000 and 0xFFFF.
  * @retval None
  */
void TIM1_SetCompare3(uint16_t Compare3)
{
  /* Set the Capture Compare3 Register value */
  TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
  TIM1->CCR3L = (uint8_t)(Compare3);
}

/**
  * @brief  Sets the TIM1 Input Capture 3 prescaler.
  * @param   TIM1_IC3Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM1_ICPSC_DIV1: no prescaler
  *                       - TIM1_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM1_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM1_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
{
  
  /* Check the parameters */
  assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
  
  /* Reset the IC1PSC Bits & Set the IC1PSC value */
  TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
                          (uint8_t)TIM1_IC3Prescaler);
}

/**
  * @brief  Gets the TIM1 Input Capture 3 value.
  * @param  None
  * @retval Capture Compare 3 Register value.
  */
uint16_t TIM1_GetCapture3(void)
{
  /* Get the Capture 3 Register value */
  uint16_t tmpccr3 = 0;
  uint8_t tmpccr3l=0, tmpccr3h=0;
  
  tmpccr3h = TIM1->CCR3H;
  tmpccr3l = TIM1->CCR3L;
  
  tmpccr3 = (uint16_t)(tmpccr3l);
  tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
  /* Get the Capture 3 Register value */
  return (uint16_t)tmpccr3;
}

/**
  * @}
  */
  
/**
  * @}
  */
  

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
