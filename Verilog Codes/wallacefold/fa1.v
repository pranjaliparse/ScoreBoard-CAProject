module fa(input a, input b,input c, output s, output v);

assign s=a^b^c;
assign v=(a&b)|(b&c)|(c&a);

endmodule