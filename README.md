# icy-tail

tail -n the file in your Emacs!!

## Usage

In your `init.el`,

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'icy-tail)
```

1. `M-x icy-tail-file`
2. Select the file you want to view, using `tail -n 100`
