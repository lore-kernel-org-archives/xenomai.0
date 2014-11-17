From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 17 Nov 2014 10:01:40 +0000
Message-ID: <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>,
 <20141111174652.GK17476@sisyphus.hd.free.fr>
In-Reply-To: <20141111174652.GK17476@sisyphus.hd.free.fr>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
Hi,=0A=
=0A=
> you are completely right, we have implemented our own skin. Using=0A=
> the debugging functionality mentioned above we have identified a=0A=
> function-call that leads to exact the behaviour as described in your post=
.=0A=
>=0A=
> Hopefully solving that issue solves our application crash.=0A=
=0A=
Now the problem "scheduling while atomic" does not occur anymore within API=
 calls of our own skin. However, after some run-time (about 5 minutes or mo=
re) it seems to appear in gatekeeper-thread (see below). =0A=
=0A=
What is not clear to me is the ipipe_raise_irq() call in backtrace below. I=
 could not identify any according call from within gatekeeper_thread(). Do =
I overlook something?=0A=
=0A=
What I also do not understand is the timestamp of kernel message. As mentio=
ned the messages do appear about 5 minutes after kernel start. However the =
message's timestamp are from about 40 seconds after boot? Could it happen t=
hat messages are delayed? Or is the timestamp wrong?=0A=
=0A=
NOTE: The config option CONFIG_TRACE_IRQFLAGS is disabled.=0A=
=0A=
=0A=
[   40.670362] BUG: scheduling while atomic: gatekeeper/0/22/0x00010001=0A=
[   40.670393] CPU: 0 PID: 22 Comm: gatekeeper/0 Not tainted 3.10.18-rt14-a=
rvero-rev01-ipipe #2=0A=
[   40.670480] [<c00130a4>] (unwind_backtrace+0x0/0xf0) from [<c0011484>] (=
show_stack+0x10/0x14)=0A=
[   40.670538] [<c0011484>] (show_stack+0x10/0x14) from [<c048329c>] (__sch=
edule_bug+0x3c/0x54)=0A=
[   40.670581] [<c048329c>] (__schedule_bug+0x3c/0x54) from [<c04887b8>] (_=
_schedule+0x35c/0x4f0)=0A=
[   40.670611] [<c04887b8>] (__schedule+0x35c/0x4f0) from [<c0488980>] (sch=
edule+0x34/0xa0)=0A=
[   40.670646] [<c0488980>] (schedule+0x34/0xa0) from [<c0489628>] (rt_spin=
_lock_slowlock+0x14c/0x308)=0A=
[   40.670684] [<c0489628>] (rt_spin_lock_slowlock+0x14c/0x308) from [<c002=
ad24>] (__lock_task_sighand+0x40/0x6c)=0A=
[   40.670716] [<c002ad24>] (__lock_task_sighand+0x40/0x6c) from [<c002ad74=
>] (do_send_sig_info+0x24/0x64)=0A=
[   40.670748] [<c002ad74>] (do_send_sig_info+0x24/0x64) from [<c00aaf88>] =
(lostage_handler+0xec/0x11c)=0A=
[   40.670778] [<c00aaf88>] (lostage_handler+0xec/0x11c) from [<c006dfa4>] =
(rthal_apc_handler+0x4c/0x60)=0A=
[   40.670810] [<c006dfa4>] (rthal_apc_handler+0x4c/0x60) from [<c00611d8>]=
 (__ipipe_do_sync_stage+0x1f8/0x288)=0A=
[   40.670844] [<c00611d8>] (__ipipe_do_sync_stage+0x1f8/0x288) from [<c001=
4224>] (ipipe_raise_irq+0x18/0x20)=0A=
[   40.670875] [<c0014224>] (ipipe_raise_irq+0x18/0x20) from [<c00aac84>] (=
gatekeeper_thread+0x150/0x368)=0A=
[   40.670918] [<c00aac84>] (gatekeeper_thread+0x150/0x368) from [<c00383f8=
>] (kthread+0x9c/0xa4)=0A=
[   40.670962] [<c00383f8>] (kthread+0x9c/0xa4) from [<c000ea20>] (ret_from=
_fork+0x18/0x38)=0A=
[   40.671179] ------------[ cut here ]------------=0A=
[   40.671233] WARNING: at kernel/softirq.c:748 irq_exit+0x118/0x138()=0A=
[   40.671260] CPU: 0 PID: 22 Comm: gatekeeper/0 Tainted: G        W    3.1=
0.18-rt14-arvero-rev01-ipipe #2=0A=
[   40.671317] [<c00130a4>] (unwind_backtrace+0x0/0xf0) from [<c0011484>] (=
show_stack+0x10/0x14)=0A=
[   40.671372] [<c0011484>] (show_stack+0x10/0x14) from [<c001b7bc>] (warn_=
slowpath_common+0x48/0x64)=0A=
[   40.671416] [<c001b7bc>] (warn_slowpath_common+0x48/0x64) from [<c001b8a=
0>] (warn_slowpath_null+0x1c/0x24)=0A=
[   40.671453] [<c001b8a0>] (warn_slowpath_null+0x1c/0x24) from [<c0023414>=
] (irq_exit+0x118/0x138)=0A=
[   40.671487] [<c0023414>] (irq_exit+0x118/0x138) from [<c00611dc>] (__ipi=
pe_do_sync_stage+0x1fc/0x288)=0A=
[   40.671518] [<c00611dc>] (__ipipe_do_sync_stage+0x1fc/0x288) from [<c001=
4224>] (ipipe_raise_irq+0x18/0x20)=0A=
[   40.671548] [<c0014224>] (ipipe_raise_irq+0x18/0x20) from [<c00aac84>] (=
gatekeeper_thread+0x150/0x368)=0A=
[   40.671586] [<c00aac84>] (gatekeeper_thread+0x150/0x368) from [<c00383f8=
>] (kthread+0x9c/0xa4)=0A=
[   40.671620] [<c00383f8>] (kthread+0x9c/0xa4) from [<c000ea20>] (ret_from=
_fork+0x18/0x38)=0A=
[   40.671632] ---[ end trace 0000000000000002 ]---=0A=
=0A=
=0A=
Thanks and advance=0A=
Christoph=

