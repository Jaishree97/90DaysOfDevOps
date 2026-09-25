# Module 3 — Multi-Tool DevOps Agent + MCP

You built a Docker troubleshooter in Module 2. Now you add Kubernetes tools to the same agent, and learn how MCP lets any AI system use your tools — not just LangChain.

## What You'll Learn

- **Multi-environment agent** — one agent that knows Docker AND Kubernetes. It decides which tools to use based on what you ask.
- **Agents, Tools, Chains** — quick LangChain primer. An agent picks tools to call. A tool is a Python function the LLM can invoke. A chain is a fixed sequence of LLM calls (we use agents, not chains, because agents are adaptive).
- **MCP (Model Context Protocol)** — a standard way to expose tools to any LLM system. Write tools once, use them in Claude Desktop, VS Code, Cursor, or anything that speaks MCP.

## The Code

Two files this time:

1. **[`agent.py`](agent.py)** — LangChain agent with 6 tools (3 Docker + 3 K8s)
2. **[`mcp_server.py`](mcp_server.py)** — MCP server that exposes the K8s tools to Claude Desktop

### agent.py — The Unified Agent

We added 3 Kubernetes tools to the Module 2 agent:

```python
@tool
def list_pods(namespace: str = "default") -> str:
    """List all pods in a Kubernetes namespace with their status."""
    result = subprocess.run(
        ["kubectl", "get", "pods", "-n", namespace],
        capture_output=True, text=True,
    )
    return result.stdout or result.stderr
```

Same pattern as Docker tools — subprocess call, capture output, return the result. The agent now has 6 tools and decides which ones to use based on your question.

### mcp_server.py — Protocol-Based Tools

Instead of LangChain, we use FastMCP — a library that implements the Model Context Protocol:

```python
from fastmcp import FastMCP

mcp = FastMCP("Kubernetes Tools")

@mcp.tool
def list_pods(namespace: str = "default") -> str:
    """List all pods in a Kubernetes namespace with their status."""
    # same kubectl subprocess call
```

The key difference: **framework vs protocol**.

| | agent.py | mcp_server.py |
|---|---|---|
| Library | LangChain | FastMCP (MCP protocol) |
| Works with | LangChain agents only | Claude Desktop, VS Code, Cursor, any MCP client |
| Runs as | Python script with REPL | Background server (stdio) |

MCP is like a REST API for AI tools — a standard interface that any LLM system can speak.

## Try It — Part 1: The Agent

### Step 1: Create a Kind cluster

```bash
kind create cluster --name devops-demo
```

This should auto-switch your kubectl context. Verify:

```bash
kubectl cluster-info
```

You should see `https://127.0.0.1:XXXXX` (local). If it still points to an EKS or other remote cluster, manually export the Kind kubeconfig:

```bash
kind export kubeconfig --name devops-demo
```

### Step 2: Deploy a broken pod

```bash
kubectl apply -f module-3/broken_pod.yaml
```

Wait 15 seconds, then check:

```bash
kubectl get pods
```

You'll see `broken-pod` in `CrashLoopBackOff` — it starts, runs for 2 seconds, exits with code 1, and Kubernetes keeps restarting it.

### Step 3: Create a broken Docker container too

```bash
docker run -d --name broken-container nginx:alpine sh -c "echo 'container starting...' && sleep 2 && exit 1"
```

Now you have problems in both Docker and Kubernetes.

### Step 4: Run the agent

```bash
python3 module-3/agent.py
```

Try these:

- "What pods are running in my cluster?"
- "Why is broken-pod crashing?"
- "Show me the events in the default namespace"
- "What Docker containers are running?"
- "Why is broken-container failing?"
- "What's broken across Docker and Kubernetes?"

Watch it pick K8s tools when you ask about pods, Docker tools when you ask about containers, and both when you ask about everything.

### Clean up

```bash
kubectl delete -f module-3/broken_pod.yaml
docker rm -f broken-container
```

## Try It — Part 2: The MCP Server

