Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002841229
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 15:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAjUhOIydIHQs9s55bIoRtBblvltru/c9AC8PiMza2q4zW17Xj6/ditBcVqpvfz9N9gK2FcFDIh6QkM2ZBo4fKKmdVrjW+zHwzd/YrBMseJ0jadvkIMycrYrcIGjHcHE0MUkdgnmEYQe6VZdQ1WskYbaVj0qgIJLEIY6wgqp3fVKkst0d5TVmO5gqaisJnI8GmvqvtBZmKR4FF6sOqtbGtTs/Cs2pQ+DObWs9kyBNtsosyTUNGhFtkwi1446HTEk1UjaD2WgwVb0PRalCYbQEtNUiqd1u7e4bWop2ec/mFmra8tts7ilEAt7Y8q8khTKKS/yrygwgk/0sVCKkfSDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx0mK6qbMR+JQ7vipA263J/k/my/HdImc/NxIaxMvOc=;
 b=mwc95Zk6+dxmrs2RJk4gkv6LLR7Tz8BXDrRx7jnLhpgLPTFgaH2KrSN1gdP+TsFs9G61ZyHDDX5iyf/TI2uRlZgl7PCtTQyanKV4P/ebvYjvU3fccdiF7YPmspjtQ78ltj0PFUMV87T+dBDbYVt4nPmfL1uWFdB3mUdDroSXWJ4m8g1LephskQW29Ah5XHtyZjH5+ranKFURD+irI2Y9EAFJ/e1PgXE5Anu0s0O5rB2UdZqpw7hvBNyLS7nhSdDlPAARc5sv5nHk1te3jOi4fvDHOg/1RcV6InfK8+MHmF7isfyiyrrt+cBbMq/ByFKu83io2rcsA8O/PYYVK4/z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx0mK6qbMR+JQ7vipA263J/k/my/HdImc/NxIaxMvOc=;
 b=Mo/j1SrLiZOsJoNCh8F+SVbD9OsS5hzsA0nYu4PvLQOtjsTLy0qETDqTUquDHyDZKhM31Qjnq59vy7bGMVzZns0JUYu69u+/E7UQKsaxxv5V+6Z2KN9THhRWE4dooI4fb+e5sUoOdM6BznqvIZ6WSKxKhr+tZlsB8BZKue2B4Y6UyV+o0zENupPnTaDKbq8DqXaC4WGaEWYsq0Ynqa2OThEk7H0asHqp1hZyuFUyL1u9xfqKgi7xgTgmnmiAcp7CM01yXGyhKFIdnWxXSmSHS6DI1ZeRxoqXXEcmcIi0VC2N7Br2VMKs9ErnwADW0tarlCGw8gkHk49ZIeJ08EAv8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:47:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:47:44 +0000
Message-ID: <716965dd-095a-4c1e-b5e6-7ff62f99babd@siemens.com>
Date: Fri, 22 Sep 2023 17:47:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rtnet: icmp.c: fix rt_icmp_dest_socket triggering a
 NULL pointer violation
