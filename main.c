/* 
 * ----------------------------------------------------------------------------
 *                         Dynamics Of Creative Engineering SRL
 *                              (DOC Engineering)
 * 
 *                 Copyright (c) 2024 Dynamics Of Creative Engineering SRL
 *                            All Rights Reserved
 * 
 * This software, including any associated documentation and source code, 
 * is the proprietary and confidential information of Dynamics Of Creative 
 * Engineering SRL. Unauthorized copying, modification, distribution, or 
 * disclosure of this software, in whole or in part, is strictly prohibited 
 * and may result in civil or criminal penalties.
 * 
 * Developed by: M. Urbino
 * Date: October 2024
 * Location: Brussels, Belgium
 * 
 * This software is intended for use only in conjunction with approved 
 * applications and systems. For licensing inquiries or additional 
 * information, please contact DOC Engineering at info@doc-engineering.be.
 * 
 * ----------------------------------------------------------------------------
 */
 
#define VERSION "Draft"
 
#include "stm8s.h"       // Include the STM8S standard library for hardware definitions
#include "stm8s_it.h"    // Include interrupt service routine headers
#include "math.h"        // Include math library for mathematical operations

// ===================== Constants =====================
#define HSI_FREQ 16000000 // HSI oscillator frequency in Hz

#define TIM2_CH3_FREQ 20000 // Timer2_CH3 PWM Frequency in Hz. Minimum frequency is ~245Hz without prescaler

#define TIM1_PRESCALER_1 0 // Timer1 configured for the same frequency as the peripheral clock
#define TIM1_REP_COUNTER 0  // Counter is updated after each PWM cycle
#define TIM1_CH3_FREQ 20000 // Timer1_CH3 PWM Frequency in Hz

#define TIMER_1 1           // Timer identifier for Timer 1
#define TIMER_2 2           // Timer identifier for Timer 2
#define TIMER_4 4           // Timer identifier for Timer 4

#define LONG_PRESS_DURATION 1500 //Long button press threshold in ms
#define DEBOUNCE_DELAY 50 // Debounce delay in ms

// ===================== Global Variables =====================
volatile uint16_t ms_count = 0;      // Milliseconds counter for timing functions
volatile uint16_t OCR = 0;          // Output Compare Register for PWM settings
volatile uint16_t arr_tim1 = 0;     // Auto-Reload Register for Timer 1
volatile uint16_t arr_tim2 = 0;     // Auto-Reload Register for Timer 2
volatile uint16_t max_pwm_speed_pump = 0; // Maximum PWM speed for the pump
volatile uint16_t max_pwm_speed_LED = 0;  // Maximum PWM speed for the LED
volatile uint8_t press_count = 0;   		// Button press counter
volatile bool long_press = 0;			// Flag indicating a long button press
volatile bool button_pressed = 0; // Flag indicating a button press
volatile uint16_t button_press_start = 0;	// Start time of button press
volatile uint16_t button_press_duration = 0; // Total time of button press
volatile uint16_t duty_cycle_step = 0;	// Current duty cycle step for PWM
volatile bool pulse_flag = 0;       // Flag indicating pulse operation status
volatile uint16_t last_interrupt_time = 0;


// ===================== Function Prototypes =====================
void clock_setup(void);                               // Configures the clock system for the microcontroller
void gpio_setup(void);                                 // Configures GPIO pins for button and LED control
void gpio_setup_SWIM(void);                            // Configures GPIO for SWIM functionality
void EXTI_setup(void);                                 // Configures external interrupts for button detection
void tim4_init(void);                                  // Initializes Timer 4 for delay management
void delay_ms(uint16_t delay);                         // Generates a delay in milliseconds

uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler); // Sets PWM Frequency in Hz

uint16_t tim2_init(void);                              // Initializes Timer 2 for LED PWM control
uint16_t tim1_init(void);                              // Initializes Timer 1 for PWM generation

void led_smooth_blink(void);                           // Function to smoothly blink an LED
uint16_t pump_smooth_on_off(uint16_t duty_cycle_step); // Function for smooth pump operation

uint16_t set_pump_speed(uint16_t duty_cycle_step);    // Sets the speed of the pump based on duty cycle
uint16_t accelerate_pump(uint16_t duty_cycle_step);   // Gradually increases the pump speed
uint16_t decelerate_pump(uint16_t duty_cycle_step);   // Gradually decreases the pump speed
uint16_t pump_off(uint16_t duty_cycle_step);               // Turns off the pump


