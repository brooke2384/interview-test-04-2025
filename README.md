# Kmbal Coding Test

### Rules

Candidates are welcome to use any tools to complete the coding test, including
documentation, search engines, and AI assistants like ChatGPT or Claude. However,
they must be prepared to answer questions about their work, and justify technical
decisions they have made.

### Background

The repo contains a movie dashboard. Users can register at the `/register` route.
Once registered, a user can see a list of movies in the dashboard. They can click
on a movie to view it's description and reviews.

### Instructions

Depending on the role you're applying for, you can find instructions in one of
the following documents:

- [Instructions (Web Developers)](./docs/instructions/WEB_DEVELPERS.md)
- [Instructions (Mobile Developers)](./docs/instructions/MOBILE_DEVELPERS.md)
- [Instructions (QAs)](./docs/instructions/QA.md)

### Getting Started (Developers)

1. Open the development container in VS Code
2. Change directory to `./web`
3. Copy `.env.example` to `.env` with `cp .env.example .env`
4. Install dependencies with `npm install` and `composer install`
5. Run the database migrations with `php artisan migrate`
6. Seed the database with `php artisan db:seed`
7. Start the Vite development server with `npm run dev`
8. Start the Laravel development server with `php artisan serve`
9. Visit `http://localhost:8000/register` and create an account

## License

© 2025 Kmbal Ltd. All rights reserved.
