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
 
 
 ////////////////////////////////////////////////////////////////
////////////////////// For random inputs ///////////////////////
integer i; //for randomizing inputs in a loop
reg [7:0] a; //first random input data in sequence of 4
reg [7:0] b; //second random input data in sequence of 4
reg [7:0] c; //third random input data in sequence of 4
reg [7:0] d; //fourth random input data in sequence of 4
integer count_error;
////////////////////////////////////////////////////////////////

 
    
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
  
initial
  begin
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
  
  
  
  
   reset = 0;
     enable = 1;
     data_valid_in =1;
     count_error=0;
     #40;   
  for(i = 0; i < 10000; i = i+1)
 // forever
    begin
      a = $urandom_range(8'hBB,8'hAA);
      b = $urandom_range(8'hBB,8'hAA);
      c = $urandom_range(8'hFF,8'hFA);
      d = $urandom_range(8'hDD,8'hCC);
      
      
      a = 8'hAA;
      b = 8'hAA;
      //c = 8'hFF;
      //d = 8'hCF;
      data_in = a;
      #10;      
      data_in = b;
      #10;      
      data_in = c;
      #10;      
      data_in = d;
      #10;
    
      if(detected_out && data_valid_out)
        if(enable &&data_valid_in && ~reset && a == 8'hAA && b == 8'hAA && c == 8'hFF && d == 8'hCF)
            begin
              $display("Correct output");
              $display("a = %h",a);
              $display("b = %h",b);
              $display("c = %h",c);
              $display("d = %h",d);
              $display("output = %b",detected_out);
            end
        else
          begin
            count_error = count_error+1;
            $display("Wrong output");
          end
    end
  //$monitor("%h",temp);
  
  //#10 $finish;
  if(count_error ==0)
    $display("TEST OK");
  else
    $display("TEST FAILED");
    
    
  #10 $finish;
  end
  
endmodule
 
  
  
