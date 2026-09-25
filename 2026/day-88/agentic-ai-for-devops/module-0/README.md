# Module 0 — Know Before You Go

Get your machine ready before Day 1. Takes about 20 minutes.

## You Should Already Have

- **Docker** — [install](https://docs.docker.com/get-docker/)
- **kubectl** — [install](https://kubernetes.io/docs/tasks/tools/)
- **Kind** — [install](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

## Step 1: Python 3.10+

```bash
python3 --version
```

Need 3.10+. If not:
- **macOS:** `brew install python@3.12`
- **Ubuntu:** `sudo apt install python3.12 python3.12-venv`
- **Other:** [python.org/downloads](https://www.python.org/downloads/)

## Step 2: Install Ollama

Ollama runs LLMs locally — no API key, no cost.

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Pull the model we'll use:

```bash
ollama pull gemma4
```

Test it:

```bash
ollama run gemma4 "Say hello in one sentence"
```

## Step 3: Clone the Repo

```bash
git clone https://github.com/trainwithshubham/agentic-ai-for-devops.git
cd agentic-ai-for-devops
```

## Step 4: Create a Virtual Environment

A virtual environment keeps this project's dependencies separate from your system Python. Everyone should use one so we're all on the same setup.

```bash
python3 -m venv .venv
source .venv/bin/activate
```

You should see `(.venv)` in your terminal prompt. If you open a new terminal, run `source .venv/bin/activate` again.

Install the dependencies:

```bash
pip install -r requirements.txt
```

## Step 5: Verify

```bash
python3 module-0/verify_setup.py
```

If everything shows `[PASS]` — you're ready for Day 1.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Ollama not running | `ollama serve` (or open Ollama app on macOS) |
| Docker not running | Start Docker Desktop, or `sudo systemctl start docker` |
| Docker permission denied | `sudo usermod -aG docker $USER` then re-login |
| Kind not found | `brew install kind` (macOS) or [install docs](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) |
| Python too old | Install newer version, use `python3.12` instead of `python3` |

---

Next: **[Module 1 — kubectl Error Explainer](../module-1/)**
