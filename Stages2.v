module LabM;
reg [31:0] d;
reg clk, enable, flag;
wire [31:0] z;
register #(32) mine(z, d, clk, enable);
always
begin
  #5 clk = ~clk;
end
initial
begin
clk = 0;
flag = $value$plusargs("enable=%b", enable);
repeat (20)
begin
  #2 d = $random;
end
$finish;
end
always
#1 $monitor("%5d: clk=%b,d=%d,z=%d", $time,clk,d,z);
endmodule
