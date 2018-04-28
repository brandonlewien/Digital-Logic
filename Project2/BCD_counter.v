//Counting up values
module BCD_counter(
	input [1:0] enable,
	input clock,
	output reg[3:0] one,
	output reg[3:0] ten,
	output reg[3:0] hun,
	output reg[9:0] overflow
	);
	reg state;
	always@(posedge clock) begin
		if (enable == 2'b00 || enable == 2'b01) begin
			one = 4'b0000;
			ten = 4'b0000;
			hun = 4'b0000;
			overflow = 9'b0000000000;
		end
		else if(enable == 2'b10) begin
			if(one == 4'b1001) begin
				one <= 4'b0000;
				if(ten == 4'b1001) begin
					ten <= 4'b0000;
					if(hun == 4'b1001) begin
						hun <= 4'b0000;
						if(overflow == 9'b100000000) begin
							overflow <= 9'b000000000;
						end
						else
							if(overflow == 0 && hun == 9) begin
								overflow <= 1;
							end
							else
								overflow <= overflow << 1;
					end
					else 
						hun <= hun + 4'b0001;
				end
				else 
					ten <= ten + 4'b0001;
			end
			else
				one <= one + 4'b0001;
		end
	end
endmodule

module BCD_countdown(
	input [1:0] enable,
	input bt1,
	input clock,
	input [11:0] LFSR,
	output reg flag
	);
	reg[11:0] holder;
	always@(posedge clock) begin
		if(!bt1) begin
			flag = 1'b0;
			holder <= LFSR;
		end
		else if(enable == 2'b01 && bt1) begin
			if(holder < 1'b1) begin
				flag = 1'b1;
			end
			else begin
				holder = holder - 1;
				flag = 1'b0;
			end
		end
	end
endmodule
