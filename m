Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636010966
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 13:01:58 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id ABFFD5B9A
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com ABFFD5B9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1696424514; bh=pHTLOHgJid+VZwiNBPAoVNsomlD8vhoAYkuRga16tds=;
	h=Date:From:To:In-Reply-To:References:From;
	b=O7FO4MaTzz6VBMYvXD/g47YtVg/ZwcsZHwJHowKGPvqZqrKUNc/D4fxFhSClkRsJJ
	 Vos37Y1iz6QhXAIdUDHUgDSjObOoVTC2inA3+HnocgYw/Akm2QFQF301hq5/iywIcW
	 o/7w1K8QZVvhPpaLm2lCHCjXX7d3T6+FGj7equHE=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id A6A4330004E
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id A3A491006B7
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 8A4DD1006C4
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 8A4DD1006C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1696424514;
	bh=wmoQT4lHzHSpP5B+pEAVIk867rBiTCcPJgrBKlSCu6s=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=PAYP1/PR+I1cZEqz0nafyz0f8mbqlyZkJ6Wie7cadF1Yi2nM0gXu2hvLS01rgIxUz
	 K7vVrq0dq5rMvdoZ0fJyM/CdMSRI3Js3jTNPJe/FQca575KMjP92rC4eVfSpBlz11V
	 MM4tkoJXv6XPMiQfQbpP72bA2X9XutxFelXlDQ0LJgKkMy6QelvwUrMRbiXJV6S7hx
	 wYXnaiNGHw36drftdm6jwJ/VzJB1kCQGRqzsM12Pmf7VRnLqzhNV1fANmBYCKW3SKr
	 ahCVjxMOkaveWu+aFzMnL0cA1Rl7Zr6fANQkOYdWxgzebJT8u4EHOBQf0v1r9/4z4i
	 cKrgUp5fmg89g==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g6LBdkWNdUVp for <xenomai@lists.linux.dev>;
	Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 6E3E41006B7
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:01:54 -0500 (CDT)
Date: Wed, 4 Oct 2023 08:01:54 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com>
In-Reply-To: <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com>
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com> <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com>
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.156.136]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC117 (Linux)/9.0.0_GA_4478)
Thread-Topic: RTNet unable to handle kernel NULL pointer dereference at 0000000000000068
Thread-Index: RaXe/6OtkYESaS8IPtdUZOU3hWHrkA==


----- Den 4 okt 2023, p=C3=A5 kl 11:42, Jan Kiszka jan.kiszka@siemens.com s=
krev:

> On 04.10.23 10:45, Per Oberg wrote:
> > Hi list
> > I experienced a crash with Xenomai-3.1 on Linux 4.19.114-cip24

>> It does not seem to be the end of the world though because things were n=
ot
> > immediately broken for me and I can't reproduce it.

> > Any thoughts ?

> > [ 129.326872] RTnet: registered rteth1
> > [ 129.326874] rt_igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Co=
nnection
>> [ 129.326875] rt_igb 0000:02:00.0: rteth1: (PCIe:2.5Gb/s:Width x1)
> > 00:1b:21:e0:b6:31
> > [ 129.327002] rt_igb 0000:02:00.0: rteth1: PBA No: G69016-005
>> [ 129.327003] rt_igb 0000:02:00.0: Using MSI-X interrupts. 1 rx queue(s)=
, 1 tx
> > queue(s)
>> [ 321.182356] rt_igb: rteth1: igb: rteth1 NIC Link is Up 1000 Mbps Full =
Duplex,
> > Flow Control: RX
>> [ 361.783381] [Xenomai] switching rtnet-rtpc to secondary mode after exc=
eption
> > #14 in kernel-space at 0xffffffffc03855a0 (pid 1445)
>> [ 361.783386] BUG: unable to handle kernel NULL pointer dereference at
> > 0000000000000068
> > [ 361.783415] PGD 0 P4D 0
> > [ 361.783428] Oops: 0000 [#1] PREEMPT SMP PTI
>> [ 361.784109] CPU: 2 PID: 1445 Comm: rtnet-rtpc Tainted: G W O
> > 4.19.114-cip24-xeno-cobolt #1
>> [ 361.784809] Hardware name: Default string Default string/SKYBAY, BIOS =
5.11
> > 09/22/2016
> > [ 361.785504] I-pipe domain: Linux
> > [ 361.786214] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]

> Most likely ((struct dest_route *)rt)->rtdev was NULL. But I have no
> idea why that should have been the case.

