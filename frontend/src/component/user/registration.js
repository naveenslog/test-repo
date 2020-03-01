import React, { useState } from "react";

const Registration = props => {
  const { activeTab } = props;

  const [formData, setFormData] = useState({});

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    })
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log(formData);
  }

  return (
    <div className="tab">
      <div id="tab-2" className="tab-content" style={{ display: activeTab === "register" ? "block" : "none" }}>
        <h3>Sign Up <span>Blue<strong>Ribons</strong></span></h3>
        <div className="custom-form">
          <form name="registerform" id="main-register-form2" onSubmit={handleSubmit}>
            <label >Full Name <span>*</span> </label>
            <input
              name="name"
              type="text"
              onChange={handleChange}
              defaultValue={formData.name}
            />
            <label>Email Address <span>*</span></label>
            <input
              name="email"
              type="text"
              onChange={handleChange}
              defaultValue={formData.email}
            />
            <label >Password <span>*</span></label>
            <input
              name="password"
              type="password"
              onChange={handleChange}
              defaultValue={formData.password}
            />
            <label >Confirm Password <span>*</span></label>
            <input
              name="password"
              type="password"
              onChange={(e) => setFormData({...formData, c_password: e.target.value })}
              defaultValue={formData.confirm_password}
            />
            <label >Account type <span>*</span></label>
            <div className="reg-radio">
              <span className="ref-spam">
                <label >School</label>
                <input
                  name="account"
                  type="radio"
                  onChange={(e) => setFormData({...formData, user_type: "school" })}
                  defaultValue={formData.user_type == "school" ? true : false}
                />
              </span>
              <span className="ref-spam">
                <label >Student</label>
                <input
                  name="account"
                  type="radio"
                  onChange={(e) => setFormData({...formData, user_type: "student" })}
                  defaultValue={formData.user_type == "student" ? true : false}
                />
              </span>
            </div>
            <button
              type="submit"
              className="log-submit-btn color-bg"
            >
              <span>Register</span>
            </button>
          </form>
        </div>
      </div>
    </div>
  )
};

export default Registration;
