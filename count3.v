//功能描述：
//  当收到en=1时，dout产生一个宽度为10的高电平脉冲。

//起始点:add_cnt = dout==1     结束点;end_cnt = add_cnt && cnt==10-1

module count_1(
          clk,  
          en,
          dout
         );

    input clk;
    input en;
     
    output reg dout;
   
    reg  [3:0] cnt;
    wire add_cnt;
    wire end_cnt;    
//    reg  dout;    
 
   always  @(posedge clk or negedge rst_n)begin
       if(rst_n==1'b0)begin
           cnt <= 4'b0;
       end
       else if(add_cnt) begin
            if(end_cnt)
               cnt <= 4'b0;
            else 
               cnt <= cnt + 1;
       end
   end

   assign add_cnt = dout==1;
   assign end_cnt = add_cnt && cnt==10-1;

   always  @(posedge clk or negedge rst_n)begin
       if(rst_n==1'b0)begin
           dout <= 0;
       end
       else if(en) begin
           dout <= 1;
       end
       else if(end_cnt) begin
           dout <= 0;
       end
   end
endmodule
