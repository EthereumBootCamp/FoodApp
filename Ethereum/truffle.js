/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */
var HDWalletProvider = require('truffle-hdwallet-provider');

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks :{
//0xE1487EF059be1597322fC29283E3341DADA16e1E
    rinkeby: {
     provider: function() { 
        return new HDWalletProvider('evil keen cigar crowd model bar trophy ketchup clown fish siege twice',
         'https://rinkeby.infura.io/v3/ef087681f7924486b9092ecc6abf84bc') 
      },
      network_id: 2,
      gas: 4500000,
      gasPrice: 10000000000,
    }
}
};
