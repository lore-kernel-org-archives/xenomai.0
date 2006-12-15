Message-ID: <4582E67C.70108@domain.hid>
Date: Fri, 15 Dec 2006 19:16:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F55C9698378419D510AD541"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RFC] git workflow
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F55C9698378419D510AD541
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

some may already be used to working with git, I'm still learning. So
take the following with a grain of salt:

This is a proposal how to create and maintain an ipipe git repository
(we may have a lot of them...). To start small but still create
something useful, I had a look at 2.6.16-i386-1.5-02 vs. the related
stable tree on kernel.org. These are my steps to setup a tree, publish
it, keep it in sync with upstream, or merge ipipe-specific patches:

[Setup]
 0. Install git (I worked with ancient 1.2.4 from OpenSuSE 10.1)

 1. Clone the reference tree

    # git clone git://git.kernel.org/pub/scm/linux/kernel/git/\
      stable/linux-2.6.16.y.git linux-2.6.16-ipipe

 2. Configure your repository (default author/mail, shorthand for upload
    URL to public repos)

    # cd linux-2.6.16-ipipe
    # git repo-config user.name "Jan Kiszka"
    # git repo-config user.email "jan.kiszka@domain.hid"
    # echo "URL: ssh://kiszka@domain.hid" \
      > .git/remote/pub

 3. Import the fitting ipipe patch

    # git apply --index /path/to/adeos-ipipe-2.6.16-i386-1.5-02.patch
    # git commit -m "Import I-pipe 1.5-02" -s

 4. Publish tree, for web access and/or to work collaboratively on it

    # ssh kiszka@domain.hid
        # mkdir linux-2.6.16-ipipe
        # git init-db --shared
        # exit
    # git push pub master

    The first steps create an empty shareable git repos on my-host. The
    second pushes the master branch to the remote repository. There are
    some more steps to perform in order to publish that tree on my-host
    for http:// or git:// access, I haven't looked at this yet.

    Now anyone with whatever access to the public repos can pull from it
    to get the latest official nifty ipipe 2.6.16 tree.


[Keeping up-to-date]
 1. The original kernel tree may have been updated, and the ipipe patch
    needs to be rebased

    # git fetch
    # git rebase origin

    The result /should/ be new commits on top of the updated original
    tree. I haven't tried this in practice yet.

    I also read that release tags of the original trees are not
    automatically fetched after cloning. This needs further
    investigation.

 2. Push new version to public repos

    # git push pub master


[Merge I-pipe updates and release new patch]
 1. The reference I-pipe tree or some contributor may have come up with
    a worthwhile patch

    # git apply --index /path/to/avoid-ipipe_lock_cpu.patch
    # git commit -m "avoid ipipe_lock_cpu when interrupt flags are
                     ignored anyway"

    There is certainly also some magic (but likely simple) dance to pull
    individual commits from something like the "I-pipe Master Tree", but
    don't ask me for details yet (I'm still not really familiar with
    git's addressing scheme).

 2. Push new version to public repos

    # git push pub master

 3. Generate an I-pipe patch

    # git diff origin..master > adeos-ipipe-2.6.16-i386-1.5-03.patch

    As this tree only contains x86 stuff, this is OK. Once we may have
    multi-arch trees, some cherry picking would be required to extract
    only arch/<arch> and include/asm-<arch> aside the generic diffs.

 4. Tagging your tree after release is smart, too

    # git tag -s ipipe-1.5-03


[Duplicate your working repository]
 You may want to build further git working trees on other hosts. In
 order to have the same environment as above, simply cloning the ipipe
 tree is not correct (origin would become the ipipe tree, not vanilla).
 Instead:

 1. Perform steps 1 and 2 of the [Setup] procedure.

 2. Pull the missing ipipe pieces from the ipipe tree

    # git pull pub master


So far. I hope I can motivate some more I-pipe hackers to give this a
try (as time permits...) so that we could soon lay out the real I-pipe
repositories. Though I'm still stumbling about mighty git mechanisms
here and there, my feeling is that this tool can be /really/ helpful for
our not-that-simple distributed maintenance scenario. And to enhance my
poor git skills, I would offer to take over the stable 2.6.16-i386
series (expecting that it will be a really trivial job :o)).

Jan


--------------enig2F55C9698378419D510AD541
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFguZ8niDOoMHTA+kRAv5iAJ4vOn5SShaWivDOAbX+awvS+nZrRwCfReCs
Xy+36QPgQBGpfB6p0bm6wX0=
=Vdcm
-----END PGP SIGNATURE-----

--------------enig2F55C9698378419D510AD541--

