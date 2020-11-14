# fastlinkcheck
> Check for broken external and internal links.  


This is useful for checking for broken links in static site generators.

## Install

`pip install fastlinkcheck`

## Usage

```
from fastlinkcheck import link_check
```

```
link_check(path='_example', host='fastlinkcheck.com')
```








- 'http://somecdn.com/doesntexist.html' was found in the following pages:
  - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`
- Path('/Users/hamelsmu/github/fastlinkcheck/_example/test.js') was found in the following pages:
  - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`



You can choose to ignore files with a a plain-text file containing a list of urls to ignore.  For example, the file `linkcheck.rc` contains a list of urls I want to ignore:

```
with open('_example/linkcheck.rc', 'r') as f: print(f.read())
```

    test.js
    https://www.google.com
    


In this case `example/test.js` will be filtered out from the list:

```
link_check(path='_example', host='fastlinkcheck.com', config_file='_example/linkcheck.rc')
```








- 'http://somecdn.com/doesntexist.html' was found in the following pages:
  - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`



### CLI Function

`check` can also be called use from the command line like this:
{% include note.html content='the `!` command in Jupyter allows you [run shell commands](https://stackoverflow.com/questions/38694081/executing-terminal-commands-in-jupyter-notebook/48529220)' %}
The `-h` or `--help` flag will allow you to see the command line docs:

```
!link_check -h
```

    usage: link_check [-h] [--host HOST] [--config_file CONFIG_FILE]
                      [--actions_output] [--exit_on_found] [--print_logs] [--pdb]
                      [--xtra XTRA]
                      path
    
    Check for broken links recursively in `path`.
    
    positional arguments:
      path                  Root directory searched recursively for HTML files
    
    optional arguments:
      -h, --help            show this help message and exit
      --host HOST           Host and path (without protocol) of web server
                            (default: )
      --config_file CONFIG_FILE
                            Location of file with urls to ignore
      --actions_output      Toggle GitHub Actions output on/off (default: False)
      --exit_on_found       (CLI Only) Exit with status code 1 if broken links are
                            found (default: False)
      --print_logs          Toggle printing logs to stdout. (default: False)
      --pdb                 Run in pdb debugger (default: False)
      --xtra XTRA           Parse for additional args (default: '')

