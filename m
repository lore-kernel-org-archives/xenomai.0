Message-ID: <45092515.1000608@domain.hid>
Date: Thu, 14 Sep 2006 11:47:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] IPC
References: <9D98C51005D80D43A19A3DF329A61D69515625@domain.hid>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D69515625@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7DECA84FFA84F27A9A7CC02B"
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
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DECA84FFA84F27A9A7CC02B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nilanjan Roychowdhury wrote:
> Hi
>=20
> What is the best IPC ( in terms of performance) between any user space
> XENOMAI task and a user space Linux thread ?
>=20
> I know pipes can be used between kernel space XENOMAI task and user
> space Linux thread ?

For larger blocks: shared memory.

We added the rtdm_mmap_to_user service for this purpose.
You can build up an interface on to of it (some IOCTL to establish a
memory region with a user process, some furthers to inform the user
about a valid data block and to signal the driver about the end of
processing that block). This even allows to export DMA memory directly
to the user, i.e. providing zero-copy. Already successfully applied on
an (unpublished) framegrabbing driver.

Jan


--------------enig7DECA84FFA84F27A9A7CC02B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFCSUVniDOoMHTA+kRAhaYAJ9Z2I6TBoHZAiyjirDOLpLW0i7rVQCfUM6e
37Mqaxe5UKdczjIdsYBREbk=
=Btwp
-----END PGP SIGNATURE-----

--------------enig7DECA84FFA84F27A9A7CC02B--

