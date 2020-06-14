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
     wire [31:0] out_debug3;

    //------------------------------------------
    // Adding some registers to store randomly generated stuffs
    reg [255:0] frame1_headers;
    reg [79:0] frame2_headers;
    reg [15:0] frame2_opCode;
    reg [255:0] integerData;
   // integer count;  //to count through generating integers
  //  integer i;  //for packet loop
  //  integer j;  //for integer loop
    integer tb_count, tb_sum, tb_max, tb_min,tb_i, tb_j, seed;
    integer errorCount_sum, errorCount_max, errorCount_min ;

    
    
    
    
    
    
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
                            .out_debug3(out_debug3)
                            );
                         //   );
                          
/*                            .out_debug1(out_debug1),
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
              errorCount_sum = 0; // starting to count errors in the output
              errorCount_max = 0; // starting to count errors in the output
              errorCount_min = 0; // starting to count errors in the output
             #6.25;
            reset=0;
            #6.25;
                for (tb_i=0; tb_i<30 ; tb_i= tb_i+1) begin
               
                
              //  $srandom;
                    seed = tb_i+1;
                    $display("\n");
                 //   void'($urandom(seed));
                  //  $urandom(seed);
                  //  $urandom(seed);
                   frame1_headers =  {$urandom(tb_i+1),$urandom,$urandom,$urandom,$urandom,$urandom,$urandom,$urandom};
                   frame2_headers =  {$urandom,$urandom,$urandom(tb_i+71)};
                   frame2_opCode =  $urandom_range(8'h2,8'h0);
                   //frame2_opCode =  0 + $random % 2 ;   //$urandom_range(8'h2,8'h0);
                   integerData[255:0] = 0;
                 //     $display("Frame1 Headers = %h",frame1_headers);
                 //     $display("frame2 Headers = %h, OpCode = %h ",frame2_headers,frame2_opCode );
                   tb_sum = 0;

                   for (tb_j=0; tb_j<128; tb_j = tb_j+32) begin
                      //integerData[i +:32] = $urandom;
                      integerData[tb_j +:32] = $urandom_range(32'd1000,32'd0);
                      $display("Integers: = %d", integerData[tb_j +:32] );
                      
                      
                      case(frame2_opCode)
                        0: begin
                            tb_sum = tb_sum+ integerData[tb_j +:32] ;
                        end
                        
                        1: begin //max
                            if (tb_j==0) tb_max = integerData[tb_j +:32];
                            else if( integerData[tb_j +:32] > tb_max) tb_max =  integerData[tb_j +:32];
                            else tb_max = tb_max;
                        end                        
                        
                        2: begin //min
                            if (tb_j==0) tb_min = integerData[tb_j +:32];
                            else if( integerData[tb_j +:32] < tb_min) tb_min =  integerData[tb_j +:32];
                            else tb_min = tb_min;
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
                   for (tb_count =0; tb_count<60; tb_count = tb_count+1)begin
                                       
                    for (tb_j=0; tb_j<=224; tb_j = tb_j+32) begin
                       //integerData[i +:32] = $urandom;
                      integerData[tb_j +:32] = $urandom_range(32'd1000,32'd0000);
                      $display("Integers2: = %d", integerData[tb_j +:32] );
                      
                      case(frame2_opCode)
                        0: begin
                            tb_sum = tb_sum+ integerData[tb_j +:32] ;
                        end
                        
                        1: begin //max
                            if( integerData[tb_j +:32] > tb_max) tb_max =  integerData[tb_j +:32];
                            else tb_max = tb_max;
                        end                        
                        
                        2: begin //min
                            if( integerData[tb_j +:32] < tb_min) tb_min =  integerData[tb_j +:32];
                            else tb_min = tb_min;
                        end
                      
                      endcase
                    end
                    #6.25;
                    in_tvalid=1;
                    in_tdata = integerData[255:0] ;
                   end
                   
                   //last frame
                                      
                    for (tb_j=0; tb_j<=96; tb_j = tb_j+32) begin
                      //integerData[i +:32] = $urandom;
                      integerData[tb_j +:32] = $urandom_range(32'd1000,32'd0000);
                     $display("Integers3: = %d", integerData[tb_j +:32] );
                      case(frame2_opCode)
                        0: begin
                            tb_sum = tb_sum+ integerData[tb_j +:32] ;
                        end
                        
                        1: begin //max
                            if( integerData[tb_j +:32] > tb_max) tb_max =  integerData[tb_j +:32];
                            else tb_max = tb_max;
                        end                        
                        
                        2: begin //min
                            if( integerData[tb_j +:32] < tb_min) tb_min =  integerData[tb_j +:32];
                            else tb_min = tb_min;
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
                            $display("Expected SUM: = %d", tb_sum );
                            $display("Actual SUM: = %d", out_tdata );
                            if(out_tdata == tb_sum) $display("PASS"); 
                            else begin
                             $display(" FAIL ");
                             errorCount_sum = errorCount_sum+1;
                             end
                        end
                        
                        1: begin //max
                            $display("Expected MAX: = %d", tb_max );
                            $display("Actual MAX: = %d", out_tdata );
                            if(out_tdata == tb_max) $display("PASS"); 
                            else begin
                             $display(" FAIL ");
                             errorCount_max = errorCount_max+1;
                             end
                        end                        
                        
                        2: begin //min
                            $display("Expected MIN: = %d", tb_min );
                            $display("Actual MIN: = %d", out_tdata );
                            if(out_tdata == tb_min) $display("PASS"); 
                            else begin
                             $display(" FAIL ");
                             errorCount_min = errorCount_min+1;
                             end
                        end
                      
                      endcase
                    
                   // #1.25;
                    
                  // $display("frame1_headers = %h,frame2_headers = %h,frame2_opCode = %h ",frame1_headers,frame2_headers,frame2_opCode );
                  // #6.25;
                   

                end // for packet
                if (errorCount_sum > 0 || errorCount_max > 0 || errorCount_min > 0 ) begin
                    $display ("FAILED with %d Errors", errorCount_sum+errorCount_max+errorCount_min);
                    $display ("Errors in SUM: %d", errorCount_sum);
                    $display ("Errors in MAX: %d", errorCount_max);
                    $display ("Errors in MIN: %d", errorCount_min);
                end
    end //enf of initial block
//  */  

     


endmodule
