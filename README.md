# 🎮 HitBox - Game Collection Manager

HitBox is a web application designed for game enthusiasts to organize and share their game collections (playlists). With its integration of Symfony 7 and Vue.js 3, HitBox provides a smooth experience for managing your gaming library.

## 📑 Table of Contents

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
- **Symfony 7.2**
- **PHP 8.4**
- **PostgreSQL 17.4**
- **PHP-FPM**
- **Nginx**

### Frontend
- **Vue.js 3**
- **TailwindCSS**
- **TypeScript**
- **Pinia** (state management)
- **Vue Router**
- **Vitest** (testing)

### Development tools
- **Docker & Docker Compose** (for containerization)
- **npm** (package manager)
- **Vite** (front build)
- **Git** (version control)

## 🚀 Getting started

### **Prerequisites**
Before you begin, make sure you have the following installed:
- **Docker** and **Docker Compose**.
- **Git**.

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Hidouen/HitBox_Init HitBox
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

4. Initialize the Symfony backend project:
    ```bash
    # Access the backend container
    ./dev.sh backend

    # Create new Symfony project
    composer create-project symfony/skeleton:"7.2.*" .

    # Install additional packages as needed
    composer require symfony/orm-pack
    composer require --dev symfony/maker-bundle
    composer require symfony/runtime
    composer require symfony/apache-pack
    composer require symfony/validator
    composer require symfony/serializer
    composer require symfony/security-bundle
    composer require lexik/jwt-authentication-bundle
    composer require nelmio/cors-bundle
    composer require --dev symfony/test-pack

    # Set proper permissions
    chown -R www-data:www-data var
    chmod -R 777 var

    # Exit the container
    exit
    ```

5. Initialize the Vue.js frontend project:
    ```bash
    # Access the frontend container
    ./dev.sh frontend

    # Create a new Vue project with recommended settings
    npm create vue@latest .

    # Install dependencies
    npm install

    # Start the development server
    npm run dev -- --host --port 3000
    ```

5. Access the application locally:
    - Frontend: [http://localhost:3000](http://localhost:3000)
    - Backend API: [http://localhost:8080/api](http://localhost:8080/api)
    - Nginx: [http://localhost:8080](http://localhost:8080) or [https://localhost:8443](https://localhost:8443)

### Development commands

The project includes a convenient script (`dev.sh`) with the following commands to help you during development:

```bash
./dev.sh init     # Initialize the project setup
./dev.sh start    # Start all containers (backend, frontend, postgres)
./dev.sh stop     # Stop all containers
./dev.sh logs     # View logs from running containers
./dev.sh backend  # Access the backend container's shell
./dev.sh frontend # Access the frontend container's shell
./dev.sh db       # Access the PostgreSQL shell
```

## 📁 Project structure

The project's directory structure is as follows:

```
hitbox/
├── backend/           # Symfony backend application
├── frontend/          # Vue.js frontend application
├── config/            # Configuration files for Docker
│   ├── nginx/         # Nginx configuration
│   ├── backend/       # Backend container configuration
│   ├── frontend/      # Frontend container configuration
│   └── postgres/      # PostgreSQL container configuration
├── database/          # Database-related files
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
To run the backend tests, first access the backend container, then run PHPUnit:
```bash
./dev.sh backend
php bin/phpunit
```

### Frontend tests
To run the frontend tests, first access the frontend container, then use Vitest:
```bash
./dev.sh frontend
npm test
```

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