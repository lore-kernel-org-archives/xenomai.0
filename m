Message-ID: <461F19B3.9090600@domain.hid>
Date: Fri, 13 Apr 2007 07:48:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <25dd9bf10704122225l19d2db87i466f8715c482514@domain.hid>
In-Reply-To: <25dd9bf10704122225l19d2db87i466f8715c482514@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03B184A6DD12D2A46D064C7B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] ADEOS IPIPE Porting on MIPS,
 Xenomai is able to Register istel with Native API's
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Subramani Venkatesh <subbu31mani@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03B184A6DD12D2A46D064C7B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Subramani Venkatesh wrote:
> Hello Phillipe and Jan,
> I thank both of you for helping me in porting ADEOS on MIPS Malta.
> Current status of Adeos is
> 1. Able to Regiser Xenomai Domain, with periodic timer interrupts.
> 2. Xenomai able to create user task and switch between kernel successfu=
lly.
> 3. Xenomai is able to catch system events and interrupts.
>=20
>=20
> I hope I am not late in sharing this information. I did not want tell
> before
> the Xenomai being successfully registering and running. Since I ported
> ADEOS
> on customer kernel 2.6.10, I cannot release this patch now, but very so=
on I
> am goanna start working on MIPS MALTA open source kernel 2.6.12 as this=
 is
> the kernel which I have now that is running on mips malta, later I
> wanted to
> ADEOS ipipe-1.6 on Linux 2.6.18.
>=20
>=20
> I request your feed back and you standards of code to clean up and rele=
ase
> to open source.

You can already make sure that all your code follows kernel coding
style. The rest will be discussed once you are able to release it to the
community.

Jan


--------------enig03B184A6DD12D2A46D064C7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGHxmzniDOoMHTA+kRAvhQAJ9J8twu/u/mrVO2s6z4/myvseNubQCfbURS
Dv5WK0ioKEHOSTKvjX/sJkY=
=/olU
-----END PGP SIGNATURE-----

--------------enig03B184A6DD12D2A46D064C7B--