// ===================== State Definitions =====================
typedef enum {
	STATE_SLEEP,        // Default state with minimal power consumption
    STATE_IDLE,         // State indicating pump is ready but not operating
    STATE_FULL_SPEED,   // State indicating pump is operating at maximum speed
    STATE_LOW_SPEED,    // State indicating pump is operating at reduced speed
	STATE_PULSE          // State indicating pump operates in a pulsed manner
} state;

state current_state = STATE_SLEEP;  // Initialize current state to SLEEP


// ===================== Interrupt Handlers =====================
/**
 * @brief Timer 4 Update and Overflow Interrupt Handler.
 * 
 * This interrupt service routine increments the ms_count variable
 * each time Timer 4 overflows, allowing for millisecond timing.
 */
INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) {
    ms_count++;  // Increment milliseconds count
    TIM4_ClearITPendingBit(TIM4_IT_UPDATE); // Clear interrupt pending bit for Timer 4
}

/**
 * @brief External Interrupt Handler for Port D.
 * 
 * This interrupt service routine detects button presses by checking the state
 * of the button connected to GPIO Port D. It includes a debounce delay
 * to avoid false triggers due to noise.
 */
INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6) {
	uint16_t current_time = ms_count; // Get current time

	// Debounce management
	if (current_time - last_interrupt_time < DEBOUNCE_DELAY) {
			return; // Return if debounce delay is not elapsed
	}
	last_interrupt_time = current_time; // Update last interrupt
	
	
	if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) == 0) // Check if the button is pressed
	{
		// Check if the button was pressed before, raise the flag if not, and start counting press duration
		if (!button_pressed)
		{
			button_pressed = 1;
			button_press_start = ms_count;
		}
	}
	else if (GPIO_ReadInputPin(GPIOD, GPIO_PIN_6) != 0)// When button is released, compute the duration of the press 
	{
		if (button_pressed) // Check if we reach this step with a proper button press, and not some noise event.
		{
			button_press_duration = ms_count - button_press_start; // Calculate the duration of the press.
		
			if (button_press_duration < LONG_PRESS_DURATION) // Short press detected
			{
				press_count++;
			}
			else // Long press detected
			{
				long_press = 1;
			}
			button_pressed = 0; //Release button press flag
		}
	}
	
}


