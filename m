Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2E29A9FA
	for <xenomai@lists.linux.dev>; Mon, 29 Dec 2025 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766989610; cv=none; b=d6ZMwI/8I4RQ+4YjDPUOVu+wYHCXR/f6cZZTPpaKoLgeU23HGYgR6U+Pmqcts6VPzye7X/PY7WMJxr7O9nv5wIsyFx02leTSbRQJYO73gFwrEvazbssY8MaybVx3BwZ6z51XARbbAuCId3ZCMRp11Go5bEPIwz8FZovxXMRVImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766989610; c=relaxed/simple;
	bh=HlazjiNTvKPi4BP7rt/oI6Hs7bhkfTEGkvTJhnbWTJc=;
	h=To:Cc:Message-Id:Subject:From:Mime-Version:In-Reply-To:References:
	 Content-Type:Date; b=nBl8wALWD32+kFRl9QFLSDOQMZ1oiPUchK8CpcAHhDnHzKys2uW+lWKSTgsZGqSQd3FabDUQ1syqMHlhyzT4ab1jPXLVIgTjpU2eDqpQXJtjBtrg0db2eSXIjRtEtz3XasGgdtbECj0A7moF4Vb0ZQaOehcXFQ6aOu89iqag2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.fvMYWu9_1766989594 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 14:26:35 +0800
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "xenomai" <xenomai@lists.linux.dev>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E5=8F=8C=E6=8B=B4?= <guoshuangshuan@sinsegye.com.cn>, 
	=?utf-8?q?=E9=83=AD=E4=BF=8A?= <guojun@sinsegye.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.4ff005b2.e199.4ffd.a180.d61091628cca@feishu.cn>
Subject: Re: the kernel hang with kernel 6.12
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <41bb39ad-6a2a-43bf-b0e1-672985177045@web.de>
X-Lms-Return-Path: <lba+169521f18+aeb8b4+web.de+liuyang@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.240ee368.f6c7.4e9f.bbf7.7848ef3885bd@feishu.cn>
	<41bb39ad-6a2a-43bf-b0e1-672985177045@web.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Dec 2025 14:26:31 +0800

Hi maintainers,
=C2=A0=C2=A0 =C2=A0 I found that commit b2a37d35 ("KVM: SVM: Use raw_local_=
irq_{disable,enable} in svm_vcpu_enter_exit") caused a serious kernel hang =
on my AMD system when using a real-time patched kernel (Xenomai/Dovetail).
The symptom is: after the guest starts, the vCPU thread gets stuck forever =
in svm_vcpu_run (specifically at the VMRUN instruction), and the host CPU r=
unning the vCPU becomes unresponsive (RCU stalls, net watchdog timeouts, et=
c.).
By comparing the assembly before and after this commit, I noticed that the =
explicit sti / cli around vmrun.
After manually adding back the following code, everything works normally ag=
ain:

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 235c4af6b692..34098ba7f45b 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -173,8 +173,10 @@ SYM_FUNC_START(__svm_vcpu_run)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 VM_CLEAR_CPU_BUFFERS

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 /* Enter guest mode */
+ =C2=A0 =C2=A0 =C2=A0 sti
=C2=A03: =C2=A0 =C2=A0 vmrun %_ASM_AX
=C2=A04:
+ =C2=A0 =C2=A0 =C2=A0 cli
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 /* Pop @svm to RAX while it's the only ava=
ilable register. */
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 pop %_ASM_AX

What was the original motivation for this commit? Was it to fix a specific =
issue or improve compatibility with certain patches (e.g. PREEMPT_RT or oth=
er real-time extensions)?
Is my workaround (explicit sti/cli) safe and acceptable, or is there a bett=
er/proper way to restore compatibility with real-time interrupt pipeline pa=
tches like Dovetail on AMD SVM?

Thank you very much!
Best regards,
liuyang
> From: "Jan Kiszka"<jan.kiszka@web.de>
> Date:=C2=A0 Sat, Dec 27, 2025, 17:11
> Subject:=C2=A0 Re: the kernel hang with kernel 6.12
> To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>, "xenomai"<xenomai@list=
s.linux.dev>
> Cc: "=E5=AE=8B=E5=81=A5=E7=8E=AE"<songjianwei@sinsegye.com.cn>, "=E9=83=
=AD=E5=8F=8C=E6=8B=B4"<guoshuangshuan@sinsegye.com.cn>, "=E9=83=AD=E4=BF=8A=
"<guojun@sinsegye.com.cn>
> On 25.12.25 10:39, =C3=A5=C3=A6=C2=A8 wrote:

> > Hi xenomai:

> > =C2=A0=C2=A0=C2=A0 I'm using the Linux-dovetail kernel version 6.12.55 =
with Cobalt 3.3.1. When I install this kernel on an AMD Ryzen 7 8845HS syst=
em and try to start a virtual machine using QEMU + KVM, the entire host sys=
tem hangs completely.=C2=A0

>=C2=A0
> We likely have a blind spot with KVM on AMD here. If the issue triggers

> immediately and reliably, that should be debuggable, though. There is

> probably something going wrong with hard or soft-disabling of IRQs

> around the switching between a KVM thread and an OOB context.

>=C2=A0
> > I installed the same kernel on an Intel N97 processor and performed the=
 exact same operations =E2=80=94 no system hang occurs.

> > I also tested it on a Hygon 3330 CPU, and the behavior is similar: some=
times the system freezes immediately upon starting the VM, and other times =
it prints some error logs before freezing. Here are the error logs:

>=C2=A0
> Seems like the Hygon is also providing an AMD-based virtualization

> interface. Then it's the same issue.

>=C2=A0
> >=C2=A0

> > [=C2=A0 629.692131] rcu: INFO: rcu_preempt self-detected stall on CPU

> > [=C2=A0 629.692137] rcu: =C2=A0 =C2=A0 4-....: (59999 ticks this GP) id=
le=3Dd6d4/1/0x4000000000000000 softirq=3D10473/10473 fqs=3D15000

> > [=C2=A0 629.692146] rcu: =C2=A0 =C2=A0 (t=3D60000 jiffies g=3D14441 q=
=3D771 ncpus=3D8)

> > [=C2=A0 629.692151] CPU: 4 UID: 0 PID: 128 Comm: ksmd Tainted: G =C2=A0=
 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel-s1=
.7 #metaOS

> > [=C2=A0 629.692154] Tainted: [W]=3DWARN

> > [=C2=A0 629.692155] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 629.692155] IRQ stage: Linux

