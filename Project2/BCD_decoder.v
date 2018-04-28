module BCD_decoder(input [3:0]in, output reg [6:0]out);
	always @(in) begin
			case(in)
				4'b0000: out = 7'b1000000; //0   1
				4'b0001: out = 7'b1111001;	//1
				4'b0010: out = 7'b0100100;	//2
				4'b0011: out = 7'b0110000;	//3
				4'b0100: out = 7'b0011001;	//4
				4'b0101: out = 7'b0010010;	//5   7
				4'b0110: out = 7'b0000010;	//6   0
				4'b0111: out = 7'b1111000;	//7
				4'b1000: out = 7'b0000000;	//8
				4'b1001: out = 7'b0010000;	//9
				4'b1010: out = 7'b0000011; //b   3	
				4'b1011: out = 7'b1000001;	//u   4
				4'b1100: out = 7'b0001110;	//f   5/6
				4'b1101: out = 7'b0100001;	
				4'b1110: out = 7'b0000110;	
				//4'b1111: out = 7'b0001110;
				4'b1111: out = 7'b1111111; //0   2/8
				default: out = 7'bx;
			endcase
		end
endmodule

module BCD_decoderGOBUFFS(input [3:0]in, output reg [6:0]out);
	always @(in) begin
			case(in)
				4'b0000: out = 7'b0000010; //'G (6)' 0
				4'b0001: out = 7'b1000000; //'O (0)' 1
				4'b0010: out = 7'b1111111; //'  ( )' 2
				4'b0011: out = 7'b0000011; //'b (b)' 3
				4'b0100: out = 7'b1000001; //'U (U)' 4 
				4'b0101: out = 7'b0001110; //'f (f)' 5
				4'b0110: out = 7'b0001110; //'f (f)' 6
				4'b0111: out = 7'b0010010; //'s (5)' 7
				4'b1000: out = 7'b1111111; //'  ( )' 8
				default: out = 7'bx;
			endcase
		end
endmodule

