import Web3 from 'web3';

let web3;
  //So when the user is not running metamask.
  const provider = new Web3.providers.HttpProvider(
    'https://rinkeby.infura.io/orDImgKRzwNrVCDrAk5Q'
  );
  web3 = new Web3(provider);

export default web3;