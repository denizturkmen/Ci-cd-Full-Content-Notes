1. **external_url** - This is the URL used to access the GitLab CE instance externally. Links in emails will use this URL along with certain uploaded assets (e.g. images specified for groups, etc.). Be sure to specify the port used externally to access the GitLab CE instance from Docker (e.g. port 9150 which maps to the internal Docker port of 443).

2. **gitlab_rails['time_zone']** - Specifies the desired timezone in order for the correct time to show up in the logs, amongst other things.

3. **gitlab_rails['smtp_enable']** - Enables SMTP so emails can be sent out on certain events (e.g. new user registrations, etc.).

4. **gitlab_rails['smtp_address']** - The SMTP server address used for sending emails.

5. **gitlab_rails['smtp_port']** - The port used for SMTP (e.g. port 587 for TLS to ensure emails are sent securely).

6. **gitlab_rails['smtp_user_name']** - The username used for sending emails via SMTP (e.g. user@example.com).

7. **gitlab_rails['smtp_password']** - The password used for the SMTP email account.

8. **gitlab_rails['smtp_domain']** - The domain used for sending emails via SMTP (e.g. example.com).

9. **gitlab_rails['smtp_authentication']** - Specifies the SMTP authentication mode.

10. **gitlab_rails['smtp_enable_starttls_auto']** - Enables TLS to ensure the transfer of secure email messages.

11. **gitlab_rails['gitlab_email_from']** - Specifies the *from* email address shown in the sent email.

12. **gitlab_rails['backup_keep_time']** - Specifies how long in seconds to keep each backup (e.g. 14515200 for roughly 6 months).

13. **logging['logrotate_frequency']** and **nginx['logrotate_frequency']** - Specifies how often logs should be rotated for GitLab CE or NGINX (e.g. daily, weekly, etc.).

14. **logging['logrotate_rotate']** and **nginx['logrotate_rotate']** - Specifies the the value used by the frequency setting above (e.g. if frequency is weekly and rotate interval is set to 7, logs will rotate every 7 weeks) for GitLab CE or NGINX.

15. **logging['logrotate_compress']** and **nginx['logrotate_compress']** - Specifies whether logs should be compressed when rotated for GitLab CE or NGINX.

16. **logging['logrotate_method']** and **nginx['logrotate_method']** - Specifies the method used when logs are rotated (e.g. copytruncate) for GitLab CE or NGINX.

17. **logging['logrotate_delaycompress']** and **nginx['logrotate_delaycompress']** - Specifies whether compression should be delayed when rotating logs for GitLab CE or NGINX.

18. **nginx['listen_port']** - Specifies the port (e.g. port 443 used internally by container) used to force NGINX to listen on. This should be specified if supplying a port to the *external_url* setting. This is because if a port is detected in the external URL, GitLab CE will instruct NGINX to listen on that port unless specifying this setting which acts as an override.

19. **nginx['redirect_http_to_https']** - Redirects HTTP requests to HTTPS, preventing the use of insecure communications.

20. **nginx['ssl_certificate']** - Specifies which SSL certificate to use via a file path. This is an internal container path.

21. **nginx['ssl_certificate_key']** - Specifies which SSL certificate key to use via a file path. This is an internal container path.
