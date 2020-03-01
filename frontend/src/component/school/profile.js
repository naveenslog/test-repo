import React, { useEffect } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { loadSchoolDetails, loadSchoolEnq } from '../../reducers/schoolReducer';
import EnqList from './enqList';

const Profile = (props) => {
    const { 
        params,
        session,
        loadSchoolDetails,
        loadSchoolEnqList,
        schoolDetails,
        schoolList,
        schoolEnqList
    } = props;

    useEffect(() => {
        params && params.id && loadSchoolDetails(params.id)
        session && session.membership && loadSchoolDetails(session.membership.id)
        session && session.membership && loadSchoolEnqList({"schoolprofile_id": session.membership.id})
    }, [])

    return (
        <React.Fragment>
            {schoolDetails&&<div style={{ marginTop: "70px", padding: "0px 50px" }}>
                <div className="profile-body" style={{ minHeight: "100vh" }}>
                    <div className="container">
                        <div className="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                            <div className="profile-left">
                                <div className="profile-image profile-image2" onClick={() => { this.upload.click() }}>
                                    <img src={schoolDetails.profile_image == "" ? require("../../images/user.svg") : schoolDetails.profile_image} alt="" />
                                    <input 
                                        type="file"
                                        id="file"
                                        style={{ display: "none" }}
                                    />
                                </div>
                                <div className="profile-details">
                                    <div 
                                        className="profile-editing"
                                        onClick={() => this.setState({ isEditable: true })}
                                    >
                                        <i class="fas fa-edit" style={{ marginRight: "2px", fontSize: "12px" }}></i>
                                        Edit
                                    </div>
                                    <ul>
                                        {/* <li>Name: {this.state.isEditable ? <input className="profile-inpu" type="text" name="name" placeholder={this.state.data.name} onChange={this.handleforminputs} /> : <span>{this.state.data.name}</span>}</li>
                                        <li>Mobile Number:{this.state.isEditable ? <input type="number" className="profile-inpu" name="mobile" placeholder={this.state.data.mobile} onChange={this.handleforminputs} /> : <span>{this.state.data.mobile}</span>}</li>
                                        <li>Email:{this.state.isEditable ? <input type="email" name="email" className="profile-inpu" placeholder={this.state.data.email} onChange={this.handleforminputs} /> : <span>{this.state.data.email}</span>}</li>
                                        <li>Gender:{this.state.isEditable ? */}
                                            {/* <div>
                                                <input type="radio" name="gender" style={{ marginRight: "5px" }} onChange={this.handleforminputs} />Male
                                                <br /><input type="radio" name="gender" style={{ marginRight: "5px" }} onChange={this.handleforminputs} />Female
                                            </div> : <span>{this.state.data.gender}</span>}</li> */}
                                        {/* <li style={{ cursor: "pointer" }} onClick={() => this.setState({ ischnde: true })}>Change Password
                                            {this.state.ischnde ?
                                                <div style={{ padding: "18px 0px" }}>
                                                    <input type="password" name="oldpassword" className="profile-inpu" placeholder={"Enter your old password"} onChange={this.handleformpassword} />
                                                    <input type="password" name="newpassword" className="profile-inpu" placeholder={"Enter your new password"} onChange={this.handleformpassword} />
                                                    <input type="password" name="confirmpassword" className="profile-inpu" placeholder={"Confirm password"} onChange={this.handleformpassword} />
                                                </div>
                                                : null}</li>

                                        {this.state.ischnde || this.state.isEditable ? <div className="update-details">Update</div> : null} */}
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div className="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                            <div className="profile-right">
                                <div className="profile-right-header">List of applications</div>
                                <div className="profile-right-body">
                                    <div className="profile-right-body-header"></div>
                                    <div className="listnerMain">
                                        {schoolEnqList&&schoolEnqList.map(item=><EnqList item={item}/>)}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>}
        </React.Fragment>
    )
}

const mapState = (state) => {
    return {
        schoolDetails: state.schoolData.schoolDetails,
        schoolList: state.schoolData.schoolData,
        schoolEnqList: state.schoolData.schoolEnq,
        session: state.session
    }
}

const mapDispatch = (dispatch) => {
    return {
        loadSchoolDetails: (schoolId) => dispatch(loadSchoolDetails(schoolId)),
        loadSchoolEnqList: (prarm) => dispatch(loadSchoolEnq(prarm))
    }
}

export default withRouter(connect(mapState, mapDispatch)(Profile));