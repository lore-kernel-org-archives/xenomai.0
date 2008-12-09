Message-ID: <493E20BE.4070600@domain.hid>
Date: Tue, 09 Dec 2008 08:39:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>
In-Reply-To: <200812090832.43063.roberto.bucher@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig697D5DD5D39D2062EA5733A6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Roberto Bucher <roberto.bucher@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig697D5DD5D39D2062EA5733A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roberto Bucher wrote:
> Hi
>=20
> I have some problems with the last patches for kernel 2.6.26.x and 2.6.=
27.x.
>=20
> I found first the problem using the RTAI patch, but then I tryed the or=
iginal=20
> adeos patch and the problem remains and I can reproduce it every time.
>=20
> When I start scilab-gtk from a patched kernel, RTAI or Adeos, the syste=
m=20
> freezes completely.
> This problem doesn't happen with a 2.6.24.x kernel or with a non patche=
d=20
> 2.6.27.x kernel.
>=20
> Paolo Mantegazza and other RTAI users have the same problem, but Paolo =
for=20
> example is not able to reproduce it in the same matter. By him for exam=
ple the=20
> problem happens sometimes after launching Acrobat Reader. On my system =
it=20
> happens sometimes when I try to download a file from the web too.
>=20
> The probem persists with the last 2.6.27-x86-2.2-01.patch. I didn't try=
 a=20
> 2.6.25.x kernel, but it seems to be ok (after Paolo Mantegazza).
>=20
> Any idea?

Some questions: Could you provide your .config? How is your X configured
(which driver, any acceleration etc.), or did you see the problem also
without X? Did you try to catch potential oopses via serial console?

Jan


--------------enig697D5DD5D39D2062EA5733A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkk+IL4ACgkQniDOoMHTA+kIaQCeIU6iCnidvmUo8FzakP09loaR
55EAnjdmH+o93o+vNezVGnhfWuERmvWG
=UoH8
-----END PGP SIGNATURE-----

--------------enig697D5DD5D39D2062EA5733A6--

