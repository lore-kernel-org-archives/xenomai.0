Message-ID: <4437E704.4010607@domain.hid>
Date: Sat, 08 Apr 2006 18:38:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] stalled xeno domain
References: <4437D2EE.4040902@domain.hid>
In-Reply-To: <4437D2EE.4040902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6BD3025C594ACBF1D46DD65A"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6BD3025C594ACBF1D46DD65A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi Philippe,
>=20
> debugging is nice, tracing is still nicer. As you suggested, I extended=

> the tracer with per-domain stall flags (needs some output clean-up,
> preliminary patch attached nevertheless).
>=20
> And here is the result (full trace attached):
>=20
>> :|    (0x51) 0x000000c8 -1113+   1.112  __ipipe_sync_stage+0x142 (ipip=
e_suspend_domain+0x56)
>> :|    fn                -1112+   1.789  __ipipe_sync_stage+0xe (ipipe_=
suspend_domain+0x56)
>> :|   *(0x50) 0x00000064 -1110+   1.293  __ipipe_sync_stage+0x97 (ipipe=
_suspend_domain+0x56)
>> :    *fn                -1109+   1.398  do_IRQ+0x8 (__ipipe_sync_stage=
+0xcf)
>> :    *fn                -1107+   2.105  __do_IRQ+0xc (do_IRQ+0x21)
>> :    *fn                -1105+   1.631  handle_IRQ_event+0xd (__do_IRQ=
+0x9e)
>> :    *fn                -1104+   2.413  timer_interrupt+0x9 (handle_IR=
Q_event+0x40)
>> :    *fn                -1101+   3.022  mark_offset_tsc+0xe (timer_int=
errupt+0x31)
>> :    *fn                -1098+   2.721  do_timer+0x9 (timer_interrupt+=
0x37)
>> :|   *fn                -1096+   2.112  __ipipe_handle_irq+0xe (common=
_interrupt+0x18)
>> :|   *fn                -1093+   1.210  __ipipe_ack_common_irq+0xc (__=
ipipe_handle_irq+0xc0)
>> :|   *(0x50) 0x00000064 -1092+   1.218  __ipipe_ack_common_irq+0x31 (_=
_ipipe_handle_irq+0xc0)
>> :|   *fn                -1091+   1.834  mask_and_ack_8259A+0xb (__ipip=
e_ack_common_irq+0x5d)
>> :|   *(0x50) 0x00000064 -1089+   1.345  __ipipe_ack_common_irq+0x9d (_=
_ipipe_handle_irq+0xc0)
>> :|   *fn                -1088    0.924  ipipe_suspend_domain+0xb (__ip=
ipe_handle_irq+0x174)
>> :|   *(0x51) 0x000000c8 -1087+   1.172  ipipe_suspend_domain+0x26 (__i=
pipe_handle_irq+0x174)
>> :|   *fn                -1086+   2.030  __ipipe_sync_stage+0xe (ipipe_=
suspend_domain+0x56)
>> :|  **(0x50) 0x000000c8 -1084+   1.330  __ipipe_sync_stage+0x97 (ipipe=
_suspend_domain+0x56)
>> :|  **fn                -1082    0.879  xnintr_clock_handler+0x8 (__ip=
ipe_sync_stage+0x12b)
>> :|  **fn                -1082+   1.218  xnintr_irq_handler+0xb (xnintr=
_clock_handler+0x18)
>> :|  **fn                -1080+   1.233  xnpod_announce_tick+0x9 (xnint=
r_irq_handler+0x2a)
>> :|  **(0x50) 0x000000c8 -1079+   1.736  xnpod_announce_tick+0x20 (xnin=
tr_irq_handler+0x2a)
>> :|  **fn                -1077+   2.984  xntimer_do_tick_aperiodic+0xe =
(xnpod_announce_tick+0x36)
>> :|  **fn                -1074+   2.751  xnthread_timeout_handler+0x8 (=
xntimer_do_tick_aperiodic+0x18d)
>> :|  **fn                -1072+   1.864  xnpod_resume_thread+0xe (xnthr=
ead_timeout_handler+0x1d)
>> :|  **(0x50) 0x000000c8 -1070+   4.699  xnpod_resume_thread+0x2b (xnth=
read_timeout_handler+0x1d)
>> :|  **(0x50) 0x000000c8 -1065+   1.586  xnpod_resume_thread+0x2bf (xnt=
hread_timeout_handler+0x1d)
>> :|  **(0x01) 0x00001237 -1063+   2.661  xntimer_do_tick_aperiodic+0x30=
9 (xnpod_announce_tick+0x36)
>> :|  **(0x50) 0x000000c8 -1061+   1.263  xnpod_announce_tick+0x4f (xnin=
tr_irq_handler+0x2a)
>> :|  **fn                -1060+   1.255  rthal_irq_end+0x8 (xnintr_irq_=
handler+0x46)
>> :|  **fn                -1058+   2.007  enable_8259A_irq+0x9 (rthal_ir=
q_end+0x2e)
>> :|  **fn                -1056+   1.924  xnpod_schedule+0xe (xnintr_irq=
_handler+0x6e)
>> :|  **(0x50) 0x000000c8 -1054!  15.368  xnpod_schedule+0x53 (xnintr_ir=
q_handler+0x6e)
>> :|  **fn                -1039!  13.300  __switch_to+0xc (xnpod_schedul=
e+0x689)
>> :|  **(0x50) 0x000000c8 -1026+   1.766  xnpod_schedule+0x951 (xnpod_su=
spend_thread+0x27c)
>> :|  **(0x50) 0x000000c8 -1024!  18.195  xnpod_suspend_thread+0x2bb (rt=
_task_sleep+0x54)
>> :   **fn                -1006+   1.624  __ipipe_syscall_root+0x9 (syst=
em_call+0x20)
>> :   **fn                -1004+   1.406  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x58)
>> :   **fn                -1003+   4.323  hisyscall_event+0xe (__ipipe_d=
ispatch_event+0x5e)
>> :   **fn                 -998+   1.398  __rt_task_sleep+0xa (hisyscall=
_event+0x23c)
>> :   **fn                 -997+   1.789  __copy_from_user_ll+0xa (__rt_=
task_sleep+0x1a)
>> :   **fn                 -995!  15.345  rt_task_sleep+0xa (__rt_task_s=
leep+0x25)
>> :   **fn                 -980    0.879  __ipipe_syscall_root+0x9 (syst=
em_call+0x20)
>> :   **fn                 -979+   1.308  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x58)
>> :   **fn                 -978+   2.451  hisyscall_event+0xe (__ipipe_d=
ispatch_event+0x5e)
>> :   **fn                 -975+   1.631  sys_rtdm_ioctl+0x8 (hisyscall_=
event+0x23c)
>> :   **fn                 -974+   1.255  _rtdm_ioctl+0xc (sys_rtdm_ioct=
l+0x1b)
>> :   **fn                 -972+   4.180  rtdm_context_get+0xa (_rtdm_io=
ctl+0x20)
>> :   **fn                 -968+   1.203  __ipipe_syscall_root+0x9 (syst=
em_call+0x20)
>> :   **fn                 -967+   1.345  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x58)
>=20
> The '*' mark a stalled domain, root domain on the right. It seems to me=

