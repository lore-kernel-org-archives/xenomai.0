Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E4FBE2
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="n2xoYar2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy4uofRWJo5IoVHT3djp7LwdASzR4KgUBf+Amu6D/ab/PqEnCEww/j0UJ68X8YJKZP7zOIvx99QcMHZ8xe+Pm5FU2236QFDHDjd6igzz/YzrJSpRVNfNgjDP0RQ9yRO3KE3ajjzVYktxoqlqZwHs+Roa/iQM0RaQdSQU3Gyt3fhWLMqL0xjL/otgS4rooBpGAH9wK8xUayZ7gPo4RwiVV5LvAh9YvQrHTvbBjDpCCkNtUbO4smTmL7QqWU2TpKJBIoob/FFfNJMckeF+3/L30ZxzMt/lVGDlmYSAeA36SNZmddsbY6qRxVlP+pJ5yk9Ez8oRThLxqA569cMxKxN1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apneneIR7PMSF+YKWvCQZi2GMpgiznO3R54vJ5dXyAU=;
 b=iarok/n9wwfgKtPAgsw9F097UUZATwNpnkE2FioBspg0t6Gz3mQpYz2ftkjezTOvImsJsp3wyZcqXSYlgK2h1F+fH10ry2E5KyoLAtnhRXKFL655pg9p162gwWrHEgfvWuRi5fdxpk1SaTr5rMu3FreNeKo2DufsOip9pJCpuTs99DhyyKvI1ad3HzGQXxkiUi6yqTGHHAWSsUlifrldkD0obtBcTiN5VwktJhHzQAeH16q1FJZhl1tIsAczs4xgztAzEwoR6ldNlOmkyzvuvreMS71HyjXaRUkYhgg8VQl7ZzYW0YaRX5YzrB6U7wIHR/tUwW0LDplTivMLyaxICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apneneIR7PMSF+YKWvCQZi2GMpgiznO3R54vJ5dXyAU=;
 b=n2xoYar26Jua9tXSXCq2HylHzV/rwBurhkH6be9XP2KW+fp4s2eOtH5YaHb3o690V+A2kXdqVscF6GLIo083H4rtl3oDyn8kC2Xb1kKcz3N90ltjy/QS9RXlBI7NURH/yP/xwla/Cwqu3in5xkgQV3w6+UWaoMgjNfHvxwbMG3GP40KYUjRHLTSYHkEnDQDpRMUqjL0Pa0TbNPQ0vmAHN28CBpiPz7jxxNQ5OKY9Xuh2j0a+aagnk56zMIp/rZSzILiccjcs/Fth8YMFURxJkoTaChwhoGbuX5so7hMArQVScBsSXN1NLB3ezOrVQzLom+X6c+al/XoKCcjekgGdQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:32:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:32:53 +0000
