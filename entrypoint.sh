#!/bin/bash
set -o errexit -o pipefail -o nounset

cp /workdir/authorized_keys /root/.ssh/
chown root:root /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

/usr/bin/ssh-keygen -A
/usr/sbin/sshd -D -e -f /workdir/sshd_config &

echo "running for ${LIFETIME}"
sleep ${LIFETIME}
echo "time is up. Bye ..."
