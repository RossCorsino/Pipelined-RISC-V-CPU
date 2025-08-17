module LabL;
reg[31:0] a0, a1, a2, a3, expect;
reg [1:0] c;
wire[31:0] z;
yMux4to1 #(32) mux(z, a0, a1, a2, a3, c);
initial
begin
repeat (10)
begin
a0 = $random;
a1 = $random;
a2 = $random;
a3 = $random;
c = $random % 2;
#1;
expect = (c == 0)?a0:(c == 1)?a1:(c == 2)?a2:a3;
if (z === expect)
  $display("Pass: a0=%b,  a1=%b,  a2=%b, a3=%b, c=%b,  z=%b", a0, a1, a2, a3, c, z);
else
  $display("Fail: a0=%b,  a1=%b,  a2=%b, a3=%b, c=%b,  z=%b", a0, a1, a2, a3, c, z);
end
$finish;
end
endmodule
