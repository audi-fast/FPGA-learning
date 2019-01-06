module count_2(
    clk,
    en,
    dout
    );

input clk;
input en;

output dout;

reg [2:0] cnt;
wire add_cnt;
wire end_cnt;
reg dout;


always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt <=3'b0;
    end
    else if(add_cnt) begin
         if(end_cnt)
             cnt <= 3'b1;
         else
             cnt <= cnt + 1;
     end
 end
 
 assign(add_cnt) = dout<=0;
 assign(end_cnt) = add_cnt && cnt=5-1;

 always  @(posedge clk or negedge rst_n)begin
     if(rst_n==1'b0)begin
         dout <= 1;
     end
     else if(en) begin
         dout <= 0;
     end
     else if(end_cnt) begin
         dout<=1;
     end
 end

endmodule
