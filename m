Message-ID: <436F6503.90705@domain.hid>
Date: Mon, 07 Nov 2005 15:30:27 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM driver path question
References: <436F60D3.9080104@domain.hid>
In-Reply-To: <436F60D3.9080104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D64DF7BEF6D53AFE02F8EBD"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D64DF7BEF6D53AFE02F8EBD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> Hello all,
>=20
> I am in the process of writing a simple device driver for Xenomai 2.0
> using RTDM. I have a skeleton driver module loading and registering wit=
h
> RTDM. (I can see the entries in the /proc filesystem when the module
> loads.) I now want to write a driver validation application to exercise=

> the interface, but don't know how Linux device nodes map to Xenomai
> devices. Do I have to manually create device nodes or are they built
> with udev? (I am more familiar with traditional Unix style /dev entries=
,
> udev is new to me.) Do Xenomai devices use the Linux filesystem layer a=
t
> all? Does Xenomain keep a separate namespace/registry of named devices?=


The RTDM namespace is totally separated from the Linux file system.
Thus, there is no dev node or "/dev/" name prefix - as long as you don't
prefer to register your device under "/dev/mydevice".

To differentiate between both namespaces, you address RTDM devices via
rt_dev_open/rt_dev_socket under most skins except for the POSIX skin.
The latter will tell them apart by first asking RTDM for a device to be
opened and then, if this fails, standard Linux.

>=20
> If I missed this in the documentation please feel free to redirect me a=
s
> needed. Any help is appreciated.

Hmm, maybe we rather missed to clearly state this aspect in the docs,
will have to check this.

Anyway, there is also an overview paper available now from the Real-Time
Linux Workshop 2005, Lille (www.realtimelinuxfoundation.org, but papers
are not yet online, I can send it to you privately).

Jan


--------------enig6D64DF7BEF6D53AFE02F8EBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDb2UDncNeS9Q0k+IRAuqeAJ9qwVyGcKpKq/T+yf44j7IQU2QeCACeJzkM
Kv0umM3ylqt0Lkg+ykScfB0=
=TPW5
-----END PGP SIGNATURE-----

--------------enig6D64DF7BEF6D53AFE02F8EBD--

