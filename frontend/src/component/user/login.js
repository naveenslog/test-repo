import React, {useState} from "react";
import {connect} from 'react-redux';
import {loginUser} from '../../reducers/session';

const Login = props => {
  const {activeTab} = props;

  const [formData, setFormData] = useState({email: "", password: ""})

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    })
  }

  const handleSubmit = (e) => {
    const {login} = props;
    e.preventDefault();
    login(formData)
  }

  return (
    <div className="tab">
      <div id="tab-1" className="tab-content" style={{ display: activeTab === "login" ? "block" : "none" }}>
        <h3>Sign In <span>Blue<strong>Ribons</strong></span></h3>
        <div className="custom-form">
          <form name="registerform" onSubmit={handleSubmit}>
            <label>Username or Email Address <span>*</span> </label>
            <input
              name="email"
              type="text"
              onChange={handleChange}
              value={formData.email}
            />
            <label >Password <span>*</span> </label>
            <input 
              name="password"
              type="password"
              onChange={handleChange}
              value={formData.password}
            />
            <button 
              type="submit"
              className="log-submit-btn color-bg"
            >
              <span>Log In</span>
            </button>
            <div className="clearfix"></div>
          </form>
          <div className="lost_password">
            <a href="#">Lost Your Password?</a>
          </div>
        </div>
      </div>
      </div>
      )
    };
    
    const mapState = (state) => {
      return{
        state: state
      }
    }

    const mapDispatch = (dispatch) => {
      return {
        login: (body) => dispatch(loginUser(body)),
      }
    }

    export default connect(mapState, mapDispatch)(Login);
