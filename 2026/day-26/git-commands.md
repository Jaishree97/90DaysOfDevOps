# GitHub CLI (gh) Commands Reference

A quick reference guide for GitHub CLI commands learned during Day 26 of the #90DaysOfDevOps journey.

---

# Authentication

| Command | Description |
|----------|-------------|
| `gh auth login` | Authenticate GitHub CLI with GitHub account |
| `gh auth status` | Check authentication status |

### Example

```bash
gh auth login
gh auth status
```

---

# Repository Management

| Command | Description |
|----------|-------------|
| `gh repo create <repo-name> --public` | Create a public repository |
| `gh repo view` | View repository details |
| `gh repo view --web` | Open repository in browser |
| `gh repo list` | List repositories |

### Example

```bash
gh repo create day26-gh-cli-test --public
gh repo view
gh repo view --web
gh repo list
```

---

# Issues

| Command | Description |
|----------|-------------|
| `gh issue create` | Create a new issue |
| `gh issue list` | List open issues |
| `gh issue view <issue-number>` | View issue details |
| `gh issue close <issue-number>` | Close an issue |

### Example

```bash
gh issue create --title "Day 26 Practice Issue" --body "Testing GitHub CLI issue creation."
gh issue list
gh issue view 1
gh issue close 1
```

---

# Pull Requests

| Command | Description |
|----------|-------------|
| `gh pr create` | Create a pull request |
| `gh pr list` | List pull requests |
| `gh pr view` | View pull request details |
| `gh pr merge --merge` | Merge using merge commit |

### Example

```bash
gh pr create --base day26-practice --head feature-branch --title "Day 26 PR Test" --body "Testing GitHub CLI Pull Request"

gh pr list
gh pr view
gh pr merge 2 --merge
```

---

# GitHub Actions & Workflows

| Command | Description |
|----------|-------------|
| `gh run list --repo owner/repo` | List workflow runs |
| `gh run view <run-id> --repo owner/repo` | View workflow run details |

### Example

```bash
gh run list --repo cli/cli
gh run view 28040818099 --repo cli/cli
```

---

# Useful GitHub CLI Commands

| Command | Description |
|----------|-------------|
| `gh api user` | View GitHub user information via API |
| `gh gist create <file>` | Create a GitHub Gist |
| `gh release create <tag>` | Create a GitHub Release |
| `gh alias set <name> "<command>"` | Create command alias |
| `gh search repos <keyword>` | Search repositories |

### Example

```bash
gh api user
gh gist create test.txt
gh release create v1.0
gh alias set myrepos "repo list"
gh search repos devops --limit 5
```

---

# Helpful Tips

| Command | Description |
|----------|-------------|
| `gh help` | Display GitHub CLI help |
| `gh <command> --help` | Show help for a specific command |
| `gh pr create --fill` | Auto-fill PR title and body from commits |

### Example

```bash
gh help
gh repo --help
gh pr create --fill
```

---

#  Key Takeaways

- GitHub CLI helps manage GitHub directly from the terminal.
- Issues can be created, viewed, and closed without opening GitHub.
- Pull Requests can be created, reviewed, and merged from the command line.
- GitHub Actions workflow runs can be monitored directly from the terminal.
- GitHub CLI is useful for automation, scripting, and DevOps workflows.

---
Built while learning GitHub CLI through the #90DaysOfDevOps challenge.
