Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B1A53
	for <xenomai@lists.linux.dev>; Mon, 29 May 2023 11:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inGaZ9pESzd0Fnryg3Q0+IUb+LicNtuie5MrPq6lmrNOHam+I2E4jNEGdrWfh29F40obLTThtMamKL56nNOQYWNixK81ao8VCItCJBcy64ARv5zl6qvZARNb7dNtRQYEHipyjE81viUWq1lXnp/m/oD07SA9kl2aaXpCl4mkA/6NWAkQln1L0W9VIBhdio7aQ635SuKuRydA8dcGMGdPW4cqJEpEZVQVI8CvgtWRWGOpSQm7wI6qw6LHxWjKlpSvD9B4fWxRdcTJb7+yS64SWantBhMWtUGFdbS8S8r8QT7LIQtpHqdn8CFv12Tdy0XpIGy/Fh6O2m1/113L2f8DNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUt4bFZnoHSlaw8OYVJO3PiBqS+w+eveCldmeEvwEac=;
 b=fZPfk6/fJaaLqIrVRqov8B+taePklExiTDRFqzc0xOBwCFECBKHQAZu4EEy2vaHFhFTC1b55QlBKQZxK9ekx8HH+vYm0th91QoTsW3ZO8fjLBOIt3lDhbnmIu9OCbOcD/ifbUrqDT18qSPSBjmsZJ+O7QwLaE1qz8RSTkWaEtZFKRS0d3K55BA/ss0/xQyQvuX9gYJ3WZ7hdyfnqL9SZQZ+KkxTl0ZbGrDPngyahLyhUueoAZ+92UeG0OKz5SS/3HGic/VF2IhJ8TT5gFp+dTbbIFkDnrSZmnk52d1UvnxHC/YtzuG8nRtrmvRFV8Pf415vMPObeN9Q9nAH/BAoAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUt4bFZnoHSlaw8OYVJO3PiBqS+w+eveCldmeEvwEac=;
 b=jGMXtziVrc6ccKWhOjxU9QfxW2rqgJWCsk6UMtzq+4kIfkcVugTdRdBn8tPw6qiJV3J/brzHDHbzBxqQt0jL31Wk4WfujtJp2q7dq11RwP1b/8Bjkax+Z+jFbhdTPv4hD3/hgswKllo3uO85+zVEIjawLjmzCK3y1X5lxso75E/S5jVLwhUKzkuZSyxkP8HQyvkXhFib4VJA9NyMyyy+tmZhJyAdAI/zTxZPDqGvu4dsqgRiGZbj4Z0F3w3Qz8IrcgnlVAG0LK3B7QeYqCSBREcX523Z/gDruLGGtqS/ElcEq3xnCo5IXKpdqe5hF/C5spFO8PyyznFnG5krmaJNYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 11:11:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 11:11:14 +0000
Message-ID: <6d7f05db-4158-9b1d-cc70-7a7681ad9aa0@siemens.com>
Date: Mon, 29 May 2023 13:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] y2038: cobalt/posix/select: Refactor
 __cobalt_select()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
 <20230516-florian-y2038-part-three-v2-1-3fc689b21a32@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v2-1-3fc689b21a32@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3994:EE_
