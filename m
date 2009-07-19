Message-ID: <4A633A57.1090005@domain.hid>
Date: Sun, 19 Jul 2009 17:23:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A62D1C1.9050807@domain.hid> <4A62D2B8.8030907@domain.hid>
	<4A6337D8.7030300@domain.hid>
In-Reply-To: <4A6337D8.7030300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF23AAD953CC9799ED266EF7D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 2/3] x86-64: Work around gcc issues with
 populating syscall registers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF23AAD953CC9799ED266EF7D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> gcc-4.1.3 of kubuntu has problem with proper syscall register
>> initialization in rt_task_shadow if TLS is enabled. But it is likely
>> that more compiler versions below 4.3 and more configuration variants
>> are affected.
>>
>> This patch installs a workaround for these gcc versions which places a=
n
>> optimization barrier before the register variable setup. This forces g=
cc
>> to actually load the registers.
>=20
> I have tried the barrier with arm gcc, it does not work. However,
> marking the registered clobbered instead of the memory fixes arm gcc 4.=
3
> bug. So, I wonder, would not it make more sense to mark the registers a=
s
> clobbered by the barrier instead of memory on x86 too?
>=20

Sounds reasonable. Will give it a try later.

I just noticed that my unification patch includes some unwanted merge
artifact, so it requires another round in any case.

Jan


--------------enigF23AAD953CC9799ED266EF7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpjOlsACgkQniDOoMHTA+k+RQCfRktKDrC1XeKOrGHGFH9ofVgC
4goAnRDbKkD5ES9rYzHzuHMqzoWx/fyC
=+nNH
-----END PGP SIGNATURE-----

--------------enigF23AAD953CC9799ED266EF7D--

