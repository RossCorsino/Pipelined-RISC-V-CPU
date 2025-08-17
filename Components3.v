module LabL;
reg[31:0] a, b, expect;
reg c;
wire[31:0] z;
yMux #(32) mux(z, a, b, c);
initial
begin
repeat (10)
begin
a = $random;
b = $random;
c = $random % 2;
#1;
expect = (c == 0)?a:b;
if (z === expect)
  $display("Pass: a=%b,  b=%b,  c=%b,  z=%b", a, b, c, z);
else
  $display("Fail: a=%b,  b=%b,  c=%b,  z=%b", a, b, c, z);
end
$finish;
end
endmodule
