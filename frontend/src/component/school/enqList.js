import React from 'react';
import { host } from '../../config';
import { connect } from 'react-redux';
import { browserHistory as history } from 'react-router';


const Listing = (props) => {
  const { item, session } = props;
  const handleApplication = (value) => {
    console.log(value)
  }
  return (
    <div
      className="list-contianer"
      key={item.id}
    >
      <span>
        {
          <img
            src={item.user_profile === "" ? (
              require("../../images/user.svg")
            ) : (
              `${host + "/images/" + item.user_profile}`
            )}
            className="list-img"
            alt="a"
          />
        }
      </span>
      <span className="list-details">
        <div><h2>Name: {item.name}</h2></div>
      </span>
      <span className="list-details">
        <div><h2>Age: {item.age}</h2></div>
      </span>
      <span className="list-details">
        <div><h2>phone: {item.name}</h2></div>
      </span>
      <span className="list-details">
        <div><h2>Course: {item.course}</h2></div>
      </span>
      <div className="profile-list-status">
        {
          item.application_status == "pending" ? (
            <React.Fragment>
              <button 
                onClick={() => handleApplication("accepted")}
              >
                Accept 
              </button>
              <button 
                onClick={() => handleApplication("accepted")}
              >
                Reject
              </button>
            </React.Fragment>
          ) : (
              item.applied_status == "accepted" ? < span style={{ color: "#00804a" }}> <i className="fas fa-check-square" style={{ marginRight: "10px" }}></i> Accepted </span> :
                <span style={{ color: "#d2052a" }}><i className="fas fa-window-close" style={{ marginRight: "10px" }}></i>Rejected </span>
            )
        }
      </div>
    </div>
  )
}

const mapState = (state) => {
  return {
    session: state.session
  }
}

const mapDispatch = (dispatch) => {
  return {

  }
}
export default Listing;