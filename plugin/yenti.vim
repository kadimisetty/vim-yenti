if !has('python')
    echo "Error requires +python feature."
    finish
endif

command! -nargs=* Yenti call yenti#LoadHelpInPrevWindow(<f-args>)
