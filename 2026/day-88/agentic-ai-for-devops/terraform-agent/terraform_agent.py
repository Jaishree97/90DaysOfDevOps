import subprocess
from langchain_ollama import ChatOllama
from langchain_core.tools import tool
from langchain.agents import create_agent as create_react_agent


@tool
def terraform_plan() -> str:
    """Run terraform plan and return the output showing what would change."""
    result = subprocess.run(
        ["terraform", "plan", "-no-color"],
        capture_output=True,
        text=True,
        cwd="/home/chaur/AI-BankApp-DevOps/terraform"
    )

    output = result.stdout + result.stderr

    if len(output) > 5000:
        output = output[-5000:] + "\n[...truncated]"

    return output


llm = ChatOllama(model="gemma4", temperature=0)
tools = [terraform_plan]
agent = create_react_agent(llm, tools)

print("\nTerraform Analyzer")
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