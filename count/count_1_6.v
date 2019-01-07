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

reg [3:0] count;
wire add_cnt;
wire end_cnt;
reg flag0;
reg flag1;
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

assign add_cnt = flag0==1;
assign end_cnt = add_cnt && (flag1==1 && cnt==11-1 || flag1==0 && cnt==12-1);

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        flag0 <= 1'b0;
    end
    else if(en1 || en2) begin
        flag0 <= 1'b1;
    end
    else if(end_cnt) begin
        flag0 <= 1'b0;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        flag1 <= 1'b0;
    end
    else if(en1) begin
        flag1 <= 1'b1;
    end
    else if(en2) begin
        flag1 <= 1'b0;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        dout <= 1'b0;
    end
    else if(add_cnt && (flag1==1 && cnt==10-1 || flag1==0 && cnt==5-1)) begin
        dout <= 1'b1;
    end
    else if(end_cnt) begin
        dout <= 1'b0;
    end
end

endmodule
