## AI-assisted contributions

- Mark AI-assisted work with an `Assisted-by` trailer in the commit message, following the Linux kernel convention:
  `Assisted-by: AGENT_NAME:MODEL_VERSION`
  e.g. `Assisted-by: Claude:claude-sonnet-5-5`
- AI agents must not add `Signed-off-by`; only the human contributor can certify the change.
- Never add `Co-Authored-By` with an AI agent as co-author; agents are assistants, not authors.
