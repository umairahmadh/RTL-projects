`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2020 10:00:46 AM
// Design Name: 
// Module Name: testb
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


module testb;
    reg clock;
    reg reset;
    reg in_tvalid;
    reg [255:0] in_tdata;
    reg in_tlast;
    wire [255:0] out_tdata; 
    wire out_valid;
    wire [15:0] out_debug;
    
    
    udp uut(
        .clock(clock),
        .reset(reset),
        .in_tvalid(in_tvalid),
        .in_tdata(in_tdata),
        .in_tlast(in_tlast),
        .out_tdata(out_tdata),
        .out_valid(out_valid),
        .out_debug(out_debug)
     );
     
    //Clock tick
    initial
        begin
            clock = 0;
            forever #3.125 clock =~clock;
        end  
        
    initial
   begin
   //in_tready = 1;
   reset=0;
   #6.25;
      in_tlast =0;
   reset=1;
   in_tvalid =1;
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000000100;
   in_tlast =1;
   #6.25;
   reset=0;
   #6.25;
      in_tlast =0;
   reset=1;
   in_tvalid =1;
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000000100;
      in_tlast =1;
      #6.25;   
   reset=0;
   #6.25;
      in_tlast =0;
   reset=1;
   in_tvalid =1;   
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000001000;
      in_tlast =1;
   #6.25;   
   reset=0;
   #6.25;
   reset=1;
   //in_tvalid =0;   
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000001000;
      in_tlast =1;
   #6.25;
   
   //in_tvalid =0; 
   reset=0;
   #6.25;
   in_tlast =0;
   reset=1;
   in_tvalid =1;   
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000000100;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000011100000000000000000000000000000100000000000000000000000000000001010000000000000000000000000000011000000000000000000000000000000111;
      in_tlast =1;
   #6.25;
   in_tlast =0;
   in_tvalid=0;

   in_tdata = 0;
   end 
endmodule
