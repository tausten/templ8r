# templ8r

Docker container app for transforming an input folder's contents (file contents, filenames, folder names) leveraging the [gomplate](https://github.com/hairyhenderson/gomplate) library.

`templ8r` is packaged so that it can be easily used within CI/CD workflows and/or from other scripts, makefiles, etc.. to help with things like project templating (eg. to fill in gaps for github template repos).

## Usage

* basic sample with long-form mount syntax (source dir is `./source`, output is `./output` and config is `./my-config.env`):

```shell
docker run --rm -ti \
    --mount type=bind,source="$(pwd)"/source,target=/in \
    --mount type=bind,source="$(pwd)"/output,target=/out \
    --mount type=bind,source="$(pwd)"/my-config.env,target=/cfg.env \
    tausten/templ8r
```

* same basic sample using shorter `-v` syntax:

```shell
docker run --rm -ti -v "$(pwd)"/source:/in -v "$(pwd)"/output:/out -v "$(pwd)"/my-config.env:/cfg.env tausten/templ8r
```

### Parameters

These have defaults, but can be overridden by env var on the docker commandline.

* `IN_DIR` - default is `/in` (i.e. mount your template source folder to this within the container)
* `OUT_DIR` - default is `/out`  (i.e. mount your target folder to this within the container)
* `CFG_FILE` - default is `/cfg.env`  (i.e. mount your template parameter config file to this within the container)
  * if you want to use yaml or json formatted file, then you will need to override this parameter by env var, and mount the appropriate file (with necessary extension) into the container
  * the expected format of the `/cfg.env` file is just a set of newline-delimited `key=value` pairs
* `LEFT_DELIM` - default: `<<[`
* `RIGHT_DELIM` - default: `]>>`

## Known issues

* because output is done via mount, the ownership of the output files are (currently) the root user (i.e. from within the docker container)
  * maybe we can do some trick with checking the perms in the source files and then chowning the targets to match?
  * for now, user of this util will need to perform the `sudo chown...` themselves on the output after execution
