Message-ID: <4565C4E0.8000502@domain.hid>
Date: Thu, 23 Nov 2006 16:57:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Debugging in Xenomai
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59C0255DEC4614464C1BF8B0"
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59C0255DEC4614464C1BF8B0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Hi,
> =20
> our application deadlocks from time to time.=20
> =20
> To isolate which of the threads are deadlocked, I look into
> /proc/xenomai/stat. Here I can see if there are context switches
> happening or not. Further I can see which threads have which PID and
> which task state they are into. One of the task states that is not clea=
r
> to me btw is the state "X" or "relaxed shadow". Anybody ?

Thread is pending in secondary mode on some Linux resource.

> =20
> So after gathering that I have some basic idea which of the threads is
> having a deadlock and now the question is, how to continue ?
> =20
> One of the next steps would be finding out which actual function back
> trace the suspicious thread has. So I execute gdb and try to attach to
> the appropriate process, which works. Problem: sending Ctrl-C doesn't
> work, independant of if gdb is executed via ssh or serial console. So I=

> cannot stop the actual program beeing debugged, rendering the gdb
> approach useless. Also sending SIGINT to the GDB process doesn't work.
> It seems to be simply ignored. As I understand CTRL-C is effectively
> sending SIGINT and is sent to GDB itself and not to the underlying appl=
=2E

I would say there is a bug, either in gdb or in Xenomai. Does debugging
in general work on your box, i.e. without Xenomai? Does it fail with any
trivial Xenomai application? What version? On PPC? If there is a bug
/wrt Xenomai, it has to be fixed.

> =20
> Of course I always can insert logger output strings. I even wrote a
> logger that doesn't force to switch the process into secondary mode. I
> just thought we might have something that gives a developer a more
> effective way of fastly finding out which task has which actual back
> trace.

Already tried strace? It may help to understand more if your thread
hangs in secondary mode.

Beyond that, we are all desperately waiting for LTTng... :)

> =20
> Under VxWorks there is a very elegant way of debugging with the help of=

> the userLib. Of course this is possible here because VxWorks makes no
> distinction between user and kernel space and the shell itself is
> running as a task having access to symbol tables etc. You can say "i"
> which gives a similar output as /proc/xenomai/stat but with much more
> informations like stack size, actual stack consumption, actual executed=

> function pointer, etc. "b" gives you a global breakpoint for any
> function. One can get stack traces without the help of gdb via "tt",
> etc. etc.
> =20
> In Xenomai I suppose the actual stack execution pointer, stack size,
> etc. of a task has to be available to the kernel as well, so
> principially it should be possible to provide more informations than
> what /proc/xenomai/stat or /proc/xenomai/sched provide. Those migrating=

> from VxWorks (and many others probably as well) would certainly like
> that.
> =20
> How do the Xenomai veterans debug their application in case of deadlock=
s
> / synchronization errors, crashes etc. ?

Log message instrumentation (we also have such a RT-safe mechanism),
meditating on the code (better: let someone else meditate that looks at
it from a different angle), gdb (at least on x86 we had no problems so fa=
r).

Jan


--------------enig59C0255DEC4614464C1BF8B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZcTgniDOoMHTA+kRArp5AJ9w18VL90gY2qL2Kcu8C5HgsGcNwwCbBURz
0fEvtyp9xGw/71RUI7HD1Yc=
=Elld
-----END PGP SIGNATURE-----

--------------enig59C0255DEC4614464C1BF8B0--

