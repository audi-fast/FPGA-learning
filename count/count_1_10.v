  module(
	  clk,
	  rst_n,
	  en1,
	  en2,
	  en3,
	  dout
            );

  input clk;
  input rst_n;
  input en1;
  input en2;
  input en3;

  output dout;

  reg [2:0] cnt0;
  wire add_cnt0;
  wire end_cnt0_1;
  wire end_cnt0_2;
  wire end_cnt0_3;
  wire end_cnt0;
  reg [3:0] cnt1;
  wire add_cnt1;
  wire end_cnt1_1;
  wire end_cnt1_2;
  wire end_cnt1_3;
  wire end_cnt1;
  reg dout;


  always  @(posedge clk or negedge rst_n)begin
	  if(rst_n==1'b0)begin
		  cnt0 <= 1'b0;
	  end
	  else if(add_cnt0) begin
		  if(end_cnt0)
			  cnt0 <= 1'b0;
		  else
			  cnt0 <= cnt0 + 1;
	  end
  end

  assign add_cnt0 = flag0==1 || flag1==1 || flag2==1;
  assign end_cnt0_1 = flag0==1 && cnt0==2-1;
  assign end_cnt0_2 = flag1==1 && cnt0==5-1;
  assign end_cnt0_3 = flag2==1 && cnt0==7-1;
  assign end_cnt0 = end_cnt0_1 || end_cnt0_2 || end_cnt0_3;

  always  @(posedge clk or negedge rst_n)begin
	  if(rst_n==1;'b0)begin
		  cnt1 <= 1'b0;
	  end
	  else if(add_cnt1) begin
		  if(end_cnt1)
			  cnt1 <= 1'b0;
		  else
			  cnt1 <= cnt1 + 1;
	  end
  end

  assign add_cnt1 = end_cnt
  assign end_cnt1_1 = flag0==1 && cnt1==3-1;
  assign end_cnt1_2 = flag1==1 && cnt1==4-1;
  assign end_cnt1_3 = flag2==1 && cnt1==8-1;
  assign end_cnt1 = end_cnt1_1 || end_cnt1_2 || end_cnt1_3;

  always  @(posedge clk or negedge rst_n)begin
	  if(rst_n==1'b0)begin
		  flag0 <= 1'b0;
	  end
	  else if(en1) begin
		  flag0 <= 1'b1;
	  end
	  else if(end_cnt1_1) begin
		  flag0 <= 1'b0;
	  end
  end

  always  @(posedge clk or negedge rst_n)begin
	  if(rst_n==1'b0)begin
		  flag1 <= 1'b0;
	  end
	  else if(en2) begin
		  flag1 <= 1'b1;
	  end
	  else if(end_cnt1_2) begin
		  flag1 <= 1'b0;
	  end
  end

  always  @(posedge clk or negedge rst_n)begin
	  if(rst_n==1'b0)begin
		  flag2 <= 1'b0;
	  end
	  else if(en3) begin
		  flag2 <= 1'b1;
	  end
	  else if(end_cnt1_3) begin
		  flag2 <= 1'b0;
	  end
  end
 
  endmodule
