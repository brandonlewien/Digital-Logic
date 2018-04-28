/******************************************************************************
 * @Title: Arithmetic.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * ***************************************************************************/

module Arithmetic(x,y,xy,z,hold,dec,choose);
	input [3:0]x;
	input [3:0]y;
	input [7:0]xy;
	output [7:0]z;
	output reg hold;
	output reg[1:0]dec;
	input[1:0] choose;

	wire[3:0] adder,subtractor,exdec; 
	wire[7:0] multipler, divider;
	
	adder add1(x,y,adder,exdec[0]);
	subtractor sub1(x,y,subtractor,exdec[1]);
	multipler mult1(xy,multipler,exdec[2]);
	divider div1(xy,divider,exdec[3]);
	
	Multiplexer compare(adder,subtractor,multipler,divider,choose,z);
	always@*
	begin
		if(choose[1:0] == 0)
		begin
			hold = exdec[0];
			dec = 0;
		end
		else if(choose[1:0] == 1)
		begin
			hold = exdec[1];
			dec = 0;
		end
		else if(choose[1:0] == 2)
		begin
			dec[0] = exdec[2];
			hold = 0;
		end
		else if(choose[1:0] == 3)
		begin
			dec[1] = exdec[3];
			hold = 0;
		end
	end
	
endmodule

module adder(x,y,z,carry);
	input [3:0] x;
	input [3:0] y;
	output [3:0] z;
	output carry;
	fourbitadder(x,y,z,0,carry);
endmodule

module subtractor(x,y,z,anticarry);
	input [3:0] x;
	input [3:0] y;
	output [3:0] z;
	output anticarry;
	fourbitsubtractor(x,y,z,anticarry);
endmodule

module multipler(xy,z,dec);
	input [7:0] xy;
	output [7:0] z;
	output reg dec;
	assign z = xy[7:0]<<1;
	always@(xy)
	begin
		if(xy[7] == 1) 	//Meaning true
			dec = 1;
		else
			dec = 0;
	end
endmodule

module divider(x,z,dec);
	input [7:0] x;
	output [7:0] z;
	output reg dec;
	always@(*)
	if(x[0] == 1)
	begin
		dec = 1;
	end
	else
	begin
		dec = 0;
	end
	assign z[7:0] = x[7:0]>>1;
endmodule

module fulladder(x,y,z,sum,carry);
		input x,y,z;
		output sum;
		output carry;
		assign sum = x ^ y ^ z;
		assign carry = (x&y)|(x&z)|(y&z);
endmodule

module fourbitadder(x,y,sum,cin,cout);
	input[3:0] x,y;
	output[3:0] sum;
	output cout;
	input cin;
	wire [4:0] rollover;
	genvar i;
	generate
		for(i=0;i<4;i=i+1) begin: test
			fulladder adder1 (x[i],y[i],rollover[i],sum[i],rollover[i+1]);
		end	
	endgenerate
	assign rollover[0] = cin;
	assign cout = rollover[4];


endmodule

module fourbitsubtractor(x,y,diff,anticarry);
	input[3:0] x,y;
	output reg[3:0] diff;
	output reg anticarry;
	reg [4:0] rollover;
	integer i;
	always@*
		begin
		rollover[0] = 0;
		anticarry = rollover[4];
			for(i=0;i<4;i=i+1)
			begin
				diff[i] = x[i]^y[i]^rollover[i];
				rollover[i+1] =~x[i]*y[i]+x[i]*rollover[i];
			end
		end
endmodule

