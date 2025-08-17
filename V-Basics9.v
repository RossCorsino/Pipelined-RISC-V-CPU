module LabK;
reg a, b, cin;
reg [1:0] expect;
integer i, j, k;
wire xor1, xor2, a1, a2, o1, z, cout;
xor(xor1, b, a);
and(a1, b, a);
and(a2, cin, xor1);
xor(xor2, cin, xor1);
assign z = xor2;
or(o1, a2, a1);
assign cout = o1;
initial
begin
  for(i = 0; i < 2; i = i + 1)
  begin
    for(j = 0; j < 2; j = j + 1)
    begin
      for(k = 0; k < 2; k = k + 1)
      begin
        a = i; b = j; cin = k;
        expect = a + b + cin;
        #1; // //wait for z
        if(expect[0] === z && expect[1] === cout)
          $display("PASS: a=%b b=%b cin=%b, z=%b, cout=%b", a, b, cin, z, cout);
        else
          $display("FAIL: a=%b b=%b cin=%b, z=%b, c_ut=%b", a, b, cin, z, cout);
      end
    end
  end
$finish;
end
endmodule
