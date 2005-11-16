Message-ID: <437AE923.7020004@domain.hid>
Date: Wed, 16 Nov 2005 09:09:07 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DC013DF1EAB95D8FFE4941B"
Subject: [Xenomai-core] Question about shadow migration
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DC013DF1EAB95D8FFE4941B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I'm currently trying to confirm my understanding of what precisely
happens during a switch-back of a shadow thread from primary to
secondary mode. I guess the thrilling things happen in xnshadow_relax().
The shadow enters in primary and leaves in secondary.

The question for me is now if I got these details right: first a
migration request is issued [1] but not immediately executed, then the
priority of the root thread (Linux) is lifted to the one of the shadow
thread [2], and then the shadow thread is suspend with respect to the
xenomai scheduler [3]. The last step should let the Linux kernel start
over again, run to its next preemption point (and this is the region
where non-deterministic delays may be injected with current kernels,
isn't it?), and switch over to lostage_handler() [4] to resume the Linux
part of the shadow thread. After that the execution of the shadow, now
in secondary mode, continues in xnshadow_relax() after [3]. Am I right?

Thanks,
Jan


[1] www.rts.uni-hannover.de/xenomai/lxr/source/nucleus/shadow.c#L540
[2] www.rts.uni-hannover.de/xenomai/lxr/source/nucleus/shadow.c#L542
[3] www.rts.uni-hannover.de/xenomai/lxr/source/nucleus/shadow.c#L543
[4] www.rts.uni-hannover.de/xenomai/lxr/source/nucleus/shadow.c#L254

--------------enig6DC013DF1EAB95D8FFE4941B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDeukjncNeS9Q0k+IRAstaAJ9/l+AFR8bw+JzbyA/AARE3fs9aVgCcDKJz
JrNV/P4z6uNWGggfgVVkb3E=
=zVuN
-----END PGP SIGNATURE-----

--------------enig6DC013DF1EAB95D8FFE4941B--

