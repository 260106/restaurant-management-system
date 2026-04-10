# Restaurant Management System

Simple Node.js + MySQL restaurant manager with login, menu, billing, and dashboard.

## Stack
- **Backend**: Node.js, Express, express-session
- **Auth**: bcryptjs (password hashing) + session cookies
- **Database**: MySQL
- **Frontend**: Plain HTML, CSS, Vanilla JS

---

## Setup & Run

### 1. Install dependencies
```
npm install
```

### 2. Set up MySQL database
```
mysql -u root -p < schema.sql
```
This creates the `rms_db` database, all tables, and seeds two demo users + 10 menu items.

### 3. Set your MySQL password
Open `config/db.js` and update the `password` field:
```js
password: 'your_mysql_password',
```

### 4. Start the server
```
node server.js
```

Open **http://localhost:3000**

---

## Login Credentials

| Role  | Email              | Password |
|-------|--------------------|----------|
| Admin | admin@rms.com      | admin123 |
| Staff | staff@rms.com      | staff123 |

---

## Pages

| URL          | Description                           |
|--------------|---------------------------------------|
| `/`          | Login page                            |
| `/dashboard` | Stats: total orders + total revenue   |
| `/billing`   | Add items to cart, place order        |
| `/menu-page` | View menu; Admin can add/edit/delete  |

---

## API Endpoints

| Method | Endpoint        | Description              |
|--------|-----------------|--------------------------|
| POST   | /auth/login     | Login                    |
| POST   | /auth/logout    | Logout                   |
| GET    | /auth/me        | Get session user         |
| GET    | /menu           | Get all menu items       |
| POST   | /menu           | Add item (admin only)    |
| PUT    | /menu/:id       | Edit item (admin only)   |
| DELETE | /menu/:id       | Delete item (admin only) |
| POST   | /orders         | Create order             |
| GET    | /orders         | List recent orders       |
| GET    | /orders/stats   | Dashboard stats          |

---

## Folder Structure

```
rms/
├── config/
│   ├── db.js          # MySQL connection pool
│   └── auth.js        # Session middleware
├── routes/
│   ├── auth.js        # Login / logout
│   ├── menu.js        # Menu CRUD
│   └── orders.js      # Order create + list
├── public/
│   ├── css/style.css  # All styles
│   ├── js/common.js   # Shared JS helpers
│   ├── index.html     # Login page
│   └── pages/
│       ├── dashboard.html
│       ├── billing.html
│       └── menu.html
├── server.js          # Express app entry
├── schema.sql         # DB schema + seed data
├── package.json
└── README.md
```
