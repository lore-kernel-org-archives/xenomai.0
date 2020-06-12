Date: Fri, 12 Jun 2020 10:26:26 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1293572894.22066.1591975586278.JavaMail.zimbra@wolfram.com>
Subject: Exception #14 in kernel space when using rttcp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi list

I get a massive amount of "swithching ... to secondary mode after exception=
 #14 in kernel-space ..." followed by a WARNING as shown below.=20

Can someone enlighten me regarding the meaning of exception #14 ?

Is the "WARNING: CPU: 0 ..." the cause or the symptom ? It has a macro at f=
d.c calling "XENO_WARN_ON(COBALT, fd->refs <=3D 0);

This is for Xenomai 3.1

[  133.458856] [Xenomai] switching RTTest to secondary mode after exception=
 #14 in kernel-space at 0xffffffff8145386e (pid 498)
[  133.461217] ------------[ cut here ]------------
[  133.461218] WARNING: CPU: 0 PID: 199 at /usr/src/kernel/kernel/xenomai/r=
tdm/fd.c:299 __put_fd+0x242/0x290
[  133.461218] Modules linked in: rttcp rtudp rtipv4 intel_powerclamp intel=
_rapl coretemp i915 e1000e rt_igb pcan(O) rtnet video fan thermal_sys
[  133.461225] CPU: 0 PID: 199 Comm: rtnet-stack Tainted: G           O    =
4.9.90-xeno-cobolt #1
[  133.461226] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
0.1.1 04/18/2016
[  133.461226] I-pipe domain: Xenomai
[  133.461227]  ffffc90000947d20 ffffffff81446d18 0000000000000000 00000000=
00000000
[  133.461229]  ffffffff81bb13f0 ffffc90000947d60 ffffffff81078461 0000012b=
00000001
[  133.461231]  0000000000000000 0000000000000000 ffff88026194d000 00000000=
00000000
[  133.461233] Call Trace:
[  133.461234]  [<ffffffff81446d18>] dump_stack+0xbf/0xe7
[  133.461234]  [<ffffffff81078461>] __warn+0xe1/0x100
[  133.461235]  [<ffffffff8107854d>] warn_slowpath_null+0x1d/0x20
[  133.461235]  [<ffffffff811711e2>] __put_fd+0x242/0x290
[  133.461236]  [<ffffffffa00bae46>] ? rtskb_pool_queue_tail+0xa6/0xd0 [rtn=
et]
[  133.461236]  [<ffffffff81171ff6>] rtdm_fd_unlock+0x96/0xc0
[  133.461237]  [<ffffffffa02ed725>] rt_ip_rcv+0x135/0x170 [rtipv4]
[  133.461237]  [<ffffffffa00bc008>] rt_stack_deliver+0xf8/0x220 [rtnet]
[  133.461238]  [<ffffffff8115fd20>] ? xnthread_map+0x330/0x330
[  133.461238]  [<ffffffffa00bc1a0>] rt_stack_mgr_task+0x70/0xa0 [rtnet]
[  133.461239]  [<ffffffff8115fd93>] kthread_trampoline+0x73/0x120
[  133.461240]  [<ffffffff810967a9>] kthread+0xd9/0xf0
[  133.461240]  [<ffffffff810966d0>] ? kthread_park+0x60/0x60
[  133.461241]  [<ffffffff81001c92>] ? do_syscall_64+0x82/0xf0
[  133.461241]  [<ffffffff818e0255>] ret_from_fork+0x55/0x60
[  133.461242] ---[ end trace c5197a4d8608bef3 ]---


Per =C3=96berg=20

