#`absrenamer`: batch renaming using the Krename syntax
[![Continuous Integration status](https://secure.travis-ci.org/lenniboy/absolute_renamer.png)](http://travis-ci.org/lenniboy/absolute_renamer)
##Help
    -D, --destination       Destination directory for copy, move and link modes
    -d, --directories       Directories handling
        --dots              Number of dots to get file extension
    -F, --force             Force the new files creation
    -f, --format            Format string used as model
    -l, --list              Only display how files will be renamed
    -m, --mode              Renaming mode
    -n, --no-extension      Removes the extension
    -x, --ext-format        Format string used as model for the extension
    -r, --replace           Search and replace
    -h, --help              Display this help message.


    RENAMING MODES

    Renaming mode can be specified using the --mode (-m) option.
    Any option works with the --destination (-D) option.
    MODE can be any of the followings:

      * move (default): Moves <old name> to <new name>
      * copy: Creates a copy of <old name> named <new name>
      * link: Creates a hard link <new name> which points to <old name>
      * symlink: Creates a symbolic link <new name> which points to <old name>


    SEARCH AND REPLACE

    When using the --replace option, you can do simple string replacement:

      --replace 'hello,hi'

    But you can also use a regular expression to do the job:

      --replace '/picture_(\d+)/,pic-\1'

    EXAMPLES

    absrenamer -f 'pics-##'  *.jpg
      => renames all files files in the current directory ending in .jpg to
         'pics-01.jpg', 'pics-02.jpg' ...

    absrenamer -f '[1;2]_[*4-]' *.mp3
      => takes the first two characters of the original name
         and camelizes from the fourth to the end.

