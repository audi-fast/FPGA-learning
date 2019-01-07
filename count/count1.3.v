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

reg [2:0] cnt;
wire add_cnt;
wire end_cnt;
reg flag; 
reg dout;


always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt <= 3'b0;
    end
    else if(add_cnt) begin
         if(end_cnt)
             cnt <= 3'b0;
         else
             cnt <= cnt + 1;
     end
 end

 assign add_cnt = dout==0;
 assign end_cnt = add_cnt && (flag <= 1 && cnt=5-1 || flag <= 0 && cnt=7-1);

 always  @(posedge clk or negedge rst_n)begin
     if(rst_n==1'b0)begin
         flag <= 1'b0;
     end
     else if(en1) begin
         flag <= 1'b1;
     end
     else if(en2) begin
         flag <= 1'b0;
     end
 end
 
 always  @(posedge clk or negedge rst_n)begin
     if(rst_n==1'b0)begin
         dout <= 1'b1;
     end
     else if(en1 || en2) begin
         dout <= 1'b0;
     end
     else if(end_cnt)begin
         dout <= 1'b1;
     end
 end

 endmodule



















