# claude-code nono package

Starter package for distributing a Claude Code profile, hook, groups, and trust policy through the nono package registry.

## Edit Before Publishing

This starter is already pinned to the `always-further/claude-code` repository and the `always-further` namespace. You still need to replace:

- `.github/workflows/publish.yml` uses `always-further/agent-sign@main`; change that only if the action moves

## Package Contents

- `package.json`: package manifest used by `nono pull`
- `claude-code.profile.json`: extends the built-in `claude-code` profile and installs the hook
- `CLAUDE.md`: project instruction file installed with `--init`
- `hooks/nono-hook.sh`: Claude Code failure hook
- `groups.json`: package-local policy groups
- `trust-policy.json`: additive project trust policy

## Local Validation

From this directory:

```bash
nono trust sign package.json claude-code.profile.json CLAUDE.md hooks/nono-hook.sh groups.json trust-policy.json
```

If you want to test installation from a registry after publishing:

```bash
nono pull --registry http://localhost:3001/api/v1 always-further/claude-code
```
