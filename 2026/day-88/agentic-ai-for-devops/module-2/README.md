# Module 2 — Docker Troubleshooter Agent

In Module 1, you built a chatbot — it reads text and responds. Now you build an **agent** — it decides what actions to take, runs them, reads the results, and keeps going until it has an answer.

## What You'll Learn

- **Chatbot vs Agent** — a chatbot answers questions. An agent takes actions. Our agent runs Docker commands on its own to diagnose problems.
- **Tool calling** — the LLM doesn't just generate text. It picks which Python function to call and with what arguments. We give it 3 Docker tools and it decides which ones to use.
- **ReAct pattern** — Reason ("I should check the logs"), Act (call `get_logs`), Observe (read the output), repeat until done. LangChain handles this loop for us.

## The Code

One file: [`agent.py`](agent.py)

Three tools defined as plain Python functions:

```python
@tool
def list_containers() -> str:
    """List all Docker containers (running and stopped)."""
    result = subprocess.run(["docker", "ps", "-a"], capture_output=True, text=True)
    return result.stdout or result.stderr
```

The `@tool` decorator tells LangChain "the LLM can call this". The docstring becomes the tool's description — the LLM reads it to decide when to use it.

The agent is created in two lines:

```python
llm = ChatOllama(model="gemma4", temperature=0)
agent = create_react_agent(llm, [list_containers, get_logs, inspect_container])
```

That's it. LangChain wires up the ReAct loop — the LLM reasons, picks a tool, we run it, feed the result back, repeat.

## Try It

First, create a broken container:

```bash
docker run -d --name broken-app nginx:alpine sh -c "echo 'app starting...' && sleep 2 && exit 1"
```

Then run the agent:

```bash
python3 module-2/agent.py
```

Ask it:
- "Why is broken-app crashing?"
- "What containers are running?"
- "Show me the logs for broken-app"

Watch it decide which tools to call on its own.

Clean up when done:

```bash
docker rm -f broken-app
```

## Experiment

- Add a 4th tool — maybe `stop_container(name)` or `restart_container(name)`
- Run multiple broken containers and ask "which containers have problems?"
- Look at the agent's reasoning — it prints what it's thinking before each tool call

---

Next: **[Module 3 — Multi-Tool DevOps Agent + MCP](../module-3/)**
