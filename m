Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2679657
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 07:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdD7WuMSM7WuzWbRkCnWxPzASfHkTJBek/ZhRah+CDjJ8uxJggWKIQYRcrNfIrZcyDoiauJ0zCPAB0tqjK1paYD0i9cfI7hX/VPy4rNWef7igQCcwYcL1eIUo07XniBMvQ+M1y5LoQ4YGSjOTTJEaL5K76ABGcqYOOzFUwcAZlqtCcDVdioXNL3d2lzItNRtDD++RtfFB5MRizW+jgxPLtd6YGGkG8yGIwuVH8gRX2g5jnCoqw7tQgm4BNri2TVZ8dKi6AN8/d6w6ThhLS4p+CHriM3HSXCMMk1oS+7K8SguveDBuf0BxnWMg+IYC4YSZkx4n+R1sdrUe/husEUc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N4tb43mjJj1nvZwHVlqYDti3eGBklAyGFn6U4ATupg=;
 b=NRKNNhQDUSb7igPN+6B5mbTVTObvKiJCyRP5h026Y9QcmXFfG4zRm1i9v4SqeT+A+ldYMgPKMPkxIdnvzZU7WJEoRvumTfddUVRPeY1xxOVmF77ki1wlE+T6tyVB/hHruSiS7MDEooSGCh91ixJgbxQeB+IU+r/dMLI0TUJQo1Fl0GFihtrXpKKE9EjtEn0UZSBkr+6IX/bqzkYWLzN42eErBZVuzyNKdPSuc+uUGYb0cYXBfG2H2hsE4T+lKdlt7esjXOW0D3SXQ07hfWXJ4+yrsghaYO5RI986NfqoSFU9rVsVjvHfSWkJIhWyhOLaXpZUyo3eh8HjSNlH/fEKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N4tb43mjJj1nvZwHVlqYDti3eGBklAyGFn6U4ATupg=;
 b=OFGkXyA9wenn5iYV9enmM4V9MmEXNSs/OcBNzCIUuLJRKWvV4u+aYoah9SAye1Ua5y+YeV6mSXOiwpqDySCAgGA7aB0htSCFCEmedBIY4vuHc5yvzInvt89jUMPIQukfSptIMgcZidUpgPYbqk8ir9ScCO0iWW0eV2ylqKlXVOl0hEWE8NkMc9ytO/KSofHzgiy1uWHZxdCj+Ygo+OlVGbQGDaEP2SrlRMg9n8wIxzcyTkGs3BB9A2s3hlb4jYqhY35ZrnI8goWsLlUZC1Ythm28vSeOyNUHLqRqNtPyIQ2GY4PMUk4IsW2UFBq4LBh7tZVZkxvJgQNNsKBgAeerBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:619::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Thu, 8 Dec
 2022 07:20:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:20:34 +0000
Message-ID: <e725d402-ec1c-bc60-5ec4-cc3bef3d452a@siemens.com>
Date: Thu, 8 Dec 2022 08:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] clock : avoid panic on xnclock_set_wallclock() call
 during COBALT_STATE_WARMUP
