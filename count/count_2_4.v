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
output [1:0]dout;

reg [3:0] cnt;
wire add_cnt;
wire end_cnt;
reg flag1;
reg flag2;
reg [1:0] dout;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b1)begin
		cnt <= 1'b0;
	end
	else if(add_cnt) begin
		if(end_cnt)
			cnt <= 1'b0;
		else
			cnt <= cnt1 + 1;
	end
end

assign add_cnt = flag1==1 || flag2==1;
assign end_cnt = flag1==1 && cnt==4-1 || flag2==2 && cnt==9-1;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag1 <= 1'b0;
	end
	else if(en1) begin
		flag1 <= 1'b1;
	end
	else if(flag1==1 && cnt1==4-1) begin
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
	else if(flag2==2 && cnt==9-1) begin
		flag2 <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		dout <= 1'b0;
	end
	else if(flag1==1 && cnt==3-1 ||  flag2==1 && cnt==4-1)) begin
		dout <= 2'b10;
	end
	else if(end_cnt) begin
		dout <= 1'b0;
	end
end

endmodule
