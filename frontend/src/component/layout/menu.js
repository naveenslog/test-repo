import React from 'react';
import { browserHistory as history } from 'react-router';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from '@material-ui/core/styles';
import CssBaseline from '@material-ui/core/CssBaseline';
import CustomNav from '../common/navbar';
import CustomFooter from '../common/footer';

const drawerWidth = 240;

class CustomMenu extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    const { classes, children } = this.props;
    return (
      <div>
        <CssBaseline />
        <CustomNav/>
        {children}
        <CustomFooter/>
      </div>
    );
  }
}

CustomMenu.propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired,
};

export default CustomMenu