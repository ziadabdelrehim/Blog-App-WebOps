# Use the official Ruby image
FROM ruby:3.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Add the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install gems
RUN bundle install

# Add the rest of the application code
COPY . /app

# Expose port 3000
EXPOSE 3000

# Start the Rails server by default
CMD ["rails", "server", "-b", "0.0.0.0"]
