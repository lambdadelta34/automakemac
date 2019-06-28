develop:
	ansible-playbook -i hosts main.yml -e "git_email=$(git_email) git_name=$(git_name)" -vvv --ask-become-pass
	ln -sfn /usr/local/opt/emacs-plus/Emacs.app /Applications
develop_silent:
	ansible-playbook -i hosts main.yml -e "git_email=$(git_email) git_name=$(git_name)" --ask-become-pass
	ln -sfn /usr/local/opt/emacs-plus/Emacs.app /Applications
check_develop:
	ansible-playbook -i hosts main.yml -vvv --check --ask-become-pass
