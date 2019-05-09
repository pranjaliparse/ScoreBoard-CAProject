import os
import numpy as np

file = open("instructions.txt","r") 
data=file.readlines()
file.close()
k1=len(data) #no. of instructions

inst_status = [[0 for i in range(4)] for i in range(k1)]
func_unit = [[0 for i in range(9)] for i in range(6)]
result_status = [0 for i in range(33)] 
status_ins= [[0 for i in range(2)] for i in range(k1)] #instruction status
dep=[[0 for i in range(2)]for i in range(k1)]
reg1=[[0 for i in range(10)]for i in range(33)]
reg2=[[0 for i in range(10)]for i in range(33)]
redg=[[0 for i in range(10)]for i in range(33)]
count1=[0 for i in range(33)]
count2=[0 for i in range(33)]
countd=[0 for i in range(33)]
execute=[0 for i in range(k1)]

cyc=[]
cyc.append(0)
cyc.append(1)#add, sub, orr ,xor, xnr
cyc.append(10)#mul
cyc.append(11)#iml
cyc.append(2)#iad
cyc.append(1)#ldr, str

cycle=0 #number of cycles

op=[]
rd=[]
rs1=[]
rs2=[]
k=[]

for i in range(k1):
    status_ins[i][1]=1
    status_ins[i][0]=i
        
for line in data:
    op.append(line[0:3])

for line in data:
    rd.append(int(line[5:7]))

for line in data:
    rs1.append(int(line[9:11]))

for line in range(k1):
    if(op[line]!="ldr" and op[line]!="str"):
        line2=data[line]
        print(line2[13:15])
        rs2.append(int(line2[13:15]))
    else:
        rs2.append(0);

name=[]
name1=[]

for line in op:
    if(line=='add' or line =='sub' or line=='orr' or line=='xor' or line=='xnr'):
        name.append(1)
        #print(line)
        #print(name[0])
    elif(line== 'mul'):
        name.append(2)
    elif(line== 'iml'):
        name.append(3)
    elif(line== 'iad'):
        name.append(4)
    elif(line=='ldr' or line=='str'):
        name.append(5)

for line in range(k1):
    if(name[line]==5):
        name1.append("int")
    elif(name[line]==2):
        name1.append("mul")
    elif(name[line]==3):
        name1.append("iml")
    elif(name[line]==4):
        name1.append("iad")
    elif(name[line]==1):
        name1.append("add")
    
    
#print(name1)
#print(name)
func_unit[name[0]][0]="Yes"
func_unit[name[0]][1]=name[0]
func_unit[name[0]][2]=rd[0]
func_unit[name[0]][3]=rs1[0]
func_unit[name[0]][4]=rs2[0]
func_unit[name[0]][5]=result_status[rs1[0]]
func_unit[name[0]][6]=result_status[rs2[0]]
if(int(func_unit[name[0]][7])==0):
    func_unit[name[0]][7]="Yes"
if(int(func_unit[name[0]][8])==0):
    func_unit[name[0]][8]="Yes"

inst_status[0][0]=1
status_ins[0][1]=2
result_status[rd[0]]=name1[0]

#print(func_unit)

