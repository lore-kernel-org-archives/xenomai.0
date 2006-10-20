Message-ID: <45389018.3080706@domain.hid>
Date: Fri, 20 Oct 2006 11:00:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: LIRE LInux Real-time Environment
References: <s5363968.059@domain.hid> <45362AE0.60301@domain.hid>
	<1161270429.9460.17.camel@domain.hid> <4537AA25.4090900@domain.hid>
	<20061020083104.GA18636@domain.hid>
In-Reply-To: <20061020083104.GA18636@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77769FA640D49E99D21E02F0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, kritop@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77769FA640D49E99D21E02F0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Robert Schwebel wrote:
> On Thu, Oct 19, 2006 at 06:39:01PM +0200, Jan Kiszka wrote:
>>> What build system are you chosen?
>> PTXdist is under consideration for quite some time, but resources were=

>> simply too limited to "play" with it.
>=20
> Tell me if we can do something to boost your playing activities :)

Take over the rest of our daily work. ;)

>=20
>> We first need to find a clean model how to integrate the Xenomai build=

>> process so that we can build from a single Xenomai source tree (to
>> allow development on that Xenomai tree), but do not turn PTXdist
>> upside down. Should be feasible. Once this is done, all other packets
>> that are missing will be easy to port.
>=20
> PTXdist can easily cope with usual things like patches, patch stacks
> with series files and local software packages. So everything you need
> should be there without turning PTXdist upside down.=20

Xenomai is special in that it comes as one package for kernel patch,
kernel "hook" (which may also be expressed as a patch), and user space
libs/tools.

>=20
>> The roadmap then looks like using PTXdist to build binary packets
>> (like we now do on our own) AND a toolchain (we simply use SuSE so
>> far), but first keep our installation process. Enhancing PTXdist with
>> generic "installation skins" may be a future step, also depending on
>> the further development of that project.
>=20
> I missed the beginning of this discussion - which features are you
> missing? PTXdist is able to build ipkg binary packets. It might also be=

> a good idea to discuss this on the PTXdist mailing list:=20
>=20
> 	http://www.pengutronix.de/mailinglists/index_en.html
>=20
> and not here.

Yeah, I'm going to start a thread there soon (once I fixed some other
issue - daily work, you know). Anyone interested is welcome to join the
thread again.

Jan


--------------enig77769FA640D49E99D21E02F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOJAYniDOoMHTA+kRApEQAJ9RrwqmAfwfKK91DP/OyAxrLlehmACfVNil
sC/CWrxyidYx5uFBuGiIJ7A=
=3Ubb
-----END PGP SIGNATURE-----

--------------enig77769FA640D49E99D21E02F0--

