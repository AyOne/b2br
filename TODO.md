## TODO b2br

- SSH on port 4242 without root access
- Configure UFW to allow only port 4242
- Implement password policy:
	- Passwords expire after 30 days
	- Minimum 2 days before password change
	- Warning issued after 7 days
	- Passwords must be at least 10 characters long
	- Require at least 1 uppercase letter, 1 lowercase letter, and 1 digit
	- Prohibit 3 consecutive characters from being the same
	- Prohibit using the username in the password
	- Passwords must differ from the last 7 passwords used
	- Reset password for user and root
- Configure sudo rules:
	- Allow only 3 password retries
	- Custom error message on failed password attempts
	- Log sudo activity in /var/log/sudo
	- Enable sudo for TTY sessions only
	- Restrict sudo to specific paths
- Create monitoring.sh script with cron task

Remember:
- dd passphrase: "passphrase"
- gbetting password: "Gaspard42"
- root password: "Gbetting42"

Useful commands:
- Check service status: `sudo service <service> status`