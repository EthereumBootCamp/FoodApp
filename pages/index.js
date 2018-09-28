import React, { Component } from 'react';
import { Button } from 'semantic-ui-react';


class FoodMain extends Component {
  
  render() {
    return (
     
        <div>
              <Button
                floated="right"
                content="create Resturant"
                icon="add circle"
                primary
              />
        </div>
    );
  }
}

export default FoodMain;