> > [=C2=A0 629.692156] RIP: 0010:smp_call_function_many_cond+0x12f/0x490

> > [=C2=A0 629.692161] Code: d0 e8 65 ab 5a 00 39 05 df 8b b6 01 76 26 48 =
63 d0 49 8b 4d 00 48 03 0c d5 40 6a 8b 8e 8b 51 08 83 e2 01 74 0a f3 90 8b =
51 08 <83> e2 01 75 f6 83 c0 01 eb c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41

> > [=C2=A0 629.692162] RSP: 0018:ffffbc71005bfb80 EFLAGS: 00000202 ORIG_RA=
X: 0000000000000000

> > [=C2=A0 629.692164] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00=
00000000000000

> > [=C2=A0 629.692165] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00=
00000000000000

> > [=C2=A0 629.692166] RBP: ffffbc71005bfbd8 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 629.692166] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 629.692167] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 629.692168] FS:=C2=A0 0000000000000000(0000) GS:ffff9506adc0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 629.692169] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 629.692170] CR2: 000001984bad1000 CR3: 000000010bf60000 CR4: 00=
00000000750eb0

> > [=C2=A0 629.692171] PKRU: 55555554

> > [=C2=A0 629.692171] Call Trace:

> > [=C2=A0 629.692172]=C2=A0 <TASK>

> > [=C2=A0 629.692175]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10

> > [=C2=A0 629.692178]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10

> > [=C2=A0 629.692179]=C2=A0 ? __pfx_should_flush_tlb+0x10/0x10

> > [=C2=A0 629.692181]=C2=A0 on_each_cpu_cond_mask+0x49/0x80

> > [=C2=A0 629.692183]=C2=A0 native_flush_tlb_multi+0xb0/0x110

> > [=C2=A0 629.692185]=C2=A0 flush_tlb_mm_range+0x157/0x1b0

> > [=C2=A0 629.692188]=C2=A0 ptep_clear_flush+0x61/0x70

> > [=C2=A0 629.692191]=C2=A0 write_protect_page+0x1ad/0x450

> > [=C2=A0 629.692196]=C2=A0 try_to_merge_one_page+0x9f/0x6d0

> > [=C2=A0 629.692198]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 629.692201]=C2=A0 ? mtree_load+0x1f8/0x230

