import React, { Component } from "react";
import MuiThemeProvider from "@material-ui/core/styles/MuiThemeProvider";

// component for routes that don't need to authenthicate token on the backend like login
// and registration
class NonAuth extends Component {
  render() {
    const { children } = this.props;
    return <MuiThemeProvider>{children}</MuiThemeProvider>;
  }
}

export default NonAuth;
