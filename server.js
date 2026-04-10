const express = require('express');
const session = require('express-session');
const path = require('path');

const app = express();

// ================= Middleware =================
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Static files
app.use(express.static(path.join(__dirname, 'public')));

// Session
app.use(session({
  secret: 'rms_session_secret_key',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 8 * 60 * 60 * 1000 } // 8 hours
}));

// ================= Routes =================
app.use('/auth', require('./routes/auth'));
app.use('/menu', require('./routes/menu'));
app.use('/orders', require('./routes/orders'));

const customerRoutes = require('./routes/customer');
console.log('✅ customerRoutes imported');
app.use('/customer', customerRoutes);

app.use('/tables', require('./routes/tables'));

// ================= Test Route =================
app.get('/test-server-route', (req, res) => {
  res.send('SERVER ROUTE WORKING');
});

// ================= HTML Pages =================

// Login page
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

// Dashboard (Staff/Admin)
app.get('/dashboard', (req, res) => {
  if (!req.session.user) return res.redirect('/');
  res.sendFile(path.join(__dirname, 'public/pages/dashboard.html'));
});

// Billing
app.get('/billing', (req, res) => {
  if (!req.session.user) return res.redirect('/');
  res.sendFile(path.join(__dirname, 'public/pages/billing.html'));
});

// Menu
app.get('/menu-page', (req, res) => {
  if (!req.session.user) return res.redirect('/');
  res.sendFile(path.join(__dirname, 'public/pages/menu.html'));
});

// ================= Customer Pages =================

// Customer Login
app.get('/customer-login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/pages/customer-login.html'));
});

// Book Table Page
app.get('/book-table', (req, res) => {
  if (!req.session.customer) return res.redirect('/customer-login');
  res.sendFile(path.join(__dirname, 'public/pages/book-table.html'));
});

// ================= Admin Tables =================
app.get('/admin-tables', (req, res) => {
  if (!req.session.user || req.session.user.role !== 'admin') {
    return res.redirect('/');
  }

  res.sendFile(path.join(__dirname, 'public/pages/admin-tables.html'));
});

// ================= Error Handler =================
app.use((err, req, res, next) => {
  console.error('Server Error:', err);
  res.status(500).json({ message: 'Server error' });
});

// ================= Server =================
const PORT = 3000;

app.listen(PORT, () => {
  console.log('\n🍽️ Restaurant Management System');
  console.log(`Server running at http://localhost:${PORT}`);
  console.log('\nLogin credentials:');
  console.log('Admin : admin@rms.com / admin123');
  console.log('Staff : staff@rms.com / staff123\n');
});