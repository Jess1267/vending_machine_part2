`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2024 14:43:43
// Design Name: 
// Module Name: final_vending_machine_tb
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


module final_vending_machine_tb;
reg clk,start;
reg [3:0]data;
wire e;
wire [3:0]curr,state,money;
wire [1:0]item_number;

final_vending_machine dut (e,curr,state,money,item_number,start,clk,data_in);

initial
begin
    clk=1'b0;
    start=1'b1;
end

always #5 clk=~clk;

initial
begin
   #11 data=4'b0000;
   #11 data=4'b0100;
   #11 data=4'b0010;
   #11 data=4'b0001;
   #11 data=4'b0010;
   #100 $finish;
end
endmodule
