# fastlinkcheck
> Check for broken external and internal links.


`fastlinkcheck` checks for broken links in HTML documents.  This occurs in parallel so performance is fast.  Both external links and internal links are checked.  Internal links are checked by verifying local files.

[fastlinkcheck.fast.ai](https://fastlinkcheck.fast.ai/)

## Install

`pip install fastlinkcheck`

## Usage


<h4 id="link_check" class="doc_header"><code>link_check</code><a href="https://github.com/fastai/fastlinkcheck/tree/master/fastlinkcheck/linkcheck.py#L83" class="source_link" style="float:right">[source]</a></h4>

> <code>link_check</code>(**`path`**:"Root directory searched recursively for HTML files", **`host`**:"Host and path (without protocol) of web server"=*`''`*, **`config_file`**:"Location of file with urls to ignore"=*`None`*, **`exit_on_err`**:"Exit with a status code 1 if broken links are found."=*`False`*)

Check for broken links recursively in `path`.


The [_example/](https://github.com/fastai/fastlinkcheck/tree/master/_example) directory in this repo contains sample HTML files which we can use for demonstration.  

The `path` parameter specifies the directory that will be searched recursively for HTML files that you wish to check.

Specifying the `host` parameter allows you detect links that are internal by identifying links with that host name. External links are verified by making a request to the appropriate website.  On the other hand, internal links are verified by inspecting the presence and content of local files.  

```python
from fastlinkcheck import link_check

broken_links = link_check(path='_example', host='fastlinkcheck.com')
print(broken_links)
```





    - 'http://somecdn.com/doesntexist.html' was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`
    - Path('/Users/hamelsmu/github/fastlinkcheck/_example/test.js') was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`


```python
print(f'Number of broken links found {len(broken_links)}')
```

    Number of broken links found 2


### Ignore links with a configuration file

You can choose to ignore files with a a plain-text file containing a list of urls to ignore.  For example, the file `linkcheck.rc` contains a list of urls I want to ignore:

```python
with open('_example/linkcheck.rc', 'r') as f: print(f.read())
```

    test.js
    https://www.google.com
    


In this case `example/test.js` will be filtered out from the list:

```python
broken_links = link_check(path='_example', host='fastlinkcheck.com', config_file='_example/linkcheck.rc')
print(broken_links)
```





    - 'http://somecdn.com/doesntexist.html' was found in the following pages:
      - `/Users/hamelsmu/github/fastlinkcheck/_example/test.html`


### CLI Function

<code>link_check</code> can also be called from the command line.  We can see various options by passing the `--help` flag.  These options correspond to the same parameters as calling the `link_check` function described above.

> link_check --help

```
usage: link_check [-h] [--host HOST] [--config_file CONFIG_FILE]
                  [--exit_on_err] [--pdb] [--xtra XTRA]
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
  --exit_on_err         Exit with a status code 1 if broken links are found.
                        (default: False)
```

## Documentation

Docs site: [fastlinkcheck.fast.ai](https://fastlinkcheck.fast.ai/)

## Appendix: Using `link_check` in GitHub Actions


In the below example we pass the flag `--exit_on_err ` which will mark this workflow as failed if a broken link is found.

```yaml
name: Check Links
on: [workflow_dispatch, push]

jobs:
  check-links:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-python@v2
    - name: check for broken links
      run: |
        pip install fastlinkcheck
        link_check _example --exit_on_err 
```

You can open an issue if broken links are found by adding a few extra lines of code:

```yaml
...
      - name: check for broken links
        run: |
          pip install fastlinkcheck
          errs=$(link_check _example)
          export GITHUB_TOKEN=${{ secrets.GITHUB_TOKEN }}
          gh issue create -t "test issue from gh" -b "$errs" -R ${{ github.repository }}
```

See the [GitHub Actions docs](https://docs.github.com/en/free-pro-team@latest/actions) for more information.
