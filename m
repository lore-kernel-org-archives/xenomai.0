From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Fri, 2 Oct 2015 20:23:58 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB938.8090905@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>, Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

Kindly ignore my previous email. I think I tried to grab a mutex which caus=
ed it to relax. Sorry for that. I don't think rt_intr_enable is causing the=
 relax.

Rgds,
Makarand.

-----Original Message-----
From: PRADHAN, MAKARAND (RC-CA)
Sent: Friday, October 02, 2015 2:30 PM
To: PRADHAN, MAKARAND (RC-CA); Philippe Gerum; Xenomai@xenomai.org
Subject: RE: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.=
6.4

Hi,

Have one more int latency related issue.

I have noticed that my User space irq handler task is relaxing on invoking =
rt_intr_enable.

Note: As advised in the previous conversation, I have removed all reference=
s to sched locks (T_LOCK) in my code.

Details follow:

System config:
Xenomai: 2.6.4
Linux: 3.14
Processor: MPC8360E (powerpc)

I have a user space task doing an rt_intr_wait on int 42(2a). The only syst=
em call it makes is rt_intr_enable once it is ready to re enable the int:

The ipipe trace is attached to the email. Am posting my interpretation of t=
he trace below.

I think that the system call is relaxing the thread causing other threads t=
o be scheduled in:

Occurance of hw interrupt:
:|  + func               -1635+   1.651  ipic_get_irq+0x8 (__ipipe_grab_irq=
+0x34)
:|  + begin   0x00000021 -1634    0.772  __ipipe_grab_irq+0x40 (__ipipe_ret=
_from_except+0x0)
:|  + func               -1633+   1.121  __ipipe_dispatch_irq+0x8 (__ipipe_=
grab_irq+0x50)
:|  + func               -1632+   2.166  irq_to_desc+0x8 (__ipipe_dispatch_=
irq+0xec)
:|  + func               -1630+   1.818  irq_to_desc+0x8 (__ipipe_dispatch_=
irq+0xfc)
:|  + func               -1628+   1.287  qe_ic_get_low_irq+0x8 (qe_ic_casca=
de_low_ipic+0x1c)
:|  + begin   0x0000002a -1627    0.484  qe_ic_cascade_low_ipic+0x28 (__ipi=
pe_dispatch_irq+0x94)
:|  + func               -1626    0.939  __ipipe_dispatch_irq+0x8 (qe_ic_ca=
scade_low_ipic+0x34)
:|  + func               -1625    0.848  irq_to_desc+0x8 (__ipipe_dispatch_=
irq+0xec)
:|  + func               -1625+   1.151  irq_to_desc+0x8 (__ipipe_dispatch_=
irq+0xfc)
:|  + func               -1623+   1.075  __ipipe_ack_level_irq+0x8 (__ipipe=
_dispatch_irq+0x94)
:|  + func               -1622    0.893  qe_ic_mask_irq+0x8 (__ipipe_ack_le=
vel_irq+0x40)
:|  + func               -1621+   1.742  __ipipe_spin_lock_irqsave+0x8 (qe_=
ic_mask_irq+0x3c)
:|  # func               -1620+   1.545  __ipipe_spin_unlock_irqrestore+0x8=
 (qe_ic_mask_irq+0x94)