Message-ID: <983ceb09-c9f3-4b15-9aa1-78fb3d371df4@siemens.com>
Date: Tue, 2 Jan 2024 14:32:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] xnthread_set_periodic: Improve period adjusting
 support
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20231220194855.8684-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231220194855.8684-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f49f325-5c1a-411a-37b6-08dc0b9752b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4gY18cOjfU0ESirQCyEwODvQmQYdhw//e+b6ImCM5kOjTgC9y/G31oNmiw57ISwb8jcWuGhyFSNFKmP/dxfihAnNE4MZvssPtTttzfAQryEWpzPpQVltU8sFdaOXfEIQftFC4e9m+E7lkgu2+hDOFgZiQFw4U0EyccdpU9/V1Sm0gHkuTq2ubIelRyuwUIYCWcO9z+gWK29wjKvd/dutKtVHg7VZUsz8hPlptrpIsgLaAxo0ZDj9313fsiHg+CB9CSQ/hsWIP7+Cx+TfEug3nXxWJp9wTZ1ovKEGUopD8GISqNZAsj3JSldM/G8mVsiHb1xp9FYCMfr5AQvJUpJ+MnMVUUeYSJWQlKTKIWEt+BJpS2oY9h8QVwenC53W079Ss0O1BcHti/pqcbR9ZcLUjqVuT56bgHBrZQLubscC2cEzWD56SIkGa0/oRC44aAk2pEVssAEHaVmG2DU4bpZGzkthPJMFnUwIMjNjKQn+TlaHv0KeK6WDw80CSxWO4PTdGk+UPbDr/ceDC1zCCPDGCNS3c9HDAFNJ1hdVTbJtEZjxLJ2V1AD9YuqGsE3KquyddA6Rs4dqW7Ty0HmkgbQGsP5GbrElXkZIrPu00O/Ix5MEPJF5+pL4TEjxxuhSTgUS0nP9sx3K77wmKOaWlfvtvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(66476007)(66556008)(6486002)(44832011)(316002)(8676002)(8936002)(2616005)(26005)(83380400001)(478600001)(53546011)(6512007)(2906002)(41300700001)(5660300002)(6506007)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZXRVRsMUZCR055TVN0UWVKamRGUEU1bkRtVEFIU0hla3NCcjdrNTc3VXhM?=
 =?utf-8?B?bktXbDR5d3FnWHA4K0g2WFVCb3hMTlA1TUtyTUE3UkhZdURjdjFtME5qNjNs?=
 =?utf-8?B?ZngrVWFQRVY0Z1orK1R1M1F6eXhxTXhkYjNkQTkrQTcybnhXWTNUR3lEOEU2?=
 =?utf-8?B?UThlVGdkOUhFTFQvOE1ZemVGcXRZYUNaZmNWaEgrOEg2eWVHOEFqaHRQdXpw?=
 =?utf-8?B?T1d2cjRyYXhiVmp5eWZ1UEtYR0JEdkxFTFptVDVWdFZzZ3NlTlVZQnZ3TEpJ?=
 =?utf-8?B?Wng5eXE0YlZZdUNCUlo1WFM4M3NFSU1ZUjRZRFZCMTg4ZzZvV2UwY2RFN3B0?=
 =?utf-8?B?L1BraTV5ak9xemlzSkFXM0VhenAxaWhwbS9GK1F1Syt4WjVDbFEzb3h6dkN5?=
 =?utf-8?B?bDRlc0Y1ZFFJU0tzMVJ5SEtWMXZsOC93UTRkTlJQc1FxSzcrbG1qRG53S2dC?=
 =?utf-8?B?TWU0UVJ5UEgvRGJFS21ja1laRjRua0p4MGd5YW93eGg2cUxWVzJLY3FsSjB0?=
 =?utf-8?B?UTVmQ2x0YWlWNTUzVC9sMXUyUXpWaFJndGdmempjNVA5TEY0OHc2YUQ4Rzdq?=
 =?utf-8?B?Q05acHVVOFZsR2VzTG9TNVNFb2FZaTVvbUtlclkzM20xVVdJNjBVTkRQT2l5?=
 =?utf-8?B?eFduYkZLdWNCeVpKOHIzSkxEYTg3N3cwWjU5dDNXTVBSTkFHQ0VWcmRKNTV3?=
 =?utf-8?B?Q1lvKzUvSDcwZVNrcXZFMkZwbDNUTW9ESHd0Z3hTVjFQMXBRUU1UZm1oZGxG?=
 =?utf-8?B?RGNXR0t3RHA0VkNaUUthK3lhL3BOMU9IMnZxVWorL1NQU3h6UElGL0loSE9x?=
 =?utf-8?B?bmhSQ29VWXh4bHErQ3ZuMEo4bEViRGdUeHVxOWJUQkFTd3pYUGgreDVhR0Vw?=
 =?utf-8?B?cGVDK1RDWjdyMnJ5Y01hUUhBd1pvRTVzRk9jQ3BUSDNrZ0ZuT2FuSy9xdzVE?=
 =?utf-8?B?ZE50QXpldkF3ZGp3SksxaXJqYUN5RUozM1FQYk8xMVhoTFNBUWM0OVR0cHhv?=
 =?utf-8?B?N2FaWjQ4N2s0SFJla0ZCMVp5dTg3NVFvTHhxaGNSVHNkUCtyY2loc3htOUs2?=
 =?utf-8?B?RTJ0UnFGOFpjdnFnK0F6bm5KY3JMVkZmUnJReC92STZGWFg5UTM3OGZlbUVh?=
 =?utf-8?B?b2tsYjJXWVI5RGQvRHZRbXJLbGFRRFI0cTZCRWxyc3E1K3NpTmdGSE05SkNY?=
 =?utf-8?B?Sk1DdE45V3lKU2QzVWs5NWVKNzFZa0JQVTNySFhEZlIvb3oydXdyeEdHbU41?=
 =?utf-8?B?NHY5cUMzbnZpUmg5TlRvamR1ajlmR3pLbTR0eitmRGdsSW5kdFgydzFiU3Q1?=
 =?utf-8?B?cGw2cWpzSUg2dTZ4TE1weXZIRnRwQTQzUVZxVTB5c1RPUitEa2J0UllibTdu?=
 =?utf-8?B?cGt3M2VXVUhuTWNxZGZ4MWhDc0NVK0NoS0Y2RXk0cUhTaWxad2psYW82L0JE?=
 =?utf-8?B?NWdxZlpQRDNoMnFZcVN6SUpISDBESWFISlZYU1NqdWRMVU9KUXg2MDNGVmpl?=
 =?utf-8?B?NEpFSzMxRGhvN2FPOUFlK3NXbU5YV3cvMnRlUUVkWDNZSmx6L0VraWFSTzlE?=
 =?utf-8?B?eXVWNUdLQjNaQVBHSzkzM2lBcVhuczZRcnBKMTczUnNkMjdzWnBhUXN0b3ls?=
 =?utf-8?B?TC9CeUoyQ0RvUDdmNi9zdmtJYmNLWDdmVXNzd2FWaDR0TGNMb3cxT2FaNEhp?=
 =?utf-8?B?MlVuWUdYZmlNSzMvYytqU2hhZHRPRG5SZUwxeG1MUFhQV0Rhck00ekozOWw4?=
 =?utf-8?B?cGZaVlZORjYvdHVGdjB6TlhRYUExSGxWMk1WNnpiVGhuc1BxaE45QTJvc2tW?=
 =?utf-8?B?QlhZUjI3UkNSRUsvZmxnQ1VxWGY3aERPb1Q5YzRSNjFLb0hrSEloZ09wQTNQ?=
 =?utf-8?B?Q1pVUlJJU1hFUml2THBKaEVJNTdQRnpjTVFUR21US0VFVUp3RHBka0ZPQ1c4?=
 =?utf-8?B?aUZBM0NyNjdDOVoxbnBtYk85OWk5VElkSGpObVRkSS9wMEZIM3F3WWdkU3dC?=
 =?utf-8?B?QjQ3REgwVlQ2R0FBOHlybGtuam1yN2FPeFVrZitPcmtHSWJtSU40Nk5YeC9n?=
 =?utf-8?B?b3U2TkI2OE8rdUI3WlJaNnBpVTdaMDNTNzVqSExrZk9GR1FhWXExS0JNTCtm?=
 =?utf-8?B?MnljVjdnTktKYWFGRDN3SFRqZmkweFBibjVrK1RsRFptWk5lM1RQUkprNyt3?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f49f325-5c1a-411a-37b6-08dc0b9752b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:32:53.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhfOSHSY8nxmidMS3E22UjybVUFgcqi7xa30UX2tjND76G/r0lvskELhZJST2tl+ERhwRdd4lk2nnjnk0Viguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3346

