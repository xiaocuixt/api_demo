---
title: API 参考文档

language_tabs:
  - ruby

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# 介绍

API 文档.

# 获取用户信息

## V1

## HTTP 请求

`GET http://localhost:3000/api/v1/users/<id>`

参数名     | 是否必须 | Description
--------- | ------- | -----------
id        | 是      | 用户id

<\```json
{
  "user":
  {
    "id":1,
    "email":"test-user-00@mail.com",
    "name":"test-user-00",
    "activated":"2015-05-02T07:47:14.697Z",
    "admin":false,
    "created_at":"2015-05-02T07:47:14.708Z",
    "updated_at":"2015-05-02T07:47:14.708Z"
   }
}
\```