:|  + func               -1618+   1.227  __ipipe_set_irq_pending+0x8 (__ipi=
pe_dispatch_irq+0x314)
:|  + end     0x0000002a -1617    0.893  qe_ic_cascade_low_ipic+0x3c (__ipi=
pe_dispatch_irq+0x94)
:|  + func               -1616+   1.636  __ipipe_do_sync_stage+0x8 (__ipipe=
_dispatch_irq+0x2f0)
:|  # func               -1615+   2.196  xnintr_irq_handler+0x8 (__ipipe_do=
_sync_stage+0x150)
:|  # func               -1612+   1.318  rt_intr_handler+0x8 [xeno_native] =
(xnintr_irq_handler+0x150)
:|  # func               -1611+   2.863  xnsynch_flush+0x8 (rt_intr_handler=
+0x48 [xeno_native])
:|  # func               -1608+   1.484  xnpod_resume_thread+0x8 (xnsynch_f=
lush+0x170)
:|  # [ 7962] -<?>-  257 -1607+   4.272  xnpod_resume_thread+0x134 (xnsynch=
_flush+0x170)
:|  # func               -1603+   1.212  __xnpod_schedule+0x8 (xnintr_irq_h=
andler+0x380)
:|  # [ 7975] -<?>-   87 -1601    0.515  __xnpod_schedule+0x150 (xnintr_irq=
_handler+0x380)
:|  # func               -1601+   4.121  xnsched_pick_next+0x8 (__xnpod_sch=
edule+0x2b4)
:|  # [ 7962] -<?>-  257 -1597+   1.060  __xnpod_schedule+0x4bc (xnpod_susp=
end_thread+0x4fc)
:|  # func               -1596+   2.924  xnarch_save_fpu.isra.23+0x8 (__xnp=
od_schedule+0x510)
:|  # func               -1593+   6.015  xnarch_restore_fpu+0x8 (__xnpod_sc=
hedule+0x518)
:|  # func               -1587    0.666  __ipipe_restore_head+0x8 (__rt_int=
r_wait+0x2b8 [xeno_native])
:|  + end     0x80000000 -1586+   1.893  __ipipe_restore_head+0xa4 (__rt_in=
tr_wait+0x2b8 [xeno_native])


The user space irq handler starts running at this point and does the rt_int=
r_enable syscall.:

:|  + begin   0x80000001 -1584    0.787  __ipipe_notify_syscall+0x144 (pipe=
line_syscall+0x8)
:|  + end     0x80000001 -1584+   6.939  __ipipe_notify_syscall+0x1b0 (pipe=
line_syscall+0x8)
:   + func               -1577    0.803  __ipipe_notify_syscall+0x8 (pipeli=
ne_syscall+0x8)
:|  + begin   0x80000001 -1576    0.696  __ipipe_notify_syscall+0x1dc (pipe=
line_syscall+0x8)
:|  + end     0x80000001 -1575    0.500  __ipipe_notify_syscall+0x110 (pipe=
line_syscall+0x8)
:   + func               -1575    0.787  ipipe_syscall_hook+0x8 (__ipipe_no=
tify_syscall+0x120)
:   + func               -1574+   1.575  hisyscall_event+0x8 (ipipe_syscall=
_hook+0x48)


The thread relaxes for some reason:
:   + func               -1573    0.878  xnshadow_relax+0x8 (hisyscall_even=
t+0x180)
:|  + begin   0x80000000 -1572    0.848  xnshadow_relax+0x1f8 (hisyscall_ev=
ent+0x180)
:|  # func               -1571+   1.803  schedule_linux_call+0x8 (xnshadow_=
relax+0x60)
:|  # func               -1569+   2.075  __ipipe_set_irq_pending+0x8 (sched=
ule_linux_call+0x108)
:|  # func               -1567+   2.166  xnpod_suspend_thread+0x8 (xnshadow=
_relax+0x14c)
:|  # func               -1565    0.651  __ipipe_restore_head+0x8 (xnpod_su=
spend_thread+0x544)
:|  + end     0x80000000 -1564    0.606  __ipipe_restore_head+0xa4 (xnpod_s=
uspend_thread+0x544)
:|  + begin   0x80000000 -1564    0.909  xnpod_suspend_thread+0x538 (xnshad=
ow_relax+0x14c)
:|  # func               -1563    0.803  __xnpod_schedule+0x8 (xnpod_suspen=
d_thread+0x4c4)


