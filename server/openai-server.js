const express = require('express');
const bodyParser = require('body-parser');
const fetch = require('node-fetch');
const app = express();
app.use(bodyParser.json());

require('dotenv').config();
const OPENAI_KEY = process.env.OPENAI_API_KEY;
const MODE = OPENAI_KEY ? 'openai' : 'mock';
console.log(`Starting iHelp server in ${MODE} mode`);

app.post('/chat', async (req, res) => {
  const { message } = req.body || {};
  if (!message) return res.status(400).json({ error: 'Message is required' });

  console.log(`[${new Date().toISOString()}] Incoming message:`, message);

  if (MODE === 'mock') {
    // Simple rule-based mock reply
    const m = (message || '').toLowerCase();
    let reply;
    if (!m.trim()) reply = "Say something and I'll try to help!";
    else if (m.includes('hello') || m.includes('hi')) reply = 'Hi there — this is iHelp (mock). How can I help?';
    else if (m.includes('how') && m.includes('use')) reply = 'Navigate the app using the bottom tabs. This is a dummy app so actions are local only.';
    else reply = `You said: "${message}". (This is a mock reply.)`;

    console.log(`[${new Date().toISOString()}] Mock reply:`, reply);
    return res.json({ reply });
  }

  // OpenAI mode
  try {
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${OPENAI_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: 'You are iHelp, a friendly helper for a mobile app. Keep answers short.' },
          { role: 'user', content: message }
        ],
        max_tokens: 200
      })
    });

    const data = await response.json();
    const reply = data?.choices?.[0]?.message?.content ?? 'Sorry, no answer.';
    console.log(`[${new Date().toISOString()}] OpenAI reply:`, reply);
    res.json({ reply });
  } catch (err) {
    console.error('OpenAI error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

const PORT = process.env.PORT || 9090;
app.listen(PORT, () => console.log(`iHelp OpenAI server running on http://localhost:${PORT}`));
