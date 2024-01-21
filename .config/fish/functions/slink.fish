function slink --description "save URL to ~/sync/links"
  if set -q argv[1]
    echo $argv >> $HOME/sync/links
  else
    cat $HOME/sync/links
  end
end
