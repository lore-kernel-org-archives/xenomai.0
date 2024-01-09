Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BA328D0
	for <xenomai@lists.linux.dev>; Tue,  9 Jan 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j68l1W0z"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 6CFCB80002
	for <xenomai@lists.linux.dev>; Tue,  9 Jan 2024 09:33:29 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::600])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6C766AC1261
	for <xenomai@xenomai.org>; Tue,  9 Jan 2024 09:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge7xvy7Z0XpXMeWfE7vm3ne1H/nDYRC9WILEtI/li7HhBHd9GJSSSgnZEiVUs2wyj2A+igjZJ48KslnkP8vczN3G4FvKKDIKLRvGyx9xY//QYiq6khbcA3OQgi4AGTqlR50ko4o9aHZCrdZVGmGSTLkn0wTX7ky8ojpIE9QNyT+fcxLZqRPpPEe7bZHPx5b4DB8Xp/ftlxwcdeChRoFAQDszedHzX6tLAlFaThf9HXs664anaWZ2YtBs2HAsvyL5+PaGV3fU78g3N2RXxgz5DHqrtFNkpYUmf1wk0n3iPnSmZQ09RAe9cvSzFOkYC1Iyr38u2yYq4IICrBM9K7B4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSp8CHDIxMT1VjNeFO4tzefvEE0pG7CuZgiQ+CjS5ro=;
 b=AVQSWWfNVhAhE2ogs1krfp+qx7LsyhI8++zl46td81zT94mYWpzvXArM08ZyVWy/MIemFvszGHqMzc9TgDqOcTwjaKiYA4CDlXC0Q5MLmcwdx7cg3y5gn/qlnR16+xiKaDX0ALpxo4YU3AV+lHGjk6JAm1uNrVdG8WsOjFuDiwjawNSQkfc7ZKn3mUWuGIbFbmLsebAi+VX7ljEa5hU3OHVGlhAZS92JZ1UdBn1DTdSfSmopTyVZ3mFKrTtrkPg6vizRv+VLYzXBnnG2FBMnaYKv+Wk36+aS4S+b8Yx6gILJT40IyVGrYTr4Rsgi/yAe+iKz5WtJlzx4/oAlC1XUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSp8CHDIxMT1VjNeFO4tzefvEE0pG7CuZgiQ+CjS5ro=;
 b=j68l1W0zmx4kZHBYPHNaCsQdI6jwgGbDU04lDCANu+fc3QLlCH4b6OZimycncBV/QJtSo9r23OTwj+CEBb0a1fveXmIqTmaDJ5/srIYUz1sPqZs7ikX4mjohhYsf1K4vaiaT8qk+Lb8o0V8Ntz/r5GzfHzbZaysX0awlRJs97SBL6xMML5xjZ+8LdDDAs/EyY4FWqj612hy65Qd0gszf48M+xkkSaJwOsJA/u43FrT8XZvEYppShl7A7xG+YSEBrvHuLiHNqC9zBtOIpcpINOM3oHD5KJlM1poV5eLRIw2rDX7wCMd0gS+QZvyfh649v9CjWiwMfeyCcNI5A43eIeg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:33:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:33:26 +0000
