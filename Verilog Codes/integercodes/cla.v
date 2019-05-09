
`include "skgp.v"
`include "kgp1.v"
`include "fa.v"
 
module hsfl(input[15:0] a,input[15:0] b,output[16:0] s);
wire[1:0] X1[16:0];
wire[1:0] Y1[16:0];
wire[1:0] Z1[16:0];
wire[1:0] T[16:0];
wire[1:0] U[16:0];

assign X1[0]=2'b0;

genvar i;
generate

for(i=0;i<=15;i=i+1)
begin
   kgp k1(a[i],b[i],X1[i+1]);
end

assign Y1[0]=X1[0];

for(i=0;i<=15;i=i+1)
begin
   skgp s1(X1[i+1],X1[i],Y1[i+1]);
end

assign Z1[1]=Y1[1];
assign Z1[0]=Y1[0];

for(i=0;i<=14;i=i+1)
begin
   skgp s2(Y1[i+2],Y1[i],Z1[i+2]);
end

assign T[3]=Z1[3];
assign T[2]=Z1[2];
assign T[1]=Z1[1];
assign T[0]=Z1[0];

for(i=0;i<=12;i=i+1)
begin
   skgp s3(Z1[i+4],Z1[i],T[i+4]);
end

assign U[7]=T[7];
assign U[6]=T[6];
assign U[5]=T[5];
assign U[4]=T[4];
assign U[3]=T[3];
assign U[2]=T[2];
assign U[1]=T[1];
assign U[0]=T[0];

for(i=0;i<=8;i=i+1)
begin
   skgp s4(T[i+8],T[i],U[i+8]);
end

for(i=0;i<=15;i=i+1)
begin
   fulladd f0(a[i],b[i],U[i][0],s[i]);
end
fulladd f16(1'b0,1'b0,U[16][0],s[16]);
endgenerate

endmodule
