/******************************************************************************
 * @Title: Multiplexer.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * ***************************************************************************/

module Multiplexer(in0,in1,in2,in3,set,out);
	input [7:0] in0,in1,in2,in3;
	input[1:0] set;
	output [7:0] out;
	reg [7:0] temp;
	always@(*)
	begin
		case(set)
			2'b00 : temp = in0;
			2'b01 : temp = in1;
			2'b10 : temp = in2;
			2'b11 : temp = in3;
		endcase
	end
	assign out = temp;
endmodule
