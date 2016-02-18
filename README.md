Archlinux docker image
======================

Based on the official `base/archlinux` image but up to date concerning
PGP keys and packages.

Contains also the base-devel package needed to install AUR packages.

Since the disappearance of the `--asroot` option in `makepkg`, we need
to rely on the old fashioned way of installing AUR packages. The trick
is to switch between the `root` user and an unprivileged one like
`nobody`. This is handled for you in the `aur-install.sh` script:
```
RUN aur-install.sh arduino
```

You can also pass a second argument to not check for checksums:
```
RUN aur-install.sh arduino --skipchecksums
```

Unfortunately, this script does not install the package's dependencies
so they need to be installed explicitly beforehand.

Some quirks can happen if the user making the build has no home. This
is why this image has set the home `/tmp/nobody` to the user `nobody`.

