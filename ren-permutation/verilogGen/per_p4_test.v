
module per_p2_test;
    parameter CLOCK_TIME = 5.0;
    parameter DATA_WIDTH = 16;
    parameter N = 256;
    parameter DP = 2;
	// Inputs
	reg clk;
	reg rst;
	reg [DATA_WIDTH-1:0] data_in [DP-1:0];
	reg ctrl_in;

	// Outputs
	wire [DATA_WIDTH-1:0] data_out [DP-1:0];
	wire ctrl_out;

	// Instantiate the Unit Under Test (UUT)
	
    per_dp2_0_r per_instance(
    //ingressStage_p2 ingress_inst(
    //egressStage_p2 ingress_inst(
    //mem_stage_dp2 mem_stage_inst(
    .inData_0(data_in[0]),
    .inData_1(data_in[1]),
    .outData_0(data_out[0]),
    .outData_1(data_out[1]),
    .in_start(ctrl_in),                        
    .out_start(ctrl_out),                       
    .clk(clk),                             
    .rst(rst)                              
    );  
    
	integer i;
	always #(CLOCK_TIME/2) clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		data_in[0] = {DATA_WIDTH{1'b0}};
		data_in[1] = {DATA_WIDTH{1'b0}};
		ctrl_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#3.0;
		rst = 0;
		data_in[0] = 0;
		data_in[1] = 0;
		ctrl_in = 1;
		
		for(i=0; i<N/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = 2*i;
		  data_in[1] = 2*i+1;
		  ctrl_in = 0;
		end
		
		  
		ctrl_in = 1;		  
        
		for(i=0; i<N/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = 2*i+0;
		  data_in[1] = 2*i+1;
		  ctrl_in = 0;
		end
		// Add stimulus here

	end
      
endmodule


module per_p4_test;
    parameter CLOCK_TIME = 5.0;
    parameter DATA_WIDTH = 16;
    parameter SIZE = 256;
    parameter DP = 4;
	// Inputs
	reg clk;
	reg rst;
	reg [DATA_WIDTH-1:0] data_in [DP-1:0];
	reg ctrl_in;

	// Outputs
	wire [DATA_WIDTH-1:0] data_out [DP-1:0];
	wire ctrl_out;

	// Instantiate the Unit Under Test (UUT)
	per_dp4_0_r per_instance(
    //per_dp4_256_r per_instance(
    //ingressStage_p2 ingress_inst(
    //egressStage_p2 ingress_inst(
    //mem_stage_dp2 mem_stage_inst(
    .inData_0(data_in[0]),
    .inData_1(data_in[1]),
	.inData_2(data_in[2]),
    .inData_3(data_in[3]),
    .outData_0(data_out[0]),
    .outData_1(data_out[1]),
	.outData_2(data_out[2]),
    .outData_3(data_out[3]),
    .in_start(ctrl_in),                        
    .out_start(ctrl_out),                       
    .clk(clk),                             
    .rst(rst)                              
    );  
    
	integer i;
	always #(CLOCK_TIME/2) clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		data_in[0] = {DATA_WIDTH{1'b0}};
		data_in[1] = {DATA_WIDTH{1'b0}};
		data_in[2] = {DATA_WIDTH{1'b0}};
		data_in[3] = {DATA_WIDTH{1'b0}};
		ctrl_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#3.0;
		rst = 0;
		data_in[0] = 0;
		data_in[1] = 0;
		data_in[2] = {DATA_WIDTH{1'b0}};
		data_in[3] = {DATA_WIDTH{1'b0}};
		ctrl_in = 1;
		
		for(i=0; i<SIZE/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = 4*i;
		  data_in[1] = 4*i+1;
		  data_in[2] = 4*i+2;
		  data_in[3] = 4*i+3;
		  ctrl_in = 0;
		end
		  
		ctrl_in = 1;		  
        
		for(i=0; i<SIZE/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = 4*i;
		  data_in[1] = 4*i+1;
		  data_in[2] = 4*i+2;
		  data_in[3] = 4*i+3;
		  ctrl_in = 0;
		end
		// Add stimulus here

	end
      
endmodule



module per_p8_test;
    parameter CLOCK_TIME = 5.0;
    parameter DATA_WIDTH = 16;
    parameter SIZE = 16;
    parameter DP = 8;
	// Inputs
	reg clk;
	reg rst;
	reg [DATA_WIDTH-1:0] data_in [DP-1:0];
	reg ctrl_in;

	// Outputs
	wire [DATA_WIDTH-1:0] data_out [DP-1:0];
	wire ctrl_out;

	// Instantiate the Unit Under Test (UUT)
	per_dp8_888_r per_instance(
    //per_dp4_256_r per_instance(
    //ingressStage_p2 ingress_inst(
    //egressStage_p2 ingress_inst(
    //mem_stage_dp2 mem_stage_inst(
    .inData_0(data_in[0]),
    .inData_1(data_in[1]),
	.inData_2(data_in[2]),
    .inData_3(data_in[3]),
    .inData_4(data_in[4]),
    .inData_5(data_in[5]),
    .inData_6(data_in[6]),
    .inData_7(data_in[7]),
    .outData_0(data_out[0]),
    .outData_1(data_out[1]),
	.outData_2(data_out[2]),
    .outData_3(data_out[3]),
    .outData_4(data_out[4]),
    .outData_5(data_out[5]),
    .outData_6(data_out[6]),
    .outData_7(data_out[7]),
    .in_start(ctrl_in),                        
    .out_start(ctrl_out),                       
    .clk(clk),                             
    .rst(rst)                              
    );  
    
	integer i;
	always #(CLOCK_TIME/2) clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		data_in[0] = {DATA_WIDTH{1'b0}};
		data_in[1] = {DATA_WIDTH{1'b0}};
		data_in[2] = {DATA_WIDTH{1'b0}};
		data_in[3] = {DATA_WIDTH{1'b0}};
		data_in[4] = {DATA_WIDTH{1'b0}};
        data_in[5] = {DATA_WIDTH{1'b0}};
        data_in[6] = {DATA_WIDTH{1'b0}};
        data_in[7] = {DATA_WIDTH{1'b0}};
		ctrl_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#3.0;
		rst = 0;
		data_in[0] = {DATA_WIDTH{1'b0}};
        data_in[1] = {DATA_WIDTH{1'b0}};
        data_in[2] = {DATA_WIDTH{1'b0}};
        data_in[3] = {DATA_WIDTH{1'b0}};
        data_in[4] = {DATA_WIDTH{1'b0}};
        data_in[5] = {DATA_WIDTH{1'b0}};
        data_in[6] = {DATA_WIDTH{1'b0}};
        data_in[7] = {DATA_WIDTH{1'b0}};
		ctrl_in = 1;
		
		for(i=0; i<SIZE/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = DP*i;
          data_in[1] = DP*i+1;
          data_in[2] = DP*i+2;
          data_in[3] = DP*i+3;
          data_in[4] = DP*i+4;
          data_in[5] = DP*i+5;
          data_in[6] = DP*i+6;
          data_in[7] = DP*i+7;
		  ctrl_in = 0;
		end
		  
		ctrl_in = 1;		  
        
		for(i=0; i<SIZE/DP; i=i+1)begin
		  #CLOCK_TIME;
		  data_in[0] = DP*i;
          data_in[1] = DP*i+1;
          data_in[2] = DP*i+2;
          data_in[3] = DP*i+3;
          data_in[4] = DP*i+4;
          data_in[5] = DP*i+5;
          data_in[6] = DP*i+6;
          data_in[7] = DP*i+7;
		  ctrl_in = 0;
		end
		// Add stimulus here

	end
      
endmodule