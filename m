Message-ID: <44D0F72E.3020406@domain.hid>
Date: Wed, 02 Aug 2006 21:04:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
References: <200608021808.18076@domain.hid>
In-Reply-To: <200608021808.18076@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig512553FBDA653F73FD9CF47C"
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig512553FBDA653F73FD9CF47C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
> I have Xenomai snapshot (18.5.2006,  2.1.1 ~ 2.1.2) and userspace=20
> application. I need to exchange lot of data between two tasks=20
> (producer -> consumer) with some buffer in the middle. I used=20
> rt_pipe/linux device scheme, but I realised that the preformance is=20
> very low. (At least some performance monitor showed it)

Could you elaborate on this? Does the performance monitor (which one?)
tell you more details? What is the characteristic of your transferred
data (size, frequency)?

> So I tried to use rt_queue. But when I tried to read from queue with
> timeout (or TM_INFINITE), I got an EPERM error. That means: "service
> should block, but was called from a context, which cannot sleep.".
> But I want to sleep (and wait for new data). Where is the problem? Do
> you have any advice?

Is the read of the queue a Xenomai thread? It has to be, even if it will
mostly run in secondary (Linux) mode. Check also /proc/xenomai/sched
when you think it should be.

Maybe what you really want is shared memory between producer and
consumer. If the consumer is mapped to Xenomai, you can even use normal
synchronisation (mutexes/semaphores) to control the access - or design
something lock-less.

Jan


--------------enig512553FBDA653F73FD9CF47C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0PcuniDOoMHTA+kRAtVFAJwIcHYOGGQHYoLpLypRBRrHmsti6wCfQU1g
BB/QLes7P2M0EjovbL4p6eg=
=Snn3
-----END PGP SIGNATURE-----

--------------enig512553FBDA653F73FD9CF47C--

