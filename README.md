## 使用说明


### 环境变量

#### `RACK_ENV`

- `development`(default)
- `production`

#### `APP_LOGGER_LEVEL`

- `info` (default)
- `debug`

#### `APP_PUMA_TIMEOUT`

- 180 (default)

#### `APP_PUMA_MIN_THREAD`

- 1 (default)

#### `APP_PUMA_MAX_THREAD`

- 3 (default)


### 使用

传递数组 data 参数，转化成 xls

```ruby
result = RestClient::Request.execute({
  method: :post,
  url: 'http://localhost:9292/array',
  raw_response: true,
  payload: {'filename' => 'text.xls', 'data' => [['test']]}.to_json,
  headers: {content_type: :json, accept: :json}
})
```

上传 csv 文件，转化为 xls

```ruby
# 生成一个 csv 文件
file = Tempfile.new
file.write <<-EOF
1,2
3,4
EOF

file.close

# 上传 csv 文件
result = RestClient::Request.execute({
  method: :post,
  url: 'http://localhost:9292/csv',
  raw_response: true,
  payload: {'filename' => 'test.xls', 'file' => File.open(file, r)}.to_json,
  headers: {content_type: :json, accept: :json}
})
```


### `docker-compose` 运行参考

```
version: '3'

services:
  spreadsheet-microservice:
    image: agideo/spreadsheet-microservice:latest
```