main()
{
	// Initial system and peripheral setup
	clock_setup();						// Configure system clock and timing
	EXTI_setup();							// Setup external interrupts for button handling
	enableInterrupts();				// Globally enable interrupts
	
	/* 
	 * Init Timer 4 before setting up GPIOs to ensure a 5-second delay. 
	 * This step is mandatory to keep the SWIM pin programmable.
	 * If the delay is omitted, the SWIM pin will be reconfigured as a GPIO, 
	 * making reprogramming the device impossible.
	 */
	tim4_init();
	delay_ms(5000);						// 5-second delay to ensure SWIM pin availability
	
	/* Initialize GPIO pins (e.g., Pin D6 for press_button) */
	gpio_setup();
	
	/* 
	 * Initialize Timer 1 and capture its ARR (Auto Reload Register) value.
	 * This value will serve as a reference for calculating the maximum 
	 * duty cycle for the pump PWM speed control.
	 */
	max_pwm_speed_pump = tim1_init();	
		
	/* 
	 * Main control loop 
	 * Implements a state machine that manages pump and LED operations
	 * based on the number of button presses.
	 */	
	while (1)
	
	{
		switch (current_state)
		{				
			case STATE_SLEEP: // Default state: minimal power consumption, awaiting wake-up
				
				while (duty_cycle_step != 0)
				{
					duty_cycle_step = pump_off(duty_cycle_step);	// Ensure the pump is off in sleep state
				}
				
				halt(); // Wait for push-button interrupt
				
				// Transition to IDLE state after exiting SLEEP state when a button press is detected
					current_state = STATE_IDLE;
					max_pwm_speed_LED = tim2_init();	// Initialize Timer 2 for LED PWM control during IDLE state (SWIM is disabled)
					
				break;
				
			case STATE_IDLE:	// Idle state: low LED brightness and pump off
			
				TIM2_SetCompare3(max_pwm_speed_LED/100);
				TIM2_SetCompare2(max_pwm_speed_LED/100);
				
				duty_cycle_step = pump_off(duty_cycle_step);	// Keep the pump turned off
				
				// Transition to LOW_SPEED state on second button press
				if (press_count > 1)
				{
					current_state = STATE_LOW_SPEED;
					// Turn off Pulse LED
					TIM2_SetCompare2(0);
				}
				
				// Transition to SLEEP state on long button press
				if (long_press != 0)
				{
					current_state = STATE_SLEEP;
					
					// Turn off the pump and reset press count
					duty_cycle_step = pump_off(duty_cycle_step);					
					press_count = 0;
					long_press = 0;
					
					// Turn off leds
					TIM2_SetCompare2(0);
					TIM2_SetCompare3(0);

					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
				}
				
				break;
				
			case STATE_LOW_SPEED:	// Reduced pump speed with moderate LED brightness
				
				// Set LED brightness to 1% of maximum
				TIM2_SetCompare3(max_pwm_speed_LED/100);
				
				// Gradually decrease pump speed to 2/3 of its maximum speed
				if (duty_cycle_step > (max_pwm_speed_pump/3)*2)
				{
					duty_cycle_step = decelerate_pump(duty_cycle_step);
				}
				else if (duty_cycle_step < (max_pwm_speed_pump/3)*2)
				{
					duty_cycle_step = accelerate_pump(duty_cycle_step);
				}
				else
				{
					duty_cycle_step = set_pump_speed((max_pwm_speed_pump/3)*2);	// Maintain 2/3 speed
				}
				
				// Transition to FULL_SPEED state on third button press
				if (press_count > 2)
				{
					current_state = STATE_FULL_SPEED;
				}
				
				// Transition to SLEEP state on long button press
				if (long_press != 0)
				{
					current_state = STATE_SLEEP;
					
					// Turn off the pump and reset press count
					duty_cycle_step = pump_off(duty_cycle_step);					
					press_count = 0;
					long_press = 0;
					
					// Turn off leds
					TIM2_SetCompare2(0);
					TIM2_SetCompare3(0);

					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
				}
				break;
				
			case STATE_FULL_SPEED:	// Full pump speed and LED brightness
				
				// Set LED to maximum brightness
				TIM2_SetCompare3(max_pwm_speed_LED/100);
				
				// Gradually increase pump speed to maximum
				if (duty_cycle_step < max_pwm_speed_pump)
				{
					duty_cycle_step = accelerate_pump(duty_cycle_step);
				}
				else
				{
					duty_cycle_step = set_pump_speed(max_pwm_speed_pump);	// Maintain max speed
				}
				
				// Transition to PULSE state on fourth button press
				if (press_count > 3)
				{
					current_state = STATE_PULSE;
					TIM2_SetCompare3(0);	// Turn off the STRONG/WEAK LEDs					
				}
				
				// Transition to SLEEP state on long button press
				if (long_press != 0)
				{
					current_state = STATE_SLEEP;
					
					// Turn off the pump and reset press count
					duty_cycle_step = pump_off(duty_cycle_step);					
					press_count = 0;
					long_press = 0;
					
					// Turn off leds
					TIM2_SetCompare2(0);
					TIM2_SetCompare3(0);

					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
				}
				break;

			case STATE_PULSE:	// Pulsed pump operation with LED indication
			
				// Set LED PULSE to 1% brightnes
				TIM2_SetCompare2(max_pwm_speed_LED/100);
				
				// Perform a smooth on-off cycle of the pump
				duty_cycle_step = pump_smooth_on_off(duty_cycle_step);
				
				// Transition back to SLEEP state on fifth button press
				if (press_count > 4)
				{					
					current_state = STATE_LOW_SPEED;	// Reset to SLEEP state
					
					// Turn off the pump and reset press count
					duty_cycle_step = pump_off(duty_cycle_step);
					press_count = 2;
					
					TIM2_SetCompare2(0);	// Turn off LED PULSE				
				}
				
				// Transition to SLEEP state on long button press
				if (long_press != 0)
				{
					current_state = STATE_SLEEP;
					
					// Turn off the pump and reset press count
					duty_cycle_step = pump_off(duty_cycle_step);					
					press_count = 0;
					long_press = 0;
					
					// Turn off leds
					TIM2_SetCompare2(0);
					TIM2_SetCompare3(0);

					TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
				}
				break;
				
			default:
			
				// Unexpected state: reset to SLEEP state as a failsafe
				current_state = STATE_SLEEP;	// Reset to SLEEP state
					
				// Turn off the pump and reset press count
				duty_cycle_step = pump_off(duty_cycle_step);
				press_count = 0;
				
				TIM2_DeInit();				// Deinitialize Timer 2 to re-enable SWIM
				
				break;
		}
	}
}

