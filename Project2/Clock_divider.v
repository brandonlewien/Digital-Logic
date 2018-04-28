module Clock_divider(input clock, output reg out);
	reg [16:0] toggle;
	always@(posedge clock) begin
		if(toggle == 25000) begin
			out <= ~out;
			toggle <= 0;
		end
		else begin
			toggle <= toggle + 1;
		end
	end
endmodule
	
	
module Clock_divider1sec(input clock, output reg out);
	reg [24:0] toggle;
	always@(posedge clock) begin
		if(toggle == 25000000) begin
			out <= ~out;
			toggle <= 0;
		end
		else begin
			toggle <= toggle + 1;
		end
	end
endmodule
	