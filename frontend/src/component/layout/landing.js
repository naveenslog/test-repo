import React, { useState } from "react";

const messages = {
    welcome: "Welcome To",
    about: "About Us",
    description: `It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).`,
    getStarted: "Get Started"
}

const Landing = (props) => {
    return (
        <React.Fragment>
            <section className="hero-section" data-scrollax-parent="true" id="sec1">
                <div className="hero-parallax">
                    <div className="bg" data-bg="images/bg/22.jpg" data-scrollax="properties: { translateY: '200px' }"></div>
                    <div className="overlay op7"></div>
                </div>
                <div className="hero-section-wrap fl-wrap">
                    <div className="container">
                        <div className="main-search-input-wrap">
                            <div className="main-search-input fl-wrap">
                                <div className="main-search-input-item location" id="autocomplete-container">
                                    <input
                                        type="text"
                                        placeholder="Search Colleges, Courses & QnA"
                                        className="autocomplete-input"
                                        id="autocompleteid2" defaultValue=""
                                        onChange={(e) => { console.log(e.target.value, "serching") }}
                                    />
                                </div>
                                <button className="main-search-button color2-bg" onClick={(e) => { console.log(e) }}>Search <i className="fal fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section id="sec2">
                <div className="container ">
                    <div className="col-xs-12 col-md-8 col-lg-8">
                        <div className="home-abouts-img">
                            <img 
                                src={require('../../images/2516.jpg')}
                                className="img-responsive"
                            />
                        </div>
                    </div>
                    <div className="col-xs-12 col-md-4 col-lg-4">
                        <div className="home-abouts-para">
                            <p>{messages.welcome}</p>
                            <h4>
                                <span>{messages.about}</span>
                            </h4>
                            <div>{messages.description}</div>
                            <button>{messages.getStarted}</button>
                        </div>
                    </div>
                </div>
            </section>
        </React.Fragment>
    );
}

export default Landing;