import { createStore, combineReducers, applyMiddleware, compose } from "redux";
import thunk from "redux-thunk";
import { routerReducer, routerMiddleware } from "react-router-redux";
import { browserHistory } from "react-router";

import error, * as errorSelector from "./reducers/errorReducer";
import session from "./reducers/session";
import schoolDataReducer from './reducers/schoolReducer';

const mainReducer = combineReducers({
  routing: routerReducer,
  error,
  session,
  schoolData: schoolDataReducer,
});

const middleware = [thunk, routerMiddleware(browserHistory)];
let composeEnhancers = compose;
if (process.env.NODE_ENV !== 'production') {
  composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || composeEnhancers;
}

export default createStore(
  mainReducer,
  composeEnhancers(applyMiddleware(...middleware))
);

export const selectAllErrorsMapped = state => errorSelector.selectAllErrorsMapped(state.error);