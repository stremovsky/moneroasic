`timescale 1ns / 1ps

/*

Main cryptonight / cryptonote / monero hashing code.

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
`define h64(hashname,pos)      hashname[(pos+1)*64-1:pos*64]
`define rev32(vname,start)    {vname[start+7:start], vname[start+15:start+8], vname[start+23:start+16], vname[start+31:start+24]}
`define rev64(vname,st)      {vname[st+7:st], vname[st+15:st+8], vname[st+23:st+16], vname[st+31:st+24], vname[st+39:st+32], vname[st+47:st+40], vname[st+55:st+48], vname[st+63:st+56]}

`define rev32_op(op) { ((op)<<24 & 'hff000000) | ((op)<<8 & 'h00ff0000) | ((op)>>8 & 'h0000ff00) | ((op)>>24 & 'h000000ff) }
//`define rev64_op(op) { ( ((op)<<56 & 'hff00000000000000) | ((op)<<40 & 'h00ff000000000000) | ((op)<<24 & 'h0000ff0000000000) | ((op)<<8  & 'h000000ff00000000) | ((op)>>8  & 'h00000000ff000000) | ((op)>>24 & 'h0000000000ff0000) | ((op)>>40 & 'h000000000000ff00) | ((op)>>56 & 'h00000000000000ff) )}
`define rev64_op(op)  { $unsigned(op) <<56 | $unsigned(op) >> 8 << 56 >> 8 | $unsigned(op) >> 16 << 56 >> 16 | $unsigned(op) >> 24 << 56 >> 24 | $unsigned(op) >> 32 << 56 >> 32 | $unsigned(op) >> 40 << 56 >> 40 | $unsigned(op) >> 48 << 56 >> 48 | $unsigned(op) >> 56 }


module mult_gen_0 (input CLK, input [63:0] A, input [63:0] B, output reg [127:0] P);
always @(posedge CLK) begin
    P <= A*B;
end
endmodule

module cryptonight#
  (
        parameter RAM_DEPTH = 64
  )
  (input clk, input rstn, input [1535:0] start_short_hash, output reg done, output reg [31:0] gen_big_buffer_counter, 
  output reg [31:0] shuffle_counter, output reg [31:0] small_buffer_counter, output [1023:0] newhash);

//localparam RAM_DEPTH = 1024*1;                  // Specify RAM depth (number of entries)
localparam MMASK = RAM_DEPTH * 16 - 16;
localparam NUM_GEN_ROUNDS = RAM_DEPTH/8;            // for 2mb = 16384
localparam enc_rounds = RAM_DEPTH*4;

reg [63:0] ah0;
reg [63:0] al0;
reg [127:0] bx0;
wire [127:0] mx;
reg [127:0] cx;
wire [127:0] cxenc;
reg [127:0] old;
reg [63:0] idx0;
//reg [31:0] hs_1_0,hs_5_0, hd0,hd1;
//reg [clogb2(RAM_DEPTH-1)-1:0] idx1;
reg [127:0] wr;
reg [127:0] wr2;
reg [63:0] ma;
reg [31:0] idx1;
reg [31:0] idx2;
reg [4:0] counter;
reg [31:0] block_counter;
reg start_shuffle_flag;
reg shuffle_done_flag;
reg [31:0] start_mem_offset;
reg gen_buf_write_done;
wire [3:0] gen_buf_write_flag;
wire gen_buf_ready;
wire [31:0] gen_buf_mem_offset;
wire [31:0] small_buf_mem_offset;
wire [127:0] gen0, gen1, gen2, gen3, gen4, gen5, gen6, gen7;
reg [127:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7;
reg buf_read_done;
wire buf_read_start;
wire small_buf_ready;
//wire [1023:0] newhash;
//reg [127:0] my_memory [10000:0]; // 2mb = (2*1024*1024)/16 = 0x20000
//(* ram_style = "block" *) 
reg [127:0] my_memory [RAM_DEPTH-1:0]; // 2mb = (2*1024*1024)/16 = 0x20000
//reg [1535:0] start_short_hash; //128*12-1, 12*16 = 192 bytes

  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
  
//assign done = done_flag;
initial begin
  counter <= 0;
  block_counter <= 0;
  start_shuffle_flag <= 0;
  start_mem_offset <= 0;
  gen_buf_write_done <= 0;
  gen_big_buffer_counter <= 0;
  small_buffer_counter <= 0;
  shuffle_counter <= 0;
  buf_read_done <= 0;
  done <= 0;
  old <= 0;
  idx0 <= 0;
  shuffle_done_flag <= 0;
  /*
  `h(start_short_hash,0) <=  'h0dfc86880ff4027ec5d37243ee33b31d; // input 0
  `h(start_short_hash,1) <=  'h54c8721205f6901b9d724f47ba95af4e; // input 1
  `h(start_short_hash,2) <=  'ha20c8e28dec8498604da53ab86375576; // input 2
  `h(start_short_hash,3) <=  'h5e3bb005a17380297dc82cb6e248c7a5; // input 3
  `h(start_short_hash,4) <=  'h93f8247afb1875b3d3d74efcbef311de; // input 4
  `h(start_short_hash,5) <=  'h6459878b3c7db10fa3daf06f7a028a0b; // input 5
  `h(start_short_hash,6) <=  'h94ffac9657a292c1c920e1a0d6222775; // input 6
  `h(start_short_hash,7) <=  'hbee39c044d70a771849ad1332184ecf4; // input 7
  `h(start_short_hash,8) <=  'ha0fd73d6df7c2c72c0d7fe4925190359; // input 8
  `h(start_short_hash,9) <=  'h8abacdd74c46828ee7b86aeafa0a4938; // input 9
  `h(start_short_hash,10) <= 'h252f5367293118e951542132d4eabe61; // input 10
  `h(start_short_hash,11) <= 'h4ef7590f95d3ac156cbca2071a989522; // input 11
  */
  $display("RAM_DEPTH 0x%H", RAM_DEPTH);
  $display("MMASK 0x%H", MMASK);
  $display("NUM_GEN_ROUNDS 0x%H", NUM_GEN_ROUNDS);
  $display("enc_rounds 0x%H", enc_rounds);
end

//(* keep_hierarchy = "yes" *) 
encstepnew encstep_f(.clk(clk), .cxx(cx), .key({`rev64(ah0,0),`rev64(al0,0)}), .enc(cxenc));

//(* keep_hierarchy = "yes" *) 
gen_big_buffer #(.NUM_ROUNDS(NUM_GEN_ROUNDS)) big0
 (.clk(clk), .rstn(rstn), .start_mem_offset(start_mem_offset), .write_done(gen_buf_write_done), 
  .hs1(start_short_hash[255:0]), .hs3(start_short_hash[1535:512]),
  .start_write(gen_buf_write_flag), .mem_offset(gen_buf_mem_offset), .buf_done(gen_buf_ready),
  .gen0(gen0), .gen1(gen1), .gen2(gen2), .gen3(gen3), .gen4(gen4), .gen5(gen5), .gen6(gen6), .gen7(gen7));

//(* keep_hierarchy = "yes" *)
gen_small_buffer #(.NUM_ROUNDS(NUM_GEN_ROUNDS)) small0
 (.clk(clk), .rstn(rstn), .start_mem_offset(start_mem_offset), .prev_buf_done(shuffle_done_flag), .read_done(buf_read_done),
  .hs2(start_short_hash[511:256]), .hs3(start_short_hash[1535:512]),
  .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3), .mem4(mem4), .mem5(mem5), .mem6(mem6), .mem7(mem7),
  .start_read(buf_read_start), .mem_offset(small_buf_mem_offset), .buf_done(small_buf_ready), .newhash(newhash) );

mult_gen_0 mul128bit0 (
  .CLK(clk),  // input wire CLK
  .A(idx0),      // input wire [63 : 0] A
  .B(`rev64(old,64)),      // input wire [63 : 0] B
  .P(mx)      // output wire [127 : 0] P
);

