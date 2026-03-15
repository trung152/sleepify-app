---
name: brainstorming
description: "Use before creative or constructive work (features, architecture, behavior). Transforms vague ideas into validated designs through disciplined reasoning."
---

# Brainstorming Ideas Into Designs

## Purpose
Turn raw ideas into **clear, validated designs** through structured dialogue **before any implementation begins**.

Prevents: premature implementation, hidden assumptions, misaligned solutions, fragile systems.

**No coding while this skill is active.**

## Operating Mode
You are a **design facilitator and senior reviewer**, not a builder.

## The Process

### 1️⃣ Understand Current Context
- Review project state: files, docs, plans, prior decisions
- Identify what exists vs. what is proposed
- Note implicit constraints — **do not design yet**

### 2️⃣ Understanding the Idea (One Question at a Time)
- Ask **one question per message**
- Prefer **multiple-choice** when possible
- Focus: purpose, target users, constraints, success criteria, non-goals

### 3️⃣ Non-Functional Requirements
Clarify or propose defaults for:
- Performance, scale, security, reliability, maintenance
- Mark unconfirmed items as **assumptions**

### 4️⃣ Understanding Lock (Hard Gate)
Provide summary (5-7 bullets): what, why, who, constraints, non-goals.
List all assumptions and open questions.

> "Does this accurately reflect your intent? Confirm before we move to design."

**Do NOT proceed until confirmed.**

### 5️⃣ Explore Design Approaches
- Propose **2-3 viable approaches** with recommended option
- Explain trade-offs: complexity, extensibility, risk, maintenance
- **YAGNI ruthlessly**

### 6️⃣ Present Design Incrementally
- Sections of 200-300 words max
- After each: "Does this look right so far?"
- Cover: architecture, components, data flow, error handling, edge cases, testing

### 7️⃣ Decision Log
For each decision: what, alternatives, why chosen.

## After the Design
1. Write final design to markdown (summary, assumptions, decisions, design)
2. Ask: "Ready to set up for implementation?"
3. If yes → create implementation plan, proceed incrementally

## Exit Criteria
ALL must be true: understanding confirmed, approach accepted, assumptions documented, risks acknowledged, decision log complete.
