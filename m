Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC171C3D
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cIK66TAs"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202310050705538329e252fd9058ae72
        for <xenomai@lists.linux.dev>;
        Thu, 05 Oct 2023 09:05:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3inmsD1kYiotaCZMeRHK5PQnbHu+A5EK316N9BjVhxQ=;
 b=cIK66TAsLm8univSoX5bqgAgJnrtHBR1xlLfhfAlEkKzcE77AdmOzMu75y4vygWj3vLLP4
 1Ysw905XTN3J69I4vF1YLwSOAl44tzXk6A1vE/WVL7I8UmyRWTfylNtQLbnjuAXqp4IWrCs0
 ayWvtnkU9I8bqr+bAcug7KW+fo4eg=;
Message-ID: <39be75e9fd66fc5d3c85409b0cb13be8c9b27f02.camel@siemens.com>
Subject: Re: Dovetail 6.1.54: IRQ handler enables HW irqs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 05 Oct 2023 09:05:53 +0200
In-Reply-To: <877co4rxqh.fsf@xenomai.org>
References: <1cd875106cdf555e52734462a9d846ffd3549556.camel@siemens.com>
	 <877co4rxqh.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

On Tue, 2023-10-03 at 08:56 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Philippe, Hi Jan,
> >=20
> > I'm currently testing the latest Dovetail 6.1.x release, which is
> > 6.1.54 to my best knowledge.=20
> >=20
> > After updating I run into the following problem. There have been recent
> > changes to the handling of per-cpu IRQs, that might be related.
> >=20
> > The problem occurs when using stress-ng to simulate system load when
> > running on VirtualBox as VMM on a Windows Host. The Linux host is still
> > running the test but might be affected too.
> >=20
> > The machine "dies"/"hangs" a few seconds after the first reporting.
> >=20
>=20
> Capturing a trace dump would help in debugging this, with
> traceoff_on_warning set on the bootcmd line.
>=20

I tried hard to come up with a trace, stared at it for a while now and
came to the point where I had to realize that it doesn't make sense and
doesn't match the code I'm looking at.

It turned out that I made a serious configuration mistake.
CONFIG_IRQ_PIPELINE was set to n.

IOW, it seems we have a problem when CONFIG_IRQ_PIPELINE is set to n.

IRQ 21 is a shared IRQ, taken from /proc/interrupts:

     CPU0   CPU1   CPU2   CPU3
21: 100330   0      0      0    IO-APIC     21    -fasteoi   ahci[0000:00:0=
d.0], snd_intel8x0

As long as the system seems fine the trace looks like that:

stress-ng-iomix-981   [000]  6241.171317: irq_handler_entry:    irq=3D21 na=
me=3Dahci[0000:00:0d.0]
stress-ng-iomix-981   [000]  6241.175512: irq_handler_exit:     irq=3D21 re=
t=3Dhandled
stress-ng-iomix-981   [000]  6241.175513: irq_handler_entry:    irq=3D21 na=
me=3Dsnd_intel8x0
stress-ng-iomix-981   [000]  6241.175567: irq_handler_exit:     irq=3D21 re=
t=3Dunhandled

Both IRQ actions are handled.

The last thing I get out of my machine before it dies:

stress-ng-iomix-981   [000]  6241.179080: irq_handler_entry:    irq=3D21 na=
me=3Dahci[0000:00:0d.0]
stress-ng-iomix-981   [000]  6241.181057: local_timer_entry:    vector=3D23=
6
stress-ng-iomix-981   [000]  6241.181062: softirq_raise:        vec=3D1 [ac=
tion=3DTIMER]
stress-ng-iomix-981   [000]  6241.181063: softirq_raise:        vec=3D9 [ac=
tion=3DRCU]
stress-ng-iomix-981   [000]  6241.181121: local_timer_exit:     vector=3D23=
6
stress-ng-iomix-981   [000]  6241.181359: irq_handler_exit:     irq=3D21 re=
t=3Dhandled
stress-ng-iomix-981   [000]  6241.191936: local_timer_entry:    vector=3D23=
6
stress-ng-iomix-981   [000]  6241.191942: softirq_raise:        vec=3D1 [ac=
tion=3DTIMER]
stress-ng-iomix-981   [000]  6241.191943: softirq_raise:        vec=3D9 [ac=
tion=3DRCU]
stress-ng-iomix-981   [000]  6241.193224: local_timer_exit:     vector=3D23=
6

Somehow a timer IRQ managed to intercepted the currently running ahci
IRQ.

Now back to CONFIG_IRQ_PIPELINE=3Dy. Different problem, now related to
spin locks:

