README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://warm-spire-6158.herokuapp.com`

CREATE USER
-----------
`STATUS 201 CREATED`
from
`POST [domain]/users`

data:
```
"user": {
  "email": "macho_man_alan_matthews@gmail.com",
  "password": "nachooooescheese"
}
```

sample response:
```
{
    "user": {
        "email": "macho_man_alan_matthews@gmail.com",
        "authentication_token": "GhBPRwKabKQX2wLzwU56"
    }
}
```

USER SIGN IN
------------
`STATUS 200 OK`
from
`POST [domain]/users/sign_in`

data:
```
"user": {
  "email": "macho_man_alan_matthews@gmail.com",
  "password": "nachooooescheese",
  "token_auth": "GhBPRwKabKQX2wLzwU5"
}
```
sample response:
```
{
    "user": {
        "email": "macho_man_alan_matthews@gmail.com",
        "authentication_token": "GhBPRwKabKQX2wLzwU56"
    }
}
```

cool deal.