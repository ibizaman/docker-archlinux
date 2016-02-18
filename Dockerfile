FROM base/archlinux

RUN pacman --quiet --noconfirm -Sy
RUN pacman --quiet --noconfirm -S archlinux-keyring
RUN pacman --quiet --noconfirm -Syu
RUN pacman-db-upgrade
RUN pacman --quiet --noconfirm -S \
    base-devel 

RUN if [ ! -z "$(pacman -Qtdq)" ]; then \
        pacman --noconfirm -Rns $(pacman -Qtdq); \
        fi
RUN pacman -Scc --noconfirm
RUN pacman-optimize

RUN usermod --home /tmp/nobody --shell /bin/sh nobody

COPY aur-install.sh /usr/bin/
RUN chmod a+x /usr/bin/aur-install.sh

CMD /bin/sh