[  190.344675] [Xenomai] lock 00000000654e1a40 already unlocked on CPU #2
                         last owner =3D kernel/xenomai/pipeline/intr.c:28 (=
xnintr_core_clock_handler(), CPU #-2)
[  190.344681] CPU: 2 PID: 589 Comm: stress-ng-iomix Not tainted 6.1.54-xen=
omai-1 #1
[  190.344684] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Virt=
ualBox 12/01/2006
[  190.344684] IRQ stage: Xenomai
[  190.344685] Call Trace:
[  190.344688]  <TASK>
[  190.344691]  dump_stack_lvl+0x71/0xa0
[  190.344696]  xnlock_dbg_release.cold+0x21/0x2c
[  190.344699]  xnintr_core_clock_handler+0xa4/0x140
[  190.344703]  lapic_oob_handler+0x41/0xf0
[  190.344707]  do_oob_irq+0x25a/0x3e0
[  190.344710]  ? page_add_file_rmap+0x85/0xb0
[  190.344713]  handle_oob_irq+0x4e/0xe0
[  190.344715]  generic_pipeline_irq_desc+0xb0/0x160
[  190.344717]  arch_handle_irq+0x5d/0x1e0
[  190.344720]  arch_pipeline_entry+0xa1/0x110
[  190.344724]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  190.344936] RIP: 0010:bpf_lsm_mmap_addr+0x0/0x10
[  190.344939] Code: c0 c3 cc cc cc cc 0f 1f 40 00 0f 1f 44 00 00 c3 cc cc =
cc cc 66=C2=A0
0f 1f 44 00 00 0f 1f 44 00 00 31 c0 c3 cc cc cc cc 0f 1f 40 00 <0f> 1f 44 0=
0 00 31=C2=A0
c0 c3 cc cc cc cc 0f 1f 40 00 0f 1f 44 00 00 31
[  190.344941] RSP: 0018:ffffb59481177d58 EFLAGS: 00010286
[  190.344943] RAX: ffffffff94a4a950 RBX: ffffffff95c39b18 RCX: 00005609132=
0bfff
[  190.344944] RDX: 0000000000000000 RSI: 00005609131eb000 RDI: 00007f85ff0=
42000
[  190.344945] RBP: 00007f85ff042000 R08: ffff914eca5bda00 R09: ffff914eca5=
bda90
[  190.344946] R10: ffff914eca5bda08 R11: 0000000000000fff R12: 00000000000=
08021
[  190.344947] R13: 0000000000000003 R14: 0000000000000000 R15: 00000000000=
093f1
[  190.344950]  ? bpf_lsm_file_ioctl+0x10/0x10
[  190.344954]  ? bpf_lsm_file_ioctl+0x10/0x10
[  190.344955]  security_mmap_addr+0x2c/0x40
[  190.344959]  get_unmapped_area+0xc3/0x130
[  190.345163]  do_mmap+0x110/0x5c0
[  190.345165]  ? mlock_page_drain_local+0x3f/0x70
[  190.345167]  vm_mmap_pgoff+0xe3/0x180
[  190.345172]  do_syscall_64+0x65/0xd0
[  190.345175]  ? syscall_exit_to_user_mode+0x27/0x70
[  190.345177]  ? do_syscall_64+0x71/0xd0
[  190.345179]  ? syscall_exit_to_user_mode+0x27/0x70
[  190.345182]  ? do_syscall_64+0x71/0xd0
[  190.345183]  ? do_syscall_64+0x71/0xd0
[  190.345185]  ? syscall_exit_to_user_mode+0x27/0x70
[  190.345188]  ? do_syscall_64+0x71/0xd0
[  190.345189]  ? do_syscall_64+0x71/0xd0
[  190.345191]  entry_SYSCALL_64_after_hwframe+0x64/0xce
[  190.345193] RIP: 0033:0x7f860017c733
[  190.345195] Code: Unable to access opcode bytes at 0x7f860017c709.
[  190.345196] RSP: 002b:00007fff5284b438 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000009
[  190.345198] RAX: ffffffffffffffda RBX: 00007fff5284b460 RCX: 00007f86001=
7c733
[  190.345199] RDX: 0000000000000003 RSI: 0000000000001000 RDI: 00000000000=
00000
[  190.345200] RBP: 0000000000001000 R08: 0000000000000004 R09: 00000000093=
f1000
[  190.345201] R10: 0000000000008021 R11: 0000000000000246 R12: 00007fff528=
4b860
[  190.345202] R13: 00007fff5284b490 R14: 00007f85fefc8000 R15: fffffffffff=
ff000
[  190.345204]  </TASK>

I can mitigate this problem by adding "nopvspin" to the kernel cmdline.
I would like to learn why Linux (vanilla) is running fine, but Xenomai
is not.

The problem is triggered by the timer proxy tick which fires quite
often. My feeling is that we trigger a VirtualBox bug, but how to prove
that?

In addition I'm quite sure it's related to timing. The problem can not
be reproduced running on 5.10-dovetail, but quite easy with 6.1-
dovetail.

Best regards,
Florian