flag=[0 for i in range(k1)]
y=1
for c in range(100):
    if(c==0 or c==1):
        continue
    else:
        for z in range(y,-1,-1):
            if(z!=0 and status_ins[z-1][1]>1 and (func_unit[name[z]][0]==0) and result_status[rd[z]]==0 and flag[z]==0):
                func_unit[name[z]][0]="Yes"
                func_unit[name[z]][1]=z
                func_unit[name[z]][2]=rd[z]
                func_unit[name[z]][3]=rs1[z]
                if(op[z]!="ldr" or op[z]!="str"):
                    func_unit[name[z]][4]=rs2[z]
                func_unit[name[z]][5]=result_status[rs1[z]]
                if(op[z]!="ldr" or op[z]!="str"):
                    func_unit[name[z]][6]=result_status[rs2[z]]
                if((func_unit[name[z]][5])==0):
                    func_unit[name[z]][7]="Yes"
                else:
                    func_unit[name[z]][7]="No"
                    reg1[rs1[z]][count1[z]]=name[z]
                    count1[rs1[z]]=count1[rs1[z]]+1
                    #dep[z][0]=rs1[z]
                if((func_unit[name[z]][6])==0):
                    func_unit[name[z]][8]="Yes"
                elif(op[z]!="ldr" or op[z]!="str"):
                    func_unit[name[z]][8]="No"
                reg2[rs2[z]][count2[z]]=name[z]
                count2[rs2[z]]=count2[rs2[z]]+1
                #dep[z][1]=rs2[z]
                status_ins[z][1]=status_ins[z][1]+1
                inst_status[z][0]=c
                result_status[rd[z]]=name1[z]
                #regd[rd[z]][countd[z]]=z
                #countd[rd[z]]=countd[rd[z]]+1
            elif(status_ins[z][1]==2 and func_unit[name[z]][7]=="Yes" and func_unit[name[z]][8]=="Yes"):
                inst_status[z][1]=c
                status_ins[z][1]=status_ins[z][1]+1
            elif(status_ins[z][1]>2 and status_ins[z][1]<3+cyc[name[z]] and func_unit[name[z]][7]=="Yes" and func_unit[name[z]][8]=="Yes"):
                if(name1[z]=="add" and execute[z]==0 and op[z]=="add"):
                    print("\n")
                    execute[z]=1
                    a="5"
                    b="6"
                    file1=open("clatb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg [15:0]a;
                    reg [15:0]b;
                    wire [16:0]s;
                    hsfl cla_0(a,b,s);
                    initial
                    begin
                    a='''+a+'''; b='''+b+''';
                    end
                    initial
                    begin
                    $display("------ADD OPERATION------");
	            $monitor("time=%2d, a=%2d, b=%2d, sum=%2d",$time,a,b,s);
	            $dumpfile("cla_adder1.vcd");
	            $dumpvars;
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o cla cla.v clatb.v")#executing this command gives us the executable "cla"
                    os.system("vvp cla>result.txt")#direct the output to "result.txt" file
                    os.system("vvp cla")
                    #print("\n")

                if(name1[z]=="add" and execute[z]==0 and op[z]=="sub"):
                    print("\n")
                    execute[z]=1
                    a="8"
                    b="6"
                    file1=open("subtb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg [15:0]a;
                    reg [15:0]b;
                    wire [15:0]s;
                    sub cla_0(a,b,s);
                    initial
                    begin
                    a='''+a+'''; b='''+b+''';
                    end
                    initial
                    begin
                    $display("------SUB OPERATION------");
	            $monitor("time=%2d, a=%2d, b=%2d, sub=%2d",$time,a,b,s);
	            $dumpfile("cla_sub.vcd");
	            $dumpvars;
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o sub sub.v subtb.v")#executing this command gives us the executable "cla"
                    os.system("vvp sub>result.txt")#direct the output to "result.txt" file
                    os.system("vvp sub")
                    #print("\n")
                    
                if(name1[z]=="int" and execute[z]==0 and (op[z]=="ldr" or op[z]=="str")):
                    #print("\n")
                    execute[z]=1
                    a="8"
                    if(op[z]=="ldr"):
                        print("------LOAD OPERATION------")
                    elif(op[z]=="str"):
                        print("------STORE OPERATION------")
                    #print(str1)
                    file1=open("ldrtb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg [15:0]a;
                    wire [15:0]s;
                    ldr ldr_0(a,s);
                    initial
                    begin
                    a='''+a+'''; 
                    end
                    initial
                    begin
	            $monitor("time=%2d, a=%2d, output value=%2d",$time,a,s);
	            $dumpfile("ldr.vcd");
	            $dumpvars;
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o ldr ldr.v ldrtb.v")#executing this command gives us the executable "cla"
                    os.system("vvp ldr>result.txt")#direct the output to "result.txt" file
                    os.system("vvp ldr")
                    #print("\n")
                
                   
                if(name1[z]=="iml" and execute[z]==0):
                    print("\n")
                    execute[z]=1
                    s1="1'b0";
                    e1="5'b10000";
                    m1="10'b1101001101";
                    s2="1'b1";
                    e2="5'b10010";
                    m2="10'b0010111111";
                    file1=open("fpmtb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg s1,s2;
                    reg [4:0]e1,e2;
                    reg [9:0]m1,m2;
                    wire [9:0] out1;
                    wire [4:0] oe;
                    wire os;
                    fpm n(s1,e1,m1,s2,e2,m2,os,oe,out1);
                    initial
                    begin
                    s1='''+s1+'''; e1='''+e1+'''; m1='''+m1+'''; s2='''+s2+''';  e2='''+e2+'''; m2='''+m2+''';
                    end
                    initial
                    begin
                    $display("------FMUL OPERATION------");
                    $monitor("a=%b %b %b\tb=%b %b %b\toutput=%b %b %b",s1,e1,m1,s2,e2,m2,os,oe,out1);
	            $dumpfile("fmu1.vcd");
	            $dumpvars;
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o fpm fpm.v fpmtb.v")#executing this command gives us the executable "cla"
                    os.system("vvp fpm>result.txt")#direct the output to "result.txt" file
                    os.system("vvp fpm")

                if(name1[z]=="mul" and execute[z]==0):
                    print("\n")
                    execute[z]=1
                    a="8"
                    b="9"
                    file1=open("ldrtb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg [15:0]a;
                    reg [15:0]b;
                    wire [31:0]s;
                    wallace wal_0(a,b,s);
                    initial
                    begin
                    a='''+a+'''; b='''+b+'''; 
                    end
                    initial
                    begin
                    $display("------MUL OPERATION------");
	            $monitor("time=%2d, a=%2d, b=%2d, output=%2d",$time,a,b,s);
	            $dumpfile("wal.vcd");
	            $dumpvars;
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o wal wallace.v wallacetb.v")#executing this command gives us the executable "cla"
                    os.system("vvp wal>result.txt")#direct the output to "result.txt" file
                    os.system("vvp wal")
                    #print("\n")
                    
                if(name1[z]=="iad" and execute[z]==0):
                    print("\n")
                    execute[z]=1
                    a="16'b1100000100000000"
                    b="16'b0100100101000000"
                    file1=open("ieeeaddertb.v","w")#creating the tb file
                    file1.write('''
                    module top;
                    reg[15:0] a;
                    reg[15:0] b;
                    wire[4:0] s;
                    wire[9:0] z;
                    wire sign;
                    adder a1(a,b,s,z,sign);
                    initial begin
                    a='''+a+'''; b='''+b+''';
                    end
                    initial
                    begin
                    $display("------FADD OPERATION------");
                    $monitor("time=%3d   a=%16b\tb=%16b\t%b %b %b",$time,a,b,sign,s,z);
                    $dumpfile("test1.vcd");
                    $dumpvars;
                    
                    end
                    endmodule
                    ''')#writing the tb file
                    file1.close()#close the tb file
                    #make sure cla_adder1.v and Sample.py are in the same folder as this python script
                    os.system("iverilog -o iad ieeeadder.v ieeeaddertb.v")#executing this command gives us the executable "cla"
                    os.system("vvp iad>result.txt")#direct the output to "result.txt" file
                    os.system("vvp iad")
                    #print("\n")

                inst_status[z][2]=c
                status_ins[z][1]=status_ins[z][1]+1    
            elif(status_ins[z][1]==3+cyc[name[z]] and flag[z]==0 and func_unit[name[z]][7]=="Yes" and func_unit[name[z]][8]=="Yes"):
                #print("rd")
                #print(rd[z])
                for x in range(count1[rd[z]]):
                    #print("x: ",x)
                    #print("Nooooo",reg1[rd[z]][x])
                    #print(func_unit[reg1[1])
                    #print(func_unit[reg1[rd[z]][x]+1][7])
                    #print("Hey: ",func_unit[1])
                    #print(rd[z]," ",z)
                    func_unit[reg1[rd[z]][x]][7]="Yes"
                
                for x in range(count2[rd[z]]):
                    func_unit[reg2[rd[z]][x]][8]="Yes"
                func_unit[name[z]][0]=0
                func_unit[name[z]][1]=0
                func_unit[name[z]][2]=0
                func_unit[name[z]][3]=0
                func_unit[name[z]][4]=0
                func_unit[name[z]][5]=0
                func_unit[name[z]][6]=0
                func_unit[name[z]][7]=0
                func_unit[name[z]][8]=0
                result_status[rd[z]]=0
                flag[z]=1
                inst_status[z][3]=c
                
                
                
                
        if(y<k1-1):
            y=y+1
    #print(func_unit)
    #print(status_ins)
    #print(inst_status)
    #print(result_status)

#print(func_unit)
print("\n")
for i in range(k1):
    print("INSTRUCTION ",i+1,": #",cyc[name[i]],"cycles   ",data[i][0:len(data[i])-1])

print("\n")
print("                      IF   RO   EX   WR")
for i in range(k1):
    print("INSTRUCTION ",i+1,":      ",inst_status[i][0],"  ",inst_status[i][1],"  ",inst_status[i][2],"  ",inst_status[i][3])
                   
                
            
        
        
#print(reg1[1][0])
    
    
    
