`timescale 1ns / 1ps

//sl_xor(a1 a2 a3 a4) = a1 (a2^a1) (a3^a2^a1) (a4^a3^a2^a1)

/*
module aes_keygenassist(input [7:0] rcon, input [31:0] byte1, input [31:0] byte3, input [127:0] x0, output res[127:0]);

wire xbyte1[31:0];
wire xbyte3[31:0];
reg opx0[127:0];

assign opx0 = {x0};
aes_sbox sbox(.sboxw1(byte1), .new_sboxw1(xbyte1), .sboxw2(byte3), new_sboxw1(xbyte3) );

// ??? mm_shuffle_epi32(xout1, 0xFF);
assign res <= {{byte3[31:8],byte3[7:0] ^ rcon}, byte3, {byte1[31:8],byte1[7:0] ^ rcon}, byte1}
assign res2 <=  x0 ^ opx0 ^ res;

endmodule
*/

/*
module aes_genkey_sub(input clk, input [3:0] rcon, input [127:0] xin0, input [127:0] xin2, output [127:0] xout0, output [127:0] xout2);

wire [31:0] sbox_result;
wire [31:0] sbox_result2;
wire [31:0] rot_result;
wire [127:0] temp;
reg [127:0] temp2;
//reg [7:0] rot_byte;

//temp[31:0], temp[63:32], temp[95:64], temp[127:96]
aes_sbox sbox(.sboxw1(xin2[31:0]), .new_sboxw1(sbox_result),
              .sboxw2(temp[31:0]), .new_sboxw2(sbox_result2));

assign rot_result = {sbox_result[7:0], sbox_result[31:16], sbox_result[15:8] ^ rcon};

assign temp = {xin0[127:96] ^ rot_result, xin0[127:96] ^ xin0[95:64] ^ rot_result, 
              xin0[127:96] ^ xin0[95:64] ^ xin0[63:32] ^ rot_result,
			  xin0[127:96] ^ xin0[95:64] ^ xin0[63:32] ^ xin0[31:0] ^ rot_result};
assign xout0 = temp;
// sbox_result2 is result of
// soft_aeskeygenassist(*xout0, 0x00);
// _mm_shuffle_epi32(xout1, 0xAA);
assign xout2 = {xin2[127:96] ^ sbox_result2, xin2[127:96] ^ xin2[95:64] ^ sbox_result2, 
              xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ sbox_result2,
			  xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ xin2[31:0] ^ sbox_result2};

endmodule
*/


/*
module aes_genkey_sub2(input clk, input [7:0] rcon, input [127:0] xin0, input [127:0] xin2, output [127:0] xout0, output [127:0] xout2);

wire [31:0] sbox_result;
wire [31:0] sbox_result2;
reg [31:0] rot_result;
reg [127:0] temp;
reg [127:0] temp2;
//reg [7:0] rot_byte;

aes_sbox sbox(.sboxw1(xin2[31:0]), .new_sboxw1(sbox_result),
              .sboxw2(temp[31:0]), .new_sboxw2(sbox_result2));

always @(posedge clk) begin
  $display("sbox_result 0x%H", sbox_result);
  //rot_byte = {sbox_result[15:8]} ^ rcon;
  //$display("rot byte 0x%H", rot_byte);
  rot_result = {sbox_result[7:0], sbox_result[31:16], {sbox_result[15:8]} ^ rcon};
  $display("rot res 0x%H", rot_result);
  temp = {xin0[127:96] ^ rot_result, xin0[127:96] ^ xin0[95:64] ^ rot_result, 
              xin0[127:96] ^ xin0[95:64] ^ xin0[63:32] ^ rot_result,
			  xin0[127:96] ^ xin0[95:64] ^ xin0[63:32] ^ xin0[31:0] ^ rot_result};
  //xout0 = temp;
  // sbox_result2 is result of
  // soft_aeskeygenassist(*xout0, 0x00);
  // _mm_shuffle_epi32(xout1, 0xAA);
  temp2 = {xin2[127:96] ^ sbox_result2, xin2[127:96] ^ xin2[95:64] ^ sbox_result2, 
              xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ sbox_result2,
			  xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ xin2[31:0] ^ sbox_result2};
  $display("temp %H", temp);
  $display("temp2 %H", temp2);
end

assign xout0 = temp;
assign xout2 = temp2;

endmodule
*/

module aes_genkey(input clk, input rstn, input [127:0] input0, input [127:0] input1, output keygen_done,
output [127:0] k0, output [127:0] k1, output [127:0] k2, output [127:0] k3, output [127:0] k4,
output [127:0] k5, output [127:0] k6, output [127:0] k7, output [127:0] k8, output [127:0] k9);

//wire [127:0] inw0;
//wire [127:0] inw2;

reg [127:0] in0;
reg [127:0] in2;
wire [127:0] temp0;
wire [127:0] temp2;
//reg [127:0] k0_r;
//reg [127:0] k1_r;
(* keep = "true" *) reg [127:0] k2_r, k3_r, k4_r, k5_r, k6_r, k7_r, k8_r, k9_r;
//(* keep = "true" *)
reg [2:0] counter;
reg [3:0] rcon;
//(* keep = "true" *) 
reg keygen_done_r;

aes_genkey_sub sub0(.clk(clk), .rcon(rcon), .xin0(in0), .xin2(in2), .xout0(temp0), .xout2(temp2));

initial begin
  keygen_done_r <= 0;
  counter <= 0;
  //k0_r <= 0;
  //k1_r <= 0;
  k2_r <= 0;
  k3_r <= 0;
  k3_r <= 0;
  k4_r <= 0;
  k5_r <= 0;
  k6_r <= 0;
  k7_r <= 0;
  k8_r <= 0;
  k9_r <= 0;
end

always @(posedge clk)
begin
  if (rstn == 0)
  begin
    keygen_done_r <= 0;
    counter <= 0;
    in0 <= 0;
    in2 <= 0;    
    k2_r <= 0;
    k3_r <= 0;
    k3_r <= 0;
    k4_r <= 0;
    k5_r <= 0;
    k6_r <= 0;
    k7_r <= 0;
    k8_r <= 0;
    k9_r <= 0;
  end
  else
  if (keygen_done_r == 0)
  begin
    case(counter)
    0: begin
	   // do nothing here
	   // we need to get value for input
	   counter <= 1;
	   end
    1: begin
	   //k0_r <= input0;
	   //k1_r <= input1;
	   in0  <= input0;
	   in2  <= input1;
	   rcon <= 1;
	   counter <= 2;
	   end
	2: begin
	   k2_r <= temp0;
	   k3_r <= temp2;
	   in0  <= temp0;
	   in2  <= temp2;
 	   rcon <= 2;
	   counter <= 3;
	   end
	3: begin
	   k4_r <= temp0;
	   k5_r <= temp2;
	   in0  <= temp0;
	   in2  <= temp2;
	   rcon <= 4;
  	   counter <= 4;
	   end
	4: begin
	   k6_r <= temp0;
	   k7_r <= temp2;
	   in0  <= temp0;
	   in2  <= temp2;
	   rcon <= 8;
   	   counter <= 5;
	   end
	5: begin
	   k8_r <= temp0;
	   k9_r <= temp2;
	   keygen_done_r <= 1;
   	   counter <= 1;
	   end
    endcase
  end
end

/*
always @(posedge clk)
begin
  if (counter == 1)
  begin
	   //k0_r <= input0;
	   //k1_r <= input1;
	   in0  <= input0;
	   in2  <= input1;
	   rcon <= 1;
  end
  else if (counter == 2)
  begin
	   k2_r <= temp0;
	   k3_r <= temp2;
	   in0  <= temp0;
	   in2  <= temp2;
 	   rcon <= 2;
  end
  else if (counter == 3)
  begin
  	   k4_r <= temp0;
	   k5_r <= temp2;
	   in0  <= temp0;
	   in2  <= temp2;
	   rcon <= 4;
  end
end
*/

assign k0 = input0; //k0_r;
assign k1 = input1; //k1_r;
assign k2 = k2_r;
assign k3 = k3_r;
assign k4 = k4_r;
assign k5 = k5_r;
assign k6 = k6_r;
assign k7 = k7_r;
assign k8 = k8_r;
assign k9 = k9_r;
assign keygen_done = keygen_done_r;

endmodule
