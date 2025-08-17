module LabL;
reg signed [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z, temp;
reg ok, flag, temp2, zero;
yAlu alu(z, ex, a, b, op);
initial
begin
 repeat (10)
 begin
 #10;
  a = $random;
  b = $random;
  temp2 = $random%2;
  if (temp2 == 0) b = a;
  op = 0;
  flag = $value$plusargs("op=%d", op);
  if(flag === 0)
    $display("No value for op, simulates 0 due to this");
  if(op === 0)
    begin
    expect = a&b;
    zero = (expect==0)?1:0;
    end
  else if(op === 1)
    begin
    expect = a|b;
    zero = (expect == 0)?1:0;
    end
  else if(op === 2)
    begin
    expect = a+b;
    zero = (expect == 0)?1:0;
    end
  else if(op === 6)
    begin
    expect = a+(~b)+1;
    zero = (expect == 0)?1:0;
    end
  else if (op == 3'b111)
    begin
    expect = (a<b)?1:0;
    zero = (expect==0)?1:0;
    end
  else
    begin
    zero = (expect==0)?1:0;
    #1;
    end
  #10;
  if(z === expect) ok = 1;
  if(ok == 1)
    $display("a=%b b=%b op=%b z=%b expect=%b ex=%b flag=%d", a, b, op, z, expect, zero, flag);
  end
$finish;
end
endmodule
