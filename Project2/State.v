module state(
	input clock,
	input bt0,
	input bt1, 
	input sw1, 
	input flag, 
	output reg [1:0] enable
	);
	reg [1:0] s0, s1;
	parameter idle = 2'b00, countdown = 2'b01, reaction = 2'b10, seg7 = 2'b11;

	always @(s0, bt0, bt1, sw1) begin
		case(s0)
			idle:
				if (!bt0) begin				
					s1 = countdown;
				end
				else
					s1 = idle;
         countdown:
            if (flag && bt0) begin
					s1 = reaction;
				end
				else 
					s1 = countdown;
         reaction:
				if (!bt1) begin
					s1 = seg7;
				end
				else
					s1 = reaction;
         seg7:
				if (sw1) begin
					s1 = idle;
				end
				else
					s1 = seg7;
		endcase
	end
	
	always @(posedge clock, posedge sw1) begin
		if (sw1)
			s0 <= idle;
		else
			s0 <= s1;
	end
	
	always @(s0) begin
		if (s0 == idle)
			enable = idle;
		if (s0 == countdown)
			enable = countdown;
		if (s0 == reaction)
			enable = reaction;
		if (s0 == seg7)
			enable = seg7;
	end
endmodule 

module highscore(
	input [1:0] enable,
	input [3:0] one,
	input [3:0] ten,
	input [3:0] hun,
	input [9:0] overflow,
	output reg [3:0] onehigh,
	output reg [3:0] tenhigh,
	output reg [3:0] hunhigh,
	output reg [9:0] overflowhigh
	);
	initial begin
		onehigh = 9;
		tenhigh = 9;
		hunhigh = 9;
		overflowhigh = 9'b000110000;
	end
	always@(enable) begin
		if(enable == 2'b00 && {one,ten,hun} != 0) begin
			if({overflow,hun,ten,one} < {overflowhigh,hunhigh,tenhigh,onehigh}) begin
				{overflowhigh,hunhigh,tenhigh,onehigh} = {overflow,hun,ten,one};
			end
		end
	end
endmodule