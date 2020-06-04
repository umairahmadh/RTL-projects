// Design
module udpparser(clock, reset, in_tdata, in_tvalid,in_tstrb,in_tlast,in_tready, out_tdata,out_tvalid ,out_tstrb,out_tlast, out_tready);
   
   input clock, reset, in_tvalid, in_tlast ; 
   input [255:0] in_tdata;
   input [31:0] in_tstrb;
   input out_tready;
   output reg in_tready;
   output reg out_tvalid;
   output reg out_tlast;
   
   output reg [31:0] out_tstrb;
   output reg [255:0] out_tdata;
   
   
   reg [15:0] opCode;    //storing opCode 
   reg [255:0] data;
   integer i;
   reg sum, max, min;
   
    parameter S0 = 0, 
              S1 = 1, 
              S2 = 2, 
              S3 = 3, 
              S4 = 4, 
              S5 = 5, 
              S6 = 6, 
              S7 = 7;
//registers to track current and next states
    reg [2:0] current_state, next_state;
    
   
  always @ (posedge clock) 
     begin
       if (!reset)
         begin
         	data[255:0]<=0; 
         	current_state <= S0;
         	out_tvalid = 1;
         out_tdata = 8'hAF;
         end
       else begin 
       current_state <= next_state;
//                out_tvalid = 1;
//         out_tdata = 1;
         end

     end
     
     
     
  always @ (*)
     begin

         case(current_state)
             S0: begin  //Initial IDLE state
                in_tready=1;
                 if(in_tready && in_tvalid)
                   begin
                                      next_state = S1; //received and ignored first header frame

                out_tvalid = 1;
                out_tdata = 10;
                   
                   end
                   else begin
                   next_state = S0;
                                   out_tvalid = 1;
                out_tdata = 8'hAA;
                end
                   

               end
             S1: begin
                 if(in_tready && in_tvalid)
                 begin
                     data = in_tdata[0 +: 160];  //first set of data
                     opCode = in_tdata[160 +: 16];
                     out_tstrb = opCode;
//                     sum = 10;
//                     max = data[31:0];
//                     min = data[31:0];                     
                     sum = 8'hBB;
                     max = 8'hBC;
                     min = 8'hBD;
                     out_tvalid = 1;
                                out_tdata = in_tdata[0 +: 32];
                     case(opCode)
                         0: begin
                                //sum
                                for (i=0; i<160; i = i+32)
                                   begin
                                      sum = sum + data[i +: 32];
                                   end
                                
                                out_tvalid = 1;
                                out_tdata = sum;
                                out_tstrb = 8'hFA;
                            end
                         1: begin
                                //max
                                for (i=0; i<160; i = i+1)
                                   begin
                                      if (max>data[i +: 32])
                                        max = data[i +: 32];
                                      else 
                                        max = max;
                                   end
                                   
                                out_tvalid = 1;
                                out_tdata = max;
                                out_tstrb = 8'hFB;
                            end
                         2: begin
                                //min
                                for (i=0; i<160; i = i+1)
                                   begin
                                      if (min<data[i +: 32])
                                        min = data[i +: 32];
                                      else 
                                        min = min;
                                   end
                                out_tvalid = 1;
                                out_tdata = min;  
                                out_tstrb = 8'hFC;                                 
                            end   
                          
                          default: begin
                                out_tvalid = 1;
                                out_tdata = 8'hAC;        
                                end         
                     endcase
                     
//                                     out_tvalid = 1;
//                out_tdata = 11;
                     next_state = S2;
                     end
                   else begin
                   next_state = S1;
                   out_tvalid = 1;
                   out_tdata = 8'hCB;
                   end
               end             
             S2: begin
//                 data = in_tdata;  //first set of data
                   next_state = S0;
                   out_tvalid = 1;
                   out_tdata = 8'hCC;
               end             
             S3: begin
               end             
             S4: begin
               end             
             S5: begin
               end             
             S6: begin
               end             
             S7: begin
               end
             default: begin
             next_state = S0;
             out_tvalid = 1;
                                out_tdata = 3;
                                end
           endcase
        end
endmodule