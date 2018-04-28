/******************************************************************************
 * @Title: Logical.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * ***************************************************************************/

module Logical(x,y,z,choose);
	input[3:0] x;
	input[3:0] y;
	output[7:0] z;
	input[1:0] choose;
	
	wire[7:0] notgate;
	wire[3:0] andgate, orgate, xorgate;
	
	andgate and1(x,y,andgate);
	orgate or1(x,y,orgate);
	xorgate xor1(x,y,xorgate);
	notgate not1(x,notgate);
	Multiplexer compare(andgate,orgate,xorgate,notgate,choose,z);
endmodule

module andgate(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output[3:0] z;
	assign z = x & y;
endmodule

module orgate(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output[3:0] z;
	assign z = x | y;
endmodule

module xorgate(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output[3:0] z;
	assign z = x ^ y;
endmodule

module notgate(x,z);
	input[7:0] x;
	output[7:0] z;
	assign z = ~x;
endmodule
