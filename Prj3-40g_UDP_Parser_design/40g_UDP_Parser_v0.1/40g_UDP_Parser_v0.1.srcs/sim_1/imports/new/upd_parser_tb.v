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
//       wire [2:0] out_debug1;
//       wire [31:0] out_debug2;
//       wire [31:0] out_debug3;

    //------------------------------------------
    // Adding some registers to store randomly generated stuffs
    reg [255:0] frame1_headers;
    reg [79:0] frame2_headers;
    reg [15:0] frame2_opCode;
    reg [255:0] integerData;
   // integer count;  //to count through generating integers
  //  integer i;  //for packet loop
  //  integer j;  //for integer loop
    integer count, sum, max, min,i, j, seed;

    
    
    
    
    
    
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
                            .out_tdata(out_tdata)
                            );
 /*                           
                            .out_debug1(out_debug1),
                            .out_debug2(out_debug2),
                            .out_debug3(out_debug3)
                        );
*/                        
                            
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
        
        /*
             out_tready=0;       //always ready to receive output from the machine
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
            #6.25; 
            // end of manual veirfifacation
          */
          
            
            //output verirfication
          //  out_tready =1;
          //  if (out_tdata ==            

          //       
   //     end
///*
            //#6.25;
            //reset=1;
            
            
            // staryting automatic random data transfer
             // data packets
             reset =1;
             #6.25;
            reset=0;
            #6.25;
                for (i=0; i<15 ; i= i+1) begin
              //  $srandom;
                    seed = i+1;
                    $display(" seed is set %d",seed);
                 //   void'($urandom(seed));
                  //  $urandom(seed);
                  //  $urandom(seed);
                   frame1_headers =  {$urandom(i+1),$urandom,$urandom,$urandom,$urandom,$urandom,$urandom,$urandom};
                   frame2_headers =  {$urandom,$urandom,$urandom(i+7)};
                   frame2_opCode =  $urandom_range(8'h2,8'h0);
                   //frame2_opCode =  0 + $random % 2 ;   //$urandom_range(8'h2,8'h0);
                   integerData[255:0] = 0;
                      $display("Frame1 Headers = %h",frame1_headers);
                      $display("frame2 Headers = %h, OpCode = %h ",frame2_headers,frame2_opCode );
                   sum = 0;

                   for (j=0; j<160; j = j+32) begin
                      //integerData[i +:32] = $urandom;
                      integerData[j +:32] = $urandom_range(32'd1000,32'd0);
                      $display("Integers: = %d", integerData[j +:32] );
                      
                      
                      case(frame2_opCode)
                        0: begin
                            sum = sum+ integerData[j +:32] ;
                        end
                        
                        1: begin //max
                            if (j==0) max = integerData[j +:32];
                            else if( integerData[j +:32] > max) max =  integerData[j +:32];
                            else max = max;
                        end                        
                        
                        2: begin //min
                            if (j==0) min = integerData[j +:32];
                            else if( integerData[j +:32] < min) min =  integerData[j +:32];
                            else min = min;
                        end
                      
                      endcase
                   end
                   
                   //first frame - only headers
                 //  #6.25;
                  //  out_tready =0;
                    in_tlast=0;
                    in_tvalid=1;
                    in_tdata = frame1_headers;

                   //second frame - opcode and data 
                   #6.25;
                    in_tvalid=1;
                    in_tdata = {frame2_headers, frame2_opCode,integerData[159:0]} ;
                    
                   // third to the not_last frame
                   for (count =0; count<60; count = count+1)begin
                                       
                    for (j=0; j<256; j = j+32) begin
                       //integerData[i +:32] = $urandom;
                      integerData[j +:32] = $urandom_range(32'd1000,32'd0000);
                     // $display("Integers2: = %d", integerData[j +:32] );
                      
                      case(frame2_opCode)
                        0: begin
                            sum = sum+ integerData[j +:32] ;
                        end
                        
                        1: begin //max
                            if( integerData[j +:32] > max) max =  integerData[j +:32];
                            else max = max;
                        end                        
                        
                        2: begin //min
                            if( integerData[j +:32] < min) min =  integerData[j +:32];
                            else min = min;
                        end
                      
                      endcase
                    end
                    #6.25;
                    in_tvalid=1;
                    in_tdata = integerData[255:0] ;
                   end
                   
                   //last frame
                                      
                    for (j=0; j<128; j = j+32) begin
                      //integerData[i +:32] = $urandom;
                      integerData[j +:32] = $urandom_range(32'd1000,32'd0000);
                      $display("Integers3: = %d", integerData[j +:32] );
                      case(frame2_opCode)
                        0: begin
                            sum = sum+ integerData[j +:32] ;
                        end
                        
                        1: begin //max
                            if( integerData[j +:32] > max) max =  integerData[j +:32];
                            else max = max;
                        end                        
                        
                        2: begin //min
                            if( integerData[j +:32] < min) min =  integerData[j +:32];
                            else min = min;
                        end
                      
                      endcase
                      
                      
                    end
                    
                    
                    #6.25; 
                    in_tvalid=1;
                    in_tdata = integerData[127:0] ;
                    in_tlast=1;
                    out_tready =1;
                    //#1.25;
                    #6.25;
                       case(frame2_opCode)
                        0: begin
                            $display("Expected SUM: = %d", sum );
                            $display("Actual SUM: = %d", out_tdata );
                            if(out_tdata == sum) $display("PASS"); else $display(" FAIL ");
                        end
                        
                        1: begin //max
                            $display("Expected MAX: = %d", max );
                            $display("Actual MAX: = %d", out_tdata );
                            if(out_tdata == max) $display("PASS"); else $display(" FAIL ");
                        end                        
                        
                        2: begin //min
                            $display("Expected MIN: = %d", min );
                            $display("Actual MIN: = %d", out_tdata );
                            if(out_tdata == min) $display("PASS"); else $display(" FAIL ");
                        end
                      
                      endcase
                    
                   // #1.25;
                    
                  // $display("frame1_headers = %h,frame2_headers = %h,frame2_opCode = %h ",frame1_headers,frame2_headers,frame2_opCode );
                  // #6.25;
                   

                end // for packet
                
                end //enf of initial block
//  */  

     


endmodule
