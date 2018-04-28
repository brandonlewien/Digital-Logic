/******************************************************************************
 * @Title: SevenSegment.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * ***************************************************************************/

module SevenSegment(bin,dec,bout);

	input[3:0] bin;
	input dec;
	output reg[7:0] bout;
	
	always@(bin)
	begin
		case(bin)
			4'b0000: bout = 8'b01000000;
			4'b0001: bout = 8'b01111001;
			4'b0010: bout = 8'b00100100;
			4'b0011: bout = 8'b00110000;
			4'b0100: bout = 8'b00011001;
			4'b0101: bout = 8'b00010010;
			4'b0110: bout = 8'b00000010;
			4'b0111: bout = 8'b01111000; 
			4'b1000: bout = 8'b00000000; 
			4'b1001: bout = 8'b00010000; 
			4'b1010: bout = 8'b00001000; 
			4'b1011: bout = 8'b00000011;
			4'b1100: bout = 8'b01000110;
			4'b1101: bout = 8'b00100001;
			4'b1110: bout = 8'b00000110;
			4'b1111: bout = 8'b00001110;
			default: bout = 8'b00000000;
		endcase
		case(dec)
			1'b0: bout = bout ^ 8'b10000000;
		endcase
	end
endmodule
