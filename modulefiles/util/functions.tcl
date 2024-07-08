# get the full, normlized path to the directory containing this tcl script:
proc home {} {
    set x [ dict get [info frame 0] file ]
    return [ file normalize [exec dirname $x]/../../ ]
}

# get the $OSRELEASE environment variable if it exists, else
# run our script to get what it will become upon loading modules:
# (Note, we don't use our getenv here for performance reasons.)
proc osrelease {} {
    global env
    if { [ info exists env(OSRELEASE) ] } {
        return $env(OSRELEASE)
    }
    return [ exec [home]/modulefiles/util/osrelease.py ]
}

# print a colored error message:
proc err {msg} {
    puts stderr "\033\[1;31mERROR:\033\[0m $msg"
}

# print a colored warning message:
proc warn {msg} {
    puts stderr "\033\[1;33mWARNING:\033\[0m $msg"
}

# print a warning message if a path doesn't exist:
proc warndir {path msg} {
    if [file isdirectory $path] {
        return 1
    } elseif {[module-info mode load] || [module-info mode test]} {
        warn $msg
    }
    return 0
}

# print a warning message if a file doesn't exist:
proc warnfile {path msg} {
    if [file isfile $path] {
        return 1
    } elseif {[module-info mode load] || [module-info mode test]} {
        warn $msg
    }
    return 0
}

proc prepend-ldpath {path} {
    global env
    prepend-path LD_LIBRARY_PATH $path

	if { [uname sysname] == "Darwin" } {
		setenv DYLD_LIBRARY_PATH $env(LD_LIBRARY_PATH)
	}
}

# on Darwin/Ubuntu/Fedora lib can changed to lib64
proc choose_dir {path1 path2} {
	if  [file isdirectory $path1]  {
		return $path1
	} elseif  [file isdirectory $path2]  {
		return $path2
    } elseif {[module-info mode load] || [module-info mode test]} {
		warn "Neither $path1 nor $path2 exist"
    }
}