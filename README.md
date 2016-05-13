hubot-keybase
=============

[![Build Status][travis-badge]][travis]
[![npm-version][npm-badge]][npm]

A [Hubot] script that encrypts messages for [Keybase] users.

```
$ hubot keybase encrypt:ngs Hi there!

-----BEGIN PGP MESSAGE-----
Version: OpenPGP.js v2.3.0
Comment: http://openpgpjs.org

wcBMA2GjYRB9O5DgA...(snip)
-----END PGP MESSAGE-----
```

Command
--------

```
hubot keybase encrypt:<keybase_user_name> <any_message_here>
```

Installation
------------

1. Add `hubot-keybase` to dependencies.

  ```bash
  npm install --save hubot-keybase
  ```

2. Update `external-scripts.json`

  ```json
  ["hubot-keybase"]
  ```

Author
------

[Atsushi Nagase]

License
-------

[MIT License]


[Hubot]: http://hubot.github.com/
[Atsushi Nagase]: http://ngs.io/
[MIT License]: LICENSE
[travis-badge]: https://travis-ci.org/ngs/hubot-keybase.svg?branch=master
[npm-badge]: http://img.shields.io/npm/v/hubot-keybase.svg
[travis]: https://travis-ci.org/ngs/hubot-keybase
[npm]: https://www.npmjs.org/package/hubot-keybase
[Keybase]: https://keybase.io
