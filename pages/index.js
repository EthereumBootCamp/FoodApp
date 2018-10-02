import React, { Component } from 'react';
import { Card,Button } from 'semantic-ui-react';
import foodApp from '../ethereum/foodApp.js';
//import Layout from '../components/Layout';
class FoodMain extends Component {

  static async getInitialProps() {
    const Resturants = await foodApp.methods.getDeployedResturants().call();

    return { Resturants };
  }

  renderResturants() {
    const items = this.props.Resturants.map(address => {
      return {
        header: address,
        description: <a>View Campaign</a>
      };
    });

    return <Card.Group items={items} />;
  }
  
  render() {
    return (
              <div>{this.renderResturants()}</div>
    );
  }
}

export default FoodMain;