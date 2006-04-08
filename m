Message-ID: <4437D2EE.4040902@domain.hid>
Date: Sat, 08 Apr 2006 17:12:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59A47D33FFC2322B11E021C0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG?] stalled xeno domain
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
--------------enig59A47D33FFC2322B11E021C0
Content-Type: multipart/mixed; boundary="------------010604010403030501030709"

This is a multi-part message in MIME format.
--------------010604010403030501030709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

debugging is nice, tracing is still nicer. As you suggested, I extended
the tracer with per-domain stall flags (needs some output clean-up,
preliminary patch attached nevertheless).

And here is the result (full trace attached):

> :|    (0x51) 0x000000c8 -1113+   1.112  __ipipe_sync_stage+0x142 (ipipe=
_suspend_domain+0x56)
> :|    fn                -1112+   1.789  __ipipe_sync_stage+0xe (ipipe_s=
uspend_domain+0x56)
> :|   *(0x50) 0x00000064 -1110+   1.293  __ipipe_sync_stage+0x97 (ipipe_=
suspend_domain+0x56)
> :    *fn                -1109+   1.398  do_IRQ+0x8 (__ipipe_sync_stage+=
0xcf)
> :    *fn                -1107+   2.105  __do_IRQ+0xc (do_IRQ+0x21)
> :    *fn                -1105+   1.631  handle_IRQ_event+0xd (__do_IRQ+=
0x9e)
> :    *fn                -1104+   2.413  timer_interrupt+0x9 (handle_IRQ=
_event+0x40)
> :    *fn                -1101+   3.022  mark_offset_tsc+0xe (timer_inte=
rrupt+0x31)
> :    *fn                -1098+   2.721  do_timer+0x9 (timer_interrupt+0=
x37)
> :|   *fn                -1096+   2.112  __ipipe_handle_irq+0xe (common_=
interrupt+0x18)
> :|   *fn                -1093+   1.210  __ipipe_ack_common_irq+0xc (__i=
pipe_handle_irq+0xc0)
> :|   *(0x50) 0x00000064 -1092+   1.218  __ipipe_ack_common_irq+0x31 (__=
ipipe_handle_irq+0xc0)
> :|   *fn                -1091+   1.834  mask_and_ack_8259A+0xb (__ipipe=
_ack_common_irq+0x5d)
> :|   *(0x50) 0x00000064 -1089+   1.345  __ipipe_ack_common_irq+0x9d (__=
ipipe_handle_irq+0xc0)
> :|   *fn                -1088    0.924  ipipe_suspend_domain+0xb (__ipi=
pe_handle_irq+0x174)
> :|   *(0x51) 0x000000c8 -1087+   1.172  ipipe_suspend_domain+0x26 (__ip=
ipe_handle_irq+0x174)
> :|   *fn                -1086+   2.030  __ipipe_sync_stage+0xe (ipipe_s=
uspend_domain+0x56)
> :|  **(0x50) 0x000000c8 -1084+   1.330  __ipipe_sync_stage+0x97 (ipipe_=
suspend_domain+0x56)
> :|  **fn                -1082    0.879  xnintr_clock_handler+0x8 (__ipi=
pe_sync_stage+0x12b)
> :|  **fn                -1082+   1.218  xnintr_irq_handler+0xb (xnintr_=
clock_handler+0x18)
> :|  **fn                -1080+   1.233  xnpod_announce_tick+0x9 (xnintr=
_irq_handler+0x2a)
> :|  **(0x50) 0x000000c8 -1079+   1.736  xnpod_announce_tick+0x20 (xnint=
r_irq_handler+0x2a)
> :|  **fn                -1077+   2.984  xntimer_do_tick_aperiodic+0xe (=
xnpod_announce_tick+0x36)
> :|  **fn                -1074+   2.751  xnthread_timeout_handler+0x8 (x=
ntimer_do_tick_aperiodic+0x18d)
> :|  **fn                -1072+   1.864  xnpod_resume_thread+0xe (xnthre=
ad_timeout_handler+0x1d)
> :|  **(0x50) 0x000000c8 -1070+   4.699  xnpod_resume_thread+0x2b (xnthr=
ead_timeout_handler+0x1d)
> :|  **(0x50) 0x000000c8 -1065+   1.586  xnpod_resume_thread+0x2bf (xnth=
read_timeout_handler+0x1d)
> :|  **(0x01) 0x00001237 -1063+   2.661  xntimer_do_tick_aperiodic+0x309=
 (xnpod_announce_tick+0x36)
