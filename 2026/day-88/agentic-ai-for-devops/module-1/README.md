# Module 1 — Docker Error Explainer

Paste a Docker error, get a plain-English explanation and fix. Your first LLM-powered tool.

## What You'll Learn

- **Prompt** — the text you send to an LLM. Here, it's the Docker error itself.
- **System role** — a message that sets the LLM's personality ("You are a Docker expert..."). Change it, and the tone of every answer changes.
- **Temperature** — controls randomness. 0.0 = same answer every time, 1.0 = creative. We use 0.3 for reliable advice.
- **Tokens** — LLMs read tokens, not words (~3/4 of a word each). More tokens = slower response.

## Run It

```bash
python3 module-1/explainer.py
```

Paste an error, press Enter twice. Try any of these:

**Port already in use**
```
docker: Error response from daemon: Bind for 0.0.0.0:3000 failed: port is already allocated.
```

**Image not found**
```
docker: Error response from daemon: pull access denied for myapp, repository does not exist or may require 'docker login'
```

**Permission denied**
```
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```

## Experiment

- Change `temperature` to `1.0` — notice how the answer varies
- Edit the system prompt — try "explain like I'm 5"
- Paste a real error from your own terminal

---

Next: **[Module 2 — Docker Troubleshooter Agent](../module-2/)**
