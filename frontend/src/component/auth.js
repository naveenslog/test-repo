import React, { Component } from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { initSession, loadUserData } from "../reducers/session";
import { SESSION_STATUS } from "../helpers/constants";
import Loader from "./common/loader";

class Auth extends Component {
  componentDidMount() {
    const { sessionInit, loadUserInfo } = this.props;
    const token = window.localStorage.token;
    sessionInit({ token });
    loadUserInfo();
  }

  render() {
    const { status, children } = this.props;
    return (
      <React.Fragment>
        <Loader loading={status === SESSION_STATUS.CHANGING} fullscreen />
        {status === SESSION_STATUS.READY ? children : null}
      </React.Fragment>
    );
  }
}

Auth.propTypes = {
  sessionInit: PropTypes.func,
  loadUserInfo: PropTypes.func,
  children: PropTypes.node,
  status: PropTypes.string
};

const mapStateToProps = state => ({
  status: state.session.state
});

const mapDispatchToProps = dispatch => ({
  sessionInit: session => {
    dispatch(initSession(session));
  },
  loadUserInfo: () => dispatch(loadUserData())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Auth);
