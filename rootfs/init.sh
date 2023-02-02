#!/bin/bash

if [ "$#" -gt 0 ];then
  exec sh -c "$*"
fi

USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}
USERNAME=${USERNAME:-i3user}
DISPLAY=${DISPLAY:-:0}
if grep -q "x:$USER_ID:$GROUP_ID:" /etc/passwd; then
  echo user exists
else
  useradd -m -G wheel "${USERNAME}"
fi

exec tini -- sh -c 'vncsession "'${USERNAME}'" "'${DISPLAY}'" & sleep infinity'
