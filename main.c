/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s.h"
#include "stm8s_it.h"
#include "math.h"

#define HSI_FREQ 16000000 //HSI oscillator frequency in Hz

#define TIM2_CH3_FREQ 20000 //Timer2_CH3 PWM Frequency in Hz. F_MIN =~ 245Hz without prescaler

#define TIM1_PRESCALER_1 0 //Timer1 as same frequency as peripheral clock
#define TIM1_REP_COUNTER 0 //Counter is updated after each PWM cycle
#define TIM1_CH3_FREQ 20000 //Timer1_CH3 PWM Frequency in Hz

#define TIMER_1 1
#define TIMER_2 2
#define TIMER_4 4

volatile int ms_count = 0; //Declared for delay_ms function purposes
volatile uint16_t OCR = 0;
volatile uint16_t arr_tim1 = 0;
volatile uint16_t arr_tim2 = 0;
volatile uint16_t max_pwm_speed_pump = 0;	
volatile uint16_t max_pwm_speed_LED = 0;
volatile uint8_t press_count = 0;
volatile uint16_t duty_cycle_step = 0;
volatile bool pulse_flag = FALSE;

void clock_setup(void);
void gpio_setup(void);
void gpio_setup_SWIM(void);
void EXTI_setup(void);
void tim4_init(void);
void delay_ms(int delay);

uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler); //set PWM Frequency in Hz

uint16_t tim2_init(void);
uint16_t tim1_init(void);

void led_smooth_blink(void);
void pump_smooth_on_off(void);

/** Setting Pump Speed Function */

void set_pump_speed(uint16_t duty_cycle_step);

uint16_t accelerate_pump(uint16_t duty_cycle_step);
uint16_t decelerate_pump(uint16_t duty_cycle_step);

void pump_off(void);

/* ///////////////////////////////////////////////// */

typedef enum {
		STATE_SLEEP,
    STATE_IDLE,
    STATE_FULL_SPEED,
    STATE_LOW_SPEED,
		STATE_PULSE

} state;


state current_state = STATE_SLEEP;


INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler,23) {
    ms_count++; 
    TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
}

INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
	
	delay_ms(50);

	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0)
	{
		 press_count++;
	}
}


main()
{
	clock_setup();
	EXTI_setup();
	
	enableInterrupts();
	
/*	Init Timer 4 before setting up GPIO's so We can initiate a 5 seconds delay.
			It lets the SWIM pin programmable for at least, before turning the pin into
			a GPIO.
			It is a mandatory feature if we want to be able to reprogram the device.
			Otherwise, we won't be able to program it anymore as the pin will now be a GPIO.
*/
	tim4_init();
	delay_ms(5000);
	
	/*Init GPIOs (Pin D6 for press_button) */
	gpio_setup();
	
	/** Init Timers and store their ARR to have a reference value for duty_cycle calculation*/
	max_pwm_speed_pump = tim1_init();	
		
	
		
	while (1)
	
	{
		switch (current_state)
		{				
			case STATE_SLEEP: //Default State, no consumption, waiting for a button press to wake up.

				pump_off();
				
				if (press_count > 0)
				{
					current_state = STATE_IDLE;
					max_pwm_speed_LED = tim2_init();
				}
				break;
				
			case STATE_IDLE:
			
				TIM2_SetCompare3(max_pwm_speed_LED/100);
				TIM2_SetCompare2(max_pwm_speed_LED/100);
				
				pump_off();
				
				if (press_count > 1)
				{
					current_state = STATE_FULL_SPEED;
					TIM2_SetCompare2(0);
					
				}
				break;
				
			case STATE_FULL_SPEED:
			
				TIM2_SetCompare3(max_pwm_speed_LED);
				
				if (duty_cycle_step < max_pwm_speed_pump)
				{
					accelerate_pump(duty_cycle_step);
				}
				else
				{
					set_pump_speed(max_pwm_speed_pump);
				}
				
				if (press_count > 2)
				{
					current_state = STATE_LOW_SPEED;
					
				}
				break;
				
			case STATE_LOW_SPEED:
			
				TIM2_SetCompare3(max_pwm_speed_LED/2);
				
				if (duty_cycle_step > 0)
				{
					decelerate_pump(duty_cycle_step);
				}
				else
				{
					set_pump_speed(0);
				}
				
				if (press_count > 2)
				{
					current_state = STATE_LOW_SPEED;
					
				}
				
				if (press_count > 3)
				{
					current_state = STATE_PULSE;
					TIM2_SetCompare3(0);					
				}
				break;
				
			case STATE_PULSE:
				TIM2_SetCompare2(max_pwm_speed_LED/2);
				pump_smooth_on_off();
				
				if (press_count > 4)
				{
					current_state = STATE_SLEEP;
					pump_off();
					press_count = 0;
					TIM2_SetCompare2(0);					
					TIM2_DeInit();
				}
				break;
		}
	}
}


