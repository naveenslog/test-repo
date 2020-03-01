import React from 'react';
import { connect } from 'react-redux';
import {ThemeProvider} from '@material-ui/styles';
import theme from './layout/theme';
import ErrorSnackbar from './common/errorSnackbar';

const Main = ({ children }) => {

  return (
    <ThemeProvider theme={theme}>
      <ErrorSnackbar>
        {children}
      </ErrorSnackbar>
    </ThemeProvider>
  );
}

const mapStateToProps = state => ({
  session: state.session,
});


const mapDispatchToProps = dispatch => ({
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(Main);
