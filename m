Message-ID: <4AEE8FA7.7040804@domain.hid>
Date: Mon, 02 Nov 2009 08:52:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <ba9b368a0911012316h393aae27y7418e74b2c8a8428@domain.hid>
In-Reply-To: <ba9b368a0911012316h393aae27y7418e74b2c8a8428@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE087FB683D2F624DC44BB1FF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] A few questions about rt_printf
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Adams <dadams81@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE087FB683D2F624DC44BB1FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Adams wrote:
> Hi,
>=20
> I was looking at using the rt_printf / rt_fprintf for doing deferred lo=
gging
> and I have a few questions.
>=20
> 1) I was reading through the source and I noticed there is no locking o=
f the
> buffer write_pos between tasks during the initial snprint into the buff=
er.
> Is the rt_printf service thread safe? There are calls to
> xnarch_read_memory_barrier() and xnarch_write_memory_barrier(), but I'm=

> assuming they are for SMP and IO ordering although I'm not 100% on what=
 the
> barriers imply as I'm fairly new to this kind of hardware.

rt_printf buffers are single-writer/single-reader (one per thread)
lock-less ring buffers, they are safe on both UP and SMP.

>=20
> 2) Can the service be called from Linux tasks and Xenomai tasks? We wer=
e
> trying to get away with a common logging interface (wrapping the servic=
e)
> which would allow writing to different streams. If it can't be called f=
rom a
> Linux process then we will have an issue if we try to write to the same=

> stream from different write tasks.

Yes, in fact the rr_printf/syslog services of rtdk even work without a
single bit of Xenomai, so they can be used in any context.

>=20
> 3) Why is there multiple buffers allowing multiple FIFO's. I've read th=
e
> code and can't really see how the extra buffers are used from a users
> perspective (I can see how the service prints / manages them). It appea=
rs
> that whatever buffer you create with rt_print_init or rt_auto_init is t=
he
> buffer that get's used for writing too. Is there a way to select the bu=
ffer
> you want to write to? Also a call to rt_print_init causes a pre-existin=
g
> buffer to be written to io from within the callers context and then cre=
ates
> a new buffer / ring buffer, so that no matter what you are always writi=
ng to
> the head of the linked list of buffers. How do I get access to an old b=
uffer
> once it has been printed? Is there something I'm missing?

See above, buffers are per thread so that we don't need locking.

>=20
> I really think I must be missing something, sorry if these are obvious
> questions.
>=20
> Thanks
>=20
> Dan Adams
>=20

HTH,
Jan


--------------enigE087FB683D2F624DC44BB1FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkruj6cACgkQitSsb3rl5xR1BACcDgP1fpODfSgXHi1hhhjejhz1
d9wAn35B+glg2I5owTvOni9klClNQOPl
=f+QE
-----END PGP SIGNATURE-----

--------------enigE087FB683D2F624DC44BB1FF--

