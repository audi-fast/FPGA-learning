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
input en2;
output [2:0] dout;

reg [2:0] cnt;
wire add_cnt;
wire end_cnt_1;
wire end_cnt_2;
wire end_cnt_3;
wire end_cnt;
reg flag1;
reg flag2;
reg flag3;
reg [2:0] dout;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		cnt <= 1'b0;
	end
	else if(add_cnt) begin
		if(end_cnt)
			cnt <= 1'b0;
		else
			cnt <= cnt + 1;
	end
end

assign add_cnt = flag1==1 || flag2==1 || flag3==1;
assign end_cnt_1 = flag1==1 && cnt==2-1;
assign end_cnt_2 = flag2==1 && cnt==4-1;
assign end_cnt_3 = flag3==1 && cnt==7-1;
assign end_cnt = end_cnt_1 || end_cnt_2 || end_cnt_3;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag1 <= 1'b0;
	end
	else if(en1) begin
		flag1 <= 1'b1;
	end
	else if(end_cnt_1) begin
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
	else if(end_cnt_2) begin
		flag2 <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag3 <= 1'b0;
	end
	else if(en3) begin
		flag3 <= 1'b1;
	end
	else if(end_cnt_3) begin
		flag3 <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		dout <= 1'b0;
	end
	else if(flag1==1 && cnt==1-1) begin
		dout <= 2'b10;
	end
	else if(flag2==1 && cnt==1-1) begin
		dout <= 3'b100;
	end
	else if(flag3==1 && cnt==5-1) begin
		dout <= 1'b1;
	end
	else if(end_cnt_1) begin
		flag1 <= 1'b0;
	end
end

endmodule
