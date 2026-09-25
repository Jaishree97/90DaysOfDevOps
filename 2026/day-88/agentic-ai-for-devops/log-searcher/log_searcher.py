import subprocess
from langchain_ollama import ChatOllama
from langchain_core.tools import tool
from langchain.agents import create_agent as create_react_agent


@tool
def search_logs(keyword: str, namespace: str = "default") -> str:
    """Search for a keyword in the logs of all pods in a namespace."""
    pods = subprocess.run(
        ["kubectl", "get", "pods", "-n", namespace, "-o", "name"],
        capture_output=True,
        text=True,
    )

    if pods.returncode != 0:
        return pods.stderr

    results = []

    for pod in pods.stdout.strip().split("\n"):
        if not pod:
            continue

        logs = subprocess.run(
            ["kubectl", "logs", pod, "-n", namespace, "--tail=100"],
            capture_output=True,
            text=True,
        )

        if keyword.lower() in logs.stdout.lower():
            results.append(f"{pod}: found '{keyword}'")

    return (
        "\n".join(results)
        if results
        else f"No pods contain '{keyword}' in their logs"
    )


llm = ChatOllama(model="gemma4", temperature=0)
tools = [search_logs]
agent = create_react_agent(llm, tools)

print("\nKubernetes Log Searcher")
print("-" * 40)
print("Type 'quit' to exit.\n")

while True:
    question = input("> ").strip()

    if question.lower() in ("quit", "exit"):
        break

    if not question:
        continue

    print("\nThinking...\n")
    result = agent.invoke({"messages": [("user", question)]})
    print(result["messages"][-1].content)
    print()
