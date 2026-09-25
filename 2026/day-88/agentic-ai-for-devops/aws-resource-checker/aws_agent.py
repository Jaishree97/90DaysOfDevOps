import subprocess
from langchain_ollama import ChatOllama
from langchain_core.tools import tool
from langchain.agents import create_agent as create_react_agent


@tool
def list_ec2_instances() -> str:
    """List all EC2 instances with their state, type, and name."""
    result = subprocess.run(
        [
            "aws", "ec2", "describe-instances",
            "--region", "us-east-1",
            "--query",
            "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,Tags[?Key=='Name'].Value|[0]]",
            "--output", "table",
        ],
        capture_output=True,
        text=True,
    )
    return result.stdout or result.stderr


llm = ChatOllama(model="gemma4", temperature=0)
tools = [list_ec2_instances]
agent = create_react_agent(llm, tools)

print("\nAWS Resource Checker")
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
