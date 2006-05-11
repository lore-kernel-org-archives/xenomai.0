Message-ID: <446364DB.50908@domain.hid>
Date: Thu, 11 May 2006 18:22:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA9CAC914126D8A138AE2D189"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Stalled xenomai domain with head-optimisation
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
--------------enigA9CAC914126D8A138AE2D189
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I had a bit "fun" today trying to get some of our robotic hardware
running with latest Xenomai / Ipipe, also in order to test recent RTDM
fixes. It turned out that the head-optimised variant easily creates that
infamous stalled Xenomai domain, e.g. like this one:

> :     fn                 -212+   3.323  sched_clock+0xd (schedule+0x112=
)
> :     fn                 -209+   2.045  __ipipe_stall_root+0x8 (schedul=
e+0x18e)
> :    *fn                 -207+   1.428  deactivate_task+0x9 (schedule+0=
x21e)
> :    *fn                 -205+   4.417  dequeue_task+0xa (deactivate_ta=
sk+0x1a)
> :    *fn                 -201+   2.635  recalc_task_prio+0xd (schedule+=
0x317)
> :    *fn                 -198+   2.345  effective_prio+0x9 (recalc_task=
_prio+0x108)
> :    *fn                 -196+   3.443  requeue_task+0xa (schedule+0x34=
4)
> :    *fn                 -192+   2.582  __ipipe_dispatch_event+0xe (sch=
edule+0x412)
> :    *fn                 -190!  11.808  schedule_event+0xd (__ipipe_dis=
patch_event+0x5e)
> :|   *fn                 -178+   8.135  __switch_to+0xc (schedule+0x4fe=
)
> :    *fn                 -170+   3.714  __ipipe_unstall_root+0x8 (sched=
ule+0x536)
> :     fn                 -166+   2.105  finish_wait+0xa (xnpipe_read+0x=
17c)
> :     fn                 -164+   1.368  __ipipe_test_and_stall_root+0x8=
 (finish_wait+0xae)
> :    *fn                 -163+   1.203  __ipipe_restore_root+0x8 (finis=
h_wait+0x70)
> :    *fn                 -161+   6.210  __ipipe_unstall_root+0x8 (__ipi=
pe_restore_root+0x2b)
> :|  * fn                 -155+   1.706  fput+0x8 (sys_read+0x5d)
> :|  * fn                 -153+   2.413  __ipipe_stall_root+0x8 (syscall=
_exit+0x5)
> :   **fn                 -151+   1.984  do_notify_resume+0x9 (work_noti=
fysig+0x13)
> :   **fn                 -149+   1.894  do_signal+0x11 (do_notify_resum=
e+0x2f)
> :   **fn                 -147+   1.330  get_signal_to_deliver+0xe (do_s=
ignal+0x4a)
> :   **fn                 -146+   2.022  __ipipe_stall_root+0x8 (get_sig=
nal_to_deliver+0x24)
> :   **fn                 -144+   2.060  dequeue_signal+0xb (get_signal_=
to_deliver+0xe9)
> :   **fn                 -142+   2.030  __dequeue_signal+0xe (dequeue_s=
ignal+0x21)
> :   **fn                 -140+   1.902  next_signal+0x9 (__dequeue_sign=
al+0x1c)

This does not happen when I switch off Xenomai's head-optimisation. I
took this trace by patching shadow.c like this:

--- ksrc/nucleus/shadow.c       (revision 1074)
+++ ksrc/nucleus/shadow.c       (working copy)
@@ -1096,6 +1096,8 @@ static inline int do_hisyscall_event(uns
     xnthread_t *thread;
     u_long sysflags;

+    if (test_bit(IPIPE_STALL_FLAG, &rthal_domain.cpudata[0].status))
+        ipipe_trace_freeze(0);
     if (!nkpod || testbits(nkpod->status, XNPIDLE))
         goto no_skin;


You can reproduce the problem without special hardware by loading the
tims.ko module of our RACK framework [1], then starting tims_msg_client
(main/tims/router), and finally terminating it with ^C. The issue seems
to be somehow related to the pipe usage of TiMS.


Besides these bad news, there is fortunately also a lot of light: The
RTDM fixes and reorganisation did not cause regressions (puh...). Well,
and our RACK framework (+ various in-house extensions) runs really
smoothly over Xenomai. Specifically terminating and reloading
applications during runtime, which used to be a nightmare with /other
RT-extensions/, works fine and cause neither latency pikes nor even
worse effects.

I did some benchmarking on a production system today with "latency -p
1000 -f", and got about 130 us worst-case jitter (266 MHz Pentium-MMX,
tracer enabled) for this highest-prio task. And all this happened while
running various RT and non-RT jobs (e.g. cache calibrator) + xeno_16550A
(2 ports, one at 500 kbit/s) in background. =3D8)

Jan


[1]http://developer.berlios.de/projects/rack


--------------enigA9CAC914126D8A138AE2D189
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEY2TbniDOoMHTA+kRApZtAJ48zZTOt8pMP/fWoZgZVU19sr3ewACfU/IL
VerfbGMY418URONs2e0ZrsU=
=x3sA
-----END PGP SIGNATURE-----

--------------enigA9CAC914126D8A138AE2D189--