Content-Language: en-US
To: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: "xenomai @ lists . linux . dev" <xenomai@lists.linux.dev>
References: <20230922090112.344174-1-martin.elshuber@chello.at>
 <20230922090112.344174-2-martin.elshuber@chello.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230922090112.344174-2-martin.elshuber@chello.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:610:38::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: bd335b28-a655-4305-4c8a-08dbbb834313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HlDPexYjXx/efZq2nwYV5pYjKG7rwSA6pUp5IudtH7dPqFVioAfEuBpXq7dEWa5WdzGLk0OTPHr+Rv/0BxYNgyuWmMGe7iB1Zh+RAq194IjqfIzKXEl97glweoDQZmp5HlCAX34F31sJ0Tc2PRzWDH8UkiF9TOreAIMdWXSK/DxD3RD80U4i41Nc0xKom/2wukO6iMffL73OgUtHDjAtbTrAlydYj+oYqbNfxZVbsDD244DMh05I0VL+TFeW9RW8fTbGvmFXp6NlBFYKcbaL/6PPtHB/zlTqFlAmDvG7Fa1XURONpCbJ11t6NohyGPfh061Z43kxOw8Pyk3Byj/b1gSz9wTjvzybLPwh6t3QuDV+JKOPJXqsAuHJ6/gFZDONjyLCwfe+nSbj1ssAziZjuBuMuUtqki6dPvPY788SGlBajd8at4SXTHoGdSlzqi2Ld2kV7I/CMgYjAtipyjaZJPVAiiWNSTcFntNDwEYlDowGxj+rQWNH5pN/UQPHUHC9GkhroZsz397QosvnMiV/0yZmcOIhk9gvCcOd3eJWVs+mG71FKf8ka8U3R63Xqqwz2IfOVdsxFV7b5nNwPdDVex1l1J0f6nXeeOJYTvWzMJNHUT++qSgD/b3BZ8WaFORbcYEkpzikDnnI05lGLbGHoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(83380400001)(2906002)(45080400002)(478600001)(6506007)(26005)(6512007)(6486002)(36756003)(6666004)(82960400001)(38100700002)(86362001)(53546011)(2616005)(31696002)(6916009)(5660300002)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(44832011)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRDUHBtMWdEc0l4WUJVN2FaMytxR09CRTNJZGRKQzEzRDIxd2hoRkpmeUwv?=
 =?utf-8?B?OEVVVGU4S3NsNEl4QVVMNzlHczRxZ3YxekJ6K1Q3L3lUYzhvNWY1MDFXaVNi?=
 =?utf-8?B?OEwxUXBQZzdNVE1YNlZXb3htemY1b3d4Ui9UMDR6U2lXYmZZeVRweXpsTStX?=
 =?utf-8?B?bWhIT0VlbkZHV0ZmKzlGZlpqWE5RaVdISmdRaHEzaE5DZzB0eFNPdVdvMWtt?=
 =?utf-8?B?YXhZdHp6bitGWkVhd0tsQW9zMjdvOS9PK0pycEg5Mm5Gd3FpOGJRSS9UdXN0?=
 =?utf-8?B?SzVaTlRiOG5hQncvU3FweG9WNmNJZjlaVjVJU0tRY1dhTHJ4WnZOdDFWRS94?=
 =?utf-8?B?MVJTOEo3SzhBTE5hYmE2cHVYOGJSdVNzdWtiV1pnOXlMSllMV3dKTVlDQ3Ji?=
 =?utf-8?B?cUNxSVlhQ0p0U0ExcGZXdEhoZWE3b1MxTjdPbVBLY3pPV20yRXdVZjRkUXYy?=
 =?utf-8?B?UTYrNHRabDk3QTZtdjdNdlZpVFZqVnFCdkxBUW14T2hhUHNkWXRvdUZVSzNU?=
 =?utf-8?B?U2Jmc25iMFM2dlZNbEdjaXVKbWF6WU5ObjRKR1JjQjhPYjRZckxMTzgvb2Vx?=
 =?utf-8?B?WGd3a0cvdzhKT2R0eHVoSXkvcnZLL0xPQWk3OXZpZGp1V2RqZjk0RzZCY3N6?=
 =?utf-8?B?Zk11TFp6UEsvUWcxeHlhK1pZSWRYOU1kWW9iTkVlWVdVQmcvV2UrTk94V1gr?=
 =?utf-8?B?WTFlUWpTVm1pQ0Y1citoMWxWSGc3a1UySmpHMGZYakVBUkF0RWNjcjBGMVZX?=
 =?utf-8?B?NVc5dlgrVXNBY2JqVXVmb2gwbzZaOWtnNzdhN0xzSk8wUGVKalNlK2JNK0Q0?=
 =?utf-8?B?VzRqUzU1Z002TVZBcSt6Q0tnMVMwaGFtRUUvNzRsS1kyYnIzYm5zQUtYZXZl?=
 =?utf-8?B?MTZwVDFpUUxyNy9KdVVNNTVKbjJKTDkxa2lVdEc3K0hiSzhYYzRJTUVUY3hO?=
 =?utf-8?B?S2I5SHRqSm1HdGdIbkxmTjNNRkdiK2FQL0NSU2VZTytLMllCbmJYM3h2SDFB?=
 =?utf-8?B?U1hINXVEQ2JKVG8zS1hVWTlqb3lSeW9BemI3N3ZNUnlNMmtaREtDTlVRSFNY?=
 =?utf-8?B?VTVnRy9oaTVsaHdEcG5pN0hTS1RwYm1XOVdmWHNxMUtNMWRTUk8rYWpRMkJF?=
 =?utf-8?B?dHVmYnFjOE9GUlFpTS9TSzgwT3NyMEZkR2kyRmR1RTFDQjBzVno1VmY0VFdE?=
 =?utf-8?B?RVgydVNpMVB4V2JxT3VXM2NkbkNacHlTQndYa1BkajFINFhxcnAxSUhzY2Fk?=
 =?utf-8?B?SHVwc3BNb3duZHE0L1hVdk43YnRYd2xlZjF2SVhJSHh3YVBYRUhzby9GVyt2?=
 =?utf-8?B?ZmQrZTFVU2RHWmRGSWN6MC90SURLWUp6K1FBU2VYNTdIS1hMMHpEdWVLc2xr?=
 =?utf-8?B?WmJ4UEE5NGFERlc1MnpsYXhJUk1iOEhHZDFqQWIrUEprL04va2xqN3BMaUdB?=
 =?utf-8?B?aHdEREkxVUZscUhMbEI2TnFHeVhiNmprWm5UY3l1RDJESWQyRzJvQUR5anlt?=
 =?utf-8?B?V29hRGsrNzl2L3JYQU1YMzNzWHdoVlN0ME1iTzJuUmFsVVZjdTJCcThCV0g5?=
 =?utf-8?B?Z3VnTXI1cFUvaHFyM1MzeFdoV3ZTN2o2d1ZMV05jaEN2M1VkOE5NL28zZUNM?=
 =?utf-8?B?T0hBYVZOM0JDcGlScVZVNzFXOHgxV3lHcktKRk9KaGxoamZmcHRrOStnSW5t?=
 =?utf-8?B?VEs4dHR0QjdMcFFKSFhIeGhpMThTZFJxOTBmS0xicXVIcEJJbmR6NmhDQjJQ?=
 =?utf-8?B?cnZIWktkSTlkMngydTEzclpzcXRSeEFmaHp5UDZKK0U3NmYyaFdZTFNoYng2?=
 =?utf-8?B?dENSWGhRVEV6cGhSQVQvR3pvWWtKdE9zSmJWQzRVZjBpdzhKL3c3NUloMkgy?=
 =?utf-8?B?cDV2OXNiMzdwWHdpVGJrKzZUSW5Ra2xBUzBFQm11b3hoaWk2OUJ1MU4zY1g5?=
 =?utf-8?B?eWlEVWd2OTRuMVRESHcya3dvaTRaM3dwcDllUGwrTXFXSmFkSnV1OWVUczBo?=
 =?utf-8?B?MXRSZkJYVlJFL2srNWt5eEtJWnR4cUFqcDJhZGZmbXVhMEdZQzBUMXZ1amxj?=
 =?utf-8?B?c2VnM0R6aGt4dVlIQWxBQzZ1V3VjeUJKMUxBNFRVZnpsSk9HdDQ0MWRsZ0hE?=
 =?utf-8?B?VjNrSDRnRDBFanNaSU8rMlVybXc5cXh5NEQ2d0U3OHNVbnBna2MzTGUvSnpT?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd335b28-a655-4305-4c8a-08dbbb834313
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:47:44.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+wHmuFHt1+KEO7AF2elLifMfjxbmAlhCkjsgARm/r6CiXkDyYKGsO4VxKsdzPx+33Xuc9p6ii/PZkdTwRWAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7873