> > [=C2=A0 629.692207]=C2=A0 try_to_merge_with_ksm_page+0x65/0x150

> > [=C2=A0 629.692210]=C2=A0 ksm_scan_thread+0x1cb/0x11e0

> > [=C2=A0 629.692213]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10

> > [=C2=A0 629.692217]=C2=A0 ? __pfx_ksm_scan_thread+0x10/0x10

> > [=C2=A0 629.692218]=C2=A0 kthread+0xfb/0x130

> > [=C2=A0 629.692221]=C2=A0 ? __pfx_kthread+0x10/0x10

> > [=C2=A0 629.692223]=C2=A0 ret_from_fork+0x3e/0x50

> > [=C2=A0 629.692226]=C2=A0 ? __pfx_kthread+0x10/0x10

> > [=C2=A0 629.692227]=C2=A0 ret_from_fork_asm+0x1a/0x30

> > [=C2=A0 629.692233]=C2=A0 </TASK>

> > [=C2=A0 640.032915] rcu: INFO: rcu_preempt detected expedited stalls on=
 CPUs/tasks: { 4-.... 7-...D } 64207 jiffies s: 689 root: 0x90/.

> > [=C2=A0 640.032927] rcu: blocking rcu_node structures (internal RCU deb=
ug):

> > [=C2=A0 640.032932] Sending NMI from CPU 0 to CPUs 4:

> > [=C2=A0 640.032937] NMI backtrace for cpu 4

> > [=C2=A0 640.032938] CPU: 4 UID: 0 PID: 128 Comm: ksmd Tainted: G =C2=A0=
 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel-s1=
.7 #metaOS

> > [=C2=A0 640.032940] Tainted: [W]=3DWARN

> > [=C2=A0 640.032940] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 640.032941] IRQ stage: Linux

> > [=C2=A0 640.032942] RIP: 0010:smp_call_function_many_cond+0x12f/0x490

> > [=C2=A0 640.032943] Code: d0 e8 65 ab 5a 00 39 05 df 8b b6 01 76 26 48 =
63 d0 49 8b 4d 00 48 03 0c d5 40 6a 8b 8e 8b 51 08 83 e2 01 74 0a f3 90 8b =
51 08 <83> e2 01 75 f6 83 c0 01 eb c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41

> > [=C2=A0 640.032944] RSP: 0018:ffffbc71005bfb80 EFLAGS: 00000202

> > [=C2=A0 640.032945] RAX: 0000000000000007 RBX: ffffffff8d0a4d10 RCX: ff=
ff9506adfb2340

> > [=C2=A0 640.032946] RDX: 0000000000000011 RSI: 0000000000000010 RDI: ff=
ff9503802dc0b8

> > [=C2=A0 640.032947] RBP: ffffbc71005bfbd8 R08: 0000000000000007 R09: ff=
ff9503802dc7e8

> > [=C2=A0 640.032948] R10: ffff95038aa31000 R11: 0000000000000000 R12: ff=
ff9506adfb2340

> > [=C2=A0 640.032948] R13: ffff9506adcabd40 R14: 0000000000000001 R15: ff=
ff9506adcabd40

> > [=C2=A0 640.032949] FS:=C2=A0 0000000000000000(0000) GS:ffff9506adc0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 640.032950] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 640.032951] CR2: 000001984bad1000 CR3: 000000010bf60000 CR4: 00=
00000000750eb0

> > [=C2=A0 640.032952] PKRU: 55555554

> > [=C2=A0 640.032952] Call Trace:

> > [=C2=A0 640.032953]=C2=A0 <TASK>

> > [=C2=A0 640.032954]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10

> > [=C2=A0 640.032956]=C2=A0 ? __pfx_flush_tlb_func+0x10/0x10

> > [=C2=A0 640.032957]=C2=A0 ? __pfx_should_flush_tlb+0x10/0x10

> > [=C2=A0 640.032958]=C2=A0 on_each_cpu_cond_mask+0x49/0x80

> > [=C2=A0 640.032961]=C2=A0 native_flush_tlb_multi+0xb0/0x110

> > [=C2=A0 640.032962]=C2=A0 flush_tlb_mm_range+0x157/0x1b0

> > [=C2=A0 640.032965]=C2=A0 ptep_clear_flush+0x61/0x70

> > [=C2=A0 640.032967]=C2=A0 write_protect_page+0x1ad/0x450

