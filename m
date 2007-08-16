Message-ID: <46C49070.8070807@domain.hid>
Date: Thu, 16 Aug 2007 19:59:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>
In-Reply-To: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2194A3708C5E69EFDC4C47A4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM context_size question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org, trem <tremyfr@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2194A3708C5E69EFDC4C47A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Kauffmann wrote:
> Hi
>=20
> When looking at the rtdm examples tut01-skeleton en tut02-skeleton, I h=
ave a
> question about the context_size in the rtdm_device struct.
>=20
> In tut01-skeleton-drv.c, the context_size =3D sizeof(buffer_t), in the =
other
> example context_size =3D 0. Both drivers uses the
> rtdm_safe_copy_to_user/rtdm_safe_copy_from_user functions to write/read=
 data
> from buffer_t(kernel space) to user_space. So I don't understand why th=
e
> context_size in tut02 is different than in tut01. Or is the context_siz=
e
> only important if we open the driver several times from one or more
> user_space programs?

The context size is important in case you want to attach some data to
each opened instance of a device. Hmm, but this is something neither
tut01 nor tut02 deals with optimally. tut02 cannot use a context-based
buffer, because it uses two device instances (opened by two instances of
the user space program) to transfer the data. But tut01 could use some
global buffer as well without loosing a feature.

Philippe (trem), could you rework tut01 and make it use a global buffer
instead? Then some tut03 would be nice to explain what per context, per
device, and global data means. I've seen confusion about this fairly
often, so a dedicated tutorial would be great.

Thanks,
Jan


--------------enig2194A3708C5E69EFDC4C47A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGxJBwniDOoMHTA+kRAjULAJ0XwHEsuNrZuVaQ/JCad2Jj8pVwJACePN7p
grQPymdd/5vKUSSUOuNPurc=
=VBen
-----END PGP SIGNATURE-----

--------------enig2194A3708C5E69EFDC4C47A4--

