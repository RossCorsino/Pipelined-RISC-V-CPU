module LabL;
reg signed [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;
yAlu alu(z, ex, a, b, op);
initial
begin
 repeat(10)
 begin
  a = $random;
  b = $random;
  op = 0;
  flag = $value$plusargs("op=%d", op);
  if(flag === 0)
    $display("No value for op, simulates 0 due to this");
  if(op === 0)
    expect = a&b;
  else if(op === 1)
    expect = a|b;
  else if(op === 2)
    expect = a+b;
  else if(op === 6)
    expect = a+(~b)+1;
  else
    $display("Incorrect op given");
  #1;
  if(z === expect) ok = 1;
  if(ok == 1)
    $display("a=%b b=%b op=%b z=%b expect=%b", a, b, op, z, expect);
  end
$finish;
end
endmodule
