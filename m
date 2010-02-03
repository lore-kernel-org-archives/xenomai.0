Message-ID: <4B69D077.7000307@domain.hid>
Date: Wed, 03 Feb 2010 20:37:27 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A4407782E6174248C5898DB"
Subject: [Xenomai-help] howto build debion packages from a Xenomai Git
	repository
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A4407782E6174248C5898DB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

below a howto which works for me on a Debian Lenny system.

Regards, Stefan

Building debian packages from a Xenomai Git repository:

This example shows how to build Xenomai 2.5.1, feel free to adapt to your=
 needs.

Prerequisites:

Install the following packages:
 # apt-get install devscripts git-core git-buildpackage debhelper dh-kpat=
ches findutils

You need a local Xenomai Git repository:
 $ git clone git://xenomai.org/xenomai-2.5.git

Finished with prerequisites, here is the starting point for later builds:=


Go to the Xenomai Git working tree:
 $ cd xenomai-2.5

Update the Git repository:
 xenomai-2.5$ git fetch origin

Create and checkout a new branch based on a git treeish object.
In this example, we create a branch v2.5.1-deb based on git tag v2.5.1:
 xenomai-2.5$ git-checkout -b v2.5.1-deb v2.5.1

Create a new debian changelog entry:
 xenomai-2.5$ debchange -v 2.5.1-0.1 Release 2.5.1

Commit the changelog to the v2.5.1-deb branch:
 xenomai-2.5$ git-commit -a --author=3D"Your Name <your@domain.hid>" -m 2.5.1-=
0.1

Build the packages in the directory ../build :
 xenomai-2.5$ git-buildpackage \
  --git-upstream-branch=3Dv2.5.1 \
  --git-debian-branch=3Dv2.5.1-deb \
  --git-export-dir=3D../build \
  -uc -us

Thats all folks, now switch back to the master branch:
 xenomai-2.5$ git checkout master

You could now delete the branch v2.5.1-deb:
 xenomai-2.5$ git branch -D v2.5.1-deb

If you keep the branch you can later switch back to it,
cherry pick some commits from another branch, adapt and
commit the changelog and build the packages again.



--------------enig2A4407782E6174248C5898DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLadCDIPTw9rIdn6oRAlzbAJ9Bp4yUUxw+y/KUIGKCKb9YeInjZACdGLfU
poWLxU/ILdhiRNiIi6toTF4=
=sGK5
-----END PGP SIGNATURE-----

--------------enig2A4407782E6174248C5898DB--

