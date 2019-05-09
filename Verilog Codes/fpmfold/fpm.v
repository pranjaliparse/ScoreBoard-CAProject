module fpm(input s1,input[4:0]e1,input [9:0]m1,input s2,input [4:0]e2,input [9:0]m2,output output_sign,output [4:0]oe,output [9:0]output_mantissa);

wire [10:0]n1,n2;
wire [21:0] o,o1;
wire [4:0] exponent;
wire [4:0]i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21;

genvar i;
generate 
for(i=0;i<=9;i=i+1)
begin
 assign n1[i]=m1[i];
 assign n2[i]=m2[i];
end

assign n1[10]=1'b1;
assign n2[10]=1'b1;

assign output_sign=s1^s2;
assign exponent=e1+e2-5'b01111;
assign o=n1*n2;


assign i0=(o[0]==1)?0:0;
assign i1=(o[1]==1)?1:i0;
assign i2=(o[2]==1)?2:i1;
assign i3=(o[3]==1)?3:i2;
assign i4=(o[4]==1)?4:i3;
assign i5=(o[5]==1)?5:i4;
assign i6=(o[6]==1)?6:i5;
assign i7=(o[7]==1)?7:i6;
assign i8=(o[8]==1)?8:i7;
assign i9=(o[9]==1)?9:i8;
assign i10=(o[10]==1)?10:i9;
assign i11=(o[11]==1)?11:i10;
assign i12=(o[12]==1)?12:i11;
assign i13=(o[13]==1)?13:i12;
assign i14=(o[14]==1)?14:i13;
assign i15=(o[15]==1)?15:i14;
assign i16=(o[16]==1)?16:i15;
assign i17=(o[17]==1)?17:i16;
assign i18=(o[18]==1)?18:i17;
assign i19=(o[19]==1)?19:i18;
assign i20=(o[20]==1)?20:i19;
assign i21=(o[21]==1)?21:i20;

assign oe=exponent+(i21-20);
assign o1=(o[21]==1)?o>>1:o<<(20-i11);


for(i=9;i>=0;i=i-1)
begin
assign output_mantissa[i]=o1[10+i];
end


endgenerate
endmodule