> One commit - though not obviously related - that is missing from 3.1.x
> is
> https://source.denx.de/Xenomai/xenomai/-/commit/ac17dcebda74edb253922b849=
9eeb71bcd0c70ed.
> Are you facing larger frames?

> Keep an eye on it if see it again and can reproduce it more reliably.

> Jan

>> [ 361.786911] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 c=
f 38 c0
>> e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 8=
b 57 68
> > 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
> > [ 361.787708] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
> > [ 361.788516] RAX: 000000000000587e RBX: 0000000000000000 RCX: 00000000=
00000000
> > [ 361.789333] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 00000000=
00000000
> > [ 361.790153] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 00000000=
00000002
> > [ 361.790980] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e=
617e8110
> > [ 361.791812] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e=
617e8000
>> [ 361.792646] FS: 0000000000000000(0000) GS:ffff891e65b00000(0000)
> > knlGS:0000000000000000
> > [ 361.793490] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 361.794334] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000=
003606e0
> > [ 361.795182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> > [ 361.796026] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> > [ 361.796869] Call Trace:
> > [ 361.797721] rt_tcp_segment.constprop.21+0x1ca/0x510 [rttcp]
> > [ 361.798557] rt_tcp_send+0x3e/0xd0 [rttcp]
> > [ 361.799411] ? rtdm_event_timedwait+0x181/0x320
> > [ 361.800271] rtpc_dispatch_handler+0xd4/0x1f0 [rtnet]
> > [ 361.801137] ? xnthread_map+0x370/0x370
> > [ 361.802002] kthread_trampoline+0x77/0x133
> > [ 361.802868] kthread+0x10e/0x130
> > [ 361.803716] ? kthread_create_worker_on_cpu+0x70/0x70
> > [ 361.804591] ret_from_fork+0x36/0x50
>> [ 361.805464] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb =
rtnet
> > x86_pkg_temp_thermal e1000e pcan(O)
> > [ 361.806378] CR2: 0000000000000068
> > [ 361.807284] ---[ end trace a94628c3ed940012 ]---
> > [ 361.808201] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]
>> [ 361.809144] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 c=
f 38 c0
>> e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 8=
b 57 68
> > 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
> > [ 361.810147] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
> > [ 361.811161] RAX: 000000000000587e RBX: 0000000000000000 RCX: 00000000=
00000000
> > [ 361.812184] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 00000000=
00000000
> > [ 361.813207] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 00000000=
00000002
> > [ 361.814222] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e=
617e8110
> > [ 361.815248] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e=
617e8000
>> [ 361.816246] FS: 0000000000000000(0000) GS:ffff891e65b00000(0000)
> > knlGS:0000000000000000
> > [ 361.817247] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 361.818213] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000=
003606e0
> > [ 361.819152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> > [ 361.820047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400


> > Regards
> > Per =C3=96berg


> --
> Siemens AG, Technology
> Linux Expert Center


Thanks, the TCP part is a simple handshake and should not need any large me=
ssages afaik.

I just had another hickup. This is 100 pct reproducible

To get it up and running I had to remove rtpacket,rttcp,rtudp,rtipv4 and th=
en forcibly remove rt_igb driver and then rtnet. This gave me another set o=
f errors, also listed below.=20

[15018.436248] ------------[ cut here ]------------
[15018.436249] [Xenomai] switching rtnet-stack to secondary mode after exce=
ption #6 in kernel-space at 0xffffffffb837064b (pid 1438)
[15018.436258] WARNING: CPU: 0 PID: 1438 at /usr/src/kernel/kernel/xenomai/=
rtdm/fd.c:299 __put_fd+0x26b/0x2c0
[15018.436259] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb x8=
6_pkg_temp_thermal rtnet e1000e pcan(O)
[15018.436265] CPU: 0 PID: 1438 Comm: rtnet-stack Tainted: G        W  O   =
   4.19.114-cip24-xeno-cobolt #1
[15018.436266] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[15018.436267] I-pipe domain: Linux
[15018.436268] RIP: 0010:__put_fd+0x26b/0x2c0
[15018.436270] Code: 83 e0 01 49 39 c4 74 08 4c 89 e7 e8 8f 98 f9 ff 48 8d =
7d b0 e8 36 99 f9 ff e9 81 fe ff ff 48 c7 c7 f0 53 3b b9 e8 1e 4b f3 ff <0f=
> 0b 41 8b 5d 18 e9 ca fd ff ff 48 8b 05 eb d0 2d 01 49 c7 45 30
[15018.436270] RSP: 0018:ffffbb998017bdc0 EFLAGS: 00010282
[15018.436272] RAX: 0000000000000028 RBX: 0000000000000000 RCX: 00000000000=
00001
[15018.436276] RDX: 0000000000000000 RSI: 0000000000001140 RDI: ffffffffb9d=
7b500
[15018.436277] RBP: ffffbb998017be20 R08: 0000000000000045 R09: 00000000000=
2e7c0
[15018.436278] R10: ffffbb998017be38 R11: 0000000000000000 R12: 00000000000=
00000
[15018.436279] R13: ffffa290e1e95800 R14: 0000000000000000 R15: ffffffffc01=
081e0
[15018.436280] FS:  0000000000000000(0000) GS:ffffa290e5a00000(0000) knlGS:=
0000000000000000
[15018.436281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15018.436282] CR2: 00007ffd7412c080 CR3: 0000000039c0a001 CR4: 00000000003=
606f0
[15018.436283] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[15018.436284] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[15018.436284] Call Trace:
[15018.436289]  ? rt_tcp_retransmit_ack+0x205/0x260 [rttcp]
[15018.436291]  ? rtdm_fd_unlock+0x9b/0xd0
[15018.436292]  rtdm_fd_unlock+0x9b/0xd0
[15018.436295]  rt_ip_rcv+0x129/0x180 [rtipv4]
[15018.436298]  rt_stack_deliver+0x22c/0x3a0 [rtnet]
[15018.436300]  ? xnthread_map+0x370/0x370
[15018.436302]  rt_stack_mgr_task+0x66/0xa0 [rtnet]
[15018.436303]  kthread_trampoline+0x77/0x133
[15018.436306]  kthread+0x10e/0x130
[15018.436308]  ? kthread_create_worker_on_cpu+0x70/0x70
[15018.436310]  ret_from_fork+0x36/0x50
[15018.436313] ---[ end trace 1c6e468cf3ee6a54 ]---
[15018.436339] ------------[ cut here ]------------
[15018.436340] WARNING: CPU: 0 PID: 1438 at /usr/src/kernel/kernel/xenomai/=
rtdm/fd.c:299 __put_fd+0x26b/0x2c0
[15018.436341] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb x8=
6_pkg_temp_thermal rtnet e1000e pcan(O)
[15018.436343] CPU: 0 PID: 1438 Comm: rtnet-stack Tainted: G        W  O   =
   4.19.114-cip24-xeno-cobolt #1
[15018.436344] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[15018.436344] I-pipe domain: Linux
[15018.436345] RIP: 0010:__put_fd+0x26b/0x2c0
[15018.436346] Code: 83 e0 01 49 39 c4 74 08 4c 89 e7 e8 8f 98 f9 ff 48 8d =
7d b0 e8 36 99 f9 ff e9 81 fe ff ff 48 c7 c7 f0 53 3b b9 e8 1e 4b f3 ff <0f=
> 0b 41 8b 5d 18 e9 ca fd ff ff 48 8b 05 eb d0 2d 01 49 c7 45 30
[15018.436346] RSP: 0018:ffffbb998017bdc0 EFLAGS: 00010282
[15018.436347] RAX: 0000000000000028 RBX: 0000000000000000 RCX: 00000000000=
00001
[15018.436348] RDX: 0000000000000000 RSI: 0000000000001140 RDI: ffffffffb9d=
7f400
[15018.436348] RBP: ffffbb998017be20 R08: 0000000000000045 R09: 00000000000=
2e7c0
[15018.436349] R10: ffffbb998017be38 R11: 0000000000000000 R12: 00000000000=
00000
[15018.436350] R13: ffffa290e1e95800 R14: 0000000000000000 R15: ffffffffc01=
081e0
[15018.436350] FS:  0000000000000000(0000) GS:ffffa290e5a00000(0000) knlGS:=
0000000000000000
[15018.436351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15018.436352] CR2: 00007ffd7412c080 CR3: 0000000039c0a001 CR4: 00000000003=
606f0
[15018.436352] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[15018.436353] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[15018.436353] Call Trace:
[15018.436354]  ? rtdm_fd_lock+0xd5/0x1c0
[15018.436355]  ? rtdm_fd_unlock+0x9b/0xd0
[15018.436355]  rtdm_fd_unlock+0x9b/0xd0
[15018.436356]  rt_ip_rcv+0x129/0x180 [rtipv4]
[15018.436356]  rt_stack_deliver+0x22c/0x3a0 [rtnet]
[15018.436357]  ? xnthread_map+0x370/0x370
[15018.436357]  rt_stack_mgr_task+0x66/0xa0 [rtnet]
[15018.436358]  kthread_trampoline+0x77/0x133
[15018.436359]  kthread+0x10e/0x130
[15018.436359]  ? kthread_create_worker_on_cpu+0x70/0x70
[15018.436360]  ret_from_fork+0x36/0x50
[15018.436360] ---[ end trace 1c6e468cf3ee6a55 ]---
[15018.436361] ------------[ cut here ]------------
[15018.436382] WARNING: CPU: 0 PID: 1438 at /usr/src/kernel/kernel/xenomai/=
rtdm/drvlib.c:884 rtdm_event_timedwait+0x50/0x320
[15018.436383] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb x8=
6_pkg_temp_thermal rtnet e1000e pcan(O)
[15018.436385] CPU: 0 PID: 1438 Comm: rtnet-stack Tainted: G        W  O   =
   4.19.114-cip24-xeno-cobolt #1
[15018.436386] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[15018.436387] I-pipe domain: Linux
[15018.436387] RIP: 0010:rtdm_event_timedwait+0x50/0x320
[15018.436388] Code: c0 48 85 f6 78 46 48 c7 c2 40 01 03 00 48 89 d0 65 48 =
03 05 da 17 ca 47 f6 40 09 40 74 19 48 c7 c7 f0 53 3b b9 e8 f9 77 f3 ff <0f=
> 0b 41 bc ff ff ff ff e9 24 01 00 00 65 48 03 15 b3 17 ca 47 48
[15018.436389] RSP: 0018:ffffbb998017be80 EFLAGS: 00010282
[15018.436390] RAX: 0000000000000024 RBX: ffffffffc011ce00 RCX: 00000000000=
00000
[15018.436390] RDX: 0000000000000000 RSI: ffffffffb93ce5b9 RDI: 00000000fff=
fffff
[15018.436391] RBP: ffffffffc011b300 R08: ffffa290e5a00000 R09: 00000000000=
006c7
[15018.436391] R10: ffffbb998017be38 R11: 0000000000000000 R12: ffffbb99802=
7ba90
[15018.436392] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffc01=
1b300
[15018.436393] FS:  0000000000000000(0000) GS:ffffa290e5a00000(0000) knlGS:=
0000000000000000
[15018.436393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15018.436394] CR2: 00007ffd7412c080 CR3: 0000000039c0a001 CR4: 00000000003=
606f0
[15018.436395] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[15018.436395] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[15018.436396] Call Trace:
[15018.436396]  ? rt_stack_deliver+0x28b/0x3a0 [rtnet]
[15018.436397]  ? xnthread_map+0x370/0x370
[15018.436397]  rt_stack_mgr_task+0x27/0xa0 [rtnet]
[15018.436398]  kthread_trampoline+0x77/0x133
[15018.436399]  kthread+0x10e/0x130
[15018.436399]  ? kthread_create_worker_on_cpu+0x70/0x70
[15018.436400]  ret_from_fork+0x36/0x50
[15018.436401] ---[ end trace 1c6e468cf3ee6a56 ]---
[15058.612235] RTnet: dropping packet in rtnetif_rx()
[15059.612209] RTnet: dropping packet in rtnetif_rx()
[15060.612166] RTnet: dropping packet in rtnetif_rx()
[15083.961342] RTnet: dropping packet in rtnetif_rx()
[15198.507222] RTnet: dropping packet in rtnetif_rx()
[15254.669404] RTnet: dropping packet in rtnetif_rx()
[15310.553224] RTnet: dropping packet in rtnetif_rx()

At module unload=20

[16042.887516] Disabling lock debugging due to kernel taint
[16047.781092] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[16047.781093] BUG rtskb_slab_pool (Tainted: G  R     W  O     ): Objects r=
emaining in rtskb_slab_pool on __kmem_cache_shutdo                         =
   wn()
[16047.781094] ------------------------------------------------------------=
-----------------
[16047.781094]
[16047.781095] INFO: Slab 0x0000000059a810bf objects=3D17 used=3D14 fp=3D0x=
00000000b5f0e913 flags=3D0x9300000008100
[16047.781097] CPU: 2 PID: 2085 Comm: rmmod Tainted: G  R B   W  O      4.1=
9.114-cip24-xeno-cobolt #1
[16047.781098] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[16047.781099] I-pipe domain: Linux
[16047.781100] Call Trace:
[16047.781105]  dump_stack+0x98/0xb3
[16047.781108]  slab_err+0xa8/0xd0
[16047.781111]  ? on_each_cpu_mask+0x47/0x90
[16047.781113]  ? on_each_cpu_cond+0x90/0xd0
[16047.781115]  __kmem_cache_shutdown+0x1c1/0x3d0
[16047.781118]  kmem_cache_destroy+0x40/0xf0
[16047.781121]  cleanup_module+0x31/0x7fa [rtnet]
[16047.781123]  __x64_sys_delete_module+0x155/0x220
[16047.781125]  ? __do_page_fault+0x2a4/0x570
[16047.781127]  do_syscall_64+0x64/0x170
[16047.781129]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[16047.781131] RIP: 0033:0x30792ecf59
[16047.781132] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8                         =
    4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f ff 2b 00 =
f7 d8 64 89 01 48
[16047.781133] RSP: 002b:00007ffcb579a968 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000b0
[16047.781134] RAX: ffffffffffffffda RBX: 00007f195face6c0 RCX: 00000030792=
ecf59
[16047.781135] RDX: 0000000000000000 RSI: 0000000000000880 RDI: 00007ffcb57=
9a980
[16047.781136] RBP: 00007ffcb579ac18 R08: 0000000000000000 R09: 00000000000=
00880
[16047.781137] R10: 000000000000005f R11: 0000000000000246 R12: 00007ffcb57=
9ac08
[16047.781138] R13: 00007ffcb579ac00 R14: 0000000000000000 R15: 00000000000=
00000
[16047.781140] INFO: Object 0x00000000fdde1d6b @offset=3D0
[16047.781141] INFO: Object 0x000000008c150ec2 @offset=3D1856
[16047.781142] INFO: Object 0x00000000c18de762 @offset=3D3712
[16047.781142] INFO: Object 0x00000000d1da0c03 @offset=3D5568
[16047.781143] INFO: Object 0x00000000c214b504 @offset=3D7424
[16047.781144] INFO: Object 0x0000000079c960b5 @offset=3D9280
[16047.781145] INFO: Object 0x000000008c56ca31 @offset=3D11136
[16047.781145] INFO: Object 0x0000000097ec8f45 @offset=3D12992
[16047.781146] INFO: Object 0x0000000015430fa3 @offset=3D14848
[16047.781147] INFO: Object 0x00000000b6afa3d5 @offset=3D16704
[16047.781147] INFO: Object 0x00000000600412d5 @offset=3D18560
[16047.781148] INFO: Object 0x0000000097312ec2 @offset=3D20416
[16047.781149] INFO: Object 0x000000009169b1f8 @offset=3D22272
[16047.781149] INFO: Object 0x000000000bfd769e @offset=3D24128
[16047.781152] kmem_cache_destroy rtskb_slab_pool: Slab cache still has obj=
ects
[16047.781153] CPU: 2 PID: 2085 Comm: rmmod Tainted: G  R B   W  O      4.1=
9.114-cip24-xeno-cobolt #1
[16047.781154] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[16047.781155] I-pipe domain: Linux
[16047.781155] Call Trace:
[16047.781157]  dump_stack+0x98/0xb3
[16047.781159]  kmem_cache_destroy+0xe3/0xf0
[16047.781161]  cleanup_module+0x31/0x7fa [rtnet]
[16047.781163]  __x64_sys_delete_module+0x155/0x220
[16047.781164]  ? __do_page_fault+0x2a4/0x570
[16047.781166]  do_syscall_64+0x64/0x170
[16047.781168]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[16047.781169] RIP: 0033:0x30792ecf59
[16047.781170] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8                         =
    4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f ff 2b 00 =
f7 d8 64 89 01 48
[16047.781171] RSP: 002b:00007ffcb579a968 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000b0
[16047.781172] RAX: ffffffffffffffda RBX: 00007f195face6c0 RCX: 00000030792=
ecf59
[16047.781173] RDX: 0000000000000000 RSI: 0000000000000880 RDI: 00007ffcb57=
9a980
[16047.781174] RBP: 00007ffcb579ac18 R08: 0000000000000000 R09: 00000000000=
00880
[16047.781174] R10: 000000000000005f R11: 0000000000000246 R12: 00007ffcb57=
9ac08
[16047.781175] R13: 00007ffcb579ac00 R14: 0000000000000000 R15: 00000000000=
00000
[16047.781193] RTnet: unloaded


Thanks
Per =C3=96berg=20
