FROM openshift/base-centos7

MAINTAINER istreeter

EXPOSE 8080

ENV PERL_VERSION=5.16 \
	PATH=$PATH:/opt/rh/perl516/root/usr/local/bin

LABEL io.k8s.description="Platform for building and running Mojolicious applications with Perl 5.16" \
      io.k8s.display-name="Hypnotoad 7.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,perl,perl516,mojo,mojolicious,hypnotoad"

RUN yum install -y centos-release-scl && \
	INSTALL_PKGS="perl516 perl516-perl-core perl516-perl-CPANPLUS" && \
	yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
	rpm -V $INSTALL_PKGS && \
	yum clean all && \
	scl enable perl516 -- cpanp 's conf prereqs 1; s save system' && \
	scl enable perl516 -- cpanp 's conf allow_build_interactivity 0; s save system' && \
	curl -sSkL https://raw.githubusercontent.com/miyagawa/cpanminus/1.7102/cpanm |scl enable perl516 -- perl - App::cpanminus && \
	scl enable perl516 -- cpanm -l /opt/app-root Mojolicious@7.01 && \
        rm -rf /opt/app-root/src/.cpanm

# My run script should end with:
# perl -I./extlib/lib/perl5 -I./lib/perl5/ hypnotoad scripts/app.pl

COPY ./s2i/bin/ $STI_SCRIPTS_PATH
COPY ./contrib/ /opt/app-root

RUN chown -R 1001:1001 /opt/app-root

USER 1001

CMD $STI_SCRIPTS_PATH/usage
