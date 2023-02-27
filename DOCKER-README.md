Start app in docker
-------------------

**Replace the database config with docker database config**

`cp config/docker.database.yml config/database.yml`

```
docker build .

docker compose up

docker-compose run web rails db:create

docker-compose run web rails db:seed

docker-compose run web rails db:migrate

docker-compose run web rails db:seed
```

**Note**: For some reason the cron job fails in the web container
      But running the same command from the container manually works.

      Try logging in to the web container and run this command to generate partners for the month
      $ docker exec -it <container id> /bin/bash 
      $ /bin/bash -l -c 'cd /Rails-Docker && bundle exec bin/rails runner -e development '\''LunchPartner.create_mystery_lunch_for_current_month'\'
