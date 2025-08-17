module LabL;
reg[31:0] a, b, expect, ok;
reg cin;
wire[31:0] z;
wire cout;
yAdder adder(z, cout, a, b, cin);
initial
begin
repeat(5)
begin
  a=$random;
  b=$random;
  cin=0;
  #2 expect = a+b+cin;
  ok=0;
  #1;
  if (expect === z) ok = 1;
  if(ok === 1)
    $display("PASS");
  else
    $display("FAIL");
end
$finish;
end
endmodule
