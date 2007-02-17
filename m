Message-ID: <45D6C540.9020707@domain.hid>
Date: Sat, 17 Feb 2007 10:05:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] tracer from user space
References: <200702161558.01839.jweber@domain.hid>
In-Reply-To: <200702161558.01839.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF8F7A7CD5968AA074FDFAAB0"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8F7A7CD5968AA074FDFAAB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> I need to isolate an unacceptable latency resuming a primary mode task,=
 by=20
> determining the events the events that preceeded the delay, preferably =
from=20
> userspace.  I cannot rule out a userspace coding error contributing to =
the=20
> latency.
>=20
> Is this a job better suited to task switch hooks, or the ipipe tracer, =
or=20
> perhaps yet another tool?

Hard to say, but often the tracer is a good starting point, at least to
rule out certain causes.

>=20
> Assuming the best tool is the ipipe tracer, because task switch hooks m=
ust be=20
> used from kernel space, how much can I learn about the user space tasks=
 and=20
> function calls that preceeded the latency?
>=20
> (All the sample tracer output I've found has shown kernel function call=
=20
> activity.)

The tracer can only record in-kernel function calls and special
instrumented spots (Xenomai task switches e.g.). Given your user space
app generates some minimal syscall "load", you can indirectly observe
what happens. If it decides to just spin for a few milliseconds or so,
then you will have to look for a different approach. (*)

>=20
> What is the minimum ipipe patch to have useful tracer functionality?
> (I'm currently using Linux-2.6.17.14 + adeos-ipipe-2.6.17-i386-1.5-00 +=
=20
> xenomai-2.2.4 )

That patch already included a full-functional tracer, you just have to
enable it in the kernel config.

I guess you've already read the tracer-dedicated page on xenomai.org.
It's unfinished, so feel free to kick me if some specific explanation
should be added - or add helpful hints on your own.

Jan


(*) I just rolled out a simple framework for user-space tracing, see
xenomai-core list. It allows to instrument your code unintrusively,
without stepping out of primary mode: rt_printf. Based on it, syscall
tracing is feasible as well ("rt-strace"). The patches are trunk-based,
but its core, librtprint, can also be broken out.



--------------enigF8F7A7CD5968AA074FDFAAB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF1sVAniDOoMHTA+kRAh5DAJ9Ol/aTv3IjTGtrQk4Ca/63oZdsfACfQOC9
tl3kqo0Al97WKnUQsVde0qk=
=rbqM
-----END PGP SIGNATURE-----

--------------enigF8F7A7CD5968AA074FDFAAB0--

