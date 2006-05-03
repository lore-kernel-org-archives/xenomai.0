Message-ID: <44589714.10800@domain.hid>
Date: Wed, 03 May 2006 13:42:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Buffer Overrun -> Kernel Explosion
References: <6ee4c8380604272202q3109a3b9n71e0327de76730b8@domain.hid>
In-Reply-To: <6ee4c8380604272202q3109a3b9n71e0327de76730b8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3372C2140C4E38DA85BCA4B5"
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
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3372C2140C4E38DA85BCA4B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
> I'm finally set up with netconsole to catch panics/crashes when they
> happen so now I can report more information on the one I alluded to a
> week or two ago in my "General Question.." thread.
>=20
> What I did to cause it was write past the end of a buffer returned by
> rt_queue_alloc. I'm not entirely sure if this message came at the
> moment of the write (unlikely, IMHO) or later when more xnheap
> activity took place. The crash popped up in several different ways
> depending on what code paths I enabled/disabled.
>=20
> What concerns me is that polluting an xnheap can bring the system to
> its knees so harshly. I can see why it could be *very* hard to police
> this sort of problem without destroying the performance of xnheap, so
> it wouldn't surprise me if this is "normal". Still, though, it's sad
> that user-space code can bring the system down after something as
> innocent as a fencepost error in a string copy routine...
>=20
> Thoughts? I've pasted the console dump below.
>=20

I remember that control structures and data are tightly knotted in
xnheaps, but I agree with you that this should not lead so easily to
such crashes for user space apps. Maybe some magic number check could
help to reduce the chance for now.

A cleaner long-term solution would be to decouple both regions.
Philippe, is this feasible (I'm not that deep in the internals of xnheap)=
?

Jan


--------------enig3372C2140C4E38DA85BCA4B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWJcUniDOoMHTA+kRAnXcAJ98+3mI5WU3avhHf/a1nXPDEizp6ACdEo6j
p/9OMAnmiMMT9awEm9+VUn0=
=POg6
-----END PGP SIGNATURE-----

--------------enig3372C2140C4E38DA85BCA4B5--

