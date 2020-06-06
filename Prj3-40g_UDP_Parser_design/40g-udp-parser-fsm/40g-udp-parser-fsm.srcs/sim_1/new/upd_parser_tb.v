`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2020 05:21:26 AM
// Design Name: 
// Module Name: upd_parser_tb
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


module upd_parser_tb();
    //---------------------------------------
    // inputs to DUT
       reg clock;
       reg reset, in_tvalid, in_tlast;
       reg [255:0] in_tdata;
       reg out_tready;
    //------------------------------------------
    // outputs from DUT
       wire in_tready;
       wire out_tvalid;
       wire [255:0] out_tdata;
       wire [2:0] out_debug1;
       wire [31:0] out_debug2;
       wire [31:0] out_debug3;

    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // instantiate DUT
    udp_parser_top UUT ( .clock(clock),
                            .reset(reset),
                            .out_tready(out_tready),
                            .in_tready(in_tready),
                            .in_tdata(in_tdata),
                            .in_tvalid(in_tvalid),
                            .in_tlast(in_tlast),
                            .out_tvalid(out_tvalid),
                            .out_tdata(out_tdata),
                            .out_debug1(out_debug1),
                            .out_debug2(out_debug2),
                            .out_debug3(out_debug3)
                        );
                            
     //-----------------------------------------------
     //Clock
     //Clock tick
     initial
        begin
            clock = 0;
            forever #3.125 clock =~clock;
        end                       

     //----------------------------------------------------
     //Data input
     initial
        begin
            out_tready=1;       //always ready to receive output from the machine
            reset =1;
            #6.25;
            reset=0;
            #6.25;
            in_tlast=0;
            in_tvalid=1;
            in_tdata = 0;
            //next frame with OpCode =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000010203040506070800000000000100000002000000030000000400000005;
            // next frame with data
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000100000002000000030000000400000005000000060000000700000008;
            //next frame with tlast =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000100000002000000030000000400000005000000060000000700000008;
            //next frame with tlast =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h000000010000000200000003000000040000000500000006000000070000000a;
            //next frame with tlast =0 
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h000000010000000200000003000000040000000500000006000000070000000b;
            //next frame with tlast =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h00000001000000010000000100000001;
            in_tlast=1;
            //again sending a sum operaton for different data
            #6.25;
            in_tlast=0;
            in_tvalid=1;
            in_tdata = 0;
            //next frame with OpCode =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000010203040506070800000000000100053002000000030000450400000005;
            // next frame with data
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000100000002000000030000000400000005000000060000000700000008;
            //next frame with tlast =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h00000001000000010000000100000001;
            in_tlast=1;
            #6.25;
            in_tlast=0;
            in_tvalid=1;
            in_tdata = 0;
            //next frame with OpCode =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000010203040506070800010000000100000002000000030000000400000005;
            // next frame with data
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000100000002000000030000035400000005000000060000000700000008;
            //next frame with tlast =0
/*            #6.25;
            in_tvalid=0;
            in_tdata = 256'h0000000100000001FFFFFFF100000001;
            in_tlast=1;*/
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000100000001FFFFFFF100000001;
            in_tlast=1;
//            #6.25;
//            reset=1;
            #6.25;
            in_tlast=0;
            in_tvalid=1;
            in_tdata = 0;
            //next frame with OpCode =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000010203040506070800020000000300000002000000030000000400000005;
            // next frame with data
            /*#6.25;
            in_tvalid=0;
            in_tdata = 256'h0000000700000002000000030000035400000005000000010000000700000008;
            //next frame with tlast =0*/
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000000700000002000000030000035400000005000000010000000700000008;
            //next frame with tlast =0
            #6.25;
            in_tvalid=1;
            in_tdata = 256'h0000005400000023FFFFFFF100000456;
            in_tlast=1;
            #6.25;
            reset=1;
        end
     


endmodule