Message-ID: <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
Date: Tue, 9 Jan 2024 10:33:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
Content-Language: en-US
To: linz <powertree@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: b56a8ae8-e64d-4bc4-82b8-08dc10f60839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UtPBUCH0FT3s0pskvCDqhn3t7fUP5O07ZuVhfSd9r85/BqUoRz3I8FlO2FjLBkENBsyAfxzM+lX4sG1Q7ONSPNAib1mcLBbqXgzbGvgZAADW+/8o/B6SLvmN1b1/S7Q7V+KHX8sTg9Dau9gEw/kk2Q68486l+CjHJ4Z6zDI1eDK0fRhFNCbR4kw9iH3fsMm4qOMCd10DlyftKE/08FB1j6nK7eKBQgg6rYYrJ3wiEsEeiP5P3N03CCaNTbK61ZYzjZh5qjMtpmb2jombDj0POSgrxp4LA87pPlApIutgd7EnW0ThtxP/G/9bjWHwioCBNNtQS5/eE7AcPs1OZ8/0P0BlpIZSMRIfFr1ExAOa5ldBkPP20hgZKjNIGTDxpU7GNd28ppBE3WVHmn59erGBPhOOzkeDyekKKLKEC54Vm7qVbWaRRrC/IPX5GGdv76hS/ZimkZQ8h8P8gpktcjcm0BHHtqoS7e5qWCUKJFvIXVzuLfPSVmuaojbL1vZKIurBOz0xNmw3zzr+zjbN2NIeW48vAyzNtoeU9ijvrF0jTjLU/a66Mn5zuQi1v9n9dsl5/eRcyU1W1qg+0TBbCUnYkjGONpbKaf0cZRjswPBmGhmD5lUBJE1N1Rb+haboWRvq4mZ0waxI8jI8Y+Zwg6jj0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(478600001)(66476007)(316002)(53546011)(66946007)(110136005)(66556008)(6486002)(8936002)(8676002)(2616005)(6512007)(83380400001)(26005)(2906002)(5660300002)(44832011)(41300700001)(36756003)(38100700002)(82960400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFF1MGZDaHcwb0k3a1E0Tm52SHNjelI1ZVFwV2NWQm9mdjBrYkY0OU9LNXpV?=
 =?utf-8?B?YjFpTE9seTcrOFpRNjBCT3RDUlc5UHpFR0lxMDRFTHlBNnF5WHFjQUVtL0VN?=
 =?utf-8?B?cWVSMkM0UnhzMHozcHQ0NWlNNlVGNkJhNkFkbU92anY2SXVPS2tSNDJLZCta?=
 =?utf-8?B?eElxYWxrNWFiNkh0d3hrdUdKRHBjRnZTQncrNnQrZ3kyOFlIakpIZ21BVXE4?=
 =?utf-8?B?VmE1T2V6eWt5bk00RFhya1N6cXk2RVNQckEwTG85ME5Mb2tTMnNGNHoveEVT?=
 =?utf-8?B?bTJJTng2OXBCZUczZXNuSWlHZllKc0lmYitWYVFtUUdvTGw2Q0dtQUNHanYy?=
 =?utf-8?B?V3NoODNrOE1xLzZHT1puNWZYdXVVSjIydHFkVUMwSjREeWYrZjArMkEwMDZS?=
 =?utf-8?B?V216Q0JGUjFQS05sMm5WQi9mMnJVcU50Tk55SXVuTmhSZ09YWGZCdmFPaUp2?=
 =?utf-8?B?NnJGd3NNajVOM1BYT0FJSXA2NEJnMlgxandUcVJRajFYRTNqWXVCNVp5S0ox?=
 =?utf-8?B?bjZ1YTlxME9aRW1sL1NGeHU1RFBsb1dXcnEvYmJtL01ua2ttek5UTmsxSjVF?=
 =?utf-8?B?RmwyekN3Y1ZmWVh0RWRxdDBnT0xqQXlxYXJaVUsxc1huM2txVE44WjFBUnNZ?=
 =?utf-8?B?K3dja0xuUVVSNnNQeW1uNzlPcVdyMlV2NTFGamg2KzdIWk04ZmhXZ0VaM3Va?=
 =?utf-8?B?aStPS0RXNFhxTEVBTnY3Y2RKTEk4VFkxemY0K3ZiVE5YMXBqNVlVc1hFVGhq?=
 =?utf-8?B?cnZGY216SEIwQ3RhbXlULzM5cXdpeWp1VzRKQXdHSlBzOTVkVEdqUEJFdjNG?=
 =?utf-8?B?OGluODNZWXE5WWhTbDVSczNyU2xMWmFwUjRybi9NeEYyZHZPVTJ6R2V2T3dw?=
 =?utf-8?B?YzY1YXB0aTdKVUR0dDZ3OS9Hc1RPUWw2UmdPT2NSdHczZGViTWtFK21jNzky?=
 =?utf-8?B?UU01T1B1aHU0Q2dtc2k0OCtjWmVRS2pKWlcvdFBkUmtLSmRJMnBNeitJRGM0?=
 =?utf-8?B?YUdsbmNYTURBU3NHTkNZeDBKUExlRHEwMHgreUF1UisyZS93cllRcHlVRisw?=
 =?utf-8?B?djB6bGU4MVlLODUrUjNTUnBQbXd5Rk96REtvRGdnT0V2dWlNWDNWeDFxRW9I?=
 =?utf-8?B?NUx4dzFzSzdhRWJIVVJUTmZqV3BTSmtXWVgxbUhLaVp1Wm55K3pRcktRRU5Y?=
 =?utf-8?B?TitidGJKNW1DYWdFZHhuTjdMc2VzalFOLy82UWYvWFpNcUpNV2Fkc1MyenRW?=
 =?utf-8?B?OUFSN2hpbmFXUGFrTzZDbVQwMGtRVlVqWjh4ZGNKNi9WU1FIUFpUTTFrckND?=
 =?utf-8?B?Wjk2MDZIaGdGRytBRlZyT21FTmxPVEVUNVh6ODFjaEVPb2xadzVKZWZaaXpH?=
 =?utf-8?B?bWxoM2tPb21nQnpjY1ZBc1dQd3ljTHEzMXlaL1lvYUllb2JweDZWWWlINC82?=
 =?utf-8?B?bjRTZEVyRy9WMDRoZ2RrRytGSnVCQi9nMmlxZUhNWlN5SG9IMjQyN0M3cTJJ?=
 =?utf-8?B?YnE5Z1cydWUyZkxieWUxNi8vdjF3cHNDSnJRR2FraCtmUG8rWEVvNGd0VndD?=
 =?utf-8?B?NFk3akNZdUVyVTVsdzFOSG1yd0lKWkVGVG1RekxQZ3hWVzVwUjR5ZVdJTmNu?=
 =?utf-8?B?U3dhandqRFo4M0s2bjU5V0NZYjZ3eTNjUzAvZHlWRUhCMUhBL3c5K1pjWTZu?=
 =?utf-8?B?cE1Qd1pPZHVZU1BsUElmQk0zeWZYSnBQU1NWTVgvUFhSdFVycytIRjZuamZR?=
 =?utf-8?B?RURsVG1DQkpWYWNaOVpjOUxrU3Y0YnY3K2s2NUdPQUJhenU3RnhVbndNQWxm?=
 =?utf-8?B?d2hhaDRiYzhuR3AyN1p2SmI5QS9RZXFkU2dFR2hiRUxLZmZ4eHNVNXZLYzAv?=
 =?utf-8?B?OHVsM2dCZS9sUGhyZnpEQklLMjdZZlZmTkJ5MXNkS3U3SllFMFpGM2lZUnll?=
 =?utf-8?B?U2tUZ0MybHNQaitQR3hYcDQwQ1BjNnQ4ZkZEZkg1Vk1LTXpZaFJ5bWFGZCsy?=
 =?utf-8?B?TlFEVFU2UGNaa2xhWGlNNWZZay9FTkFERUpGYk5yRUlIclpKeEpEMWRhVjFU?=
 =?utf-8?B?Z1VZZFFFbDNtWFJkcWZ0a1p4bWFXeVVQNkRJeDlYSjZkSy9paWR5MzBEWFlS?=
 =?utf-8?B?U3ArZjM4M2tzTzY0bThrTU1ZcmdXUldUSUkyaGw5ZjdJdThtNnhGQUh1dWY5?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56a8ae8-e64d-4bc4-82b8-08dc10f60839
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:33:26.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9IK/NTvpP39IrohUxwQj6C4EddR/7hMH9f2GlOegxJdyKZhqQSVFVsQsQS/bbkp/m0WnTSzGJRDlAjg6NWH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5156
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=j68l1W0z;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe0c::600 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 09.01.24 10:16, linz wrote:
> Hi, I find a call tracing when I use xenomai v3.2.2 branch and test
> latency testsuit, the Call trace is as follows
> 
> [  777.563100] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000002c0
> [  777.563101] Mem abort info:
> [  777.563102]   ESR = 0x96000004
> [  777.563103]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  777.563104]   SET = 0, FnV = 0
> [  777.563104]   EA = 0, S1PTW = 0
> [  777.563105] Data abort info:
> [  777.563105]   ISV = 0, ISS = 0x00000004
> [  777.563106]   CM = 0, WnR = 0
> [  777.563107] user pgtable: 4k pages, 48-bit VAs, pgdp=000000200c513000
> [  777.563108] [00000000000002c0] pgd=0000000000000000,
> p4d=0000000000000000
> [  777.563110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  777.563118] CPU: 3 PID: 149 Comm: kworker/u16:2 Not tainted
> 5.10.153-dovetail3 #2

