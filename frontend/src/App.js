import React from "react";
import { Provider } from "react-redux";
import Routes from "./routes";
import store from "./store";
import "./css/styles.css";
import "./css/color.css";
import "./css/plugins.css"
import "./css/cs-style.css";
import "./css/reset.css";

function App() {
  return (
    <Provider store={store}>
      <Routes />
    </Provider>
  );
}

export default App;
