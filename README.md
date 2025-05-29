# 🎮 HitBox - Game Collection Manager

HitBox is a web application designed for game enthusiasts to organize and share their game collections (playlists). With its integration of Symfony 7 and Vue.js 3, HitBox provides a smooth experience for managing your gaming library.

## 📑 Table of contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Development Commands](#development-commands)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)
- [Authors](#authors)
- [Acknowledgments](#acknowledgments)

## 🌟 Features

- **Game collection management**: Create and organize your personal game playlists.
- **Playlist sharing**: Share your playlists with the community.
- **Game reviews**: Note and review your games.
- **User profiles**: Set up and manage your profile.
- **Modern UI**: Clean and responsive design for a smooth user experience.
- **API-First architecture**: A RESTful API ensuring seamless communication between frontend and backend.

## 🛠️ Tech stack

### Backend
- **Symfony 7.3**
- **PHP 8.4**
- **PostgreSQL 17.4**
- **PHP-FPM**

### Frontend
- **Vue.js 3**
- **TailwindCSS**
- **TypeScript**
- **Pinia** (state management)
- **Vue Router**
- **Vitest**

### Development tools
- **Docker & Docker Compose**
- **npm**
- **Vite** (front build)
- **Git**

## 🚀 Getting started

### **Prerequisites**
Before you begin, make sure you have the following installed:
- **Docker** and **Docker Compose**.
- **Git**.

### Installation

1. Clone the repository:
```bash
git clone https://gitlab.com/ko-technique/ez_hitbox.git HitBox
cd HitBox
```

2. Initialize the project by running the setup script:
```bash
chmod +x dev.sh
./dev.sh init
```

3. Start the development containers:
```bash
./dev.sh start
```

4. Install dependancies:
```bash
./dev.sh backend
composer install
exit
./dev.sh frontend
npm install
exit
```

5. Start front: 
```bash
./dev.sh frontend
npm run dev -- --host --port 3000
```

6. Access the application locally:
    - Frontend: [http://localhost:3000](http://localhost:3000)
    - Backend API: [http://localhost:8080/api](http://localhost:8080/api)
    - Nginx: [http://localhost:8080](http://localhost:8080) or [https://localhost:8443](https://localhost:8443)

### Development commands

The project includes a convenient script (`dev.sh`) with the following commands to help you during development:

```bash
./dev.sh init           # Initialize the project setup
./dev.sh start          # Start all containers (backend, frontend, postgres)
./dev.sh stop           # Stop all containers
./dev.sh restart        # Restart all containers
./dev.sh status         # Check status of containers
./dev.sh logs           # View logs from all running containers
./dev.sh logs:backend   # View backend container logs
./dev.sh logs:frontend  # View frontend container logs
./dev.sh logs:db        # View database container logs
./dev.sh logs:nginx     # View nginx container logs
./dev.sh backend        # Access the backend container's shell
./dev.sh frontend       # Access the frontend container's shell
./dev.sh db             # Access the PostgreSQL shell
./dev.sh migrate        # Run database migrations
./dev.sh backup:db      # Create a backup of the database
./dev.sh restore:db     # Restore database from backup
./dev.sh clean          # Clean up unused containers and volumes
./dev.sh test:backend   # Run backend tests
./dev.sh test:frontend  # Run frontend tests
```

## 📁 Project structure

The project's directory structure is as follows:

```
hitbox/
├── backend/           # Symfony backend application
├── frontend/          # Vue.js frontend application
├── docker/            # Docker configuration files
│   ├── nginx/         # Nginx configuration
│   ├── backend/       # Backend container configuration
│   ├── frontend/      # Frontend container configuration
│   └── postgres/      # PostgreSQL container configuration
├── database/          # Database-related files
│   ├── backups/       # Database backup files
│   └── scripts/       # SQL initialization scripts
└── documentation/     # Project-related documentation
```

## 🔧 Configuration

### Backend configuration
After installing Symfony, you need to configure your `.env` file in the Backend directory:

```env
# Backend/.env
DATABASE_URL="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?serverVersion=17.4&charset=utf8"
APP_ENV=dev
APP_SECRET=your_secret_here
CORS_ALLOW_ORIGIN='^https?://(localhost|127\.0\.0\.1)(:[0-9]+)?$'
```

### Frontend configuration
Create environment files for the frontend:

```env
# Frontend/.env
VITE_API_URL=http://localhost:8080/api
```

## 🧪 Testing

### Backend tests
To run the backend tests:
```bash
./dev.sh test:backend
```

Or manually by accessing the backend container:
```bash
./dev.sh backend
php bin/phpunit
```

### Frontend tests
To run the frontend tests:
```bash
./dev.sh test:frontend
```

Or manually by accessing the frontend container:
```bash
./dev.sh frontend
npm test
```

## 📦 Database management

### Migrations
To run database migrations:
```bash
./dev.sh migrate
```

### Backup and Restore
The project includes convenient commands to backup and restore your database:

```bash
# Create a database backup
./dev.sh backup:db

# Restore from the most recent backup
./dev.sh restore:db

# Restore from a specific backup
./dev.sh restore:db backup_filename.sql
```

Backups are stored in the `database/backups/` directory.

## 📝 Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add an amazing feature'`)
4. Push to your branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request for review

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 👥 Authors

- [Celia](https://github.com/cetrl) - *Conception, development, and deployment - Frontend artist*
- [Hidouen](https://github.com/hidouen) - *Conception, development, and deployment - Backend optimizer*

## 🙏 Acknowledgments

- **Symfony** team for the incredible framework.
- **Vue.js** team for providing a modern, reactive frontend framework.
- All contributors who help improve this project.