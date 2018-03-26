`timescale 1ns / 1ps

/*

AES encryption code.

Copyright 2018 Yuli Stremovsky <stremovsky@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

//sl_xor(a1 a2 a3 a4) = a1 (a2^a1) (a3^a2^a1) (a4^a3^a2^a1)

module aes_genkey_sub(input clk, input [3:0] rcon, input [127:0] xin0, input [127:0] xin2, output [127:0] xout0, output [127:0] xout2);

wire [31:0] sbox_result;
wire [31:0] sbox_result2;
wire [31:0] rot_result;
wire [127:0] temp;

aes_sbox sbox(.sboxw1(xin2[31:0]), .new_sboxw1(sbox_result),
              .sboxw2(temp[31:0] ^ rot_result), .new_sboxw2(sbox_result2));

assign rot_result = {sbox_result[23:16] ^ rcon, sbox_result[15:8], sbox_result[7:0], sbox_result[31:24]};   // rotr(x3,8)^rcon

assign temp = {xin0[127:96], xin0[127:96] ^ xin0[95:64], 
              xin0[127:96] ^ xin0[95:64] ^ xin0[63:32],
              xin0[127:96] ^ xin0[95:64] ^ xin0[63:32] ^ xin0[31:0]};
assign xout0 = temp ^ {rot_result,rot_result,rot_result,rot_result};

// sbox_result2 is result of
// soft_aeskeygenassist(*xout0, 0x00);
// _mm_shuffle_epi32(xout1, 0xAA);
assign xout2 = {xin2[127:96] ^ sbox_result2, xin2[127:96] ^ xin2[95:64] ^ sbox_result2, 
              xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ sbox_result2,
              xin2[127:96] ^ xin2[95:64] ^ xin2[63:32] ^ xin2[31:0] ^ sbox_result2};

endmodule
