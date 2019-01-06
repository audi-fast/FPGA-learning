//always @(posedge clk or negedge rst_n)
//    if(!rst_)begin
//        flag<=1'b0;
//    end
//    else begin
//        if(en1==1'b1)
//            flag<=1'b1;
//        else if(en2==1'b1)
//            flag<=1'b0;
//    end                         //不用内嵌

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        flag <= 0;
    end
    else if(en1)begin
        flag <= 1;
    end
    else if(en2)begin
        flag <= 0;
    end
end

    
//加1计数器，用于大部分计数情况

assign count_add =dout==0;       //加1条件；
assign count_end =count_add&&(flag==1&&count==5-1||flag==0&&count==7-1)    //结束条件、尾值；

always @(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        count <= 0;
    end
    else if(count_add)begin
        if(count_end)
            count <= 0;
        else
            count <= count + 1;
    end
end
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        dout<=1'b1;
    end
    else if(en1||en2)begin
        dout<=1'b0;
    end
    else if(count_end)begin
        dout<=1'b1;
    end
end


