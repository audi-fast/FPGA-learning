module(
	clk,
	rst_n,
	en,
	dout
          );

input clk;
input rst_n;
input en;
output [1:0] dout;

reg [2:0] cnt0;
reg [1:0] cnt1;
wire add_cnt0;
wire end_cnt0;
wire add_cnt1;
wire end_cnt1;
reg flag;
reg [1:0] dout;

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

assign add_cnt0 = flag==1;
assign end_cnt0 = add_cnt0 && cnt0==6-1;

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

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1==3-1;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag <= 1'b0;
	end
	else if(en) begin
		flag <= 1'b1;
	end
	else if(end_cnt1) begin
		flag <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		dout <= 1'b0;
	end
	else if(add_cnt0 && cnt0==1-1) begin
		dout <= 2'b11;
	end
	else if(end_cnt0) begin
		dout <= 1'b0;
	end
end

endmodule