/**
 * @brief Configures the clock system and enables/disables specific peripheral clocks.
 * 
 * This function initializes the clock system to use the internal HSI (High-Speed Internal) clock
 * source, sets the prescalers for CPU and peripheral clocks, and selectively enables/disables
 * clocks for various peripherals based on the application requirements.
 */
void clock_setup(void)
{
	CLK_DeInit();		// Reset clock configuration to default state
	
	CLK_HSECmd(DISABLE);  // Disable external high-speed clock
	CLK_LSICmd(DISABLE);  // Disable low-speed internal clock
	CLK_HSICmd(ENABLE);   // Enable internal high-speed clock (16 MHz)
	
	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);	// Wait until HSI clock is stable
	
	CLK_ClockSwitchCmd(ENABLE);  // Enable automatic clock switching
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);  // Set HSI clock prescaler (Peripheral Clock = 16 MHz)
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);  // Set CPU clock prescaler (CPU Clock = 16 MHz)
	
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
	
	// Configure clocks for specific peripherals
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);  // Enable Timer 1 for PWM generation
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);  // Enable Timer 2 for PWM generation
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);  // Enable Timer 4 for delay function
	
}

/**
 * @brief Configures the GPIO pins for the application.
 * 
 * This function initializes the GPIO ports A, B, and D, and sets specific pins for input or output modes
 * as needed by the application. For example, it configures Pin D6 as an input pin with interrupt capability
 * and Pin B4 as a push-pull output.
 */
void gpio_setup(void)
{
	GPIO_DeInit(GPIOA);  // Reset Port A configuration
	GPIO_DeInit(GPIOB);  // Reset Port B configuration
	GPIO_DeInit(GPIOD);  // Reset Port D configuration
	
	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_IT);					// Configure Pin D6 as an floating input with interrupt
	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);	// Configure Pin B4 as push-pull output with fast response
}

/**
 * @brief Configures the external interrupt settings.
 * 
 * Sets up the external interrupt for Port D with falling-edge sensitivity, which is useful for detecting
 * button presses or other events. Additionally, it sets the priority for these interrupts to the lowest 
 * level, ensuring that higher-priority interrupts can preempt this handler if necessary.
 */
void EXTI_setup(void)
{
	ITC_DeInit();	// Reset interrupt controller configuration
	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0); 	// Set Port D interrupt priority to level 0 (lowest)
	
	EXTI_DeInit(); // Reset external interrupt configuration
	//Enable PORTD interrupt on falling edges
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_FALL);  // Enable falling and rising-edge sensitivity for Port D
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);  // Set TLI sensitivity to falling-edge
	
	enableInterrupts();	// Enable global interrupts. Do nothing if already enabled
}


/**
 * @brief Initializes Timer 4 for delay functions.
 * 
 * Configures Timer 4 to generate an interrupt every millisecond. This timer is used as a time reference 
 * for implementing delay functions, ensuring accurate timing without blocking the main program execution.
 */
void tim4_init(void) //Timer Used to count milliseconds for delay function
{
	
	TIM4_DeInit();	// Reset Timer 4 configuration
	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); // Set prescaler to 128 and set ARR to 125 (1 ms period). CLK_PRESCALER_HSIDIV1/TIM4_PRESCALER_128 => F_TIM4 = 125kHz. Counter needs to reach 125 to get 1ms.
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);  // Enable update interrupt
	TIM4_Cmd(ENABLE);  // Start Timer 4
	
}

/**
 * @brief Creates a blocking delay for a specified duration.
 * 
 * Implements a delay in milliseconds using Timer 4. This function monitors a counter variable (`ms_count`)
 * that increments with each Timer 4 interrupt and blocks execution until the specified delay time has elapsed.
 * 
 * @param delay The delay duration in milliseconds.
 */
void delay_ms(uint16_t delay)
{
    uint16_t start = ms_count;	// Record the current timer count
    while ((ms_count - start) < delay);	// Wait until the delay period has elapsed
		
}


/**
 * @brief Sets the PWM frequency for a specified timer.
 * 
 * Calculates and sets the appropriate auto-reload register (ARR) value based on the desired PWM frequency, 
 * HSI clock prescaler, and the timer prescaler. Ensures that the calculated ARR value does not exceed 
 * the 16-bit limit (65535).
 * 
 * @param timer The timer for which the PWM frequency is being set.
 * @param frequency The desired PWM frequency.
 * @param hsi_prescaler The prescaler applied to the HSI clock.
 * @param timx_prescaler The prescaler applied to the specific timer.
 * @return uint16_t The calculated ARR value for the given frequency.
 */
