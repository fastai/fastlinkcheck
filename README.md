# fastlinkcheck
> Check for broken external and internal links.  


Check for broken links in HTML documents.  This occurs in parallel so performance is fast.  Both external links and external links are checked, with intelligent behavior for internal links.

## Install

`pip install fastlinkcheck`

## Usage


<h4 id="link_check" class="doc_header"><code>link_check</code><a href="https://github.com/fastai/fastlinkcheck/tree/master/fastlinkcheck/linkcheck.py#L83" class="source_link" style="float:right">[source]</a></h4>

> <code>link_check</code>(**`path`**:"Root directory searched recursively for HTML files", **`host`**:"Host and path (without protocol) of web server"=*`''`*, **`config_file`**:"Location of file with urls to ignore"=*`None`*, **`actions_output`**:"Toggle GitHub Actions output on/off"=*`False`*, **`exit_on_found`**:"(CLI Only) Exit with status code 1 if broken links are found"=*`False`*, **`print_logs`**:"Toggle printing logs to stdout."=*`False`*)

Check for broken links recursively in `path`.


The [_example/](https://github.com/fastai/fastlinkcheck/tree/master/_example) directory in this repo contains sample HTML files which we can use for demonstration:

```
broken_links = link_check(path='_example', host='fastlinkcheck.com')
print(broken_links)
```





    - 'http://somecdn.com/doesntexist.html' was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`
    - Path('/Users/hamelsmu/github/fastlinkcheck/_example/test.js') was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`


### Print logs to stdout 

You can optionally print logs to stdout with the `print_logs` parameter.  This can be useful for debugging:

```
broken_links = link_check(path='_example', host='fastlinkcheck.com', print_logs=True)
```





    
    ERROR: The Following Broken Links or Paths were found:
    - 'http://somecdn.com/doesntexist.html' was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`
    - Path('/Users/hamelsmu/github/fastlinkcheck/_example/test.js') was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`


```
print(f'Number of broken links found {len(broken_links)}')
```

    Number of broken links found 2


### Ignore links with a configuration file

You can choose to ignore files with a a plain-text file containing a list of urls to ignore.  For example, the file `linkcheck.rc` contains a list of urls I want to ignore:

```
with open('_example/linkcheck.rc', 'r') as f: print(f.read())
```

    test.js
    https://www.google.com
    


In this case `example/test.js` will be filtered out from the list:

```
broken_links = link_check(path='_example', host='fastlinkcheck.com', config_file='_example/linkcheck.rc')
print(broken_links)
```





    - 'http://somecdn.com/doesntexist.html' was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`


### CLI Function

<code>link_check</code> can also be called use from the command line like this:
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

