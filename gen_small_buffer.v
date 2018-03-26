`timescale 1ns / 1ps

/*

Generate small cryptonight / cryptonote / monero buffer.

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

module gen_small_buffer  #
  (
        parameter NUM_ROUNDS = 'h020
  )
  (input clk, input rstn, input [31:0] start_mem_offset, input prev_buf_done, input read_done,
  input [255:0] hs2, input [1023:0] hs3,
  input [127:0] mem0, input [127:0] mem1, input [127:0] mem2, input [127:0] mem3,
  input [127:0] mem4, input [127:0] mem5, input [127:0] mem6, input [127:0] mem7,
  output reg start_read, output reg [31:0] mem_offset, output buf_done, output [1023:0] newhash);

  localparam nrounds = NUM_ROUNDS;

  (* keep = "true" *) reg [127:0] xout0, xout1, xout2, xout3, xout4, xout5, xout6, xout7;
  wire [127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9;
  wire keygen_done;
  wire [127:0] xout0_w, xout1_w, xout2_w, xout3_w, xout4_w, xout5_w, xout6_w, xout7_w;
  (* keep = "true" *) reg [clogb2(NUM_ROUNDS*8-1)-1:0] total;
  (* keep = "true" *) reg [2:0] counter;
  reg start_round;
  wire aes_round_done0;
  wire aes_round_done1;
  wire aes_round_done2;
  wire aes_round_done3;
  wire aes_round_done4;
  wire aes_round_done5;
  wire aes_round_done6;
  wire aes_round_done7;
  
  aes_genkey genkey(.clk(clk), .rstn(rstn), .input0( `h(hs2,0) ), .input1( `h(hs2,1) ), .keygen_done(keygen_done),
   .k0(k0), .k1(k1), .k2(k2), .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9));

  aes_round round0(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout0), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout0_w));
  aes_round round1(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout1), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout1_w));
  aes_round round2(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout2), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout2_w));
  aes_round round3(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout3), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout3_w));
  aes_round round4(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout4), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout4_w));
  aes_round round5(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout5), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout5_w));
  aes_round round6(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout6), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout6_w));
  aes_round round7(.clk(clk), .rstn(rstn), .start_round(start_round), .xin(xout7), .k0(k0), .k1(k1), .k2(k2),
    .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8), .k9(k9), .aes_round_done(aes_round_done0), .xout(xout7_w));

  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
  
  initial begin
    start_read <= 0;
    mem_offset <= 0;
    counter <= 0;
    total <= 0;
    start_round <= 0;
  end

  assign buf_done = (total == nrounds);
  
  // prev_buf_ready => start_read
  // read_ready => gen xout
  
  always @(posedge clk)
  begin
    if (rstn == 0 || total == nrounds)
    begin
      start_read <= 0;
      mem_offset <= 0;
    end
    else if (start_read == 0 && prev_buf_done && counter == 0 && total == 0)
    begin
         start_read <= 1;
        mem_offset <= start_mem_offset;
    end
    else if (start_read == 0 && prev_buf_done && counter == 1 && total != 0 && total < nrounds)
    begin
         start_read <= 1;
        mem_offset <= mem_offset + 16*8;
    end
    else if (read_done && counter == 1)
    begin
       start_read <= 0;
    end
    
  end
  
  always @(posedge clk)
  begin
    if (rstn == 0 || total == nrounds)
    begin
      start_round <= 0;
    end
    else if (read_done && counter == 1 && prev_buf_done && total < nrounds)
    begin
      start_round <= 1;
    end
    else if (aes_round_done0)
    begin
      start_round <= 0;
    end
  end

  always @(posedge clk)
  begin
    if (rstn == 0)
    begin
      total <= 0;
    end 
    else if (prev_buf_done && aes_round_done0 && counter == 2 && total < nrounds)
    begin
      total <= total + 1;
    end
  end

  always @(posedge clk)
  begin
    if (rstn == 0)
    begin
      counter <= 0;
    end
    else if (counter == 0 && total == 0 && start_round == 0 && prev_buf_done)
    begin
        //initial setup
          xout0 <= `h(hs3,0); // input 4
        xout1 <= `h(hs3,1); // input 5
        xout2 <= `h(hs3,2); // input 6
        xout3 <= `h(hs3,3); // input 7
        xout4 <= `h(hs3,4); // input 8
        xout5 <= `h(hs3,5); // input 9
        xout6 <= `h(hs3,6); // input 10
        xout7 <= `h(hs3,7); // input 11
        counter <= 1;
    end
    // check if we got data from memory
    else if (read_done && counter == 1)
    begin
      xout0 <= mem0 ^ xout0;
      xout1 <= mem1 ^ xout1;
      xout2 <= mem2 ^ xout2;
      xout3 <= mem3 ^ xout3;
      xout4 <= mem4 ^ xout4;
      xout5 <= mem5 ^ xout5;
      xout6 <= mem6 ^ xout6;
      xout7 <= mem7 ^ xout7;
      counter <= 2;
    end
    else if (aes_round_done0 && counter == 2 && total < nrounds)
    begin
        xout0 <= xout0_w;
        xout1 <= xout1_w;
        xout2 <= xout2_w;
        xout3 <= xout3_w;
        xout4 <= xout4_w;
        xout5 <= xout5_w;
        xout6 <= xout6_w;
        xout7 <= xout7_w;
        counter <= 1;
    end
  end

assign newhash = {xout0,xout1,xout2,xout3,xout4,xout5,xout6,xout7};

endmodule