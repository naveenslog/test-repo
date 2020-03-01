import React, {useEffect} from "react";
import {connect} from 'react-redux';
import StudentDashboard from '../student/index'
import SchoolDashboard from '../school/index'
import { loadSchoolData } from '../../reducers/schoolReducer';

const DashboardEntryPoint = props => {
  const {session, loadSchoolData} = props;

  useEffect(()=>{
    loadSchoolData()
  }, [])

  return (
    <React.Fragment>
      {session&&session.user_type === "student" && <StudentDashboard/>}
      {session&&session.user_type === "school" && <SchoolDashboard/>}
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
    loadSchoolData: (post) => dispatch(loadSchoolData())
  }
}

export default connect(mapState, mapDispatch)(DashboardEntryPoint);