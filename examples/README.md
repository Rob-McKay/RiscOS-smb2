RISC OS libsmb2 Examples
========================

This directory contains examples for the RISC OS libsmb2 module.

For the examples to work create a `passwords` text file in the current directory of the form:

```
DOMAIN:USERNAME:PASSWORD
```

There should be one line per username. Also set the `NTLM_USER_FILE` environment to point to the `passwords` file.
