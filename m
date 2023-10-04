Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B567101E2
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 08:45:34 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id ACD135D73
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com ACD135D73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1696409126; bh=H/QvGk+OG8nddZRDXXa/o4ZPlTJpst0FkAdrunxWIi8=;
	h=Date:From:To:From;
	b=tp29XWcxQIHe49loCrXWKoQ39DzCN51GUmKuvLlMZdZTh+OHhWl3hRv12qDydl9d4
	 A/MB8i5naRExqt6/mKGXmPKGutbAruR90RtVbPpsuhqoGKHRrPq+VqLyXBppR7LAwJ
	 zaPWo6WdI66hQs+T+HtODpKg/b/HW1JB7pXVOotA=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id A882630004E
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 9C19F100673
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 8008D1006B3
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 8008D1006B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1696409126;
	bh=oaFxu1K68Wz+TWHOf08NhkrM0EdmZ+//22frRAmDujM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FHVvcoydapmPm0z9uSTLD3zkDNFtoP3QDe8wr5XgFvzuNKY5FRwPo0BVW7GB9v7Jh
	 CSBNGCtGWGBSxXb1NH1W3cxU/QfHuf8DcVXFhf2xDbHffmkdoRZIqU7xmEnMsxY09Q
	 o5yir+5+/dBgpra6keTu8Vg8vVsIGdoQ3ZMMts6XfZBHX0eZwSLF0zEj5DwdYaxA4C
	 KmqkHVy9hiNS19a32T+EvCVbGkFoLHy/uKseLFY//2K3DyMCzd9cC+8sf+BWudULbv
	 M31sWEnAiUb0BK4wtIVW3rhVjdAI+3E8xRprmIhV/AD/doUriPhcHstcP9oOaTGjsP
	 CLqNfsmaYiHfw==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j_oNpEhO9Uw2 for <xenomai@lists.linux.dev>;
	Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 68258100673
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 03:45:26 -0500 (CDT)
Date: Wed, 4 Oct 2023 03:45:26 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com>
Subject: RTNet unable to handle kernel NULL pointer dereference at
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
Thread-Index: z7oMtg5zsWyig8hWMyvUH5wEmXMAlg==
Thread-Topic: RTNet unable to handle kernel NULL pointer dereference at 0000000000000068

Hi list
I experienced a crash  with Xenomai-3.1 on Linux 4.19.114-cip24

It does not seem to be the end of the world though because things were not =
immediately broken for me and I can't reproduce it.

Any thoughts ?

[  129.326872] RTnet: registered rteth1
[  129.326874] rt_igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Conne=
ction
[  129.326875] rt_igb 0000:02:00.0: rteth1: (PCIe:2.5Gb/s:Width x1) 00:1b:2=
1:e0:b6:31
[  129.327002] rt_igb 0000:02:00.0: rteth1: PBA No: G69016-005
[  129.327003] rt_igb 0000:02:00.0: Using MSI-X interrupts. 1 rx queue(s), =
1 tx queue(s)
[  321.182356] rt_igb: rteth1: igb: rteth1 NIC Link is Up 1000 Mbps Full Du=
plex, Flow Control: RX
[  361.783381] [Xenomai] switching rtnet-rtpc to secondary mode after excep=
tion #14 in kernel-space at 0xffffffffc03855a0 (pid 1445)
[  361.783386] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000068
[  361.783415] PGD 0 P4D 0=20
[  361.783428] Oops: 0000 [#1] PREEMPT SMP PTI
[  361.784109] CPU: 2 PID: 1445 Comm: rtnet-rtpc Tainted: G        W  O    =
  4.19.114-cip24-xeno-cobolt #1
[  361.784809] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[  361.785504] I-pipe domain: Linux
[  361.786214] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]
[  361.786911] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 cf =
38 c0 e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48=
> 8b 57 68 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
[  361.787708] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
[  361.788516] RAX: 000000000000587e RBX: 0000000000000000 RCX: 00000000000=
00000
[  361.789333] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 00000000000=
00000
[  361.790153] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 00000000000=
00002
[  361.790980] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e617=
e8110
[  361.791812] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e617=
e8000
[  361.792646] FS:  0000000000000000(0000) GS:ffff891e65b00000(0000) knlGS:=
0000000000000000
[  361.793490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  361.794334] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000003=
606e0
[  361.795182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  361.796026] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  361.796869] Call Trace:
[  361.797721]  rt_tcp_segment.constprop.21+0x1ca/0x510 [rttcp]
[  361.798557]  rt_tcp_send+0x3e/0xd0 [rttcp]
[  361.799411]  ? rtdm_event_timedwait+0x181/0x320
[  361.800271]  rtpc_dispatch_handler+0xd4/0x1f0 [rtnet]
[  361.801137]  ? xnthread_map+0x370/0x370
[  361.802002]  kthread_trampoline+0x77/0x133
[  361.802868]  kthread+0x10e/0x130
[  361.803716]  ? kthread_create_worker_on_cpu+0x70/0x70
[  361.804591]  ret_from_fork+0x36/0x50
[  361.805464] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb rt=
net x86_pkg_temp_thermal e1000e pcan(O)
[  361.806378] CR2: 0000000000000068
[  361.807284] ---[ end trace a94628c3ed940012 ]---
[  361.808201] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]
[  361.809144] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 cf =
38 c0 e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48=
> 8b 57 68 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
[  361.810147] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
[  361.811161] RAX: 000000000000587e RBX: 0000000000000000 RCX: 00000000000=
00000
[  361.812184] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 00000000000=
00000
[  361.813207] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 00000000000=
00002
[  361.814222] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e617=
e8110
[  361.815248] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e617=
e8000
[  361.816246] FS:  0000000000000000(0000) GS:ffff891e65b00000(0000) knlGS:=
0000000000000000
[  361.817247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  361.818213] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000003=
606e0
[  361.819152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  361.820047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400


Regards
Per =C3=96berg=20
