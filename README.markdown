vim-leaderboard
===============

vim-leaderboard is a Vim plugin that allows you keep track of which leader commands you run, when you run them, and what the command actually was.

You just run your leader commands as usual when you quit Vim your new data gets saved in a CSV file. You can then parse the CSV and do whatever you want with the data.

Setup
-----

There is a little bit of setup required:

1. Install the plugin. I recommend using [Vundle](https://github.com/gmarik/Vundle.vim):

  ```vim
  Bundle 'davidpdrsn/vim-leaderboard'
  ```

2. Wrap all your leader commands in a function call. Here is an example

  ```vim
  call leaderboard#noremap("Fix formatting", "re", ":call FixFormatting()")
  call leaderboard#noremap("Run tests", "t", ":w", ":call RunTests()")
  call leaderboard#noremap("Run current file", "rr", ":w", ":call RunCurrentFile()")
  ```

  The `leaderboard#noremap` function takes 3 or more arguments:

  1. A description of what the command does.
  2. The key combination you wanna use. If this is for example `rr`, you'll have it `<leader>rr` to run the command.
  3. The remaining arguments (can be as many as you want) are the commands that will be run. They will be run in the order you supply them.

Once this is done you can run your leader commands as usual.

Getting the data
----------------

When you quit Vim the history of the session will be saved it a file at `~/.leaderboard_hist`. This is a CSV file with the following format:

```csv
name,key,command,datetime
"Run current file","rr",":w :call RunCurrentFile()","Mon May 19 15:16:20 2014"
"Fix formatting","t",":call RunTests()","Mon May 19 15:16:24 2014"
"Run tests","re",":call FixFormatting()","Mon May 19 15:16:29 2014"
```

You can then do whatever you want with the data.
