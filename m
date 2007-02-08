Message-ID: <45CAE4E5.4020508@domain.hid>
Date: Thu, 08 Feb 2007 09:52:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] ADEOS with dcache write through enabled on ARM
References: <2905.69.70.101.145.1170911698.squirrel@domain.hid>
In-Reply-To: <2905.69.70.101.145.1170911698.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig500AB9464507724DD4ABD672"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: lobby@domain.hid
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig500AB9464507724DD4ABD672
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

lobby@domain.hid wrote:
> Hello,
>=20
> I read a suggestion Michael Neuhauser made on a web page to enable dcac=
he
> write through on arm9 processors to improve real time latency on the AR=
M
> CPU.
>=20
> I tried this on a cirrus EP9302 (ARM 920T) on a TS-7400 board and it do=
es
> improve the worst case latency dramaticaly but it causes ramdom
> segmentation violations (init process on a idle machine and also user
> started processes)
>=20
> I was wondering if any one has heard of problems on this specific proce=
ssor
> when CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy with linux kernel 2.4.26 and AD=
EOS

That means you are using a really old and outdated version of Adeos. Do
you have the chance to test a recent 2.6.19 I-pipe patch as well?

I guess many people are interested in reducing the poor ARM latencies
and would be happy to work on fixing remaining quirks, but development
now takes place around I-pipe, using Xenomai.

>=20
> The problem only happens when ADEOS patches are applied together with
> CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy. Having the dcache write through ena=
bled
> without adeos patches works fine.
>=20
> Please let me know if I missed something.
>=20
>=20
> Thank You
>=20
> Patrick Robin
>=20

Jan


--------------enig500AB9464507724DD4ABD672
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyuTlniDOoMHTA+kRAh5zAJ0U2noGw/omS883Y2ThpmfZKcXEbQCeIg2B
6K40ABiq9/CTFsZ23Hh3gcY=
=mrcY
-----END PGP SIGNATURE-----

--------------enig500AB9464507724DD4ABD672--