X-MS-Office365-Filtering-Correlation-Id: e05ef95b-7557-4972-d267-08db60356aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	954SugazXaQ2Dcv2YXhqCMTZXRyvCNLVfebD3GAYxkIDrv1opyLUfasUaRoDuxooWpP7iIAh4Ezo/1txP6cLxETptCv4ZbR90HSOGMqz3wzCt2HJl87BEsosvgjTBEEO1WqlCDJ6Zu9w41MZrSL4bR5UdY++aZIQvfVfN4H0vC909qiNa2H50/PtHRmdGdluJd+VM3QqnYAjybsPyQ2TiNS1OBRU+fUhv8EN+yTkUgy8aIjJbqsa1WMksG3Bd6AEooOeiddOI2hGkHRUG03QRH34RXyyJ2v2h21sfERQ7dV4DFTyCJUGfFa/4ZhzxinzUU3I2eoSmS85J/6Q71ELzefSg2M4hUr6guvQJ4OxV/Zx4p+xNdXp4sxm2CJRuEq3RRCfHfUzYBGVccJi3E05yHKPy63G15n8Tp5OU/pklDnQkNrPn/Thi1u9e9XJHUQn5FcIR/I/5hJn8zebEwnKGJbIOm4AgyCl5JtM83D0+l8oJcX9b/+WuKB9Jyn615pAjJtHQ6KX6hbMC1nFc5xxxugIyjYCD7uzejcAkLTvskWDxb+x3TBoqHqm2zBCoEjYDoVgsd3u7glQ0w/vFtaQCzvlbRsVhPoRyh0Pr2GRrfoiO5LWUEDacgyTYOXwGyAfYAnQcu19pQtRK8vDxJXvdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(66946007)(36756003)(66476007)(66556008)(83380400001)(5660300002)(44832011)(31696002)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(82960400001)(2906002)(6486002)(31686004)(6666004)(6512007)(316002)(6506007)(26005)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBRbWZtQlEwYmdEYllpS21lZmErN2ovSlBmV2pPMXVkZEFrOU9JTU5ZODZG?=
 =?utf-8?B?T01OYjMyN2NkaWlYSUNpZHF0YzZKSjhYVGtIMkF6NnE5dzRYNTN1emh6aWdv?=
 =?utf-8?B?R245SHhQYzl6WFIyVEdlRUtuSDBlTllLNHljUXVLdDdWNXAyYU1tdkRlV0E3?=
 =?utf-8?B?ME1jdERGUUdTS2toYWR3WEVRc0RVdEFBaXBOSzhGUCtNRWYrNUlCejBXaXVh?=
 =?utf-8?B?SW5DM2YzT0FwcHdzVysxL3ZmTHphMlZoWU9BMGdlaHU5QjdyVTd6UXU5VjVN?=
 =?utf-8?B?bDZyVkRIakRJT3dxanQ0cnRRVE9XKzlQMWhPUk9RQU9DNncyRUtxU1JOWVRH?=
 =?utf-8?B?bTJyd3BCUGRWTkM2SEM2dVM5Z1pydkVjQ0cwL0VwMVJMdmpUMXhzQlVsNlVF?=
 =?utf-8?B?U3pjMU5EUzk5S3NqNTJFQlhIUmJEUncyVGh1T3lIMXQ0dlVYSHl3R0R2VHlx?=
 =?utf-8?B?eExYNjZEUmFkODZGTDByc1NnR3loRDZuNFJRN2FlZmk1Z0tNazZEdEc2Qkww?=
 =?utf-8?B?TEZVVnJQQWI4YWlvMG9tQ2VmSERwaXI2akZ3NmhpK2t6c3hHMk91L0dDT0Ro?=
 =?utf-8?B?WEhNTkhIajJVaytqUkF5bG42STc0S1paWXBsbmNzZ3VVSGRuWGVLSjBWaXg3?=
 =?utf-8?B?VXdzQjR5bFpKb1AvWmZKTmJod1pWNDUwaEFRdGN6VWpzT3lBdnh4NUl6ZzAx?=
 =?utf-8?B?SElId0swaHhQaWxuOUsxTlNCYkxZQ0ZaR2ZEQWtIYnRuSTMyZzMzUmJ4WEJa?=
 =?utf-8?B?VExnU0Rjc2VseW9Ybk5GVkRTNXlueFJxSnlONGtzdUM5Mjhvb3hhU3V3L3U1?=
 =?utf-8?B?YXBSUzBLWGR4dXUrWjRwSjA2STdScU1sZGZ2RXBHWnRVdkUxLzdNZFpCRVdy?=
 =?utf-8?B?UGJ6am1YenZ2YUpmOU00Zk4rdmtnc0wwejRMY0V0R1RwSHZjUTJvSk5qL0JR?=
 =?utf-8?B?cS9xM3Q4SXhEVE11bmgybWluL2ZyNHd5Tmo0S3RaRGJMWVcwYnBicUdQYWxj?=
 =?utf-8?B?QStSakFER1VZK25KVXR2cy9QdUV1QVFUQWc5eUp3NmhzcmQ0SHNEenM3dnQr?=
 =?utf-8?B?dzFreVcyT3hwTnNrNWpsY1E2SHhwMjRSNXdLdFRIM2ZIRWczZUk2aXhHNkwx?=
 =?utf-8?B?MUlOczlFWVY4WUdnYjVCY3p1Nkp6S1JTS0FtajdYbnV0SEhuSVRWQmpYWVpY?=
 =?utf-8?B?bEdvV3dIeW1DeERvL2RKQUFIcjZHcUs4TjhpZ0dSUFJiWHFtZkZvdW50bkp3?=
 =?utf-8?B?djRkYVBManNTNUdsaHBodVg3SzJXVmxnZ0lnU3FzSVgvOUY1TmFiOWN1OFE4?=
 =?utf-8?B?NkFIK0NDZjFXRVcxSlFwNnlzUnV3ajVJR2pIUi80Tk82dk5Ib0E2WFMxYlRM?=
 =?utf-8?B?QUlhMjk2bzRpSEpLY2VjbFlSNUlDM09Fb2tOV3F5ZUo0a3pHWngzUHI2RlZr?=
 =?utf-8?B?bHFZdmlVUzZpZDF5L1pRTmRETUwwZHVuOFc1K1NXY0lXSkV2Ky83M2tEY3Z4?=
 =?utf-8?B?dlJESWl5Sm1sckxoMDZXeUorWEJlUi9kb3dCWlcrVEJVQjdRY2VEOFVtUDd0?=
 =?utf-8?B?UituUzRGUGFXV2U0K2lDeFVCUjNCWXplT0RtcDR2N011ZDNwZWY0Myt0VE5m?=
 =?utf-8?B?NUlWZGF5bkhtYlIwUDRVWGFvbkVSRGQ3dEc3SVBISUJHbE05RW1sd00wUkx0?=
 =?utf-8?B?OExuTlpWS3d5RksxSGNac1hiVm94cFdaSUwzQ0g5TzZFTFJKeW1ndm1RZlZv?=
 =?utf-8?B?bmZKY0xWSG8xRWN3bWhHVlZyWDE0UVM1USszK0l5N0JzQ1c5cDlXRkpJQW45?=
 =?utf-8?B?UndHZWlzT3F4bnhtZld0SE03dGZIQ2VVUG05YVR3cDFDWThBRndFMFpIK3dq?=
 =?utf-8?B?eE5hUmt0T1dhVkdzYy9zeG9lNEc3WUFtZG1PL210UW1vY3pENm51T3dLdlVK?=
 =?utf-8?B?MWhhQkw4dTZ4R0pnMHNJYnM4SzNSSDlmbWpWZ05zUU96d1AvMFRGTDZJQWxk?=
 =?utf-8?B?aVRHQVI0cy9pWGEzaEpQOWZRUFBQK3IzZVYzN3dTcVNJWjFxT3VrcFF1VHdx?=
 =?utf-8?B?OUxNb3h0aVNOMi9qNUgwdDVwVXJnRlVjV2FUSzJ1a0pVNUs4bDl0WEx0SHoy?=
 =?utf-8?Q?XzQVy7tvGGFVzpLXwxloHwX2M?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05ef95b-7557-4972-d267-08db60356aa6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 11:11:14.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQjGwuHgOuhvMrB+N5x3wWYdCc5l6nZqQg89Y4mW1A9tP75NlCy/qz/bsroTcuVFXNGXy6vRwE5w7+VeLg0CHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3994

