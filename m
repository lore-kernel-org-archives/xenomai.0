Message-ID: <4B69DD73.3040004@domain.hid>
Date: Wed, 03 Feb 2010 21:32:51 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D49DCCD2CECC5DBE45AF231"
Subject: [Xenomai-help] unofficial Xenomai 2.5.x apt archive for Debian and
	Ubuntu
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
--------------enig1D49DCCD2CECC5DBE45AF231
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

i've put a apt repository online with binary xenomai packages (private, u=
nofficial).
There is a tree for Debian 5.0 'Lenny' and another for Ubuntu 9.10 'Karmi=
c Koala' (amd64,i386).

I'm tracking the Xenomai branch 2.5 and have just uploaded the Xenomai 2.=
5.1 deb's. Give it a try.

First, you need to add the apt key of my repository:
# wget -q -O - http://homepage.hispeed.ch/kisda/xenomai/apt.key | apt-key=
 add -

Next, put the following lines in your /etc/apt/sources.list file:

 For Debian 5.0 'Lenny' - amd64,i386:

  deb http://homepage.hispeed.ch/kisda/xenomai/ lenny 2.5
  deb-src http://homepage.hispeed.ch/kisda/xenomai/ lenny 2.5

 For Ubuntu 9.10 'Karmic Koala' - amd64,i386:

  deb http://homepage.hispeed.ch/kisda/xenomai/ karmic 2.5
  deb-src http://homepage.hispeed.ch/kisda/xenomai/ karmic 2.5

Finally, update apt-index and install the Xenomai packages:
 apt-get update
 apt-get install xenomai-runtime xenomai-doc libxenomai1 libxenomai-dev l=
inux-patch-xenomai

Regards, Stefan


--------------enig1D49DCCD2CECC5DBE45AF231
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLad1zIPTw9rIdn6oRAlE4AJ9OK0uEaYOtgsr0LUGP2FQPeI9eiwCeIz3D
chGOcGbs757X6HKm985CCng=
=ZZck
-----END PGP SIGNATURE-----

--------------enig1D49DCCD2CECC5DBE45AF231--

