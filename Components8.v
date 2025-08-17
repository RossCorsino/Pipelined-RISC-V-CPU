module LabL;
reg signed [31:0] a, b, expect;
reg ctrl;
wire signed [31:0] z;
wire cout;
yAdder adder(z, cout, a, b, ctrl);
initial
begin
repeat(5)
begin
  a=$random;
  b=$random;
  ctrl = $random % 2;
  #2; expect = (ctrl == 1)?a+(~b)+1:a+b;
  if(expect === z)
      $display("a=%b b=%b ctrl=%b z=%b cout=%b expect=%b", a, b, ctrl, z, cout, expect);
    else
      $display("a=%b b=%b ctrl=%b z=%b cout=%b expect=%b", a, b, ctrl, z, cout, expect);
end
$finish;
end
endmodule