void clock_setup(void)
{
	CLK_DeInit();
	
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	CLK_HSICmd(ENABLE); //Enable HSI clock (16MHz)
	
	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
	
	CLK_ClockSwitchCmd(ENABLE);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Peripheral Clock is 16MHz
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1); //CPU Clock is 16MHz
	
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE); //Enable Timer 1
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE); //Enable Timer 2
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE); //Enable Timer 4 to use as reference for Delay Function
	
}


void gpio_setup(void)
{
	GPIO_DeInit(GPIOA); //Prepare Port A for operation
	GPIO_DeInit(GPIOB); //Prepare Port B for operation	
	GPIO_DeInit(GPIOD); //Prepare Port D for operation
	
	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_IT);
	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
}

void gpio_setup_SWIM(void)
{
	//GPIO_DeInit(GPIOD); //Prepare Port D for operation
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);

}

void EXTI_setup(void)
{
	ITC_DeInit();
	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
	
	EXTI_DeInit();
	//Enable PORTD interrupt on falling edges
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
	
	enableInterrupts();
}

void tim4_init(void) //Timer Used to count milliseconds for delay function
{
	
	TIM4_DeInit();
	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
	TIM4_Cmd(ENABLE);
	
}

void delay_ms(int delay)
{
    int start = ms_count;
    while ((ms_count - start) < delay);
		
}

uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler) //Set PWM frequency based on HSI speed, the HSI prescaler, and the timer prescaler
{
	uint32_t arr = 0; //Declared as uint32_t to avoid overflow issue during calculation
	switch (hsi_prescaler)
	{
		case 0x00:
			hsi_prescaler = 1;
			break;
			
		case 0x08:
			hsi_prescaler = 2;
			break;
			
		case 0x10:
			hsi_prescaler = 4;
			break;
			
		case 0x18:
			hsi_prescaler = 8;
			break;
	}
	
	if (timer !=  1)
	{		
		arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;
		
		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
		{
			frequency++;
			arr = (HSI_FREQ/(frequency*hsi_prescaler*(pow(2, timx_prescaler))))-1;		
		}
	}
	else
	{
		arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;
	
		while (arr > 65535) //Adjust PWM Frequency so ARR is not out of range.
		{
			frequency++;
			arr = (HSI_FREQ/(frequency*hsi_prescaler*(timx_prescaler + 1)))-1;		
		}
		
	}
	
	return (uint16_t)arr;
}

uint16_t tim2_init(void)
{
		
	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
	OCR = 0; //To force PWM Low to avoid driving things unintentionally when it's enabled
	
	TIM2_DeInit(); //DeInit TIM2
	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // Init PWM Output Compare, High when Counter < DutyCycle (OCR), Low afterwards.
	TIM2_Cmd(ENABLE);
	
	return ARR;
	
}

uint16_t tim1_init(void)
{
	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
	
	TIM1_DeInit();
	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
	TIM1_Cmd(ENABLE);
	
	TIM1_CtrlPWMOutputs(ENABLE);
	
}

void led_smooth_blink(void)
{
	
	uint16_t duty_cycle_step = 0;
	//Test progressive blink//
	while (duty_cycle_step <= arr_tim2)
	{		
		delay_ms(1);
		TIM2_SetCompare3(duty_cycle_step);
		duty_cycle_step++;			
	}
	
	while (duty_cycle_step)
	{		
		delay_ms(1);
		TIM2_SetCompare3(duty_cycle_step);
		duty_cycle_step--;
	}
		
}

void pump_smooth_on_off(void)
{
	if ((duty_cycle_step < arr_tim1) && (!pulse_flag))
	{		
		accelerate_pump(duty_cycle_step);			
	}
	else
	{
		pulse_flag = TRUE;
	}
	
	if ((duty_cycle_step > 0) && (pulse_flag))
	{		
		decelerate_pump(duty_cycle_step);			
	}
	else
	{
		pulse_flag = FALSE;
	}
		
}

uint16_t accelerate_pump(uint16_t duty_cycle_step)
{	
	delay_ms(1);
	TIM1_SetCompare3(duty_cycle_step);
	duty_cycle_step++;			

	return duty_cycle_step;
}

uint16_t decelerate_pump(uint16_t duty_cycle_step)
{	
	delay_ms(1);
	TIM1_SetCompare3(duty_cycle_step);
	duty_cycle_step--;			

	return duty_cycle_step;
}

void set_pump_speed(uint16_t duty_cycle_step)
{	
	TIM1_SetCompare3(duty_cycle_step);

}

void pump_off(void)
{
	TIM1_SetCompare3(0);
}

/*
void pump_smooth_on_off2(void)
{
	
	uint16_t duty_cycle_step = 0;
	//Test 0 to max to 0 for pump//
	while (duty_cycle_step <= arr_tim1)
	{		
		delay_ms(1);
		TIM1_SetCompare3(duty_cycle_step);
		duty_cycle_step++;			
	}
	
	while (duty_cycle_step)
	{		
		delay_ms(1);
		TIM1_SetCompare3(duty_cycle_step);
		duty_cycle_step--;
	}
		
}*/