> > [=C2=A0 640.032971]=C2=A0 try_to_merge_one_page+0x9f/0x6d0

> > [=C2=A0 640.032973]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.032975]=C2=A0 ? mtree_load+0x1f8/0x230

> > [=C2=A0 640.032978]=C2=A0 try_to_merge_with_ksm_page+0x65/0x150

> > [=C2=A0 640.032981]=C2=A0 ksm_scan_thread+0x1cb/0x11e0

> > [=C2=A0 640.032984]=C2=A0 ? __pfx_autoremove_wake_function+0x10/0x10

> > [=C2=A0 640.032987]=C2=A0 ? __pfx_ksm_scan_thread+0x10/0x10

> > [=C2=A0 640.032988]=C2=A0 kthread+0xfb/0x130

> > [=C2=A0 640.032990]=C2=A0 ? __pfx_kthread+0x10/0x10

> > [=C2=A0 640.032992]=C2=A0 ret_from_fork+0x3e/0x50

> > [=C2=A0 640.032994]=C2=A0 ? __pfx_kthread+0x10/0x10

> > [=C2=A0 640.032995]=C2=A0 ret_from_fork_asm+0x1a/0x30

> > [=C2=A0 640.032999]=C2=A0 </TASK>

> > [=C2=A0 640.033935] Sending NMI from CPU 0 to CPUs 7:

> > [=C2=A0 640.033941] NMI backtrace for cpu 7

> > [=C2=A0 640.033943] CPU: 7 UID: 1000 PID: 1913 Comm: CPU 4/KVM Tainted:=
 G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS

> > [=C2=A0 640.033946] Tainted: [W]=3DWARN

> > [=C2=A0 640.033947] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 640.033947] IRQ stage: Linux

> > [=C2=A0 640.033948] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]

> > [=C2=A0 640.033956] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 =
b9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00

> > [=C2=A0 640.033957] RSP: 0018:ffffbc71031efca0 EFLAGS: 00000056

> > [=C2=A0 640.033959] RAX: 0000000000000800 RBX: ffff95039c31b860 RCX: 00=
00000000000da0

> > [=C2=A0 640.033960] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: ff=
ff95039c31b860

> > [=C2=A0 640.033961] RBP: ffffbc71031efcd0 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 640.033961] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 640.033962] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
000000000a9b48

> > [=C2=A0 640.033963] FS:=C2=A0 00007f140899c6c0(0000) GS:ffff9506adf0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 640.033964] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 640.033965] CR2: 00007ff638732d00 CR3: 000000010986e000 CR4: 00=
00000000750eb0

> > [=C2=A0 640.033966] PKRU: 55555554

> > [=C2=A0 640.033966] Call Trace:

> > [=C2=A0 640.033967]=C2=A0 <TASK>

> > [=C2=A0 640.033970]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]

> > [=C2=A0 640.033998]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.034003]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]

> > [=C2=A0 640.034020]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]

> > [=C2=A0 640.034037]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.034041]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.034042]=C2=A0 ? __fget_files+0x7f/0xb0

> > [=C2=A0 640.034046]=C2=A0 __x64_sys_ioctl+0x97/0xd0

> > [=C2=A0 640.034049]=C2=A0 x64_sys_call+0x1d09/0x1d50

> > [=C2=A0 640.034051]=C2=A0 do_syscall_64+0xc0/0x220

> > [=C2=A0 640.034054]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.034056]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 640.034058]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 640.034060]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 640.034062]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> > [=C2=A0 640.034064] RIP: 0033:0x7f140b417e1d

> > [=C2=A0 640.034065] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 =
10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00

> > [=C2=A0 640.034066] RSP: 002b:00007f140899b440 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000010

> > [=C2=A0 640.034068] RAX: ffffffffffffffda RBX: 000055ad3d2bd5a0 RCX: 00=
007f140b417e1d

> > [=C2=A0 640.034069] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00=
0000000000001a

> > [=C2=A0 640.034069] RBP: 00007f140899b490 R08: 000055ad25e60648 R09: 00=
00000000000001

> > [=C2=A0 640.034070] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 00=
0000000000ae80

> > [=C2=A0 640.034071] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 640.034075]=C2=A0 </TASK>

> > [=C2=A0 701.629797] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:

> > [=C2=A0 701.629805] rcu: =C2=A0 =C2=A0 4-...0: (169 ticks this GP) idle=
=3Dea9c/1/0x4000000000000000 softirq=3D10688/10690 fqs=3D15000