uint16_t set_pwm_frequency(uint8_t timer, uint16_t frequency, uint8_t hsi_prescaler, uint8_t timx_prescaler)
{
	uint32_t arr = 0; //uint32_t to avoid 16-bit overflow
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
		
		while (arr > 65535) //Ajust Frequency to get it back into ARR 16-bit limit.
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

/**
 * @brief Initializes Timer 2 for PWM generation.
 * 
 * Configures Timer 2 for generating PWM signals, setting the prescaler and ARR values based on the required frequency.
 * Initializes the PWM output channels and enables the timer.
 * 
 * @return uint16_t The ARR value used for configuring Timer 2.
 */
uint16_t tim2_init(void)
{
	// Calculate the Auto-Reload Register (ARR) value for the desired PWM frequency.	
	uint16_t ARR = set_pwm_frequency(TIMER_2, TIM2_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM2_PRESCALER_1);
	
	// Set the Output Compare Register to 0 to start PWM with no output initially.
	OCR = 0;
	
	// Deinitialize Timer 2 to clear any previous configuration.
	TIM2_DeInit();
	
	// Configure Timer 2 with calculated ARR and a prescaler value of 1
	TIM2_TimeBaseInit(TIM2_PRESCALER_1, ARR); //Set TIM2 Prescaler and period (in number of ticks) Note: ARRmax = 65535 (Adjust prescaler to get the correct pwm frequency)
	
	// Initialize Timer 2 Channel 3  and channel 2 in PWM mode 1 with output state enabled.
	TIM2_OC3Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_STRONG
	TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, OCR, TIM2_OCPOLARITY_HIGH); // For LED_PULSE
	
	// Enable Timer 2 to start counting.
	TIM2_Cmd(ENABLE);
	
	// Return the calculated ARR value for reference.
	return ARR;
	
}

/**
 * @brief Initializes Advanced Timer 1 for PWM operation.
 * 
 * This function configures Timer 1 to generate a PWM signal with a specified frequency and duty cycle.
 * It sets the Auto-Reload Register (ARR) value based on the desired frequency, initializes Timer 1's 
 * PWM channels, and enables the PWM output. The initial duty cycle is set to zero (0) to ensure the 
 * PWM signal starts in a known state and does not drive connected components unintentionally.
 * 
 * @return uint16_t The ARR value used for Timer 1, which defines the PWM period.
 */
uint16_t tim1_init(void)
{
	// Calculate the Auto-Reload Register (ARR) value for the desired PWM frequency.
	uint16_t ARR = set_pwm_frequency(TIMER_1, TIM1_CH3_FREQ, CLK_PRESCALER_HSIDIV1, TIM1_PRESCALER_1);
	
	// Set the Output Compare Register to 0 to start PWM with no output initially.
	OCR = 0; //Enable PWM but force it Low to avoid driving things unintentionally
	
	// Deinitialize Timer 1 to clear any previous configuration.
	TIM1_DeInit();
	
	// Configure Timer 1 with calculated ARR and a prescaler value of 1
	TIM1_TimeBaseInit(TIM1_PRESCALER_1, TIM1_COUNTERMODE_UP, ARR, TIM1_REP_COUNTER);
	
	// Initialize Timer 1 Channel 3 in PWM mode 1 with output state enabled.
	TIM1_OC3Init(TIM1_OCMODE_PWM1,TIM1_OUTPUTSTATE_ENABLE, TIM1_OUTPUTNSTATE_DISABLE, OCR, TIM1_OCPOLARITY_HIGH, TIM1_OCNPOLARITY_LOW, TIM1_OCIDLESTATE_RESET, TIM1_OCNIDLESTATE_RESET);
	
	// Enable Timer 1 to start counting.
	TIM1_Cmd(ENABLE);
	
	// Activate the PWM output for Timer 1.
	TIM1_CtrlPWMOutputs(ENABLE);
	
	// Return the calculated ARR value for reference.
	return ARR;
	
}

