`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2020 09:36:04 AM
// Design Name: 
// Module Name: udp
// Project Name: 
// 
//////////////////////////////////////////////////////////////////////////////////


module udp(
            clock, 
            reset, in_tvalid, in_tdata, in_tlast, out_tdata, out_valid, out_debug);

    input clock, reset;
    input in_tvalid;
    input [255:0] in_tdata;
    input in_tlast;
    output reg [255:0] out_tdata;
    output reg out_valid;
    output reg [15:0] out_debug;
    
    reg [255:0] data;
    reg [15:0] opCode;
    integer frameCount;
    integer i;
    integer data_size;
    reg [31:0] sum;
    reg [31:0] max;
    reg [31:0] min;
    reg out_data_memory;
    always @ (posedge clock)
        begin
            if (!reset) //Go to idle state
                begin
                    data<=0;
                    frameCount<=0;
                    //debug
                    out_valid <= 0;
                    out_tdata <= 8'hA1;
                    opCode <= 5;
                end
            else if(in_tvalid) 
                begin
                    
                    frameCount <= frameCount+1;
                    
                end
            
            else begin 
                    frameCount <= frameCount;
                    //debug
                    out_valid <= 0;
                    out_tdata <= 8'hA2;
                 end
        
        end
     
    always @ (*)
        begin
            //initiating variables
            
            if (frameCount ==2) //second frame received
                begin
                    opCode = in_tdata[160 +: 16];
                    data = in_tdata[0 +: 160];
                    sum = 0;
                    max = data[0 +: 32];
                    min = data[0 +: 32];
                    data_size =160;
                     out_debug = sum;
                end
            else if(frameCount>2)
                begin
                opCode =opCode;
                    //data = in_tdata[255:0];
                    data_size = 256;
                    out_debug = sum;
                end
            
            //doing operations:
            
            case(opCode)
                0: begin
                    //sum
                    for (i=0; i<data_size; i = i+32)
                        begin
                          sum = sum + in_tdata[i +: 32];
                        end
                        out_valid=0;
                    out_tdata = sum;  //debug
//                   out_data_memory = sum;
                   end
                 1: begin
                    //max
                    for (i=0; i<data_size; i = i+32)
                        begin
                          if (max<in_tdata[i +: 32])
                            max = in_tdata[i +: 32];
                          else 
                            max = max;
                        end
//                        out_data_memory = max;
                        out_valid=0;
                     out_tdata = max;  //debug
                    end
                  2: begin
                     //min
                        for (i=0; i<data_size; i = i+32)
                           begin
                              if (min>in_tdata[i +: 32])
                                min = in_tdata[i +: 32];
                              else 
                                min = min;
                           end
//                           out_data_memory = min;
                         out_valid =0;  
                         out_tdata = min; //debug
                         
                        end   
                          
                  default: begin
                            out_valid =0;
                            out_tdata = 8'hA3; //debug        
                           end         
             endcase
            out_debug = sum;
            if(in_tlast ==1)
                begin
                 //frameCount =0;
                 out_valid =1;  
                 out_tdata = opCode; //debug         
                end
    
    
    end
        
    
    
    
    endmodule
