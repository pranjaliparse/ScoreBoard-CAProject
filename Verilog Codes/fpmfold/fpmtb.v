module fpmtb();
reg s1,s2;
reg [4:0]e1,e2;
reg [9:0]m1,m2;

wire [9:0] out1;
wire [4:0] oe;
wire os;

initial begin
$dumpfile("d.vcd");
$dumpvars(0,fpmtb);
$monitor("a=%b %b %b\tb=%b %b %b\toutput=%b %b %b",s1,e1,m1,s2,e2,m2,os,oe,out1);

 s1=1'b0;            
 e1=5'b10000;
 m1=10'b1101001101;
 s2=1'b1;           
 e2=5'b10010;
 m2=10'b0010111111;
   
end
fpm n(s1,e1,m1,s2,e2,m2,os,oe,out1);
//dmux8x1S m(d1,s1,o1);
endmodule