install:
	./install-dotfiles
brew:
	(cd brew && brew bundle)

.PHONY: brew install
