# HTML to markdown
function curlmd --description "curlmd [url]"
  curl $argv | pandoc -f html -t markdown
end
