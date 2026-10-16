const express = require('express');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.type('text/plain').send('Bonjour depuis APP3 — pipeline sécurisé !');
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`APP3 écoute sur le port ${port}`);
});
