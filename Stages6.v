module LabM;
reg clk, read, write;
reg[31:0] address, memIn;
wire[31:0] memOut;
mem data(memOut, address, memIn, clk, read, write);
initial begin
  clk = 0;
  address = 128; write = 0; read = 0;
  repeat (11)
  begin
  read = 1;
  #5;
    if(memOut[31:26] == 0)
      $display("%d %d %d %d %d", memOut[31:26], memOut[25:21], memOut[20:16], memOut[15:11], memOut[5:0]);
    if(memOut[31:26] == 8 || memOut[31:26] == 35 || memOut[31:26] == 4 || memOut[31:26] == 43)
      $display("%d %d %d %d", memOut[31:26], memOut[25:21], memOut[20:16], memOut[15:0]);
    if(memOut[31:26] == 2)
      $display("%d %d", memOut[31:26], memOut[25:0]);
    address = address + 4;
  end
  $finish;
end
always begin
  #4 clk = ~clk;
end
endmodule
