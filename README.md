# devopsdance-consul-template

Install and configures Consul templates. This cookbook has been build on top of
https://github.com/adamkrone/chef-consul-template.. but you need to take into
account that:

- There's no support for Windows.
- Debian and Ubuntu are supported only.
- No support for things other than systemd at the moment.
- It supports Chef 12 as well as 13.

Basically, I did it because consul-template's cookbook dependencies were
blocking myself from moving towards Chef 13.
