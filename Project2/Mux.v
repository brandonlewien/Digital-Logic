module mux(
	input [3:0] a,
	input [3:0] b,
	input s,
	output reg [3:0] out
	);
	always@(s)
		case(s)
			1:out = a [3:0];
			0:out = b [3:0];
		endcase
endmodule

module mux9(
	input [9:0] a,
	input [9:0] b,
	input s,
	output reg [9:0] out
	);
	always@(s)
		case(s)
			1:out = a [9:0];
			0:out = b [9:0];
		endcase
endmodule