On 20.12.23 20:48, Richard Weinberger wrote:
> Currently, when a periodic task invokes xnthread_set_periodic() multiple times,
> the timer is reset each time.
> Consequently, the period drifts because the elapsed time is not taken into
> consideration.
> To improve the situation, account the elapsed time of the already
> running time to the new start time if the time is smaller than
> the new period when idate is XN_INFINITE.
> 

If I scan our code base correctly, this only affects RTDM tasks, at
least in-tree. Is that your use case as well?

> Alternatively, callers of xnthread_set_periodic() could access
> task->ptimer directly and pass an adjusted start time to xnthread_set_periodic().
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/thread.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index ff12f288a..a5304cc8a 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -1335,9 +1335,18 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
>  
>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
>  
> -	if (idate == XN_INFINITE)
> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
> -	else {
> +	if (idate == XN_INFINITE) {
> +		xnticks_t start = period;
> +
> +		if (xntimer_running_p(&thread->ptimer)) {
> +			xnticks_t elapsed = xntimer_interval(&thread->ptimer) -
> +						__xntimer_get_timeout(&thread->ptimer);
> +			if (elapsed < period)
> +				start = period - elapsed;
> +		}
> +
> +		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
> +	} else {
>  		if (timeout_mode == XN_REALTIME)
>  			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
>  		else if (timeout_mode != XN_ABSOLUTE) {

If we changed the behavior of xnthread_set_period, we would also need to
update its documentation - which so far states that "now" is the start
time when calling this service with idate == XN_INFINITE.

But why not using idate for this use case instead? Is the pattern too
common to push it to the user?

And if changing the current logic, I would wonder why not saying that
idate == XN_INFINITE means that the change will only take affect for the
next period, not the current one. Would avoid losing one shot like in
your proposal above.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

