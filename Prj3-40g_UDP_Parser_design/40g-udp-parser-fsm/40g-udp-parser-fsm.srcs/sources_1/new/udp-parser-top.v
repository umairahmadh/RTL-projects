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
    input out_tready,
    output reg in_tready,
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
    reg doOperation;    
    integer i;  //for loops
    reg [2:0] state;
    //States as parameters
    parameter   IDLE = 0,           //Idle state. Nothing is being received. Not ready. No incoming, etc.
                FIRST_FRAME_RECEIVED = 1,    //First fram is received. Headers only. So data should be ignored
                SECOND_FRAME_RECEIVED =2,    //
                LAST_FRAME_RECEIVED =3,
                FINAL =4;
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
                    in_tready <=1;
                    state <= IDLE;  
                    doOperation =0;
                end
            else begin
               //state<=nextState;
               out_debug1 <= state;
               out_debug2 <= output_buffer;
<<<<<<< HEAD
               
               // transmitting the output buffer to the out_tdata port
               if(output_waiting && out_tready) begin
                out_tvalid <= 1;
=======
               if(output_waiting && out_tready) begin
                out_tvalid = 1;
>>>>>>> 924285812bbfa5c47f6015c0188b195aa3c0da70
                out_tdata <= output_buffer;
                output_waiting <= 0;
                output_buffer <= 0;
               end
               
               
               case(state)
            IDLE: begin         //
<<<<<<< HEAD
                sum <= 0;
                max <= 0;
                min <= 0;
                out_tvalid <= 0;
                in_tready <=1;
                if(in_tvalid && in_tready) begin  //&&in_tready  //receiving initial frame (Header frame)
                    state <= FIRST_FRAME_RECEIVED;    
                    doOperation <= ~doOperation;                        
=======
                sum = 0;
                max = 0;
                min = 0;
                out_tvalid = 0;
                in_tready =1;
                if(in_tvalid) begin  //&&in_tready  //receiving initial frame (Header frame)
                    state = FIRST_FRAME_RECEIVED;                            
>>>>>>> 924285812bbfa5c47f6015c0188b195aa3c0da70
                end 
                else state <= IDLE;
            end
            
            FIRST_FRAME_RECEIVED: begin
            in_tready =1;
                if(in_tvalid && in_tready) begin //&&in_tready       //recevigin second frame with OpCode
<<<<<<< HEAD
                    opCode <= in_tdata[160 +: 16];
                    data_under_operation <= in_tdata[0 +: 160];
                    doOperation <= ~doOperation;      
                    state <= SECOND_FRAME_RECEIVED;
=======
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
>>>>>>> 924285812bbfa5c47f6015c0188b195aa3c0da70
                    end
                 else state <= FIRST_FRAME_RECEIVED;  
            end
            
            SECOND_FRAME_RECEIVED: begin   
<<<<<<< HEAD
            in_tready <=1;      
                if(in_tvalid && ~in_tlast && in_tready) begin //&&in_tready       //recevigin a frame that is full of data but not the last frame.
                    data_under_operation <= in_tdata[0 +: 256];
                     doOperation <= ~doOperation;    
=======
            in_tready =1;      
                if(in_tvalid && ~in_tlast  && in_tready) begin //&&in_tready       //recevigin a frame that is full of data but not the last frame.
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
>>>>>>> 924285812bbfa5c47f6015c0188b195aa3c0da70
                                 
                    state <= SECOND_FRAME_RECEIVED;
                end
                
                else if(in_tvalid && in_tlast  && in_tready) begin
<<<<<<< HEAD
                    data_under_operation <= in_tdata[0 +: 128];
                    state <= FINAL;
=======
                    data_under_operation = in_tdata[0 +: 128];
                    case(opCode)
                            0: begin //sum
                                for (i=0; i<128; i = i+32)
                                    begin
                                        sum = sum + data_under_operation[i +: 32];
                                    end
                                    out_debug3 = sum;
                                    output_waiting =1;
                              //      out_tvalid =1;
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
                              //      out_tvalid =1;   
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
                               //     out_tvalid =1; 
                               end

                        endcase            

                    state = IDLE;
>>>>>>> 924285812bbfa5c47f6015c0188b195aa3c0da70
                
                end
              else state <= SECOND_FRAME_RECEIVED;
              
              end
              
              FINAL: begin 
              doOperation <= ~doOperation;
              state <= IDLE;
              end
        endcase
        end
           
        
        end
   
always @ (*) 
    begin
       case(state)
        FIRST_FRAME_RECEIVED: begin
        
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
          end 
          
          
        SECOND_FRAME_RECEIVED: begin  
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
       end
       
       FINAL: begin
            case(opCode)
                0: begin //sum
                        for (i=0; i<128; i = i+32)
                            begin
                                sum = sum + data_under_operation[i +: 32];
                            end
                            out_debug3 = sum;
                            output_waiting =1;
                      //      out_tvalid =1;
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
                      //      out_tvalid =1;   
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
                       //     out_tvalid =1; 
                       end

                endcase            
           
           end
    endcase
end


endmodule
