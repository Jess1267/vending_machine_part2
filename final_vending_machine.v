`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2024 11:20:53
// Design Name: 
// Module Name: final_vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module item(out, ld,clk,in,clr);
input [1:0]in;
input ld,clk,clr;
output reg [1:0]out;

always @(posedge clk)
begin
    if(ld)out<=in;
    else if(clr)out<=2'b00;
end

endmodule

module money(out,  ld,clr,clk,in);
input [3:0]in;
input ld,clr,clk;

output reg [3:0]out;

always @(posedge clk)
begin
    if(ld)out<=in;
    else if(clr)out<=4'b0000;
end
endmodule

module comp(out, value,money);
input [3:0]value,money;
output reg [1:0]out;

always @(*)
begin
    if(value==money)out<=2'b00;
    else if(value<money)out<=2'b01;
    else if(value>money)out<=2'b10;
end

endmodule

module sub(out, curr,money,signal);
input [3:0]curr,money;
input [1:0]signal;
output reg [3:0]out;

always @(*)
begin
    if(signal==2'b01)out<=curr-money;
    else if(signal==2'b10)out<=money-curr;
    else if(signal==2'b00)out<=4'b0000;
end
endmodule

module value(curr, ld_a,clr,ld_k,k,clk,temp);
input ld_a,clr,ld_k,clk;
input [3:0]temp,k;
output reg [3:0]curr;

always @(posedge clk)
begin
    if(ld_a)curr<=temp;
    else if(ld_k)curr<=k;
end
endmodule

module data_path(signal,item_number,curr,money,
                    clk,ld_item,clr_item,data_in, ld_money,clr_money,ld_k,k,ld_a,clr_a);
                    
input clk,ld_item,clr_item,
        ld_money,clr_money,
        ld_k,ld_a,clr_a;
        
input [3:0]data_in,k;

output [3:0]curr,money;
output [1:0]signal,item_number;

wire [3:0]temp;

item i (item_number,ld_item,clk,data_in[1:0],clr_item);
money m (money,ld_money,clr_money,clk,data_in);

value v (curr, ld_a,clr_a,ld_k,k,clk,temp);
comp c (signal,curr,money);
sub s (temp,curr,money,signal);

endmodule

module control_path(clk,start,signal,item,state,
                        ld_item,clr_item, ld_money,clr_money,ld_k,k,ld_a,clr_a,e);

input clk,start;
input [1:0]item,signal;
output reg ld_item,clr_item, ld_money,clr_money, ld_k,ld_a,clr_a, e;
output reg [3:0]k,state;

parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=4'b0100,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=4'b1000,s9=4'b1001,s10=4'b1010,s11=4'b1011;
//reg [3:0] state;

always @(posedge clk)
    case(state)
        s0:begin
            if(start)state<=s1;
           end
        s1:begin
            if(item==2'b00)state<=s2;
            else if(item==2'b01)state<=s3;
            else if(item==2'b10)state<=s4;
            else if(item==2'b11)state<=s5;
           end
         s2:state<=s6;
         s3:state<=s6;
         s4:state<=s6;
         s5:state<=s6;
         
         s6:begin
             
             if(signal==2'b00)state<=s10;
             else if(signal==2'b01)state<=s9;
             else if(signal==2'b10)state<=s7;
             else if(signal==2'b11)state<=s8;
            end
         s7:state<=s6;
         s8:state<=s10;
         s9:state<=s10;
         s10:state<=s10;
         
         default:state<=s0;
    endcase
    
always @(state)
    case(state)
        s0:begin ld_item=0; clr_item=1; ld_money=0; clr_money=1; ld_k=0; k=4'b0000; ld_a=0; clr_a=1; e=0; end
        s1:begin ld_item=1; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=0; clr_a=0; e=0; end
        s2:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=1; k=4'b0111; ld_a=0; clr_a=0; e=0; end //7
        s3:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=1; k=4'b0101; ld_a=0; clr_a=0; e=0; end //5
        s4:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=1; k=4'b0010; ld_a=0; clr_a=0; e=0; end//2
        s5:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=1; k=4'b1010; ld_a=0; clr_a=0; e=0; end//10
        s6:begin ld_item=0; clr_item=0; ld_money=1; clr_money=0; ld_k=0; k=4'b0000; ld_a=0; clr_a=0; e=0; end
        s7:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=1; clr_a=0; e=0; end
        s8:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=1; clr_a=0; e=0; end
        s9:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=1; clr_a=0; e=0; end
        s10:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=0; clr_a=0; e=1; end
        default:begin ld_item=0; clr_item=0; ld_money=0; clr_money=0; ld_k=0; k=4'b0000; ld_a=0; clr_a=0; e=0; end
    endcase
        
endmodule

module final_vending_machine(e,curr,state,money,item_number,start,clk,data);
input start,clk;
input [3:0]data;

output e;
output [3:0]curr,state,money;
output [1:0]item_number;

wire [1:0]signal;
wire ld_item,clr_item,ld_money,clr_money,ld_k,ld_a,clr_a;
wire [3:0]k;

data_path d (signal,item_number,curr,money,clk,ld_item,clr_item,data, ld_money,clr_money,ld_k, k,ld_a,clr_a);

control_path c (clk,start,signal,item_number,state, ld_item,clr_item, ld_money,clr_money,ld_k,k,ld_a,clr_a,e);

endmodule
