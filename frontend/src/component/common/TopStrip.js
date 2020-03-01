import React, { useState, useEffect } from "react";
import {connect } from 'react-redux';
import { browserHistory as history } from 'react-router';

const messages = {
    signIn: "Sign In",
    logout: "Logout",
    myAccount: "My Account",
    career: "Career",
    blog: "Blog",
    faqs: "FAQs",
    aboutUs: "About Us",
    home: "Home",
    dashboard: "Dashboard"
}

const TopStrip = (props) => {
    const {session} = props;
    const [state, setState] = useState({
        isProfile: false
    })
    return (
        <div>
            <div>
                <div className="header-top fl-wrap">
                    <div className="container">
                        <div>
                        </div>
                        <div 
                            className="show-reg-form modal-open"
                            onClick={() => {session&&session.authorized === true ? history.push("/profile") : history.push("/login")}}
                        >
                            <i className="fa fa-sign-in"></i>
                            {session&&session.authorized === true ? messages.myAccount : messages.signIn}
                         </div>
                        <div className="lang-wrap">
                            <div className="show-lang">
                                <span>{messages.career}</span>
                            </div>
                        </div>
                        <div className="lang-wrap">
                            <div 
                                className="show-lang"
                                onClick={() => history.push("/faq")}
                            >
                                <span>{messages.faqs}</span>
                            </div>
                        </div>
                        <div className="lang-wrap">
                            <div className="show-lang">
                                <span>{messages.blog}</span>
                            </div>
                        </div>
                        <div className="lang-wrap">
                            <div 
                                className="show-lang"
                                onClick={() => history.push("/about")}
                            >   
                                <span>{messages.aboutUs}</span>
                            </div>
                        </div>
                        <div className="lang-wrap">
                            <div 
                                className="show-lang"
                                onClick={() => history.push("/home")}
                            >
                                <span>{messages.home}</span>
                            </div>
                        </div>
                        {/* <a href="/home"><img src={require("../../images/logo.png")} alt="" /></a> */}
                    </div>
                </div>
            </div>
        </div>
    );
}

const mapState = (state) => {
    return {
        session: state.session
    }
}

export default connect(mapState, null)(TopStrip)