`include "fa2.v"
module rca(a,b,sum);

input [31:0]a,b;
output [31:0]sum;

wire [31:0]c;

fa2 f1(a[0],b[0],1'b0,sum[0],c[0]);

genvar i;


generate 
for(i=1;i<=31;i=i+1)
begin: asgn
  fa2 f(a[i],b[i],c[i-1],sum[i],c[i]);
end
endgenerate

endmodule