> > [=C2=A0 701.629813] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffie=
s, g=3D14825, q=3D910 ncpus=3D8)

> > [=C2=A0 701.629819] Sending NMI from CPU 0 to CPUs 4:

> > [=C2=A0 701.629824] NMI backtrace for cpu 4

> > [=C2=A0 701.629827] CPU: 4 UID: 1000 PID: 1910 Comm: CPU 1/KVM Tainted:=
 G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS

> > [=C2=A0 701.629830] Tainted: [W]=3DWARN

> > [=C2=A0 701.629830] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 701.629831] IRQ stage: Linux

> > [=C2=A0 701.629832] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]

> > [=C2=A0 701.629841] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 =
b9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00

> > [=C2=A0 701.629842] RSP: 0018:ffffbc71031d7c80 EFLAGS: 00000056

> > [=C2=A0 701.629844] RAX: 0000000000000800 RBX: ffff95038db83860 RCX: 00=
00000000000da0

> > [=C2=A0 701.629845] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: ff=
ff95038db83860

> > [=C2=A0 701.629846] RBP: ffffbc71031d7cb0 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 701.629846] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 701.629847] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
000000000a9b48

> > [=C2=A0 701.629848] FS:=C2=A0 00007f14037fe6c0(0000) GS:ffff9506adc0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 701.629849] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 701.629850] CR2: 000002c591858598 CR3: 000000010986e000 CR4: 00=
00000000750eb0

> > [=C2=A0 701.629851] PKRU: 55555554

> > [=C2=A0 701.629851] Call Trace:

> > [=C2=A0 701.629852]=C2=A0 <TASK>

> > [=C2=A0 701.629856]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]

> > [=C2=A0 701.629884]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629888]=C2=A0 ? kvm_apic_has_interrupt+0x43/0x90 [kvm]

> > [=C2=A0 701.629911]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629913]=C2=A0 ? kvm_cpu_has_interrupt+0x27/0x40 [kvm]

> > [=C2=A0 701.629933]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]

> > [=C2=A0 701.629951]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]

> > [=C2=A0 701.629969]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20

> > [=C2=A0 701.629972]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629974]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629977]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629979]=C2=A0 ? __fget_files+0x7f/0xb0

> > [=C2=A0 701.629982]=C2=A0 __x64_sys_ioctl+0x97/0xd0

> > [=C2=A0 701.629985]=C2=A0 x64_sys_call+0x1d09/0x1d50

> > [=C2=A0 701.629988]=C2=A0 do_syscall_64+0xc0/0x220

> > [=C2=A0 701.629991]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629992]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 701.629994]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.629996]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 701.629998]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.630000]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 701.630001]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 701.630003]=C2=A0 ? arch_pipeline_entry+0xf0/0x120

> > [=C2=A0 701.630005]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> > [=C2=A0 701.630007] RIP: 0033:0x7f140b417e1d

> > [=C2=A0 701.630008] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 =
10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00

> > [=C2=A0 701.630010] RSP: 002b:00007f14037fd440 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000010

> > [=C2=A0 701.630011] RAX: ffffffffffffffda RBX: 000055ad3d2a0590 RCX: 00=
007f140b417e1d

> > [=C2=A0 701.630012] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00=
00000000000014

> > [=C2=A0 701.630013] RBP: 00007f14037fd490 R08: 000055ad25e60648 R09: 00=
00000000000001

> > [=C2=A0 701.630013] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 00=
0000000000ae80

> > [=C2=A0 701.630014] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 701.630018]=C2=A0 </TASK>

> > [=C2=A0 761.828796] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:

> > [=C2=A0 761.828805] rcu: =C2=A0 =C2=A0 2-...0: (1 GPs behind) idle=3Dbb=
04/1/0x4000000000000000 softirq=3D11260/11261 fqs=3D15000

> > [=C2=A0 761.828815] rcu: =C2=A0 =C2=A0 (detected by 3, t=3D60002 jiffie=
s, g=3D14869, q=3D257 ncpus=3D8)

> > [=C2=A0 761.828820] Sending NMI from CPU 3 to CPUs 2:

> > [=C2=A0 761.828827] NMI backtrace for cpu 2

> > [=C2=A0 761.828829] CPU: 2 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted:=
 G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS

> > [=C2=A0 761.828832] Tainted: [W]=3DWARN

