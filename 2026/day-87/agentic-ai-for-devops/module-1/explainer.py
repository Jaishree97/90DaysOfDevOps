"""
Docker Error Explainer — paste a Docker error, get a human-readable fix.
Run: python3 module-1/explainer.py
"""

import ollama

SYSTEM_PROMPT = """You are a Docker expert. When given a Docker error, explain:
1. What went wrong (plain English)
2. Most likely cause
3. How to fix it (with commands)
Keep it short."""

print("\nPaste your Docker error (press Enter twice when done):\n")

lines = []
while True:
    line = input()
    if line == "":
        break
    lines.append(line)
error = "\n".join(lines)

print("\nThinking...\n")

response = ollama.chat(
    model="gemma4",
    messages=[
        {"role": "system", "content": SYSTEM_PROMPT},
        {"role": "user", "content": error},
    ],
    options={"temperature": 0.3},
)

print(response["message"]["content"])
