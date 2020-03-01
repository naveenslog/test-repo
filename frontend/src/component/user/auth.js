import React, { useState } from "react";
import Login from './login';
import Register from './registration';
import { browserHistory as history } from 'react-router';

const Auth = (props) => {
    const [activeTab, setActiveTab] = useState("login");

    return (
        <div className="main-register-wrap modal" style={{ display: "block" }}>
            <div className="reg-overlay" ></div>
            <div className="main-register-holder">
                <div className="main-register fl-wrap">
                    <div className="close-reg color-bg" onClick={()=>history.push("/home")}>
                        <i className="fal fa-times"></i>
                    </div>
                    <ul className="tabs-menu">
                        <li 
                            className={activeTab === "login" ? "current": null}
                            onClick={()=>{setActiveTab("login")}}
                        >
                            <a href="#tab-1"><i className="fal fa-sign-in-alt"></i> Login</a>
                        </li>
                        <li 
                            className={activeTab === "register" ? "current": null}
                            onClick={()=>{setActiveTab("register")}}
                        >
                            <a href="#tab-2"><i className="fal fa-user-plus"></i> Register</a>
                        </li>
                    </ul>
                    <div id="tabs-container">
                        <Login activeTab={activeTab}/>
                        <Register activeTab={activeTab}/>
                        <div className="log-separator fl-wrap"><span>or</span></div>
                        <div className="soc-log fl-wrap">
                            <p>For faster login or register use your social account.</p>
                            <a href="#" className="google-log"><i className="fab fa-google"></i>Connect with Google</a>
                            <a href="#" className="facebook-log"><i className="fab fa-facebook-f"></i>Connect with Facebook</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Auth;