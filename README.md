# Blog Application with Ruby on Rails

This repository contains a blog application built with Ruby on Rails, Docker, Redis, and Sidekiq. It includes features such as user authentication, post management, and background job processing.

## Features

- **User Authentication**: Secure sign-up, login, and session management using JWT.
- **Post Management**: Create, edit, and delete posts with tagging and commenting functionality.
- **Redis Integration**: Session storage and caching with Redis for improved performance.
- **Sidekiq Integration**: Background job processing to handle asynchronous tasks.
- **Docker Support**: Easily deploy and manage the application with Docker Compose.

## Technologies Used

- **Ruby on Rails**: Web framework for building the application.
- **PostgreSQL**: Database management system.
- **Redis**: In-memory data store for caching and session management.
- **Sidekiq**: Framework for background job processing.
- **Docker**: Platform for containerizing and managing application dependencies.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your machine.

### Setup

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/ziadabdelrehim/Blog-App-WebOps.git
    cd Blog-App-WebOps
    ```

2. **Configure Environment Variables**:

    Create a `.env` file in the root directory with the following environment variables:

    ```bash
    REDIS_URL=redis://redis:6379/1
    DATABASE_URL=postgres://postgres:05kickass@db:5432/Blog_development
    ```

3. **Build and Start Containers**:

    ```bash
    docker-compose up --build
    ```

4. **Access the Application**:

    Open your web browser and navigate to `http://localhost:3000` to use the application.

## Running Tests

To run the test suite, execute the following command:

```bash
docker-compose run web bundle exec rspec
