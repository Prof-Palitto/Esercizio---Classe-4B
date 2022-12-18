# genera una pagina HTML con rappresentazione grafica dell'albero dei GIT Commit
# Uso: 

# :setl noai nocin nosi inde=  # vim command for removing auto-indent
cat << EOF
<html>
  <body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gitgraph.js/1.11.4/gitgraph.min.js"></script>
    <canvas id="gitGraph"></canvas>
    <script>
      var gitgraph = new GitGraph({
        template: "metro", // or blackarrow
        orientation: "vertical",
        author: "John Doe",
        mode: "extended", // or compact if you don't want the messages
      });
EOF

exec 4<.shtree
message=""
while read -u 4 f line; do 
	#echo "LINE: $line"
	if [ "$f" == "commit" ]; then 
		#echo "COMMIT: $line"
		if [ "$message" != "" ]; then
			echo "      $branch.commit({message: \"$message\", author: \"$author - $date\", sha1: \"$sha1 - \"})"
			#echo -e "message: $message"
			message=""
		fi
		set -- $line #commit e number
		sha1=$1
		#echo $f $sha1
		br="${line#*origin/}"
		if [ "$br" != "$line" ]; then
			#echo $branch
			branch=${br%,*}
			#echo $branch
			branch=${branch%)}
			br=$branch
			branch=${branch/-/_}
			#echo $branch
			#if [ $branch ]; then echo "BRANCH: $branch"; fi
			echo "var $branch = gitgraph.branch('$br');"
		fi
		read -u 4 f line
		author=${line/<*/ }
		#echo $f $author
		read -u 4 f line
		date="$line"
		#echo $f
		read -u 4 f line
		read -u 4 message
	else
		message="$message\n$f $line"
	fi
done

echo "master.commit({message: \"$message\", author: \"$author\", sha1: \"$sha1\"})"

cat << EOF
    </script>
  </body>
</html>
EOF
