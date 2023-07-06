Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5086110E
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3vOVhfRsSNcKiCLaUpA8NtA6cQFVz5ImJNmQFVS7o2PKUpKOmlAfBv3JBBCb070E0enGYYwa0BoyqS3WUxsRQNPXbaqlwsCEKY54IM/0REe6X63j/osn+ttlSX39Slg2UbQ69E5f6uZ60m5DDrMAwJEefXwvDFlP3qPDA6goMOWLPBZZ832ionqkGPyYkmm5v1F/PTGbiPjTgQhgq4Tcte2n8t9CmBzLOD60MvfQ1CpFVv6k8stBX8cF7dXapTXYe1BFuXycvQHFqkyOq7neNoqHqTo/t29gDI99LfPqHLwSWk+Du0Ccb9jzAUglu6R6dV+y3qjd1fKTpnvuEiSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51GBNe6gnJWFfJKCH1jmTrwIcry3Y0eCPtnS0IYrmM4=;
 b=RsCbnBZisFBXrtYmaeJtIZNNFFvlDrtHg+KgVdmKRDREpvidcYO2RBnccVNS1JZbBFeaz3ATktjZWEIPoglekkfv3hn4OpgOAr5VsQui0l27yIExyPKmTmNma7ioz+Sblx1SoDfWQw2wUZUcuYrfygm4Dqvdk8uZeW5w3Gc4yB67eCGi8h6GdbZHZHuOd8NE2XydlhfX6rf/Um31XlHzTomlOwimXMccerb6BM3MrY9wHD8q/Uic82cqs6r0b9lsV8AAyohCXmXx69L/G+ECTL8noDKD/86LlWmPGyPypJeEdHNSDsR5PeDq3oIL44pnoU1n0KAxv4GFufZPsCZ74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51GBNe6gnJWFfJKCH1jmTrwIcry3Y0eCPtnS0IYrmM4=;
 b=ej6l1Rv1F+9cbUgQriK32eKaa1+0yTz+iyMGnyeNzw8uKQhnKHLZftHJc/PJfiORpcIhgBWB7tEUPxhnn/Qf/DjbFWCBf/TnB4f97UDp75za6rhedHF7diVCp9FAV2QBI131o/XUCw0L1d7UGjLYf376UBnHlNJh5FBp3viNq9mk5Br3Fl8BpmjgAFHWiRJYCNne5wubIo/Cw/rBsEu9/DDtyLEK0zlvoODzRdZRKm+yE8cI2APmG/aJke4YMySkWwtteOdLEPgg4yyceUb6Cy3e2D0kkLkuIFfDRR9c0nF8FHUqMfN61BfTu2iatWzUY6071rM4elhL030TliLrfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:13:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:13:23 +0000
