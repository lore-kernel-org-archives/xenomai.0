Subject: Re: Exception #14 in kernel space when using rttcp
References: <1293572894.22066.1591975586278.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f545866d-efc1-e35e-5f69-6a40102a5cb0@siemens.com>
Date: Fri, 12 Jun 2020 17:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <1293572894.22066.1591975586278.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 12.06.20 17:26, Per Oberg via Xenomai wrote:
> Hi list
> 
> I get a massive amount of "swithching ... to secondary mode after exception #14 in kernel-space ..." followed by a WARNING as shown below. 
> 
> Can someone enlighten me regarding the meaning of exception #14 ?
> 
> Is the "WARNING: CPU: 0 ..." the cause or the symptom ? It has a macro at fd.c calling "XENO_WARN_ON(COBALT, fd->refs <= 0);
> 

Likely related: The WARN_ON triggers a stack dump and that may trigger
fixable or ignorable faults. We may consider converting that
XENO_WARN_ON into XENO_WARN_ON_ONCE.

What is actually interesting is the warning itself. Reference counting
became imbalanced. How do you trigger that?

Jan

> This is for Xenomai 3.1
> 
> [  133.458856] [Xenomai] switching RTTest to secondary mode after exception #14 in kernel-space at 0xffffffff8145386e (pid 498)
> [  133.461217] ------------[ cut here ]------------
> [  133.461218] WARNING: CPU: 0 PID: 199 at /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x242/0x290
> [  133.461218] Modules linked in: rttcp rtudp rtipv4 intel_powerclamp intel_rapl coretemp i915 e1000e rt_igb pcan(O) rtnet video fan thermal_sys
> [  133.461225] CPU: 0 PID: 199 Comm: rtnet-stack Tainted: G           O    4.9.90-xeno-cobolt #1
> [  133.461226] Hardware name: Default string Default string/SKYBAY, BIOS 5.0.1.1 04/18/2016
> [  133.461226] I-pipe domain: Xenomai
> [  133.461227]  ffffc90000947d20 ffffffff81446d18 0000000000000000 0000000000000000
> [  133.461229]  ffffffff81bb13f0 ffffc90000947d60 ffffffff81078461 0000012b00000001
> [  133.461231]  0000000000000000 0000000000000000 ffff88026194d000 0000000000000000
> [  133.461233] Call Trace:
> [  133.461234]  [<ffffffff81446d18>] dump_stack+0xbf/0xe7
> [  133.461234]  [<ffffffff81078461>] __warn+0xe1/0x100
> [  133.461235]  [<ffffffff8107854d>] warn_slowpath_null+0x1d/0x20
> [  133.461235]  [<ffffffff811711e2>] __put_fd+0x242/0x290
> [  133.461236]  [<ffffffffa00bae46>] ? rtskb_pool_queue_tail+0xa6/0xd0 [rtnet]
> [  133.461236]  [<ffffffff81171ff6>] rtdm_fd_unlock+0x96/0xc0
> [  133.461237]  [<ffffffffa02ed725>] rt_ip_rcv+0x135/0x170 [rtipv4]
> [  133.461237]  [<ffffffffa00bc008>] rt_stack_deliver+0xf8/0x220 [rtnet]
> [  133.461238]  [<ffffffff8115fd20>] ? xnthread_map+0x330/0x330
> [  133.461238]  [<ffffffffa00bc1a0>] rt_stack_mgr_task+0x70/0xa0 [rtnet]
> [  133.461239]  [<ffffffff8115fd93>] kthread_trampoline+0x73/0x120
> [  133.461240]  [<ffffffff810967a9>] kthread+0xd9/0xf0
> [  133.461240]  [<ffffffff810966d0>] ? kthread_park+0x60/0x60
> [  133.461241]  [<ffffffff81001c92>] ? do_syscall_64+0x82/0xf0
> [  133.461241]  [<ffffffff818e0255>] ret_from_fork+0x55/0x60
> [  133.461242] ---[ end trace c5197a4d8608bef3 ]---
> 
> 
> Per Öberg 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

