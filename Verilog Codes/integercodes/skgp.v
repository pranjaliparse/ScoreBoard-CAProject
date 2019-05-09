module skgp(input[1:0] a,input[1:0] b,output[1:0] out);

assign out[0]=(a[1]&a[0]) | (a[0] &b[0]);
assign out[1]=(a[1]&a[0]) | (a[0] &b[1]);

endmodule