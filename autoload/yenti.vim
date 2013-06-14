
function!  LoadHelpInPrevWindow(raw_help_url)
    let temp_file = tempname() 
    " Open temp file in a prev-window
    silent execute ":pedit! " . temp_file
    " Switch to that window and set options
    wincmd P
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal syntax=none
    setlocal filetype=help
    setlocal bufhidden=delete
    

python << EOF
import vim
import urllib2
timeout = 20

# Obtain the gh_user name and gh_repo from a
# string passed in and guess the help file URL from
# there.

# gh_user, gh_repo = vim.eval('a:ghuser_slash_repo').split('/')
# raw_help_url = 'https://raw.github.com/{}/master/doc/{}'.format(gh_user, gh_repo)

# raw_help_url = "https://raw.github.com/sjl/lam.vim/master/doc/clam.txt"
raw_help_url = vim.eval("a:raw_help_url")

try:
    response = urllib2.urlopen(raw_help_url, None, timeout).read()
    b = vim.current.buffer
    del b[:]
    b.append(response.splitlines())

except Exception, e:
    print e
EOF

    " Switch back to first window
    wincmd p

endfunction
