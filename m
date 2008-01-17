Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jan 2008 20:49:33 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFF0B@ARVMAIL1.mra.roland-man.biz>
From: <Thomas.Debes@domain.hid>
Subject: [Xenomai-help] Modeswitch using message queues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I am writing a communication daemon based on Xenomai message queues
(using native skin). This daemon creates a queue und starts listening
for incoming client messages. A client can open a "connection" by
binding to the daemons queue and sending a special message containing
ist own queuename. Thereafter the daemon binds to the client queue and
sends back a response message. "Disconnecting" works the same way.
Everything works as expected, the only thing is that the mode switch
counter in /proc/xenomai/stat increases on each
rt_bind_queue/rt_unbind_queue call (for the daemon and the client). I
tracked this back by adding a signal handler for SIGXCPU and setting the
T_WARNSW bit in my realtime task. The gdb backtrace output shows the
nunmap(..) as last call before the mode switch occurs.

Program received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread 16386 (LWP 520)]
0x0fddb7d8 in munmap () from /lib/libc.so.6
(gdb) bt
#0  0x0fddb7d8 in munmap () from /lib/libc.so.6
#1  0x0fe829d8 in rt_queue_unbind (q=3D0x1003a1b6) at queue.c:100
#2  0x100084d4 in remove_connection (client_address=3D17) at
src/proto_mqc.c:1610
#3  0x10006230 in eval_disconnect_msg (connection=3D0x30036240,
    in_msg=3D0x300362b0) at src/proto_mqc.c:793
#4  0x10005cd4 in eval_msg (connection=3D0x30036240, =
in_msg=3D0x300362b0)
    at src/proto_mqc.c:634
#5  0x10005ba8 in proto_mqc_handler (msg=3D0x300362b0) at
src/proto_mqc.c:598
#6  0x1000399c in dispatch_message (msg=3D0x300362b0) at
src/dispatch.c:236
#7  0x10003c38 in dispatch (cookie=3D0x0) at src/dispatch.c:309
#8  0x0fe835f0 in rt_task_trampoline (cookie=3D0x0) at task.c:95
#9  0x0fba8920 in pthread_start_thread_event (arg=3D0x30036be0) at
manager.c:300
#10 0x0fddedc4 in clone () from /lib/libc.so.6
(gdb) c


All queue related functions (except create/delete) are called from
realtime tasks. The daemon itself and all other applications are user
space programs. So from my point of view, mode switches shouldn't occur
here.

Thanks for your help

Thomas=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

