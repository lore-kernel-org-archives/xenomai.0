Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907B10A28
	for <xenomai@lists.linux.dev>; Wed,  4 Oct 2023 09:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC4lHMcx67h3s385zDhlLouyluLcTrOGkouNWipqouxASR3J6RJrgL3fgdsRZIpeVmx0/0VlrWLUYvsCt70/BvpohttoXJiD7OELC/Lzm5GanmLez0pwJbZX9oiRaQf4ggWVlFYLTUbbN68xXM1XYdqcnyIs7uR4tumB85kKOQ2YH6Gp3Gmct4ORx0jyjNNSHW2g+BWgrtw4TLNIc7EazEed523V/fr7PQmXHZbHQNmxOmdccgdVunl594EVC4Ac6z1tHEf6Mc/apmMGTvGR+aUOM/xaO4KK6XX8rz2pyWDV7LhWdkM2zqBYvHCjfWTeaVQsIuUOB1RIw/600gukKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlP7z+ZEhs+2kjn6d/4LtTiSRfWztKwhAkP1PA20qFA=;
 b=jitg7ICKTw7HFBtiesjKKrfq3+WAlgtJlty1oUmfer5EZaYUar7M31rPP5UWcBTISPY53mqjFHT04mmAr80qCv0HNsuEvsrHQ4pmOHKGguvmGtSKhDDY52SBWwHj9uXXajeTaDq3iRrI4rYtLoonBK5zT48Rvh8LBY+hAAO8eEbe62yWpYmERIOtE3DdrJ2lAkrSt5O7bPeirrugnwa1QvE2cgBaudvtll4fy+5qfzK7LnVZiUt+MzKOkt/YgGkFxvl7ZAnaBnpR3isajucjD+TYgEr/c1WTQwSpeILzSRojUrA/gXBHUmIl246pJ40TP/ryfXCYs2LfuuAJ19A67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlP7z+ZEhs+2kjn6d/4LtTiSRfWztKwhAkP1PA20qFA=;
 b=Aauq7gHTKQvlBw301Y1gHPC9CUzz3Y31qGFd4ksgTZpHfMu7103sveWkx8hfYTv0eIA43eYmi7kyGayK+c1Av8IrvGxbd2voCR6P1i5dFo1ltDga/cfk2yMAhKN/YK3fDrv82svGNBAi6FuWVKVqrK46DOYzc4X35XucQS4k7Zw7pvlqEM4XWxlQGk7jjb8+LMg9c31PqJWpy9vRdWQfHtewB2BUYzShXNcf+bg/Ox+Is7Hsn0wn4cs0QiYOqXE1fi9RFph4d9Z7aS7eW+ijKkFox2zWetmy0s4KjK2K+IEo7EwNaImgWcLBAXo5tzDvw7DOUVNxMny183/o0AiV+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:42:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 09:42:06 +0000
