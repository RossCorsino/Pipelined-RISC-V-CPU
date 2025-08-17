module LabK;
reg a, b, c, flag;
wire z, notOutput, lowerInput, a1, a2, o1;
integer i, j, k;
not my_not(notOutput, c);
assign lowerInput = notOutput;
and(a1, lowerInput, a);
and(a2, b, c);
or(o1, a1, a2);
assign z = o1;
initial
begin
  flag = $value$plusargs("a=%b", a);
  flag = $value$plusargs("b=%b", b);
  flag = $value$plusargs("c=%b", c);
  if (!flag)
    $display("Please input the values necessary.");
  else
    #1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
  $finish;
  end
endmodule
