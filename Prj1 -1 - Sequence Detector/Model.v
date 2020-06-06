//G.S. Umair Ahmadh
//Sequence detection (case study)

`timescale 1ns / 1ps
module SQD(
//defining input ports
    input[7:0] data_in,
    input reset,
    input clk,
    input enable,
    input data_valid_in,
//output ports
    output reg detected_out = 0,
    output reg data_valid_out  
    );
//states    
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b011,
              S3 = 3'b010,
              S4 = 3'b110;
//registers to track current and next states
    reg [2:0] current_state, next_state;

//For each clocks, for the purpose of updating the state, if the reset goes high, current state will be S0
//if enable goes low, state will go to S0
//Else: the next state will be updated as the current state   
    always @ (posedge clk, posedge reset, posedge enable)
    begin
      if(reset==1 | enable==0)
      current_state <= S0;
      else
      current_state <= next_state;
    end

//wheneever the current state or the data_in or  data_valid_in changes, it has to determine
//which state is going to be the next
    always @(current_state, data_in, data_valid_in)
    begin
    if(enable ==1)
      if(data_valid_in ==1)
          case(current_state)
          S0:begin
            if(data_in == 8'hAA)
              next_state <= S1;
            else
              next_state <= S0;
             end
          
          S1:begin
            if(data_in ==8'hAA)
              next_state <= S2;
            else
              next_state <= S0;
             end
          
          S2:begin
            if(data_in ==8'hFF)
              next_state <= S3;
            else if(data_in ==8'hAA)
              next_state <= S2;
            else
              next_state <= S0;
             end
          
          S3:begin
            if(data_in ==8'hCF)
              next_state <= S4;
            else if(data_in ==8'hAA)
              next_state <= S1;
            else
              next_state <= S0;
             end
          
          S4:begin
            if(data_in ==8'hAA)
              next_state <= S1;
            else if(data_in ==8'hAA)
              next_state <= S1;
            else
              next_state <= S0;
             end
          default: next_state<=S0;
          endcase
      else next_state <= current_state;
     
     else next_state <= S0;
    end
      
//checking for output
    
    always @(current_state)
    begin 
      case(current_state)
        S0: begin data_valid_out <= 0; detected_out <= 0; end
        S1: begin data_valid_out <= 0; detected_out <= 0; end
        S2: begin data_valid_out <= 0; detected_out <= 0; end
        S3: begin data_valid_out <= 0; detected_out <= 0; end
        S4: begin data_valid_out <= 1; detected_out <= 1; end
        default: begin data_valid_out <= 0; detected_out <= 0; end
      endcase
      end
endmodule
