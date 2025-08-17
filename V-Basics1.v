module Labk;
reg [31:0] x;
reg [0:0] one;
reg [1:0] two;
reg [2:0] three;
initial
begin
  x = 32'hffff0000;
  one = &x;
  $display("time = %5d, one = %d", $time, one);
  x = x + 2;
  two = x[1:0];
  $display("time = %5d, two = %b", $time, two);
  three = {one, two};
  $display("time = %5d, three = %h", $time, three);
  $finish;
end
endmodule
