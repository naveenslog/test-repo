import { browserHistory as history } from 'react-router';
import R from 'ramda';
import {
  getUserData,
  login,
  logout,
} from '../helpers/api/api';
import { SESSION_STATUS, ACCOUNT_TYPES, OTHER  } from '../helpers/constants';

export const SESSION_CHANGE = 'SESSION_CHANGE';
export const SESSION_READY = 'SESSION_READY';
export const LOGIN_SUCCESS = 'LOGIN_SUCCESS';
export const LOGIN_FAILURE = 'LOGIN_FAILURE';
export const LOGIN_SUBMITTING = 'LOGIN_SUBMITTING';
export const LOGOUT_SUCCESS = 'LOGOUT_SUCCESS';
export const SESSION_ERROR = 'SESSION_ERROR';
export const USER_INFO = 'USER_INFO';

const initialState = {
  state: SESSION_STATUS.INITIAL,
  authorized: false,
  fontSize: '16px',
  user: null,
  userId: null,
  token: null,
  userStatus: null,
  userLogged: false,
  error: null,
  email: null,
  user_type: null,
  membership: null
};

// Action creators
export const initSession = session => ({ type: SESSION_CHANGE, session });
export const sessionInitializing = () => ({
  type: SESSION_CHANGE,
  session: { state: SESSION_STATUS.CHANGING }
});
export const sessionChange = session => ({
  type: SESSION_CHANGE,
  session: { ...session, state: SESSION_STATUS.READY }
});
export const sessionReady = getState => ({
  type: SESSION_READY,
  session: { state: SESSION_STATUS.READY },
  getState
});
export const sessionError = error => ({ type: SESSION_ERROR, error });
export const loginSuccess = session => ({ type: LOGIN_SUCCESS, session });
export const logoutSuccess = () => ({ type: LOGOUT_SUCCESS });
export const userData = session => ({ type: USER_INFO, session });

export const loadUserData = () => (dispatch, getState) => {
  const { session } = getState();
  const token = session.token;

  dispatch(sessionInitializing());
  return getUserData(token)
    .then((response) => {
      window.localStorage.setItem('user_type', response.success.user_type);
      const membership = response.success.user_type === "student" ? (
        response.success.studentProfile
      ) : (
        response.success.schoolProfile
      )
      let sessionObject = {
        user_type: response.success.user_type,
        name: response.success.name,
        userId: response.success.id,
        email: response.success.email,
        membership: membership,
        authorized: true,
      };
      const addToSession = R.mergeDeepRight(sessionObject);
      sessionObject = addToSession(sessionObject);
      dispatch(initSession(sessionObject));
      dispatch(sessionReady(getState));
      return sessionObject;
    })
    .catch((error) => {
      console.log(error, "Error while create the session")
      window.localStorage.removeItem('token');
      window.location.href = '/landing/';
      dispatch(initSession({
        authorized: false,
        error,
      }));
    });
};

export const loginUser = creds => dispatch => login(creds)
  .then((response) => {
    window.localStorage.setItem('token', response.success.token);
    dispatch(loginSuccess({ user: creds.email, token: response.success.token }));
    dispatch(loadUserData());
    history.push('/profile');
  })

export const logoutUser = () => (dispatch, getState) => {
  const logoutAzure = getState().generalConfig['active-directory-logout-url'];

  return logout()
    .then(() => {
      window.localStorage.removeItem('token');
      dispatch(logoutSuccess())
      window.location.href = '/login';
    }).catch(() => {
      window.localStorage.removeItem('token');
      dispatch(logoutSuccess());
      window.location.href = '/login';
    })
  }

// Reducer helper function
const setSession = (state, session) => {
  return R.mergeDeepRight(state, session);
};

// Reducer
export default function sessionReducer(state = initialState, action) {
  switch (action.type) {
    case SESSION_READY: {
      return setSession(state, action.session);
    }
    case SESSION_CHANGE: {
      return setSession(state, action.session);
    }
    case LOGIN_SUCCESS: {
      return setSession(state, { userLogged: true, ...action.session });
    }
    case LOGOUT_SUCCESS: {
      return initialState;
    }
    case SESSION_ERROR: {
      return R.assoc('error', action.error, state);
    }
    default:
      return state;
  }
}