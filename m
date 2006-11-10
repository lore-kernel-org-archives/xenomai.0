Message-ID: <4554A498.8030202@domain.hid>
Date: Fri, 10 Nov 2006 17:11:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>	
	<45203E31.6050707@domain.hid>
	<4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
In-Reply-To: <4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig649380BF9C255FA0BBC1DE6B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig649380BF9C255FA0BBC1DE6B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi Jan and Philippe,
>=20

=2E..

>=20
> Also attached the new ipiper-tracer log.

Damn, no fitting reference trace at hand, but something seems to be
fishy. See comments/questions below.

> -----------------------------------------------------------------------=
-
>=20
> root:~> ./latency -t2 -p200 -f
>=20
> root:~> cat /proc/ipipe/trace/frozen
> I-pipe frozen back-tracing service on 2.6.16.27-ADI-2006R2/ipipe-1.5-00=

> ------------------------------------------------------------
> Freeze: 144879102832 cycles, Trace Points: 200 (+50)
>=20
>  +----- Hard IRQs ('|': locked)
>  |+---- <unused>
>  ||+--- <unused>
>  |||+-- Xenomai
>  ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=

>  |||||                        +---------- Delay flag ('+': > 1 us, '!':=
 > 10 us)
>  |||||                        |        +- NMI noise ('N')
>  |||||                        |        |
>       Type    User Val.   Time    Delay  Function (Parent)
=2E..

> :    +func                 -98+   1.550  _kthread_should_stop+0x10 (_ga=
tekeeper_thread+0xec)
> :|   +begin   0x80000001   -97+   2.898  _gatekeeper_thread+0x100 (__st=
art+0xfffff000)
> :|  *+func                 -94+   1.432  _xnpod_resume_thread+0xa (_gat=
ekeeper_thread+0x186)
> :|  *+[   51] -<?>-    0   -92+   5.450  _xnpod_resume_thread+0x4a (__s=
tart+0xfffff000)

Here we go: harden the xeno thread related to pid 51 (likely some now
gone part of latency).

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L155=
5

> :|  *+func                 -87+   1.100  _xnpod_schedule_runnable+0xc (=
_gatekeeper_thread+0x1be)
> :|  *+[    0] swapper -1   -86+   2.788  _xnpod_schedule_runnable+0x28 =
(__start+0xfffff000)

This correlates to
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L252=
9

xnpod_schedule_runnable returns without actually switching (off-topic:
seems to be the only use-case for this function right now...).

> :|  *+func                 -83+   2.852  _xnpod_schedule+0xa (_gatekeep=
er_thread+0x1ce)
> :|  *+func                 -80+   2.970  _ipipe_trigger_irq+0x12 (_xnpo=
d_schedule+0x2e6)
> :|  *+func                 -77+   2.120  ___ipipe_handle_irq+0x1e (_ipi=
pe_trigger_irq+0x86)
> :|  *+func                 -75+   2.058  ___ipipe_dispatch_wired+0x14 (=
___ipipe_handle_irq+0x190)
> :|  *+func                 -73+   1.722  ___ipipe_restore_pipeline_head=
+0xa (_gatekeeper_thread+0x138)
> :|   +func                 -71+   2.130  ___ipipe_walk_pipeline+0x18 (_=
__ipipe_restore_pipeline_head+0xd0)
> :|  + func                 -69+   2.410  _ipipe_suspend_domain+0xa (___=
ipipe_walk_pipeline+0xac)
> :|  + func                 -67+   5.048  ___ipipe_sync_stage+0xe (_ipip=
e_suspend_domain+0x4e)
> :|  # func                 -62+   2.452  _xnpod_schedule_handler+0xe (_=
__ipipe_sync_stage+0x186)
> :|  # func                 -59+   2.130  _xnpod_schedule+0xa (_xnpod_sc=
hedule_handler+0x5c)
> :|  # [    0] swapper -1   -57+   7.180  _xnpod_schedule+0x104 (__start=
+0xfffff000)

This must be
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L233=
7

saying "root thread is about the be scheduled away". But then I'm
missing code here that one would normally see on x86:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L244=
2

Likely inlined on bfin, but this *must* make some noise:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L245=
3

Instead we enter the pending timer interrupt. This currently makes no
sense to me, rather make me think that something is skewed. Maybe only
the tracer, maybe more...

> :|  # end     0x80000000   -50+   2.278  ___sched_text_start+0x5ca (__s=
tart+0xfffff000)
> :|  # func                 -48    0.922  ___ipipe_grab_irq+0x22 (__comm=
on_int_entry+0x72)
> :|  # begin   0x00000006   -47+   1.820  ___ipipe_grab_irq+0x34 (__star=
t+0xfffff000)
> :|  # func                 -45+   1.530  ___ipipe_handle_irq+0x1e (___i=
pipe_grab_irq+0x3c)
> :|  # func                 -43+   1.168  _rthal_timer_ack+0x8 (___ipipe=
_handle_irq+0x178)
> :|  # func                 -42+   1.102  ___ipipe_dispatch_wired+0x14 (=
___ipipe_handle_irq+0x190)
> :|  # end     0x00000006   -41+   2.010  ___ipipe_grab_irq+0x42 (__star=
t+0xfffff000)
> :   # func                 -39+   1.090  _ipipe_unstall_pipeline_head+0=
x8 (_xnshadow_harden+0xce)
> :|  # begin   0x80000001   -38+   2.308  _ipipe_unstall_pipeline_head+0=
x18 (__start+0xfffff000)

That's another weirdness, but now very likely of the tracer: both
tracepoints should contain the same parent entry, but the second one is
just nonsense. And there are such kind of parents all over the place -
hmm, actually any explicit trace point shows this problem. Is there no
way on bfin to get the caller from everywhere in a function? I guess
there is, likely a register, right?

Jan


--------------enig649380BF9C255FA0BBC1DE6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVKSYniDOoMHTA+kRAodUAJ9lpeHzbft+DuAQNAh6Us7aNi91SACeJ+ki
YGAVkdZNw0gNNdoLXIf+2RQ=
=ev9A
-----END PGP SIGNATURE-----

--------------enig649380BF9C255FA0BBC1DE6B--

