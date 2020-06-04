`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Accelr
// Designer: G.S. Umair Ahmadh 
// 
// Create Date: 06/03/2020 03:40:31 PM
// Design Name: 40G UDP Parser Design
// Module Name: udp-parser-top
// Project Name: 40G UDP Parser Design
// Target Devices: N/A
// Tool Versions: Vivado 2019.2
// Description: 40G UDP Parser Design
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module udp_parser_top(  
    input clock,
    input reset,
    input [255:0] in_tdata,
    input in_tvalid,
    input in_tlast,
    output reg out_tvalid,
    output reg [255:0] out_tdata,
    output reg [2:0] out_debug1,
    output reg [31:0] out_debug2,
    output reg [31:0] out_debug3
    //input out_tready
    );
    
    reg [255:0] data_under_operation;   //store the integers from the received frame in order to process (SUM/MAX/MIN)
    reg [255:0] output_buffer;
    reg [15:0] opCode;  //OpCode
    reg [31:0] sum;
    reg [31:0] max;
    reg [31:0] min;
    reg output_waiting;
        
    integer i;  //for loops
    reg [2:0] state;
    //States as parameters
    parameter   IDLE = 0,           //Idle state. Nothing is being received. Not ready. No incoming, etc.
                FIRST_FRAME_RECEIVED = 1,    //First fram is received. Headers only. So data should be ignored
                SECOND_FRAME_RECEIVED =2,    //
                LAST_FRAME_RECEIVED =3;
                //LAST_FRAME_RECEIVED=4;
                
    //
    always @ (posedge clock)
        begin
            if(reset)
                begin
                    data_under_operation <= 0;
                    output_buffer <=0;
                    opCode <= 0;
                    sum <= 0;
                    max <=0;
                    min <= 0;
                    state <= IDLE;  
                end
            else begin
               //state<=nextState;
               out_debug1 <= state;
               out_debug2 <= output_buffer;
               if(output_waiting) begin
                out_tdata <= output_buffer;
                output_waiting <= 0;
               end
               
                
            end
           
        
        end
    
always @ (in_tdata) 
    begin
        case(state)
            IDLE: begin         //
                sum = 0;
                max = 0;
                min = 0;
                
                if(in_tvalid) begin  //&&in_tready  //receiving initial frame (Header frame)
                    state = FIRST_FRAME_RECEIVED;                            
                end 
                else state = IDLE;
            end
            
            FIRST_FRAME_RECEIVED: begin
                if(in_tvalid) begin //&&in_tready       //recevigin second frame with OpCode
                    opCode = in_tdata[160 +: 16];
                    data_under_operation = in_tdata[0 +: 160];
                    max = data_under_operation [31:0];
                    min = data_under_operation [31:0];
                        case(opCode)
                            0: begin //sum
                                for (i=0; i<160; i = i+32)
                                    begin
                                        sum = sum + data_under_operation[i +: 32];
                                    end
                                out_debug3 = sum;
                               end
                            
                            1: begin
                               //do things
                               for (i=0; i<160; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]>max) max = data_under_operation[i +: 32];
                                        else max = max;
                                    end
                                out_debug3 = max;    
                                 
                               end
                               
                            2: begin
                               //do things
                               //do things
                               for (i=0; i<160; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]<min) min = data_under_operation[i +: 32];
                                        else min = min;
                                    end
                               out_debug3 = min;
                               end

                        endcase     
                                       
                        state = SECOND_FRAME_RECEIVED;
                    end
                 else state = FIRST_FRAME_RECEIVED;  
            end
            
            SECOND_FRAME_RECEIVED: begin         
                if(in_tvalid && ~in_tlast) begin //&&in_tready       //recevigin a frame that is full of data but not the last frame.
                    data_under_operation = in_tdata[0 +: 256];
                    case(opCode)
                            0: begin //sum
                                for (i=0; i<256; i = i+32)
                                    begin
                                        sum = sum + data_under_operation[i +: 32];
                                    end
                                    
                                    out_debug3 = sum;
                               end
                            
                            1: begin
                               //do things
                               for (i=0; i<256; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]>max) max = data_under_operation[i +: 32];
                                        else max = max;
                                    end
                                    out_debug3 = max;
                               end
                               
                            2: begin
                               //do things
                               //do things
                               for (i=0; i<256; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]<min) min = data_under_operation[i +: 32];
                                        else min = min;
                                    end
                                    out_debug3 = min;
                               end

                        endcase     
                                 
                    state = SECOND_FRAME_RECEIVED;
                end
                
                else if(in_tvalid && in_tlast) begin
                    data_under_operation = in_tdata[0 +: 128];
                    case(opCode)
                            0: begin //sum
                                for (i=0; i<128; i = i+32)
                                    begin
                                        sum = sum + data_under_operation[i +: 32];
                                    end
                                    out_debug3 = sum;
                                                            output_waiting =1;
                        output_buffer = sum;   
                               end
                            
                            1: begin
                               //do things
                               for (i=0; i<128; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]>max) max = data_under_operation[i +: 32];
                                        else max = max;
                                    end
                                    out_debug3 = max;
                                                            output_waiting =1;
                        output_buffer = max;   
                               end
                               
                            2: begin
                               //do things
                               //do things
                               for (i=0; i<128; i = i+32)
                                    begin
                                        if(data_under_operation[i +: 32]<min) min = data_under_operation[i +: 32];
                                        else min = min;
                                    end
                                    out_debug3 = min;
                                                            output_waiting =1;
                        output_buffer = min;   
                               end

                        endcase            

                    state = IDLE;
                
                end
              else state = SECOND_FRAME_RECEIVED;
              
              end
        endcase
        
    end


endmodule
