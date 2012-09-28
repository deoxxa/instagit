#!/bin/sh

print_and_execute() {
  if [ "x${INSTAGIT_AM_ROOT}" = "xyes" ]; then
    echo $@ | sed -e 's/^/>>> /g';
    exec $@ | sed -e 's/^/<<< /g';
  else
    echo $@;
  fi;
}

warn() {
  echo $@ >&2;
}

INSTAGIT_COMMAND_PREFIX="";
if [ $(whoami) = "root" ]; then
  INSTAGIT_AM_ROOT="yes";
fi;

MY_ROOT=$(pwd);

if [ $# -lt 2 ]; then
  echo "Usage: $0 user home";
  exit 1;
fi;

if [ ! "x${INSTAGIT_AM_ROOT}" = "xyes" ]; then
  warn "";
  warn "You're running me in non-root mode. That's fine, but it means I'll just output all the commands I'd usually run and you can run them on your own.";
  warn "";
  warn "Just copy and paste everything between the two ===== lines.";
  warn "";
  warn "================";
  warn "";
fi;

MY_LOCATION=$(dirname ${0});
INSTAGIT_INSTALL_USER=${1};
INSTAGIT_INSTALL_HOME=${2};

print_and_execute adduser --system --home ${INSTAGIT_INSTALL_HOME} --disabled-login --disabled-password ${INSTAGIT_INSTALL_USER}
print_and_execute cp -v -a ${MY_ROOT}/bin/instagit.sh ${INSTAGIT_INSTALL_HOME}/instagit.sh;
print_and_execute chmod -v 755 ${INSTAGIT_INSTALL_HOME}/instagit.sh;
print_and_execute cp -v -a ${MY_ROOT}/config/instagit.rc.example ${INSTAGIT_INSTALL_HOME}/.instagit.rc;
print_and_execute chmod -v 644 ${INSTAGIT_INSTALL_HOME}/.instagit.rc;
print_and_execute mkdir -v ${INSTAGIT_INSTALL_HOME}/gits;
print_and_execute chown -v ${INSTAGIT_INSTALL_USER} ${INSTAGIT_INSTALL_HOME}/gits;
print_and_execute chmod -v 700 ${INSTAGIT_INSTALL_USER} ${INSTAGIT_INSTALL_HOME}/gits;
print_and_execute mkdir -v ${INSTAGIT_INSTALL_HOME}/.ssh;
print_and_execute chown -v ${INSTAGIT_INSTALL_USER} ${INSTAGIT_INSTALL_HOME}/.ssh;
print_and_execute chmod -v 700 ${INSTAGIT_INSTALL_HOME}/.ssh;

if [ ! "x${INSTAGIT_AM_ROOT}" = "xyes" ]; then
  warn "";
  warn "================";
fi;

warn "";
warn "Now that this is done, you're going to need to add a user to the ${INSTAGIT_INSTALL_HOME}/.ssh/authorized_keys file with the correct options. You'll want it to look like this:";
warn "";
warn "command=\"${INSTAGIT_INSTALL_HOME}/instagit.sh\" ssh-rsa <KEY_DATA_OMITTED>";
warn "";
warn "After that, you should be good to go. Feel free to open an issue at https://github.com/deoxxa/instagit/issues if there are any problems.";
warn "";
warn "Good luck!";
warn "";
