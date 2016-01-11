# The Collaborative GIF Cloud #

## Configuring the Development Environment ##

### Dependencies ###

+ Postgres. Installing in OS X via Homebrew (`brew install postgres`) works.

+ [Docker Compose](https://docs.docker.com/compose/).

+ [ceph-compose-docker](https://github.com/ohsu-computational-biology/ceph-docker-compose).
  You need to run this in your development. Please read the documentation and
  make sure to specify the `MON_IP` and `CEPH_NETWORK` environment variables.
  Please use [Pow](https://pow.cx) to route traffic to you local Ceph instance
  via [http://ceph.dev](http://ceph.dev). This can easily be done via:

    ```
      echo http://$(docker-machine ip ceph) > ~/.pow/ceph
    ```

+ [Elasticsearch](https://www.elastic.co/). Installing in OS X via Homebrew
  (`brew install elasticsearch`) works.

### Running the server ###

1. Install Ruby (2.2.2+). If on OS X, this is easy to do via `rbenv`
  (`brew install rbenv`) by running `rbenv install 2.2.4`.

2. Install Rails dependencies with `bundle install`.

3. Run `bin/rake db:create db:migrate` to run database migrations.

4. Run `bin/rake elasticsearch:import:all FORCE=t` to create Elasticsearch
  indexes.

5. Run `bin/rails s` to start the server on
   [http://localhost:3000](http://localhost:3000).

6. After signing up in the app, run `bin/rake db:seed` to import data.
