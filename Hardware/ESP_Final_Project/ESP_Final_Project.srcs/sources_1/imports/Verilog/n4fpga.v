`timescale 1ns / 1ps
// n4fpga.v - Top level module for the ECE 544  project 1
//
// Copyright Srivatsa Yogendra, Portland State University  2015. 2016
//
// Created By: Srivatsa Yogendra
// Date:		09-November-2016
// Version:		1.0
//
// Description:
// ------------
// This module provides the top level for the Hardware component
// of the Final project for ECE 558.
// The module assume that a PmodOLEDrgb is plugged into the JA 
// expansion port and that a PmodBT2 is plugged into the JC expansion 
// port.  
//////////////////////////////////////////////////////////////////////
module n4fpga(
    input				clk,						// 100Mhz clock input
    input				btnC,						// center pushbutton
    input				btnU,						// UP (North) pusbhbutton
    input				btnL,						// LEFT (West) pushbutton
    input				btnD,						// DOWN (South) pushbutton  - used for system reset
    input				btnR,						// RIGHT (East) pushbutton
	input				btnCpuReset,				// CPU reset pushbutton
    input	[15:0]		sw,							// slide switches on Nexys 4
    output	[15:0] 		led,						// LEDs on Nexys 4   
    output              RGB1_Blue,					// RGB1 LED (LD16) 
    output              RGB1_Green,
    output              RGB1_Red,
    output              RGB2_Blue,     				// RGB2 LED (LD17)
    output              RGB2_Green,
    output              RGB2_Red,
    output [7:0]        an,             			// Seven Segment display
    output [6:0]        seg,
    output              dp,
    
    input				usb_uart_rxd,				// USB UART Rx and Tx on Nexys 4
    output				usb_uart_txd,	
    
    inout				JA1, JA2, JA3, JA4,			// JA Pmod connector 
    inout				JA7, JA8, JA9, JA10,
   
  	inout				JB1, JB2, JB3, JB4,			// JG Pmod connector 
    inout				JB7, JB8, JB9, JB10,
    
    inout				JC1, JC2, JC3, JC4,			// JC Pmod connector
    inout				JC7, JC8, JC9, JC10,
    
	output				JD1, JD2, JD3, JD4,			// JD Pmod connector
	inout				JD7, JD8, JD9, JD10			
);

// internal variables
wire				sysclk;
wire				sysreset_n, sysreset;
wire	[7:0]		lcd_d;
wire				lcd_rs, lcd_rw, lcd_e;

wire 				pmodoledrgb_out_pin1_i, pmodoledrgb_out_pin1_io, pmodoledrgb_out_pin1_o, pmodoledrgb_out_pin1_t; 
wire 				pmodoledrgb_out_pin2_i, pmodoledrgb_out_pin2_io, pmodoledrgb_out_pin2_o, pmodoledrgb_out_pin2_t; 
wire 				pmodoledrgb_out_pin3_i, pmodoledrgb_out_pin3_io, pmodoledrgb_out_pin3_o, pmodoledrgb_out_pin3_t; 
wire 				pmodoledrgb_out_pin4_i, pmodoledrgb_out_pin4_io, pmodoledrgb_out_pin4_o, pmodoledrgb_out_pin4_t; 
wire 				pmodoledrgb_out_pin7_i, pmodoledrgb_out_pin7_io, pmodoledrgb_out_pin7_o, pmodoledrgb_out_pin7_t; 
wire 				pmodoledrgb_out_pin8_i, pmodoledrgb_out_pin8_io, pmodoledrgb_out_pin8_o, pmodoledrgb_out_pin8_t; 
wire 				pmodoledrgb_out_pin9_i, pmodoledrgb_out_pin9_io, pmodoledrgb_out_pin9_o, pmodoledrgb_out_pin9_t; 
wire 				pmodoledrgb_out_pin10_i, pmodoledrgb_out_pin10_io, pmodoledrgb_out_pin10_o, pmodoledrgb_out_pin10_t;

wire                pmodbt2_out_pin1_i, pmodbt2_out_pin1_io, pmodbt2_out_pin1_o, pmodbt2_out_pin1_t;
wire                pmodbt2_out_pin2_i, pmodbt2_out_pin2_io, pmodbt2_out_pin2_o, pmodbt2_out_pin2_t;
wire                pmodbt2_out_pin3_i, pmodbt2_out_pin3_io, pmodbt2_out_pin3_o, pmodbt2_out_pin3_t;
wire                pmodbt2_out_pin4_i, pmodbt2_out_pin4_io, pmodbt2_out_pin4_o, pmodbt2_out_pin4_t;
wire                pmodbt2_out_pin7_i, pmodbt2_out_pin7_io, pmodbt2_out_pin7_o, pmodbt2_out_pin7_t;
wire                pmodbt2_out_pin8_i, pmodbt2_out_pin8_io, pmodbt2_out_pin8_o, pmodbt2_out_pin8_t;
wire                pmodbt2_out_pin9_i, pmodbt2_out_pin9_io, pmodbt2_out_pin9_o, pmodbt2_out_pin9_t;
wire                pmodbt2_out_pin10_i, pmodbt2_out_pin10_io, pmodbt2_out_pin10_o, pmodbt2_out_pin10_t;  
wire                led_out;



// make the connections

// system-wide signals
assign sysclk = clk;
assign sysreset_n = btnCpuReset;		// The CPU reset pushbutton is asserted low.  The other pushbuttons are asserted high
										// but the microblaze for Nexys 4 expects reset to be asserted low
assign sysreset = ~sysreset_n;			// Generate a reset signal that is asserted high for any logic blocks expecting it.


// pmodOLEDrgb signals
// JA - both rows. pin mapping is done in the pmodOLEDrgb peripheral
// using Digilent's PMOD bridge component
assign JA1 = pmodoledrgb_out_pin1_io;
assign JA2 = pmodoledrgb_out_pin2_io;
assign JA3 = pmodoledrgb_out_pin3_io;
assign JA4 = pmodoledrgb_out_pin4_io;
assign JA7 = pmodoledrgb_out_pin7_io;
assign JA8 = pmodoledrgb_out_pin8_io;
assign JA9 = pmodoledrgb_out_pin9_io;
assign JA10 = pmodoledrgb_out_pin10_io;

// pmodBT2 signals
// JC - both rows. pin mapping is done in the pmodBT2 peripheral
// using Digilent's PMOD bridge component
assign JC1 = pmodbt2_out_pin1_io;
assign JC2 = pmodbt2_out_pin2_io;
assign JC3 = pmodbt2_out_pin3_io;
assign JC4 = pmodbt2_out_pin4_io;
assign JC7 = pmodbt2_out_pin7_io;
assign JC8 = pmodbt2_out_pin8_io;
assign JC9 = pmodbt2_out_pin9_io;
assign JC10 = pmodbt2_out_pin10_io;

assign JD1 = led_out;


// instantiate the embedded system
embsys embsys_i
(
    .PmodBT2_out_pin10_i(pmodbt2_out_pin10_i),
    .PmodBT2_out_pin10_o(pmodbt2_out_pin10_o),
    .PmodBT2_out_pin10_t(pmodbt2_out_pin10_t),
    .PmodBT2_out_pin1_i(pmodbt2_out_pin1_i),
    .PmodBT2_out_pin1_o(pmodbt2_out_pin1_o),
    .PmodBT2_out_pin1_t(pmodbt2_out_pin1_t),
    .PmodBT2_out_pin2_i(pmodbt2_out_pin2_i),
    .PmodBT2_out_pin2_o(pmodbt2_out_pin2_o),
    .PmodBT2_out_pin2_t(pmodbt2_out_pin2_t),
    .PmodBT2_out_pin3_i(pmodbt2_out_pin3_i),
    .PmodBT2_out_pin3_o(pmodbt2_out_pin3_o),
    .PmodBT2_out_pin3_t(pmodbt2_out_pin3_t),
    .PmodBT2_out_pin4_i(pmodbt2_out_pin4_i),
    .PmodBT2_out_pin4_o(pmodbt2_out_pin4_o),
    .PmodBT2_out_pin4_t(pmodbt2_out_pin4_t),
    .PmodBT2_out_pin7_i(pmodbt2_out_pin7_i),
    .PmodBT2_out_pin7_o(pmodbt2_out_pin7_o),
    .PmodBT2_out_pin7_t(pmodbt2_out_pin7_t),
    .PmodBT2_out_pin8_i(pmodbt2_out_pin8_i),
    .PmodBT2_out_pin8_o(pmodbt2_out_pin8_o),
    .PmodBT2_out_pin8_t(pmodbt2_out_pin8_t),
    .PmodBT2_out_pin9_i(pmodbt2_out_pin9_i),
    .PmodBT2_out_pin9_o(pmodbt2_out_pin9_o),
    .PmodBT2_out_pin9_t(pmodbt2_out_pin9_t),
    .PmodOLEDrgb_out_pin10_i(pmodoledrgb_out_pin10_i),
	.PmodOLEDrgb_out_pin10_o(pmodoledrgb_out_pin10_o),
	.PmodOLEDrgb_out_pin10_t(pmodoledrgb_out_pin10_t),
	.PmodOLEDrgb_out_pin1_i(pmodoledrgb_out_pin1_i),
	.PmodOLEDrgb_out_pin1_o(pmodoledrgb_out_pin1_o),
	.PmodOLEDrgb_out_pin1_t(pmodoledrgb_out_pin1_t),
	.PmodOLEDrgb_out_pin2_i(pmodoledrgb_out_pin2_i),
	.PmodOLEDrgb_out_pin2_o(pmodoledrgb_out_pin2_o),
	.PmodOLEDrgb_out_pin2_t(pmodoledrgb_out_pin2_t),
	.PmodOLEDrgb_out_pin3_i(pmodoledrgb_out_pin3_i),
	.PmodOLEDrgb_out_pin3_o(pmodoledrgb_out_pin3_o),
	.PmodOLEDrgb_out_pin3_t(pmodoledrgb_out_pin3_t),
	.PmodOLEDrgb_out_pin4_i(pmodoledrgb_out_pin4_i),
	.PmodOLEDrgb_out_pin4_o(pmodoledrgb_out_pin4_o),
	.PmodOLEDrgb_out_pin4_t(pmodoledrgb_out_pin4_t),
	.PmodOLEDrgb_out_pin7_i(pmodoledrgb_out_pin7_i),
	.PmodOLEDrgb_out_pin7_o(pmodoledrgb_out_pin7_o),
	.PmodOLEDrgb_out_pin7_t(pmodoledrgb_out_pin7_t),
	.PmodOLEDrgb_out_pin8_i(pmodoledrgb_out_pin8_i),
	.PmodOLEDrgb_out_pin8_o(pmodoledrgb_out_pin8_o),
	.PmodOLEDrgb_out_pin8_t(pmodoledrgb_out_pin8_t),
	.PmodOLEDrgb_out_pin9_i(pmodoledrgb_out_pin9_i),
	.PmodOLEDrgb_out_pin9_o(pmodoledrgb_out_pin9_o),
	.PmodOLEDrgb_out_pin9_t(pmodoledrgb_out_pin9_t),
	.RGB1_Blue(RGB1_Blue),
	.RGB1_Green(RGB1_Green),
	.RGB1_Red(RGB1_Red),
	.RGB2_Blue(RGB2_Blue),
	.RGB2_Green(RGB2_Green),
	.RGB2_Red(RGB2_Red),
	.an(an),
	.btnC(btnC),
	.btnD(btnD),
	.btnL(btnL),
	.btnR(btnR),
	.btnU(btnU),
	.dp(dp),
	.led(led),
	.seg(seg),
	.sw(sw),
	.uart_rtl_rxd(usb_uart_rxd),
	.uart_rtl_txd(usb_uart_txd),
	.sysclk(sysclk), 
	.led_out(led_out),
	.gpio_0_GPIO_tri_i(gpio_in_high_r),	// Added port instantiation
	.sysreset_n(sysreset_n)
 );
                   
// Tristate buffers for the pmodOLEDrgb and pmodBT2 pins
// generated by PMOD bridge component.  Many
// of these signals are not tri-state.
IOBUF pmodoledrgb_out_pin1_iobuf
(
	.I(pmodoledrgb_out_pin1_o),
	.IO(pmodoledrgb_out_pin1_io),
	.O(pmodoledrgb_out_pin1_i),
	.T(pmodoledrgb_out_pin1_t)
);

IOBUF pmodoledrgb_out_pin2_iobuf
(
	.I(pmodoledrgb_out_pin2_o),
	.IO(pmodoledrgb_out_pin2_io),
	.O(pmodoledrgb_out_pin2_i),
	.T(pmodoledrgb_out_pin2_t)
);

IOBUF pmodoledrgb_out_pin3_iobuf
(
	.I(pmodoledrgb_out_pin3_o),
	.IO(pmodoledrgb_out_pin3_io),
	.O(pmodoledrgb_out_pin3_i),
	.T(pmodoledrgb_out_pin3_t)
);

IOBUF pmodoledrgb_out_pin4_iobuf
(
	.I(pmodoledrgb_out_pin4_o),
	.IO(pmodoledrgb_out_pin4_io),
	.O(pmodoledrgb_out_pin4_i),
	.T(pmodoledrgb_out_pin4_t)
);

IOBUF pmodoledrgb_out_pin7_iobuf
(
	.I(pmodoledrgb_out_pin7_o),
	.IO(pmodoledrgb_out_pin7_io),
	.O(pmodoledrgb_out_pin7_i),
	.T(pmodoledrgb_out_pin7_t)
);

IOBUF pmodoledrgb_out_pin8_iobuf
(
	.I(pmodoledrgb_out_pin8_o),
	.IO(pmodoledrgb_out_pin8_io),
	.O(pmodoledrgb_out_pin8_i),
	.T(pmodoledrgb_out_pin8_t)
);

IOBUF pmodoledrgb_out_pin9_iobuf
(
	.I(pmodoledrgb_out_pin9_o),
	.IO(pmodoledrgb_out_pin9_io),
	.O(pmodoledrgb_out_pin9_i),
	.T(pmodoledrgb_out_pin9_t)
);

IOBUF pmodoledrgb_out_pin10_iobuf
(
	.I(pmodoledrgb_out_pin10_o),
	.IO(pmodoledrgb_out_pin10_io),
	.O(pmodoledrgb_out_pin10_i),
	.T(pmodoledrgb_out_pin10_t)
);

IOBUF pmodbt2_out_pin10_iobuf
(
    .I(pmodbt2_out_pin10_o),
    .IO(pmodbt2_out_pin10_io),
    .O(pmodbt2_out_pin10_i),
    .T(pmodbt2_out_pin10_t)
);

IOBUF pmodbt2_out_pin1_iobuf
(
    .I(pmodbt2_out_pin1_o),
    .IO(pmodbt2_out_pin1_io),
    .O(pmodbt2_out_pin1_i),
    .T(pmodbt2_out_pin1_t)
);

IOBUF pmodbt2_out_pin2_iobuf
(
    .I(pmodbt2_out_pin2_o),
    .IO(pmodbt2_out_pin2_io),
    .O(pmodbt2_out_pin2_i),
    .T(pmodbt2_out_pin2_t)
);

IOBUF pmodbt2_out_pin3_iobuf
(
    .I(pmodbt2_out_pin3_o),
    .IO(pmodbt2_out_pin3_io),
    .O(pmodbt2_out_pin3_i),
    .T(pmodbt2_out_pin3_t)
);

IOBUF pmodbt2_out_pin4_iobuf
(
    .I(pmodbt2_out_pin4_o),
    .IO(pmodbt2_out_pin4_io),
    .O(pmodbt2_out_pin4_i),
    .T(pmodbt2_out_pin4_t)
);

IOBUF pmodbt2_out_pin7_iobuf
(
    .I(pmodbt2_out_pin7_o),
    .IO(pmodbt2_out_pin7_io),
    .O(pmodbt2_out_pin7_i),
    .T(pmodbt2_out_pin7_t)
);

IOBUF pmodbt2_out_pin8_iobuf
(
    .I(pmodbt2_out_pin8_o),
    .IO(pmodbt2_out_pin8_io),
    .O(pmodbt2_out_pin8_i),
    .T(pmodbt2_out_pin8_t)
);

IOBUF pmodbt2_out_pin9_iobuf
(
    .I(pmodbt2_out_pin9_o),
    .IO(pmodbt2_out_pin9_io),
    .O(pmodbt2_out_pin9_i),
    .T(pmodbt2_out_pin9_t)
);
 

endmodule

