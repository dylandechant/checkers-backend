README
======

This is where the API docs will lie from here on out unless we decide to change
to somewhere else, but here goes:
our url for now is here: `https://warm-spire-6158.herokuapp.com`


FINISHED
===========

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
CREATE GAMES
------------
`STATUS 201 CREATED`
from
`POST [domain]/games/create`

data:
```
{
    "game": {
        "auth_token": "GhBPRwKabKQX2wLzwU56"
    }
}
```
sample response:
```
{
    "game": {
        "id": 2,
        "board": [
            [
                1,
                0,
                1,
                0,
                1,
                0,
                1,
                0
            ],
            [
                0,
                1,
                0,
                1,
                0,
                1,
                0,
                1
            ],
            [
                1,
                0,
                1,
                0,
                1,
                0,
                1,
                0
            ],
            [
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
            ],
            [
                0,
                2,
                0,
                2,
                0,
                2,
                0,
                2
            ],
            [
                2,
                0,
                2,
                0,
                2,
                0,
                2,
                0
            ],
            [
                0,
                2,
                0,
                2,
                0,
                2,
                0,
                2
            ]
        ],
        "turn": null,
        "winner": null,
        "loser": null,
        "finished": false,
        "players_count": null
    }
}

JOIN GAMES
----------
`STATUS 200 OK`
from
`POST [domain]/games/join`

data:
```
{
    "game": {
        "auth_token": "GhBPRwKabKQX2wLzwU56"
    }
}

```
sample response:
```

{
    "game": {
        "id": 3,
        "board": [
            [
                1,
                0,
                1,
                0,
                1,
                0,
                1,
                0
            ],
            [
                0,
                1,
                0,
                1,
                0,
                1,
                0,
                1
            ],
            [
                1,
                0,
                1,
                0,
                1,
                0,
                1,
                0
            ],
            [
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
            ],
            [
                0,
                2,
                0,
                2,
                0,
                2,
                0,
                2
            ],
            [
                2,
                0,
                2,
                0,
                2,
                0,
                2,
                0
            ],
            [
                0,
                2,
                0,
                2,
                0,
                2,
                0,
                2
            ]
        ],
        "turn": null,
        "winner": null,
        "loser": null,
        "finished": false,
        "players_count": null
    }
}
```

cool deal.