always @(posedge clk) begin
  if (rstn == 0)
  begin
    gen_big_buffer_counter <= 0;
  end
  else if (gen_buf_ready == 0)
  begin
    gen_big_buffer_counter <= gen_big_buffer_counter + 1;
  end
end
        
  
always @(posedge clk) begin
  if (rstn == 0)
  begin
    shuffle_done_flag <= 0;
    start_shuffle_flag <= 0;
    //gen_buf_ready <= 0;
    shuffle_counter <= 0;
    counter <= 0;
    gen_buf_write_done <= 0;
  end
  /*
  else if (gen_buf_ready == 0)
  begin
    if (gen_buf_write_flag == 2) // all xinX records are ready
    begin
        my_memory[(gen_buf_mem_offset>>4)+0] <= xin0;
        my_memory[(gen_buf_mem_offset>>4)+1] <= xin1;
        my_memory[(gen_buf_mem_offset>>4)+2] <= xin2;
        my_memory[(gen_buf_mem_offset>>4)+3] <= xin3;
        my_memory[(gen_buf_mem_offset>>4)+4] <= xin4;
        my_memory[(gen_buf_mem_offset>>4)+5] <= xin5;
        my_memory[(gen_buf_mem_offset>>4)+6] <= xin6;
        my_memory[(gen_buf_mem_offset>>4)+7] <= xin7;
        gen_buf_write_done <= 1;
    end
    else
    begin
        gen_buf_write_done <= 0;
    end
  end
  */  
  else if (gen_buf_ready && start_shuffle_flag == 0)
  begin
      $display("first buffer ready");
      $display(gen_big_buffer_counter);
      start_shuffle_flag <= 1;
      counter <= 1;
  end
  //
  //  Shuffle code
  //
  else if (gen_buf_ready == 0 && gen_buf_write_flag == 0 && gen_buf_write_done == 1)
  begin
    gen_buf_write_done <= 0;
  end
  else if ((start_shuffle_flag && block_counter < enc_rounds) ||
           (gen_buf_ready == 0 && gen_buf_write_flag > 0) )
  begin
    case(counter)
      0:begin
        case (gen_buf_write_flag)
        1:begin
          my_memory[(gen_buf_mem_offset>>4)+0] <= gen0;
          gen_buf_write_done <= 0;
          //$display("writing 0x%H at 0x%H", gen0, (gen_buf_mem_offset>>4)+0);
          end
        2:begin
          my_memory[(gen_buf_mem_offset>>4)+1] <= gen1;
          //$display("prev mem is 0x%H at 0x%H", my_memory[(gen_buf_mem_offset>>4)+0], (gen_buf_mem_offset>>4)+0);
          end
        3:begin
          my_memory[(gen_buf_mem_offset>>4)+2] <= gen2;
          end
        4:begin
          my_memory[(gen_buf_mem_offset>>4)+3] <= gen3;
          end
        5:begin
          my_memory[(gen_buf_mem_offset>>4)+4] <= gen4;
          end
        6:begin
          my_memory[(gen_buf_mem_offset>>4)+5] <= gen5;
          end
        7:begin
          my_memory[(gen_buf_mem_offset>>4)+6] <= gen6;
          end
        8:begin
          my_memory[(gen_buf_mem_offset>>4)+7] <= gen7;
          gen_buf_write_done <= 1;
          end
        endcase
        /*
        my_memory[(gen_buf_mem_offset>>4)+0] <= xin0;
        my_memory[(gen_buf_mem_offset>>4)+1] <= xin1;
        my_memory[(gen_buf_mem_offset>>4)+2] <= xin2;
        my_memory[(gen_buf_mem_offset>>4)+3] <= xin3;
        my_memory[(gen_buf_mem_offset>>4)+4] <= xin4;
        my_memory[(gen_buf_mem_offset>>4)+5] <= xin5;
        my_memory[(gen_buf_mem_offset>>4)+6] <= xin6;
        my_memory[(gen_buf_mem_offset>>4)+7] <= xin7;
        */
        //counter = 1;
      end
      1:begin
        //hd0 <= ({start_short_hash[103:96], start_short_hash[111:104], start_short_hash[119:112], start_short_hash[127:120]} ^ {start_short_hash[359:352], start_short_hash[367:360], start_short_hash[375:368], start_short_hash[383:376]}) ;
        //hd1 <= (start_short_hash[127:96] ^ start_short_hash[387:352]) ;
        ah0 <= `rev64(start_short_hash,1*64) ^ `rev64(start_short_hash,5*64);
        al0 <= `rev64(start_short_hash,0) ^ `rev64(start_short_hash,4*64);
        bx0 <= {`h64(start_short_hash,3) ^ `h64(start_short_hash,7), `h64(start_short_hash,2) ^ `h64(start_short_hash,6)};
        idx1 <= ((`rev32(start_short_hash,96) ^ `rev32(start_short_hash,352)) & MMASK) >> 4;
        //cx <= my_memory[(({start_short_hash[103:96], start_short_hash[111:104], start_short_hash[119:112], start_short_hash[127:120]} ^ {start_short_hash[359:352], start_short_hash[367:360], start_short_hash[375:368], start_short_hash[383:376]}) & MMASK) >> 4];
        cx <= my_memory[((`rev32(start_short_hash,96) ^ `rev32(start_short_hash,352)) & MMASK) >> 4];
        counter <= 2;
        old <= 0;
        idx0 <= 0;
        shuffle_counter <= shuffle_counter + 1;
        end
      2:begin
        //$display("new cx=%H", cx);
        //$display("idx0 & 'h10=%H", (idx0 & 'h010) >> 4);
        // enc -> cxenc
        //$display("got cxenc=%H", cxenc);
        wr <= bx0 ^ cxenc;
        my_memory[idx1] <= bx0 ^ cxenc;
        $display("XXX %d [%d] %H => %H", block_counter, idx1, cx, (bx0 ^ cxenc)); 
        bx0 <= cxenc;
        //idx0 <= {cxenc[71:64],cxenc[79:72],cxenc[87:80],cxenc[95:88],cxenc[103:96],cxenc[111:104],cxenc[119:112],cxenc[127:120]};
        //idx1 <= cxenc[127:96];
        idx1 <= (`rev32(cxenc,96) & MMASK) >> 4;
        //idx1 <= ((cxenc[95:64]) & MMASK) >> 4;
        counter <= 3;
        shuffle_counter <= shuffle_counter + 1;
        end
        //$display("new idx0 0x%H, 0x%H", idx0, (idx0 & 'h010) >> 4);
      3:begin
        // 64 * 64 bit multipliction
        old <= my_memory[idx1];
        idx0 <= `rev64(cxenc,64);
        //calc mx <= idx0 * old[63:0];
        counter <= 4;
        shuffle_counter <= shuffle_counter + 1;
        end
      4:begin
        // TODO wait for 64bit x 64bit calculations, optimize this step !
        counter <= 5;
        shuffle_counter <= shuffle_counter + 1;
        end
      5:begin
        ma <= `rev64(old,64);
        //$display("mx 0x%H",mx);
        //idx0 <= 0; // no need to multiply
        ah0 <= ah0 + mx[127:64];
        al0 <= al0 + mx[63:0];
        wr <= {al0 + mx[63:0],ah0 + mx[127:64]};
        wr2 <= { `rev64_op($unsigned(ah0 + mx[127:64])), `rev64_op($unsigned(al0 + mx[63:0]))} ;
        my_memory[idx1] <= {`rev64_op((ah0 + mx[127:64])), `rev64_op((al0 + mx[63:0]))};
        $display("YYY %d [%d] %H => %H", block_counter, idx1, old, ({ `rev64_op((ah0 + mx[127:64])), `rev64_op((al0 + mx[63:0]))}));
        //idx2 <= (((`rev32(ah0,0) + mx[95:64]) ^ `rev32(old,96)) & MMASK) >> 4;
        counter <= 6;
        shuffle_counter <= shuffle_counter + 1;
        end
      6:begin
        idx1 <= ((ah0[31:0] ^ `rev32(old,96)) & MMASK) >> 4;
        ah0 <= ah0 ^ `rev64(old,64);
        al0 <= al0 ^ `rev64(old,0);
        cx <= my_memory[((ah0[31:0] ^ `rev32(old,96)) & MMASK) >> 4];
        counter <= 2;
        old <= 0;
        idx0 <= 0;
        shuffle_counter <= shuffle_counter + 1;
        block_counter <= block_counter + 1;
        end
    endcase
  end
  else if (shuffle_done_flag == 0 && start_shuffle_flag && block_counter == enc_rounds)
  begin
        shuffle_done_flag <= 1;
        //start_shuffle_flag <= 1;
        counter <= 0;
        $display("shuffle buffer ready");
        $display(shuffle_counter);
  end
  //
  // gen small
  //
  else if (shuffle_done_flag && small_buf_ready == 0)
  begin
    if (buf_read_start)
    begin
        small_buffer_counter <= small_buffer_counter + 1;
          mem0 <= my_memory[(small_buf_mem_offset>>4)+0];
          mem1 <= my_memory[(small_buf_mem_offset>>4)+1];
          mem2 <= my_memory[(small_buf_mem_offset>>4)+2];
          mem3 <= my_memory[(small_buf_mem_offset>>4)+3];
          mem4 <= my_memory[(small_buf_mem_offset>>4)+4];
          mem5 <= my_memory[(small_buf_mem_offset>>4)+5];
          mem6 <= my_memory[(small_buf_mem_offset>>4)+6];
          mem7 <= my_memory[(small_buf_mem_offset>>4)+7];
        buf_read_done <= 1;
        small_buffer_counter <= small_buffer_counter + 1;
    end
    else begin
        buf_read_done <= 0;
        small_buffer_counter <= small_buffer_counter + 1;
    end
  end
  else if (small_buf_ready && done == 0)
  begin
    //start_short_hash[1535:512] = newhash;
    $display("small buffer ready");
    $display(small_buffer_counter);
    done <= 1;
  end
end

endmodule
