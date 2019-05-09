module ieeeaddertb;
reg[15:0] a;
reg[15:0] b;
wire[4:0] s;
wire[9:0] z;
wire sign;
integer i;
adder a1(a,b,s,z,sign);
initial begin
a=16'b1100000100000000; b=16'b0100100101000000; #10;
a=16'b1100110100100000; b=16'b0100110010010000; #10;
a=16'b1100110100100000; b=16'b1100110010010000; #10;
end

initial
begin
$dumpfile("test1.vcd");
$dumpvars(0,ieeeaddertb);
$monitor("time=%3d   a=%16b\tb=%16b\t%b %b %b",$time,a,b,sign,s,z);

end
endmodule