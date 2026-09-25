"""
Docker Troubleshooter Agent — an AI agent that diagnoses Docker issues on its own.
Run: python3 module-2/agent.py
"""

import subprocess
from langchain_ollama import ChatOllama
from langchain_core.tools import tool
from langchain.agents import create_agent as create_react_agent


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

@tool
def list_images() -> str:
    """List all Docker images on this machine with their sizes."""
    result = subprocess.run(
        ["docker", "images"],
        capture_output=True,
        text=True,
    )
    return result.stdout or result.stderr

@tool
def restart_container(container_name: str) -> str:
    """Restart a Docker container."""
    result = subprocess.run(["docker", "restart", container_name], capture_output=True, text=True,)
    return result.stdout or result.stderr

llm = ChatOllama(model="gemma4", temperature=0)
tools = [list_containers, get_logs, inspect_container, list_images, restart_container]
agent = create_react_agent(llm, tools)

print("\nDocker Troubleshooter Agent")
print("-" * 30)
print("Ask me about your Docker containers. Type 'quit' to exit.\n")

while True:
    question = input("> ").strip()
    if question.lower() in ("quit", "exit", "q"):
        break
    if not question:
        continue

    print("\nThinking...\n")
    result = agent.invoke({"messages": [("user", question)]})

    # The last message is the agent's final answer
    print(result["messages"][-1].content)
    print()
