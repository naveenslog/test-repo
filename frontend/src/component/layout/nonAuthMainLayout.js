import React, { Component } from 'react';
import CustomMenu from './menu';
import Footer from '../common/footer';
import { withStyles } from '@material-ui/core/styles';

const styles = theme => ({
  "@global": {
    body: {
      backgroundRepeat  : 'no-repeat',
      backgroundPosition: 'center',
      backgroundSize: 'cover',
    },
  },
  root: {
    marginLeft: '20px',
    marginRight: '20px',
  },
});

class NonAuthMainLayout extends Component {

  render() {
    const { classes, children } = this.props;
    return (
      <div className={classes.main}>
        <CustomMenu>
          {children}
        </CustomMenu>
      </div>
    );
  }
}

export default withStyles(styles)(NonAuthMainLayout);
