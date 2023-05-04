#!/bin/bash +x 

PWD=$(pwd)
WHOAMI=$(whoami)
USER_KEY_PUB_CERT="/etc/ssh/ssh_user_ecdsa_key-cert.pub"
USER_KEY_PUB="/etc/ssh/ssh_user_ecdsa_key.pub"
HOST_KEY_PUB_CERT="/etc/ssh/ssh_host_ecdsa_key-cert.pub"
HOST_KEY_PUB="/etc/ssh/ssh_host_ecdsa_key.pub"

function generate_host_key() {
    printf "Generating Host Key...";
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
    	&& printf "Done\n" || printf "Fail\n"
}

function generate_user_key() {
    printf "Generating User Key...";
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_user_ecdsa_key \
    	&& printf "Done\n" || printf "Fail\n"
}

function sign_user_key() {
	printf "Signing User Key...";
	ssh-keygen -s $PWD/user-ca \
		-n root,sean \
		-t rsa-sha2-256 \
		-I "$WHOAMI $(date +%Y-%m-%d)" \
		-z "$(date +%Y%m%d)" \
		-f $USER_KEY_PUB_CERT \
		$USER_KEY_PUB \
    	&& printf "Done\n" || printf "Fail\n"

	printf "Changing /etc/ssh/ssh_user_ecdsa_key owner...";
	chown sean:sean /etc/ssh/ssh_user_ecdsa_key{,.pub,-cert.pub} \
    	&& printf "Done\n" || printf "Fail\n"
}

function conf_ssh_known_hosts () { 
	printf "Appending host-ca.pub to known hosts...";
	cat host-ca.pub | \
		awk '{ print "@cert-authority * " $0 }' > \
		/etc/ssh/known_hosts \
	&& printf "Done\n" \
	|| printf "Fail\n"
}

function conf_ssh_hosts_file() {
	printf "Generating Global Known Hosts File ssh client Configuration...";
	echo "GlobalKnownHostsFile /etc/ssh/known_hosts" > \
		/etc/ssh/ssh_config.d/global_known_hosts_file.conf
}

function conf_ssh_identity_file() {
	echo "### Generate Identity File ssh client Configuration ###";
	echo "IdentityFile /etc/ssh/ssh_user_ecdsa_key" > \
		/etc/ssh/ssh_config.d/identity_file.conf
}

function sign_host_key() {
	printf "Signing the Host key...\n";
	ssh-keygen -s $PWD/host-ca \
		-h \
		-t rsa-sha2-256 \
		-I "$(hostname) $(date +%Y-%m-%d)" \
		-f $HOST_KEY_PUB_CERT \
			$HOST_KEY_PUB \
    	&& printf "Done\n" || printf "Fail\n"
}

function conf_sshd_update() {
	if [ -z $1 ]; then
		printf "Error - empty sshd config string\n";  exit 1;
	fi
	FILENAME=$(echo $@ | awk '{print $1}')
	printf "Updating sshd config for %s..." $FILENAME;
	if [ -d /etc/ssh/sshd_config.d ]; then
	    if !(grep -r -i -E "^\s*$1" /etc/ssh/sshd_config.d/ > /dev/null); then
		echo $@ > \
			/etc/ssh/sshd_config.d/$FILENAME.conf \
    		&& printf "Done\n" || printf "Fail\n"
		else printf "Existing\n"
	    fi
	else
	    if !(grep -i -E "^\s*$1" /etc/ssh/sshd_config > /dev/null); then
		echo $@ >> /etc/ssh/sshd_config \
    		&& printf "Done\n" || printf "Fail\n"
		else printf "Existing\n"
	    fi
	fi
}

function conf_sshd_host_cert() {
	if [ -f $PWD/user-ca.pub ]; then
	printf "Moving Certificate Authority Public Certificate...";
	    cp $PWD/user-ca.pub /etc/ssh/ssh_user_ecdsa-cert.pub \
    		&& printf "Done\n" || printf "Fail\n"
    	else printf "Missing User CA Public Key\n"; exit 1;
	fi

	printf "Updating sshd config for Host Certificate File...";
	HOST_CERT_CONFIG='HostCertificate /etc/ssh/ssh_host_ecdsa_key-cert.pub'
	conf_sshd_update $HOST_CERT_CONFIG
}

function conf_sshd_trusted_ca() {
	TRUST_USER_CONFIG='TrustedUserCAKeys /etc/ssh/ssh_user_ecdsa-cert.pub'
	conf_sshd_update $TRUST_USER_CONFIG
}

function conf_sshd_disable_pass_auth() {
	sed -i 's/^PasswordAuthentication\ no/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
}

for argv in "$@"
do
	printf "%s\n" $argv
	case $argv in 
	'-h')
		## New Server
		generate_host_key
		sign_host_key
		conf_sshd_host_cert
		conf_sshd_trusted_ca
		systemctl restart sshd;
		break
		;;
	'-u')
		generate_user_key
		sign_user_key
		conf_ssh_known_hosts
		conf_ssh_hosts_file
		conf_ssh_identity_file
		break
		;;
	*)
		echo "usage:"
		echo "	-h - Generate Host Certificates"
		
	esac
done

exit 0;

