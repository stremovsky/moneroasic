`timescale 1ns / 1ps

/*

Generate big cryptonight / cryptonote / monero buffer.

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

`define h(hashname,pos)      hashname[(pos+1)*128-1:pos*128]

module gen_big_buffer #
  (
        parameter NUM_ROUNDS = 'h020
  )
  (input clk, input rstn, input [31:0] start_mem_offset, input write_done, input [255:0] hs1, input [1023:0] hs3,
  output [3:0] start_write, output reg [31:0] mem_offset, output reg buf_done,
  output [127:0] gen0, output [127:0] gen1, output [127:0] gen2, output [127:0] gen3,
  output [127:0] gen4, output [127:0] gen5, output [127:0] gen6, output [127:0] gen7);

  localparam nrounds = NUM_ROUNDS;

  wire keygen_done;
  wire aes_round_done0;
  wire aes_round_done1;
  wire aes_round_done2;
  wire aes_round_done3;
  wire aes_round_done4;
  wire aes_round_done5;
  wire aes_round_done6;
  wire aes_round_done7;

  (* keep = "true" *) reg [clogb2(NUM_ROUNDS*8-1)-1:0] total;
  (* keep = "true" *) reg [3:0] wcounter;
  
  wire [127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9;
  reg start_round;
  reg [127:0] xin0_r, xin1_r, xin2_r, xin3_r, xin4_r, xin5_r, xin6_r, xin7_r;
  wire [127:0] xout0_w, xout1_w, xout2_w, xout3_w, xout4_w, xout5_w, xout6_w, xout7_w;
  
  aes_genkey genkey(.clk(clk), .rstn(rstn), .input0( `h(hs1,0) ), .input1( `h(hs1,1) ), .keygen_done(keygen_done),
   .k0(k0), .k1(k1), .k2(k2), .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9));

  aes_round round0(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin0_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout0_w));
  aes_round round1(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin1_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done1), .xout(xout1_w));
  aes_round round2(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin2_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done2), .xout(xout2_w));
  aes_round round3(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin3_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done3), .xout(xout3_w));
  aes_round round4(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin4_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done4), .xout(xout4_w));
  aes_round round5(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin5_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done5), .xout(xout5_w));
  aes_round round6(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin6_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done6), .xout(xout6_w));
  aes_round round7(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xin7_r), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done7), .xout(xout7_w));

  assign gen0 = (aes_round_done0)? xout0_w : 0;
  assign gen1 = (aes_round_done0)? xout1_w : 0;
  assign gen2 = (aes_round_done0)? xout2_w : 0;
  assign gen3 = (aes_round_done0)? xout3_w : 0;
  assign gen4 = (aes_round_done0)? xout4_w : 0;
  assign gen5 = (aes_round_done0)? xout5_w : 0;
  assign gen6 = (aes_round_done0)? xout6_w : 0;
  assign gen7 = (aes_round_done0)? xout7_w : 0;
  
  assign start_write = wcounter;
  //assign buf_done = (total == nrounds);
  
  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
  
  initial begin
    total <= 0;
    buf_done = 0;
    wcounter <= 0;
    mem_offset <= 0;
    start_round <= 0;
    //start_write <= 0;
  end

  always @(posedge clk)
  begin
    if (rstn == 0)
    begin
        mem_offset = 0;
    end
    else if (total == 0)
    begin
        mem_offset <= start_mem_offset;
    end
    else if (write_done && wcounter == 0 && total != 0 && total < nrounds)
    begin
        mem_offset <= mem_offset + 16*8;
    end
  end
  
  always @(posedge clk)
  begin
    if (rstn == 0)
    begin
      total <= 0;
      buf_done <= 0;
    end
    else if (aes_round_done0  && wcounter == 8 && total < nrounds)
    begin
      total <= total + 1;
    end
    else if (aes_round_done0 && total == nrounds)
    begin
      buf_done <= 1;
    end
    
  end

  always @(posedge clk)
  begin
    if (rstn == 0 || (wcounter == 0 && total==0))
    begin
      xin0_r <= `h(hs3,0); // input 4
      xin1_r <= `h(hs3,1); // input 5
      xin2_r <= `h(hs3,2); // input 6
      xin3_r <= `h(hs3,3); // input 7
      xin4_r <= `h(hs3,4); // input 8
      xin5_r <= `h(hs3,5); // input 9
      xin6_r <= `h(hs3,6); // input 10
      xin7_r <= `h(hs3,7); // input 11
      /*
      xin0_r <= 'h11889900338885774499888812348880; // input 4
      xin1_r <= 'h22449660334459994499888812348880; // input 5
      xin2_r <= 'h33889900666455660099888111348880; // input 6
      xin3_r <= 'h44889900334444f64499998812348880; // input 7
      xin4_r <= 'h55a8aa003341116fff99888552348880; // input 8
      xin5_r <= 'h668899aa334456664499888812348880; // input 9
      xin6_r <= 'h77889900a34455664477788112348880; // input 10
      xin7_r <= 'h88a8990a355466667499888812348880; // input 11
      */
    end
    else if (keygen_done && wcounter == 8 && aes_round_done0)
    begin
      xin0_r <= xout0_w;
      xin1_r <= xout1_w;
      xin2_r <= xout2_w;
      xin3_r <= xout3_w;
      xin4_r <= xout4_w;
      xin5_r <= xout5_w;
      xin6_r <= xout6_w;
      xin7_r <= xout7_w;
    end
  end
  
  always @(posedge clk)
  begin
    if (rstn == 0)
    begin
      start_round <= 0;
    end
    else if (keygen_done && (write_done || wcounter==8))
    begin
        start_round <= 0;
    end
    else if (keygen_done && wcounter == 0 && buf_done == 0)
    begin
        start_round <= 1;
    end
  end
  
  always @(posedge clk)
  begin
    if (rstn == 0 /* || (write_done && start_write)*/)
    begin
      wcounter <= 0;
    end
    else if (aes_round_done0 && write_done == 0 && total < nrounds)
    begin
        if (wcounter != 8)
        begin
            wcounter = wcounter + 1;
        end
        else
         begin
            wcounter <= 0;
        end
    end
  end
  
endmodule