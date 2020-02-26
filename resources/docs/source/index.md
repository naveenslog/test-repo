---
title: API Reference

language_tabs:
- bash
- javascript

includes:

search: true

toc_footers:
- <a href='http://github.com/mpociot/documentarian'>Documentation Powered by Documentarian</a>
---
<!-- START_INFO -->
# Info

Welcome to the generated API reference.
[Get Postman Collection](http://localhost/docs/collection.json)

<!-- END_INFO -->

#general


<!-- START_0c068b4037fb2e47e71bd44bd36e3e2a -->
## Authorize a client to access the user&#039;s account.

> Example request:

```bash
curl -X GET \
    -G "http://localhost/oauth/authorize" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/authorize"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET oauth/authorize`


<!-- END_0c068b4037fb2e47e71bd44bd36e3e2a -->

<!-- START_e48cc6a0b45dd21b7076ab2c03908687 -->
## Approve the authorization request.

> Example request:

```bash
curl -X POST \
    "http://localhost/oauth/authorize" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/authorize"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST oauth/authorize`


<!-- END_e48cc6a0b45dd21b7076ab2c03908687 -->

<!-- START_de5d7581ef1275fce2a229b6b6eaad9c -->
## Deny the authorization request.

> Example request:

```bash
curl -X DELETE \
    "http://localhost/oauth/authorize" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/authorize"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "DELETE",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`DELETE oauth/authorize`


<!-- END_de5d7581ef1275fce2a229b6b6eaad9c -->

<!-- START_a09d20357336aa979ecd8e3972ac9168 -->
## Authorize a client to access the user&#039;s account.

> Example request:

```bash
curl -X POST \
    "http://localhost/oauth/token" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/token"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST oauth/token`


<!-- END_a09d20357336aa979ecd8e3972ac9168 -->

<!-- START_d6a56149547e03307199e39e03e12d1c -->
## Get all of the authorized tokens for the authenticated user.

> Example request:

```bash
curl -X GET \
    -G "http://localhost/oauth/tokens" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/tokens"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET oauth/tokens`


<!-- END_d6a56149547e03307199e39e03e12d1c -->

<!-- START_a9a802c25737cca5324125e5f60b72a5 -->
## Delete the given token.

> Example request:

```bash
curl -X DELETE \
    "http://localhost/oauth/tokens/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/tokens/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "DELETE",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`DELETE oauth/tokens/{token_id}`


<!-- END_a9a802c25737cca5324125e5f60b72a5 -->

<!-- START_abe905e69f5d002aa7d26f433676d623 -->
## Get a fresh transient token cookie for the authenticated user.

> Example request:

```bash
curl -X POST \
    "http://localhost/oauth/token/refresh" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/token/refresh"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST oauth/token/refresh`


<!-- END_abe905e69f5d002aa7d26f433676d623 -->

<!-- START_babcfe12d87b8708f5985e9d39ba8f2c -->
## Get all of the clients for the authenticated user.

> Example request:

```bash
curl -X GET \
    -G "http://localhost/oauth/clients" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/clients"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET oauth/clients`


<!-- END_babcfe12d87b8708f5985e9d39ba8f2c -->

<!-- START_9eabf8d6e4ab449c24c503fcb42fba82 -->
## Store a new client.

> Example request:

```bash
curl -X POST \
    "http://localhost/oauth/clients" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/clients"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST oauth/clients`


<!-- END_9eabf8d6e4ab449c24c503fcb42fba82 -->

<!-- START_784aec390a455073fc7464335c1defa1 -->
## Update the given client.

> Example request:

```bash
curl -X PUT \
    "http://localhost/oauth/clients/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/clients/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "PUT",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`PUT oauth/clients/{client_id}`


<!-- END_784aec390a455073fc7464335c1defa1 -->

<!-- START_1f65a511dd86ba0541d7ba13ca57e364 -->
## Delete the given client.

> Example request:

```bash
curl -X DELETE \
    "http://localhost/oauth/clients/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/clients/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "DELETE",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`DELETE oauth/clients/{client_id}`


<!-- END_1f65a511dd86ba0541d7ba13ca57e364 -->

<!-- START_9e281bd3a1eb1d9eb63190c8effb607c -->
## Get all of the available scopes for the application.

> Example request:

```bash
curl -X GET \
    -G "http://localhost/oauth/scopes" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/scopes"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET oauth/scopes`


<!-- END_9e281bd3a1eb1d9eb63190c8effb607c -->

<!-- START_9b2a7699ce6214a79e0fd8107f8b1c9e -->
## Get all of the personal access tokens for the authenticated user.

> Example request:

```bash
curl -X GET \
    -G "http://localhost/oauth/personal-access-tokens" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/personal-access-tokens"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET oauth/personal-access-tokens`


<!-- END_9b2a7699ce6214a79e0fd8107f8b1c9e -->

<!-- START_a8dd9c0a5583742e671711f9bb3ee406 -->
## Create a new personal access token for the user.

> Example request:

```bash
curl -X POST \
    "http://localhost/oauth/personal-access-tokens" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/personal-access-tokens"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST oauth/personal-access-tokens`


<!-- END_a8dd9c0a5583742e671711f9bb3ee406 -->

<!-- START_bae65df80fd9d72a01439241a9ea20d0 -->
## Delete the given token.

> Example request:

```bash
curl -X DELETE \
    "http://localhost/oauth/personal-access-tokens/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/oauth/personal-access-tokens/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "DELETE",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`DELETE oauth/personal-access-tokens/{token_id}`


<!-- END_bae65df80fd9d72a01439241a9ea20d0 -->

<!-- START_c3fa189a6c95ca36ad6ac4791a873d23 -->
## login api

> Example request:

```bash
curl -X POST \
    "http://localhost/api/login" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/login"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/login`


<!-- END_c3fa189a6c95ca36ad6ac4791a873d23 -->

<!-- START_d7b7952e7fdddc07c978c9bdaf757acf -->
## Register api

> Example request:

```bash
curl -X POST \
    "http://localhost/api/register" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/register"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/register`


<!-- END_d7b7952e7fdddc07c978c9bdaf757acf -->

<!-- START_ee3aaa1cbf023e52d44f748dbed08991 -->
## api/get-school
> Example request:

```bash
curl -X GET \
    -G "http://localhost/api/get-school" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/get-school"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
{
    "success": [
        {
            "name": "DPSdfafafasfs",
            "user_type": "student",
            "id": 7,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "54674747474",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 4
        },
        {
            "name": "DPS",
            "user_type": "student",
            "id": 6,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "54674747474",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 4
        },
        {
            "name": "DPS",
            "user_type": "student",
            "id": 5,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "54674747474",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 4
        },
        {
            "name": "DPS",
            "user_type": "student",
            "id": 4,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "6563636363",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 4
        },
        {
            "name": "DPS",
            "user_type": "student",
            "id": 3,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "6563636363",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 4
        },
        {
            "name": "DPS",
            "user_type": "student",
            "id": 2,
            "admission_status": null,
            "about": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "email": "pradipdsaff.comat@appypiellp.com",
            "phone": "6563636363",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "fee_structure": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "course_detail": "In the first step, we require to get fresh Laravel application using below command, So open your terminal OR command prompt and run below command:",
            "rating": 0
        },
        {
            "name": "pradip",
            "user_type": "student",
            "id": 1,
            "admission_status": null,
            "about": "fdafafasfaf",
            "email": "pradip.comat@appypiellp.com",
            "phone": "6563636363",
            "admission": null,
            "add_line1": "Noida",
            "add_line2": null,
            "area_code": null,
            "user_id": 1,
            "scholarship": null,
            "fee_structure": null,
            "course_detail": null,
            "rating": 0
        }
    ]
}
```

### HTTP Request
`GET api/get-school`


<!-- END_ee3aaa1cbf023e52d44f748dbed08991 -->

<!-- START_05856c67b47cd161112e3588c3e1f99e -->
## api/school-detail
> Example request:

```bash
curl -X POST \
    "http://localhost/api/school-detail" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/school-detail"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/school-detail`


<!-- END_05856c67b47cd161112e3588c3e1f99e -->

<!-- START_6dd84b1d4bba277343b6cc0ff66ca21e -->
## details api

> Example request:

```bash
curl -X POST \
    "http://localhost/api/user-details" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/user-details"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/user-details`


<!-- END_6dd84b1d4bba277343b6cc0ff66ca21e -->

<!-- START_e8844b1cdf0435fb4e154546e8faefcf -->
## registerSchool api

> Example request:

```bash
curl -X POST \
    "http://localhost/api/post-school" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/post-school"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/post-school`


<!-- END_e8844b1cdf0435fb4e154546e8faefcf -->

<!-- START_c9aa647d7f62e3f4329e4e2834bf1d97 -->
## api/student-save-school
> Example request:

```bash
curl -X POST \
    "http://localhost/api/student-save-school" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/student-save-school"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST api/student-save-school`


<!-- END_c9aa647d7f62e3f4329e4e2834bf1d97 -->

<!-- START_80612b9f2d2a6b1b874ea68a2c030767 -->
## api/get-school-saved-by-student
> Example request:

```bash
curl -X GET \
    -G "http://localhost/api/get-school-saved-by-student" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/api/get-school-saved-by-student"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (401):

```json
{
    "message": "Unauthenticated."
}
```

### HTTP Request
`GET api/get-school-saved-by-student`


<!-- END_80612b9f2d2a6b1b874ea68a2c030767 -->


