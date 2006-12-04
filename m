Message-ID: <4573D896.9050200@domain.hid>
Date: Mon, 04 Dec 2006 09:13:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid> <45732660.6050605@domain.hid>	
	<1165175999.4952.431.camel@domain.hid> <45733D1B.7010805@domain.hid>
	<1165188655.4952.457.camel@domain.hid>
In-Reply-To: <1165188655.4952.457.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig345576364557EDE52BA56171"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig345576364557EDE52BA56171
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-12-03 at 22:09 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2006-12-03 at 20:32 +0100, Jan Kiszka wrote:
>>>> Nicolas BLANCHARD wrote:
>>>>>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 =
>>>
>>>>>> Hello,
>>>>>>
>>>>>> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
>>>>>> and change the config :=20
>>>>>>                                        - CONFIG_M586
>>>>>>                                        - disable CONFIG_INPUT_PCSP=
KR
>>>>> (it was on module)
>>>>>>                                        - disable prio boosting (ch=
eck
>>>>> CONFIG_XENO_OPT_RPDISALBLE)
>>>>>> and it seems to work better, one hour without blocking, it's a rec=
ord
>>>>>> for me.
>>>>>>
>>>>>> So, i will investigate to find which modification improve my probl=
em.
>>>>> After somes tests (kernel compil), it seems that prio boost is
>>>>> responsable of my
>>>>> problem. When it's disable (kernel option checked) my program run
>>>>> correctly.
>>>> Confirmed!
>>>>
>>>> root@domain.hid :/root# cat /proc/xenomai/sched
>>>> CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
>>>>   0  0       99      0        0          R          ROOT
>>>>   0  837     99      9999312  0          X          TASK1
>>>>   0  838      0      10999998 0          R          TASK2
>>>>
>>>> So far "only" on real hardware (P-I 133) with CONFIG_M586 and (this =
is
>>>> likely also very important) CONFIG_PREEMPT. I'm now about to check i=
f I
>>>> can migrate this problem into qemu and/or capture it with the I-pipe=
 tracer.
>>>>
>>> Please also try moving task2 to the SCHED_FIFO class to see if things=

>>> evolve.
>>>
>> Here is the Xenomai scheduling sequence that leads to the deadlock. I
>> raised the frequency of TASK2 a bit, and this seems to accelerate the
>> lock-up.
>>
>> ...
>>> :|  *+[  844] TASK2    1 -5061+   4.436  xnpod_resume_thread+0x48 (ga=
tekeeper_thread+0xf7)
>>> :|  *+[  827] sshd    -1 -5055+   4.015  xnpod_schedule_runnable+0x45=
 (gatekeeper_thread+0x12e)
>=20
> Damnit. What about this?
>=20
> --- ksrc/nucleus/shadow.c~	2006-11-19 11:09:00.000000000 +0100
> +++ ksrc/nucleus/shadow.c	2006-12-04 00:29:13.000000000 +0100
> @@ -551,9 +551,6 @@
>  			thread->sched =3D xnpod_sched_slot(cpu);
>  #endif /* CONFIG_SMP */
>  			xnpod_resume_thread(thread, XNRELAX);
> -#ifndef CONFIG_XENO_OPT_RPIDISABLE
> -			xnpod_renice_root(XNPOD_ROOT_PRIO_BASE);
> -#endif /* CONFIG_XENO_OPT_RPIDISABLE */
>  #ifdef CONFIG_XENO_OPT_ISHIELD
>  			disengage_irq_shield();
>  #endif /* CONFIG_XENO_OPT_ISHIELD */
>=20

Stalls on relaxing TASK1:

CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       99      0        0          R          ROOT
  0  831     99      10000000 0          R          TASK1
  0  832      1      11000000 0          R          TASK2

My excerpt may have suggested a priority adjustment bug, but there is
non. When TASK2 is resumed, the currently running root thread still has
prio -1, all correct.

But here is the full trace of the problematic path:

