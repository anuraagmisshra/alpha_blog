# AlphaBlog

A modern Ruby on Rails 8.1 blogging platform with secure authentication, rich content editing, categorization, and comprehensive CI/CD integration.

![Ruby Version](https://img.shields.io/badge/Ruby-3.5.0--preview1-red)
![Rails Version](https://img.shields.io/badge/Rails-8.1.0.beta1-brightgreen)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.5-purple)

## 📋 Overview

AlphaBlog is a full-stack Ruby on Rails application demonstrating modern Rails patterns and best practices. It features Turbo-driven UX, Devise authentication with optional 2FA and reCAPTCHA protection, article and category management with rich text editing, and robust security measures.

## ✨ Features

- **User Authentication**
  - Secure registration and login with [Devise](https://github.com/heartcombo/devise)
  - reCAPTCHA v2 integration to prevent bot attacks
  - Optional TOTP two-factor authentication
  
- **Content Management**
  - Create, read, update, and delete blog articles
  - Rich text editing with [Action Text](https://guides.rubyonrails.org/action_text_overview.html)
  - File and image embedding with Active Storage
  - Article categorization system
  
- **UI/UX**
  - Responsive design with Bootstrap 5.3
  - Turbo-driven navigation for SPA-like experience
  - User profiles with Gravatar integration
  - Pagination support with [will_paginate](https://github.com/mislav/will_paginate)
  
- **Security**
  - Comprehensive security tooling (Brakeman, Bundler Audit, Importmap audit)
  - CSRF protection
  - Strong parameter sanitization
  
- **Quality Assurance**
  - RSpec and Rails testing framework
  - RuboCop for code style enforcement
  - CI/CD pipeline with GitHub Actions

## 🛠️ Installation

### Prerequisites

- Ruby 3.3.0+ (3.5.0-preview1 recommended)
- Node.js and Yarn
- SQLite (development) or PostgreSQL (production)
- Git

### Step-by-step Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/alpha_blog.git
cd alpha_blog
```

2. **Set up environment variables**

Create a .env file in the root directory:

```bash
cp .env.example .env
```

Edit the .env file with your specific configuration:

```
GOOGLE_SITE_KEY=your_recaptcha_site_key
GOOGLE_SECRET_KEY=your_recaptcha_secret_key
SMTP_USERNAME=mailer_username
SMTP_PASSWORD=mailer_password
FROM_EMAIL=verified_sender@example.com
APP_HOST=localhost
OTP_SECRET_KEY=some-random-base32-or-hex
OTP_2FA_ISSUER_NAME=AlphaBlog
```

3. **Install dependencies**

```bash
bundle install
yarn install
```

4. **Set up the database**

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed  # Optional: add sample data
```

5. **Start the Rails server**

```bash
bin/rails server
```

Visit `http://localhost:3000` in your browser.

## 📝 Usage

### Creating an Account

1. Navigate to the signup page via the "Sign up" link
2. Complete the registration form with your details
3. Verify with reCAPTCHA if enabled
4. Optionally set up 2FA after registration

### Managing Articles

**Creating a new article:**

```ruby
# In Rails console
article = Article.new(
  title: "My First Article",
  description: "This is the content of my first article",
  user_id: User.first.id
)
article.save
```

**Through the web interface:**
1. Navigate to Articles → New Article
2. Fill in the title and content using the rich text editor
3. Select categories for your article
4. Click "Create Article"

### Using Categories

Categories allow you to organize articles by topic. You can:
1. Create categories (admin only)
2. Assign articles to multiple categories
3. Browse articles by category

```erb
<%# Example of displaying categories for an article %>
<% if @article.categories.any? %>
  <div class="mt-2">
    <%= render @article.categories %>
  </div>
<% end %>
```

## 🧪 Testing

The application includes a comprehensive test suite:

```bash
# Run the full test suite
bin/rails test
bin/rails test:system

# Run RSpec tests
bundle exec rspec

# Run security checks
bin/bundler-audit
bin/brakeman --quiet
bin/importmap audit

# Run RuboCop for code style checking
bundle exec rubocop
```

## 🚀 Deployment

### Production Setup

1. Configure your production database in database.yml or via environment variables
2. Precompile assets:
   ```bash
   RAILS_ENV=production bin/rails assets:precompile
   ```
3. Run migrations:
   ```bash
   RAILS_ENV=production bin/rails db:migrate
   ```
4. Start the server with your preferred production setup (Puma, Nginx, etc.)

### Docker Deployment

The project includes Docker configuration for testing:

```bash
docker-compose -f docker-compose.test.yml up
```

## 🧭 Troubleshooting

| Issue | Solution |
|-------|----------|
| OpenSSL legacy error during Node builds | `export NODE_OPTIONS=--openssl-legacy-provider` |
| Captcha validation failures | Verify site domain and keys in Google reCAPTCHA admin |
| Email delivery issues | Check SMTP credentials and server settings |
| Database connection errors | Verify connection string and credentials |
| 2FA not working | Ensure OTP secret key is properly configured |

## 🔄 API Documentation

The application includes a Model Context Protocol (MCP) endpoint at `/mcp` that can be used for integration with external services.

Example API request:

```bash
curl -X POST http://localhost:3000/mcp \
  -H "Content-Type: application/json" \
  -d '{"method": "notifications/initialized"}'
```

## 👨‍💻 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Run the test suite to ensure everything works before your changes
4. Make your changes and add tests if applicable
5. Ensure the test suite passes (ci)
6. Commit your changes (`git commit -m 'Add some amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

Please adhere to the [Ruby style guide](https://rubystyle.guide/) and ensure all tests pass before submitting PRs.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- The Ruby on Rails community
- Bootstrap team for the UI framework
- All contributors to the gems used in this project

---

> Built with ❤️ by Anurag Mishra.