> that xnpod_suspend_thread() leaves the xeno domain stalled on wake up.
> This gets recovered somehow later.
>=20
> But here we see a different effect which finally causes the tick to get=

> frozen:
>=20
>> :     fn                 -504+   2.075  sched_clock+0xd (schedule+0x11=
2)
>> :     fn                 -502    0.992  __ipipe_stall_root+0x8 (schedu=
le+0x18e)
>> :    *(0x50) 0x00000064  -501+   4.022  __ipipe_stall_root+0x32 (sched=
ule+0x18e)
>> :    *fn                 -497+   1.977  __ipipe_dispatch_event+0xe (sc=
hedule+0x412)
>> :    *fn                 -495+   4.210  schedule_event+0xd (__ipipe_di=
spatch_event+0x5e)
>> :   **(0x50) 0x000000c8  -491+   1.428  schedule_event+0x261 (__ipipe_=
dispatch_event+0x5e)
>> :|  **fn                 -490+   2.067  xnpod_schedule_runnable+0xe (s=
chedule_event+0x28b)
>> :|  **fn                 -488    0.954  ipipe_unstall_pipeline_from+0x=
c (schedule_event+0x2c1)
>> :|   *(0x51) 0x000000c8  -487+   4.646  ipipe_unstall_pipeline_from+0x=
25 (schedule_event+0x2c1)
>> :|   *fn                 -482+   7.248  __switch_to+0xc (xnpod_schedul=
e+0x689)
>> :|  **(0x50) 0x000000c8  -475+   1.421  xnpod_schedule+0x77f (xnpod_su=
spend_thread+0x27c)
>> :|  **(0x50) 0x000000c8  -473+   1.481  xnpod_schedule+0x951 (xnpod_su=
spend_thread+0x27c)
>> :|  **(0x50) 0x000000c8  -472+   1.654  xnpod_suspend_thread+0x2bb (xn=
shadow_relax+0x136)
>> :|  **(0x50) 0x000000c8  -470+   2.917  xnshadow_relax+0x154 (hisyscal=
l_event+0x2ec)
>> :|  **fn                 -467+   1.375  ipipe_reenter_root+0xb (xnshad=
ow_relax+0x204)
>> :|  **fn                 -466    0.954  __ipipe_unstall_root+0x8 (ipip=
e_reenter_root+0x26)
>> :|  * (0x51) 0x00000064  -465+   3.789  __ipipe_unstall_root+0x25 (ipi=
pe_reenter_root+0x26)
>> :   * fn                 -461+   1.578  send_sig+0x8 (xnshadow_relax+0=
x228)
>> :   * fn                 -460+   1.496  send_sig_info+0xb (send_sig+0x=
1d)
>> :   * fn                 -458    0.909  __ipipe_test_and_stall_root+0x=
9 (send_sig_info+0x38)
>> :   **(0x50) 0x00000064  -457+   1.699  __ipipe_test_and_stall_root+0x=
27 (send_sig_info+0x38)
>> :   **fn                 -455+   1.203  specific_send_sig_info+0xb (se=
nd_sig_info+0x69)
>> :   **fn                 -454+   1.706  __ipipe_test_root+0x8 (specifi=
c_send_sig_info+0x16)
>> :   **fn                 -453+   3.360  sig_ignored+0x9 (specific_send=
_sig_info+0x29)
>> :   **fn                 -449+   1.714  send_signal+0xb (specific_send=
_sig_info+0x55)
>> :   **fn                 -447+   3.142  __sigqueue_alloc+0x9 (send_sig=
nal+0x3f)
>> :   **fn                 -444+   1.210  kmem_cache_alloc+0xa (__sigque=
ue_alloc+0x42)
>> :   **fn                 -443    0.909  __ipipe_test_and_stall_root+0x=
9 (kmem_cache_alloc+0x12)
>> :   **(0x50) 0x00000064  -442+   2.180  __ipipe_test_and_stall_root+0x=
27 (kmem_cache_alloc+0x12)
>> :   **fn                 -440+   1.218  __ipipe_restore_root+0x8 (kmem=
_cache_alloc+0x52)
>> :   **fn                 -439+   1.315  __ipipe_stall_root+0x8 (__ipip=
e_restore_root+0x11)
>=20
> No more recovery from the xeno stall, no more timer ticks.
>=20
> The special traces were generated via
>=20
> #define ipipe_mark_domain_stall(ipd,cpuid)     \
> 	ipipe_trace_special(0x50, ipd->priority)
> #define ipipe_mark_domain_unstall(ipd,cpuid)   \
> 	ipipe_trace_special(0x51, ipd->priority)
>=20
> Any ideas? I do not find anything fishy yet that we may have introduced=

> to cause this problem.
>=20

Hmm, what about this theory: the RT-thread which got woken up in the
first trace snippet suffered from a leaking IRQ lock. Its broken flags
got restored on wakeup, and also when the thread went for termination
(second trace). Therefore, we see this leaking domain stall. Possible
explanation?

This would move I-pipe and Xenomai out of the focus, leaving only the
16550A driver and our middleware messaging service (also a RTDM driver,
currently my top favourite). My trace unfortunately does not last back
far enough to answer this, I will have a look at this on Monday.

If it turned out to be the reason, we should consider putting some
XENO_ASSERT guards in the return-to-user paths of RTDM services.

Jan


--------------enig6BD3025C594ACBF1D46DD65A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEN+cEniDOoMHTA+kRAoe/AJ0VNvcU+l5ECqAnlCfK0xdu7RYl3ACcDjJq
fCBYPFXbjpWiZ/3ula0LZpY=
=TdfC
-----END PGP SIGNATURE-----

--------------enig6BD3025C594ACBF1D46DD65A--

