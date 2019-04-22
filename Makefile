develop:
	ansible-playbook -i hosts main.yml -e "git_email=$(git_email) git_name=$(git_name)" -vvv --ask-sudo-pass
	ln -sfn /usr/local/opt/emacs-plus/Emacs.app /Applications
develop_silent:
	ansible-playbook -i hosts main.yml -e "git_email=$(git_email) git_name=$(git_name)"
check_develop:
	ansible-playbook -i hosts main.yml -vvv --check --ask-sudo-pass