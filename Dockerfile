# Base image
FROM ruby:2.7.2

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y sqlite3 libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]