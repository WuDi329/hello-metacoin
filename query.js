const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545');

web3.eth.getBalance('0xa64728460d7Fc85017F9E4ba4F979d27381D8BB5', (err, balance) => {
  if (err) {
    console.error(err);
  } else {
    console.log(`Balance: ${web3.utils.fromWei(balance, 'ether')} ETH`);
  }
});