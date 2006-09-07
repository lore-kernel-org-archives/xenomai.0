Message-ID: <44FFF5FF.2000106@domain.hid>
Date: Thu, 07 Sep 2006 12:35:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Porting / API Questions
References: <44FF3C26.10501@domain.hid>
In-Reply-To: <44FF3C26.10501@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA557C04258842DA6C92BED5"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA557C04258842DA6C92BED5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
>=20
> I am attempting to port a real-time simulation from rtlinux3.2-pre3
> (GPL) to xenomai.  The application consists of a kernel module, and a
> user-space application.  I would like to port the application to xenoma=
i
> with as few changes as possible, and then make improvements in
> incremental steps.  I am currently working on a Fedora Core I,
> Linux-2.4.32 / xenomai-2.1-rc4 system.
>=20
> In this simulation, we use the rtlinux POSIX-like API for threads,
> timing, and writing-to / reading-from real-time FIFOs.  It looks like
> the xeno_posix API will allow me to port the thread and timing code wit=
h
> very few (if any) changes.  There does not appear to be a kernel-space
> version of read and write for use on xenomai pipes.  Am I missing
> something?

For what side, RT or non-RT? Or what service (function name) is missing
precisely?

>=20
> I noticed that the rtai API appears to support real-time FIFOs, much
> like the old RTLinux API.  In light of this discovery, I changed my
> RT-Linux code to use rtf_get and rtf_put calls (instead of read/write).=
=20
> This code seems to compile for xeno_rtai without too much trouble.
>=20
> Is it okay to use the POSIX API for threads and timing, and the rtai AP=
I
> for FIFOs?  It seems like this is working, but I want to make sure that=

> there are no hidden problems.

I haven't used the RTAI skin so far, but from a look at the FIFO code I
cannot find any reasons for not using it with other skins.

>=20
> I have compiled my application for xenomai.  The kernel module loads
> fine, and the userspace application runs as well.  The problem I am
> having now is creating a large FIFO, which is why I wrote the previous
> email.
>=20
> Any input on this porting project would be appreciated.  Thanks!
>=20
> -Jeff
>=20

Jan


--------------enigAA557C04258842DA6C92BED5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE//X/niDOoMHTA+kRAviBAJwP9aAQ9RX0Af+1cfnBoXCk/Mve9gCeLApn
zhP4pE99LsoiW9x9Aw2rhTY=
=Ack3
-----END PGP SIGNATURE-----

--------------enigAA557C04258842DA6C92BED5--

