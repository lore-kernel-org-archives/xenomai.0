Message-ID: <4537AA25.4090900@domain.hid>
Date: Thu, 19 Oct 2006 18:39:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <s5363968.059@domain.hid> <45362AE0.60301@domain.hid>
	<1161270429.9460.17.camel@domain.hid>
In-Reply-To: <1161270429.9460.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE2637201CFE7479BF8C7D996"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: LIRE LInux Real-time Environment
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, kritop@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2637201CFE7479BF8C7D996
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi,
>=20
> I ask excuse for my very bad english.
>=20
> [...]
>>> http://www.rts.uni-hannover.de/lire/
>>>
>>> " LiRE V0.6.1 released / 18.08.2006
>>> This release contains the Linux Kernel 2.6.17.8, Xenomai 2.2.0, RTnet=

>>> 0.9.4, RACK 0.3.0, BusyBox 1.2.1, bugfixes and some new features like=

>>> QEMU Image Support. "
> [...]
>> We are now working on the next generation of LiRE which will likely be=

>> based on some smarter third-party build system, specifically to ease t=
he
>=20
> What build system are you chosen?

PTXdist is under consideration for quite some time, but resources were
simply too limited to "play" with it.

We first need to find a clean model how to integrate the Xenomai build
process so that we can build from a single Xenomai source tree (to allow
development on that Xenomai tree), but do not turn PTXdist upside down.
Should be feasible. Once this is done, all other packets that are
missing will be easy to port.

The roadmap then looks like using PTXdist to build binary packets (like
we now do on our own) AND a toolchain (we simply use SuSE so far), but
first keep our installation process. Enhancing PTXdist with generic
"installation skins" may be a future step, also depending on the further
development of that project.

Jan


--------------enigE2637201CFE7479BF8C7D996
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFN6olniDOoMHTA+kRAi2XAJ9DLJU7KeDzq+6wKqX9IV77I9WMjgCfV1gL
rphxtYTQNemgt2pq9Nj6xuI=
=zTgL
-----END PGP SIGNATURE-----

--------------enigE2637201CFE7479BF8C7D996--