On 26.05.23 07:35, Florian Bezdeka wrote:
> There is no y2038 safe select() syscall provided by Linuy. If y2038
> safety is required the application should not use select() and move on
> to something like pselect().
> 
> As we still want to support select() for keeping backward compatibility
> - even if y2038 safety is requested - an additional pselect() based
> entry will be introduced soon which will re-use __cobalt_select().
> 
> This patch moves all the timeout related userspace copy operations out
> of __cobalt_select() and migrates __cobalt_select() to
> struct timespec64. That will allow pselect64() to be based on
> __cobalt_select() as well.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 ++++++++
>  kernel/cobalt/posix/clock.h                        |  6 +--
>  kernel/cobalt/posix/io.c                           | 60 ++++++++++------------
>  kernel/cobalt/posix/syscall32.c                    | 22 +++++++-
>  4 files changed, 74 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> index 70b3e68f9..d61b985fb 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> @@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
>  	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
>  }
>  
> +static inline struct timespec64
> +cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
> +{
> +	struct timespec64 ts;
> +
> +	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
> +	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
> +
> +	return ts;
> +}
> +
> +static inline struct __kernel_old_timeval
> +cobalt_timespec64_to_timeval(const struct timespec64 *src)
> +{
> +	struct __kernel_old_timeval tv;
> +
> +	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
> +	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
> +
> +	return tv;
> +}
> +
>  /* 32bit syscall emulation */
>  #define __COBALT_COMPAT_BIT	0x1
>  /* 32bit syscall emulation - extended form */
> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
> index dbaabbc5d..38b59e24f 100644
> --- a/kernel/cobalt/posix/clock.h
> +++ b/kernel/cobalt/posix/clock.h
> @@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
>  	return nsecs;
>  }
>  
> -static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
> +static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
>  {
>  	unsigned long nsecs;
>  
> -	tv->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
> -	tv->tv_usec = nsecs / 1000;
> +	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
> +	ts->tv_nsec = nsecs;
>  }
>  
>  static inline xnticks_t clock_get_ticks(clockid_t clock_id)
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index 45ec09fae..8d408cc90 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnselector *selector,
>  }
>  
>  int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
> -		    void __user *u_xfds, void __user *u_tv, bool compat)
> +		    void __user *u_xfds, struct timespec64 *to, bool compat)
>  {
>  	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
>  		[XNSELECT_READ] = u_rfds,
> @@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>  	xntmode_t mode = XN_RELATIVE;
>  	struct xnselector *selector;
>  	struct xnthread *curr;
> -	struct __kernel_old_timeval tv;
>  	size_t fds_size;
>  	int i, err;
>  
>  	curr = xnthread_current();
>  
> -	if (u_tv) {
> +	if (to) {
>  		if (xnthread_test_localinfo(curr, XNSYSRST)) {
>  			xnthread_clear_localinfo(curr, XNSYSRST);
>  
> @@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>  				goto out;
>  			}
>  		} else {
> -#ifdef CONFIG_XENO_ARCH_SYS3264
> -			if (compat) {
> -				if (sys32_get_timeval(&tv, u_tv))
> -					return -EFAULT;
> -			} else
> -#endif
> -			{
> -				if (!access_ok(u_tv, sizeof(tv))
> -				    || cobalt_copy_from_user(&tv, u_tv,
> -							     sizeof(tv)))
> -					return -EFAULT;
> -			}
>  
> -			if (tv.tv_usec >= 1000000)
> +			if (!timespec64_valid(to))
>  				return -EINVAL;
>  
> -			timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
> +			timeout = clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
>  		}
>  
>  		mode = XN_ABSOLUTE;
> @@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>  	}
>  
>  out:
> -	if (u_tv && (err > 0 || err == -EINTR)) {
> +	if (to && (err > 0 || err == -EINTR)) {
>  		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
>  		if (diff > 0)
> -			ticks2tv(&tv, diff);
> +			ticks2ts64(to, diff);
>  		else
> -			tv.tv_sec = tv.tv_usec = 0;
> -
> -#ifdef CONFIG_XENO_ARCH_SYS3264
> -		if (compat) {
> -			if (sys32_put_timeval(u_tv, &tv))
> -				return -EFAULT;
> -		} else
> -#endif
> -		{
> -			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
> -				return -EFAULT;
> -		}
> +			to->tv_sec = to->tv_nsec = 0;
>  	}
>  
>  	if (err >= 0)
> @@ -390,5 +366,25 @@ COBALT_SYSCALL(select, primary,
>  		fd_set __user *u_xfds,
>  		struct __kernel_old_timeval __user *u_tv))
>  {
> -	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
> +	struct timespec64 ts64, *to = NULL;
> +	struct __kernel_old_timeval tv;
> +	int ret;
> +
> +	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
> +		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
> +		return -EFAULT;
> +
> +	if (u_tv) {
> +		ts64 = cobalt_timeval_to_timespec64(&tv);
> +		to = &ts64;
> +	}
> +
> +	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
> +
> +	if (u_tv) {
> +		tv = cobalt_timespec64_to_timeval(to);
> +		cobalt_copy_to_user(u_tv, &tv, sizeof(tv)); // errors ignored

This helps in case ret was already non-zero. But if it wasn't, we are
now missing an error.

And I'm also not sure if the kernel relaxed the comment style guides
(which we follow) and allows "//" by now.

Jan

> +	}
> +
> +	return ret;
>  }
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
> index 10b080dfd..5fba3cf3b 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -749,7 +749,27 @@ COBALT_SYSCALL32emu(select, primary,
>  		     compat_fd_set __user *u_xfds,
>  		     struct old_timeval32 __user *u_tv))
>  {
> -	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, true);
> +	struct timespec64 ts64, *to = NULL;
> +	struct __kernel_old_timeval tv;
> +	int ret;
> +
> +	if (u_tv &&
> +	    (!access_ok(u_tv, sizeof(tv)) || sys32_get_timeval(&tv, u_tv)))
> +		return -EFAULT;
> +
> +	if (u_tv) {
> +		ts64 = cobalt_timeval_to_timespec64(&tv);
> +		to = &ts64;
> +	}
> +
> +	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, true);
> +
> +	if (u_tv) {
> +		tv = cobalt_timespec64_to_timeval(to);
> +		sys32_put_timeval(u_tv, &tv); // errors ignored
> +	}
> +
> +	return ret;
>  }
>  
>  COBALT_SYSCALL32emu(recvmsg, handover,
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