Other threads get scheduled in and start running happily:
:|  # [ 7962] -<?>-  257 -1562    0.500  __xnpod_schedule+0x150 (xnpod_susp=
end_thread+0x4c4)
:|  # func               -1561+   1.515  xnsched_pick_next+0x8 (__xnpod_sch=
edule+0x2b4)
:|  # [ 7975] -<?>-   87 -1560    0.560  __xnpod_schedule+0x4bc (xnintr_irq=
_handler+0x380)
:|  # func               -1559    0.757  xnarch_save_fpu.isra.23+0x8 (__xnp=
od_schedule+0x510)
:|  # func               -1559+   1.818  xnarch_restore_fpu+0x8 (__xnpod_sc=
hedule+0x518)
:|  + end     0x00000021 -1557    0.621  __ipipe_grab_irq+0x58 (__ipipe_ret=
_from_except+0x0)
:|  + func               -1556+   1.969  __ipipe_exit_irq+0x8 (__ipipe_grab=
_irq+0x60)


The rt_intr_enable is finally invoked after close to 1ms:
:    +func                -495    0.924  xnshadow_send_sig+0x8 (xnshadow_re=
lax+0x218)
:    +func                -494    0.893  schedule_linux_call+0x8 (xnshadow_=
send_sig+0x40)
:|   +begin   0x80000000  -493+   1.136  schedule_linux_call+0x128 (xnshado=
w_send_sig+0x40)
:|  *+func                -492+   1.015  __ipipe_set_irq_pending+0x8 (sched=
ule_linux_call+0x108)
:|  *+func                -491    0.636  __ipipe_restore_head+0x8 (schedule=
_linux_call+0xdc)
:|   +end     0x80000000  -491+   2.606  __ipipe_restore_head+0xa4 (schedul=
e_linux_call+0xdc)
:    +func                -488+   1.515  __rt_intr_enable+0x8 [xeno_native]=
 (hisyscall_event+0x19c)
:    +func                -487+   1.363  xnregistry_fetch+0x8 (__rt_intr_en=
able+0x60 [xeno_native])
:    +func                -485    0.924  rt_intr_enable+0x8 [xeno_native] (=
__rt_intr_enable+0x6c [xeno_native])
:|   +begin   0x80000000  -484+   1.924  rt_intr_enable+0x210 [xeno_native]=
 (__rt_intr_enable+0x6c [xeno_native])
:|  *+func                -483    0.833  xnintr_enable+0x8 (rt_intr_enable+=
0x1f4 [xeno_native])
:|  *+func                -482    0.848  rthal_irq_enable+0x8 (xnintr_enabl=
e+0x28)
:|  *+func                -481+   2.500  irq_to_desc+0x8 (rthal_irq_enable+=
0x30)
:|  *+func                -478+   1.136  irq_to_desc+0x8 (rthal_irq_enable+=
0x40)
:|  *+func                -477    0.833  qe_ic_unmask_irq+0x8 (rthal_irq_en=
able+0x58)


I believe that this is causing a 1ms latency which is too high and our appl=
ication cannot work properly.

Can you please advice on how I can avoid the relax?

Kind Rgds,
Makarand.


-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of PRADHAN, MA=
KARAND (RC-CA)
Sent: Tuesday, September 29, 2015 1:14 PM
To: Philippe Gerum; Xenomai@xenomai.org
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.=
6.4

Thanks Philippe.

Will correct and retest for latency.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Tuesday, September 29, 2015 12:16 PM
To: PRADHAN, MAKARAND (RC-CA); Xenomai@xenomai.org
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.=
6.4

On 09/29/2015 06:04 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>> Are you playing with the T_LOCK bit?
>
> Yes. We do T_LOCK to lock the scheduler while we are in a critical sectio=
n. Is that why the scheduler does not kick in immediately after the HW int?

If the IRQ happens while some task holds the scheduler lock, the answer is =
yes, that is the point of it.

The scheduler lock is an ugly construct inherited from the dark ages of RTO=
S. Xenomai being about properly emulating these for running legacy code is =
the only reason why this anti-feature is present. I would strongly recommen=
d to use a mutual exclusion mechanism with a finer granularity.

--
Philippe.

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://xenomai.org/mailman/listinfo/xenomai

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation


This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

