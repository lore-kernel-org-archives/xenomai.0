Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2008 14:14:02 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFF0F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <478FC490.5090708@domain.hid>
From: <Thomas.Debes@domain.hid>
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> -----Urspr=FCngliche Nachricht-----
> Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
> Gesendet: Donnerstag, 17. Januar 2008 22:12
> An: Debes, Thomas RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Modeswitch using message queues
>=20
> Thomas.Debes@domain.hid wrote:
> > Hello,
> >=20
> > I am writing a communication daemon based on Xenomai message queues=20
> > (using native skin). This daemon creates a queue und starts=20
> listening=20
> > for incoming client messages. A client can open a "connection" by=20
> > binding to the daemons queue and sending a special message=20
> containing=20
> > ist own queuename. Thereafter the daemon binds to the=20
> client queue and=20
> > sends back a response message. "Disconnecting" works the same way.
> > Everything works as expected, the only thing is that the=20
> mode switch=20
> > counter in /proc/xenomai/stat increases on each=20
> > rt_bind_queue/rt_unbind_queue call (for the daemon and the=20
> client). I=20
> > tracked this back by adding a signal handler for SIGXCPU=20
> and setting=20
> > the T_WARNSW bit in my realtime task. The gdb backtrace=20
> output shows=20
> > the
> > nunmap(..) as last call before the mode switch occurs.
> >=20
> > Program received signal SIGXCPU, CPU time limit exceeded.
> > [Switching to Thread 16386 (LWP 520)]
> > 0x0fddb7d8 in munmap () from /lib/libc.so.6
> > (gdb) bt
> > #0  0x0fddb7d8 in munmap () from /lib/libc.so.6
> > #1  0x0fe829d8 in rt_queue_unbind (q=3D0x1003a1b6) at queue.c:100
> > #2  0x100084d4 in remove_connection (client_address=3D17) at=20
> > src/proto_mqc.c:1610
> > #3  0x10006230 in eval_disconnect_msg (connection=3D0x30036240,
> >     in_msg=3D0x300362b0) at src/proto_mqc.c:793
> > #4  0x10005cd4 in eval_msg (connection=3D0x30036240,=20
> in_msg=3D0x300362b0)
> >     at src/proto_mqc.c:634
> > #5  0x10005ba8 in proto_mqc_handler (msg=3D0x300362b0) at
> > src/proto_mqc.c:598
> > #6  0x1000399c in dispatch_message (msg=3D0x300362b0) at
> > src/dispatch.c:236
> > #7  0x10003c38 in dispatch (cookie=3D0x0) at src/dispatch.c:309
> > #8  0x0fe835f0 in rt_task_trampoline (cookie=3D0x0) at task.c:95
> > #9  0x0fba8920 in pthread_start_thread_event (arg=3D0x30036be0) at=20
> > manager.c:300 #10 0x0fddedc4 in clone () from /lib/libc.so.6
> > (gdb) c
> >=20
> >=20
> > All queue related functions (except create/delete) are called from=20
> > realtime tasks. The daemon itself and all other=20
> applications are user=20
> > space programs. So from my point of view, mode switches shouldn't=20
> > occur here.
>=20
> Native queues are designed for efficient data transfer also=20
> of larger blocks, i.e. without copying. Therefore, when you=20
> establish a communication channel based on a queue between=20
> two processes, both have to map the underlying buffer into=20
> their address spaces. This means leaving RT land.
>=20
> I think you have to redesign your communication protocol with=20
> this fact in mind, so that you can avoiding continuous=20
> reconnections. Those which are still required for clients=20
> joining the party, could be handled by splitting up the=20
> daemon into two threads: one for time-critical communication,=20
> the other for low-prio connection setup/cleanup.
>=20
> An alternative would be an IPC scheme that requires at least=20
> one copy-step (from the sender's into the receiver's buffer).=20
> We once did this for the RACK RT-middleware based on RTDM=20
> sockets [1] (it's a bit "specialised").
>=20
> Jan
>=20
> [1] http://svn.berlios.de/viewcvs/rack/trunk/rack/main/tims/driver/
>

Thanks for your help, I'll rewrite the connection setup stuff by putting =
it into a separate task.

Regards
Thomas=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

