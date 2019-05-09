module full(a,b,cin,s,c);
input a,b,cin;
output s,c;
wire su,c1,c2;
assign su=a^b;
assign c1=a&b;
assign s= su^cin;
assign c2= su&cin;

assign c=c1|c2;
endmodule