> > [=C2=A0 761.828833] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 761.828834] IRQ stage: Linux

> > [=C2=A0 761.828835] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]

> > [=C2=A0 761.828844] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 =
b9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00

> > [=C2=A0 761.828845] RSP: 0018:ffffbc71031dfad0 EFLAGS: 00000056

> > [=C2=A0 761.828847] RAX: 0000000000000800 RBX: ffff950382b5d490 RCX: 00=
00000000000da0

> > [=C2=A0 761.828848] RDX: 0000000000000000 RSI: 0000000000350ef8 RDI: ff=
ff950382b5d490

> > [=C2=A0 761.828849] RBP: ffffbc71031dfb00 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 761.828850] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 761.828851] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
000000000a9b48

> > [=C2=A0 761.828851] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506ada0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 761.828853] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 761.828853] CR2: 0000019849e83000 CR3: 000000010986e000 CR4: 00=
00000000750eb0

> > [=C2=A0 761.828854] PKRU: 55555554

> > [=C2=A0 761.828855] Call Trace:

> > [=C2=A0 761.828856]=C2=A0 <TASK>

> > [=C2=A0 761.828860]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]

> > [=C2=A0 761.828889]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828893]=C2=A0 ? x86_emulate_instruction+0x396/0x6f0 [kvm]

> > [=C2=A0 761.828912]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]

> > [=C2=A0 761.828930]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]

> > [=C2=A0 761.828948]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828951]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828953]=C2=A0 ? __fget_files+0x7f/0xb0

> > [=C2=A0 761.828956]=C2=A0 __x64_sys_ioctl+0x97/0xd0

> > [=C2=A0 761.828960]=C2=A0 x64_sys_call+0x1d09/0x1d50

> > [=C2=A0 761.828962]=C2=A0 do_syscall_64+0xc0/0x220

> > [=C2=A0 761.828966]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828968]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.828970]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828972]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20

> > [=C2=A0 761.828974]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828975]=C2=A0 ? __ct_user_enter+0x99/0x110

> > [=C2=A0 761.828978]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828980]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 761.828982]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828984]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.828985]=C2=A0 ? __ct_user_enter+0x99/0x110

> > [=C2=A0 761.828987]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828989]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 761.828991]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828993]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.828995]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.828997]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.828999]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.829000]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 761.829003]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.829004]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.829006]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 761.829008]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 761.829010]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> > [=C2=A0 761.829012] RIP: 0033:0x7f140b417e1d

> > [=C2=A0 761.829014] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 =
10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00

> > [=C2=A0 761.829015] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 OR=
IG_RAX: 0000000000000010

> > [=C2=A0 761.829016] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 00=
007f140b417e1d

> > [=C2=A0 761.829017] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00=
00000000000016

> > [=C2=A0 761.829018] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 00=
00000000000001

> > [=C2=A0 761.829019] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 00=
0000000000ae80

> > [=C2=A0 761.829019] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 761.829023]=C2=A0 </TASK>

> > [=C2=A0 821.834293] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:

> > [=C2=A0 821.834301] rcu: =C2=A0 =C2=A0 3-...0: (1 GPs behind) idle=3D8c=
a4/1/0x4000000000000000 softirq=3D10896/10897 fqs=3D15000

> > [=C2=A0 821.834310] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffie=
s, g=3D14873, q=3D389 ncpus=3D8)

> > [=C2=A0 821.834315] Sending NMI from CPU 0 to CPUs 3:

> > [=C2=A0 821.834321] NMI backtrace for cpu 3

> > [=C2=A0 821.834324] CPU: 3 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted:=
 G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS

> > [=C2=A0 821.834327] Tainted: [W]=3DWARN

> > [=C2=A0 821.834328] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 821.834328] IRQ stage: Linux

> > [=C2=A0 821.834330] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]

> > [=C2=A0 821.834339] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 =
b9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00

> > [=C2=A0 821.834340] RSP: 0018:ffffbc71031dfad0 EFLAGS: 00000056

> > [=C2=A0 821.834342] RAX: 0000000000000800=C2=A0RBX: ffff950382b5d490 RC=
X: 0000000000000da0

> > [=C2=A0 821.834343] RDX: 0000000000000000 RSI: 0000000000350ef8=C2=A0RD=
I: ffff950382b5d490

> > [=C2=A0 821.834344] RBP: ffffbc71031dfb00 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 821.834345] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 821.834345] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
000000000a9b48

