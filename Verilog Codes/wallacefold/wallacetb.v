module wallacetb;
reg[15:0] a;
reg[15:0] b;
wire[31:0] s;
wire[31:0] z;
integer i;
wallace a1(a,b,s,z);
initial begin
a=65535;b=65535;#10;
a=25;b=25; #10;
a=100;b=2;#10;
a=45;b=2; #10;
end

initial
begin
$dumpfile("test1.vcd");
$dumpvars(0,wallacetb);
$monitor("time=%3d   a=%16b  %2d\tb=%16b  %2d\t %b %3d",$time,a,a,b,b,s,s);
//for(i=0;i<=15;i=i+1)
//begin
//$monitor("%b\n",a1.X[0]);
//end
end
endmodule