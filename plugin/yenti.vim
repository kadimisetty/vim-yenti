if !has('python')
    echo "Error requires +python feature."
    finish
endif

command! Yenti call yenti#LoadHelpToCurrentBuffer('sjl/clam')
