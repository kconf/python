# vim: ft=sh
layout_conda() {
	if (($# > 1)) && [[ $2 == "micromamba" ]]; then
		export MAMBA_ROOT_PREFIX=~/micromamba/
		eval "$(~/.local/bin/micromamba shell hook -s zsh)"
		local conda_cmd=micromamba
	else
		eval "$(~/miniconda3/bin/conda shell.zsh hook)"
		local conda_cmd=conda
	fi

	if [ -n "$1" ]; then
		# Explicit environment name from layout command.
		local env_name="$1"
		$conda_cmd activate ${env_name}
	elif (grep -q name: environment.yml); then
		# Detect environment name from `environment.yml` file in `.envrc` directory
		$conda_cmd activate $(grep name: environment.yml | sed -e 's/name: //' | cut -d "'" -f 2 | cut -d '"' -f 2)
	else
		(echo >&2 No environment specified)
		exit 1
	fi
}

layout_poetry() {
	if [[ ! -f pyproject.toml ]]; then
		log_error 'No pyproject.toml found. Use `poetry new` or `poetry init` to create one first.'
		exit 2
	fi

	LOCK="$PWD/poetry.lock"
	watch_file "$LOCK"

	local VENV=$(poetry env info --path)
	if [[ -z $VENV || ! -d $VENV/bin ]]; then
		log_status 'No poetry virtual environment found. Running `poetry install` to create one.'
		poetry install
		VENV=$(poetry env info --path)
	else
		HASH="$PWD/.poetry.lock.sha512"
		if ! sha512sum -c $HASH --quiet >&/dev/null; then
			log_status 'poetry.lock has been updated. Running `poetry install`'
			poetry install
			sha512sum "$LOCK" >"$HASH"
		fi
	fi

	export VIRTUAL_ENV=$VENV
	export POETRY_ACTIVE=1
	PATH_add "$VENV/bin"
}
