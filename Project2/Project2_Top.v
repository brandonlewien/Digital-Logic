module Project2_Top(clock,sw0,sw1,bt0,bt1,seg0,seg1,seg2,seg3,seg4,seg5,led);
	input clock,sw0,sw1,bt0,bt1;
	output [6:0] seg0,seg1,seg2,seg3,seg4,seg5;
	output [9:0] led;
	
	wire clockdownscale,clock1sec,flag;
	wire [1:0] enable;
	wire [3:0] one,ten,hun,onehigh,tenhigh,hunhigh,oneout,tenout,hunout,soneout,stenout,shunout,sthoout,stthout,shthout;
	wire [9:0] overflow,overflowhigh,overflowout;
	wire [11:0] random;
	reg indicator,assigner,scrollindicator;
	reg [3:0] scrollseg5,scrollseg4,scrollseg3,scrollseg2,scrollseg1,scrollseg0,tracker;
	
																					//Flag allows for the LFSR/Countdown to start the Countup
	Clock_divider ckd1(clock,clockdownscale);							//Input 50MHz | Output 1kHz
	LFSR l1(clock,random);													//Input 50MHz | Output random 12bit #
	state(clock,bt0,bt1,sw0,flag,enable);								//Input 50MHz, bt0, bt1, sw1 (reset), flag | Output enable
	BCD_countdown(enable,bt0,clockdownscale,random,flag);		   //Input enable, sw1, 1kHz, random 12bit # | Output flag
	BCD_counter(enable,clockdownscale,one,ten,hun,overflow);		//Input enable, 1kHz | Output decoded ones, tens, and hundreds place, and added 8 second overflow tracker
	Clock_divider1sec ckd1s(clock,clock1sec);
	highscore(enable,one,ten,hun,overflow,onehigh,tenhigh,hunhigh,overflowhigh);
	
	mux onesplace(onehigh,one,sw1,oneout);
	mux tensplace(tenhigh,ten,sw1,tenout);
	mux hundredsplace(hunhigh,hun,sw1,hunout);
	
	mux sonesplace(oneout,scrollseg0,scrollindicator,soneout);
	mux stensplace(tenout,scrollseg1,scrollindicator,stenout);
	mux shundredsplace(hunout,scrollseg2,scrollindicator,shunout);
	mux ssonesplace(0,scrollseg3,scrollindicator,sthoout);
	mux sstensplace(0,scrollseg4,scrollindicator,stthout);
	mux sshundredsplace(0,scrollseg5,scrollindicator,shthout);
	
	mux9 overflowsplace(overflowhigh,overflow,sw1,overflowout);

	BCD_decoder oneseg(soneout,seg0);
	BCD_decoder tenseg(stenout,seg1);
	BCD_decoder hunseg(shunout,seg2);
	BCD_decoder thoseg(sthoout,seg3);
	BCD_decoder tthseg(stthout,seg4);
	BCD_decoder hthseg(shthout,seg5);
	

	assign led[7:0] = overflowout;
	
	always@(posedge clock) begin
		if(enable == 2'b10) begin
			indicator = 1;
		end
		else
			indicator = 0;
	end
	assign led[9] = indicator;

	reg [3:0] c1;
	always@(posedge clock) begin
		if(enable == 2'b00 && !sw1) begin
			scrollindicator = 0;
		end
		else
			scrollindicator = 1;
	end
	
	always@(posedge clock1sec) begin
		if(c1 == 8) begin
			c1 = 0;
		end
		else begin
			c1 = c1 + 1;
		end
		case(c1) 
			0: begin
			scrollseg5 = 6;
			scrollseg4 = 0;
			scrollseg3 = 15;
			scrollseg2 = 10;
			scrollseg1 = 11;
			scrollseg0 = 12;
			end
			1: begin
			scrollseg5 = 0;
			scrollseg4 = 15;
			scrollseg3 = 10;
			scrollseg2 = 11;
			scrollseg1 = 12;
			scrollseg0 = 12;
			end
			2: begin
			scrollseg5 = 15;
			scrollseg4 = 10;
			scrollseg3 = 11;
			scrollseg2 = 12;
			scrollseg1 = 12;
			scrollseg0 = 5;
			end
			3: begin
			scrollseg5 = 10;
			scrollseg4 = 11;
			scrollseg3 = 12;
			scrollseg2 = 12;
			scrollseg1 = 5;
			scrollseg0 = 15;
			end
			4: begin
			scrollseg5 = 11;
			scrollseg4 = 12;
			scrollseg3 = 12;
			scrollseg2 = 5;
			scrollseg1 = 15;
			scrollseg0 = 6;
			end
			5: begin
			scrollseg5 = 12;
			scrollseg4 = 12;
			scrollseg3 = 5;
			scrollseg2 = 15;
			scrollseg1 = 6;
			scrollseg0 = 0;
			end
			6: begin
			scrollseg5 = 12;
			scrollseg4 = 5;
			scrollseg3 = 15;
			scrollseg2 = 6;
			scrollseg1 = 0;
			scrollseg0 = 15;
			end
			7: begin
			scrollseg5 = 5;
			scrollseg4 = 15;
			scrollseg3 = 6;
			scrollseg2 = 0;
			scrollseg1 = 15;
			scrollseg0 = 10;
			end
			8: begin
			scrollseg5 = 15;
			scrollseg4 = 6;
			scrollseg3 = 0;
			scrollseg2 = 15;
			scrollseg1 = 10;
			scrollseg0 = 11;
			end
		endcase
		
		assigner = ~assigner;
	end
	assign led[8] = assigner;
	
endmodule