On 22.09.23 11:01, Martin Elshuber wrote:
> From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> 
> When the ICMP stack gets a fragmented message delivered, there is NULL
> pointer violation that gets triggered when the IP stack decreases the
> reference to the socket.
> 
> This is because for fragmented messages the IP expects that skb->sk is
> set to the socket in question, while the socket as an increased
> reference count.
> 
> Following the UDP implementation rt_udp_dest_socket this commit
> assigns the the socket to the respective SKB.
> 
> Kernel Panic fixed by this patch:
> 
> [   54.217711] RTnet: improper length in icmp packet
> [   54.217721] Unable to handle kernel paging request at virtual address ffffffffffffffc0
> [   54.217728] Mem abort info:
> [   54.217730]   ESR = 0x0000000096000004
> [   54.217734]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   54.217741]   SET = 0, FnV = 0
> [   54.217745]   EA = 0, S1PTW = 0
> [   54.217748]   FSC = 0x04: level 0 translation fault
> [   54.217753] Data abort info:
> [   54.217755]   ISV = 0, ISS = 0x00000004
> [   54.217759]   CM = 0, WnR = 0
> [   54.217763] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000003319000
> [   54.217771] [ffffffffffffffc0] pgd=0000000000000000, p4d=0000000000000000
> [   54.217784] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   54.217792] Modules linked in: rtnetproxy rt_loopback rtipv4 rtnet
> [   54.217811] CPU: 4 PID: 225 Comm: rtnetproxy Not tainted 6.0.2 #22
> [   54.217822] Hardware name: Theobroma Systems RK3399-Q7 SoM (DT)
> [   54.217826] IRQ stage: Xenomai
> [   54.217830] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   54.217842] pc : __put_fd+0x1c/0x160
> [   54.217858] lr : rtdm_fd_unlock+0x50/0x70
> [   54.217867] sp : ffff800009ffbcc0
> [   54.217871] x29: ffff800009ffbcc0 x28: 0000000000000000 x27: ffff0000042b4400
> [   54.217886] x26: 0000000000000000 x25: ffff000001df8e40 x24: ffff800000c89580
> [   54.217899] x23: ffff800000c89000 x22: 0000000000000000 x21: 0000000000000000
> [   54.217912] x20: ffffffffffffffa8 x19: ffffffffffffffa8 x18: fffffffffffe7e40
> [   54.217924] x17: 0000000000000006 x16: 0000000000000006 x15: 0000000000000030
> [   54.217936] x14: 0000000000000001 x13: 0a74656b63617020 x12: 706d6369206e6920
> [   54.217949] x11: 6874676e656c2072 x10: 65706f72706d6920 x9 : 7020706d6369206e
> [   54.217962] x8 : ffff800009365868 x7 : ffff800009ffbba0 x6 : 000000000000000c
> [   54.217973] x5 : ffff8000093e0c34 x4 : 0000000000000000 x3 : ffff8000093e0c34
> [   54.217985] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffffffffffffa8
> [   54.217998] Call trace:
> [   54.218001]  __put_fd+0x1c/0x160
> [   54.218010]  rtdm_fd_unlock+0x50/0x70
> [   54.218018]  rt_ip_rcv+0x194/0x230 [rtipv4]
> [   54.218052]  rt_stack_deliver+0xc0/0x1d0 [rtnet]
> [   54.218093]  rt_loopback_xmit+0x54/0x70 [rt_loopback]
> [   54.218105]  rtdev_xmit_proxy+0x48/0x70 [rtnet]
> [   54.218143]  rtnetproxy_tx_loop+0xa0/0x174 [rtnetproxy]
> [   54.218157]  kthread_trampoline+0x1a8/0x330
> [   54.218170]  kthread+0x10c/0x110
> [   54.218181]  ret_from_fork+0x10/0x20
> [   54.218196] Code: a90153f3 aa0003f3 a9025bf5 aa0103f5 (b9401814)
> [   54.476465] ---[ end trace 0000000000000000 ]---
> [   54.476470] note: rtnetproxy[225] exited with preempt_count 33554434
> 
> Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> ---
>  kernel/drivers/net/stack/ipv4/icmp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
> index 8485614ec..cdd22beb3 100644
> --- a/kernel/drivers/net/stack/ipv4/icmp.c
> +++ b/kernel/drivers/net/stack/ipv4/icmp.c
> @@ -421,6 +421,7 @@ static struct rt_icmp_control rt_icmp_pointers[NR_ICMP_TYPES + 1] = {
>  struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
>  {
>  	rt_socket_reference(icmp_socket);
> +	skb->sk = icmp_socket;
>  	return icmp_socket;
>  }
>  

Oh, that must be a very old bug!

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

