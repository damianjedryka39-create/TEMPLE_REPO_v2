---
name: Create_Skill
trigger: "nowy skill|stwórz skill|dodaj skill|zainstaluj skill"
purpose: Instalacja nowego skilla — z Anthropic repo lub tworzenie własnego w SKILL/
output: Nowy plik .md w 🅓_SYSTEM/SKILL/ + update AGENTS.md skill table
agents: [Claude]
cross_link: [Workflow_Edit.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

TASK: Install the Claude Code skill-creator skill from Anthropic's official repository.

GOAL: After completion, the user should be able to invoke `/create-skill` slash command in Claude Code.

STEPS:

1. Create the target directory:
   mkdir -p ~/.claude/skills/skill-creator

2. Download the official SKILL.md from Anthropic's GitHub:
   curl -L -o ~/.claude/skills/skill-creator/SKILL.md \
     https://raw.githubusercontent.com/anthropics/skills/main/skills/skill-creator/SKILL.md

3. Verify the file was downloaded correctly:
   - Check file exists at ~/.claude/skills/skill-creator/SKILL.md
   - Confirm it contains YAML frontmatter (lines starting with ---)
   - Confirm it has a `name:` field

4. Report back:
   - Full path where the skill was installed
   - The exact slash command name from the `name:` field in the YAML frontmatter
   - Confirm the skill is ready to use

NOTES:
- Do NOT use sudo
- Do NOT modify the SKILL.md file content — install as-is
- If curl is unavailable, use wget as fallback:
  wget -O ~/.claude/skills/skill-creator/SKILL.md \
    https://raw.githubusercontent.com/anthropics/skills/main/skills/skill-creator/SKILL.md
- If GitHub is unreachable, try the alternative source:
  https://raw.githubusercontent.com/anthropics/claude-plugins-official/main/plugins/skill-creator/skills/skill-creator/SKILL.md
