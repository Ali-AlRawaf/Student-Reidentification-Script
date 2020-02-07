d="d"         #direction variable
o="-b"        #optional option is defaulted as -b
path1="x2"    #file paths
path2="x3"

for x in "$@" ; do    #loops through arguments to gather options and paths
	if [ "$x" = "-s" ] ; then
		d="-s"
	elif [ "$x" = "-u" ] ; then
		d="-u"
	elif [ -f "$x" ] ; then
		if [ "$path1" = "x2" ] ; then
			path1="$x"
		else
			path2="$x"
		fi
	elif [ "$x" = "-b" ] ; then
		o="-b"
	elif [ "$x" = "-0" ] ; then
		o="-0"
	elif [ "$x" = "-q" ] ; then
		o="-q"
	fi
done

if [ "$d" = "-u" ] ; then    #based on gathered options, the right command is executed onto the given paths
	if [ $o = "-b" ] ; then
		sort -t, -k 1,1 "$path1" | join -t, -a 1 -1 1 -2 1 -o '1.2,2.2' - $path2 | sort
	elif [ $o = "-0" ] ; then
		sort -t, -k 1,1 "$path1" | join -e0 -a 1 -t, -1 1 -2 1 -o '1.2,2.2' - $path2 | sort
	elif [ $o = "-q" ] ; then
		sort -t, -k 1,1 "$path1" | join -t, -1 1 -2 1 -o '1.2,2.2' - $path2 | sort
	fi
elif [ "$d" = "-s" ] ; then 
	if [ $o = "-b" ] ; then
		sort -t, -k 2,2 "$path1" | join -t, -a 1 -1 2 -2 1 -o '1.1,2.2' - $path2 | sort
	elif [ $o = "-0" ] ; then 
		sort -t, -k 2,2 "$path1" | join -e0 -a 1 -t, -1 2 -2 1 -o '1.1,2.2' -  $path2 | sort
	elif [ $o = "-q" ] ; then
		sort -t, -k 2,2 "$path1" | join -t, -1 2 -2 1 -o '1.1,2.2' - $path2 | sort
	fi
fi