Message-ID: <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com>
Date: Wed, 4 Oct 2023 11:42:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a57d40e-dd1c-4b35-df1a-08dbc4be2bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e8e51ytpT+97/KB0lXMaZ7I324OgO68+cN3TAo90PlDQ0AnpQw2I13zhNZq/ElLIfmicPpOy3Bsc3+UvX30mDQQqYWk/hjKqW9Sz5wZ2R9IJKVPyrJjdmhgHAGYKt71AbrkYPyPDui6mjFrjBPjP/XTS+yO9g6W6SkGaxeDS+QHGjJXLckoeoyMUsWMWFapY+5IXOZdd0iG2DJZakXegIRRZZl5VOkYFWHfP8lMsY0JncI9aMkZ20lic+g6Lv1xNqJ1+qfun15pc0zNyPyhUtnQskjWKxi1zBlJrh0LIVsrSROp4stKZZFppUcgdw/hcYDzKXGkqjCGl3XXEcx/dZG4dPzjtO2OpFzX3w63yfwGuBdX3s206rPLSlPdDkIPpZVxX9bWFzVjV40D5oKsKjzHzPB/ErLLF7P6GycBEAjpl4SE7mke5oToUQgRLFv2LASY4fHZotD4qFHttnel7aAKGFffDC8mSv+Ztzoi8lTR31nIoIcQr7IBzgnLtyErVPbGL6FG5wY+ZHknFfep2mAXnA/3VLRDC1DbAiFRc4hwxzEQ8hYhBEVqDn2YbMtel83xFAOsCiUn9a+NsbDVnewx7iBrl443nDCDXvft0+UIXImxLOebER3dJpn29CAji89FCkAQynM1nF04vrE4HDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(966005)(45080400002)(6506007)(6666004)(6512007)(6486002)(478600001)(53546011)(38100700002)(86362001)(31696002)(82960400001)(2906002)(316002)(83380400001)(26005)(2616005)(5660300002)(66476007)(36756003)(66556008)(44832011)(66946007)(41300700001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGpQYXlHTDFxZHUycTBERlZPZG9MRmpBbTJ4QldFT1JzVVF2Q0tOc3JFL3N5?=
 =?utf-8?B?TXlIRjVWTW5tY2Y2WTVQa3Y4Y2wwdmZwZ0hkUjUwREk1d1hzejJmdGJnUXhh?=
 =?utf-8?B?QlFHS0FZaU9WLzhsS1FCYTFJR1RhSGtyUklzMjltMXdlL1p4MWxDTXZUc3Ux?=
 =?utf-8?B?NzdPSUdMOUx4cUpDUERkOWxweHZNQkJRbWcxL1IwMVVsaHBiNEFUN3ZhMHV1?=
 =?utf-8?B?UUFYbzBndEpSMWh1ZUdKcHIvMER1bEsvS2RBK3AwTnBqTzhpaURVbTFjcWpv?=
 =?utf-8?B?dFRxUXA4L1FmQ0ttdTl5WUpEVzJFTjBoRitHaWt3bnppbEljZjFxVWYrT2NX?=
 =?utf-8?B?TFFrUW14U1V1dmVQMUYxRWhGMGlHWWpTN1Z6czVmMkxJK29ybXV3eThtb0VY?=
 =?utf-8?B?emJ1QzBNRlhlZjV2N3JMTkcvRHNRVDROMHpZTldRSW1nZFo4SUVZK3g0NWE0?=
 =?utf-8?B?YTlLRlA2RFAvTDhtNGhGQitSYkk4bjVtMFFtTkpybTZ3M1dtWksxeHdSVTd3?=
 =?utf-8?B?ZkQwRmVEdzQwZVVCSmVqZjFiOVg1NmhKTlRYSVJsRXkreXlDTEpPTG9KN2Jh?=
 =?utf-8?B?QzhQQlc2eGIybkNtbEVpSFlyT3hnZUxlRGwyTG95dW9MTHZ2ZGRacUFZck4y?=
 =?utf-8?B?SjhhWU8xUE9icnQxYjNuckRSYk9ZUzM5YlZUcWlNRkU0Rm05d2crSjIrTGw3?=
 =?utf-8?B?OGpsS05kY213KzhRNEVLZWlIZm1LNFVYc0taSHZJMGFvb3VYektBanFVVlRU?=
 =?utf-8?B?dk0rZ0xNYXZsb1JhMEYyWmFzRmdGQVU5cU9PV2dNdkxEWDVDR1Fxd3d3all2?=
 =?utf-8?B?N3ZWV1dlVU0rY0wyMDFUWkhhQUczQ3FyZG0yRkF3bFVvZUxyV1dXcFZLZFVl?=
 =?utf-8?B?WFVIUGFHTEFHVmZwYmplZnZsSDBLVWF2MkgvNlJ0Y0pxajlSOU9PeEhCV2VI?=
 =?utf-8?B?bWQ4SXVoditFSjJwbVphYnM2Ri9mTUg5allxNndETjA5N2N1ZFAyU0k2NURq?=
 =?utf-8?B?b3ZzTytjVTJ0bGlydmRmZXdURmNacjNFM0sxVDdwMkFlNUhLRVpnbVMxRkt4?=
 =?utf-8?B?dzZXN0lGMzZnMkNwM2xaOUFWUVZSSWNmK1VCcnI1UVlZWnFBRGNnSXdQS3kx?=
 =?utf-8?B?UWZwQitKbWdBZytPSVJsWUZSYjZ4Nm9LSWcwVFp2TWt4M2tsbFNIalFvR3pX?=
 =?utf-8?B?NHdlanV5YVNpM3FBeGdEcjhjeU1wUGUyb2xjU3Qra0JNUnRVQnpQb0lueTdC?=
 =?utf-8?B?MzJ3aWcyYm5iUHBQbXJtOFh1QXB1UDlBK1JOT0pmNmYvSk9xL25BVEpVTUww?=
 =?utf-8?B?ZEpVNWRJcG04S2RPZmxLNnl6Q2NScGpZcXphc3l2dlRPTW01eERCTVFsbUxx?=
 =?utf-8?B?WDRNQmRNeGFBUnRRYk9zU0VCR1VwN2pSbDR2TlpRUTY5c2tuSitpNzAzL3Jy?=
 =?utf-8?B?NU50Rk03dG5ySXJWRnN5ZGx4MmIweVM3MVpqbmU1ak5HRGlVU1EyQUd0WWhs?=
 =?utf-8?B?WnNDQ0JGTi8yNW1WWFZOR0R4TXdTeFlYQjF5OXlweHNDaTZmeUtLNEllVXZQ?=
 =?utf-8?B?cUJHaC8wNzg3WTRSbzdXUFZydHpDWVZCWjZkdm9SZitTcHBkUTYrRVZZRHZP?=
 =?utf-8?B?SG52MEVreFFKMTZZd2pLN2FxS0ZVYm1VQ3huVWVwcU1zRXM3Unk3NFF4c3NH?=
 =?utf-8?B?VDFiOTZibWZXV25EcXJ6cTdOc0Rra3I5Tk1Ca3k1MTRhdU14SXFqR0U0U3VL?=
 =?utf-8?B?OSt5ZEVTMlRpbXN4VG5xTnNYY1J2MjNVOTN6MWhYODdFbFJPRzJiczlhdnRt?=
 =?utf-8?B?S3BqNmhITmREdHR5ay8vM25IRkhJL2lhcWlxeWszdnZOT3Zwamd3YkV2ZjRS?=
 =?utf-8?B?ZHRMbFlGREJhSmNsZVgrUDZuYkJ3UjgxdFFkVDJOaFZ5OXp2bmtlMU9mWGtO?=
 =?utf-8?B?MEpjOVJHN2RONHdjcENzYlk1ckFSRjg3NXU1amZTcjZaeGg5Wm1ybjJqa0Yw?=
 =?utf-8?B?VU1RTVlkaHpRYnQzdEFVL2RkYjVzS0UyWHlDRVltS3BaUHNVL1RhTGFwbjUw?=
 =?utf-8?B?a3lXTHVucFFqWEFGcThUdmFFVjhhWTdmK205R1dkQ1Q4RTliMVNxV0tNNVNC?=
 =?utf-8?B?NHovMHdoa3dzQmx3UmdjeVU3dXFsMDJ0NkNaMXUzUkpjSFVmV2g2SHZob04r?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a57d40e-dd1c-4b35-df1a-08dbc4be2bc7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:42:06.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwNqB5MPFOKPR/xO78h76NSoj7DgGL2BxzNvaa42s/mrLDa1k9qUQv2E6BK0jaHYC2WaJ/hat/h+jQn/XA++wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3489

On 04.10.23 10:45, Per Oberg wrote:
> Hi list
> I experienced a crash  with Xenomai-3.1 on Linux 4.19.114-cip24
> 
> It does not seem to be the end of the world though because things were not immediately broken for me and I can't reproduce it.
> 
> Any thoughts ?
> 
> [  129.326872] RTnet: registered rteth1
> [  129.326874] rt_igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> [  129.326875] rt_igb 0000:02:00.0: rteth1: (PCIe:2.5Gb/s:Width x1) 00:1b:21:e0:b6:31
> [  129.327002] rt_igb 0000:02:00.0: rteth1: PBA No: G69016-005
> [  129.327003] rt_igb 0000:02:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s)
> [  321.182356] rt_igb: rteth1: igb: rteth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> [  361.783381] [Xenomai] switching rtnet-rtpc to secondary mode after exception #14 in kernel-space at 0xffffffffc03855a0 (pid 1445)
> [  361.783386] BUG: unable to handle kernel NULL pointer dereference at 0000000000000068
> [  361.783415] PGD 0 P4D 0 
> [  361.783428] Oops: 0000 [#1] PREEMPT SMP PTI
> [  361.784109] CPU: 2 PID: 1445 Comm: rtnet-rtpc Tainted: G        W  O      4.19.114-cip24-xeno-cobolt #1
> [  361.784809] Hardware name: Default string Default string/SKYBAY, BIOS 5.11 09/22/2016
> [  361.785504] I-pipe domain: Linux
> [  361.786214] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]

