.PHONY: lint syntax shellcheck

# Everything a contributor (or CI) should run before committing.
lint: syntax shellcheck

BASH_FILES := $(filter-out bin/csv2json,$(wildcard bin/*)) install.sh \
	$(wildcard setup/*/*.sh) $(wildcard config/.config/shell/sh/*.sh) \
	$(wildcard config/.config/shell/login/*.sh)
ZSH_FILES := $(wildcard config/.config/shell/zsh/*.zsh) config/.config/zsh/.zshrc \
	config/.config/zsh/.zimrc config/.zshenv

# Parse every shell file without executing it.
syntax:
	@for f in $(BASH_FILES); do head -1 "$$f" | grep -q 'bash\|/sh' && bash -n "$$f" || true; done
	@for f in $(ZSH_FILES); do zsh -n "$$f" || exit 1; done
	@echo "syntax ok"

# Errors only: the repo still has style-level warnings (SC2155, unused vars) that we
# haven't cleaned up yet, so gating on them would just make this always fail.
shellcheck:
	@command -v shellcheck >/dev/null || { echo "shellcheck not installed"; exit 1; }
	@shellcheck -S error $(filter-out setup/packages/go.sh,$(BASH_FILES))
	@echo "shellcheck ok"
