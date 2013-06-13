
function! LoadHelpToCurrentBuffer(ghuser_slash_repo)
    let local_tmp_fname = tempname()

python << EOF
import vim
import urllib2
timeout = vim.eval('g:yenti_timeout')
# Eg: https://raw.github.com/sjl/clam.vim/master/doc/clam.txt
gh_user, gh_repo = vim.eval('a:ghuser_slash_repo').split('/')
raw_help_url = 'https://raw.github.com/{}/master/doc/{}'.format(gh_user, gh_repo)

try:
    response = urllib2.urlopen(raw_help_url, None, timeout).read()
    with open(vim.eval("local_tmp_fname"), 'r') as f:
        f.write(response)
    #b = vim.current.buffer
    #del b[:]
    #b.append(response.splitlines())

except Exception, e:
    print e
EOF

    set nomodifiable
    set filetype=help

    silent execute ":pedit! " . dst
    " change to preview window
    wincmd P
    " set options
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal syntax=none
    setlocal bufhidden=delete
    " replace current buffer with ruby's output
    " silent execute ":%! ruby " . src . " 2>&1 "
    " change back to the source buffer
    wincmd p

endfunction


