# hotels-data-polisher

#### Prerequisites
* Ruby version
```
3.2.2
```
* Rails version
```
7.1.2
```
* bundler
* postgres
* redis


#### Configuration
```sh
$ bundle install
```

#### Database creation
```sh
$ rake db:migrate

$ rails db:seed

$ rake setup:hotels_updater_and_polisher

```

#### Start application
* Start Database connection
```sh
$ /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgresql@14
```

* Start redis
```sh
$ redis-server
```

* Start Sidekiq
```sh
$ bundle exec sidekiq
```

* Start server
```sh
$ rails s
```

* API:
```
{host}/api/v1/hotels
```
query: `id` or `destination_id` this can be single or array.

For example:
```
http://localhost:3000/api/v1/hotels?id=iJhz
```
or
```
http://localhost:3000/api/v1/hotels?id[]=iJhz&id[]=SjyX
```

#### Optimization
```
On top of what I have implemented, we can consider:
 - Elastisearch or Typesense as a database storage, this can help to boost speed of data retrieval or scalability
```

