Message-ID: <478FC490.5090708@domain.hid>
Date: Thu, 17 Jan 2008 22:11:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFF0B@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFF0B@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2E956BF79992FBF7CD993C70"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Modeswitch using message queues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas.Debes@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E956BF79992FBF7CD993C70
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Thomas.Debes@domain.hid wrote:
> Hello,
>=20
> I am writing a communication daemon based on Xenomai message queues
> (using native skin). This daemon creates a queue und starts listening
> for incoming client messages. A client can open a "connection" by
> binding to the daemons queue and sending a special message containing
> ist own queuename. Thereafter the daemon binds to the client queue and
> sends back a response message. "Disconnecting" works the same way.
> Everything works as expected, the only thing is that the mode switch
> counter in /proc/xenomai/stat increases on each
> rt_bind_queue/rt_unbind_queue call (for the daemon and the client). I
> tracked this back by adding a signal handler for SIGXCPU and setting th=
e
> T_WARNSW bit in my realtime task. The gdb backtrace output shows the
> nunmap(..) as last call before the mode switch occurs.
>=20
> Program received signal SIGXCPU, CPU time limit exceeded.
> [Switching to Thread 16386 (LWP 520)]
> 0x0fddb7d8 in munmap () from /lib/libc.so.6
> (gdb) bt
> #0  0x0fddb7d8 in munmap () from /lib/libc.so.6
> #1  0x0fe829d8 in rt_queue_unbind (q=3D0x1003a1b6) at queue.c:100
> #2  0x100084d4 in remove_connection (client_address=3D17) at
> src/proto_mqc.c:1610
> #3  0x10006230 in eval_disconnect_msg (connection=3D0x30036240,
>     in_msg=3D0x300362b0) at src/proto_mqc.c:793
> #4  0x10005cd4 in eval_msg (connection=3D0x30036240, in_msg=3D0x300362b=
0)
>     at src/proto_mqc.c:634
> #5  0x10005ba8 in proto_mqc_handler (msg=3D0x300362b0) at
> src/proto_mqc.c:598
> #6  0x1000399c in dispatch_message (msg=3D0x300362b0) at
> src/dispatch.c:236
> #7  0x10003c38 in dispatch (cookie=3D0x0) at src/dispatch.c:309
> #8  0x0fe835f0 in rt_task_trampoline (cookie=3D0x0) at task.c:95
> #9  0x0fba8920 in pthread_start_thread_event (arg=3D0x30036be0) at
> manager.c:300
> #10 0x0fddedc4 in clone () from /lib/libc.so.6
> (gdb) c
>=20
>=20
> All queue related functions (except create/delete) are called from
> realtime tasks. The daemon itself and all other applications are user
> space programs. So from my point of view, mode switches shouldn't occur=

> here.

Native queues are designed for efficient data transfer also of larger=20
blocks, i.e. without copying. Therefore, when you establish a=20
communication channel based on a queue between two processes, both have=20
to map the underlying buffer into their address spaces. This means=20
leaving RT land.

I think you have to redesign your communication protocol with this fact=20
in mind, so that you can avoiding continuous reconnections. Those which=20
are still required for clients joining the party, could be handled by=20
splitting up the daemon into two threads: one for time-critical=20
communication, the other for low-prio connection setup/cleanup.

An alternative would be an IPC scheme that requires at least one=20
copy-step (from the sender's into the receiver's buffer). We once did=20
this for the RACK RT-middleware based on RTDM sockets [1] (it's a bit=20
"specialised").

Jan

[1] http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver/


--------------enig2E956BF79992FBF7CD993C70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHj8SRniDOoMHTA+kRAvZaAJ965QHAuoJ2ouvm+/nB5ZY6jU9q4QCeIQSd
/1l6rfttRq5mCeOlUDRkwxE=
=ORmt
-----END PGP SIGNATURE-----

--------------enig2E956BF79992FBF7CD993C70--

