"""
Checks if your machine is ready for the course.
Run: python3 module-0/verify_setup.py
"""

import shutil
import subprocess
import sys

passed = 0
total = 0

def check(name, ok, hint=""):
    global passed, total
    total += 1
    if ok:
        passed += 1
        print(f"  [PASS] {name}")
    else:
        print(f"  [FAIL] {name} — {hint}")


print("\nChecking your setup...\n")

# Python
v = sys.version_info
check("Python 3.10+", v.minor >= 10, f"you have {v.major}.{v.minor}, need 3.10+")

# Docker
try:
    subprocess.run(["docker", "info"], capture_output=True, timeout=10, check=True)
    check("Docker", True)
except Exception:
    check("Docker", False, "install or start Docker")

# kubectl
check("kubectl", shutil.which("kubectl"), "install kubectl")

# Kind
check("Kind", shutil.which("kind"), "install kind")

# Ollama + model
try:
    out = subprocess.run(["ollama", "list"], capture_output=True, text=True, timeout=10, check=True)
    if "gemma4" in out.stdout:
        check("Ollama + gemma4", True)
    else:
        check("Ollama + gemma4", False, "run: ollama pull gemma4")
except Exception:
    check("Ollama", False, "install from https://ollama.com or run: ollama serve")

# Summary
print(f"\n{'—' * 40}")
if passed == total:
    print(f"  {passed}/{total} — you're ready for Day 1!")
else:
    print(f"  {passed}/{total} passed — fix the failures above")
print()
