module(
	clk,
	rst_n,
	en1,
	en2,
	dout
          );

input clk;
input rst_n;
input en1;
input en2;
output dout;

reg [4:0] cnt1;
wire add_cnt1;
wire end_cnt1;
wire end_cnt1_1;
wire end_cnt1_2;
reg [4:0] cnt2;
wire add_cnt2;
wire end_cnt2;
wire end_cnt2_1;
wire end_cnt2_2;
wire dout;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		cnt1 <= 1'b0;
	end
	else if(add_cnt1) begin
		if(end_cnt1)
			cnt1 <= 1'b0;
		else
			cnt1 <= cnt1 + 1;
	end
end

assign add_cnt1 = flag1==1;
assign end_cnt1 = add_cnt1 && cnt1==29-1;
assign end_cnt1_1 = add_cnt1 && (cnt1==2-1 || cnt1==9-1 || cnt1==18-1 || cnt1==23-1);
assign end_cnt1_2 = add_cnt1 && (cnt1==7-1 || cnt1==16-1 || cnt1==21-1 || cnt1==29-1);

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		cnt2 <= 1'b0;
	end
	else if(add_cnt2) begin
		if(end_cnt2)
			cnt2 <= 1'b0;
		else
			cnt2 <= cnt2 + 1;
	end
end

assign add_cnt2 = flag2==1;
assign end_cnt2 = add_cnt2 && cnt2==30-1;
assign end_cnt2_1 = add_cnt2 && (cnt2==4-1 || cnt2==8-1 || cnt2==20-1 || cnt2==25-1);
assign end_cnt2_2 = add_cnt2 && (cnt2==7-1 || cnt2==14-1 || cnt2==23-1 || cnt2==30-1);

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag1 <= 1'b0;
	end
	else if(en1) begin
		flag1 <= 1'b1;
	end
	else if(end_cnt1) begin
		flag1 <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag2 <= 1'b0;
	end
	else if(en2) begin
		flag2 <= 1'b1;
	end
	else if(end_cnt2) begin
		flag2 <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		dout <= 1'b0;
	end
	else if(end_cnt1_1 || end_cnt2_1) begin
		dout <= 1'b1;
	end
	else if(end_cnt1_2 || end_cnt2_2) begin
		dout <= 1'b0;
	end
end

endmodule
