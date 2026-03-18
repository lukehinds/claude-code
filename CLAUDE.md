# Claude Code Package

This package provides a starter `nono` profile, hook, groups file, and trust policy for Claude Code.

## Expected Usage

Run Claude Code through `nono` with the installed profile:

```bash
nono run --profile claude-code -- claude
```

## Package Notes

- Adjust `claude-code.profile.json` if you want to extend the built-in profile with extra access.
- Keep `trust-policy.json` additive. It should complement a user-level trust policy, not replace it.
- If you add nested files under `hooks/` or other directories, make sure they are listed explicitly in the publishing workflow.
