module hsfltb;
reg[15:0] a;
reg[15:0] b;
wire[16:0] s;

hsfl obj(a,b,s);
initial begin
a=65535;b=65535;#10;
a=8;b=9; #10;
a=10;b=2;#10;
a=100;b=9;#10;
end

initial
begin
$dumpfile("hsflvcd.vcd");
$dumpvars(0,hsfltb);
$monitor("time=%3d   a=%16b  %2d\tb=%16b  %2d\ts=%17b  %2d",$time,a,a,b,b,s,s);
end
endmodule