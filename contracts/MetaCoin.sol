// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract MetaCoin {
	mapping (address => uint) balances;

// 事件用来记录日志
// Transfer事件是一个在Solidity合约中定义的事件，用于记录代币的转账操作。它包含三个参数：

// _from：代币发送者的地址。
// _to：代币接收者的地址。
// _value：转移的代币数量。
// 当MetaCoin合约中的sendCoin()函数被调用时，如果代币转移成功，就会触发Transfer事件。
// 在这个事件中，_from参数会被设置为发送者的地址，_to参数会被设置为接收者的地址，_value参数会被设置为转移的代币数量。
// 这个事件会被记录到以太坊网络中，并可以被其他合约或外部应用程序监听和处理。
	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() {
		// tx.origin表示交易的发送者的地址。当合约被部署到以太坊网络中时，构造函数会被执行，
		// 并将合约创建者的地址（即交易的发送者）的余额设置为10000个代币。
		// 这个操作使用了balances映射类型的变量，将tx.origin作为键，将10000作为值，将代币余额存储到了balances变量中。
		balances[tx.origin] = 10000;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
