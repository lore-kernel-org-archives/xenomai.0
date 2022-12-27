Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07AEB8
	for <xenomai@lists.linux.dev>; Tue, 27 Dec 2022 10:16:31 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221227093613828cc8b1e536a15645
        for <xenomai@lists.linux.dev>;
        Tue, 27 Dec 2022 10:36:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8TaEtuaBfI0Yzo6QgxGQXVTe4lq1L3UFKLvAVBef71Q=;
 b=OT4PdnGPNJNsDsFW7zq29kg1kvwd2ExuLUGzwh2UCf6hLwC8NAuE3ZE5zVBlvoQlwNxkIB
 BiiVa9j1IegFwFp4DaG4UJVRyQnCQbsxrwDXnZpa/+AhQwhbf8o9GhDJd5yazqrQoh2cUyeZ
 pQ/m17pqn3D0THGmHq5UEcaD2CPkI=;
Message-ID: <9da33db3ae41a25ec71926bbbd7f49dc5c19e8a6.camel@siemens.com>
Subject: Re: some kernel exceptions
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Yxian.Yao" <yxianyao@126.com>, xenomai@lists.linux.dev
Date: Tue, 27 Dec 2022 10:36:12 +0100
In-Reply-To: <44d3d245.e8a.1854d5dc672.Coremail.yxianyao@126.com>
References: <44d3d245.e8a.1854d5dc672.Coremail.yxianyao@126.com>
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

Hi,

On Mon, 2022-12-26 at 15:37 +0800, Yxian.Yao wrote:
>=20
> Hi=EF=BC=8C
>=20
> Install the debian11.0 operating system on the machine.=EF=BC=8Cthe syste=
m
> can start normally.
> But the system is abnormal after using this kernel,linux-5.4.133-
> ipipe-6-xenomai-3.1.1-20221216 (linux-5.4.133,=C2=A0ipipe-core-5.4.133-
> x86-6.patch,=C2=A0xenomai 3.1.1),=C2=A0
> See the attachment for output information during kernel startup, and
> the=C2=A0kernel=C2=A0outputs=C2=A0some=C2=A0exception=C2=A0messages,=C2=
=A0as=C2=A0follows.

Linux is failing while trying to initialize the IRQ controler (APIC) of
your application processors (APs) (=3D non boot CPUs). There seems to be
a mismatch regarding LAPIC IDs.

Such IDs are normally extracted from the APIC ACPI table. Something
seems to go wrong there (taken from your attachment):

[    0.214734] ACPI: x2apic entry ignored

There are a lot of such lines. This makes me wonder if your ACPI tables
are set up properly (which might be a BIOS/Firmware issue). That's
nothing Xenomai/ipipe specific. Does a standard Linux 5.4 boot on that
machine?

[    0.214840] smpboot: Boot CPU (id 255) not listed by BIOS

That points into the same direction. Your boot CPU has a APIC ID of
255, I would expect 0.

[    0.284534] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:1 n=
r_node_ids:1

nr_cpu_ids: 1 is strage. According to the line below we are on a NUMA
system (with one node) and I would expect a higher number of CPUs on
that system. So something is hiding your cores. (At least there is no
maxcpus=3D1 on your kernel cmdline).

NUMA configuration:
[    0.008196] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-=
0x207fffffff] -> [mem 0x00000000-0x207fffffff]

Hope that helps,
Florian

>=20
> Please=C2=A0give=C2=A0me=C2=A0some=C2=A0hints!
>=20
> Thanks=C2=A0a=C2=A0lot.
>=20
> [=C2=A0 =C2=A0 2.425873] ------------[ cut here ]------------
> [=C2=A0 =C2=A0 2.430270] kernel BUG at arch/x86/kernel/apic/apic.c:1659!
> [=C2=A0 =C2=A0 2.435593] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [=C2=A0 =C2=A0 2.440574] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.13=
3-ipipe-6-xenomai-3.1.1-20221216 #1
> [=C2=A0 =C2=A0 2.448851] Hardware name: HP HP Z8 Fury G5 Workstation/88C1=
, BIOS U61 Ver. 79.01.87 09/22/2022
> [=C2=A0 =C2=A0 2.457129] I-pipe domain: Linux
> [=C2=A0 =C2=A0 2.460211] RIP: 0010:setup_local_APIC+0x2df/0x310
> [=C2=A0 =C2=A0 2.464775] Code: 00 0b 05 b8 66 5b 01 0f 85 f7 fe ff ff 85 =
d2 7f 3f 48 8b 05 43 36 e4 00 be 00 07 01 00 bf 50 03 00 00 ff 50 10 e9 f6 =
fe ff ff <0f> 0b 48 8b 4c 24 40 65 48 2b 0c 25 28 00 00 00 75 0a be 00 04 0=
0
> [=C2=A0 =C2=A0 2.482628] RSP: 0000:ffffffff82003ea0 EFLAGS: 00010246
> [=C2=A0 =C2=A0 2.487606] RAX: 0000000000000000 RBX: 0000000000000000 RCX:=
 ffff889fffe00000
