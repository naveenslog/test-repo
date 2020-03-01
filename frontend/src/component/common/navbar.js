import React, { useEffect } from "react";
import TopStrip from './TopStrip';

const Navbar = (props) => {
    return (
        <div className="header-inner fl-wrap" style={props.param ? { background: "#3aaced" } : null}>
            <TopStrip/>
            {/* <div className="container">
                <div className="logo-holder">
                    <a href="/home"><img src={require("../../images/logo.png")} alt="" /></a>
                </div>
                <div className="nav-holder main-menu">
                    <nav>
                        <ul>
                            <li>
                                <a href="#" style={props.color ? { color: "#F9B90F" } : null}>Play School <i className="fas fa-caret-down"></i></a>
                                <ul>
                                    <li><a href="/home">Search by location</a></li>
                                    <li><a href="/home">Top Schools</a></li>
                                    <li><a href="/home">Search by reviews</a></li>
                                    <li><a href="/home">Search by school ranking</a></li>
                                    <li><a href="/home">Search by school cut-off</a></li>
                                </ul>

                            </li>
                            <li>
                                <a href="#" style={props.color ? { color: "#F9B90F" } : null}>Primary School <i className="fas fa-caret-down"></i></a>
                                <ul>
                                    <li><a href="listing.html">Search by location</a></li>
                                    <li><a href="listing6.html">Top Schools</a></li>
                                    <li><a href="listing2.html">Search by reviews</a></li>
                                    <li><a href="listing3.html">Search by school ranking</a></li>
                                    <li><a href="listing4.html">Search by school cut-off</a></li>
                                    <li><a href="listing5.html">Comparison</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="blog.html" style={props.color ? { color: "#F9B90F" } : null}>Help</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div> */}
        </div>
    );
}

export default Navbar; 