import R from 'ramda';
import { getSchoolData, getSchoolDetails, getSchoolEnq } from '../helpers/api/api';
import {
  clearError,
  startLoading,
  stopLoading,
  saveErrorMsg,
} from './apiStatus';

export const SCHOOL_LOAD_STARTED = 'SCHOOL_LOAD_STARTED';
export const SCHOOL_LOAD_FAILURE = 'SCHOOL_LOAD_FAILURE';
export const SCHOOL_LOAD_ENDED = 'SCHOOL_LOAD_ENDED';
export const SCHOOL_LOAD_SUCCESS = 'SCHOOL_LOAD_SUCCESS';
export const SCHOOL_DETAIL_LOAD_SUCCESS = 'SCHOOL_DETAIL_LOAD_SUCCESS';
export const SCHOOL_ENQ_LOAD_SUCCESS = 'SCHOOL_ENQ_LOAD_SUCCESS';

export const schoolLoadStarted = () => ({ type: SCHOOL_LOAD_STARTED });
export const schoolLoadFailure = error => ({ type: SCHOOL_LOAD_FAILURE, error });
export const schoolLoadEnded = () => ({ type: SCHOOL_LOAD_ENDED });
export const schoolLoadSuccess = response => ({ type: SCHOOL_LOAD_SUCCESS, response });
export const schoolDetailLoadSuccess = response => ({ type: SCHOOL_DETAIL_LOAD_SUCCESS, response });
export const schoolEnqLoadSuccess = response => ({ type: SCHOOL_ENQ_LOAD_SUCCESS, response });

const saveSchool = (state, action) => {
  return R.assoc('schoolData', action.response.success, state);
};
const saveSchoolDetails = (state, action) => {
  return R.assoc('schoolDetails', action.response.success, state);
};
const saveSchoolEnq = (state, action) => {
  return R.assoc('schoolEnq', action.response.success, state);
};

const messages = {
  loadFailed: 'Loading school data failed.',
};

const initialState = {
  loading: false,
  totalCount: 0,
  schoolData: [],
  schoolDetails: null,
  saveSchoolEnq: []
};


export const loadSchoolData = params => (dispatch) => {
  dispatch(schoolLoadStarted());
  return getSchoolData(params)
    .then((school) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolLoadSuccess(school));
    })
    .catch((error) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolLoadFailure(error));
    });
};

export const loadSchoolDetails = schoolId => (dispatch) => {
  dispatch(schoolLoadStarted());
  return getSchoolDetails(schoolId)
    .then((school) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolDetailLoadSuccess(school));
    })
    .catch((error) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolLoadFailure(error));
    });
};

export const loadSchoolEnq = params => (dispatch) => {
  dispatch(schoolLoadStarted());
  return getSchoolEnq(params)
    .then((school) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolEnqLoadSuccess(school));
    })
    .catch((error) => {
      dispatch(schoolLoadEnded());
      dispatch(schoolLoadFailure(error));
    });
};


export default function schoolDataReducer(state = initialState, action) {
  switch (action.type) {
    case SCHOOL_LOAD_FAILURE: {
      return saveErrorMsg(state, action, messages.loadFailed);
    }
    case SCHOOL_LOAD_ENDED: {
      return stopLoading(state);
    }
    case SCHOOL_LOAD_STARTED: {
      return startLoading(clearError(state));
    }
    case SCHOOL_LOAD_SUCCESS: {
      return saveSchool(state, action);
    }
    case SCHOOL_DETAIL_LOAD_SUCCESS: {
      return saveSchoolDetails(state, action);
    }
    case SCHOOL_ENQ_LOAD_SUCCESS: {
      return saveSchoolEnq(state, action);
    }
    default:
      return state;
  }
}