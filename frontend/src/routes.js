import React, { Suspense, lazy } from "react";
import { Router, Route, browserHistory, IndexRedirect } from "react-router";
import { syncHistoryWithStore } from "react-router-redux";

import store from "./store";
import Loader from "./component/common/loader";
const auth = lazy(() => import("./component/auth"));
const main = lazy(() => import("./component/main"));
const authForm = lazy(() => import("./component/user/auth"));
const mainLayout = lazy(() => import("./component/layout/mainLayout"));
const nonAuthMainLayout = lazy(() =>import("./component/layout/nonAuthMainLayout"));
const landing = lazy(() => import("./component/layout/landing"));
const nonAuth = lazy(() => import("./component/nonAuth"));
const page404 = lazy(() => import("./component/page404"));
const about = lazy(()=> import("./component/layout/about"));
const FAQs = lazy(()=> import("./component/layout/faqs"));
const Dashboard = lazy(()=> import("./component/dashboard/entryPoint"));
const Profile = lazy(() => import("./component/profile/entrypoint"));
const SchoolProfile = lazy(() => import("./component/school/profile"));

const history = syncHistoryWithStore(browserHistory, store);

function WaitingComponent(Component) {
  return props => (
    <Suspense fallback={<Loader loading={true} fullscreen />}>
      <Component {...props} />
    </Suspense>
  );
}

const allRoutes = () => (
  <Router history={history}>
    <Route component={WaitingComponent(auth)}>
      <Route component={WaitingComponent(main)}>
        <Route path="/" component={WaitingComponent(mainLayout)}>
          <IndexRedirect to="/profile" />
          <Route path="/profile" component={WaitingComponent(Profile)} />
        </Route>
      </Route>
    </Route>
    <Route component={WaitingComponent(nonAuth)}>
      <Route component={WaitingComponent(main)}>
        <Route path="/" component={WaitingComponent(nonAuthMainLayout)}>
          <IndexRedirect to="/landing" />
          <Route path="/landing" component={WaitingComponent(landing)} />
          <Route path="/home" component={WaitingComponent(landing)} />
          <Route path="/login" component={WaitingComponent(authForm)} />
          <Route path="/about" component={WaitingComponent(about)} />
          <Route path="/faq" component={WaitingComponent(FAQs)} />
          <Route path="/school-profile/:id" component={WaitingComponent(SchoolProfile)} />
        </Route>
      </Route>
    </Route>
    <Route path="*" exact={true} component={WaitingComponent(page404)} />
  </Router>
);
export default allRoutes;