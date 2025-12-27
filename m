Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D91CDFD5
	for <xenomai@lists.linux.dev>; Sat, 27 Dec 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766826656; cv=none; b=NRgZsNKerlVDZqiqYihqQuMYD0XI3jWvuQb1HO5+EDf8T6SNRB9azsS4E9RzvkGFz7pXYqbi5aFPrPI65bXAzJcQXdHoVOjl/dywA1ZrLD/Ynu0lAptXS/r5tWnUg4dE/7PhEyc7dtLBPRVANZq4+UkKcL2aK9Foi9gA1A2jbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766826656; c=relaxed/simple;
	bh=pjPBDLfvKD1v8wbhM+lNoP4S717qnlIBgPSwAAJIeUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0i7DH81d7RulXC+DhvB030xmnfKkBdo+jyKLSNNvnIGMLAUvljnWIZ0h9N/wh3e3EB/t4cYUpHSxPpAgIrIRvtRzVmGLjjR56IuvSuXykozPtjnI/59HzLttqyP2n2DahME8zGp6GvaTNkrx0nAaa+2WsAbzGkEdlJGUl9vCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=valtbuZX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="valtbuZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766826645; x=1767431445; i=jan.kiszka@web.de;
	bh=pjPBDLfvKD1v8wbhM+lNoP4S717qnlIBgPSwAAJIeUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=valtbuZX9CQDwa6p8ilecx2UEgZWXxvgWZ0FmZM+CVyUiBXJcLsqur0jLl9Y0RTp
	 bKSjXy71pRcDH0pdvRDSnY4p0bRLmxtgEi/Ms0rGs8r2iP4frMraxAKV5X6ZGsgev
	 ozMhjNgw+WdRIoq91lDMw4zHoPGeRdsCMCdw3nNffRUqMEPNt9vT7oFKg6PstyKA0
	 PoBIfBvPoesKRl8aJQDOTvLv6xFmdr3ICWsR00CVpXO96/MkuaZRW6jH4n4PEOuyR
	 3QQNmqBxMoIYylXgdO/os1HnGrFTslBPYl+cQWLClqWMQgDn+PM7ct4EFwq2Cf5v5
	 NTqvO4cd6xh4GJROBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.21.22]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1wL74x1yiY-00fAWj; Sat, 27
 Dec 2025 10:10:45 +0100
Message-ID: <41bb39ad-6a2a-43bf-b0e1-672985177045@web.de>
Date: Sat, 27 Dec 2025 10:10:43 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the kernel hang with kernel 6.12
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>,
 =?UTF-8?B?6YOt5Y+M5ou0?= <guoshuangshuan@sinsegye.com.cn>,
 =?UTF-8?B?6YOt5L+K?= <guojun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.240ee368.f6c7.4e9f.bbf7.7848ef3885bd@feishu.cn>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.240ee368.f6c7.4e9f.bbf7.7848ef3885bd@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sEvCxzkOnNNeGjYciGoyU5p8bdORRlvl3VgsrB4vO5mVFJV3Cjk
 oM/KwgHcckWvocVpn5VAc/2Tz4c77cwyuZVvc+3Glqz+ivfTdd3Jzqmw3x4zZYrmyJ+WpW2
 4K6D78smZPUYhjudPyw6VoNumBar6rlzbf4pHqKMD42K2RTa4sWzWumCmtHaM7o9IIoRl+U
 OosQVPbJVjIqfYIDWM9Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5eQWa2TD0BE=;hDiz+0OXPQCu0nYdKYVRiGIU0Ug
 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
 KgLmxnfjDSW7A6hpTFnK6G2gik/Ra

On 25.12.25 10:39, =C3=A5=C3=A6=C2=A8 wrote:
> Hi xenomai:
> =C2=A0=C2=A0=C2=A0 I'm using the Linux-dovetail kernel version 6.12.55 w=
ith Cobalt 3.3.1. When I install this kernel on an AMD Ryzen 7 8845HS syst=
em and try to start a virtual machine using QEMU + KVM, the entire host sy=
stem hangs completely.=C2=A0

