if !has('python')
    echo "Error requires +python feature."
    finish
endif


"Load a help file into the current buffer
function! LoadHelpFile()
python << EOF
import vim
import urllib2
TIMEOUT = 20
# URL = "https://raw.github.com/sjl/clam.vim/master/doc/clam.txt"
GH_USER_SLASH_REPO = "sjl/clam.vim"
GH_REPO = GH_USER_SLASH_REPO.split()[-1]
URL = "https://raw.github.com/{}/master/doc/{}".format(GH_USER_SLASH_REPO, GH_REPO)
try:
    response = urllib2.urlopen(URL, None, TIMEOUT).read()
    del vim.current.buffer[:]
    vim.current.buffer[:] = response.splitlines()

except Exception, e:
    print e
EOF
endfunction


function! SetUpBufferForHelp()
    set nomodifiable
    set filetype=help
endfunction
