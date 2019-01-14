module LFSR(input clock, output reg [11:0] random);
	initial begin
		random = 12'b111111111111;
	end
	always @(posedge clock) begin
		if (random == 0) begin
			random <= 12'b111111111111;
		end
		else begin
			random <= {random[10], 
				   random[9],
				   random[8],
				   random[7],
			     	   random[6],
			 	   random[5],
				   random[4],
				   random[3],
				   random[2],
				   random[1],
				   random[0],
				   random[8] ^ random[3]
			           };
		end
	end
endmodule
