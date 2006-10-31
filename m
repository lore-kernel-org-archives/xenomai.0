Message-ID: <45478914.4030309@domain.hid>
Date: Tue, 31 Oct 2006 18:34:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] My work on Xenomai integration to LTTng / LTTV
References: <1162302832.3687.12.camel@domain.hid>
In-Reply-To: <1162302832.3687.12.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB768F1292A54BC9660753F7A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jean-olivier.villemure@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB768F1292A54BC9660753F7A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jean-Olivier Villemure wrote:
> Hello,
>=20
> I'm currently working on the integration of Xenomai tracing in LTTng
> (Linux Trace Toolkit Next Generation) and the event viewing in LTTV
> (Linux Trace Toolkit Viewer).
>=20
> At this moment, I 'm tracing events about task handling, period and
> soon, mutex and semaphore synchronization.

Wow, great news!

>=20
> Inserting traqcing points in Xenomai nucleus is not very difficult, my
> main work is focus on the controlflow viewer module of LTTV. At this
> moment, we can open a trace and view:
> - Task state : init, started, running, suspended, overrunning (period
> miss)
> - Period timer tick for periodic task
> - Textual information about the task (name, period, priority, birth)
> - Mutex/semaphore owned by specific task
> - Soon task waiting on mutex/semaphore
>=20
> Look at the screenshot to have a better idea.
>=20
> The next step will be to generate some statistics, for this step I will=

> need your help. As Xenomai users, which kind of stats would you want to=

> compute?

 - CPU usage (see /proc/xenomai/stat for average numbers, but we should
   now be able to precisely calculate them for a specific period)
 - Waiting times after activation (maybe one can define deadlines later
   and verify them)
 - Number of preemptions per second or whatever while a task is runnable
 - Number of blockades a task faces due to unavailable resources
   (mutexes, semaphores, etc.)

=2E..just to through some first ideas in.

>=20
> After that, I'll study the possibilities of simulating an execution
> trace from an existing trace by modifying some parameters (period
> length, ...)
>=20
> Any ideas are welcome!

So you have an integrated I-pipe+LTTng patch which is able to record
events under any context and push them to Linux non-RT user-space,
right? How does this work, what impact does it have (also compared to
the I-pipe tracer, which is not light-weight)? And, most important, when
will we be able to see some code (ipipe add-on patch)? Would be good to
assess how this could be integrated on the long term into
I-pipe/Xenomai, at least until required LTTng parts become mainstream.

Jan


--------------enigB768F1292A54BC9660753F7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFR4kUniDOoMHTA+kRAh6EAJ91iXR5ZDJ/4fdCKr2cmdU4jmWoAwCfbolm
/bib9MuwFE3mpBvKahbmwro=
=CsYn
-----END PGP SIGNATURE-----

--------------enigB768F1292A54BC9660753F7A--

