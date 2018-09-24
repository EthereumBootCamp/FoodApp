pragma solidity ^0.4.0;
contract foodApp {
    address contract1;
    function contractAddress() view returns (address){
    return contract1;
  }

  function createResturant() {
    address resturant = new Resturant(msg.sender);
    contract1 = resturant;
  }
}
contract Resturant {
    int rating;
    int ratersNum =0;
    int orderNum =0;
    mapping(address => bool) raters;
    mapping(int => uint) orders;
    address manager;
    struct Meal {
        string description;
        uint price;
    }
    Meal[] meals;
    event order(int ordernumber, string location, string mealDesc );
    event cancel(int ordernumber);
    constructor(address owner){
        manager= owner;
    }
    
    function addMeal(string description, uint price) isManager {
        Meal memory meal = Meal(description,price);
        meals.push(meal);
    }
    
    modifier isManager {
        require(msg.sender == manager);
        _;
    }
    
    function orderMealByToken(uint index){}
    
    function orderMealByEther(uint index, string location) payable{
       Meal meal = meals[index];
       require(msg.value >= meal.price);
       orders[orderNum] = now;
       orderNum++;
       manager.transfer(msg.value); 
       raters[msg.sender] = true;
       //we need to send the location info to the resturant
       emit order(orderNum-1, location, meal.description);
    }
    
    function rate(int num){
        require(raters[msg.sender]);
        ratersNum++;
        rating = (rating+num)/(ratersNum);
        raters[msg.sender] = false;

    }
    
    function cancelOrder(int orderNumber){
    // we have a problem guys we need to make sure that message sender is 
    //the same person who ordered
        require(orders[orderNumber] == now+ 15 minutes);
        emit cancel(orderNumber);
    }
    
}