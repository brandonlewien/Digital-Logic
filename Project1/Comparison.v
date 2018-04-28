/******************************************************************************
 * @Title: Comparison.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * ***************************************************************************/

module Comparison(x,y,choose,z);
	input[3:0] x;
	input[3:0] y;
	input[1:0] choose;
	output[3:0] z;
	
	wire[3:0] isequal;
	wire[3:0] isgreater;
	wire[3:0] isless;
	wire[3:0] ismax;
	isequal equal(x,y,isequal);
	isgreater greater(x,y,isgreater);
	isless less(x,y,isless);
	ismax max(x,y,ismax);
	Multiplexer compare(isequal,isgreater,isless,ismax,choose,z);
endmodule

module isequal(x,y,both);
	input[3:0] x;
	input[3:0] y;
	output reg both = 1'b0;
	wire hold = (x == y);
	always@(*)
	begin
	if(hold == 1)
		both = 4'b0001;
	else
		both = 4'b0000;
	end
endmodule

module isgreater(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output reg[3:0] z;
	assign both = x > y;
	always@(*)
	if(both == 1)
		z = 4'b0001;
	else
		z = 4'b0000;
endmodule

module isless(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output reg[3:0] z;
	wire both;
	assign both = x < y;
	always@(*)
	if(both == 1)
		z = 4'b0001;
	else
		z = 4'b0000;
endmodule

module ismax(x,y,z);
	input[3:0] x;
	input[3:0] y;
	output [3:0] z;
	assign z = x^((x^y)&-(x<y));
endmodule
