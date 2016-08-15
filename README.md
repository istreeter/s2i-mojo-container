# s2i-mojo-container
This is the source for building Docker images to run a Mojolicious web application using Openshift's source-to-image.

This repo is used to build a Docker base image at [Docker Hub](https://hub.docker.com/).
Use the base image to build any Mojolicious web application from source using
[Openshift's source-to-image](https://docs.openshift.org/latest/creating_images/s2i.html#creating-images-s2i).

## Concepts

[Mojolicious](http://mojolicious.org/) is a perl web application framework, designed for simple and complex web applications.
[Hypnotoad](http://mojolicious.org/perldoc/Mojo/Server/Hypnotoad) is the UNIX optimized preforking web server that ships with Mojolicious.
It is optimized specifically for production environments out of the box.

[Source to image](https://github.com/openshift/source-to-image) (S2I) is a toolkit for building Docker images from source code.
S2I makes it easy to build Docker images that take application source code
as an input and produce a new image that runs the assembled application as
output.

The [OpenShift Documentation](https://docs.openshift.org/latest/creating_images/s2i.html#creating-images-s2i)
has lots of information on using S2I.

The source in this repo is based on the [SCL/Openshift repo](https://github.com/sclorg/s2i-perl-container) for building perl apps with S2I.
That repo uses Apache and mod\_perl in the Docker image, whereas this repo uses Hypnotoad without requiring Apache.

## Build an application

You will need the [S2I](https://github.com/openshift/source-to-image) standalone script. The S2I build syntax is:

    $ s2i build <application-source> <base-image-name> <output-image-name>

Build the test application in this repo:

    $ s2i build git://github.com/istreeter/s2i-mojo-container --context-dir=test/test-app istreeter/mojo-701-perl-516 mojo-test-app
    $ Docker run -p 8080:8080 mojo-test-app

Build the fastnotes [Mojolicious app from koorchik](https://github.com/koorchik/FastNotes-Proto)

    $ s2i build git://github.com/koorchik/FastNotes-Proto.git mojo-701-perl-516 fastnotes-proto
    $ Docker run -p 8080:8080 fastnotes-proto

Build the Ado [Mojolicious app from kberov](https://github.com/kberov/Ado), using Mojolicious version 6.66

    $ s2i build git://github.com/kberov/Ado.git mojo-666-perl-516 ado
    $ Docker run -p 8080:8080 ado

Build the Photobooth [Mojolicious lite app from diegok](https://github.com/diegok/PhotoBooth)

    $ s2i build https://github.com/diegok/PhotoBooth.git mojo-701-perl-516 photo-booth
    $ Docker run -p 8080:8080 photo-booth

