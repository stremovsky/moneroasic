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

module aes_round(input clk, input rstn, input start_round, input [127:0] xin, input [127:0] k0, input [127:0] k1, input [127:0] k2,
input [127:0] k3, input [127:0] k4, input [127:0] k5, input [127:0] k6,
input [127:0] k7, input [127:0] k8, input [127:0] k9, output aes_round_done, output [127:0] xout);

reg [127:0] xxin;
reg [127:0] key;
wire [127:0] xxout;
reg [4:0] counter;
reg aes_round_done_flag;

encstepnew step0(.clk(clk), .cxx(xxin), .key(key), .enc(xxout));

assign xout = (aes_round_done_flag) ? xxout : 0;
assign aes_round_done = aes_round_done_flag;

always @(posedge clk)
begin
  if (rstn == 0 || start_round == 0)
  begin
    counter <= 0;
    aes_round_done_flag <= 0;
  end
  else if (start_round && aes_round_done_flag == 0)
  begin
    case (counter)
      0: begin
         xxin <= xin;
         key <= k0;
         counter <= 1;
         end
      1: begin
         xxin <= xxout;
         key <= k1;
         counter <= 2;
         end
      2: begin
         xxin <= xxout;
         key <= k2;
         counter <= 3;
         end
      3: begin
         xxin <= xxout;
         key <= k3;
         counter <= 4;
         end
      4: begin
         xxin <= xxout;
         key <= k4;
         counter <= 5;
         end
      5: begin
         xxin <= xxout;
         key <= k5;
         counter <= 6;
         end
      6: begin
         xxin <= xxout;
         key <= k6;
         counter <= 7;
         end
      7: begin
         xxin <= xxout;
         key <= k7;
         counter <= 8;
         end
      8: begin
         xxin <= xxout;
         key <= k8;
         counter <= 9;
         end
      9: begin
         xxin <= xxout;
         key <= k9;
         counter <= 0;
         aes_round_done_flag <= 1;
         end
      //10: begin
      // counter <= 0;
      // aes_round_done <= 1;
      // end
     endcase
  end
end

endmodule


/*

module aes_fast_round(input clk, input start_round, input [127:0] xin, input [127:0] k0, input [127:0] k1, input [127:0] k2,
input [127:0] k3, input [127:0] k4, input [127:0] k5, input [127:0] k6,
input [127:0] k7, input [127:0] k8, input [127:0] k9, output aes_round_done, output [127:0] xout);

wire [127:0] xout0;
wire [127:0] xout1;
wire [127:0] xout2;
wire [127:0] xout3;
wire [127:0] xout4;
wire [127:0] xout5;
wire [127:0] xout6;
wire [127:0] xout7;
wire [127:0] xout8;
wire [127:0] xout9;
//reg [127:0] xout_r;

encstepnew step0(.clk(clk), .cxx(xin), .key(k0), .enc(xout0));
encstepnew step1(.clk(clk), .cxx(xout0), .key(k1), .enc(xout1));
encstepnew step2(.clk(clk), .cxx(xout1), .key(k2), .enc(xout2));
encstepnew step3(.clk(clk), .cxx(xout2), .key(k3), .enc(xout3));
encstepnew step4(.clk(clk), .cxx(xout3), .key(k4), .enc(xout4));
encstepnew step5(.clk(clk), .cxx(xout4), .key(k5), .enc(xout5));
encstepnew step6(.clk(clk), .cxx(xout5), .key(k6), .enc(xout6));
encstepnew step7(.clk(clk), .cxx(xout6), .key(k7), .enc(xout7));
encstepnew step8(.clk(clk), .cxx(xout7), .key(k8), .enc(xout8));
encstepnew step9(.clk(clk), .cxx(xout8), .key(k9), .enc(xout9));

assign xout = xout9;
assign aes_round_done = 1;

//always @(posedge clk)
//begin
  //if (start_round)
  //begin
  //  xout_r <= xout7;
  //end else begin
  //  xout_r <= 0;
  //end
//end

endmodule

*/
