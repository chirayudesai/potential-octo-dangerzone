This repository contains manifests to setup a Android Mirror, AOSP & LineageOS.

The main goal of the project is to save disk space, and cut down on duplicate network transfers by restricting them to a single point (the mirror)

The local_manifests directory contains local manifests I have been using, since basically forever.

## Current Setup:
URL=https://github.com/chirayudesai/potential-octo-dangerzone
### Mirrors
#### mirror/aosp
`repo init -u $URL -m aosp.xml`
* Also contains all the local manifests under local_manifests/mirror/aosp
#### mirror/cm
`repo init -u $URL -m lineage.xml`
* Also contains all the local manifests under local_manifests/mirror/cm
* Another thing I do is symlink {device,external,kernel,platform} from the AOSP mirror here, so that it gets picked up when initing Lineage and setting this as `--reference`
### Working directories
### lineage/16.0
`repo init -u path/to/mirror/cm/chirayudesai/potential-octo-dangerzone.git -b lineage/lineage-16.0 --reference=path/to/mirror/cm`
* I use a custom manifest here with one change, fetch AOSP from '..' instead of the actual URL. This means that this repo does not actually touch the network at all.
* 194M    .repo
### aosp/9.0
`repo init -u path/to/mirror/aosp/platform/manifest.git --reference=path/to/mirror/aosp`
* Nothing too fancy here, just a sync from mirror + reference to mirror.
* 183M    .repo

### Scripts
#### bin/repo2
Wrapper to sync a repository in the mirror first
Not fully complete, but does the job for most of the repos.

#### bin/aosp-mirror-to-cm.sh
Something crazy I did while setting up these mirrors.
Refer to AOSP objects in the forked CM repos, to save even more space.
E.g. Lineage forks aosp/platform/external/foo as LineageOS/android_external_foo
This script you setup the Lineage repo to refer to objects from the AOSP mirror.