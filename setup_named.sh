#!/bin/bash
yum update -y
yum install -y bind bind-utils

# Enable and start named
systemctl enable named
systemctl start named

# Configure named.conf
cat > /etc/named.conf <<EOL
options {
    listen-on port 53 { any; };
    directory       "/var/named";
    allow-query     { any; };
    recursion yes;
    dnssec-enable yes;
};

zone "kbvsm.com" IN {
    type master;
    file "kbvsm.com.db";
    allow-update { none; };
};
EOL

# Create zone file for kbvsm.com
cat > /var/named/kbvsm.com.db <<EOL
\$TTL 86400
@   IN  SOA ns.kbvsm.com. admin.kbvsm.com. (
        2026032001 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL

@       IN  NS      ns.kbvsm.com.
ns      IN  A       127.0.0.1
www     IN  A       127.0.0.1
EOL

chown root:named /var/named/kbvsm.com.db
systemctl restart named
