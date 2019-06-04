hubot-keybase-encrypt
=============

:warning: `hubot-keybase` was renamed to `hubot-keybase-encrypt` from v0.1.1. [hubot-keybase] is now official Hubot adapter.

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
  ["hubot-keybase-encrypt"]
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
[travis-badge]: https://travis-ci.org/ngs/hubot-keybase-encrypt.svg?branch=master
[npm-badge]: http://img.shields.io/npm/v/hubot-keybase-encrypt.svg
[travis]: https://travis-ci.org/ngs/hubot-keybase-encrypt
[npm]: https://www.npmjs.org/package/hubot-keybase-encrypt
[Keybase]: https://keybase.io
[hubot-keybase]: https://www.npmjs.com/package/hubot-keybase