// This Rate controller module supports 2 modes
// Data explosion mode -> output data size = N times the input data size
// Data filtering mode -> output data size = M times filtered than input data size
// Make sure to use ONLY one of the above modes by:
// DATA explosion mode : set M to 0 and use any N value >= 1
// DATA filtering mode : set N to 1 and use any M value
// Parameters 
// D : Delay between inputs (in cycles)
// N : Data explosion coeficient
// P : Total data size
// Q : Payload size
// F : (P*(100-M))/100 - Number of data to be passed out of P

// ------------------
// Author:  Upul Ekanayaka
// Date:    28/02/2020
// Version: 1.0
// ------------------

module rate_controller #(
  parameter integer C_AXIS_TDATA_WIDTH = 256 // Data width of both input and output data
)
(
  //general signals
  input wire                                clk,                   
  input wire                                reset,
  //input stream                 
  output reg                                in_tready,           
  input wire                                in_tvalid,           
  input wire   [256-1:0]     in_tdata,      
  input wire   [256/2-1:0]   in_tuser,      
  input wire   [256/8-1:0]   in_tstrb,      
  input wire                                in_tlast,      
  input wire   [256/8-1:0]   in_tag,
  //output stream             
  input wire                                out_tready,          
  output reg                                out_tvalid,          
  output reg   [256-1:0]     out_tdata,     
  output reg   [256/2-1:0]   out_tuser,     
  output reg   [256/8-1:0]   out_tstrb,     
  output reg                                out_tlast,     
  output reg   [256/8-1:0]   out_tag
);

localparam CONFIG_PHASE          = 32'hC0;
localparam DATA_PHASE            = 32'h5F;
localparam PARAM_SIZE            = 32;

/////////////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////////////
integer i;

reg   [32 - 1 : 0]       D;
reg   [32 - 1 : 0]       N;
reg   [32 - 1 : 0]       P;
reg   [32 - 1 : 0]       Q;
reg   [32 - 1 : 0]       F;

reg   [32 - 1 : 0]       n_counter;
reg   [32 - 1 : 0]       f_counter;
reg                              filter_done;
reg   [32 - 1 : 0]       f_flits;
reg   [32 - 1 : 0]       f_empty; 

//states
reg   [2 : 0]  state;
localparam CONFIG    = 3'd0;
localparam TRANSIT   = 3'd1;
localparam DATA_EXPL = 3'd2;
localparam DATA_FILT = 3'd3;
localparam NULL_FLIT = 3'd4;

reg [256-1:0]   data;
reg                            valid;
reg [256/2-1:0] user;
reg [256/8-1:0] strobe;
reg [256/8-1:0] tag;
reg                            last;
/////////////////////////////////////////////////////////////////////////////
// RTL Logic
/////////////////////////////////////////////////////////////////////////////

