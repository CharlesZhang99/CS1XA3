#         !/bin/bash

#informs if you're local repo is up to date
function check_up_to_date() {
  cutd=$(git fetch -v --dry-run)
  utd="[up to date]"
  #echo $cutd
  if [[ "utd" =~ "$cutd" ]]; then
    echo "Your local repo is up to date"
  else
    echo "Your local repo is not up to date"
  fi
}

#Puts all uncommited changes in a file changes.log
function check_uncommited_changes(){

  #check if changes.log exists. Creates it if it doesn't.
  #cited from https://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
  git diff > changes.log
  echo "logged changes to changes.log"
}

#Puts each line from every file of your project with the tag #TODO into a file todo.log
function log_todo(){
  #cite: I got the "*.log" idea from deleeuwj1's project
  grep -r --exclude="*.log" "#TODO" > todo.log
}

#Checks all haskell files for shyntax errors and puts the results into error.log
function check_haskell_errors(){
  #I used bucklj4's code for my next line because I simply do not know how to add a main module if it isnt there already. I tried using the method from https://stackoverflow.com/questions/3557037/appending-a-line-to-a-file-only-if-it-does-not-already-exist but it does not work the way I want it to. bucklj4's code adds the main module to the end of the file which is not what I want to do either but I'm too tired to figure this out.
  find -name "*.hs" | xargs -I {} grep -l -L "main = undefined" {} | xargs -I{} sh -c "(echo 'main = undefined') >> {}"
  find . -name "*.hs" | xargs -I error ghc -fno-code "error" &>> error.log
 
}

#custom feature 1. This removes all log files
function remove_logs(){
  find . -name "*.log" | xargs rm
}

#custom feature 2. This removes any file with the extension the user inputs
function remove_any_extension(){
  read -p "Files with what extensions would you like to remove?" ext
  find . -name "*.$ext" | xargs rm
}

function encrypted_files(){
  find . -name "*.enc" | xargs echo
}

function check_permission(){
  read -p "Enter name of file you would like to check permissions to " filen
  #cite for permissions check: https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line
  pm=$(stat -c "%a %n" $filen)
  
  #cite for indexing: http://landoflinux.com/linux_bash_scripting_substring_tests.html
  pm1=${pm:0:1}
  pm2=${pm:1:1}
  pm3=${pm:2:2}
  #cite for dictionary: https://www.artificialworlds.net/blog/2012/10/17/bash-associative-array-examples/
  declare -A permission_num
  permission_num=( ["0"]="do nothing. No permissions" ["1"]="execute" ["2"]="write" ["3"]="write & execute" ["4"]="read" ["5"]="read & execute" ["6"]="read & write" ["7"]="read, write, & execute")
  
  echo "Owner can ${permission_num[$pm1]}"
  echo "Group can ${permission_num[$pm2]}"
  #I don't know why this echo doesnt output value in the dicto
  echo "Others can ${permission_num[$pm2]}"
}

function shitty_compression(){
  read -p "Do you want to compress or decompress? (c/d) " dc
  cw=[
  if [ "$dc" == "c" ];then
    sed -i 's/bonjour/hello/g' txt1.txt
  fi
}

conti=True
function start_menu(){
  if [[ $conti ]];then
    echo "Here is a list of functions you can call:"
    echo "1. check_up_to_date"
    echo "2. check_uncommited_changes"
    echo "3. log_todo"
    echo "4. check_haskell_errors"
    echo "5. remove_logs"
    echo "6. remove_any_extension"
    echo "7. encrypted_files"
    echo "8. check_permission"
    read -p "Enter name of function you would like to run " fun
    $fun
  fi
} 
start_menu
#clear_logs
#check_haskell_errors
#check_uncommited_changes
#log_todo
#remove_any_extension
#encrypted_files
#check_permission
#shitty_compression




