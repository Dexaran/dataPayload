# Data Payload Realization on ERC23

I deployed DataPayloadContract on Ropsten testnet: https://testnet.etherscan.io/address/0xbbf41077eb977778099189e711f8eba03f6faa6b
ERC23 token transaction contains `data`. You can call a function in contract by sending tokens with attached `data` similar to contract call by sent ETC transaction with `data`.
DataPayloadContract contains `buy(uint256, address)` function that will send given amount of Ether to a given address. So if we need to call it directly we should attach sha3("buy(uint256,address)") to transaction (= `0x7deb6025`). At my experiment I was asking contract for 2443 wei. uint256 should be encoded to `000000000000000000000000000000000000000000000000000000000000098b` so the complete `data` payload will be `0x7deb6025000000000000000000000000000000000000000000000000000000000000098b`.
TX: https://testnet.etherscan.io/tx/0x6b2f80d407568b1c648f293f63abe7dcf490be6b7682abb0fe026eee63e5c9c5
As the result of this I received 2443 wei as expected. You can call every function inside contract by sending ERC23 tokens to contract address with `data` attached. Receiver contract may also call one more contract etc.

### Contract calls scheme
Our address: A
ERC23 token contract: B
We need to send our tokens to contract C.
C needs to redirect every incoming tokens to contract D.
D is doing nothing.

A -> B -> C -> D will be a single transaction.
A -> (msg.data contains `B call data` + `C call data`) -> B (executes `B call data` then sends token transaction to C with `C call data`) -> C (executes `C call data`) -> D