Content-Language: en-US
To: florent pirou <florent.pirou@intel.com>, xenomai@lists.linux.dev
References: <20221206113707.31311-1-florent.pirou@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221206113707.31311-1-florent.pirou@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0097.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: a2abb07f-ca83-483b-fea3-08dad8ecb255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5T/FIbZNGl/t/0fWcWxre921yeuYDbyLvvNX9BMW1P2YgRhH1u5BwnAEdN/ns5jvcgJVTUjL28qPoE6wM3nig+S8ksfXFixTopo8B/MN0HQXla1U9m6xeXhUJ/R1zaSf/TIe+eNp464s2YpKds6nMX0ofsqDH2MSbzeb7ka3k790PJZYwPm9PBuSBrfbh6JV5OeCX7UNnfPEJIaAuG4btJowO5jLfla8mwHFW0IylUyZ5AbeBx71eCsZcWpz3v3w17HkBUR1E313NbB8H6ie0yVzuU52dyjf58cdQcwIKZ+FRe5vR7oVV08D5BN4DlrPeY290dyPZyVpXxHygFiYzhs8Cywy+rgo5fLmJ46wK6uAMouUiO612W9Ffgq+62K8qL3TU8kDavlnV8PkKrV/Nu5Y8LYL8PLILateW0dXlQvgTifAGa5MyctDQZpm9i5lpK0OrRJxuIYZJkJ6I9fOb4JAsXwote0m8laTxAnjbxNVxZNLbUtMOYeViIb2BxIA35mlgIHv7pRUBkDc329r5sR/rdbI1OpI7ArQrd5Cp3LzGJpuKRyBkNbhrxgOR+Wg6LRzrq5qNMip0ZoIKkOxqijPLa3hrD0iyOzBOKeBCZ8dFCpguZ3K6Hx6rFv902NvzgTlhX+9pP0nHK8Ze88aPhJwGDtYMH/WQaqQ6RRSSPiFnHe5lQ18dlqVsI3aUOIwm48qTh2aTucD20RzpgX6LB1AOm1r6HgoN5P15DS4vZmqZXN07ObTNieDFm/0HvG8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(66556008)(66476007)(31686004)(44832011)(8676002)(66946007)(2906002)(478600001)(966005)(316002)(36756003)(5660300002)(31696002)(6512007)(6486002)(26005)(86362001)(6506007)(186003)(2616005)(8936002)(83380400001)(41300700001)(6666004)(53546011)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SklXd21aZ1UwWnpuWkt3LzBjeGJWWWlmM1hvckQrVUpFd2swTHdsbERaMGw1?=
 =?utf-8?B?L3gzQ0pnVTZuM2RLbm5MUkU5NjUvblJvU2JobVBKeDFLTjZWZDVwVlJVdzN6?=
 =?utf-8?B?Q2RmeGMvbFJFU3JYbmpIYTJCY1gxWVRyaG1mNTlERC9FMmpxN3Q3UDROMHFX?=
 =?utf-8?B?b2JqcW9qOWh3SEJ6N1pHTitMZThlYjF2bWNRcitkbkRXYVdlVjRrd0FZeE8v?=
 =?utf-8?B?Zk5NZTFnajcrL1ZoTDRyck13bmtrZXp3aDM3UnpqUGlnUU1sMjMvallLQU1h?=
 =?utf-8?B?WEZ0VGJuNi8vaytqaFhVSGV0QlkxT2tFTENhNmFkczR6V0tsV0tMbmQrVGYv?=
 =?utf-8?B?Y2FQUzZoSDFZeXI2Z1Uxa3B3a3cvdWxOYW9nK1ZGczN0V2gwWkdiTEJ2ZFdM?=
 =?utf-8?B?dFJybnVUbFoyc0tVZnRBRUpRVTFxMWVHODFIWHVPaHlWdjk3R1VVNG1wZWlj?=
 =?utf-8?B?enA1YWxHbnM4aVpadUhvVGYyYTU0NDBvdmc5NnRjQ3hscUpFLzU0VkJpNEVU?=
 =?utf-8?B?dFR1Y0JGV1dQNTN4VnBwWG13d2w0OERZa3AwZk1GdGhDMnpyZjg4Ui9uR3Er?=
 =?utf-8?B?QlFUTXZBemFzS2tmSWNiajQxbHNMTHlodUhhVlJxUklIUFpTVEZoU2tXNnRW?=
 =?utf-8?B?K3Y0VVJRR2d5K0NOZGxEMHdmUnhsZ2djaHVOa250REg5YWdsMzFrMk0wajVq?=
 =?utf-8?B?aWJPcGhpMlorQ1Z6VGg2aTY3Zm1yS1V4Wk1YY0xnaHh5VWdYbWpzcmcwemZV?=
 =?utf-8?B?aEc5RXlhbllvbjBtZVh4RFdFRWZGRk12bnBCZzQrRVNxSzA1RUJ0Q25XV1pO?=
 =?utf-8?B?c3BsWStEcEZ3MlY2OWRoY2RTMGJseXowRHdNNExBNVczYlRBWDZPWGNQUFgv?=
 =?utf-8?B?alVVb05JVkhaWkRvd0QyYzNXZjZLVVZiQmp0ZTZNQ0RPUENmazdNTDZHUFc0?=
 =?utf-8?B?c0k1SStjMXF4UWVEUlJsTlNiV0VrbTdGY2JTRkpNUUUySk03VERTS2toYXBW?=
 =?utf-8?B?MU8xNGgzOGxRWmdkQnczcWxjdlVRYk5xVDVIa0FvQVR2dU1TSDBMeWNpTndE?=
 =?utf-8?B?Qi9JRWVzTEZtNVMzMy9xZ3hwa1JCeVlkb0k2WWtrSjFoSUw5MGNMalc4clUx?=
 =?utf-8?B?bVpMQWFsRW1NVUIwenZlSFQxS1hJeGtUdUdSRlptUXFCY3pmd3h3ZHZNbDEx?=
 =?utf-8?B?Q05WSVhJK2kwMXpJQlp3azZDQlp0RjRnc253M25WM05MY2V1ekZWYnZ3Yk4v?=
 =?utf-8?B?OWRhU0NPZFRNd2hlQnlydHA2UUw3UDB3cmhVZDk3OWhaMHM3M1JkWm9RNlI0?=
 =?utf-8?B?R0V6aE9HZ21idVV0UVp6N0ROOHVFbVhpb1hUUW1sc2xNMjdrektLZTBLS0tT?=
 =?utf-8?B?TC8rSmFIWUpaSUZ6UzhxTndUODM3cTFmZlhnZS9XVVNiL2EzK1hPZ0NudzZr?=
 =?utf-8?B?cW1RSnRvaFNaR0hPTzBYNFRoZUhPbEZJNFFRZitGWWxzSFZzUHArbkNaMmdz?=
 =?utf-8?B?ZXJ4V01MWWIwbUtyMGRZblJiZXZ6YmtMS01TRUVVakV2THQ0ZWcxVVdCSDRp?=
 =?utf-8?B?QndBbXFPSXdYNjJYeWpodWoxNEJmYUR0MXJ1aUdBcXNXeXFWdnRaVFZZQ25s?=
 =?utf-8?B?WGpVUlptNEs3Y0hqc1ZPdlpsN3VWa1ZLZWlEUFR1VXg4K0JMY0dTOGsvdU5G?=
 =?utf-8?B?Q3lMam0wTEh2MldRekoyaE1vTmlnL29MeU9CSmJ4NEU5aytxOXB4L2txVUJM?=
 =?utf-8?B?cVlZN21DdTFVYUN6RVI3THYvaWxFcWJrQkk2MmZJRzRZd3Bmc2RNTDZFNVIy?=
 =?utf-8?B?T3dtZzdHM21lMUp5b2RyRnRjeFlqQkxoeVVmQWFKT2VwSnlzTDZSK1VoVld0?=
 =?utf-8?B?Z0RRYmVXU1hac1l2MEZYWFkyT2M5SFdaNyt0TndLckdxMVA1VnkyemFPRVBq?=
 =?utf-8?B?c1dEQ0dGOURlMHFCRWhqSUs0VXFwKytSNVJ6SXIvZWxoMjZGTFViM2pCZFZs?=
 =?utf-8?B?d3hEa0N2endBeTVZNFlVOUx4OVBQclcySGpteWFOMDFCUkxaRWpOSzhTYXlE?=
 =?utf-8?B?RE5JbnpiZFpqM0ZKZGpFN1hSaWlrZ3RNTXhkclo0MDFpb2NzWllxUGRuMTRh?=
 =?utf-8?B?Yk1rbkVncEVZc3VDZWNuaTZ6aEw1cS93RnZRTWREcW03M1gzNDFySjhOWjFG?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2abb07f-ca83-483b-fea3-08dad8ecb255
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:20:34.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsJr6HzN0HgIompOXNzoRavSMyiKsBNpgjh+8bLiN4bMkTtx3V+FleFNhf26macq1l7YTr3ZfaAqUfVS3ji7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7231

