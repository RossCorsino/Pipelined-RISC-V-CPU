module LabK;
reg a, b, c;
wire notOutput, lowerInput, z, a1, a2, o1;
not my_not(notOutput, c);
assign lowerInput = notOutput;
and(a1, lowerInput, a);
and(a2, b, c);
or(o1, a1, a2);
assign z = o1;
initial
begin
  a = 1; b = 0; c = 0;
  #1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
  $finish;
end
endmodule
