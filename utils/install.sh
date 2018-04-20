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
    echo -e "${TXT_INFO}Already added to $file$TXT_RESET"
  else
    echo -e "${TXT_INFO}Adding to $file$TXT_RESET"
    echo $string >> $file
  fi
}

export -f append_to_file

# Updates and upgrades the local package manager.
update_package_manager ()
{
  if (which apt && which dpkg) &> /dev/null
  then
    (apt update &> /dev/null) && apt upgrade -y
  else
    echo -e "${TXT_FAIL}Package manager not found!$TXT_RESET"
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
      echo -e "${TXT_INFO}Package $package already installed.$TXT_RESET"
    else
      echo -e "${TXT_INFO}Installing $package using apt.$TXT_RESET"
      apt install $package
    fi
  else
    echo -e "${TXT_FAIL}Package manager not found!$TXT_RESET"
    exit 1
  fi
}
