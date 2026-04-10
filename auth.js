function requireLogin(req, res, next) {
  if (!req.session.user) {
    return res.redirect('/');
  }
  next();
}

function requireAdmin(req, res, next) {
  // no login session at all
  if (!req.session.user) {
    return res.status(401).json({ error: 'Login required.' });
  }

  // logged in, but not admin
  if (req.session.user.role !== 'admin') {
    return res.status(403).json({ error: 'Admin access required.' });
  }

  next();
}

module.exports = {
  requireLogin,
  requireAdmin
};