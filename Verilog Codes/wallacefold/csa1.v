/*`include "fa1.v"
module csa(a,b,c,s,cout);
input [31:0]a,b,c;
output [31:0]cout,s;


genvar i;

assign cout[0]=1'b0;
generate 
for(i=0;i<=30;i=i+1)
begin: asgn
  fa f(a[i],b[i],c[i],s[i],cout[i+1]);
end
endgenerate

 assign s[31]=(a[31]^b[31])^c[31];
 
 
 
 
 
 
endmodule*/

`include "fa1.v"

module csa(a0,a1,a2,b0,c0);
input [31:0]a0,a1,a2;
output[31:0]b0,c0;

assign c0[0]=1'b0;
fa m1(a2[0],a1[0],a0[0],b0[0],c0[1]);
fa m2(a2[1],a1[1],a0[1],b0[1],c0[2]);
fa m3(a2[2],a1[2],a0[2],b0[2],c0[3]);
fa m4(a2[3],a1[3],a0[3],b0[3],c0[4]);
fa m5(a2[4],a1[4],a0[4],b0[4],c0[5]);
fa m6(a2[5],a1[5],a0[5],b0[5],c0[6]);
fa m7(a2[6],a1[6],a0[6],b0[6],c0[7]);
fa m8(a2[7],a1[7],a0[7],b0[7],c0[8]);
fa m9(a2[8],a1[8],a0[8],b0[8],c0[9]);
fa m10(a2[9],a1[9],a0[9],b0[9],c0[10]);
fa m11(a2[10],a1[10],a0[10],b0[10],c0[11]);
fa m12(a2[11],a1[11],a0[11],b0[11],c0[12]);
fa m13(a2[12],a1[12],a0[12],b0[12],c0[13]);
fa m14(a2[13],a1[13],a0[13],b0[13],c0[14]);
fa m15(a2[14],a1[14],a0[14],b0[14],c0[15]);
fa m16(a2[15],a1[15],a0[15],b0[15],c0[16]);
fa m17(a2[16],a1[16],a0[16],b0[16],c0[17]);
fa m18(a2[17],a1[17],a0[17],b0[17],c0[18]);
fa m19(a2[18],a1[18],a0[18],b0[18],c0[19]);
fa m20(a2[19],a1[19],a0[19],b0[19],c0[20]);
fa m21(a2[20],a1[20],a0[20],b0[20],c0[21]);
fa m22(a2[21],a1[21],a0[21],b0[21],c0[22]);
fa m23(a2[22],a1[22],a0[22],b0[22],c0[23]);
fa m24(a2[23],a1[23],a0[23],b0[23],c0[24]);
fa m25(a2[24],a1[24],a0[24],b0[24],c0[25]);
fa m26(a2[25],a1[25],a0[25],b0[25],c0[26]);
fa m27(a2[26],a1[26],a0[26],b0[26],c0[27]);
fa m28(a2[27],a1[27],a0[27],b0[27],c0[28]);
fa m29(a2[28],a1[28],a0[28],b0[28],c0[29]);
fa m30(a2[29],a1[29],a0[29],b0[29],c0[30]);
fa m31(a2[30],a1[30],a0[30],b0[30],c0[31]);
assign b0[31]=a2[31]^(a1[31]^a0[31]);

//fa m32(a2[31],a1[31],a0[31],b0[31],0);


endmodule