Message-ID: <99f6eab7-bb4b-020a-0a0c-49e653a4a243@siemens.com>
Date: Thu, 6 Jul 2023 09:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/12] y2038: cobalt: Introduce sched_param_ex64 and use
 it internally
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 9238db12-669e-4ba7-939f-08db7df07c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZeHdvwMfnqZbtrf9lggAjdF3OTAYhqE2vAn1Z3o8MLOMtzw89yjbhAZmJzSX5W45uo5Dby1+yho52LgloYcQlwIaWG4Y5pTVMwqdSyOi3sOyD/2CkqQHTQ0q0Cq6vEGaKF1RAYLhxb5pKGmzCsTLSUt9Or/X6sXVQi+WKzrhRc7cPfVSD+kScRfClI/kJm3M5p9BgN7JMDh1cTR78rEsh5DXuiiRMzE/8mAo77IzM/MqH2oWbnneFsSmsG5/VJks3BHn+/HY0vDejvIeZJP/M1EajnFxkbptLNcZ2qRYEMk+Rl0AWCTCaqDDrA7lslvXlbkhr2z9t7E9t8tNHWBVgG3Vq6plTBmMcQhdwKUSai19Jd5tLETwBoIuHarUpV85JTP1MVa9mg1yG8W5oQh54aYwva9xsLWKWgDu70GQA89wJzHyGMCOCn5BNmfE7oUx4f2r6h/Wgyc2ZUFECIsPBfxqvgIwHwS9mxIHoAlhgn8y9CW+iwFG/H3dG1KRqf0z/8kuk1evS2gmWAUHkIt9B4nVQUSO0beu8tdShNnr7KJ5JuTpObK2lI0l2olTHhujKzQaR0LYUSzvOPS9io1LHDcEAejjq43z63G7MUEvO0wwW3NExzSFqmhlMbfMGstBiuHRZxJXkm850WW97zJT0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(38100700002)(82960400001)(36756003)(31696002)(86362001)(6512007)(478600001)(6486002)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(44832011)(5660300002)(66946007)(31686004)(41300700001)(66556008)(66476007)(316002)(2906002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGh4bEZNanhpWTFjc3llSE5vL0I2T3JiRnRpbXpRRThTUk8xYldrcHQ0bnIw?=
 =?utf-8?B?QXgzVTBhTm82Ky9mRVJJemZlU0JPVEMwbWduMzFyWU5qWmtla2FXaVYzejJZ?=
 =?utf-8?B?LzVjeVFDdEV6RnRsd1pwRmE5cm5DQjJCdkJibTdLN1R1R3doY1NweDJ4RC9C?=
 =?utf-8?B?ci9vWHUzS3o4Y3ZMTlJRWFJmOHNha0N5UC9TVi95ZGZwbFljaWNSSVJaTGFY?=
 =?utf-8?B?U0VzZW5hWkVTOWt2ZlpCeWlDNUl2ekI0QmRRMHdXaUFxR1JYc1Z6SWxQTk1t?=
 =?utf-8?B?QStCSTNXMXNJbjloMThzYzlybzREcm1WeURqNm43ekYySXBHTzY5MjNGWjlV?=
 =?utf-8?B?cjloYWJVYUZSTzYzaVFOTG0yOENQL1ZhUlRHMjZwNC9hK1NrbCsrTmxUaUVY?=
 =?utf-8?B?SDBpSVp3Q0MrNTNzR0lqSjZGL3dubW5qKzRRR01OODdjRG5wUWJKZlp0T3Js?=
 =?utf-8?B?TGhTNnA0L0h6dENyQXI3OGRoOUl4SlF2NXVDN1BEZXVoUFNONkFhMTVnUXIw?=
 =?utf-8?B?Mm9PeG1hY1VmRlk1c3A0ZjJQRFUzNzhEdmh5UDFkY0hnMVIwOEtheUtOOElq?=
 =?utf-8?B?QSszNjNtYXJ3K2ZZRnpRT0ZJWktFRVMrYmZ5MnJxT3ZMTmRjVFY1SVZhZUpY?=
 =?utf-8?B?cVNiYnk4OEsrUkdqNjVJVE9WSzFBOWdlZHJwTDllMk1GOTRWNEpnQnI2b3B6?=
 =?utf-8?B?YVVrR1I3N2NwTkI2RmY3SmRHanFNQUE3SWQraGRVZmVvdkRmSTNZUFNUK3Fs?=
 =?utf-8?B?QWNGcmxEQmhwemduck5sRGE3YzFMRGcya0ZtSFUzZVI4QTk1VGFCRnIxeE1U?=
 =?utf-8?B?WWhBUUZnUC9UUGdDc0JpaTFiVVRybi9zOHJ3L01KV0R0K3FRR0ZtbTZtQlNr?=
 =?utf-8?B?ajMxeXdtL0MvYVVxNDJiM0swcUhiaWVYQ0RSaUtlek1Ccm1oNTRZMmFOb2xW?=
 =?utf-8?B?aTd2OE00dW5RbDhXdnZsVFViVkJCbnczV2dGTHY3RVhUazlibmdqQVI3TDZk?=
 =?utf-8?B?QnJJWko5MGhzTU9SdnlEaGdUeUtJQzVCbC9PenFjeUVVOS81N1hkWEtZdWo0?=
 =?utf-8?B?bjZxdG5iTE93TU56UlBocVg0ZXpCa3pualZOSmlveS9FTi9nTHdFZXZIclhV?=
 =?utf-8?B?b1RROVRxUHlMekkxcDF6OTBaNHY2ekdtc2ZzeUh2ZTZYaVFydjFsSURCT2xZ?=
 =?utf-8?B?SHo5S3U0RkowTWZKSjBySHNmcXRaV0FSVEdxUEFOakcxR01Nd0tkR3Zya1VN?=
 =?utf-8?B?bGpsVWpLdW1iOGlLOGtyZlBOSU41NE9IVjlsWXdyVkZsZUU4YXNSNjY1V1pm?=
 =?utf-8?B?UDJKSTN1QTlNc1EwNi93dGFuSlNHY285TkZiZnIrbStKYllvM2hhRVJ6UDJs?=
 =?utf-8?B?c0ZSRlh5Mlppd1RxSi9CbHdQOEk5dGxLOW5zb2lUaHFIa0RMYWVIV1NsbEps?=
 =?utf-8?B?SnBDajJnc2tWR3NVQ05Sb1BRTFRFSUNYeUp2VVh0OTlyVEt2TXRFT2FjNjFw?=
 =?utf-8?B?aVNIZ1VsS3RuekdQUS96akVXWkRxV0hTbk5MWkYvQmFpdWh1Tlo0eW12eVJW?=
 =?utf-8?B?WFhyNEVwQlZsLzNUVW8xYnpUekQwTk1obS8wSktNVTV1N2NUNTJDelZ1N3Ji?=
 =?utf-8?B?VXRGWDRlaWpiQjdnbm1XeHhBK1k1WVNIK0NEM00yQmtEdmNmVjB1VXVra0Za?=
 =?utf-8?B?NHN2TXc1eXAyVDZDVkpheFByV0gycWtXT05ha0JkT2dwUVdUTDN5eHljWE85?=
 =?utf-8?B?KzBIUzVjckJzeWtjditiSGYyUmViSFdUenZCM0JBajNGZGJQeGxwM3NqNElz?=
 =?utf-8?B?Y1VmOWl1a1RZdkFWdFNmK0V1aDBjNzg5cHpPQkNOOUpGejF4ZDN5aVJWVXE2?=
 =?utf-8?B?ZkdQakRETTdUOCtVYWhOOFBYampseWd3TllBWUJreHYwb2FoWjFIN2tvbXFF?=
 =?utf-8?B?N1FFLzEzVEVCaVdaQ2J1VDBiMDc2UWsxdkppYlV6QUVDVFUwbkxVV0RwTlRy?=
 =?utf-8?B?VU5YeElPS0QzeFhQak5wNUN0eHdXakVZTEdvQ0VXRHZLZ3FacUZneTZrUFor?=
 =?utf-8?B?SEpBNFJaNWxVeDQ1SEFvai9hT1A4UU1CU0hpSGo1Y1ZVVWhpbWJESWhVRXRE?=
 =?utf-8?B?N0hBNnZmbEVrVUhJOXhpdXNHcTE3UXhmZHlENGFHMXEwN1BpanlybE1WL2w2?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9238db12-669e-4ba7-939f-08db7df07c57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:13:23.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi4C77I2OLWAXbUKnud/7iubtaoJLUgmr+lLZRrZiV5Ocsph5RwHA8rhY84VrT6Cq39nxrr40QJSe945RNtuVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525

On 05.07.23 08:38, Florian Bezdeka wrote:
> Introducing a new type sched_param_ex64. All members are (always) based
> on time64_t. All internal APIs have been migrated now. Existing compat
> and native system call entry points will do the necessary translation.
> 
> This is a preparation step for introducing time64_t based cobalt thread
> cobalt services.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/compat.h     |   5 +-
>  kernel/cobalt/posix/clock.h        |  38 +++++++++--
>  kernel/cobalt/posix/compat.c       |   5 +-
>  kernel/cobalt/posix/sched.c        |  39 +++++++-----
>  kernel/cobalt/posix/sched.h        |   8 +--
>  kernel/cobalt/posix/syscall32.c    |  12 ++--
>  kernel/cobalt/posix/thread.c       | 126 ++++++++++++++++++++++++++++++-------
>  kernel/cobalt/posix/thread.h       |  39 ++++++++++--
>  kernel/cobalt/trace/cobalt-posix.h |  20 +++---
>  9 files changed, 219 insertions(+), 73 deletions(-)
> 
> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
> index 275735df5..f2dce74b4 100644
> --- a/include/cobalt/kernel/compat.h
> +++ b/include/cobalt/kernel/compat.h
> @@ -26,6 +26,7 @@
>  #include <cobalt/uapi/sched.h>
>  
>  struct mq_attr;
> +struct sched_param_ex64;
>  
>  struct __compat_sched_ss_param {
>  	int __sched_low_priority;
> @@ -117,12 +118,12 @@ int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
>  		    size_t fdsize);
>  
>  int sys32_get_param_ex(int policy,
> -		       struct sched_param_ex *p,
> +		       struct sched_param_ex64 *p,
>  		       const struct compat_sched_param_ex __user *u_cp);
>  
>  int sys32_put_param_ex(int policy,
>  		       struct compat_sched_param_ex __user *u_cp,
> -		       const struct sched_param_ex *p);
> +		       const struct sched_param_ex64 *p);
>  
>  int sys32_get_mqattr(struct mq_attr *ap,
>  		     const struct compat_mq_attr __user *u_cap);
> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
> index 38b59e24f..b0fc84396 100644
> --- a/kernel/cobalt/posix/clock.h
> +++ b/kernel/cobalt/posix/clock.h
> @@ -18,6 +18,7 @@
>  #ifndef _COBALT_POSIX_CLOCK_H
>  #define _COBALT_POSIX_CLOCK_H
>  
> +#include <linux/compat.h>
>  #include <linux/types.h>
>  #include <linux/time.h>
>  #include <linux/cpumask.h>
> @@ -38,6 +39,14 @@ static inline void u_ns2ts(struct __user_old_timespec *ts, xnticks_t nsecs)
>  	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
>  }
>  
> +static inline void ns2kts(struct __kernel_timespec *kts, xnticks_t ticks)
> +{
> +	unsigned long nsecs;
> +
> +	kts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
> +	kts->tv_nsec = (long long)nsecs;
> +}
> +
>  static inline xnticks_t ts2ns(const struct timespec64 *ts)
>  {
>  	xnticks_t nsecs = ts->tv_nsec;
> @@ -48,6 +57,23 @@ static inline xnticks_t ts2ns(const struct timespec64 *ts)
>  	return nsecs;
>  }
>  
> +static inline xnticks_t kts2ns(const struct __kernel_timespec *ts)
> +{
> +	xnticks_t nsecs = ts->tv_nsec;
> +
> +	/* zero out padding in compat mode */
> +	if (in_compat_syscall())
> +		nsecs &= 0xFFFFFFFFUL;
> +
> +	/* In 32-bit mode, this drops the padding */
> +	nsecs = (long)nsecs;

These two look strange: nsecs > 1,000,000,000 (which already fits into
32-bits) is a bug, if ts came from userspace, an userspace bug. Why
don't we need to catch that? When could the higher bits be undefined,
and why don't we initialize them properly at the point ts is filled?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

