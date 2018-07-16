develop:
	ansible-playbook -vvv -i hosts main.yml
	ln -sfn /usr/local/opt/emacs-plus/Emacs.app /Applications
	fish && omf install lambda && exit
develop_silent:
	ansible-playbook -i hosts main.yml
check_develop:
	ansible-playbook -vvv -i hosts main.yml --check
