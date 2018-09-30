pragma solidity ^0.4.21;
contract foodApp {
   address contract1;
   function contractAddress() public view returns (address){
       return contract1;
       
   }
       function createResturant(address token) public {
           address resturant = new Resturant(msg.sender,token);
           contract1 = resturant;
           
       }

}




interface BCCoin{
    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value)  external returns (bool success);
    }




contract Resturant {
    int rating;
    int ratersNum =0;
    int public orderNum =0;

       
    mapping(address => bool) raters;  
    address manager;
    address tokenUsed;
    
    struct Meal {
        string description;
        uint ethPrice;  
        uint tokenPrice;
        
    }
    struct Order {  
        address customer;
        uint time; 
        uint mealIndex;
        
    }
    
    mapping(int => Order) orders;
    mapping(address => uint) approved;
    
    Meal[] public meals;
    
     event orderEvent(int ordernumber, string location, string mealDesc );
     event cancel(int ordernumber);
     
    constructor (address owner , address currency)  public{
         manager= owner; 
         tokenUsed = currency;
         
        
    }

 function addMeal(string description, uint ethPrice,uint tokenPrice) public isManager {
         Meal memory meal = Meal(description,ethPrice,tokenPrice);
        meals.push(meal);
        }     
        
 modifier isManager {
     require(msg.sender == manager);
      _;
 }
 
function orderMealByToken(uint index,string location, address from) public {
  Meal memory meal = meals[index];
  BCCoin token = BCCoin(tokenUsed);
  require (approved[from] >= meal.tokenPrice);
  require(token.transferFrom(from,this,meal.tokenPrice));
  approved[from]-=meal.tokenPrice;
  Order memory order = Order (msg.sender,now,index);
  orders[orderNum] = order;
  orderNum++;
  raters[msg.sender] = true;
  emit orderEvent(orderNum-1, location, meal.description);     
                
    
}


function orderMealByEther(uint index, string location) public payable{     
    Meal memory meal = meals[index];    
    Order memory order = Order (msg.sender,now,index);    
    
    require (msg.value >= meal.ethPrice);    
    orders[orderNum] = order;    
    orderNum++;   
    manager.transfer(meal.ethPrice);         
    raters[msg.sender] = true;     //we need to send the location info to the resturant
   emit orderEvent(orderNum-1, location, meal.description);      
  }
     
     
function rate(int num) public {
    require(raters[msg.sender]);
    ratersNum++;
    rating = (rating+num)/(ratersNum);      
    raters[msg.sender] = false;       
    
}
 
 
 function cancelOrderByEther(int orderNumber) public {
   // we have a problem guys we need to make sure that message sender is  //the same person who ordered
    Order memory ord = orders[orderNumber];
    Meal memory mealOrdered = meals[ord.mealIndex];
    require (ord.customer == msg.sender);
    require(ord.time == now+ 15 minutes);
    delete orders[orderNumber];
    msg.sender.transfer(mealOrdered.ethPrice);
    emit cancel(orderNumber);
             
  }
  
  function cancelOrderByToken(int orderNumber) public {
   // we have a problem guys we need to make sure that message sender is  //the same person who ordered
    Order memory ord = orders[orderNumber];
    Meal memory mealOrdered = meals[ord.mealIndex];
    require (ord.customer == msg.sender);
    require(ord.time == now+ 15 minutes);
    delete orders[orderNumber];
    
    BCCoin token = BCCoin(tokenUsed);
    token.transfer(ord.customer,mealOrdered.tokenPrice);
    
    approved[ord.customer]+=mealOrdered.tokenPrice;
    emit cancel(orderNumber);
             
  }


function receiveApproval(address _from, uint256 _value) public {
approved[_from]=_value;
}

    
}