//state machine to handle states and buffer incoming data
always @(posedge clk) begin
  if (reset) begin
    state <= CONFIG;

    D  <= 0;
    N  <= 0;
    P  <= 0;
    Q  <= 0;
    F  <= 0;

    n_counter   <= 0;
    f_counter   <= 0;
    filter_done <= 0;
    f_flits     <= 0;
    f_empty     <= 0;

    data   <= 0;
    valid  <= 0;
    user   <= 0;
    strobe <= 0;
    tag    <= 0;
    last   <= 0;
  end
  else begin
    case (state)
      CONFIG : begin
        //receive config data and store
        if(in_tvalid && in_tready && (in_tag == CONFIG_PHASE)) begin
          D <= in_tdata[32*1 - 1 : 32*0];
          N <= in_tdata[32*2 - 1 : 32*1];
          P <= in_tdata[32*3 - 1 : 32*2];
          Q <= in_tdata[32*4 - 1 : 32*3];
          F <= in_tdata[32*5 - 1 : 32*4];

          state <= TRANSIT;
        end
        else begin
          state <= CONFIG;
        end
        data   <= 0;
        valid  <= 0;
        user   <= 0;
        strobe <= 0;
        tag    <= 0;
        last   <= 0;

        n_counter   <= 0;
        f_counter   <= 0;
        filter_done <= 0;
        f_flits     <= 0;
        f_empty     <= 0;
      end
      TRANSIT : begin
        //wait at transit until null flit is sent back for config phase
        if(out_tready) begin
          state <= (F == P) ? DATA_EXPL : DATA_FILT;
        end
        else begin
          state <= TRANSIT;
        end
        // Number of flits in filtering mode
        f_flits <= (F >> 5) + ((F&32'h1F)>0);
        // Number of empty bytes in last flit in filtering mode
        f_empty <= ((F&32'h1F)>0) ? 32'h20 - (F&32'h1F) : 0; 
      end
      DATA_EXPL : begin
        if((in_tvalid || n_counter>0) && out_tready && (in_tag == DATA_PHASE)) begin
          if(n_counter == N - 1) begin
            n_counter <= 0;
            state <= (last | in_tlast) ? NULL_FLIT : DATA_EXPL;
          end
          else begin
            n_counter <= n_counter + 1;
            state  <= DATA_EXPL;
          end
          if(n_counter == 0) begin
            data   <= in_tdata;
            valid  <= in_tvalid;
            user   <= in_tuser;
            strobe <= in_tstrb;
            tag    <= in_tag;
            last   <= in_tlast;
          end
        end
        else begin
          state  <= DATA_EXPL;
        end
      end
      DATA_FILT : begin
        if(in_tvalid && out_tready && (in_tag == DATA_PHASE)) begin
          if(f_counter == f_flits - 1) begin
            if(in_tlast) begin
              f_counter   <= 0;
            end
            filter_done <= 1; 
          end
          else begin
            f_counter <= f_counter + 1;
          end
        end
        else if(in_tvalid && in_tready && (in_tag == 0)) begin
          filter_done <= 0;
        end
        state  <= DATA_FILT;
      end
      NULL_FLIT : begin //filter out null flit for DATA_EXPL mode
        if(in_tvalid && in_tready && (in_tag == 0)) begin
          state <= DATA_EXPL;
        end
        else begin
          state <= NULL_FLIT;
        end

        data   <= 0;
        valid  <= 0;
        user   <= 0;
        strobe <= 0;
        tag    <= 0;
        last   <= 0;
      end
      default : begin
        state <= CONFIG;
      end
    endcase    
  end
end

always @ (*) begin
  case(state)
    CONFIG : begin
      in_tready  = 1;
      out_tvalid = 0;
      out_tdata  = 0;
      out_tuser  = 0;
      out_tstrb  = 0;
      out_tlast  = 0;
      out_tag    = 0;
    end
    TRANSIT : begin
      //return null flit
      if(out_tready) begin
        in_tready  = 1;
        out_tvalid = 1;
        out_tdata  = 0;
        out_tuser  = 0;
        out_tstrb  = 0;
        out_tlast  = 1;
        out_tag    = 0;
      end
      else begin
        in_tready  = 1;
        out_tvalid = 0;
        out_tdata  = 0;
        out_tuser  = 0;
        out_tstrb  = 0;
        out_tlast  = 0;
        out_tag    = 0;
      end
    end
    DATA_EXPL : begin
      if(n_counter == 0) begin
        in_tready  = out_tready;
        out_tvalid = in_tvalid;
        out_tdata  = in_tdata;
        out_tuser  = in_tuser;
        out_tstrb  = in_tstrb;
        out_tlast  = (N == 1) ? in_tlast : 0;
        out_tag    = in_tag;
      end
      else begin
        in_tready  = 0;
        out_tvalid = valid;
        out_tdata  = data;
        out_tuser  = user;
        out_tstrb  = strobe;
        out_tlast  = (n_counter == N - 1) ? last : 0;
        out_tag    = tag;
      end        
    end
    DATA_FILT : begin
      in_tready  = out_tready;
      if(in_tag == DATA_PHASE) begin
        if(filter_done) begin
          out_tvalid = 0;
          out_tdata  = 0;
          out_tuser  = 0;
          out_tstrb  = 0;
          out_tlast  = 0;
          out_tag    = 0;
        end
        else begin
          out_tvalid = in_tvalid;
          out_tlast  = (f_counter == f_flits - 1) & in_tvalid & out_tready ? 1 : 0;
          out_tdata  = out_tlast ? in_tdata&({256{1'b1}} >> f_empty*8) : in_tdata;
          out_tuser  = out_tlast ? (32 - f_empty) : 32;
          out_tstrb  = out_tlast ? ({32{1'b1}} >> f_empty) : in_tstrb;
          out_tag    = in_tag;
        end        
      end
      else begin //filter out null flits
        out_tvalid = 0;
        out_tdata  = 0;
        out_tuser  = 0;
        out_tstrb  = 0;
        out_tlast  = 0;
        out_tag    = 0;         
      end
    end
    NULL_FLIT : begin //filter out null flit for DATA_EXPL mode
      in_tready  = 1;
      out_tvalid = 0;
      out_tdata  = 0;
      out_tuser  = 0;
      out_tstrb  = 0;
      out_tlast  = 0;
      out_tag    = 0;   
    end
    default : begin
      in_tready  = 1;
      out_tvalid = 0;
      out_tdata  = 0;
      out_tuser  = 0;
      out_tstrb  = 0;
      out_tlast  = 0;
      out_tag    = 0;
    end
  endcase
end

endmodule

// Top wrapper module
module Top #(
  parameter integer C_AXIS_TDATA_WIDTH = 256 // Data width of both input and output data
)
(
  input wire                 clk,                   
  input wire                 reset,                 
  output wire                io_in_ready,           
  input wire                 io_in_valid,           
  input wire   [256-1:0]     io_in_bits_tdata,      
  input wire   [256/2-1:0]   io_in_bits_tuser,      
  input wire   [256/8-1:0]   io_in_bits_tstrb,      
  input wire                 io_in_bits_tlast,      
  input wire   [256/8-1:0]   io_in_tag,             
  input wire                 io_out_ready,          
  output wire                io_out_valid,          
  output wire  [256-1:0]     io_out_bits_tdata,     
  output wire  [256/2-1:0]   io_out_bits_tuser,     
  output wire  [256/8-1:0]   io_out_bits_tstrb,     
  output wire                io_out_bits_tlast,     
  output wire  [256/8-1:0]   io_out_tag,            
  input wire                 io_pcIn_valid,         
  input wire                 io_pcIn_bits_request,  
  input wire   [15:0]        io_pcIn_bits_moduleId, 
  input wire   [7:0]         io_pcIn_bits_portId,   
  input wire   [19:0]        io_pcIn_bits_pcValue,  
  input wire   [3:0]         io_pcIn_bits_pcType,   
  output wire                io_pcOut_valid,        
  output wire                io_pcOut_bits_request, 
  output wire  [15:0]        io_pcOut_bits_moduleId,
  output wire  [7:0]         io_pcOut_bits_portId,  
  output wire  [19:0]        io_pcOut_bits_pcValue, 
  output wire  [3:0]         io_pcOut_bits_pcType  
);

  // rate controller
  rate_controller #(
    .C_AXIS_TDATA_WIDTH (256)
  ) 
  rc_inst(
    .clk                    ( clk               ),
    .reset                  ( reset             ),
    .in_tready              ( io_in_ready       ),
    .in_tvalid              ( io_in_valid       ),
    .in_tdata               ( io_in_bits_tdata  ), 
    .in_tuser               ( io_in_bits_tuser  ),
    .in_tstrb               ( io_in_bits_tstrb  ),
    .in_tlast               ( io_in_bits_tlast  ),
    .in_tag                 ( io_in_tag         ),
    .out_tready             ( io_out_ready      ),
    .out_tvalid             ( io_out_valid      ),
    .out_tdata              ( io_out_bits_tdata ),
    .out_tuser              ( io_out_bits_tuser ),
    .out_tstrb              ( io_out_bits_tstrb ),
    .out_tlast              ( io_out_bits_tlast ),
    .out_tag                ( io_out_tag        )
  );

endmodule