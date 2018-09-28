pragma solidity ^0.4.21;
contract foodApp {
   address contract1;
   function contractAddress() public view returns (address){
       return contract1;}
       function createResturant() public {
           address resturant = new Resturant(msg.sender);
           contract1 = resturant;}

}

interface BCCoin{
   //function approve(address _spender, uint256 _value)  external returns (bool success);
   function transferFrom(address _from, address _to, uint256 _value)  external returns (bool success);
    }



    contract Resturant {
      int rating;
       int ratersNum =0;
       int public orderNum =0;
       uint tokenValue = 1;
       mapping(address => bool) raters;  //  mapping(int => uint) orders;
            address manager;
             struct Meal {
              string description;  uint price;  }
              struct Order {  address customer;
               uint time;  }
               mapping(int => Order) orders;
               Meal[] public meals;
                event orderEvent(int ordernumber, string location, string mealDesc );
                event cancel(int ordernumber);
                constructor (address owner) public{
                manager= owner;  }
                function addMeal(string description, uint price) public isManager {
                   Meal memory meal = Meal(description,price);
                    meals.push(meal);
                     }     modifier isManager {
                        require(msg.sender == manager); _;
                             }
function orderMealByToken(uint index,string location, address from, uint value, address token1) public {
  Meal memory meal = meals[index];
    uint mealPriceInToken = meal.price/tokenValue;
        BCCoin token = BCCoin(token1);
          // require (token.approve(this,mealPriceInToken));
             require(token.transferFrom(from,this,value));
     Order memory order = Order (msg.sender,now);
       orders[orderNum] = order;
          orderNum++;
                emit orderEvent(orderNum-1, location, meal.description);      }
                 function orderMealByEther(uint index, string location) public payable{     Meal memory meal = meals[index];     Order memory order = Order (msg.sender,now);     require (msg.value >= meal.price);     orders[orderNum] = order;     orderNum++;    // manager.transfer(msg.value);    manager.transfer(meal.price);          raters[msg.sender] = true;     //we need to send the location info to the resturant
   emit orderEvent(orderNum-1, location, meal.description);       }
      function rate(int num) public {
          require(raters[msg.sender]);
          ratersNum++;
          rating = (rating+num)/(ratersNum);      raters[msg.sender] = false;       }
 function cancelOrder(int orderNumber) public {
   // we have a problem guys we need to make sure that message sender is  //the same person who ordered
         Order memory ord = orders[orderNumber];
          require (ord.customer == msg.sender);
          require(ord.time == now+ 15 minutes);
          delete orders[orderNumber];
          emit cancel(orderNumber);
               }


function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public {
orderMealByToken(0,"ayyyyy eshi",_from, _value, _token);
}
    }