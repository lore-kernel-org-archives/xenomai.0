Message-ID: <440435C3.9070007@domain.hid>
Date: Tue, 28 Feb 2006 12:36:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtdm_mmap and rt_heap
References: <b647ffbd0602270656m4719d6aes@domain.hid>	<44035219.1020302@domain.hid>
	<1141117773.7873.11.camel@domain.hid>
In-Reply-To: <1141117773.7873.11.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A21B9C844459697E9606316"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A21B9C844459697E9606316
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi All,
>=20
> Exist differences between RTDM's Memory mapped API
> (rtdm_mmap()/rtdm_munmap()) and Native's sharing memory API
> (rt_heap_*())? Which?

The RTDM API is intended to be used by portable drivers for all skins
(even for other RT-Linux extensions) while the native heaps are for
native skin applications. So, if you are planning to implement a driver
for some hardware or some communication protocol and you want to map
e.g. DMA buffers from kernel to user space, use the RTDM API. If you
want to set up shared memory between native applications (user-user,
user-kernel), the heaps are your mechanism of choice.

Jan


--------------enig8A21B9C844459697E9606316
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBDXDniDOoMHTA+kRAqWkAJ92a7vcTxgS+6NJ/aVk8L0zI8qNlQCeI/Ab
WJ6TpAGI0SC9zd/tIBqaq+8=
=5AVl
-----END PGP SIGNATURE-----

--------------enig8A21B9C844459697E9606316--