> > [=C2=A0 821.834346] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506adb0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 821.834347] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 821.834348] CR2: 0000019849e83000 CR3: 000000010986e000=C2=A0CR=
4: 0000000000750eb0

> > [=C2=A0 821.834349] PKRU: 55555554

> > [=C2=A0 821.834350] Call Trace:

> > [=C2=A0 821.834351]=C2=A0 <TASK>

> > [=C2=A0 821.834355]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]

> > [=C2=A0 821.834387]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]

> > [=C2=A0 821.834406]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]

> > [=C2=A0 821.834425]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834430]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834432]=C2=A0 ? __fget_files+0x7f/0xb0

> > [=C2=A0 821.834436]=C2=A0 __x64_sys_ioctl+0x97/0xd0

> > [=C2=A0 821.834439]=C2=A0 x64_sys_call+0x1d09/0x1d50

> > [=C2=A0 821.834442]=C2=A0 do_syscall_64+0xc0/0x220

> > [=C2=A0 821.834446]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834448]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834450]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834452]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20

> > [=C2=A0 821.834454]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834456]=C2=A0 ? __ct_user_enter+0x99/0x110

> > [=C2=A0 821.834458]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834460]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 821.834462]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834464]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834466]=C2=A0 ? __ct_user_enter+0x99/0x110

> > [=C2=A0 821.834468]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834470]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 821.834472]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834474]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834476]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834478]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834479]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834481]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 821.834483]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834485]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834487]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 821.834489]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 821.834491]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> > [=C2=A0 821.834493] RIP: 0033:0x7f140b417e1d

> > [=C2=A0 821.834495] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 =
10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00

> > [=C2=A0 821.834496] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 OR=
IG_RAX: 0000000000000010

> > [=C2=A0 821.834497] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 00=
007f140b417e1d

> > [=C2=A0 821.834498] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00=
00000000000016

> > [=C2=A0 821.834499] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 00=
00000000000001

> > [=C2=A0 821.834500] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 00=
0000000000ae80

> > [=C2=A0 821.834501] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 821.834505]=C2=A0 </TASK>

> > [=C2=A0 881.905482] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:

> > [=C2=A0 881.905491] rcu: =C2=A0 =C2=A0 4-...0: (1 GPs behind) idle=3Dec=
5c/1/0x4000000000000000 softirq=3D10733/10734 fqs=3D15000

> > [=C2=A0 881.905500] rcu: =C2=A0 =C2=A0 (detected by 0, t=3D60002 jiffie=
s, g=3D14905, q=3D856 ncpus=3D8)

> > [=C2=A0 881.905505] Sending NMI from CPU 0 to CPUs=C2=A04:

> > [=C2=A0 881.905511] NMI backtrace for cpu 4

> > [=C2=A0 881.905514] CPU: 4 UID: 1000 PID: 1911 Comm: CPU 2/KVM Tainted:=
 G =C2=A0 =C2=A0 =C2=A0=C2=A0 W =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-r=
kernel-s1.7 #metaOS

> > [=C2=A0 881.905517] Tainted: [W]=3DWARN

> > [=C2=A0 881.905518] Hardware name: TianBei GEM12/GEM12, BIOS 1.00 03/07=
/2024

> > [=C2=A0 881.905519] IRQ stage: Linux

> > [=C2=A0 881.905519] RIP: 0010:svm_vcpu_run+0x27a/0x790 [kvm_amd]

> > [=C2=A0 881.905528] Code: 02 00 00 48 3b 82 70 06 00 00 74 13 48 89 c2 =
b9 d9 01 00 00 48 c1 ea 20 0f 30 0f 1f 44 00 00 48 89 df e8 c9 79 ec ff 0f =
01 dc <48> 8b 83 48 19 00 00 83 78 70 61 0f 84 1e 03 00 00 f6 83 00 02 00

> > [=C2=A0 881.905529] RSP: 0018:ffffbc71031dfb70 EFLAGS: 00000056

> > [=C2=A0 881.905531] RAX: 0000000000000800=C2=A0RBX: ffff950382b5d490 RC=
X: 0000000000000da0

> > [=C2=A0 881.905532] RDX: 0000000000000000 RSI: 0000000000350ef8=C2=A0RD=
I: ffff950382b5d490

> > [=C2=A0 881.905533] RBP: ffffbc71031dfba0 R08: 0000000000000000 R09: 00=
00000000000000