> :|  # [  844] TASK2    1 -2992+   9.954  xnpod_resume_thread+0x48 (xnth=
read_periodic_handler+0x28)
> :|  # func               -2982+   3.368  xnpod_schedule+0xe (xnintr_irq=
_handler+0xec)
> :|  # [   75] gatekee -1 -2978!  13.759  xnpod_schedule+0x81 (xnintr_ir=
q_handler+0xec)
> :|  # func               -2965+   2.285  __switch_to+0xb (xnpod_schedul=
e+0x6ce)
> :|  # func               -2962+   7.879  debug_smp_processor_id+0x9 (__=
switch_to+0x1e)
> :|  # [  844] TASK2    1 -2955+   7.842  xnpod_schedule+0x7a2 (xnpod_su=
spend_thread+0x1e4)
> :|  # func               -2947!  39.947  __ipipe_restore_pipeline_head+=
0x8 (xnpod_wait_thread_period+0x1a8)
> :   + func               -2907+   2.406  __ipipe_syscall_root+0x9 (syst=
em_call+0x20)
> :   + func               -2904+   2.857  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x73)
> :   + func               -2902+   4.375  hisyscall_event+0xe (__ipipe_d=
ispatch_event+0x82)
> :   + func               -2897+   2.225  xnshadow_relax+0xe (hisyscall_=
event+0x1ed)
> :   + func               -2895+   2.330  schedule_linux_call+0xe (xnsha=
dow_relax+0x7d)
> :|  # func               -2893+   2.962  __ipipe_restore_pipeline_head+=
0x8 (schedule_linux_call+0xaf)
> :   + func               -2890+   2.323  rthal_apc_schedule+0x8 (schedu=
le_linux_call+0xb9)
> :   + func               -2887+   3.511  __ipipe_schedule_irq+0xa (rtha=
l_apc_schedule+0x31)
> :|  + func               -2884+   2.240  __ipipe_handle_irq+0xe (common=
_interrupt+0x18)
> :|  + func               -2882+   1.639  __ipipe_ack_common_irq+0xa (__=
ipipe_handle_irq+0x80)
> :|  + func               -2880+   2.067  ipipe_test_and_stall_pipeline_=
from+0x8 (__ipipe_ack_common_irq+0x16)
> :|  # func               -2878+   2.879  mask_and_ack_8259A+0xb (__ipip=
e_ack_common_irq+0x3e)
> :|  + func               -2875+   2.812  __ipipe_dispatch_wired+0xe (__=
ipipe_handle_irq+0x8a)
> :|  # func               -2872+   1.759  xnintr_clock_handler+0x8 (__ip=
ipe_dispatch_wired+0x7d)
> :|  # func               -2870+   1.969  xnintr_irq_handler+0xe (xnintr=
_clock_handler+0x17)
> :|  # func               -2868+   1.864  xnpod_announce_tick+0x8 (xnint=
r_irq_handler+0x39)
> :|  # func               -2867+   3.052  xntimer_do_tick_aperiodic+0xe =
(xnpod_announce_tick+0xf)
> :|  # func               -2863+   2.511  xnthread_periodic_handler+0x8 =
(xntimer_do_tick_aperiodic+0x7b)
> :|  # func               -2861+   2.789  xnpod_resume_thread+0xe (xnthr=
ead_periodic_handler+0x28)
> :|  # [  843] TASK1   99 -2858+   7.977  xnpod_resume_thread+0x48 (xnth=
read_periodic_handler+0x28)
> :|  # func               -2850+   2.270  xnpod_schedule+0xe (xnintr_irq=
_handler+0xec)
> :|  # [  844] TASK2    1 -2848+   8.466  xnpod_schedule+0x81 (xnintr_ir=
q_handler+0xec)
> :|  # func               -2839+   1.751  __switch_to+0xb (xnpod_schedul=
e+0x6ce)
> :|  # func               -2838+   6.593  debug_smp_processor_id+0x9 (__=
switch_to+0x1e)
> :|  # [  843] TASK1   99 -2831+   4.421  xnpod_schedule+0x7a2 (xnpod_su=
spend_thread+0x1e4)
> :|  # func               -2827!  17.894  __ipipe_restore_pipeline_head+=
0x8 (xnpod_wait_thread_period+0x1a8)
> :   + func               -2809+   2.360  __ipipe_syscall_root+0x9 (syst=
em_call+0x20)
> :   + func               -2806+   2.210  __ipipe_dispatch_event+0xe (__=
ipipe_syscall_root+0x73)
> :   + func               -2804+   3.458  hisyscall_event+0xe (__ipipe_d=
ispatch_event+0x82)
> :   + func               -2801+   2.421  xnshadow_relax+0xe (hisyscall_=
event+0x1ed)
> :   + func               -2798+   2.691  schedule_linux_call+0xe (xnsha=
dow_relax+0x7d)
> :|  # func               -2796+   1.984  __ipipe_restore_pipeline_head+=
0x8 (schedule_linux_call+0xaf)
> :   + func               -2794+   2.631  rthal_apc_schedule+0x8 (schedu=
le_linux_call+0xb9)
> :|  # func               -2791+   2.180  xnpod_schedule_runnable+0xe (x=
nshadow_relax+0xd9)
> :|  # [  843] TASK1   99 -2789+   4.315  xnpod_schedule_runnable+0x45 (=
xnshadow_relax+0xd9)
> :|  # func               -2785+   5.593  xnpod_suspend_thread+0xe (xnsh=
adow_relax+0x104)
> :|  # func               -2779+   2.045  xnpod_schedule+0xe (xnpod_susp=
end_thread+0x1e4)
> :|  # [  843] TASK1   99 -2777+   6.932  xnpod_schedule+0x81 (xnpod_sus=
pend_thread+0x1e4)
> :|  # func               -2770+   2.368  __switch_to+0xb (xnpod_schedul=
e+0x6ce)
> :|  # func               -2768+   5.736  debug_smp_processor_id+0x9 (__=
switch_to+0x1e)
> :|  # [  827] sshd    99 -2762+   4.917  xnpod_schedule+0x7a2 (xnintr_i=
rq_handler+0xec)
> :|   +func               -2757+   3.744  __ipipe_walk_pipeline+0xe (__i=
pipe_handle_irq+0x182)
> :|   +func               -2753+   2.135  __ipipe_unstall_iret_root+0x8 =
(restore_raw+0x0)
> :    +func               -2751+   2.360  tcp_cong_avoid+0xa (tcp_ack+0x=
14d3)
> :    +func               -2749+   5.909  bictcp_cong_avoid+0xb (tcp_con=
g_avoid+0x1b)
> :    +func               -2743+   2.496  __kfree_skb+0xa (tcp_rcv_estab=
lished+0x109)=20

This indicates that we face an I-pipe bug: the scheduled Linux call on
relaxation of TASK2 and then later TASK1 somehow gets lost (there is no
rthal_apc_handler in the remaining trace).

Jan


--------------enig345576364557EDE52BA56171
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFc9icniDOoMHTA+kRAs7sAJsGWX30IRyrLFX5BSR/4IdiFuBQ+wCeKBZj
Ceeyu6fwCgVHWKEbWLcL+h4=
=mD8+
-----END PGP SIGNATURE-----

--------------enig345576364557EDE52BA56171--