Could you check if the issue persists with latest v6.6-dovetail1-rebase?
Just to avoid that we are missing some fix backports in 5.10.

> [  777.563119] IRQ stage: Xenomai
> [  777.563120] Workqueue: efi_rts_wq efi_call_rts
> [  777.563121] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
> [  777.563121] pc : xnthread_relax+0x78/0x1d4
> [  777.563122] lr : xnthread_relax+0x78/0x1d4
> [  777.563122] sp : ffff80001001bbf0
> [  777.563123] x29: ffff80001001bbf0 x28: ffff001f809daa00
> [  777.563124] x27: ffff001f803426c8 x26: ffff80001001c000
> [  777.563126] x25: ffff800010018000 x24: ffff0020f6f93008
> [  777.563127] x23: 0000000080000085 x22: 0000000000000003
> [  777.563129] x21: ffff001f809daa00 x20: 0000000000000001
> [  777.563130] x19: 0000000000000000 x18: 0000000000000000
> [  777.563132] x17: 0000015a8ca44dbc x16: 0000000000000013
> [  777.563133] x15: ffff800010f892a8 x14: 0000000000000002
> [  777.563135] x13: 0000000000000043 x12: 0000000000000040
> [  777.563136] x11: ffff001f804dab58 x10: ffff001f804dab5a
> [  777.563137] x9 : 00000000000003c0 x8 : 0000000000000000
> [  777.563139] x7 : 0000000000000000 x6 : 0000000000000001
> [  777.563140] x5 : ffff0020f6f8ece0 x4 : 0000000000000000
> [  777.563142] x3 : ffff0020f6f8eae0 x2 : ffff8020e5a57000
> [  777.563143] x1 : 0000000000000003 x0 : 0000000000000002
> [  777.563144] Call trace:
> [  777.563145]  xnthread_relax+0x78/0x1d4
> [  777.563146]  handle_oob_trap_entry+0x78/0x1b0
> [  777.563146]  __oob_trap_notify+0x40/0x70
> [  777.563147]  do_debug_exception+0x170/0x1c4
> [  777.563147]  el1_dbg+0x34/0x50
> [  777.563148]  el1_sync_handler+0x9c/0xd0
> [  777.563148]  el1_sync+0x88/0x140
> [  777.563149]  __get_cpu_fpsimd_context+0x2c/0x40
> [  777.563150]  __switch_to+0x20/0x120
> [  777.563150]  dovetail_context_switch+0x6c/0x130
> [  777.563151]  pipeline_switch_to+0x10/0x20
> [  777.563151]  ___xnsched_run+0x174/0x25c
> [  777.563152]  run_oob_call+0x88/0x174
> [  777.563153]  handle_irq_pipelined_finish+0x1d8/0x1ec
> [  777.563153]  handle_irq_pipelined+0x38/0x50
> [  777.563154]  handle_arch_irq_pipelined+0x10/0x20
> [  777.563155]  el1_irq+0xdc/0x1c0
> [  777.563155]  0x203626c4
> [  777.563156]  0x20361190
> [  777.563156]  0x203615b4
> [  777.563156]  0x20361660
> [  777.563157]  0x20361da0
> [  777.563157]  0x203609ec
> [  777.563158]  __efi_rt_asm_wrapper+0x28/0x4c
> [  777.563159]  efi_call_rts+0x204/0x3d0
> [  777.563159]  process_one_work+0x1cc/0x350
> [  777.563160]  worker_thread+0x138/0x46c
> [  777.563160]  kthread+0x154/0x160
> [  777.563161]  ret_from_fork+0x10/0x3c
> [  777.563162] Code: 97ff4dae f000a180 91236000 97ffdde7 (f9416260)
> [  777.563162] ---[ end trace 5ef18d81e2ade362 ]---
> [  777.563163] note: kworker/u16:2[149] exited with preempt_count 33554434
> 
> 
> The reason is when kernel_neon_begin is called, it calls
> __get_cpu_fpsimd_context. Then xenomai oob interrupt triggers function
> named __switch_to, which calls  __get_cpu_fpsimd_context again.
> Calling this function twice in a row will trigger a call trace.
> The function call relationship is as follows:
> 
> efi_call_rts
>   =>__efi_fpsimd_begin
>     =>kernel_neon_begin
>       =>get_cpu_fpsimd_context
>         =>hard_preempt_disable  // disable interrupt
>         =>__get_cpu_fpsimd_context    // *first call*
>       =>hard_cond_local_irq_restore  // enable interrupt
> 
>       handle_arch_irq_pipelined // Latency timer interrupt triggered
>         =>handle_irq_pipelined_finish
>           =>irq_exit_pipeline
>             =>xnsched_run
>               =>__xnsched_run
>                 =>pipeline_schedule
>                   =>run_oob_call
>                     =>___xnsched_run
>                       =>pipeline_switch_to
>                         =>dovetail_context_switch
>                           =>__switch_to
>                             =>fpsimd_thread_switch
>                               =>__get_cpu_fpsimd_context //*second call*
> 
> 
> The fixed up patch is as follows:
> 
> From f0cb2b2f3174789eb8348feff6abdc7dbdafc8c4 Mon Sep 17 00:00:00 2001
> From: zhanglin <powertree@163.com>
> Date: Tue, 9 Jan 2024 17:08:20 +0800
> Subject: [PATCH] arm64/fpsimd: fix bug for calling __get_cpu_fpsimd_context
>  twice in a row when kernel_neon_begin running
> 
> ---
>  arch/arm64/kernel/fpsimd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 01a4774a2..bc180d0cf 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -44,6 +44,10 @@
>  #include <asm/traps.h>
>  #include <asm/virt.h>
> 
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +#include <cobalt/kernel/sched.h>
> +#endif
> +
>  #define FPEXC_IOF    (1 << 0)
>  #define FPEXC_DZF    (1 << 1)
>  #define FPEXC_OFF    (1 << 2)
> @@ -1367,6 +1371,7 @@ void kernel_neon_begin(void)
> 
>      BUG_ON(!may_use_simd());
> 
> +    xnsched_lock();

This would be a laying violation: dovetail has no knowledge of Xenomai,
and it also serves EVL with a different API. But we will find a fitting
locking construct here quickly once we understood the issue completely
(or I - need to spend some calm cycles later).

>      get_cpu_fpsimd_context(flags);
> 
>      /* Save unsaved fpsimd state, if any: */
> @@ -1397,6 +1402,7 @@ void kernel_neon_end(void)
>          return;
> 
>      put_cpu_fpsimd_context(flags);
> +    xnsched_unlock();
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center

