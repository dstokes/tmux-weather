Tmux Weather Plugin
===================

Display local weather in your status line.

![tmux-weather](/screenshots/tmux-weather.png)

Results are cached in `~/.tmux-weather` for 15 minutes by default.

Install
=======

Make sure you have [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) and [jq](https://stedolan.github.io/jq/download/) installed.

Then add the plugin to `~/.tmux.conf`:

```
set -g @plugin 'dstokes/tmux-weather'
```

Load the plugin with `prefix + I`.


Usage
=====

```
set -g status-right "#{weather}"
```

