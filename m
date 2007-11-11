Message-ID: <47373B12.7020808@domain.hid>
Date: Sun, 11 Nov 2007 18:25:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16433DDCE62B40486EB12211"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] x86_64: problems with syscall tracing?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16433DDCE62B40486EB12211
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe,

you recently said there is a bug in the x86_64 support when syscall
tracing is enabled. Now I think I stepped on it as well: In order to
validate my APIC frequency patches for that arch, I wanted to use LTTng
there. But as soon as I start the trace, the latency test fails to run,
prematurely exiting due to a segfault. Gdb and the kernel say that user
land jumped to address 0, I just yet failed to find out where they come
from. I strongly assume LTTng enables syscall tracing, because its
entry/exit instrumentations are inside the hook function
(syscall_trace_entry/leave).

Do you have any further details on your tracing issue? Does may
observation correlates with yours?

Jan


--------------enig16433DDCE62B40486EB12211
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFHNzsWniDOoMHTA+kRAtTKAJ498UJeVqBPKBIAdG/Xd6thWnYz1gCXWW+m
NsuiHnXgQ3c+xbkNL0B+pg==
=nhqT
-----END PGP SIGNATURE-----

--------------enig16433DDCE62B40486EB12211--

