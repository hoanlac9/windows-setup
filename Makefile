.POSIX:

default: init run

init:
	python3 -m venv .venv \
		&& . .venv/bin/activate \
		&& pip3 install --upgrade pip \
		&& pip3 install -r requirements.txt \
		&& ansible-galaxy install -r requirements.yml

/tmp/brew-install.sh:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /tmp/brew-install.sh
	chmod +x /tmp/brew-install.sh
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

/usr/local/bin/brew: /tmp/brew-install.sh
	bash -c /tmp/brew-install.sh

run: /usr/local/bin/brew
	. .venv/bin/activate \
		&& ansible-playbook --ask-become-pass --inventory hosts.ini main.yml  

install: 
	. .venv/bin/activate \
		&& ansible-playbook --ask-become-pass --inventory hosts.ini main.yml  

winlocal: 
	. .venv/bin/activate \
		&& ansible-playbook --inventory hosts.ini --limit 52.163.185.85 main.yml -vvvvv

dotfiles:
	. .venv/bin/activate \
		&& ansible-playbook --inventory hosts.ini --tags dotfiles main.yml   

work:
		ansible-playbook --ask-become-pass --inventory hosts.ini work.yml
