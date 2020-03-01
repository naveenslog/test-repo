import axios from "axios";
import moment from "moment-timezone";
import store from "../../store";
import { func } from "prop-types";

const host = "http://34.70.253.200:8000/api";

// Internal help/generic functions
function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== "") {
    const cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) === `${name}=`) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}

function buildHeaders(authorize = false, extraHeaders = {}) {
  const token = store.getState().session.token;
  const partnerId = store.getState().session.partnerId;
  const officeId = store.getState().session.officeId;
  let headers = {
    Pragma: "no-cache",
    "Cache-Control": "no-cache",
    "Client-Timezone-Name": moment.tz.guess(),
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
  };
  if (authorize && token)
    headers = { ...headers, Authorization: `Bearer ${token}` };
  if (partnerId) headers = { ...headers, "Partner-ID": partnerId };
  if (officeId) headers = { ...headers, "Agency-Office-ID": officeId };

  return { ...headers, ...extraHeaders };
}

function get(uri, params = {}, options) {
  const opt = { method: "GET", params, headers: buildHeaders() };
  return axios
    .get(`${host}${uri}`, { ...opt, ...options })
    .then(response => response.data);
}

function post(uri, body = {}) {
  return axios
    .post(`${host}${uri}`, body)
    .then(response => response.data);
}

function authorizedGet({ uri, params = {}, options }) {
  const opt = {
    params,
    headers: buildHeaders(true)
  };
  return axios
    .get(`${host}${uri}`, { ...options, ...opt })
    .then(response => response.data);
}

function authorizedPost({ uri, params, body = {} }) {
  const options = {
    params,
    headers: buildHeaders(true, { "X-CSRFToken": getCookie("csrftoken") })
  };

  return axios
    .post(`${host}${uri}`, body, options)
    .then(response => response.data);
}

// function authorizedDelete({ uri, params }) {
//   const options = {
//     params,
//     headers: buildHeaders(true, { "X-CSRFToken": getCookie("csrftoken") })
//   };
//   return axios.delete(`${host}${uri}`, options).then(response => response.data);
// }

// function authorizedPatch({ uri, params, body = {} }) {
//   const options = {
//     params,
//     headers: buildHeaders(true, { "X-CSRFToken": getCookie("csrftoken") })
//   };
//   return axios
//     .patch(`${host}${uri}`, body, options)
//     .then(response => response.data);
// }

// function authorizedPut({ uri, params, body = {} }) {
//   const options = {
//     params,
//     headers: buildHeaders(true, { "X-CSRFToken": getCookie("csrftoken") })
//   };
//   return axios
//     .put(`${host}${uri}`, body, options)
//     .then(response => response.data);
// }

function authorizedPostUpload({ uri, body = {}, params }) {
  const options = {
    params,
    headers: buildHeaders(true, {
      "content-type": "multipart/form-data",
      "X-CSRFToken": getCookie("csrftoken")
    })
  };
  return axios
    .post(`${host}${uri}`, body, options)
    .then(response => response.data);
}

// export function authorizedFileDownload({ uri }) {
//   const opt = {
//     headers: buildHeaders(true),
//     responseType: "blob"
//   };
//   return axios.get(`${host}${uri}`, { ...opt }).then(response => {
//     const url = window.URL.createObjectURL(new Blob([response.data]));
//     const link = document.createElement("a");
//     link.href = url;

//     const filename_match = response.headers["content-disposition"].match(
//       /filename="(.+)"/
//     );
//     if (filename_match) {
//       link.setAttribute("download", filename_match[1]);
//     } else {
//       link.setAttribute("download", "export.pdf");
//     }

//     document.body.appendChild(link);
//     link.click();
//     window.URL.revokeObjectURL(url);
//     document.body.removeChild(link);
//   });
// }

export function postRegistration(body) {
  return post('/registration', body);
}

export function login(body) {
  return post('/login', body);
}

export function logout() {
  return post('/logout/');
}

export function getUserData() {
  return authorizedPost({ uri: '/user-details/' });
}

export function getSchoolData(params) {
  return authorizedGet({ uri: '/get-school/', params });
}

export function getSchoolDetails(schoolId) {
  return authorizedGet({ uri: `/school-detail/${schoolId}/` });
}

// export function getStudentDetails(studentlId) {
//   return authorizedGet({ uri: `/school-detail/${schoolId}/` });
// }

export function getSchoolEnq(params) {
  return authorizedGet({ uri: `/get-enquiry/`, params });
}