> > [=C2=A0 881.905534] R10: 0000000000000000 R11: 0000000000000000 R12: 00=
00000000000000

> > [=C2=A0 881.905535] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
000000000a9b48

> > [=C2=A0 881.905535] FS:=C2=A0 00007f1403fff6c0(0000) GS:ffff9506adc0000=
0(0000) knlGS:0000000000000000

> > [=C2=A0 881.905537] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033

> > [=C2=A0 881.905537] CR2: 0000018933253210 CR3: 000000010986e000=C2=A0CR=
4: 0000000000750eb0

> > [=C2=A0 881.905538] PKRU: 55555554

> > [=C2=A0 881.905539] Call Trace:

> > [=C2=A0 881.905540]=C2=A0 <TASK>

> > [=C2=A0 881.905544]=C2=A0 vcpu_enter_guest+0xaea/0x19b0 [kvm]

> > [=C2=A0 881.905573]=C2=A0 ? debug_smp_processor_id+0x1b/0x30

> > [=C2=A0 881.905579]=C2=A0 kvm_arch_vcpu_ioctl_run+0x156/0x6b0 [kvm]

> > [=C2=A0 881.905597]=C2=A0 kvm_vcpu_ioctl+0x538/0x920 [kvm]

> > [=C2=A0 881.905615]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 881.905618]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905621]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 881.905624]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905626]=C2=A0 ? __fget_files+0x7f/0xb0

> > [=C2=A0 881.905629]=C2=A0 __x64_sys_ioctl+0x97/0xd0

> > [=C2=A0 881.905633]=C2=A0 x64_sys_call+0x1d09/0x1d50

> > [=C2=A0 881.905635]=C2=A0 do_syscall_64+0xc0/0x220

> > [=C2=A0 881.905637]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905639]=C2=A0 ? inband_irq_enable+0xd/0x20

> > [=C2=A0 881.905642]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905643]=C2=A0 ? __schedule+0x13f7/0x1930

> > [=C2=A0 881.905645]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905647]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20

> > [=C2=A0 881.905650]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905652]=C2=A0 ? __this_cpu_preempt_check+0x17/0x20

> > [=C2=A0 881.905653]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905655]=C2=A0 ? __ct_user_enter+0x99/0x110

> > [=C2=A0 881.905657]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905659]=C2=A0 ? syscall_exit_to_user_mode+0x1d5/0x310

> > [=C2=A0 881.905661]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905663]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 881.905665]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905666]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 881.905668]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905670]=C2=A0 ? do_syscall_64+0xcc/0x220

> > [=C2=A0 881.905672]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef5

> > [=C2=A0 881.905673]=C2=A0 ? arch_pipeline_entry+0xf0/0x120

> > [=C2=A0 881.905676]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e

> > [=C2=A0 881.905678] RIP: 0033:0x7f140b417e1d

> > [=C2=A0 881.905679] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 =
10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 =
0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00

> > [=C2=A0 881.905680] RSP: 002b:00007f1403ffe440=C2=A0EFLAGS: 00000246 OR=
IG_RAX: 0000000000000010

> > [=C2=A0 881.905682] RAX: ffffffffffffffda RBX: 000055ad3d2aa020 RCX: 00=
007f140b417e1d

> > [=C2=A0 881.905683] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00=
00000000000016

> > [=C2=A0 881.905683] RBP: 00007f1403ffe490 R08: 000055ad25e60648 R09: 00=
00000000000001

> > [=C2=A0 881.905684] R10: 000055ad3cefe090 R11: 0000000000000246 R12: 00=
0000000000ae80

> > [=C2=A0 881.905685] R13: 0000000000000000 R14: 0000000000000000 R15: 00=
00000000000000

> > [=C2=A0 881.905689]=C2=A0 </TASK>

> >=C2=A0

> >=C2=A0

> > Has anyone encountered this issue before? Any ideas on what might be ca=
using it, or suggestions for debugging/workarounds?

> > Thanks in advance!

>=C2=A0
> Besides debugging and fixing this particular bug, we really need to

> extend our test coverage by a KVM scenario. We could spawn some KVM/QEMU

> aside the switchtest or even expand the latter by KVM thread. People are

> using KVM aside (separate cores) or even on top of Xenomai (same cores),

> but our core CI tests are not reflecting this.

>=C2=A0
> Jan
>=C2=A0
