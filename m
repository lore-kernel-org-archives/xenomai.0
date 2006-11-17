Message-ID: <455D7FFB.9080802@domain.hid>
Date: Fri, 17 Nov 2006 10:25:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>	
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>	
	<455CC9DE.6030601@domain.hid>	
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>	
	<455D6D3B.9000009@domain.hid>	
	<54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>	
	<455D787D.9010407@domain.hid>
	<54b161f50611170119x70b2104cma26e4ad77df8f965@domain.hid>
In-Reply-To: <54b161f50611170119x70b2104cma26e4ad77df8f965@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCDE0126CFB2705757926E585"
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDE0126CFB2705757926E585
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> On 11/17/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> > I entered the following command:
>> >
>> > modprobe  xeno_rtcan_isa io=3D55296,56320 irq=3D11
>>
>> Try "modprobe xeno_rtcan_isa io=3D55296,56320 irq=3D11,11" instead to =
assign
>> the irq of the second port as well.
>>
>> Jan
>>
>>
> This (two times irq 11) fails with the following output (only the last =
part
> actually):
>=20
> rtcan: registered rtcan0
> ERROR! IRQ 11 busy or invalid (code=3D-16)!
> ERROR -16 while trying to register SJA1000 device!
> Unregistering SJA1000 device rtcan0
> RTCAN: unregistered rtcan0
> FATAL: Error inserting xeno_rtcan_isa (/lib/modules/../xeno_rtcan_isa.k=
o):
> Device or resource busy
>=20
> Then it just returns to the shell.
>=20
> Any ideas about this?

CONFIG_XENO_OPT_SHIRQ_*

Jan


--------------enigCDE0126CFB2705757926E585
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXX/7niDOoMHTA+kRAtY/AJ9sR79PCYkUmbJEb7NTuGKBjB1KAgCdGL1x
mUd/BUqMxCUoHhLQeJb5PJ4=
=zP+o
-----END PGP SIGNATURE-----

--------------enigCDE0126CFB2705757926E585--

