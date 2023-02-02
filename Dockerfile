FROM archlinux:base-devel as dependencies
RUN pacman -Sy --needed --noconfirm base-devel git cmake
RUN mkdir /work && chown 1000 /work
USER 1000

WORKDIR /work
RUN git clone https://aur.archlinux.org/tini.git && cd tini && makepkg

FROM archlinux:latest
RUN pacman -Syu --noconfirm tigervnc i3 sudo ttf-droid terminator
COPY rootfs/ /
COPY --from=dependencies /work/tini/pkg/tini/usr/ /usr

ENTRYPOINT [ "/init.sh" ]
