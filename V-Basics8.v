module LabK;
reg a, b, c, expect;
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
  for (i = 0; i < 2; i = i + 1)
  begin
    for (j = 0; j < 2; j = j + 1)
    begin
      for (k = 0; k < 2; k = k + 1)
        begin
          a = i; b = j; c = k;
          expect = (a & ~c)|(c & b);
          #1; //wait for z
          if (expect === z)
            $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
          else
            $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
        end
    end
  end
  $finish;
end
endmodule