Most likely ((struct dest_route *)rt)->rtdev was NULL. But I have no
idea why that should have been the case.

One commit - though not obviously related - that is missing from 3.1.x
is
https://source.denx.de/Xenomai/xenomai/-/commit/ac17dcebda74edb253922b8499eeb71bcd0c70ed.
Are you facing larger frames?

Keep an eye on it if see it again and can reproduce it more reliably.

Jan

> [  361.786911] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 cf 38 c0 e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 8b 57 68 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
> [  361.787708] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
> [  361.788516] RAX: 000000000000587e RBX: 0000000000000000 RCX: 0000000000000000
> [  361.789333] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 0000000000000000
> [  361.790153] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 0000000000000002
> [  361.790980] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e617e8110
> [  361.791812] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e617e8000
> [  361.792646] FS:  0000000000000000(0000) GS:ffff891e65b00000(0000) knlGS:0000000000000000
> [  361.793490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  361.794334] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000003606e0
> [  361.795182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  361.796026] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  361.796869] Call Trace:
> [  361.797721]  rt_tcp_segment.constprop.21+0x1ca/0x510 [rttcp]
> [  361.798557]  rt_tcp_send+0x3e/0xd0 [rttcp]
> [  361.799411]  ? rtdm_event_timedwait+0x181/0x320
> [  361.800271]  rtpc_dispatch_handler+0xd4/0x1f0 [rtnet]
> [  361.801137]  ? xnthread_map+0x370/0x370
> [  361.802002]  kthread_trampoline+0x77/0x133
> [  361.802868]  kthread+0x10e/0x130
> [  361.803716]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  361.804591]  ret_from_fork+0x36/0x50
> [  361.805464] Modules linked in: rttcp rtpacket rtudp rtipv4 igb rt_igb rtnet x86_pkg_temp_thermal e1000e pcan(O)
> [  361.806378] CR2: 0000000000000068
> [  361.807284] ---[ end trace a94628c3ed940012 ]---
> [  361.808201] RIP: 0010:rtdev_reference+0x0/0x70 [rtnet]
> [  361.809144] Code: 00 eb e0 48 89 ef e8 ff 25 00 00 89 de 48 c7 c7 19 cf 38 c0 e8 da fb 91 c1 eb c8 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 8b 57 68 48 85 d2 74 52 53 8b 47 5c 85 c0 74 19 8d 50 01 48 8d
> [  361.810147] RSP: 0018:ffff947dc01a7df0 EFLAGS: 00010206
> [  361.811161] RAX: 000000000000587e RBX: 0000000000000000 RCX: 0000000000000000
> [  361.812184] RDX: 0000000083ca0000 RSI: 0000000000001a00 RDI: 0000000000000000
> [  361.813207] RBP: ffff891e64a4c058 R08: ffff891e617e8138 R09: 0000000000000002
> [  361.814222] R10: 0000000000000000 R11: 00000000000005dc R12: ffff891e617e8110
> [  361.815248] R13: 0000000000025540 R14: ffff891e64a4c278 R15: ffff891e617e8000
> [  361.816246] FS:  0000000000000000(0000) GS:ffff891e65b00000(0000) knlGS:0000000000000000
> [  361.817247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  361.818213] CR2: 0000000000000068 CR3: 0000000051c0a005 CR4: 00000000003606e0
> [  361.819152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  361.820047] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> Regards
> Per Öberg 
> 

-- 
Siemens AG, Technology
Linux Expert Center

