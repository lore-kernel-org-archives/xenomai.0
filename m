Message-ID: <4BD5D4C4.1090107@domain.hid>
Date: Mon, 26 Apr 2010 20:00:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271600150.git.jan.kiszka@domain.hid> <4BD54515.9010101@domain.hid>
	<4BD5C8C4.3040207@domain.hid>
In-Reply-To: <4BD5C8C4.3040207@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42A7E08AEFE30BB39DBD7BD9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes
	and seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42A7E08AEFE30BB39DBD7BD9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5=
a5987d:
>>>   Gilles Chanteperdrix (1):
>>>         switchtest: increase stack sizes
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.xenomai.org/xenomai-jki.git queues/proc
>>>
>>> This series fixes some of the potential (but when they happen fatal)
>>> overflows in our procfs outputs. Specifically, it fixes all issues in=

>>> RTDM (one of them hit us in the field) and the recently reported
>>> overflow in /proc/xenomai/heap. Moreover, Wolfgang started the length=
y
>>> conversion of the registry by introducing a new seq_file-based interf=
ace
>>> and already moving the native skin over.
>>>
>>> The future belongs to seq_file, so some of the patches are strictly
>>> spoken not yet required. But we better start this effort before the l=
ast
>>> legacy interface user was converted and the old interface is suddenly=

>>> dropped from the kernel. This may not be that far away. A patch of mi=
ne
>>> to improve error reporting of the old interface was rejected with
>>> "->read_proc is going to be removed, so there is no point."
>> Did you already have a chance to look into this series?
>=20
> Not yet, that is a big series. With a high potential for kernel crashes=
,
> memory leaks and other things like that. I am trying to find a way to
> test it. Maybe we can try and run it with kmemcheck?

It's mostly ordinary kernel code - should work. The boring thing will be
to populate every entry with some content. Most were already stressed,
but likely not every corner or the native skin tree.

Jan


--------------enig42A7E08AEFE30BB39DBD7BD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvV1MQACgkQitSsb3rl5xSafgCggBrANktP3osJ59igWiuljYU3
FrsAoNKsfxpNH4+e3O1QjrBEDAVAj9Qz
=XLn9
-----END PGP SIGNATURE-----

--------------enig42A7E08AEFE30BB39DBD7BD9--