> [=C2=A0 =C2=A0 2.494401] RDX: 0000000000000000 RSI: 00000000fffffeff RDI:=
 0000000000000020
> [=C2=A0 =C2=A0 2.501196] RBP: ffffffff8253d2e0 R08: 0000000000000001 R09:=
 ffffffff820dbc20
> [=C2=A0 =C2=A0 2.507989] R10: 0000000000000008 R11: 0000000000000000 R12:=
 00000000000000d0
> [=C2=A0 =C2=A0 2.514786] R13: 0000000000000000 R14: 000000005565f000 R15:=
 000000005b0ca000
> [=C2=A0 =C2=A0 2.521582] FS:=C2=A0 0000000000000000(0000) GS:ffff889fffe0=
0000(0000) knlGS:0000000000000000
> [=C2=A0 =C2=A0 2.529285] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0 =C2=A0 2.534759] CR2: ffff88a07ffff000 CR3: 000000000400a001 CR4:=
 00000000000606b0
> [=C2=A0 =C2=A0 2.541553] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> [=C2=A0 =C2=A0 2.548348] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:=
 0000000000000400
> [=C2=A0 =C2=A0 2.555141] Call Trace:
> [=C2=A0 =C2=A0 2.557479]=C2=A0 ? __ipipe_do_IRQ+0x87/0xb0
> [=C2=A0 =C2=A0 2.561137]=C2=A0 ? __ipipe_do_sync_stage+0x12a/0x160
> [=C2=A0 =C2=A0 2.565537]=C2=A0 apic_intr_mode_init+0xb7/0xda
> [=C2=A0 =C2=A0 2.569441]=C2=A0 x86_late_time_init+0x12/0x17
> [=C2=A0 =C2=A0 2.573262]=C2=A0 start_kernel+0x42e/0x4e7
> [=C2=A0 =C2=A0 2.576757]=C2=A0 secondary_startup_64+0xa4/0xb0
> [=C2=A0 =C2=A0 2.580744] Modules linked in:
> [=C2=A0 =C2=A0 2.583659] ---[ end trace bd3da5ac6eb39a7b ]---
> [=C2=A0 =C2=A0 2.588058] RIP: 0010:setup_local_APIC+0x2df/0x310
> [=C2=A0 =C2=A0 2.592622] Code: 00 0b 05 b8 66 5b 01 0f 85 f7 fe ff ff 85 =
d2 7f 3f 48 8b 05 43 36 e4 00 be 00 07 01 00 bf 50 03 00 00 ff 50 10 e9 f6 =
fe ff ff <0f> 0b 48 8b 4c 24 40 65 48 2b 0c 25 28 00 00 00 75 0a be 00 04 0=
0
> [=C2=A0 =C2=A0 2.610482] RSP: 0000:ffffffff82003ea0 EFLAGS: 00010246
> [=C2=A0 =C2=A0 2.615460] RAX: 0000000000000000 RBX: 0000000000000000 RCX:=
 ffff889fffe00000
> [=C2=A0 =C2=A0 2.622252] RDX: 0000000000000000 RSI: 00000000fffffeff RDI:=
 0000000000000020
> [=C2=A0 =C2=A0 2.629048] RBP: ffffffff8253d2e0 R08: 0000000000000001 R09:=
 ffffffff820dbc20
> [=C2=A0 =C2=A0 2.635841] R10: 0000000000000008 R11: 0000000000000000 R12:=
 00000000000000d0
> [=C2=A0 =C2=A0 2.642637] R13: 0000000000000000 R14: 000000005565f000 R15:=
 000000005b0ca000
> [=C2=A0 =C2=A0 2.649430] FS:=C2=A0 0000000000000000(0000) GS:ffff889fffe0=
0000(0000) knlGS:0000000000000000
> [=C2=A0 =C2=A0 2.657135] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0 =C2=A0 2.662608] CR2: ffff88a07ffff000 CR3: 000000000400a001 CR4:=
 00000000000606b0
> [=C2=A0 =C2=A0 2.669403] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> [=C2=A0 =C2=A0 2.676198] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:=
 0000000000000400
> [=C2=A0 =C2=A0 2.682993] Kernel panic - not syncing: Attempted to kill th=
e idle task!
> [=C2=A0 =C2=A0 2.689396] Rebooting in 1 seconds..
> [=C2=A0 =C2=A0 3.648759] ACPI MEMORY or I/O RESET_REG.

