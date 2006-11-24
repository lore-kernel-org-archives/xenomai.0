Message-ID: <4566F934.9070905@domain.hid>
Date: Fri, 24 Nov 2006 14:52:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN update, please read
References: <4566F619.9060403@domain.hid>
In-Reply-To: <4566F619.9060403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A9070080570F8337D5F6678"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A9070080570F8337D5F6678
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I have just commited various modifications and improvements for
> RT-Socket-CAN to the SVN trunk (v2.3-devel). The modification you might=

> realize sooner than later is the renaming of the RT-Socket-CAN kernel
> modules from "xeno_rtcan_*" to "xeno_can_*" to comply with the usual
> RTDM driver naming scheme. I have attached the full ChangeLog entry.

One wish for the future: if possible, please try to break up such large
commits into smaller pieces. They should be compilable on their own in
order to hunt potential issues (also with the help of users) on a more
fine-grained base by switching back and forth svn revisions. quilt can
help to manage such pieces, I'm using it even for private stuff.

Thanks,
Jan


--------------enig6A9070080570F8337D5F6678
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZvk0niDOoMHTA+kRAuIKAJ426H4A+4Kib7vMignKrSHJOVu+rACbBEMz
XIndckk7oyQb1va03iBt77o=
=Lb9q
-----END PGP SIGNATURE-----

--------------enig6A9070080570F8337D5F6678--

