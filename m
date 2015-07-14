Message-ID: <55A4BA1C.9080306@siemens.com>
Date: Tue, 14 Jul 2015 09:28:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
In-Reply-To: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging
	request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gowtham Garimella <ggarime1@jhu.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-07-14 02:57, Gowtham Garimella wrote:
>   
> Hi Everyone,
> 
> I have installed xenomai 2.6.4 on ubuntu 14.04 with the latest kernel   3.14.17. My hardware is a NUC i5 computer (NUC5i5MYHE model) with x86  architecture 64 bit computer. I am able  to successfully install xenomai  and am able to reboot the system  normally. I checked that Xenomai is enabled correctly  as seen in /var/log/syslog
> 
> The issue I am facing is that, when I run xeno latency it hangs and  does  not print any latencies. I have seen some posts before on similar   issues but they did not help much. I enabled ipipe tracing and am   attaching the trace. The main part of the log files  that  I think is the issue is these lines:
> 
> 
> [  643.881016] BUG: unable to handle kernel paging request at 00007fff0d573ea0
> [  643.881049] IP: [<ffffffff8163c181>] rthal_strncpy_from_user+0x11/0x30
> [  643.881077] PGD 3f78f8067 PUD 3e5e37067 PMD 3ff7b5067 PTE 80000003cf16c067
> [  643.881108] Oops: 0001 [#1] SMP
> [  643.881124] Modules linked in: x86_pkg_temp_thermal i915 drm_kms_helper
> 
> Output from xeno-latency:
>  xeno latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> 
> xeno-test itself runs fine until it hits the latency test. I am   attaching the trace and kernel config file with this mail. Please let  me  know if this is a kernel configuration issue or a hardware issue  etc. I  can send more information needed to debug this issue.  Any help is appreciated ...
> 
> Regards,
> Gowtham Garimella.
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config_current
> Type: application/octet-stream
> Size: 97142 bytes
> Desc: config_current
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/28c5e2ed/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: trace
> Type: application/octet-stream
> Size: 12330 bytes
> Desc: trace
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/28c5e2ed/attachment-0001.obj>
> 

>From this log:

> [  643.881287] task: ffff880409406a80 ti: ffff88040a208000 task.ti: ffff88040a208000
> [  643.881326] RIP: 0010:[<ffffffff8163c181>]  [<ffffffff8163c181>] rthal_strncpy_from_user+0x11/0x30
> [  643.881378] RSP: 0018:ffff88040a20bdf0  EFLAGS: 00010202
> [  643.881398] RAX: 00007fffffffefff RBX: 0000000000000000 RCX: 000000000000001f
> [  643.881433] RDX: 000000000000001f RSI: 00007fff0d573ea0 RDI: ffff88040a20be18
> [  643.881472] RBP: ffff88040a20bdf0 R08: 00007ffffffff000 R09: ffff88040ce1fb00
> [  643.881508] R10: 000000000001fac4 R11: 00000000000a0040 R12: 00000000fffffff0
> [  643.881546] R13: 00007fff0d573cd0 R14: ffff880409406a80 R15: 0000000000000048
> [  643.881583] FS:  00007fd568d1f700(0000) GS:ffff88040ce00000(0000) knlGS:0000000000000000
> [  643.881635] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  643.881667] CR2: 00007fff0d573ea0 CR3: 00000003e5d40000 CR4: 00000000003407e0
> [  643.881706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  643.881742] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  643.881779] I-pipe domain Linux
> [  643.881798] Stack:
> [  643.881811]  ffff88040a20be90 ffffffff8113bbb4 0000000000000200 ffff88040a20be18
> [  643.881859]  ffffffff810d5dc3 ffff88040a20bf08 ffffffff8181edd6 ffff88040ce1fb00
> [  643.881907]  00000000001e00c0 0000000000605a70 00007fff0d573ea0 0000000000000000
> [  643.881956] Call Trace:
> [  643.881976]  [<ffffffff8113bbb4>] __rt_task_create+0x144/0x220
> [  643.882012]  [<ffffffff810d5dc3>] ? ipipe_trace_function+0x23/0x30
> [  643.882049]  [<ffffffff8181edd6>] ? trace+0x55/0x8f
> [  643.882080]  [<ffffffff81121825>] losyscall_event+0xc5/0x2c0
> [  643.882100]  [<ffffffff810d63de>] ipipe_syscall_hook+0x6e/0xb0
> [  643.882121]  [<ffffffff810d2bcf>] __ipipe_notify_syscall+0x9f/0x400
> [  643.882143]  [<ffffffff8181efda>] pipeline_syscall+0xa/0x17
> [  643.882161] Code: 65 30 b8 81 48 c7 c7 fd d5 bf 81 31 c0 e8 48 34 1d 00 5b 5d c3 0f 1f 44 00 00 e8 cb 2b 1e 00 55 48 89 d1 48 89 e5 48 85 c9 74 0e <ac> aa 84 c0 74 05 48 ff c9 75 f5 48 29 ca 48 89 d0 5d c3 66 2e

This is very strange: We crash on the instruction that is supposed to
copy from user (ac: lods %ds:(%rsi),%al), obviously using a user space
address, and the instruction should be known to the kernel as fix-up
point. However, the fixup is not found, and an oops is generated
instead. So something must have corrupted the fixup table - or it was
never generated properly!

I gave this a quick try, corrupting the name parameter passed from
userspace down on rt_task_create, and also a recent 3.18 kernel crashes
here (instead of returning -EFAULT). Queued, will look into this later.

What this tells us, though, is that userspace is likely out of sync /wrt
to the kernel used here. Please check if both installations actually match.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

