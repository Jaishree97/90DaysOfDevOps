# GitHub CLI (gh) Commands Reference

A quick reference guide for GitHub CLI commands explored during Day 26 of the #90DaysOfDevOps challenge.

---

## Authentication

| Command | Description |
|----------|-------------|
| `gh auth login` | Authenticate GitHub CLI |
| `gh auth status` | Check authentication status |

---

## Repository Management

| Command | Description |
|----------|-------------|
| `gh repo create <repo-name> --public` | Create a public repository |
| `gh repo view` | View repository details |
| `gh repo view --web` | Open repository in browser |
| `gh repo list` | List repositories |

---

## Issues

| Command | Description |
|----------|-------------|
| `gh issue create` | Create a new issue |
| `gh issue list` | List open issues |
| `gh issue view <issue-number>` | View issue details |
| `gh issue close <issue-number>` | Close an issue |

---

## Pull Requests

| Command | Description |
|----------|-------------|
| `gh pr create` | Create a pull request |
| `gh pr list` | List pull requests |
| `gh pr view` | View pull request details |
| `gh pr merge --merge` | Merge using merge commit |
| `gh pr merge --squash` | Merge using squash strategy |
| `gh pr merge --rebase` | Merge using rebase strategy |

---

## GitHub Actions

| Command | Description |
|----------|-------------|
| `gh run list --repo owner/repo` | List workflow runs |
| `gh run view <run-id> --repo owner/repo` | View workflow run details |
| `gh workflow list` | List workflows |

---

## Useful Commands

| Command | Description |
|----------|-------------|
| `gh api user` | View GitHub user details using API |
| `gh gist create <file>` | Create a GitHub Gist |
| `gh release create <tag>` | Create a GitHub Release |
| `gh alias set <name> "<command>"` | Create a command alias |
| `gh search repos <keyword>` | Search repositories |

---

## Helpful Tips

| Command | Purpose |
|----------|---------|
| `gh help` | Display GitHub CLI help |
| `gh <command> --help` | Show help for a specific command |
| `gh pr create --fill` | Auto-fill PR title and description |
| `gh repo view --json` | Return machine-readable JSON output |

---

## Key Takeaways

- Manage GitHub repositories directly from the terminal.
- Create and manage issues without opening GitHub.
- Create, review, and merge pull requests from the command line.
- Monitor GitHub Actions workflows and workflow runs.
- Automate GitHub operations using scripts and CI/CD pipelines.

---

Built while learning GitHub CLI through the #90DaysOfDevOps challenge.
