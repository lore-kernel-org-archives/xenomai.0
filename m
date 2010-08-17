Message-ID: <4C6AA99D.3010907@domain.hid>
Date: Tue, 17 Aug 2010 17:24:13 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>
	<4C698E16.5050806@domain.hid>,
	<1282040830.1730.232.camel@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA31B2CBE272583FC9DA2D2EC"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
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
--------------enigA31B2CBE272583FC9DA2D2EC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17.08.2010 15:51, Hemal C.Bavishi wrote:
> When I tried to compile it with the latest version of kernel with xenom=
ai 2.5.4, I am getting following errors in Xenomai (disable CONFIG_SMP, e=
nable CONFIG_X86_UP_APIC and
> CONFIG_X86_UP_IOAPIC (*).)
>  =20

Just tested, got the same build error with 2.6.34.
If I patch 2.6.34 with prepare-kernel [1] it compiles,
if I use the debian packaged patch generated with prepare-patch [2] it
fails.

I guess a fix is needed in prepare-patch for 2.6.34, but no time to look
closer now.

Stefan

[1] xenomai-2.5.4/scripts/prepare-kernel.sh
[2] xenomai-2.5.4/debian/prepare-patch.sh



--------------enigA31B2CBE272583FC9DA2D2EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxqqakACgkQIPTw9rIdn6pIFQCfeKk99s03sB7psVjTJc/goFzM
EbAAmwWXXImDS3+9g9dwpcUhK4TZlJ/M
=dgTL
-----END PGP SIGNATURE-----

--------------enigA31B2CBE272583FC9DA2D2EC--

