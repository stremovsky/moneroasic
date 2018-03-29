# moneroasic
Cryptonight Monero Verilog code for ASIC

# Description
This is a ending point of the project that I was leading - a custom monero ASIC.
After drafting the ASIC Verilog code, it turned out that the comunity decided to
change the underline code to block any attempt to create ASIC chips.

I decided to release this code because creating new adaptable ASIC to mine monero
will require completly different approach and the code bellow does not address this.

# Monero / Cryptonight algo (as of beggining March 2018)
In a nutshell original Monero / Cryptonight algo works as following:
1. Get 200 bytes array from network and apply nonce value.
2. Hash these bytes using Keccak hashing algo and generate new 200 bytes.
3. Generate AES keys using some of the 200 bytes.
4. Generate 2 Megabyte buffer out of hashed bytes.
5. Shuffle and scramble this 2 Megabyte buffer.
6. Generate small 128 bytes buffer out of this 2 Megabytes.
7. Hash the small buffer using one of the SHA3 candidates: groestl or jk or skein etc...
8. Check if final hash has required leading number of zeros and if yes, send it to the network.

The Verilog code bellow implements steps: 3, 4, 5, 6. Only memory intensive code was
intended to be implemented by special AISC chip. Other steps were intentially left for CPU.
To be able to make changes if required in the future (in steps 1, 2, 7, 8).

# Simulation results
It takes min 2.7 million ticks to perform hashing of one buffer using cryptonight algorithm.
In worst case it might take 3.2 million ticks (depending on the 64bit x 64bit multiplication in hardware).
![alt simulation results](https://raw.githubusercontent.com/stremovsky/moneroasic/master/simulation.png)

