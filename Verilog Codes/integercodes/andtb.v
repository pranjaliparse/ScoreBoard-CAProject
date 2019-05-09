
                    module top;
                    reg [15:0]a;
                    reg [15:0]b;
                    wire [15:0]s;
                    and1 cla_0(a,b,s);
                    initial
                    begin
                    a=8; b=6;
                    end
                    initial
                    begin
                    $display("------SUB OPERATION------");
	            $monitor("time=%2d, a=%2d, b=%2d, sub=%2d",$time,a,b,s);
	            $dumpfile("cla_sub.vcd");
	            $dumpvars;
                    end
                    endmodule
                    