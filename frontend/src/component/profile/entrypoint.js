import React, {useEffect} from "react";
import {connect} from 'react-redux';
import StudentProfile from '../student/profile'
import SchoolProfile from '../school/profile'
import { loadSchoolData } from '../../reducers/schoolReducer';

const ProfileEntryPoint = props => {
  const {session, loadSchoolData} = props;

  useEffect(()=>{
    console.log("profile called")
    loadSchoolData()
  }, [])

  return (
    <React.Fragment>
      {session&&session.user_type === "student" && <StudentProfile/>}
      {session&&session.user_type === "school" && <SchoolProfile/>}
    </React.Fragment>
  );
};

const mapState = (state) => {
  return {
    session: state.session
  }
}

const mapDispatch = (dispatch) => {
  return {
    loadSchoolData: () => dispatch(loadSchoolData())
  }
}

export default connect(mapState, mapDispatch)(ProfileEntryPoint);