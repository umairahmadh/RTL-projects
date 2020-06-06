`timescale 1ns / 1ps

module testbench;
    //inputs
    reg [7:0] data_in;
    reg reset;
    reg clk;
    reg enable;
    reg data_valid_in;
    //outputs
    wire detected_out;
    wire data_valid_out;  
    
    //Unit under Test
    SQD uut (
     .data_in(data_in),
     .reset(reset),
     .clk(clk),
     .enable(enable),
     .data_valid_in(data_valid_in),
        
    .detected_out(detected_out),
    .data_valid_out(data_valid_out)
    
    );
  
initial begin
  clk = 0;
  forever #5 clk =~clk;
  end

initial 
begin
  data_valid_in =0;
  data_in = 8'h00;
  reset = 1;  
  enable = 0;
  
  #30;
     reset = 0;
     enable = 1;
     data_valid_in =1;
  #40;
     data_in = 8'hAA;
  #20;
     data_in = 8'hFF;
     
  #10;
  data_valid_in =0;
     data_in = 8'hCF;
     
  #10;
     data_valid_in =1;
     data_in = 8'hCF;
  #10;
     data_in = 8'hEF;
  #10;
     data_in = 8'hFF;
  #10;
     data_in = 8'hAA;
  #20;
     data_in = 8'hFF;
  #10;
     data_in = 8'hCF;
  #10;
  
     data_in = 8'hAA;
  #20;
     data_in = 8'hFF;   
  #10;
  //trying to reset in the middle of the sequence
     reset  = 1;
     data_in = 8'hCF;
  #10;
     reset  = 0;
     data_in = 8'hCF;
  #10;
     data_in = 8'hAA;
  #20;
     data_in = 8'hFF;   
  #10;
     data_in = 8'hCF;
  #10;
  
  
  #10 $finish;
  end
  
endmodule
 
  
  