### Step 1: Install FastMCP

```bash
pip install fastmcp
```

### Step 2: Configure Claude Desktop

Open the Claude Desktop config file:

- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux**: `~/.config/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

Add this (replace both paths with your actual absolute paths):

```json
{
  "mcpServers": {
    "k8s-tools": {
      "command": "/absolute/path/to/agentic-ai-for-devops/.venv/bin/python3",
      "args": ["/absolute/path/to/agentic-ai-for-devops/module-3/mcp_server.py"]
    }
  }
}
```

Get your repo path with `pwd` in the repo root, then append `.venv/bin/python3` for the command and `module-3/mcp_server.py` for the arg.

**Important:** The command must point to your **venv Python**, not just `python3`. Claude Desktop uses the system Python by default, which won't have fastmcp installed.

### Step 3: Restart Claude Desktop

Fully quit Claude Desktop (Cmd+Q on macOS, not just close the window) and reopen it. You should see a tools indicator showing 3 available tools.

### Step 4: Test it

Make sure the broken pod is still running (or redeploy it):

```bash
kubectl apply -f module-3/broken_pod.yaml
```

In Claude Desktop, ask:

- "List the pods in my cluster"
- "Describe the broken-pod"
- "Show me the events in the default namespace"

Claude calls your MCP server's tools to get the answers. Same tools, different AI system.

### Clean up

```bash
kubectl delete -f module-3/broken_pod.yaml
kind delete cluster --name devops-demo
```

## LangChain Quick Primer

You've been using LangChain since Module 2. Here's what each piece does:

**Tool** — a Python function the LLM can call. The `@tool` decorator registers it and the docstring becomes the tool's description (the LLM reads this to decide when to use it).

**Agent** — the decision-maker. It reads your question, picks a tool, runs it, reads the result, and repeats until it has an answer. This is the ReAct pattern: Reason, Act, Observe. `create_react_agent` sets this up.

**Chain** — a fixed sequence of LLM calls where the output of one feeds into the next. We don't use chains here because agents are smarter — they decide what to do next instead of following a script.

## Why MCP Matters

You just saw the same K8s tools delivered two ways:

1. **LangChain agent** (agent.py) — framework-specific. Only works inside LangChain.
2. **MCP server** (mcp_server.py) — protocol-based. Works with any MCP-compatible client.

Why this matters:

- **Write once, use everywhere.** Your MCP server works with Claude Desktop today, VS Code tomorrow, and whatever comes next.
- **Separation of concerns.** The LLM lives in one place, the tools live in another. Update tools without touching the LLM setup.
- **Local execution.** The MCP server runs on your machine with your kubeconfig. Credentials stay local.

## Troubleshooting

**MCP server shows "Server disconnected"**
- Make sure the `command` in your config points to the venv Python (`.venv/bin/python3`), not system `python3`.
- Test manually: run `.venv/bin/python3 module-3/mcp_server.py` — if it crashes, you'll see the error.

**kubectl points to wrong cluster**
- Run `kubectl config get-contexts` to see all clusters.
- Switch with `kubectl config use-context kind-devops-demo`.
- If the Kind context is missing: `kind export kubeconfig --name devops-demo`.

**Tools not showing in Claude Desktop**
- Fully quit (Cmd+Q on macOS) and reopen. Closing the window isn't enough.
- Check JSON syntax in the config file — one wrong comma breaks it.
- Check logs: `~/Library/Logs/Claude/mcp*.log` on macOS.

## Experiment

- Add a 4th K8s tool: `get_pod_logs(pod_name, namespace)` to get logs from a pod
- Add Docker tools to the MCP server — it doesn't have to be K8s-only
- Deploy multiple broken pods in different namespaces and ask the agent to find them all
- Ask Claude Desktop to "restart the broken pod" — what happens? (It can't, because we didn't give it a restart tool. That's coming in Module 5.)

---

Next: **[Module 4 — AIOps Demystified](../module-4/)**