/**
 * @brief Gradually increases the pump speed by adjusting the PWM duty cycle.
 * 
 * Smoothly ramps up the pump speed by incrementing the PWM duty cycle in small steps, with a 1 ms delay
 * between each increment. This avoids sudden speed changes that could mechanically stress the pump.
 * The function updates the Timer 1 Compare Register to reflect the new duty cycle.
 * 
 * @param duty_cycle_step The current duty cycle value.
 * @return uint16_t The incremented duty cycle value.
 */
uint16_t accelerate_pump(uint16_t duty_cycle_step)
{	
	delay_ms(1); // Short delay to smooth out the ramp-up.
	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
	duty_cycle_step++; // Increment the duty cycle value.

	return duty_cycle_step; // Return the updated duty cycle.
}

/**
 * @brief Gradually decreases the pump speed by adjusting the PWM duty cycle.
 * 
 * Smoothly ramps down the pump speed by decrementing the PWM duty cycle in small steps, with a 1 ms delay
 * between each decrement. This prevents sudden speed drops that could disrupt the pump operation.
 * The function updates the Timer 1 Compare Register to reflect the new duty cycle.
 * 
 * @param duty_cycle_step The current duty cycle value.
 * @return uint16_t The decremented duty cycle value.
 */
uint16_t decelerate_pump(uint16_t duty_cycle_step)
{	
	delay_ms(1); // Short delay to smooth out the ramp-down.
	TIM1_SetCompare3(duty_cycle_step); // Update the PWM duty cycle.
	duty_cycle_step--; // Decrement the duty cycle value.

	return duty_cycle_step; // Return the updated duty cycle.
}

/**
 * @brief Sets the pump speed to a specified PWM duty cycle.
 * 
 * Directly sets the pump speed to a desired value by updating the Timer 1 Compare Register. This function
 * bypasses gradual acceleration or deceleration and is typically used for setting a fixed pump speed.
 * 
 * @param duty_cycle_step The desired duty cycle value to set.
 * @return uint16_t The same duty cycle value passed to the function.
 */
uint16_t set_pump_speed(uint16_t duty_cycle_step)
{	
	TIM1_SetCompare3(duty_cycle_step); // Set the PWM duty cycle to the specified value.
	return duty_cycle_step; // Return the specified duty cycle.

}

/**
 * @brief Turns off the pump by gradually reducing its speed to zero.
 * 
 * This function ensures a smooth deceleration of the pump's duty cycle until 
 * it reaches zero. Once the pump is fully stopped, it disables the PWM output
 * by setting the compare value to 0. This helps to avoid abrupt speed changes 
 * that could damage the pump or cause unwanted mechanical stress.
 * 
 * @param duty_cycle_step The current duty cycle of the pump's PWM control.
 */
 
uint16_t pump_off(uint16_t duty_cycle_step)
{
	if (duty_cycle_step > 0)
	{
		// Gradually decrease the pump's duty cycle to zero
		duty_cycle_step = decelerate_pump(duty_cycle_step);
	}
	else
	{
		// Completely turn off the PWM signal once the duty cycle reaches zero
		TIM1_SetCompare3(0);
	}
	
	return duty_cycle_step;
}

/**
 * @brief Manages the pump's duty cycle to create a smooth pulsing effect.
 * 
 * This function alternates between accelerating and decelerating the pump, 
 * producing a smooth on-off pulsing effect. The function uses a pulse flag 
 * (`pulse_flag`) to track whether the pump is in the acceleration or 
 * deceleration phase. This allows for consistent transitions, helping to 
 * avoid sudden changes in pump speed that could cause mechanical instability.
 * 
 * @param duty_cycle_step The current duty cycle of the pump's PWM control.
 * @return uint16_t Updated duty cycle value after performing acceleration 
 * or deceleration.
 */
uint16_t pump_smooth_on_off(uint16_t duty_cycle_step)
{
	// Check if the pump is still accelerating and has not reached the maximum speed
	if ((duty_cycle_step < max_pwm_speed_pump) && (pulse_flag == 0))
	{		
		duty_cycle_step = accelerate_pump(duty_cycle_step);				// Increase the duty cycle			
	}
	else
	{
		pulse_flag = 1;	// Switch to deceleration mode
	}
	
	// If the pump is in deceleration mode and the duty cycle is greater than zero
	if ((duty_cycle_step > 0) && (pulse_flag == 1))
	{		
		duty_cycle_step = decelerate_pump(duty_cycle_step);	// Decrease the duty cycle		
	}
	else
	{
		pulse_flag = 0;				// Switch back to acceleration mode once the duty cycle reaches zero
	}
	return duty_cycle_step;	// Return the updated duty cycle value
}
