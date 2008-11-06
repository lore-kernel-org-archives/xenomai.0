Message-ID: <4912EB75.1060105@domain.hid>
Date: Thu, 06 Nov 2008 14:04:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1225962826.4912b54a14c23@domain.hid>	<4912B760.5000600@domain.hid>
	<1225976575.4912eaff644c6@domain.hid>
In-Reply-To: <1225976575.4912eaff644c6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai installation issue.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: xenomai@xenomai.org

garryt wrote:
> Oups,
> 
> It seems i only reply to you and not to the list.
> For information:
> Here is the log (if someone has the same problem).
> 
> These new options didn't solve the issue.

Call Trace:
 [<ffffffff8027a274>] ? xnthread_init+0x68/0x2dc
 [<ffffffff80275a25>] ? xnpod_init_thread+0x4b/0x340
 [<ffffffff8028f46e>] ? rt_task_create+0xc4/0x48d
 [<ffffffff8026a429>] ? xnheap_alloc+0x552/0x568
 [<ffffffff8037ef6f>] ? __up_read+0x13/0x8a
 [<ffffffff8029802f>] ? __rt_task_create+0x136/0x1d6
 [<ffffffff8027fed3>] ? losyscall_event+0xb2/0x189
 [<ffffffff80266751>] ? __ipipe_dispatch_event+0xcd/0x1df
 [<ffffffff8021bd17>] ? __ipipe_syscall_root+0x97/0x156
 [<ffffffff8045b523>] ? __ipipe_syscall_root_thunk+0x35/0x6a
 [<ffffffff8020bcf4>] ? system_call_after_swapgs+0x54/0x94


Code: 00 00 89 05 c9 58 2b 00 eb 04 48 83 cf 02 48 8d 75 50 48 8d 83 80
00 00 00 48 8b 4e 08 48 8b 11 48 89 48 08 48 89 93 80 00 00 00 <48> 89
42 08 48 89 01 ff 46 10 ff 45 68 40 f6 c7 02 0f 85 d8 00
RIP  [<ffffffff8027b1d6>] __xntimer_init+0x280/0x3a2
 RSP <ffff81007147dca8>
CR2: 0000000000000008
---[ end trace 9a45efdc794cc264 ]---


This is a known issue which has been fixed in trunk and v2.4.x branch.
It will be in the upcoming v2.4.6 release.


-- 
                                                 Gilles.

