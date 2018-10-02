import web3 from './web3';
import foodApp from './build/contracts/foodApp.json';

const foodAppinstance = new web3.eth.Contract(
  JSON.parse(foodApp.abi),
  ''
);

export default foodAppinstance;