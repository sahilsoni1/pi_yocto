# Verifying `rsyslog` Integration with BitBake PyDevShell

This guide helps you confirm that `rsyslog` configuration files (e.g., `rsyslog.conf`, `rsyslogtest.conf`, `ss001.conf`) are correctly fetched and installed during the Yocto build using the `pydevshell` tool.

## ✅ Step 1: Open PyDevShell for rsyslog

From your Yocto build directory:

```bash
bitbake -c pydevshell rsyslog
```

You’ll enter a Python shell where internal BitBake variables are accessible via the `d` object.

## ✅ Step 2: Print Key Paths

Run the following:

```python
print(d.getVar("WORKDIR"))
print(d.getVar("S"))
print(d.getVar("D"))
```

These will output:
- `WORKDIR`: temporary working directory for the recipe
- `S`: unpacked source directory
- `D`: image staging root (`/etc/` content goes here)

## ✅ Step 3: Verify Files Exist on Disk

In another terminal, use the paths obtained above to check:

```bash
# Fetched config files (from SRC_URI)
find $WORKDIR -type f -name "rsyslog*.conf"

# Installed config files (do_install destination)
find $D -type f -name "*.conf"
```

Expected installed paths:

```
$D/etc/rsyslog.conf
$D/etc/rsyslogtest.conf
$D/etc/rsyslog.d/ss001.conf
```

## ✅ Notes

- If files are missing from `$WORKDIR`, check your `SRC_URI` and `FILESEXTRAPATHS`.
- If files are missing from `$D`, check your `do_install()` function in the `.bb` file.

---

This process avoids the need for pseudo-root or external terminals, and helps you debug recipe variables and file deployment cleanly.