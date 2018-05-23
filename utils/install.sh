#!/bin/bash

# Appends a line to the end of a file only if the line isn't found in the file
# already.
#
# Usage:
# append_to_file path/to/file "string to add"
append_to_file ()
{
  file=$1
  string=$2
  if grep -Fxq "$string" $file &> /dev/null
  then
    printf "${TXT_INFO}Already added to $file$TXT_RESET\n"
  else
    printf "${TXT_INFO}Adding to $file$TXT_RESET\n"
    printf $string >> $file
  fi
}

export -f append_to_file

# Updates and upgrades the local package manager.
update_package_manager ()
{
  if (which apt && which dpkg) &> /dev/null
  then
    (apt update &> /dev/null) && apt upgrade -y
  elif (which brew) &> /dev/null
  then
    (sudo -u $SUDO_USER brew update &> /dev/null) && sudo -u $SUDO_USER brew upgrade
  else
    printf "${TXT_FAIL}Package manager not found!$TXT_RESET\n"
    exit 1
  fi
}

# Installs a package using the local package manager.
install_package ()
{
  package=$1
  if (which apt && which dpkg) &> /dev/null
  then
    if dpkg -s $package &> /dev/null
    then
      printf "${TXT_INFO}Package $package already installed.$TXT_RESET\n"
    else
      printf "${TXT_INFO}Installing $package using apt.$TXT_RESET\n"
      apt install $package
    fi
  elif which brew &> /dev/null
  then
    if sudo -u $SUDO_USER brew ls $package &> /dev/null
    then
      printf "${TXT_INFO}Package $package already installed.$TXT_RESET\n"
    else
      printf "${TXT_INFO}Installing $package using brew.$TXT_RESET\n"
      sudo -u $SUDO_USER brew install $package
    fi
  else
    printf "${TXT_FAIL}Package manager not found!$TXT_RESET\n"
    exit 1
  fi
}
