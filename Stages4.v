module LabM;
reg[31:0] address, memIn;
reg clk, read, write;
wire[31:0] memOut;
mem data(memOut, address, memIn, clk, read, write);
initial begin
write = 1; read = 0; address = 16;
  clk = 0;
  memIn = 32'h12345678;
  #5;
  address = address + 4;
  #5;
  memIn = 32'h0;
  #5;
  address = address + 4;
  #5;
  memIn = 32'h89abcdef;
  #9;
  write = 0; read = 1; address = 16;
  repeat (3)
    begin
      #4 $display("Address %d contains %h", address, memOut);
      address = address + 4;
    end
    $finish;
end
always
begin
  #4 clk = ~clk;
end
endmodule
