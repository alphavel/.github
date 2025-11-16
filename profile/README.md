<p align="center"><a href="https://github.com/alphavel/alphavel" target="_blank"><img src="./logo.png" width="160" alt="Alphavel Logo"></a><h1 align="center">Alphavel</h1></p>


<p align="center">
<a href="https://packagist.org/packages/alphavel/core"><img src="https://img.shields.io/packagist/v/alphavel/core" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/alphavel/core"><img src="https://img.shields.io/packagist/dt/alphavel/core" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/alphavel/core"><img src="https://img.shields.io/packagist/l/alphavel/core" alt="License"></a>
<a href="https://packagist.org/packages/alphavel/core"><img src="https://img.shields.io/packagist/php-v/alphavel/core" alt="PHP Version"></a>
</p>

## About Alphavel

Alphavel is a high-performance PHP framework built on top of Swoole, designed for developers who demand speed without sacrificing elegant syntax. We believe that building modern web applications should be fast, efficient, and enjoyable. Alphavel achieves exceptional performance while maintaining a developer-friendly API similar to Laravel:

- [Simple, intuitive routing engine](https://github.com/alphavel/alphavel) with support for REST APIs.
- [Powerful dependency injection container](https://github.com/alphavel/alphavel) with PSR-11 compliance.
- Multiple back-ends for [cache](https://github.com/alphavel/cache) storage (Redis, File).
- Expressive, Laravel-inspired [database ORM](https://github.com/alphavel/database) with Active Record pattern.
- [Modular architecture](https://github.com/alphavel/alphavel) - load only what you need.
- [Auto-discovery system](https://github.com/alphavel/alphavel) for service providers via Composer.
- [PSR-compliant implementation](https://github.com/alphavel/alphavel) (PSR-1, PSR-3, PSR-4, PSR-11, PSR-12).

Alphavel is accessible, powerful, and provides the tools required for high-performance applications handling millions of requests per day.

## Performance

Alphavel delivers exceptional performance thanks to Swoole's event-driven, asynchronous architecture:

| Framework | Req/s | Memory | Response Time |
|-----------|-------|--------|---------------|
| **Alphavel (core)** | **520,000** | **0.3 MB** | **0.19 ms** |
| Alphavel (full stack) | 387,000 | 4.0 MB | 0.26 ms |
| HyperF | 170,000 | 2.1 MB | 0.59 ms |
| Laravel Octane | 8,500 | 12 MB | 2.4 ms |
| Laravel (FPM) | 1,200 | 15 MB | 8.3 ms |

**12.6x faster than Laravel** • **13.7x faster than Symfony** • **520,000+ requests per second**

## Learning Alphavel

Alphavel provides comprehensive [documentation](https://github.com/alphavel/alphavel) covering all aspects of the framework. The documentation is thorough and makes it easy to get started building high-performance applications.

Key documentation resources:

- [Installation Guide](https://github.com/alphavel/alphavel#installation) - Get up and running in minutes.
- [Routing](https://github.com/alphavel/alphavel#routing) - Learn how to define routes and handle requests.
- [Database](https://github.com/alphavel/database) - Work with databases using the expressive query builder.
- [Facades](https://github.com/alphavel/alphavel#facades) - Understand auto-generated facades with zero overhead.
- [Performance Optimization](https://github.com/alphavel/alphavel) - Tips for maximizing application performance.

The framework's modular design means you can start with just the core and add features as needed, keeping your application lean and fast.

## Installation

```bash
composer create-project alphavel/skeleton my-app
cd my-app
php alphavel serve
```

### Add to Existing Project

```bash
composer require alphavel/alphavel
```

## Quick Start

Create your first Alphavel application:

```php
<?php

require __DIR__ . '/vendor/autoload.php';

use Alphavel\Framework\Application;
use Alphavel\Framework\Request;
use Alphavel\Framework\Response;

$app = Application::getInstance(__DIR__);

$app->get('/', function (Request $request) {
    return Response::json(['message' => 'Hello Alphavel!']);
});

$app->get('/users/{id}', function (Request $request, $id) {
    return Response::json(['user_id' => $id]);
});

$app->run();
```

Start the development server:

```bash
./alphavel serve
# Server running at http://localhost:8080
```

Test your application:

```bash
curl http://localhost:8080/
# {"message":"Hello Alphavel!"}
```

## Documentation

### Facades

Alphavel provides zero-overhead static proxies to container services:

```php
use Cache;
use DB;
use Log;
use Event;

// Cache
$users = Cache::remember('users', 300, fn() => 
    User::where('active', true)->get()
);

// Database
$results = DB::table('users')
    ->where('age', '>', 18)
    ->get();

// Logging (PSR-3)
Log::info('User logged in', ['user_id' => 123]);
Log::error('Something went wrong');

// Events
Event::listen('user.created', function($user) {
    Log::info('New user', ['id' => $user->id]);
});

Event::dispatch('user.created', $user);
```

### Database & Models

Alphavel includes a Laravel-inspired Active Record implementation:

```php
use App\Models\Post;

// Find
$post = Post::find(1);
$posts = Post::all();

// Query Builder
$posts = Post::where('status', 'published')
    ->where('views', '>', 1000)
    ->orderBy('created_at', 'DESC')
    ->limit(10)
    ->get();

// Create
$post = Post::create([
    'title' => 'New Post',
    'content' => 'Content here'
]);

// Update
$post = Post::find(1);
$post->title = 'Updated Title';
$post->save();

// Delete
$post->delete();
```

### Routing

```php
// GET request
$app->get('/users', [UserController::class, 'index']);

// POST request
$app->post('/users', [UserController::class, 'store']);

// Route parameters
$app->get('/users/{id}', [UserController::class, 'show']);

// Route groups with middleware
$app->group([
    'prefix' => '/api', 
    'middleware' => [AuthMiddleware::class]
], function ($app) {
    $app->get('/profile', [ProfileController::class, 'show']);
    $app->put('/profile', [ProfileController::class, 'update']);
});
```

### Validation

```php
use Alphavel\Validation\Validator;

$validator = new Validator($request->all(), [
    'email' => 'required|email',
    'password' => 'required|min:8',
    'age' => 'required|integer|min:18',
    'role' => 'in:admin,user,guest',
]);

if (!$validator->validate()) {
    return Response::error('Validation failed', 422, $validator->errors());
}
```

## Architecture

### Modular Structure

```
alphavel/
├── packages/              # 7 modular packages
│   ├── core/             # Required (520k req/s)
│   ├── database/         # Optional (-40k req/s)
│   ├── cache/            # Optional (-5k req/s)
│   ├── validation/       # Optional (-3k req/s)
│   ├── events/           # Optional (-2k req/s)
│   ├── logging/          # Optional (-1k req/s)
│   └── support/          # Optional (-2k req/s)
│
├── app/
│   ├── Controllers/      # HTTP controllers
│   ├── Models/          # Active Record models
│   ├── Middlewares/     # HTTP middlewares
│   └── Console/         # CLI commands
│
├── storage/
│   ├── framework/       # Auto-generated facades
│   ├── cache/          # Provider & config cache
│   └── logs/           # Application logs
│
├── docs/               # Documentation
│   ├── EXTENSIBILITY.md
│   ├── FACADES.md
│   ├── PERFORMANCE-OPTIMIZATION.md
│   └── PSR-COMPLIANCE.md
│
└── composer.json       # Modular autoloading
```

### Available Packages

| Package | Description | Version |
|--------|-----------|--------|
| [alphavel/alphavel](https://github.com/alphavel/alphavel) | Framework core components | [![Latest](https://img.shields.io/packagist/v/alphavel/alphavel)](https://packagist.org/packages/alphavel/alphavel) |
| [alphavel/database](https://github.com/alphavel/database) | Database & Query Builder | [![Latest](https://img.shields.io/packagist/v/alphavel/database)](https://packagist.org/packages/alphavel/database) |
| [alphavel/cache](https://github.com/alphavel/cache) | Cache layer (Redis, etc) | [![Latest](https://img.shields.io/packagist/v/alphavel/cache)](https://packagist.org/packages/alphavel/cache) |
| [alphavel/validation](https://github.com/alphavel/validation) | Request validation | [![Latest](https://img.shields.io/packagist/v/alphavel/validation)](https://packagist.org/packages/alphavel/validation) |
| [alphavel/events](https://github.com/alphavel/events) | Event dispatcher | [![Latest](https://img.shields.io/packagist/v/alphavel/events)](https://packagist.org/packages/alphavel/events) |
| [alphavel/logging](https://github.com/alphavel/logging) | PSR-3 Logger | [![Latest](https://img.shields.io/packagist/v/alphavel/logging)](https://packagist.org/packages/alphavel/logging) |
| [alphavel/support](https://github.com/alphavel/support) | Support utilities | [![Latest](https://img.shields.io/packagist/v/alphavel/support)](https://packagist.org/packages/alphavel/support) |

## CLI Commands

Alphavel includes powerful command-line tools:

```bash
# Generate files
./alphavel make:controller UserController
./alphavel make:model User
./alphavel make:middleware AuthMiddleware
./alphavel make:command SendEmails
./alphavel make:test UserTest

# Cache and optimization
./alphavel config:cache
./alphavel route:cache
./alphavel optimize

# Clear cache
./alphavel config:clear
./alphavel route:clear
./alphavel clear:all

# Utilities
./alphavel route:list
./alphavel ide-helper:generate
```

**Test Environment:** Intel i7, 16GB RAM, PHP 8.3, Swoole 5.1

| Framework | Req/s | Memória | Config |
|-----------|-------|---------|--------|
| alphavel (core only) | 520,000 | 0.3MB | Minimal |
| alphavel (core + DB) | 480,000 | 1.2MB | Database |
| alphavel (all plugins) | 387,000 | 4.0MB | Full stack |
| HyperF | 170,000 | 2.1MB | Full |
| Laravel Octane | 8,500 | 12MB | Full |
| Laravel FPM | 1,200 | 15MB | Full |

### Why So Fast?

- **Swoole** - Event-driven, asynchronous, coroutine-based architecture
- **No Bootstrap Overhead** - Application stays resident in memory
- **Optimized Autoloading** - Minimal file I/O operations
- **Zero-Config Facades** - Generated once, cached forever
- **Lean Core** - Load only what you need, when you need it

## Deployment

### Docker

```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "8080:8080"
    command: php alphavel serve
```

```dockerfile
# Dockerfile
FROM php:8.3-cli
RUN pecl install swoole && docker-php-ext-enable swoole
COPY . /app
WORKDIR /app
RUN composer install --optimize-autoloader --no-dev
RUN php alphavel optimize
CMD ["php", "alphavel", "serve"]
```

### Supervisor

```ini
# /etc/supervisor/conf.d/alphavel.conf
[program:alphavel]
command=php /var/www/alphavel/alphavel serve
autostart=true
autorestart=true
user=www-data
```

## Testing

```bash
# Run all tests
composer test

# Run with coverage
composer test-coverage

# Check PSR-12 code style
composer pint

# Static analysis
composer phpstan
```

## Contributing

Thank you for considering contributing to Alphavel! Please see [CONTRIBUTING.md](https://github.com/alphavel/alphavel/blob/main/CONTRIBUTING.md) for details.

## Code of Conduct

Please review and abide by the [Code of Conduct](https://github.com/alphavel/alphavel/blob/main/CODE_OF_CONDUCT.md).

## Security Vulnerabilities

If you discover a security vulnerability within Alphavel, please send an e-mail to security@alphavel.dev. All security vulnerabilities will be promptly addressed.

## License

The Alphavel Framework is open-sourced software licensed under the [MIT license](LICENSE).