> :|  **(0x50) 0x000000c8 -1061+   1.263  xnpod_announce_tick+0x4f (xnint=
r_irq_handler+0x2a)
> :|  **fn                -1060+   1.255  rthal_irq_end+0x8 (xnintr_irq_h=
andler+0x46)
> :|  **fn                -1058+   2.007  enable_8259A_irq+0x9 (rthal_irq=
_end+0x2e)
> :|  **fn                -1056+   1.924  xnpod_schedule+0xe (xnintr_irq_=
handler+0x6e)
> :|  **(0x50) 0x000000c8 -1054!  15.368  xnpod_schedule+0x53 (xnintr_irq=
_handler+0x6e)
> :|  **fn                -1039!  13.300  __switch_to+0xc (xnpod_schedule=
+0x689)
> :|  **(0x50) 0x000000c8 -1026+   1.766  xnpod_schedule+0x951 (xnpod_sus=
pend_thread+0x27c)
> :|  **(0x50) 0x000000c8 -1024!  18.195  xnpod_suspend_thread+0x2bb (rt_=
task_sleep+0x54)
> :   **fn                -1006+   1.624  __ipipe_syscall_root+0x9 (syste=
m_call+0x20)
> :   **fn                -1004+   1.406  __ipipe_dispatch_event+0xe (__i=
pipe_syscall_root+0x58)
> :   **fn                -1003+   4.323  hisyscall_event+0xe (__ipipe_di=
spatch_event+0x5e)
> :   **fn                 -998+   1.398  __rt_task_sleep+0xa (hisyscall_=
event+0x23c)
> :   **fn                 -997+   1.789  __copy_from_user_ll+0xa (__rt_t=
ask_sleep+0x1a)
> :   **fn                 -995!  15.345  rt_task_sleep+0xa (__rt_task_sl=
eep+0x25)
> :   **fn                 -980    0.879  __ipipe_syscall_root+0x9 (syste=
m_call+0x20)
> :   **fn                 -979+   1.308  __ipipe_dispatch_event+0xe (__i=
pipe_syscall_root+0x58)
> :   **fn                 -978+   2.451  hisyscall_event+0xe (__ipipe_di=
spatch_event+0x5e)
> :   **fn                 -975+   1.631  sys_rtdm_ioctl+0x8 (hisyscall_e=
vent+0x23c)
> :   **fn                 -974+   1.255  _rtdm_ioctl+0xc (sys_rtdm_ioctl=
+0x1b)
> :   **fn                 -972+   4.180  rtdm_context_get+0xa (_rtdm_ioc=
tl+0x20)
> :   **fn                 -968+   1.203  __ipipe_syscall_root+0x9 (syste=
m_call+0x20)
> :   **fn                 -967+   1.345  __ipipe_dispatch_event+0xe (__i=
pipe_syscall_root+0x58)

The '*' mark a stalled domain, root domain on the right. It seems to me
that xnpod_suspend_thread() leaves the xeno domain stalled on wake up.
This gets recovered somehow later.

But here we see a different effect which finally causes the tick to get
frozen:

