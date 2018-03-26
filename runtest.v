`timescale 1ns / 1ps

/*

Main cryptonight / cryptonote / monero test scrypt.

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

module runtest;
//reg [10:0][127:0] my_memory_t;
reg [4:0] i;
reg clk;
reg rstn;
wire done;
wire [31:0] gen_big_buffer_counter;
wire [31:0] shuffle_counter;
wire [31:0] small_buffer_counter;
reg [1535:0] starthash; //128*12-1, 12*16 = 192 bytes
always #0.01 clk = ~clk;
//always #1 clk = ~clk;
wire [1023:0] newhash;


cryptonight #(.RAM_DEPTH(1024*1024*2/16)) all0(.clk(clk), .rstn(rstn), .start_short_hash(starthash), .done(done), .gen_big_buffer_counter(gen_big_buffer_counter), 
 .shuffle_counter(shuffle_counter), .small_buffer_counter(small_buffer_counter), .newhash(newhash) );

initial begin
    
clk <= 0;
rstn <= 0;
  `h(starthash,0) <=  'h0dfc86880ff4027ec5d37243ee33b31d; // input 0
  `h(starthash,1) <=  'h54c8721205f6901b9d724f47ba95af4e; // input 1
  `h(starthash,2) <=  'ha20c8e28dec8498604da53ab86375576; // input 2
  `h(starthash,3) <=  'h5e3bb005a17380297dc82cb6e248c7a5; // input 3
  `h(starthash,4) <=  'h93f8247afb1875b3d3d74efcbef311de; // input 4
  `h(starthash,5) <=  'h6459878b3c7db10fa3daf06f7a028a0b; // input 5
  `h(starthash,6) <=  'h94ffac9657a292c1c920e1a0d6222775; // input 6
  `h(starthash,7) <=  'hbee39c044d70a771849ad1332184ecf4; // input 7
  `h(starthash,8) <=  'ha0fd73d6df7c2c72c0d7fe4925190359; // input 8
  `h(starthash,9) <=  'h8abacdd74c46828ee7b86aeafa0a4938; // input 9
  `h(starthash,10) <= 'h252f5367293118e951542132d4eabe61; // input 10
  `h(starthash,11) <= 'h4ef7590f95d3ac156cbca2071a989522; // input 11
#10;
rstn <= 1;
//$monitor ("TIME = %H %H %H %H %H", $time, gen_big_buffer_counter, shuffle_counter,  small_buffer_counter, done);
//#6000000;
#60000000;
$display("done? ", done);
$display(gen_big_buffer_counter);
$display(shuffle_counter);
$display(small_buffer_counter);
$finish();
end
endmodule
