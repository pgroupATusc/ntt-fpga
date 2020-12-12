module  counter_64(
in_start,                         
counter_out,                         
clk,                             
rst                              
);                               
  input in_start, clk, rst;                   
  output [5:0] counter_out;            
  
  reg [5:0] counter_r;        
  reg status_couting;        

  assign counter_out = counter_r;        
  
  always@(posedge clk)             
  begin                            
    if(rst) begin                    
      counter_r <= 6'b0;    
      status_couting <= 1'b0;            
    end
    else begin                        
      if (status_couting == 1'b1)                
        counter_r <= counter_r + 1'b1;                   
      if (counter_r[5:0] == 63) begin  
        status_couting <= 1'b0;                 
        counter_r <= 6'b0;         
      end                                    
      if (in_start) begin                     
        status_couting <= 1'b1;                 
      counter_r <= 6'b0;                
      end                                    
    end
  end                              

endmodule 
