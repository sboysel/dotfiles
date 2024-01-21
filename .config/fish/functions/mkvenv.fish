# project-level venv
function mkvenv --description "mkvenv [venv_name]"
    python -m venv ".env/$argv"
    echo "source .env/$argv/bin/activate" >> .envrc
    direnv allow .
end