On 06.12.22 12:37, florent pirou wrote:
> The nkvdso variable should not  be unconditionally referenced in
> xnclock_set_wallclock().
> 
> Call-stack:
> ```
> IRQ stage: Linux
> RIP: 0010:xnclock_set_wallclock+0xba/0x1a0
> Code: 7a 01 00 4c 8b 25 e6 39 35 01 e8 31 a2 f6 ff 48 c7 c7 60 3e 4c 82 48 29 c3
>  48 8b 05 70 f9 9c 01 48 89 de 48 89 1d c6 39 35 01 <48> 89 58 40 4c 29 e6 e8 fa
>   fb ff ff 48 c7 c1 10 cb 01 82 ba 29 01
>   RSP: 0000:ffffffff82403e70 EFLAGS: 00010012
>   RAX: 0000000000000000 RBX: 172c603286674a4f RCX: 0000000000000008
>   RDX: 000000000f424000 RSI: 172c603286674a4f RDI: ffffffff824c3e60
>   RBP: 0000000000000000 R08: 0000000000000123 R09: ffffffff8201cb10
>   R10: 00000000fffff000 R11: 3fffffffffffffff R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000200 R15: 000000002b4448a4
>   FS:  0000000000000000(0000) GS:ffff888869000000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000040 CR3: 000000000840c001 CR4: 00000000000626b0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    do_settimeofday64+0x137/0x1c0
>    rth_timer_init+0x60/0x7e
>    x86_late_time_init+0x12/0x2f
>    start_kernel+0x4d8/0x577
>    secondary_startup_64_no_verify+0xb0/0xbb
> ```
> 
> Kernel panic happens when the clock is set using do_settimeofday64(),
> implicitly calling xnclock_set_wallclock(), during the cobalt_runstate
> COBALT_STATE_WARMUP state, while nkvdso is NULL.
> 
> Yuri Zaporozhets: Crash in xnclock_set_wallclock() if time/date is set early
> https://lore.kernel.org/all/CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com/T/
> 
> Signed-off-by: florent pirou <florent.pirou@intel.com>
> ---
>  kernel/cobalt/clock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 2b9efad4e..b1b9a3b0e 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -282,6 +282,11 @@ void xnclock_set_wallclock(xnticks_t epoch_ns)
>  	xnsticks_t old_offset_ns, offset_ns;
>  	spl_t s;
>  
> +	/*
> +	 * Check if time/date is set earlier than cobalt_init
> +	 */
> +	if (!nkvdso) return;
> +
>  	/*
>  	 * The epoch of CLOCK_REALTIME just changed. Since timeouts
>  	 * are expressed as monotonic ticks, we need to apply the

This also seems to obsolete the "if (realtime_core_enabled())" in
inband_clock_was_set.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

