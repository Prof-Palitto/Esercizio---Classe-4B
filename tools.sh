dir=''
setup(){
 echo 'dir="'$1'"' >> tools.sh
 source tools.sh
}

shtree(){
	cd $dir
	#git --no-pager log --graph --abbrev-commit --decorate --date=relative --all
	git --no-pager log --abbrev-commit --decorate --date=relative --all
	cd -
}

co(){
	cd $dir
	git checkout $1
	mv replit.nix /tmp
       	cd -
	cp -R $dir/* .
}
dir="Esercizi---GITHUB"
dir="Esercizi---GITHUB-1"
dir="Esercizi---GITHUB"
dir="nuovo-progetto"
dir="GitHuub101"
