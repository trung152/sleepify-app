---
name: systematic-debugging
description: "Use when encountering any bug, test failure, or unexpected behavior. Find root cause before proposing fixes."
---

# Systematic Debugging

## The Iron Law
```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

## When to Use
ANY technical issue: test failures, bugs, unexpected behavior, performance problems, build failures.

**Especially when:** under time pressure, "obvious" fix seems tempting, already tried multiple fixes.

## The Four Phases

### Phase 1: Root Cause Investigation
**BEFORE attempting ANY fix:**

1. **Read Error Messages Carefully** — stack traces, line numbers, error codes
2. **Reproduce Consistently** — exact steps, every time?
3. **Check Recent Changes** — git diff, new deps, config changes
4. **Gather Evidence** — add diagnostic logging at component boundaries
5. **Trace Data Flow** — where does the bad value originate? Trace backward.

### Phase 2: Pattern Analysis
1. Find **working examples** of similar code in the codebase
2. Compare working vs. broken — list every difference
3. Understand dependencies: what settings, config, environment?

### Phase 3: Hypothesis and Testing
1. **Form single hypothesis:** "X is root cause because Y"
2. **Test minimally:** smallest possible change, one variable
3. **Verify:** worked → Phase 4 | didn't → new hypothesis (don't stack fixes)

### Phase 4: Implementation
1. **Create failing test** that reproduces the bug
2. **Implement single fix** at root cause (not symptom)
3. **Verify:** test passes, no regressions
4. **If 3+ fixes failed** → question the architecture, discuss with user

## Red Flags — STOP and Return to Phase 1
- "Quick fix for now"
- "Just try changing X"
- "I don't fully understand but this might work"
- Proposing solutions before tracing data flow
- Each fix reveals new problem in different place

## Flutter-Specific Debugging
- Use **Flutter DevTools** for widget inspector, performance overlay
- Check **`ref.watch` vs `ref.read`** misuse for unexpected rebuilds
- Verify **provider lifecycle** — is state being disposed prematurely?
- Audio issues: check `AudioPlayer` state, permissions, background mode
- Navigation bugs: verify `go_router` route definitions and guards
