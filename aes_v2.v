`timescale 1ns / 1ps

module aes_fn1(input [7:0] code1, input wire [31:0] src1, output reg [31:0] dst1,
input [7:0] code2, input wire [31:0] src2, output reg [31:0] dst2,
input [7:0] code3, input wire [31:0] src3, output reg [31:0] dst3,
input [7:0] code4, input wire [31:0] src4, output reg [31:0] dst4);

reg [31:0] t1 [255:0];

initial begin
 t1[0] = 'ha56363c6; t1[1] = 'h847c7cf8; t1[2] = 'h997777ee; t1[3] = 'h8d7b7bf6;
 t1[4] = 'hdf2f2ff; t1[5] = 'hbd6b6bd6; t1[6] = 'hb16f6fde; t1[7] = 'h54c5c591;
 t1[8] = 'h50303060; t1[9] = 'h3010102; t1[10] = 'ha96767ce; t1[11] = 'h7d2b2b56;
 t1[12] = 'h19fefee7; t1[13] = 'h62d7d7b5; t1[14] = 'he6abab4d; t1[15] = 'h9a7676ec;
 t1[16] = 'h45caca8f; t1[17] = 'h9d82821f; t1[18] = 'h40c9c989; t1[19] = 'h877d7dfa;
 t1[20] = 'h15fafaef; t1[21] = 'heb5959b2; t1[22] = 'hc947478e; t1[23] = 'hbf0f0fb;
 t1[24] = 'hecadad41; t1[25] = 'h67d4d4b3; t1[26] = 'hfda2a25f; t1[27] = 'heaafaf45;
 t1[28] = 'hbf9c9c23; t1[29] = 'hf7a4a453; t1[30] = 'h967272e4; t1[31] = 'h5bc0c09b;
 t1[32] = 'hc2b7b775; t1[33] = 'h1cfdfde1; t1[34] = 'hae93933d; t1[35] = 'h6a26264c;
 t1[36] = 'h5a36366c; t1[37] = 'h413f3f7e; t1[38] = 'h2f7f7f5; t1[39] = 'h4fcccc83;
 t1[40] = 'h5c343468; t1[41] = 'hf4a5a551; t1[42] = 'h34e5e5d1; t1[43] = 'h8f1f1f9;
 t1[44] = 'h937171e2; t1[45] = 'h73d8d8ab; t1[46] = 'h53313162; t1[47] = 'h3f15152a;
 t1[48] = 'hc040408; t1[49] = 'h52c7c795; t1[50] = 'h65232346; t1[51] = 'h5ec3c39d;
 t1[52] = 'h28181830; t1[53] = 'ha1969637; t1[54] = 'hf05050a; t1[55] = 'hb59a9a2f;
 t1[56] = 'h907070e; t1[57] = 'h36121224; t1[58] = 'h9b80801b; t1[59] = 'h3de2e2df;
 t1[60] = 'h26ebebcd; t1[61] = 'h6927274e; t1[62] = 'hcdb2b27f; t1[63] = 'h9f7575ea;
 t1[64] = 'h1b090912; t1[65] = 'h9e83831d; t1[66] = 'h742c2c58; t1[67] = 'h2e1a1a34;
 t1[68] = 'h2d1b1b36; t1[69] = 'hb26e6edc; t1[70] = 'hee5a5ab4; t1[71] = 'hfba0a05b;
 t1[72] = 'hf65252a4; t1[73] = 'h4d3b3b76; t1[74] = 'h61d6d6b7; t1[75] = 'hceb3b37d;
 t1[76] = 'h7b292952; t1[77] = 'h3ee3e3dd; t1[78] = 'h712f2f5e; t1[79] = 'h97848413;
 t1[80] = 'hf55353a6; t1[81] = 'h68d1d1b9; t1[82] = 'h0; t1[83] = 'h2cededc1;
 t1[84] = 'h60202040; t1[85] = 'h1ffcfce3; t1[86] = 'hc8b1b179; t1[87] = 'hed5b5bb6;
 t1[88] = 'hbe6a6ad4; t1[89] = 'h46cbcb8d; t1[90] = 'hd9bebe67; t1[91] = 'h4b393972;
 t1[92] = 'hde4a4a94; t1[93] = 'hd44c4c98; t1[94] = 'he85858b0; t1[95] = 'h4acfcf85;
 t1[96] = 'h6bd0d0bb; t1[97] = 'h2aefefc5; t1[98] = 'he5aaaa4f; t1[99] = 'h16fbfbed;
 t1[100] = 'hc5434386; t1[101] = 'hd74d4d9a; t1[102] = 'h55333366; t1[103] = 'h94858511;
 t1[104] = 'hcf45458a; t1[105] = 'h10f9f9e9; t1[106] = 'h6020204; t1[107] = 'h817f7ffe;
 t1[108] = 'hf05050a0; t1[109] = 'h443c3c78; t1[110] = 'hba9f9f25; t1[111] = 'he3a8a84b;
 t1[112] = 'hf35151a2; t1[113] = 'hfea3a35d; t1[114] = 'hc0404080; t1[115] = 'h8a8f8f05;
 t1[116] = 'had92923f; t1[117] = 'hbc9d9d21; t1[118] = 'h48383870; t1[119] = 'h4f5f5f1;
 t1[120] = 'hdfbcbc63; t1[121] = 'hc1b6b677; t1[122] = 'h75dadaaf; t1[123] = 'h63212142;
 t1[124] = 'h30101020; t1[125] = 'h1affffe5; t1[126] = 'hef3f3fd; t1[127] = 'h6dd2d2bf;
 t1[128] = 'h4ccdcd81; t1[129] = 'h140c0c18; t1[130] = 'h35131326; t1[131] = 'h2fececc3;
 t1[132] = 'he15f5fbe; t1[133] = 'ha2979735; t1[134] = 'hcc444488; t1[135] = 'h3917172e;
 t1[136] = 'h57c4c493; t1[137] = 'hf2a7a755; t1[138] = 'h827e7efc; t1[139] = 'h473d3d7a;
 t1[140] = 'hac6464c8; t1[141] = 'he75d5dba; t1[142] = 'h2b191932; t1[143] = 'h957373e6;
 t1[144] = 'ha06060c0; t1[145] = 'h98818119; t1[146] = 'hd14f4f9e; t1[147] = 'h7fdcdca3;
 t1[148] = 'h66222244; t1[149] = 'h7e2a2a54; t1[150] = 'hab90903b; t1[151] = 'h8388880b;
 t1[152] = 'hca46468c; t1[153] = 'h29eeeec7; t1[154] = 'hd3b8b86b; t1[155] = 'h3c141428;
 t1[156] = 'h79dedea7; t1[157] = 'he25e5ebc; t1[158] = 'h1d0b0b16; t1[159] = 'h76dbdbad;
 t1[160] = 'h3be0e0db; t1[161] = 'h56323264; t1[162] = 'h4e3a3a74; t1[163] = 'h1e0a0a14;
 t1[164] = 'hdb494992; t1[165] = 'ha06060c; t1[166] = 'h6c242448; t1[167] = 'he45c5cb8;
 t1[168] = 'h5dc2c29f; t1[169] = 'h6ed3d3bd; t1[170] = 'hefacac43; t1[171] = 'ha66262c4;
 t1[172] = 'ha8919139; t1[173] = 'ha4959531; t1[174] = 'h37e4e4d3; t1[175] = 'h8b7979f2;
 t1[176] = 'h32e7e7d5; t1[177] = 'h43c8c88b; t1[178] = 'h5937376e; t1[179] = 'hb76d6dda;
 t1[180] = 'h8c8d8d01; t1[181] = 'h64d5d5b1; t1[182] = 'hd24e4e9c; t1[183] = 'he0a9a949;
 t1[184] = 'hb46c6cd8; t1[185] = 'hfa5656ac; t1[186] = 'h7f4f4f3; t1[187] = 'h25eaeacf;
 t1[188] = 'haf6565ca; t1[189] = 'h8e7a7af4; t1[190] = 'he9aeae47; t1[191] = 'h18080810;
 t1[192] = 'hd5baba6f; t1[193] = 'h887878f0; t1[194] = 'h6f25254a; t1[195] = 'h722e2e5c;
 t1[196] = 'h241c1c38; t1[197] = 'hf1a6a657; t1[198] = 'hc7b4b473; t1[199] = 'h51c6c697;
 t1[200] = 'h23e8e8cb; t1[201] = 'h7cdddda1; t1[202] = 'h9c7474e8; t1[203] = 'h211f1f3e;
 t1[204] = 'hdd4b4b96; t1[205] = 'hdcbdbd61; t1[206] = 'h868b8b0d; t1[207] = 'h858a8a0f;
 t1[208] = 'h907070e0; t1[209] = 'h423e3e7c; t1[210] = 'hc4b5b571; t1[211] = 'haa6666cc;
 t1[212] = 'hd8484890; t1[213] = 'h5030306; t1[214] = 'h1f6f6f7; t1[215] = 'h120e0e1c;
 t1[216] = 'ha36161c2; t1[217] = 'h5f35356a; t1[218] = 'hf95757ae; t1[219] = 'hd0b9b969;
 t1[220] = 'h91868617; t1[221] = 'h58c1c199; t1[222] = 'h271d1d3a; t1[223] = 'hb99e9e27;
 t1[224] = 'h38e1e1d9; t1[225] = 'h13f8f8eb; t1[226] = 'hb398982b; t1[227] = 'h33111122;
 t1[228] = 'hbb6969d2; t1[229] = 'h70d9d9a9; t1[230] = 'h898e8e07; t1[231] = 'ha7949433;
 t1[232] = 'hb69b9b2d; t1[233] = 'h221e1e3c; t1[234] = 'h92878715; t1[235] = 'h20e9e9c9;
 t1[236] = 'h49cece87; t1[237] = 'hff5555aa; t1[238] = 'h78282850; t1[239] = 'h7adfdfa5;
 t1[240] = 'h8f8c8c03; t1[241] = 'hf8a1a159; t1[242] = 'h80898909; t1[243] = 'h170d0d1a;
 t1[244] = 'hdabfbf65; t1[245] = 'h31e6e6d7; t1[246] = 'hc6424284; t1[247] = 'hb86868d0;
 t1[248] = 'hc3414182; t1[249] = 'hb0999929; t1[250] = 'h772d2d5a; t1[251] = 'h110f0f1e;
 t1[252] = 'hcbb0b07b; t1[253] = 'hfc5454a8; t1[254] = 'hd6bbbb6d; t1[255] = 'h3a16162c;
end

always @(code1 or src1)
begin
  dst1 <= src1 ^ t1[code1];
end

always @(code2 or src2)
begin
  dst2 <= src2 ^ t1[code2];
end

always @(code3 or src3)
begin
  dst3 <= src3 ^ t1[code3];
end

always @(code4 or src4)
begin
  dst4 <= src4 ^ t1[code4];
end

endmodule

module aes_fn2(input [7:0] code1, input wire [31:0] src1, output reg [31:0] dst1,
input [7:0] code2, input wire [31:0] src2, output reg [31:0] dst2,
input [7:0] code3, input wire [31:0] src3, output reg [31:0] dst3,
input [7:0] code4, input wire [31:0] src4, output reg [31:0] dst4);

reg [31:0] t2 [255:0];

initial begin
t2[0] = 'h6363c6a5; t2[1] = 'h7c7cf884; t2[2] = 'h7777ee99; t2[3] = 'h7b7bf68d;
t2[4] = 'hf2f2ff0d; t2[5] = 'h6b6bd6bd; t2[6] = 'h6f6fdeb1; t2[7] = 'hc5c59154;
t2[8] = 'h30306050; t2[9] = 'h1010203; t2[10] = 'h6767cea9; t2[11] = 'h2b2b567d;
t2[12] = 'hfefee719; t2[13] = 'hd7d7b562; t2[14] = 'habab4de6; t2[15] = 'h7676ec9a;
t2[16] = 'hcaca8f45; t2[17] = 'h82821f9d; t2[18] = 'hc9c98940; t2[19] = 'h7d7dfa87;
t2[20] = 'hfafaef15; t2[21] = 'h5959b2eb; t2[22] = 'h47478ec9; t2[23] = 'hf0f0fb0b;
t2[24] = 'hadad41ec; t2[25] = 'hd4d4b367; t2[26] = 'ha2a25ffd; t2[27] = 'hafaf45ea;
t2[28] = 'h9c9c23bf; t2[29] = 'ha4a453f7; t2[30] = 'h7272e496; t2[31] = 'hc0c09b5b;
t2[32] = 'hb7b775c2; t2[33] = 'hfdfde11c; t2[34] = 'h93933dae; t2[35] = 'h26264c6a;
t2[36] = 'h36366c5a; t2[37] = 'h3f3f7e41; t2[38] = 'hf7f7f502; t2[39] = 'hcccc834f;
t2[40] = 'h3434685c; t2[41] = 'ha5a551f4; t2[42] = 'he5e5d134; t2[43] = 'hf1f1f908;
t2[44] = 'h7171e293; t2[45] = 'hd8d8ab73; t2[46] = 'h31316253; t2[47] = 'h15152a3f;
t2[48] = 'h404080c; t2[49] = 'hc7c79552; t2[50] = 'h23234665; t2[51] = 'hc3c39d5e;
t2[52] = 'h18183028; t2[53] = 'h969637a1; t2[54] = 'h5050a0f; t2[55] = 'h9a9a2fb5;
t2[56] = 'h7070e09; t2[57] = 'h12122436; t2[58] = 'h80801b9b; t2[59] = 'he2e2df3d;
t2[60] = 'hebebcd26; t2[61] = 'h27274e69; t2[62] = 'hb2b27fcd; t2[63] = 'h7575ea9f;
t2[64] = 'h909121b; t2[65] = 'h83831d9e; t2[66] = 'h2c2c5874; t2[67] = 'h1a1a342e;
t2[68] = 'h1b1b362d; t2[69] = 'h6e6edcb2; t2[70] = 'h5a5ab4ee; t2[71] = 'ha0a05bfb;
t2[72] = 'h5252a4f6; t2[73] = 'h3b3b764d; t2[74] = 'hd6d6b761; t2[75] = 'hb3b37dce;
t2[76] = 'h2929527b; t2[77] = 'he3e3dd3e; t2[78] = 'h2f2f5e71; t2[79] = 'h84841397;
t2[80] = 'h5353a6f5; t2[81] = 'hd1d1b968; t2[82] = 'h0; t2[83] = 'hededc12c;
t2[84] = 'h20204060; t2[85] = 'hfcfce31f; t2[86] = 'hb1b179c8; t2[87] = 'h5b5bb6ed;
t2[88] = 'h6a6ad4be; t2[89] = 'hcbcb8d46; t2[90] = 'hbebe67d9; t2[91] = 'h3939724b;
t2[92] = 'h4a4a94de; t2[93] = 'h4c4c98d4; t2[94] = 'h5858b0e8; t2[95] = 'hcfcf854a;
t2[96] = 'hd0d0bb6b; t2[97] = 'hefefc52a; t2[98] = 'haaaa4fe5; t2[99] = 'hfbfbed16;
t2[100] = 'h434386c5; t2[101] = 'h4d4d9ad7; t2[102] = 'h33336655; t2[103] = 'h85851194;
t2[104] = 'h45458acf; t2[105] = 'hf9f9e910; t2[106] = 'h2020406; t2[107] = 'h7f7ffe81;
t2[108] = 'h5050a0f0; t2[109] = 'h3c3c7844; t2[110] = 'h9f9f25ba; t2[111] = 'ha8a84be3;
t2[112] = 'h5151a2f3; t2[113] = 'ha3a35dfe; t2[114] = 'h404080c0; t2[115] = 'h8f8f058a;
t2[116] = 'h92923fad; t2[117] = 'h9d9d21bc; t2[118] = 'h38387048; t2[119] = 'hf5f5f104;
t2[120] = 'hbcbc63df; t2[121] = 'hb6b677c1; t2[122] = 'hdadaaf75; t2[123] = 'h21214263;
t2[124] = 'h10102030; t2[125] = 'hffffe51a; t2[126] = 'hf3f3fd0e; t2[127] = 'hd2d2bf6d;
t2[128] = 'hcdcd814c; t2[129] = 'hc0c1814; t2[130] = 'h13132635; t2[131] = 'hececc32f;
t2[132] = 'h5f5fbee1; t2[133] = 'h979735a2; t2[134] = 'h444488cc; t2[135] = 'h17172e39;
t2[136] = 'hc4c49357; t2[137] = 'ha7a755f2; t2[138] = 'h7e7efc82; t2[139] = 'h3d3d7a47;
t2[140] = 'h6464c8ac; t2[141] = 'h5d5dbae7; t2[142] = 'h1919322b; t2[143] = 'h7373e695;
t2[144] = 'h6060c0a0; t2[145] = 'h81811998; t2[146] = 'h4f4f9ed1; t2[147] = 'hdcdca37f;
t2[148] = 'h22224466; t2[149] = 'h2a2a547e; t2[150] = 'h90903bab; t2[151] = 'h88880b83;
t2[152] = 'h46468cca; t2[153] = 'heeeec729; t2[154] = 'hb8b86bd3; t2[155] = 'h1414283c;
t2[156] = 'hdedea779; t2[157] = 'h5e5ebce2; t2[158] = 'hb0b161d; t2[159] = 'hdbdbad76;
t2[160] = 'he0e0db3b; t2[161] = 'h32326456; t2[162] = 'h3a3a744e; t2[163] = 'ha0a141e;
t2[164] = 'h494992db; t2[165] = 'h6060c0a; t2[166] = 'h2424486c; t2[167] = 'h5c5cb8e4;
t2[168] = 'hc2c29f5d; t2[169] = 'hd3d3bd6e; t2[170] = 'hacac43ef; t2[171] = 'h6262c4a6;
t2[172] = 'h919139a8; t2[173] = 'h959531a4; t2[174] = 'he4e4d337; t2[175] = 'h7979f28b;
t2[176] = 'he7e7d532; t2[177] = 'hc8c88b43; t2[178] = 'h37376e59; t2[179] = 'h6d6ddab7;
t2[180] = 'h8d8d018c; t2[181] = 'hd5d5b164; t2[182] = 'h4e4e9cd2; t2[183] = 'ha9a949e0;
t2[184] = 'h6c6cd8b4; t2[185] = 'h5656acfa; t2[186] = 'hf4f4f307; t2[187] = 'heaeacf25;
t2[188] = 'h6565caaf; t2[189] = 'h7a7af48e; t2[190] = 'haeae47e9; t2[191] = 'h8081018;
t2[192] = 'hbaba6fd5; t2[193] = 'h7878f088; t2[194] = 'h25254a6f; t2[195] = 'h2e2e5c72;
t2[196] = 'h1c1c3824; t2[197] = 'ha6a657f1; t2[198] = 'hb4b473c7; t2[199] = 'hc6c69751;
t2[200] = 'he8e8cb23; t2[201] = 'hdddda17c; t2[202] = 'h7474e89c; t2[203] = 'h1f1f3e21;
t2[204] = 'h4b4b96dd; t2[205] = 'hbdbd61dc; t2[206] = 'h8b8b0d86; t2[207] = 'h8a8a0f85;
t2[208] = 'h7070e090; t2[209] = 'h3e3e7c42; t2[210] = 'hb5b571c4; t2[211] = 'h6666ccaa;
t2[212] = 'h484890d8; t2[213] = 'h3030605; t2[214] = 'hf6f6f701; t2[215] = 'he0e1c12;
t2[216] = 'h6161c2a3; t2[217] = 'h35356a5f; t2[218] = 'h5757aef9; t2[219] = 'hb9b969d0;
t2[220] = 'h86861791; t2[221] = 'hc1c19958; t2[222] = 'h1d1d3a27; t2[223] = 'h9e9e27b9;
t2[224] = 'he1e1d938; t2[225] = 'hf8f8eb13; t2[226] = 'h98982bb3; t2[227] = 'h11112233;
t2[228] = 'h6969d2bb; t2[229] = 'hd9d9a970; t2[230] = 'h8e8e0789; t2[231] = 'h949433a7;
t2[232] = 'h9b9b2db6; t2[233] = 'h1e1e3c22; t2[234] = 'h87871592; t2[235] = 'he9e9c920;
t2[236] = 'hcece8749; t2[237] = 'h5555aaff; t2[238] = 'h28285078; t2[239] = 'hdfdfa57a;
t2[240] = 'h8c8c038f; t2[241] = 'ha1a159f8; t2[242] = 'h89890980; t2[243] = 'hd0d1a17;
t2[244] = 'hbfbf65da; t2[245] = 'he6e6d731; t2[246] = 'h424284c6; t2[247] = 'h6868d0b8;
t2[248] = 'h414182c3; t2[249] = 'h999929b0; t2[250] = 'h2d2d5a77; t2[251] = 'hf0f1e11;
t2[252] = 'hb0b07bcb; t2[253] = 'h5454a8fc; t2[254] = 'hbbbb6dd6; t2[255] = 'h16162c3a;
end

always @(code1 or src1)
begin
  dst1 <= src1 ^ t2[code1];
end

always @(code2 or src2)
begin
  dst2 <= src2 ^ t2[code2];
end

always @(code3 or src3)
begin
  dst3 <= src3 ^ t2[code3];
end

always @(code4 or src4)
begin
  dst4 <= src4 ^ t2[code4];
end

endmodule


module aes_fn3(input [7:0] code1, input wire [31:0] src1, output reg [31:0] dst1,
input [7:0] code2, input wire [31:0] src2, output reg [31:0] dst2,
input [7:0] code3, input wire [31:0] src3, output reg [31:0] dst3,
input [7:0] code4, input wire [31:0] src4, output reg [31:0] dst4);

reg [31:0] t3 [255:0];

initial begin
t3[0] = 'h63c6a563; t3[1] = 'h7cf8847c; t3[2] = 'h77ee9977; t3[3] = 'h7bf68d7b;
t3[4] = 'hf2ff0df2; t3[5] = 'h6bd6bd6b; t3[6] = 'h6fdeb16f; t3[7] = 'hc59154c5;
t3[8] = 'h30605030; t3[9] = 'h1020301; t3[10] = 'h67cea967; t3[11] = 'h2b567d2b;
t3[12] = 'hfee719fe; t3[13] = 'hd7b562d7; t3[14] = 'hab4de6ab; t3[15] = 'h76ec9a76;
t3[16] = 'hca8f45ca; t3[17] = 'h821f9d82; t3[18] = 'hc98940c9; t3[19] = 'h7dfa877d;
t3[20] = 'hfaef15fa; t3[21] = 'h59b2eb59; t3[22] = 'h478ec947; t3[23] = 'hf0fb0bf0;
t3[24] = 'had41ecad; t3[25] = 'hd4b367d4; t3[26] = 'ha25ffda2; t3[27] = 'haf45eaaf;
t3[28] = 'h9c23bf9c; t3[29] = 'ha453f7a4; t3[30] = 'h72e49672; t3[31] = 'hc09b5bc0;
t3[32] = 'hb775c2b7; t3[33] = 'hfde11cfd; t3[34] = 'h933dae93; t3[35] = 'h264c6a26;
t3[36] = 'h366c5a36; t3[37] = 'h3f7e413f; t3[38] = 'hf7f502f7; t3[39] = 'hcc834fcc;
t3[40] = 'h34685c34; t3[41] = 'ha551f4a5; t3[42] = 'he5d134e5; t3[43] = 'hf1f908f1;
t3[44] = 'h71e29371; t3[45] = 'hd8ab73d8; t3[46] = 'h31625331; t3[47] = 'h152a3f15;
t3[48] = 'h4080c04; t3[49] = 'hc79552c7; t3[50] = 'h23466523; t3[51] = 'hc39d5ec3;
t3[52] = 'h18302818; t3[53] = 'h9637a196; t3[54] = 'h50a0f05; t3[55] = 'h9a2fb59a;
t3[56] = 'h70e0907; t3[57] = 'h12243612; t3[58] = 'h801b9b80; t3[59] = 'he2df3de2;
t3[60] = 'hebcd26eb; t3[61] = 'h274e6927; t3[62] = 'hb27fcdb2; t3[63] = 'h75ea9f75;
t3[64] = 'h9121b09; t3[65] = 'h831d9e83; t3[66] = 'h2c58742c; t3[67] = 'h1a342e1a;
t3[68] = 'h1b362d1b; t3[69] = 'h6edcb26e; t3[70] = 'h5ab4ee5a; t3[71] = 'ha05bfba0;
t3[72] = 'h52a4f652; t3[73] = 'h3b764d3b; t3[74] = 'hd6b761d6; t3[75] = 'hb37dceb3;
t3[76] = 'h29527b29; t3[77] = 'he3dd3ee3; t3[78] = 'h2f5e712f; t3[79] = 'h84139784;
t3[80] = 'h53a6f553; t3[81] = 'hd1b968d1; t3[82] = 'h0; t3[83] = 'hedc12ced;
t3[84] = 'h20406020; t3[85] = 'hfce31ffc; t3[86] = 'hb179c8b1; t3[87] = 'h5bb6ed5b;
t3[88] = 'h6ad4be6a; t3[89] = 'hcb8d46cb; t3[90] = 'hbe67d9be; t3[91] = 'h39724b39;
t3[92] = 'h4a94de4a; t3[93] = 'h4c98d44c; t3[94] = 'h58b0e858; t3[95] = 'hcf854acf;
t3[96] = 'hd0bb6bd0; t3[97] = 'hefc52aef; t3[98] = 'haa4fe5aa; t3[99] = 'hfbed16fb;
t3[100] = 'h4386c543; t3[101] = 'h4d9ad74d; t3[102] = 'h33665533; t3[103] = 'h85119485;
t3[104] = 'h458acf45; t3[105] = 'hf9e910f9; t3[106] = 'h2040602; t3[107] = 'h7ffe817f;
t3[108] = 'h50a0f050; t3[109] = 'h3c78443c; t3[110] = 'h9f25ba9f; t3[111] = 'ha84be3a8;
t3[112] = 'h51a2f351; t3[113] = 'ha35dfea3; t3[114] = 'h4080c040; t3[115] = 'h8f058a8f;
t3[116] = 'h923fad92; t3[117] = 'h9d21bc9d; t3[118] = 'h38704838; t3[119] = 'hf5f104f5;
t3[120] = 'hbc63dfbc; t3[121] = 'hb677c1b6; t3[122] = 'hdaaf75da; t3[123] = 'h21426321;
t3[124] = 'h10203010; t3[125] = 'hffe51aff; t3[126] = 'hf3fd0ef3; t3[127] = 'hd2bf6dd2;
t3[128] = 'hcd814ccd; t3[129] = 'hc18140c; t3[130] = 'h13263513; t3[131] = 'hecc32fec;
t3[132] = 'h5fbee15f; t3[133] = 'h9735a297; t3[134] = 'h4488cc44; t3[135] = 'h172e3917;
t3[136] = 'hc49357c4; t3[137] = 'ha755f2a7; t3[138] = 'h7efc827e; t3[139] = 'h3d7a473d;
t3[140] = 'h64c8ac64; t3[141] = 'h5dbae75d; t3[142] = 'h19322b19; t3[143] = 'h73e69573;
t3[144] = 'h60c0a060; t3[145] = 'h81199881; t3[146] = 'h4f9ed14f; t3[147] = 'hdca37fdc;
t3[148] = 'h22446622; t3[149] = 'h2a547e2a; t3[150] = 'h903bab90; t3[151] = 'h880b8388;
t3[152] = 'h468cca46; t3[153] = 'heec729ee; t3[154] = 'hb86bd3b8; t3[155] = 'h14283c14;
t3[156] = 'hdea779de; t3[157] = 'h5ebce25e; t3[158] = 'hb161d0b; t3[159] = 'hdbad76db;
t3[160] = 'he0db3be0; t3[161] = 'h32645632; t3[162] = 'h3a744e3a; t3[163] = 'ha141e0a;
t3[164] = 'h4992db49; t3[165] = 'h60c0a06; t3[166] = 'h24486c24; t3[167] = 'h5cb8e45c;
t3[168] = 'hc29f5dc2; t3[169] = 'hd3bd6ed3; t3[170] = 'hac43efac; t3[171] = 'h62c4a662;
t3[172] = 'h9139a891; t3[173] = 'h9531a495; t3[174] = 'he4d337e4; t3[175] = 'h79f28b79;
t3[176] = 'he7d532e7; t3[177] = 'hc88b43c8; t3[178] = 'h376e5937; t3[179] = 'h6ddab76d;
t3[180] = 'h8d018c8d; t3[181] = 'hd5b164d5; t3[182] = 'h4e9cd24e; t3[183] = 'ha949e0a9;
t3[184] = 'h6cd8b46c; t3[185] = 'h56acfa56; t3[186] = 'hf4f307f4; t3[187] = 'heacf25ea;
t3[188] = 'h65caaf65; t3[189] = 'h7af48e7a; t3[190] = 'hae47e9ae; t3[191] = 'h8101808;
t3[192] = 'hba6fd5ba; t3[193] = 'h78f08878; t3[194] = 'h254a6f25; t3[195] = 'h2e5c722e;
t3[196] = 'h1c38241c; t3[197] = 'ha657f1a6; t3[198] = 'hb473c7b4; t3[199] = 'hc69751c6;
t3[200] = 'he8cb23e8; t3[201] = 'hdda17cdd; t3[202] = 'h74e89c74; t3[203] = 'h1f3e211f;
t3[204] = 'h4b96dd4b; t3[205] = 'hbd61dcbd; t3[206] = 'h8b0d868b; t3[207] = 'h8a0f858a;
t3[208] = 'h70e09070; t3[209] = 'h3e7c423e; t3[210] = 'hb571c4b5; t3[211] = 'h66ccaa66;
t3[212] = 'h4890d848; t3[213] = 'h3060503; t3[214] = 'hf6f701f6; t3[215] = 'he1c120e;
t3[216] = 'h61c2a361; t3[217] = 'h356a5f35; t3[218] = 'h57aef957; t3[219] = 'hb969d0b9;
t3[220] = 'h86179186; t3[221] = 'hc19958c1; t3[222] = 'h1d3a271d; t3[223] = 'h9e27b99e;
t3[224] = 'he1d938e1; t3[225] = 'hf8eb13f8; t3[226] = 'h982bb398; t3[227] = 'h11223311;
t3[228] = 'h69d2bb69; t3[229] = 'hd9a970d9; t3[230] = 'h8e07898e; t3[231] = 'h9433a794;
t3[232] = 'h9b2db69b; t3[233] = 'h1e3c221e; t3[234] = 'h87159287; t3[235] = 'he9c920e9;
t3[236] = 'hce8749ce; t3[237] = 'h55aaff55; t3[238] = 'h28507828; t3[239] = 'hdfa57adf;
t3[240] = 'h8c038f8c; t3[241] = 'ha159f8a1; t3[242] = 'h89098089; t3[243] = 'hd1a170d;
t3[244] = 'hbf65dabf; t3[245] = 'he6d731e6; t3[246] = 'h4284c642; t3[247] = 'h68d0b868;
t3[248] = 'h4182c341; t3[249] = 'h9929b099; t3[250] = 'h2d5a772d; t3[251] = 'hf1e110f;
t3[252] = 'hb07bcbb0; t3[253] = 'h54a8fc54; t3[254] = 'hbb6dd6bb; t3[255] = 'h162c3a16;
end


always @(code1 or src1)
begin
  dst1 <= src1 ^ t3[code1];
end

always @(code2 or src2)
begin
  dst2 <= src2 ^ t3[code2];
end

always @(code3 or src3)
begin
  dst3 <= src3 ^ t3[code3];
end

always @(code4 or src4)
begin
  dst4 <= src4 ^ t3[code4];
end

endmodule

module aes_fn4(input [7:0] code1, input wire [31:0] src1, output reg [31:0] dst1,
input [7:0] code2, input wire [31:0] src2, output reg [31:0] dst2,
input [7:0] code3, input wire [31:0] src3, output reg [31:0] dst3,
input [7:0] code4, input wire [31:0] src4, output reg [31:0] dst4);

reg [31:0] t4 [255:0];

initial begin
t4[0] = 'hc6a56363; t4[1] = 'hf8847c7c; t4[2] = 'hee997777; t4[3] = 'hf68d7b7b;
t4[4] = 'hff0df2f2; t4[5] = 'hd6bd6b6b; t4[6] = 'hdeb16f6f; t4[7] = 'h9154c5c5;
t4[8] = 'h60503030; t4[9] = 'h2030101; t4[10] = 'hcea96767; t4[11] = 'h567d2b2b;
t4[12] = 'he719fefe; t4[13] = 'hb562d7d7; t4[14] = 'h4de6abab; t4[15] = 'hec9a7676;
t4[16] = 'h8f45caca; t4[17] = 'h1f9d8282; t4[18] = 'h8940c9c9; t4[19] = 'hfa877d7d;
t4[20] = 'hef15fafa; t4[21] = 'hb2eb5959; t4[22] = 'h8ec94747; t4[23] = 'hfb0bf0f0;
t4[24] = 'h41ecadad; t4[25] = 'hb367d4d4; t4[26] = 'h5ffda2a2; t4[27] = 'h45eaafaf;
t4[28] = 'h23bf9c9c; t4[29] = 'h53f7a4a4; t4[30] = 'he4967272; t4[31] = 'h9b5bc0c0;
t4[32] = 'h75c2b7b7; t4[33] = 'he11cfdfd; t4[34] = 'h3dae9393; t4[35] = 'h4c6a2626;
t4[36] = 'h6c5a3636; t4[37] = 'h7e413f3f; t4[38] = 'hf502f7f7; t4[39] = 'h834fcccc;
t4[40] = 'h685c3434; t4[41] = 'h51f4a5a5; t4[42] = 'hd134e5e5; t4[43] = 'hf908f1f1;
t4[44] = 'he2937171; t4[45] = 'hab73d8d8; t4[46] = 'h62533131; t4[47] = 'h2a3f1515;
t4[48] = 'h80c0404; t4[49] = 'h9552c7c7; t4[50] = 'h46652323; t4[51] = 'h9d5ec3c3;
t4[52] = 'h30281818; t4[53] = 'h37a19696; t4[54] = 'ha0f0505; t4[55] = 'h2fb59a9a;
t4[56] = 'he090707; t4[57] = 'h24361212; t4[58] = 'h1b9b8080; t4[59] = 'hdf3de2e2;
t4[60] = 'hcd26ebeb; t4[61] = 'h4e692727; t4[62] = 'h7fcdb2b2; t4[63] = 'hea9f7575;
t4[64] = 'h121b0909; t4[65] = 'h1d9e8383; t4[66] = 'h58742c2c; t4[67] = 'h342e1a1a;
t4[68] = 'h362d1b1b; t4[69] = 'hdcb26e6e; t4[70] = 'hb4ee5a5a; t4[71] = 'h5bfba0a0;
t4[72] = 'ha4f65252; t4[73] = 'h764d3b3b; t4[74] = 'hb761d6d6; t4[75] = 'h7dceb3b3;
t4[76] = 'h527b2929; t4[77] = 'hdd3ee3e3; t4[78] = 'h5e712f2f; t4[79] = 'h13978484;
t4[80] = 'ha6f55353; t4[81] = 'hb968d1d1; t4[82] = 'h0; t4[83] = 'hc12ceded;
t4[84] = 'h40602020; t4[85] = 'he31ffcfc; t4[86] = 'h79c8b1b1; t4[87] = 'hb6ed5b5b;
t4[88] = 'hd4be6a6a; t4[89] = 'h8d46cbcb; t4[90] = 'h67d9bebe; t4[91] = 'h724b3939;
t4[92] = 'h94de4a4a; t4[93] = 'h98d44c4c; t4[94] = 'hb0e85858; t4[95] = 'h854acfcf;
t4[96] = 'hbb6bd0d0; t4[97] = 'hc52aefef; t4[98] = 'h4fe5aaaa; t4[99] = 'hed16fbfb;
t4[100] = 'h86c54343; t4[101] = 'h9ad74d4d; t4[102] = 'h66553333; t4[103] = 'h11948585;
t4[104] = 'h8acf4545; t4[105] = 'he910f9f9; t4[106] = 'h4060202; t4[107] = 'hfe817f7f;
t4[108] = 'ha0f05050; t4[109] = 'h78443c3c; t4[110] = 'h25ba9f9f; t4[111] = 'h4be3a8a8;
t4[112] = 'ha2f35151; t4[113] = 'h5dfea3a3; t4[114] = 'h80c04040; t4[115] = 'h58a8f8f;
t4[116] = 'h3fad9292; t4[117] = 'h21bc9d9d; t4[118] = 'h70483838; t4[119] = 'hf104f5f5;
t4[120] = 'h63dfbcbc; t4[121] = 'h77c1b6b6; t4[122] = 'haf75dada; t4[123] = 'h42632121;
t4[124] = 'h20301010; t4[125] = 'he51affff; t4[126] = 'hfd0ef3f3; t4[127] = 'hbf6dd2d2;
t4[128] = 'h814ccdcd; t4[129] = 'h18140c0c; t4[130] = 'h26351313; t4[131] = 'hc32fecec;
t4[132] = 'hbee15f5f; t4[133] = 'h35a29797; t4[134] = 'h88cc4444; t4[135] = 'h2e391717;
t4[136] = 'h9357c4c4; t4[137] = 'h55f2a7a7; t4[138] = 'hfc827e7e; t4[139] = 'h7a473d3d;
t4[140] = 'hc8ac6464; t4[141] = 'hbae75d5d; t4[142] = 'h322b1919; t4[143] = 'he6957373;
t4[144] = 'hc0a06060; t4[145] = 'h19988181; t4[146] = 'h9ed14f4f; t4[147] = 'ha37fdcdc;
t4[148] = 'h44662222; t4[149] = 'h547e2a2a; t4[150] = 'h3bab9090; t4[151] = 'hb838888;
t4[152] = 'h8cca4646; t4[153] = 'hc729eeee; t4[154] = 'h6bd3b8b8; t4[155] = 'h283c1414;
t4[156] = 'ha779dede; t4[157] = 'hbce25e5e; t4[158] = 'h161d0b0b; t4[159] = 'had76dbdb;
t4[160] = 'hdb3be0e0; t4[161] = 'h64563232; t4[162] = 'h744e3a3a; t4[163] = 'h141e0a0a;
t4[164] = 'h92db4949; t4[165] = 'hc0a0606; t4[166] = 'h486c2424; t4[167] = 'hb8e45c5c;
t4[168] = 'h9f5dc2c2; t4[169] = 'hbd6ed3d3; t4[170] = 'h43efacac; t4[171] = 'hc4a66262;
t4[172] = 'h39a89191; t4[173] = 'h31a49595; t4[174] = 'hd337e4e4; t4[175] = 'hf28b7979;
t4[176] = 'hd532e7e7; t4[177] = 'h8b43c8c8; t4[178] = 'h6e593737; t4[179] = 'hdab76d6d;
t4[180] = 'h18c8d8d; t4[181] = 'hb164d5d5; t4[182] = 'h9cd24e4e; t4[183] = 'h49e0a9a9;
t4[184] = 'hd8b46c6c; t4[185] = 'hacfa5656; t4[186] = 'hf307f4f4; t4[187] = 'hcf25eaea;
t4[188] = 'hcaaf6565; t4[189] = 'hf48e7a7a; t4[190] = 'h47e9aeae; t4[191] = 'h10180808;
t4[192] = 'h6fd5baba; t4[193] = 'hf0887878; t4[194] = 'h4a6f2525; t4[195] = 'h5c722e2e;
t4[196] = 'h38241c1c; t4[197] = 'h57f1a6a6; t4[198] = 'h73c7b4b4; t4[199] = 'h9751c6c6;
t4[200] = 'hcb23e8e8; t4[201] = 'ha17cdddd; t4[202] = 'he89c7474; t4[203] = 'h3e211f1f;
t4[204] = 'h96dd4b4b; t4[205] = 'h61dcbdbd; t4[206] = 'hd868b8b; t4[207] = 'hf858a8a;
t4[208] = 'he0907070; t4[209] = 'h7c423e3e; t4[210] = 'h71c4b5b5; t4[211] = 'hccaa6666;
t4[212] = 'h90d84848; t4[213] = 'h6050303; t4[214] = 'hf701f6f6; t4[215] = 'h1c120e0e;
t4[216] = 'hc2a36161; t4[217] = 'h6a5f3535; t4[218] = 'haef95757; t4[219] = 'h69d0b9b9;
t4[220] = 'h17918686; t4[221] = 'h9958c1c1; t4[222] = 'h3a271d1d; t4[223] = 'h27b99e9e;
t4[224] = 'hd938e1e1; t4[225] = 'heb13f8f8; t4[226] = 'h2bb39898; t4[227] = 'h22331111;
t4[228] = 'hd2bb6969; t4[229] = 'ha970d9d9; t4[230] = 'h7898e8e; t4[231] = 'h33a79494;
t4[232] = 'h2db69b9b; t4[233] = 'h3c221e1e; t4[234] = 'h15928787; t4[235] = 'hc920e9e9;
t4[236] = 'h8749cece; t4[237] = 'haaff5555; t4[238] = 'h50782828; t4[239] = 'ha57adfdf;
t4[240] = 'h38f8c8c; t4[241] = 'h59f8a1a1; t4[242] = 'h9808989; t4[243] = 'h1a170d0d;
t4[244] = 'h65dabfbf; t4[245] = 'hd731e6e6; t4[246] = 'h84c64242; t4[247] = 'hd0b86868;
t4[248] = 'h82c34141; t4[249] = 'h29b09999; t4[250] = 'h5a772d2d; t4[251] = 'h1e110f0f;
t4[252] = 'h7bcbb0b0; t4[253] = 'ha8fc5454; t4[254] = 'h6dd6bbbb; t4[255] = 'h2c3a1616;
end


always @(code1 or src1)
begin
  dst1 <= src1 ^ t4[code1];
end

always @(code2 or src2)
begin
  dst2 <= src2 ^ t4[code2];
end

always @(code3 or src3)
begin
  dst3 <= src3 ^ t4[code3];
end

always @(code4 or src4)
begin
  dst4 <= src4 ^ t4[code4];
end

endmodule


module encstepnew(input clk, input [127:0] cxx, input [127:0] key, output [127:0] enc);

wire [31:0] dest_0_0;
wire [31:0] dest_0_1;
wire [31:0] dest_0_2;
wire [31:0] dest_0_3;

wire [31:0] dest_1_0;
wire [31:0] dest_1_1;
wire [31:0] dest_1_2;
wire [31:0] dest_1_3;

wire [31:0] dest_2_0;
wire [31:0] dest_2_1;
wire [31:0] dest_2_2;
wire [31:0] dest_2_3;

wire [31:0] dest_3_0;
wire [31:0] dest_3_1;
wire [31:0] dest_3_2;
wire [31:0] dest_3_3;

aes_fn1 aes_fn1_0(.code1(cxx[31:24]),  .src1({key[7:0],   key[15:8],   key[23:16],  key[31:24]}),  .dst1(dest_0_0),
                  .code2(cxx[63:56]),   .src2({key[39:32], key[47:40],  key[55:48],  key[63:56]}),  .dst2(dest_0_1),
                  .code3(cxx[95:88]),   .src3({key[71:64], key[79:72],  key[87:80],  key[95:88]}),  .dst3(dest_0_2),
                  .code4(cxx[127:120]), .src4({key[103:96],key[111:104],key[119:112],key[127:120]}),.dst4(dest_0_3));

aes_fn2 aes_fn2_0(.code1(cxx[119:112]), .src1(dest_0_0),  .dst1(dest_1_0),
                  .code2(cxx[23:16]), .src2(dest_0_1), .dst2(dest_1_1),
                  .code3(cxx[55:48]), .src3(dest_0_2), .dst3(dest_1_2),
                  .code4(cxx[87:80]), .src4(dest_0_3), .dst4(dest_1_3));

aes_fn3 aes_fn3_0(.code1(cxx[79:72]), .src1(dest_1_0), .dst1(dest_2_0),
                  .code2(cxx[111:104]), .src2(dest_1_1), .dst2(dest_2_1),
                  .code3(cxx[15:8]), .src3(dest_1_2), .dst3(dest_2_2),
                  .code4(cxx[47:40]), .src4(dest_1_3), .dst4(dest_2_3));

aes_fn4 aes_fn4_0(.code1(cxx[39:32]), .src1(dest_2_0), .dst1(dest_3_0),
                  .code2(cxx[71:64]), .src2(dest_2_1), .dst2(dest_3_1),
                  .code3(cxx[103:96]), .src3(dest_2_2), .dst3(dest_3_2),
                  .code4(cxx[7:0]), .src4(dest_2_3), .dst4(dest_3_3));

assign enc = {dest_3_3[7:0], dest_3_3[15:8], dest_3_3[23:16], dest_3_3[31:24], 
              dest_3_2[7:0], dest_3_2[15:8], dest_3_2[23:16], dest_3_2[31:24], 
              dest_3_1[7:0], dest_3_1[15:8], dest_3_1[23:16], dest_3_1[31:24], 
              dest_3_0[7:0], dest_3_0[15:8], dest_3_0[23:16], dest_3_0[31:24]};

endmodule
