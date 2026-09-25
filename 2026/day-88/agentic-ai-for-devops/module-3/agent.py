"""
Multi-Tool DevOps Agent — diagnoses Docker and Kubernetes issues.
Run: python3 module-3/agent.py
"""

import subprocess
from langchain_ollama import ChatOllama
from langchain_core.tools import tool
from langchain.agents import create_agent as create_react_agent


# --- Docker tools ---

@tool
def list_containers() -> str:
    """List all Docker containers (running and stopped)."""
    result = subprocess.run(["docker", "ps", "-a"], capture_output=True, text=True)
    return result.stdout or result.stderr


@tool
def get_logs(container_name: str) -> str:
    """Get the last 50 lines of logs from a Docker container."""
    result = subprocess.run(
        ["docker", "logs", "--tail", "50", container_name],
        capture_output=True, text=True,
    )
    return result.stdout + result.stderr


@tool
def inspect_container(container_name: str) -> str:
    """Get detailed info about a Docker container (state, config, network)."""
    result = subprocess.run(
        ["docker", "inspect", container_name],
        capture_output=True, text=True,
    )
    return result.stdout or result.stderr


# --- Kubernetes tools ---

@tool
def list_pods(namespace: str = "default") -> str:
    """List all pods in a Kubernetes namespace with their status."""
    result = subprocess.run(
        ["kubectl", "get", "pods", "-n", namespace],
        capture_output=True, text=True,
    )
    return result.stdout or result.stderr


@tool
def describe_pod(pod_name: str, namespace: str = "default") -> str:
    """Get detailed info about a Kubernetes pod including events and conditions."""
    result = subprocess.run(
        ["kubectl", "describe", "pod", pod_name, "-n", namespace],
        capture_output=True, text=True,
    )
    return result.stdout or result.stderr


@tool
def get_events(namespace: str = "default") -> str:
    """Get recent Kubernetes events in a namespace (useful for troubleshooting)."""
    result = subprocess.run(
        ["kubectl", "get", "events", "-n", namespace, "--sort-by=.lastTimestamp"],
        capture_output=True, text=True,
    )
    return result.stdout or result.stderr


llm = ChatOllama(model="gemma4", temperature=0)
tools = [
    list_containers, get_logs, inspect_container,
    list_pods, describe_pod, get_events,
]
agent = create_react_agent(llm, tools)

print("\nMulti-Tool DevOps Agent")
print("-" * 40)
print("I can troubleshoot Docker and Kubernetes.")
print("Type 'quit' to exit.\n")

messages = []

while True:
    question = input("> ").strip()
    if question.lower() in ("quit", "exit", "q"):
        break
    if not question:
        continue

    #print("\nThinking...\n")
    #result = agent.invoke({"messages": [("user", question)]})
    #print(result["messages"][-1].content)
    #print()
    print("\nThinking...\n")
    messages.append(("user", question))
    result = agent.invoke({"messages": messages})
    response = result["messages"][-1].content
    messages.append(("assistant", response))
    print(response)
    print()
