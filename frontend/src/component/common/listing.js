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
            <span>{<img src={item.user_profile === "" ? require("../../images/user.svg") : `${host + "/images/" + item.user_profile}`} className="list-img" alt="jfk" />}</span>
            <span className="list-details">
                <div><h2>{item.name}</h2></div>
                <div>
                    <span className="list-rating">{item.rating}</span>
                    {item.rating}
                </div>
                <div><i className="fa fa-map-marker-alt"></i>
                    <span className="list-location">{item.add_line1}</span></div>
                <div>{item.status == "Open" || item.status == "open" ? <span className="list-open">Admission Open</span> : <span className="list-closed">Admission Closed</span>}</div>
            </span>
            <div className="profile-list-status">
                {
                    session && session.user_type === "student" ? (
                        item.application_status == "pending" ? (<span style={{ color: "#3aaced" }} > <i className="far fa-tasks" style={{ marginRight: "10px" }} /> Applied</span>) : 
                        item.applied_status == "accepted" ? < span style={{ color: "#00804a" }}> <i className="fas fa-check-square" style={{ marginRight: "10px" }}></i> Accepted </span> : 
                        < span style={{ color: "#d2052a" }}><i className="fas fa-window-close" style={{ marginRight: "10px" }}></i>Rejected </span>
                    ) : (
                        item.application_status == "pending" ? (
                            <React.Fragment>
                                <button onClick={()=>handleApplication("accepted")}>Accept </button>/ <button onClick={()=>handleApplication("accepted")}> Reject </button>>
                            </React.Fragment>
                        ) : (
                            item.applied_status == "accepted" ? < span style={{ color: "#00804a" }}> <i className="fas fa-check-square" style={{ marginRight: "10px" }}></i> Accepted </span> : 
                            <span style={{ color: "#d2052a" }}><i className="fas fa-window-close" style={{ marginRight: "10px" }}></i>Rejected </span>
                        )
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