We likely have a blind spot with KVM on AMD here. If the issue triggers
immediately and reliably, that should be debuggable, though. There is
probably something going wrong with hard or soft-disabling of IRQs
around the switching between a KVM thread and an OOB context.

> I installed the same kernel on an Intel N97 processor and performed the =
exact same operations =E2=80=94 no system hang occurs.
> I also tested it on a Hygon 3330 CPU, and the behavior is similar: somet=
imes the system freezes immediately upon starting the VM, and other times =
it prints some error logs before freezing. Here are the error logs:

Seems like the Hygon is also providing an AMD-based virtualization
interface. Then it's the same issue.

>=20
> [=C2=A0 629.692131] rcu: INFO: rcu_preempt self-detected stall on CPU
> [=C2=A0 629.692137] rcu: =C2=A0 =C2=A0 4-....: (59999 ticks this GP) idl=
e=3Dd6d4/1/0x4000000000000000 softirq=3D10473/10473 fqs=3D15000
> [=C2=A0 629.692146] rcu: =C2=A0 =C2=A0 (t=3D60000 jiffies g=3D14441 q=3D=
771 ncpus=3D8)
> [=C2=A0 629.692151] CPU: 4 UID: 0 PID: 128 Comm: ksmd Tainted: G =C2=A0 =
=C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel-s1=
.7 #metaOS
> [=C2=A0 629.692154] Tainted: [W]=3DWARN
> [=C2=A0 629.692155] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 629.692155] IRQ stage: Linux
> [=C2=A0 629.692156] RIP: 0010:smp_call_function_many_cond+0x12f/0x490
> [=C2=A0 629.692161] Code: d0 e8 65 ab 5a 00 39 05 df 8b b6 01 76 26 48 6=
3 d0 49 8b 4d 00 48 03 0c d5 40 6a 8b 8e 8b 51 08 83 e2 01 74 0a f3 90 8b =
51 08 <83> e2 01 75 f6 83 c0 01 eb c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41
> [=C2=A0 629.692162] RSP: 0018:ffffbc71005bfb80 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000000
> [=C2=A0 629.692164] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
> [=C2=A0 629.692165] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
> [=C2=A0 629.692166] RBP: ffffbc71005bfbd8 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 629.692166] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 629.692167] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 629.692168] FS:=C2=A0 0000000000000000(0000) GS:ffff9506adc00000=
(0000) knlGS:0000000000000000
> [=C2=A0 629.692169] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 629.692170] CR2: 000001984bad1000 CR3: 000000010bf60000 CR4: 000=
0000000750eb0
> [=C2=A0 629.692171] PKRU: 55555554
> [=C2=A0 629.692171] Call Trace:
> [=C2=A0 629.692172]=C2=A0 <TASK>
> [=C2=A0 629.692175]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10
> [=C2=A0 629.692178]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10
> [=C2=A0 629.692179]=C2=A0 ? __pfx_should_flush_tlb+0x10/0x10
> [=C2=A0 629.692181]=C2=A0 on_each_cpu_cond_mask+0x49/0x80
> [=C2=A0 629.692183]=C2=A0 native_flush_tlb_multi+0xb0/0x110
> [=C2=A0 629.692185]=C2=A0 flush_tlb_mm_range+0x157/0x1b0
> [=C2=A0 629.692188]=C2=A0 ptep_clear_flush+0x61/0x70
> [=C2=A0 629.692191]=C2=A0 write_protect_page+0x1ad/0x450
> [=C2=A0 629.692196]=C2=A0 try_to_merge_one_page+0x9f/0x6d0
> [=C2=A0 629.692198]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 629.692201]=C2=A0 ? mtree_load+0x1f8/0x230
> [=C2=A0 629.692207]=C2=A0 try_to_merge_with_ksm_page+0x65/0x150
> [=C2=A0 629.692210]=C2=A0 ksm_scan_thread+0x1cb/0x11e0
> [=C2=A0 629.692213]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [=C2=A0 629.692217]=C2=A0 ? __pfx_ksm_scan_thread+0x10/0x10
> [=C2=A0 629.692218]=C2=A0 kthread+0xfb/0x130
> [=C2=A0 629.692221]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 629.692223]=C2=A0 ret_from_fork+0x3e/0x50
> [=C2=A0 629.692226]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 629.692227]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [=C2=A0 629.692233]=C2=A0 </TASK>
> [=C2=A0 640.032915] rcu: INFO: rcu_preempt detected expedited stalls on =
CPUs/tasks: { 4-.... 7-...D } 64207 jiffies s: 689 root: 0x90/.
> [=C2=A0 640.032927] rcu: blocking rcu_node structures (internal RCU debu=
g):
> [=C2=A0 640.032932] Sending NMI from CPU 0 to CPUs 4:
> [=C2=A0 640.032937] NMI backtrace for cpu 4
> [=C2=A0 640.032938] CPU: 4 UID: 0 PID: 128 Comm: ksmd Tainted: G =C2=A0 =
=C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel-s1=
.7 #metaOS
> [=C2=A0 640.032940] Tainted: [W]=3DWARN
> [=C2=A0 640.032940] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 640.032941] IRQ stage: Linux
> [=C2=A0 640.032942] RIP: 0010:smp_call_function_many_cond+0x12f/0x490
> [=C2=A0 640.032943] Code: d0 e8 65 ab 5a 00 39 05 df 8b b6 01 76 26 48 6=
3 d0 49 8b 4d 00 48 03 0c d5 40 6a 8b 8e 8b 51 08 83 e2 01 74 0a f3 90 8b =
51 08 <83> e2 01 75 f6 83 c0 01 eb c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41
> [=C2=A0 640.032944] RSP: 0018:ffffbc71005bfb80 EFLAGS: 00000202
> [=C2=A0 640.032945] RAX: 0000000000000007 RBX: ffffffff8d0a4d10 RCX: fff=
f9506adfb2340
> [=C2=A0 640.032946] RDX: 0000000000000011 RSI: 0000000000000010 RDI: fff=
f9503802dc0b8
> [=C2=A0 640.032947] RBP: ffffbc71005bfbd8 R08: 0000000000000007 R09: fff=
f9503802dc7e8
> [=C2=A0 640.032948] R10: ffff95038aa31000 R11: 0000000000000000 R12: fff=
f9506adfb2340
> [=C2=A0 640.032948] R13: ffff9506adcabd40 R14: 0000000000000001 R15: fff=
f9506adcabd40
> [=C2=A0 640.032949] FS:=C2=A0 0000000000000000(0000) GS:ffff9506adc00000=
(0000) knlGS:0000000000000000
> [=C2=A0 640.032950] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 640.032951] CR2: 000001984bad1000 CR3: 000000010bf60000 CR4: 000=
0000000750eb0
> [=C2=A0 640.032952] PKRU: 55555554
> [=C2=A0 640.032952] Call Trace:
> [=C2=A0 640.032953]=C2=A0 <TASK>
> [=C2=A0 640.032954]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10
> [=C2=A0 640.032956]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10
> [=C2=A0 640.032957]=C2=A0 ? __pfx_should_flush_tlb+0x10/0x10
> [=C2=A0 640.032958]=C2=A0 on_each_cpu_cond_mask+0x49/0x80
> [=C2=A0 640.032961]=C2=A0 native_flush_tlb_multi+0xb0/0x110
> [=C2=A0 640.032962]=C2=A0 flush_tlb_mm_range+0x157/0x1b0
> [=C2=A0 640.032965]=C2=A0 ptep_clear_flush+0x61/0x70
> [=C2=A0 640.032967]=C2=A0 write_protect_page+0x1ad/0x450
> [=C2=A0 640.032971]=C2=A0 try_to_merge_one_page+0x9f/0x6d0
> [=C2=A0 640.032973]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.032975]=C2=A0 ? mtree_load+0x1f8/0x230
> [=C2=A0 640.032978]=C2=A0 try_to_merge_with_ksm_page+0x65/0x150
> [=C2=A0 640.032981]=C2=A0 ksm_scan_thread+0x1cb/0x11e0
> [=C2=A0 640.032984]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10
> [=C2=A0 640.032987]=C2=A0 ? __pfx_ksm_scan_thread+0x10/0x10
> [=C2=A0 640.032988]=C2=A0 kthread+0xfb/0x130
> [=C2=A0 640.032990]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 640.032992]=C2=A0 ret_from_fork+0x3e/0x50
> [=C2=A0 640.032994]=C2=A0 ? __pfx_kthread+0x10/0x10
> [=C2=A0 640.032995]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [=C2=A0 640.032999]=C2=A0 </TASK>
> [=C2=A0 640.033935] Sending NMI from CPU 0 to CPUs 7:
> [=C2=A0 640.033941] NMI backtrace for cpu 7
> [=C2=A0 640.033943] CPU: 7 UID: 1000 PID: 1913 Comm: CPU 4/KVM Tainted: =
G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS
> [=C2=A0 640.033946] Tainted: [W]=3DWARN
> [=C2=A0 640.033947] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 640.033947] IRQ stage: Linux
> [=C2=A0 640.033948] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]
> [=C2=A0 640.033956] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 b=
9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00
> [=C2=A0 640.033957] RSP: 0018:ffffbc71031efca0 EFLAGS: 00000056
> [=C2=A0 640.033959] RAX: 0000000000000800 RBX: ffff95039c31b860 RCX: 000=
0000000000da0
> [=C2=A0 640.033960] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: fff=
f95039c31b860
> [=C2=A0 640.033961] RBP: ffffbc71031efcd0 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 640.033961] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 640.033962] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
00000000a9b48
> [=C2=A0 640.033963] FS:=C2=A0 00007f140899c6c0(0000) GS:ffff9506adf00000=
(0000) knlGS:0000000000000000
> [=C2=A0 640.033964] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 640.033965] CR2: 00007ff638732d00 CR3: 000000010986e000 CR4: 000=
0000000750eb0
> [=C2=A0 640.033966] PKRU: 55555554
> [=C2=A0 640.033966] Call Trace:
> [=C2=A0 640.033967]=C2=A0 <TASK>
> [=C2=A0 640.033970]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]
> [=C2=A0 640.033998]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.034003]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]
> [=C2=A0 640.034020]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]
> [=C2=A0 640.034037]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.034041]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.034042]=C2=A0 ? __fget_files+0x7f/0xb0
> [=C2=A0 640.034046]=C2=A0 __x64_sys_ioctl+0x97/0xd0
> [=C2=A0 640.034049]=C2=A0 x64_sys_call+0x1d09/0x1d50
> [=C2=A0 640.034051]=C2=A0 do_syscall_64+0xc0/0x220
> [=C2=A0 640.034054]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.034056]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 640.034058]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 640.034060]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 640.034062]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 640.034064] RIP: 0033:0x7f140b417e1d
> [=C2=A0 640.034065] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [=C2=A0 640.034066] RSP: 002b:00007f140899b440 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
> [=C2=A0 640.034068] RAX: ffffffffffffffda RBX: 000055ad3d2bd5a0 RCX: 000=
07f140b417e1d
> [=C2=A0 640.034069] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000=
000000000001a
> [=C2=A0 640.034069] RBP: 00007f140899b490 R08: 000055ad25e60648 R09: 000=
0000000000001
> [=C2=A0 640.034070] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 000=
000000000ae80
> [=C2=A0 640.034071] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 640.034075]=C2=A0 </TASK>
> [=C2=A0 701.629797] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks=
:
> [=C2=A0 701.629805] rcu: =C2=A0 =C2=A0 4-...0: (169 ticks this GP) idle=
=3Dea9c/1/0x4000000000000000 softirq=3D10688/10690 fqs=3D15000
> [=C2=A0 701.629813] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffies=
, g=3D14825, q=3D910 ncpus=3D8)
> [=C2=A0 701.629819] Sending NMI from CPU 0 to CPUs 4:
> [=C2=A0 701.629824] NMI backtrace for cpu 4
> [=C2=A0 701.629827] CPU: 4 UID: 1000 PID: 1910 Comm: CPU 1/KVM Tainted: =
G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS
> [=C2=A0 701.629830] Tainted: [W]=3DWARN
> [=C2=A0 701.629830] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 701.629831] IRQ stage: Linux
> [=C2=A0 701.629832] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]
> [=C2=A0 701.629841] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 b=
9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00
> [=C2=A0 701.629842] RSP: 0018:ffffbc71031d7c80 EFLAGS: 00000056
> [=C2=A0 701.629844] RAX: 0000000000000800 RBX: ffff95038db83860 RCX: 000=
0000000000da0
> [=C2=A0 701.629845] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: fff=
f95038db83860
> [=C2=A0 701.629846] RBP: ffffbc71031d7cb0 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 701.629846] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 701.629847] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
00000000a9b48
> [=C2=A0 701.629848] FS:=C2=A0 00007f14037fe6c0(0000) GS:ffff9506adc00000=
(0000) knlGS:0000000000000000
> [=C2=A0 701.629849] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 701.629850] CR2: 000002c591858598 CR3: 000000010986e000 CR4: 000=
0000000750eb0
> [=C2=A0 701.629851] PKRU: 55555554
> [=C2=A0 701.629851] Call Trace:
> [=C2=A0 701.629852]=C2=A0 <TASK>
> [=C2=A0 701.629856]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]
> [=C2=A0 701.629884]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629888]=C2=A0 ? kvm_apic_has_interrupt+0x43/0x90 [kvm]
> [=C2=A0 701.629911]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629913]=C2=A0 ? kvm_cpu_has_interrupt+0x27/0x40 [kvm]
> [=C2=A0 701.629933]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]
> [=C2=A0 701.629951]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]
> [=C2=A0 701.629969]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20
> [=C2=A0 701.629972]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629974]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629977]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629979]=C2=A0 ? __fget_files+0x7f/0xb0
> [=C2=A0 701.629982]=C2=A0 __x64_sys_ioctl+0x97/0xd0
> [=C2=A0 701.629985]=C2=A0 x64_sys_call+0x1d09/0x1d50
> [=C2=A0 701.629988]=C2=A0 do_syscall_64+0xc0/0x220
> [=C2=A0 701.629991]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629992]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 701.629994]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.629996]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 701.629998]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.630000]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 701.630001]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 701.630003]=C2=A0 ? arch_pipeline_entry+0xf0/0x120
> [=C2=A0 701.630005]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 701.630007] RIP: 0033:0x7f140b417e1d
> [=C2=A0 701.630008] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [=C2=A0 701.630010] RSP: 002b:00007f14037fd440 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
> [=C2=A0 701.630011] RAX: ffffffffffffffda RBX: 000055ad3d2a0590 RCX: 000=
07f140b417e1d
> [=C2=A0 701.630012] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000=
0000000000014
> [=C2=A0 701.630013] RBP: 00007f14037fd490 R08: 000055ad25e60648 R09: 000=
0000000000001
> [=C2=A0 701.630013] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 000=
000000000ae80
> [=C2=A0 701.630014] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 701.630018]=C2=A0 </TASK>
> [=C2=A0 761.828796] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks=
:
> [=C2=A0 761.828805] rcu: =C2=A0 =C2=A0 2-...0: (1 GPs behind) idle=3Dbb0=
4/1/0x4000000000000000 softirq=3D11260/11261 fqs=3D15000
> [=C2=A0 761.828815] rcu: =C2=A0 =C2=A0 (detected by 3, t=3D60002 jiffies=
, g=3D14869, q=3D257 ncpus=3D8)
> [=C2=A0 761.828820] Sending NMI from CPU 3 to CPUs 2:
> [=C2=A0 761.828827] NMI backtrace for cpu 2
> [=C2=A0 761.828829] CPU: 2 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted: =
G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS
> [=C2=A0 761.828832] Tainted: [W]=3DWARN
> [=C2=A0 761.828833] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 761.828834] IRQ stage: Linux
> [=C2=A0 761.828835] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]
> [=C2=A0 761.828844] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 b=
9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00
> [=C2=A0 761.828845] RSP: 0018:ffffbc71031dfad0 EFLAGS: 00000056
> [=C2=A0 761.828847] RAX: 0000000000000800 RBX: ffff950382b5d490 RCX: 000=
0000000000da0
> [=C2=A0 761.828848] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: fff=
f950382b5d490
> [=C2=A0 761.828849] RBP: ffffbc71031dfb00 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 761.828850] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 761.828851] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
00000000a9b48
> [=C2=A0 761.828851] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506ada00000=
(0000) knlGS:0000000000000000
> [=C2=A0 761.828853] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 761.828853] CR2: 0000019849e83000 CR3: 000000010986e000 CR4: 000=
0000000750eb0
> [=C2=A0 761.828854] PKRU: 55555554
> [=C2=A0 761.828855] Call Trace:
> [=C2=A0 761.828856]=C2=A0 <TASK>
> [=C2=A0 761.828860]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]
> [=C2=A0 761.828889]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828893]=C2=A0 ? x86_emulate_instruction+0x396/0x6f0 [kvm]
> [=C2=A0 761.828912]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]
> [=C2=A0 761.828930]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]
> [=C2=A0 761.828948]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828951]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828953]=C2=A0 ? __fget_files+0x7f/0xb0
> [=C2=A0 761.828956]=C2=A0 __x64_sys_ioctl+0x97/0xd0
> [=C2=A0 761.828960]=C2=A0 x64_sys_call+0x1d09/0x1d50
> [=C2=A0 761.828962]=C2=A0 do_syscall_64+0xc0/0x220
> [=C2=A0 761.828966]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828968]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.828970]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828972]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20
> [=C2=A0 761.828974]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828975]=C2=A0 ? __ct_user_enter+0x99/0x110
> [=C2=A0 761.828978]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828980]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 761.828982]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828984]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.828985]=C2=A0 ? __ct_user_enter+0x99/0x110
> [=C2=A0 761.828987]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828989]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 761.828991]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828993]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.828995]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.828997]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.828999]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.829000]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 761.829003]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.829004]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.829006]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 761.829008]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 761.829010]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 761.829012] RIP: 0033:0x7f140b417e1d
> [=C2=A0 761.829014] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [=C2=A0 761.829015] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 ORI=
G_RAX: 0000000000000010
> [=C2=A0 761.829016] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 000=
07f140b417e1d
> [=C2=A0 761.829017] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000=
0000000000016
> [=C2=A0 761.829018] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 000=
0000000000001
> [=C2=A0 761.829019] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 000=
000000000ae80
> [=C2=A0 761.829019] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 761.829023]=C2=A0 </TASK>
> [=C2=A0 821.834293] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks=
:
> [=C2=A0 821.834301] rcu: =C2=A0 =C2=A0 3-...0: (1 GPs behind) idle=3D8ca=
4/1/0x4000000000000000 softirq=3D10896/10897 fqs=3D15000
> [=C2=A0 821.834310] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffies=
, g=3D14873, q=3D389 ncpus=3D8)
> [=C2=A0 821.834315] Sending NMI from CPU 0 to CPUs 3:
> [=C2=A0 821.834321] NMI backtrace for cpu 3
> [=C2=A0 821.834324] CPU: 3 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted: =
G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS
> [=C2=A0 821.834327] Tainted: [W]=3DWARN
> [=C2=A0 821.834328] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 821.834328] IRQ stage: Linux
> [=C2=A0 821.834330] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]
> [=C2=A0 821.834339] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 b=
9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00
> [=C2=A0 821.834340] RSP: 0018:ffffbc71031dfad0 EFLAGS: 00000056
> [=C2=A0 821.834342] RAX: 0000000000000800=C2=A0RBX: ffff950382b5d490 RCX=
: 0000000000000da0
> [=C2=A0 821.834343] RDX: 0000000000000000 RSI: 0000000000350ef8=C2=A0RDI=
: ffff950382b5d490
> [=C2=A0 821.834344] RBP: ffffbc71031dfb00 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 821.834345] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 821.834345] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
00000000a9b48
> [=C2=A0 821.834346] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506adb00000=
(0000) knlGS:0000000000000000
> [=C2=A0 821.834347] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 821.834348] CR2: 0000019849e83000 CR3: 000000010986e000=C2=A0CR4=
: 0000000000750eb0
> [=C2=A0 821.834349] PKRU: 55555554
> [=C2=A0 821.834350] Call Trace:
> [=C2=A0 821.834351]=C2=A0 <TASK>
> [=C2=A0 821.834355]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]
> [=C2=A0 821.834387]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]
> [=C2=A0 821.834406]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]
> [=C2=A0 821.834425]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834430]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834432]=C2=A0 ? __fget_files+0x7f/0xb0
> [=C2=A0 821.834436]=C2=A0 __x64_sys_ioctl+0x97/0xd0
> [=C2=A0 821.834439]=C2=A0 x64_sys_call+0x1d09/0x1d50
> [=C2=A0 821.834442]=C2=A0 do_syscall_64+0xc0/0x220
> [=C2=A0 821.834446]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834448]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834450]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834452]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20
> [=C2=A0 821.834454]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834456]=C2=A0 ? __ct_user_enter+0x99/0x110
> [=C2=A0 821.834458]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834460]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 821.834462]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834464]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834466]=C2=A0 ? __ct_user_enter+0x99/0x110
> [=C2=A0 821.834468]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834470]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 821.834472]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834474]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834476]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834478]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834479]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834481]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 821.834483]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834485]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834487]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 821.834489]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 821.834491]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 821.834493] RIP: 0033:0x7f140b417e1d
> [=C2=A0 821.834495] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [=C2=A0 821.834496] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 ORI=
G_RAX: 0000000000000010
> [=C2=A0 821.834497] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 000=
07f140b417e1d
> [=C2=A0 821.834498] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000=
0000000000016
> [=C2=A0 821.834499] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 000=
0000000000001
> [=C2=A0 821.834500] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 000=
000000000ae80
> [=C2=A0 821.834501] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 821.834505]=C2=A0 </TASK>
> [=C2=A0 881.905482] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks=
:
> [=C2=A0 881.905491] rcu: =C2=A0 =C2=A0 4-...0: (1 GPs behind) idle=3Dec5=
c/1/0x4000000000000000 softirq=3D10733/10734 fqs=3D15000
> [=C2=A0 881.905500] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffies=
, g=3D14905, q=3D856 ncpus=3D8)
> [=C2=A0 881.905505] Sending NMI from CPU 0 to CPUs=C2=A04:
> [=C2=A0 881.905511] NMI backtrace for cpu 4
> [=C2=A0 881.905514] CPU: 4 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted: =
G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS
> [=C2=A0 881.905517] Tainted: [W]=3DWARN
> [=C2=A0 881.905518] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07/=
2024
> [=C2=A0 881.905519] IRQ stage: Linux
> [=C2=A0 881.905519] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]
> [=C2=A0 881.905528] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 b=
9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00
> [=C2=A0 881.905529] RSP: 0018:ffffbc71031dfb70 EFLAGS: 00000056
> [=C2=A0 881.905531] RAX: 0000000000000800=C2=A0RBX: ffff950382b5d490 RCX=
: 0000000000000da0
> [=C2=A0 881.905532] RDX: 0000000000000000 RSI: 0000000000350ef8=C2=A0RDI=
: ffff950382b5d490
> [=C2=A0 881.905533] RBP: ffffbc71031dfba0 R08: 0000000000000000 R09: 000=
0000000000000
> [=C2=A0 881.905534] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
> [=C2=A0 881.905535] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
00000000a9b48
> [=C2=A0 881.905535] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506adc00000=
(0000) knlGS:0000000000000000
> [=C2=A0 881.905537] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [=C2=A0 881.905537] CR2: 0000018933253210 CR3: 000000010986e000=C2=A0CR4=
: 0000000000750eb0
> [=C2=A0 881.905538] PKRU: 55555554
> [=C2=A0 881.905539] Call Trace:
> [=C2=A0 881.905540]=C2=A0 <TASK>
> [=C2=A0 881.905544]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]
> [=C2=A0 881.905573]=C2=A0 ? debug_smp_processor_id+0x1b/0x30
> [=C2=A0 881.905579]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]
> [=C2=A0 881.905597]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]
> [=C2=A0 881.905615]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 881.905618]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905621]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 881.905624]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905626]=C2=A0 ? __fget_files+0x7f/0xb0
> [=C2=A0 881.905629]=C2=A0 __x64_sys_ioctl+0x97/0xd0
> [=C2=A0 881.905633]=C2=A0 x64_sys_call+0x1d09/0x1d50
> [=C2=A0 881.905635]=C2=A0 do_syscall_64+0xc0/0x220
> [=C2=A0 881.905637]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905639]=C2=A0 ? inband_irq_enable+0xd/0x20
> [=C2=A0 881.905642]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905643]=C2=A0 ? __schedule+0x13f7/0x1930
> [=C2=A0 881.905645]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905647]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20
> [=C2=A0 881.905650]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905652]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20
> [=C2=A0 881.905653]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905655]=C2=A0 ? __ct_user_enter+0x99/0x110
> [=C2=A0 881.905657]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905659]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310
> [=C2=A0 881.905661]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905663]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 881.905665]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905666]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 881.905668]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905670]=C2=A0 ? do_syscall_64+0xcc/0x220
> [=C2=A0 881.905672]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5
> [=C2=A0 881.905673]=C2=A0 ? arch_pipeline_entry+0xf0/0x120
> [=C2=A0 881.905676]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 881.905678] RIP: 0033:0x7f140b417e1d
> [=C2=A0 881.905679] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [=C2=A0 881.905680] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 ORI=
G_RAX: 0000000000000010
> [=C2=A0 881.905682] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 000=
07f140b417e1d
> [=C2=A0 881.905683] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000=
0000000000016
> [=C2=A0 881.905683] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 000=
0000000000001
> [=C2=A0 881.905684] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 000=
000000000ae80
> [=C2=A0 881.905685] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
> [=C2=A0 881.905689]=C2=A0 </TASK>
>=20
>=20
> Has anyone encountered this issue before? Any ideas on what might be cau=
sing it, or suggestions for debugging/workarounds?
> Thanks in advance!

Besides debugging and fixing this particular bug, we really need to
extend our test coverage by a KVM scenario. We could spawn some KVM/QEMU
aside the switchtest or even expand the latter by KVM thread. People are
using KVM aside (separate cores) or even on top of Xenomai (same cores),
but our core CI tests are not reflecting this.

Jan
