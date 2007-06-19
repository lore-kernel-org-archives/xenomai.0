Message-ID: <46778B6C.30308@domain.hid>
Date: Tue, 19 Jun 2007 09:53:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AAA6EFD@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AAA6EFD@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC02D3268840B3F50A2BDA0A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and Busybox
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC02D3268840B3F50A2BDA0A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Does anyone use Busybox(www.busybox.net) on a xenomai-linux ?
> Or does anyone experience one of these problems with busybox on xenomai=

> :
> - yes > /dev/null stalls system completely (yes is a little program
> returning 'y' continously; this does not happen using a normal bash
> shell)
> - "netstat -a" seems to delay realtime execution (periodic task produce=
s
> overruns). I have no idea how this could happen, as I thought xenomai
> has highest priority and, as far as I have seen, netstat does not
> anything else than reading /proc/net/netstat.
>=20
> We experienced these problems on a PPC 2.4 xenomai-linux.
>=20
> Any suggestions/ideas/explanations ?

This sounds like busybox is just triggering a kernel issue. Maybe we are
leaking some lock into application context. Are there any special
(RT-)drivers running? Does this already happen with only I-pipe applied
and enabled, but not Xenomai? Please try to describe your scenario
precisely (including .config) so that someone with a similar setup can
try to reproduce it.

Jan


--------------enigFC02D3268840B3F50A2BDA0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd4tsniDOoMHTA+kRAoQBAJ9/jwHGaIaDVHarPtgsktQASM9IYACdFuWw
18gnzjSn4/+o4I57VFWAT4g=
=XooS
-----END PGP SIGNATURE-----

--------------enigFC02D3268840B3F50A2BDA0A--

