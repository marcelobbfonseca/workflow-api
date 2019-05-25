FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y nodejs 

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install rails -v 5.1
RUN bundle install
COPY . /app
EXPOSE 3000

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]

# https://docs.docker.com/compose/rails/