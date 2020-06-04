`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2020 12:02:37 PM
// Design Name: 
// Module Name: testb
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module testb;
    //inputs
    reg clock;
    reg reset;
    reg in_tvalid;
    reg in_tlast;
    reg [255:0] in_tdata;
    reg [31:0] in_tstrb;
    reg out_tready;
    
    //outputs
    wire out_tvalid;
    wire out_tlast;
    wire [31:0] out_tstrb;
    wire [255:0] out_tdata;
    wire in_tready;
    
    //UUT
    udpparser uut(
    .clock(clock),
    .reset(reset),
    .in_tdata(in_tdata),
    .in_tvalid(in_tvalid),
    .in_tstrb(in_tstrb),
    .in_tlast(in_tlast), 
    .in_tready(in_tready),
    .out_tdata(out_tdata),
    .out_tvalid(out_tvalid),
    .out_tstrb(out_tstrb),
    .out_tlast(out_tlast),
    .out_tready(out_tready)
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
   reset=1;
   in_tvalid =1;
   in_tdata = 256'd0;
   #6.25;
   in_tdata = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001;
   in_tlast = 1;
   #6.25;
   
   end
  
  
  
   
endmodule
