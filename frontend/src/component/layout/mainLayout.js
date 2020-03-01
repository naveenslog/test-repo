import React, { Component } from 'react';
import CustomMenu from './menu';
import Footer from '../common/footer';
import { withStyles } from '@material-ui/core/styles';


const styles = theme => ({
  root: {
    marginLeft: '20px',
    marginRight: '20px'
  }
});


class MainLayout extends Component {

  render() {
    const { children } = this.props;
    return (
      <div>
        <CustomMenu>
          {children}
        </CustomMenu>
      </div>
    );
  }
}


export default withStyles(styles)(MainLayout);
