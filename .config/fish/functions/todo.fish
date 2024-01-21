function todo --description "todo [--a/add 'thing to do'] | [--d/do #] | [--t/tag 'a task tag'] | [--done] | [--all] | [--edit]"

  set -l TODO $HOME/sync/todo/todo
  set -l DONE $HOME/sync/todo/done

  argparse 'a/add=' 'do=' 't/tag=' 'done' 'all' 'e/edit' -- $argv
  
  if set -q _flag_add
    echo $_flag_add >> $TODO
  else if set -q _flag_do
    sed -n $_flag_do'p' $TODO >> $DONE
    sed -i $_flag_do'd' $TODO
  else if set -q _flag_tag
    cat -n $TODO | grep '\['$_flag_tag'\]'
  else if set -q _flag_done
    cat -n $DONE
  else if set -q _flag_edit
    $EDITOR $TODO
  else
    cat -n $TODO
  end

end
