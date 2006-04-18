Message-ID: <44455471.8090001@domain.hid>
Date: Tue, 18 Apr 2006 23:04:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>	
	<4443992C.5000808@domain.hid>
	<6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>
In-Reply-To: <6ee4c8380604181253t235363a9v79d91b57bea4575a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35205C1F241E4112A5C607C9"
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
--------------enig35205C1F241E4112A5C607C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
> Ok; What xenomai priority in the 1-99 scheme corresponds to the
> priority of normal user-level posix threads?

Depends on the mode of your xenomai thread: when in primary mode (the
hard-rt mode where the xeno threads live by default), those 99 levels
are actually above all linux priorities.

But when your thread enters secondary mode to issue some linux syscall
or handle a normal signal, its priority gets mapped 1:1 on the linux
range. This means, e.g., that a xenomai thread with prio 50 in secondary
mode gets overruled by a normal linux thread with prio 60 but not by a
xenomai thread in primary mode even with prio 1.

>=20
> The application I'm building has realtime and non-realtime components
> which share some native-skin objects. I am constructing my
> time-critical and non-time-critical threads using rt_task_create. I
> would like almost all of them to behave exactly as ordinary
> non-xenomai posix threads do with regard to priority and starvation.

Why do you create the non-rt threads also via rt_task_create? This just
introduces unneeded load on the RT subsystem.

>=20
> The example was contrived to support my question. In practice, I do
> call mlockall. Also, my development machine has no swap space, so
> mlockall probably shouldn't have an effect.

I does, thanks to the lacy memory allocation scheme of glibc (alloc on
access).

>=20
> What does this watchdog do and where is it documented? I'm surprised I
> haven't heard it mentioned before, since it seems rather important.

It's a kernel option (isn't it mentioned somewhere in the docs? then it
needs fixing).

The scheme is that after 4 seconds (if I remember the number correctly)
of continuous xenomai activity with linux leaving no breath, the
currently running xenomai thread gets suspended. This may be the wrong
one when you are unlucky, but then one of the next round will hit the
offender. We may think about improving this scheme a bit (suspending the
lowest-prio thread?). I helps to return your system to "interactive
mode", analysing what went wrong and maybe cleaning it up.

>=20
> So far, I've not intended to introduce any "real-time" features; What
> I'm doing is very vanilla stuff that I'd normally do with pthreads.
>=20
> Brian
>=20

Jan


--------------enig35205C1F241E4112A5C607C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERVRyniDOoMHTA+kRAv/2AJ93a9fMfEeGwEDxWlrKjjz/6M1wvACeOlls
3dTrCOTqL/nxJZzTQnttQ+w=
=r/w1
-----END PGP SIGNATURE-----

--------------enig35205C1F241E4112A5C607C9--