> :     fn                 -504+   2.075  sched_clock+0xd (schedule+0x112=
)
> :     fn                 -502    0.992  __ipipe_stall_root+0x8 (schedul=
e+0x18e)
> :    *(0x50) 0x00000064  -501+   4.022  __ipipe_stall_root+0x32 (schedu=
le+0x18e)
> :    *fn                 -497+   1.977  __ipipe_dispatch_event+0xe (sch=
edule+0x412)
> :    *fn                 -495+   4.210  schedule_event+0xd (__ipipe_dis=
patch_event+0x5e)
> :   **(0x50) 0x000000c8  -491+   1.428  schedule_event+0x261 (__ipipe_d=
ispatch_event+0x5e)
> :|  **fn                 -490+   2.067  xnpod_schedule_runnable+0xe (sc=
hedule_event+0x28b)
> :|  **fn                 -488    0.954  ipipe_unstall_pipeline_from+0xc=
 (schedule_event+0x2c1)
> :|   *(0x51) 0x000000c8  -487+   4.646  ipipe_unstall_pipeline_from+0x2=
5 (schedule_event+0x2c1)
> :|   *fn                 -482+   7.248  __switch_to+0xc (xnpod_schedule=
+0x689)
> :|  **(0x50) 0x000000c8  -475+   1.421  xnpod_schedule+0x77f (xnpod_sus=
pend_thread+0x27c)
> :|  **(0x50) 0x000000c8  -473+   1.481  xnpod_schedule+0x951 (xnpod_sus=
pend_thread+0x27c)
> :|  **(0x50) 0x000000c8  -472+   1.654  xnpod_suspend_thread+0x2bb (xns=
hadow_relax+0x136)
> :|  **(0x50) 0x000000c8  -470+   2.917  xnshadow_relax+0x154 (hisyscall=
_event+0x2ec)
> :|  **fn                 -467+   1.375  ipipe_reenter_root+0xb (xnshado=
w_relax+0x204)
> :|  **fn                 -466    0.954  __ipipe_unstall_root+0x8 (ipipe=
_reenter_root+0x26)
> :|  * (0x51) 0x00000064  -465+   3.789  __ipipe_unstall_root+0x25 (ipip=
e_reenter_root+0x26)
> :   * fn                 -461+   1.578  send_sig+0x8 (xnshadow_relax+0x=
228)
> :   * fn                 -460+   1.496  send_sig_info+0xb (send_sig+0x1=
d)
> :   * fn                 -458    0.909  __ipipe_test_and_stall_root+0x9=
 (send_sig_info+0x38)
> :   **(0x50) 0x00000064  -457+   1.699  __ipipe_test_and_stall_root+0x2=
7 (send_sig_info+0x38)
> :   **fn                 -455+   1.203  specific_send_sig_info+0xb (sen=
d_sig_info+0x69)
> :   **fn                 -454+   1.706  __ipipe_test_root+0x8 (specific=
_send_sig_info+0x16)
> :   **fn                 -453+   3.360  sig_ignored+0x9 (specific_send_=
sig_info+0x29)
> :   **fn                 -449+   1.714  send_signal+0xb (specific_send_=
sig_info+0x55)
> :   **fn                 -447+   3.142  __sigqueue_alloc+0x9 (send_sign=
al+0x3f)
> :   **fn                 -444+   1.210  kmem_cache_alloc+0xa (__sigqueu=
e_alloc+0x42)
> :   **fn                 -443    0.909  __ipipe_test_and_stall_root+0x9=
 (kmem_cache_alloc+0x12)
> :   **(0x50) 0x00000064  -442+   2.180  __ipipe_test_and_stall_root+0x2=
7 (kmem_cache_alloc+0x12)
> :   **fn                 -440+   1.218  __ipipe_restore_root+0x8 (kmem_=
cache_alloc+0x52)
> :   **fn                 -439+   1.315  __ipipe_stall_root+0x8 (__ipipe=
_restore_root+0x11)

No more recovery from the xeno stall, no more timer ticks.

The special traces were generated via

#define ipipe_mark_domain_stall(ipd,cpuid)     \
	ipipe_trace_special(0x50, ipd->priority)
#define ipipe_mark_domain_unstall(ipd,cpuid)   \
	ipipe_trace_special(0x51, ipd->priority)

Any ideas? I do not find anything fishy yet that we may have introduced
to cause this problem.

