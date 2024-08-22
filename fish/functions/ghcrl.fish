function ghcrl --description "push local to new github repopush local to new github repo"
	gh repo create (basename $PWD) --private --source=.
end
