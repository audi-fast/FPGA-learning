module(
	clk,
	rst_n,
	en,
	dout
          );

input clk;
input rst_n;
input en;

output dout;

reg [4:0] cnt;
wire add_cnt;
wire end_cnt;
reg flag;
reg dout;

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

assign add_cnt = flag==1;
assign end_cnt = add_cnt && cnt==29-1;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		flag <= 1'b0;
	end
	else if(en) begin
		flag <= 1'b1;
	end
	else if(end_cnt) begin
		flag <= 1'b0;
	end
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		dout <= 1'b0;
	end
	else if(add_cnt && (cnt==2-1 || cnt==9-1 || cnt==18-1 || cnt==23-1)) begin
		dout <= 1'b1;
	end
	else if(add_cnt && (cnt==7-1 || cnt==16-1 || cnt==21-1 || cnt==29-1)) begin
		dout <= 1'b0;
	end
end

endmodule
