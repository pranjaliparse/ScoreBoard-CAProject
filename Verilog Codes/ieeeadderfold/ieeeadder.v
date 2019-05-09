`include "fulladder.v"

module adder(input [15:0]a, input [15:0]b,output [4:0]a1, output [9:0]b1, output sign);

wire b2;
wire [11:0]sum; wire [11:0]c; wire [4:0]e1; wire [4:0]e2;
wire [4:0]temp1; wire [4:0]l1; wire [4:0]temp2;
wire [9:0]m1; wire [9:0]m2;
wire [10:0]temp; wire [10:0]add;
wire [10:0]s1; wire [10:0]s2;
wire [10:0]ts1; wire [10:0]ts2;
wire [4:0]exp; wire m;

genvar i;
genvar j;
generate
for(i=10;i<=14;i=i+1)
begin
   assign e1[i-10]=a[i];
   assign e2[i-10]=b[i];
end

assign temp1=(e1>e2)?e1:e2;
assign temp2=(e1>e2)?e2:e1;
assign b2=(e1>e2)?1'b0:1'b1;
assign l1=temp1-temp2;
assign l2=l1;

for(i=0;i<=9;i=i+1)
begin
   assign m1[i]=(b2==0)?a[i]:b[i];
   assign m2[i]=(b2==0)?b[i]:a[i];
end

assign s2[10]=1'b1;
assign s1[10]=1'b1;

assign s2[9:0]=m2[9:0];
assign s1[9:0]=m1[9:0];

assign temp=(l1>0)?s2>>(l1-1):s2;
assign m=a[15]^b[15];

assign ts1=(s1>temp)?s1:temp;
assign ts2=(s1>temp)?temp:s1;



full f1(ts1[0],ts2[0]^m,m,sum[0],c[0]);
full f2(ts1[1],ts2[1]^m,c[0],sum[1],c[1]);
full f3(ts1[2],ts2[2]^m,c[1],sum[2],c[2]);
full f4(ts1[3],ts2[3]^m,c[2],sum[3],c[3]);
full f5(ts1[4],ts2[4]^m,c[3],sum[4],c[4]);
full f6(ts1[5],ts2[5]^m,c[4],sum[5],c[5]);
full f7(ts1[6],ts2[6]^m,c[5],sum[6],c[6]);
full f8(ts1[7],ts2[7]^m,c[6],sum[7],c[7]);
full f9(ts1[8],ts2[8]^m,c[7],sum[8],c[8]);
full f10(ts1[9],ts2[9]^m,c[8],sum[9],c[9]);
full f11(ts1[10],ts2[10]^m,c[9],sum[10],c[10]);
assign sum[11]=c[10]&(~m);

assign exp=(sum[11]==1'b1)?(temp1+1):temp1;
assign a1=exp;
assign b1[9:0]=(sum[11]==1'b1)?sum[10:1]:sum[9:0];
//assign b1=temp;
assign sign=(ts1>ts2)?a[15]:b[15];
endgenerate
endmodule
