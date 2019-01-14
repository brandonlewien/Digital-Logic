/******************************************************************************
 * @Title: Project1_top.v
 *
 * @authors Brandon Lewien
 * @date March 1st, 2018
 * @version 1.0--3/4/18BL
 *
 * Compiled using Quartus Prime Lite
 *
 * Description:
 * This holds 1 multiplexer, and calls to each peripheral needed for Project 1.
 * I have collaborated with a couple others including Miles Iola's group,
 * and Mark Hinkle's group for this project. In turn, some of my code supplied
 * might be similar to theirs.
 * ***************************************************************************/

module Project1_top(bt,sw,led,seg0,seg1);
	input [1:0] bt;								//Input for top and botton buttons
	input[9:0] sw;							        //Input for 10 switches
	output[9:0] led;							//Output for 10 LEDs							
   	output[7:0] seg0;							//Output for leftmost 7 segment
	output[7:0] seg1;							//Output for second to left 7 segment
      //wire [1:0] s = 2'b00;   						//Backup for buttons (a mockup pretty much)
 
	/*Buttons*/
	reg [1:0]but;								//Register to store button presses
	always@(posedge bt[0])
	begin
		but[0] = ~but[0];
	end
	always@(posedge bt[1])
	begin
		but[1] = ~but[1];
	end
	
	/*Switches*/
	wire[3:0]xswitch;							//4 Rightmost switches are x
	assign xswitch = sw[3:0];
	wire[3:0]yswitch;							//Next 4 after the x's are y control switches
	assign yswitch = sw[7:4];
	wire[1:0]chooser;							//The 2 leftmost are 4 possible inner options within the different modes
	assign chooser = sw[9:8];					        //Basically mode within mode
	wire[7:0]bothswitch;							//For some of the cases where some modes use the full 8 bits
	assign bothswitch = sw[7:0];
	wire[7:0] out;								//MAIN OUTPUT
	wire [1:0]dec;								//MAIN DECIMAL OUTPUT
	wire hold;								//LED9 mainly for Arithmetic indicator
	wire [1:0]dechold;
	
	/*Wires for outputs for 3 modules*/
	wire[3:0] compout;
	wire[7:0] logout;
	wire[7:0] ariout;
	
	/*Modules calls so outputs could be set to Multiplexer*/
	Arithmetic math(xswitch,yswitch,bothswitch,ariout,hold,dec,chooser);
	Comparison compare(xswitch,yswitch,chooser,compout);
	Logical logic(xswitch,yswitch,logout,chooser);
	
	/*Main Multiplexer*/
	Multiplexer top(ariout,compout,logout,0,but,out);
	
	/*Main Lights*/
	SevenSegment segment0(out[3:0],dec[1],seg0);
	SevenSegment segment1(out[7:4],dec[0],seg1);
	assign led[8:0] = out;
	assign led[9] = hold;
	
endmodule
