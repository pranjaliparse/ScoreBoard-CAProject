`include "rca1.v"
`include "csa1.v"
module wallace(input [15:0] a, input [15:0] b, output [31:0] out, output[31:0] z );

wire[31:0] X[15:0];
//wire[31:0]//columns X2[2:0]//rows;
genvar i;
genvar j;
genvar k;
generate
for(i=0;i<=15;i=i+1)
begin
   for(k=0;k<i;k=k+1)
   begin
      assign X[i][k]=1'b0;
   end
   for(j=i; j<=i+15; j=j+1)
   begin	   
     assign X[i][j]=b[i] & 
	 a[j-i];
   end
   for(j=i+16; j<=31; j=j+1)
   begin
   assign X[i][j]=1'b0;
   end
end
endgenerate
//assign out=X[0];

wire [31:0] u [31:0];
wire [31:0] v [31:0];

csa c0(X[0],X[1],X[2],u[0],v[0]);
csa c1(X[3],X[4],X[5],u[1],v[1]);
csa c2(X[6],X[7],X[8],u[2],v[2]);
csa c3(X[9],X[10],X[11],u[3],v[3]);
csa c4(X[12],X[13],X[14],u[4],v[4]);

csa c5(u[0],v[0],u[1],u[5],v[5]);
csa c6(v[1],u[2],v[2],u[6],v[6]);
csa c7(u[3],v[3],u[4],u[7],v[7]);

csa c8(u[5],v[5],u[6],u[8],v[8]);
csa c9(v[6],u[7],v[7],u[9],v[9]);

csa c10(u[8],v[8],u[9],u[10],v[10]);
csa c11(v[9],v[4],X[15],u[11],v[11]);
csa c12(u[10],v[10],u[11],u[12],v[12]);
csa c13(u[12],v[12],v[11],u[13],v[13]);

//assign y=u[13]|v[13];
rca r1(u[13],v[13],out);
endmodule