Jan

--------------010604010403030501030709
Content-Type: text/plain;
 name="ipipe-dom-state.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-dom-state.patch"

Index: linux-2.6.15.5/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/kernel/ipipe/core.c	2006-04-08 13:36:34.000000000=
 +0200
+++ linux-2.6.15.5/kernel/ipipe/core.c	2006-04-08 16:39:30.000000000 +020=
0
@@ -40,7 +40,7 @@
=20
 ipipe_spinlock_t __ipipe_pipelock =3D IPIPE_SPIN_LOCK_UNLOCKED;
=20
-struct list_head __ipipe_pipeline;
+LIST_HEAD(__ipipe_pipeline);
=20
 unsigned long __ipipe_virtual_irq_map =3D 0;
=20
@@ -66,8 +66,6 @@
 	 * secondary CPUs are still lost in space.
 	 */
=20
-	INIT_LIST_HEAD(&__ipipe_pipeline);
-
 	ipd->name =3D "Linux";
 	ipd->domid =3D IPIPE_ROOT_ID;
 	ipd->priority =3D IPIPE_ROOT_PRIO;
Index: linux-2.6.15.5/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.5.orig/kernel/ipipe/tracer.c	2006-04-08 13:37:21.0000000=
00 +0200
+++ linux-2.6.15.5/kernel/ipipe/tracer.c	2006-04-08 16:52:07.000000000 +0=
200
@@ -51,6 +51,7 @@
=20
 #define IPIPE_TFLG_HWIRQ_OFF        0x0100
 #define IPIPE_TFLG_FREEZING         0x0200
+#define IPIPE_TFLG_DOMSTATE_SHIFT   12   /* bits 12..15: domain stalled?=
 */
=20
=20
 struct ipipe_trace_point{
@@ -118,6 +119,24 @@
 static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)=
;
=20
=20
+static notrace void
+__ipipe_store_domain_states(struct ipipe_trace_point *point, int cpu_id)=

+{
+	int i =3D IPIPE_TFLG_DOMSTATE_SHIFT;
+	struct list_head *pos;
+
+	list_for_each_prev(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *ipd =3D
+			list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpu_id].status))
+			point->flags |=3D (1 << i);
+
+		if (++i > IPIPE_TFLG_DOMSTATE_SHIFT+3)
+			break;
+	}
+}
+
 static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
 {
 	int new_active =3D old;
@@ -282,6 +301,8 @@
 	point->v =3D v;
 	ipipe_read_tsc(point->timestamp);
=20
+	__ipipe_store_domain_states(point, cpu_id);
+
 	/* forward to next point buffer */
 	next_pos =3D WRAP_POINT_NO(pos+1);
 	tp->trace_pos =3D next_pos;
@@ -617,6 +638,7 @@
 {
 	char mark =3D ' ';
 	int point_no =3D point - print_path->point;
+	int i;
=20
 	if (print_path->end =3D=3D point_no)
 		mark =3D '<';
@@ -626,6 +648,12 @@
 		mark =3D ':';
 	seq_printf(m, "%c%c", mark,
 	           (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
+
+	if (verbose_trace)
+		for (i =3D IPIPE_TFLG_DOMSTATE_SHIFT + 3;
+		     i >=3D IPIPE_TFLG_DOMSTATE_SHIFT; i--)
+			seq_printf(m, "%c",
+			           (point->flags & (1 << i)) ? '*' : ' ');
 }
=20
 static void

--------------010604010403030501030709
Content-Type: application/octet-stream;
 name="frozen-timer3.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="frozen-timer3.bz2"

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
--------------010604010403030501030709--

--------------enig59A47D33FFC2322B11E021C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEN9LuniDOoMHTA+kRAgy6AJ48PexyTxvZ3LmD+faofM6fHoVyuQCeOW54
Plc8KHEyhkt289Y11LnnaJk=
=8jkD
-----END PGP SIGNATURE-----

--------------enig59A47D33FFC2322B11E021C0--

