Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57D3D9E
	for <xenomai@lists.linux.dev>; Mon, 29 May 2023 11:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxCKpR04mLPXoa8lezyOW9Y+rQYkwsBSxWugnQwgNO625kdSgfSIEuYeZCuVETxNpCTCL7xmqOG2JqSvb6UipYjXYDAUgkjfvjI5of5qZDiab0BtvzZYkUexoaVG+TKUHwdGYH5gkrxrYZsL6eG0fw8NpkyzOEyRSwJjr72uPg1dPj9YblXUsaD5o/QAIH98N6TBMU6On1w5OLQoJQ3JF3aFnVFDART1TFN0r3KGa2uJKjo6o5ZjQNnZrSeHheG3PtNbQWzjKS6vjSXGtofGpBX3bSxNuLwLOuhl2euP8GSubMbg5Ft8MkboKt5zmxED3vRU9qx/jxHjIyqnWiRPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgDYCucvUQA8j04NZ60UvnHE66/gY528AX9vtQ8sry0=;
 b=M0VrwHjaFnVNKRYyAGuQQcZy2rHZbQaBhzYgB8MjVKEy06E1HudleiVPp7ouat4cYxtGWYeNKPhIckshs8LWHhl0OfvNxbMgELPMs3ta9s6tF0DSXygN6K6fqqypG+95gsNhr0cZiEZy+asPFOU+xMRpN+QoUGKS9WTsNdmKY1GJzEsO3GyJQi1AZJ3jEn53nAMeDOZLx2WRJ6tbGfplMKacofsrKYkup4D9brES5c41yC+Il9QpRZ4Rmzlrzgm8qnqS+1rZcOOvID3Qe76rPIGwcw2pihy3gDP30Sa8QojKk4CVCukBS+6/lbg2f6v5jqwr4nReIGUqVTiXRQmGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgDYCucvUQA8j04NZ60UvnHE66/gY528AX9vtQ8sry0=;
 b=yZ7/VlpyuVB6S5P+CgHv7L3koCsGnVdiptcQ3nz7ykDzGs3jVEK+Ft3kP17e6NBuwFpz1FPfo3BkbqzLHhX8el/4PHSEi+6qnMq6In5R9yY95X/lYy3H3YZNol2vi+C/cvZH/p17+LnatdAZ/iMOWqK4BI5LoGwIxxpG4w2YjBLcwv4/dpa/J6c4ZCe8kaR8kQfzxUE1w72+V23uuNpJvDnKh73s5rXdZcZEZoklfiho1cZNSZvTMzsRtjMZxlbvatonoZ1c0ot5xpTA1EDcFObI4SFMjq9sN4bTUKboHIyhOrJdORfwfEXpFda9cWffAn04HAke5VP6CW8vnggT4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 11:19:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 11:19:34 +0000
Message-ID: <b14d0870-d9a5-e53b-cd68-5b86c325edad@siemens.com>
Date: Mon, 29 May 2023 13:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] cobalt/posix/select: Fix timeout update in case of
 -EINTR
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
 <20230516-florian-y2038-part-three-v2-4-3fc689b21a32@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v2-4-3fc689b21a32@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 8831b30a-2c72-4cce-1cbb-08db6036950d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1jb1u674PiPTQTyfJE/qsP1tUrzDIiHsG/tyJDvfOP7hGeXvfDi+hD1MBMiwDAOtrzAXDnbJ5p2Weurmr46TgIPPRhgcCDLdOMXiexIU0MZtrvvcxE1mEcOWq2yIQadbURXXCZGAL94LOJYQQUWh5xbw+bZiAjbagVYHRIZXpvmFz09gIIc4rlq/GJ6C/UsHwzt1YHnyDFoYYpO/cJY/L3997dczWFhuIa86mCMkD0ilQe+nTnYI3xtOeqLWrNmLh78aKEWwCzx0wo8eG235ZRTjup9NITmdtJGslHD+OF6cQWmlqah4jKG2BBVSie5TRT4tgUTJBfti8h0e1fgM3XPyxuVrM6+jvR3OflRtexPmQ3QRDu2hqAVy7Y+WUUcvA4aHcgQkJ5wtxkaRFLLgMzclCEQgDVZAX1wLSrws+NSFRvy8CEEreJgbbw6qoUZIH0izmpdVD3+VvJcEe/ZxmCIPpYzJ5fjHXZBKturryi5FVYRveVkEM6OZVlB5T9r8EnHoxFOYXVnzA8ikUGlWEW3Z1q04V76rgoUYdEjY40HlSUAAe/Fl7q8hMIvlpnawiUH58AtkPRZ5zvxg22yur4EawmFekCw+QoiPv0eDVQ5ad/VZ+tdHhevPdMa4UjufaNJq7yxpKNFHocBMkodpIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(31686004)(5660300002)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008)(8676002)(8936002)(15650500001)(44832011)(31696002)(53546011)(26005)(41300700001)(316002)(6506007)(6512007)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRCOWQ4a2N5T0k3YmFxbFVja0pqc2x6NStWYVJuMlM1QzNabFlZbi9wRjZB?=
 =?utf-8?B?bmRlYlhHRWVXK0cvM201NW9QQmpjSHRNUnUyRkFZL29IVjZPSjUzblpLV0pt?=
 =?utf-8?B?bVNhSGZRTVR0cmtJV1VUNVcrZitoMTVzbWRqWEZPaEUzRWpqeUFSdk9OL3Bz?=
 =?utf-8?B?RHg4YnUwY0pWbzBJUFNlTVJVaXJTMm45a1QwNTBNZzVZS1k1N1RaWnljZnhQ?=
 =?utf-8?B?YnNBbE5DRmxOUTFhT1pWcCtjMHJBZ0hSakVlQnR3d092UkJmSzYwclZlcEU3?=
 =?utf-8?B?SC9ZdmZoNkNDeTBBcUJhdjVlTmZkNDJXMC9WakV2VWFSM2tjNURIOW9aVmhv?=
 =?utf-8?B?bTRPeTdSMk1nS3FhOFNkMWlIRXhJa2NrbXNyczlJMGdqVktiMG8yWHhURWNH?=
 =?utf-8?B?NFFTWGVVMzk2WTdwamdiVlFVdzV2b2RRSlNTT0xiTU81ZWtOZU83dE1oaHYy?=
 =?utf-8?B?T2xQS216S0t6Mk5VbGd6eVhQVmV3NWswVGs2WFNPSlNoekgwR2VNZ2R4T3RO?=
 =?utf-8?B?dmloUnVOVXp2K0w1VHZTSjJGYkUvaGxoL3h1NnVWT2h4MXl0K2hKL0dxOUpM?=
 =?utf-8?B?T3hSaDFRT2VnM3Zrb0UrZndGaGNxWlc4TmY5Z3lnaG1vMEV3QWpxRTMrZlNL?=
 =?utf-8?B?ZEdhWnFCNWx4Q08ySkViUENvSnlHNU5KVkdIVm0wR1hpc29rMEY3QytGNHpW?=
 =?utf-8?B?WlFqTjZCSmFWYlRYTUFOSzFVeXZLd05ZRWFEcDNFcENpSWs5SHBGVmtBcmVO?=
 =?utf-8?B?ZExVa3VCTXJzTXdZVW02WktINkh6MkkwdHkwbSthMzRvdTJRWnJwaEFjSVJx?=
 =?utf-8?B?ZlI2bUk1cW41NkZsWDVNYkQ1YmZxZ0xJbEhiNm1iSDZQTkxXL0pjaUxXcWFn?=
 =?utf-8?B?aFE1MmlScjhzcFZTb3I3MUhJc1N2b01mcjM3L3UwcWZJSTAvU1h3MFVzUVBS?=
 =?utf-8?B?M2JQMkMvMTkreU1XaWdleWpaOFJTRzVwU0RsM25PMlFoOFlWMFhyRS9kOTBC?=
 =?utf-8?B?VDl5TnNwV0JzMkV4eWt5QlV1NEdrWUx0cytYQldpR2RURjBJdW1jYnFTVGRw?=
 =?utf-8?B?YjNYR01idVRZdjVscjU2cW9xUlo1MzhTZzJEejRIQnFLbTZ2bitjbGpNZDBD?=
 =?utf-8?B?VmJNV0VQWjdCZVVvdUE2UkJUcGxNUkgrOC9ZSEhNcG1wQUVNd3plS3NUWUV1?=
 =?utf-8?B?UDVhdFprYmJrMUl4Vm1wcWxLc3ROZ1pkQ1RKL0RFZXF5THRjK1hYcEY3MEJ1?=
 =?utf-8?B?Qys4L0szUng3VVNoOVRkdUsvaUJiVVBRcHg5TDIydWZab1RpS1JoSTIraGRQ?=
 =?utf-8?B?WGw2VnMrL0pUZTJVZHhoMXE0NEtPRlhmNkJWOGY0ajlMZGNDUVNHRUM2cWZS?=
 =?utf-8?B?QUkzMTNaTVd1R2Y0Z1dwVDJ3cW80QTJROEpBUDlxUFhtOXE5THZZcGx5WDZG?=
 =?utf-8?B?T3ozMkVPUmdlalc4MGFxeStJWWgwMC9GUjFYbDg3RmRrbEFtcVBxZW5VQTRY?=
 =?utf-8?B?ZElWWW9uQVh6UFNBSFI4UFprVFZWeTBXUG4relFGSmJjNHZqeU5Ib2VQY3ZH?=
 =?utf-8?B?Rm0wTmtNQ3N2bHNDOS9SZEJLU2VPQ2h1dDlWZkpnd2dGS09RNDJ4TVNWNU1a?=
 =?utf-8?B?aFVFeStWUlYrQWlUd2JTd0ZrS250SUlWQkhNRFp6Sk1lS0pYeldYdzlwRVhx?=
 =?utf-8?B?TGhVb1hybVhmN05aelVsQStPNU1VTi9Hcll3VzN0bllrUDh4NEtyOGZBbnE3?=
 =?utf-8?B?U2ZnL3N3WVJZc0M0eFQvQVppMnBuYkljbWVZT0RKZWxJbjZ3SmdHMS9VRzl1?=
 =?utf-8?B?NzdDaWkwT05qbnJqR0NlODhoT0k3TDRna1h5NHNzRzJMUGg5VGdxcjUvRXpv?=
 =?utf-8?B?MjR6dVFnMG1HckZOc2hNeWliaXB0TzZrU1c5SlNYNDJZUDQzcGxqbnRGVE1M?=
 =?utf-8?B?MUhZWkFLS2ZXTVVwcXJjZGhJU3ZHL2NhVytOOW53RmlsSzcwRzBETkx5UTBh?=
 =?utf-8?B?V1BZcERIK29FQysydTRDU0h0aGVUelp5disyVEZiTEREOWwyZitjMmR2QVhW?=
 =?utf-8?B?L1VwRUJ1dkZiS1UyS0s0MGk1R1F2QkJWYjM5akdZbDNuZmpJZzV3dno0Mi9v?=
 =?utf-8?Q?xrYlHyka4Ra6/2BdYF5oTy80b?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8831b30a-2c72-4cce-1cbb-08db6036950d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 11:19:34.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+glo4M5n3r/0jccg6rt6Ap2ygvoqQOm3flbPiMDyU9bxL6lYmdO6u7B6TcSMfPC8mnPu2/fGwXDtMdvDQj22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8003

On 26.05.23 07:36, Florian Bezdeka wrote:
> When the select() syscall was interrupted (e.g. for handling a Linux
> signal) the supplied timeout has not been updated. __cobalt_select()
> bailed out too early.
> 
> The testsuite has been improved to cover this case as well.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/posix/io.c               | 18 +++----
>  testsuite/smokey/y2038/syscall-tests.c | 94 +++++++++++++++++++++++++++++++++-
>  2 files changed, 102 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index 42a9b6208..beaa8fe63 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -319,6 +319,15 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>  		}
>  	} while (err == -ECHRNG);
>  
> +out:
> +	if (to && (err > 0 || err == -EINTR)) {
> +		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
> +		if (diff > 0)
> +			ticks2ts64(to, diff);
> +		else
> +			to->tv_sec = to->tv_nsec = 0;
> +	}
> +
>  	if (err == -EINTR && signal_pending(current)) {
>  		xnthread_set_localinfo(curr, XNSYSRST);
>  
> @@ -329,15 +338,6 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>  		return -ERESTARTSYS;
>  	}
>  
> -out:
> -	if (to && (err > 0 || err == -EINTR)) {
> -		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
> -		if (diff > 0)
> -			ticks2ts64(to, diff);
> -		else
> -			to->tv_sec = to->tv_nsec = 0;
> -	}
> -
>  	if (err >= 0)
>  		for (i = 0; i < XNSELECT_MAX_TYPES; i++) {
>  			if (!ufd_sets[i])
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index d1e1f46bf..af27f2bce 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -123,6 +123,7 @@ static inline bool ts_less(const struct xn_timespec64 *a,
>   */
>  struct thread_context {
>  	int sc_nr;
> +	int sock;
>  	pthread_mutex_t *mutex;
>  	struct xn_timespec64 *ts;
>  	bool timedwait_timecheck;
> @@ -1443,6 +1444,94 @@ out:
>  	return ret;
>  }
>  
> +static void pselect64_sig_handler(int sig)
> +{
> +	smokey_trace("pselect64: signal received");
> +}
> +
> +static void *pselect64_waiting_thread(void *arg)
> +{
> +	struct thread_context *ctx = (struct thread_context *)arg;
> +	struct xn_timespec64 ts;
> +	int sock = ctx->sock;
> +	struct sigaction sa;
> +	fd_set rfds;
> +	int ret;
> +
> +	FD_ZERO(&rfds);
> +	FD_SET(ctx->sock, &rfds);
> +
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = SA_SIGINFO;
> +	sa.sa_handler = pselect64_sig_handler;
> +
> +	ret = smokey_check_errno(sigaction(SIGUSR1, &sa, NULL));
> +	if (ret)
> +		goto out;
> +
> +	/* Waiting for 1sec should be enough to get a signal */
> +	ts.tv_sec = 1;
> +	ts.tv_nsec = 0;
> +	ret = XENOMAI_SYSCALL5(ctx->sc_nr, sock + 1, &rfds, NULL, NULL, &ts);
> +	if (!smokey_assert(ret == -EINTR)) {
> +		ret = ret ?: -EINVAL;
> +		goto out;
> +	}
> +
> +	/* The remaining timeout has to be less than 1 sec */
> +	if (!smokey_assert(ts.tv_sec == 0 && ts.tv_nsec > 0)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	return (void *)(long)ret;
> +}
> +
> +static int test_pselect64_interruption(void)
> +{
> +	struct timespec ts = { .tv_sec = 0, .tv_nsec = 100000 };
> +	struct thread_context ctx = { 0 };
> +	void *w_ret = NULL;
> +	pthread_t w;
> +	int sock;
> +	int ret;
> +
> +	sock = smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP));
> +	if (sock == -EAFNOSUPPORT) {
> +		smokey_note("pselect64: skipped timeout write back test");
> +		return 0;
> +	}
> +	if (sock < 0)
> +		return sock;
> +
> +	ctx.sock = sock;
> +	ctx.sc_nr = sc_cobalt_pselect64;
> +
> +	ret = smokey_check_status(
> +		pthread_create(&w, NULL, pselect64_waiting_thread, &ctx));
> +	if (ret)
> +		goto out_sock;
> +
> +	/* Allow the waiting thread to enter the pselect64() syscall */
> +	nanosleep(&ts, NULL);
> +
> +	/* Send a signal to interrupt the syscall and trigger -EINTR */
> +	__STD(pthread_kill(w, SIGUSR1));
> +
> +	ret = smokey_check_status(pthread_join(w, &w_ret));
> +	if (ret)
> +		goto out_sock;
> +
> +	ret = smokey_assert((long)w_ret == -EINTR);
> +	if (ret)
> +		w_ret = NULL;
> +
> +out_sock:
> +	close(sock);
> +	return (int)(long)w_ret;
> +}
> +
>  static int test_sc_cobalt_pselect64(void)
>  {
>  	long sc_nr = sc_cobalt_pselect64;
> @@ -1506,7 +1595,10 @@ static int test_sc_cobalt_pselect64(void)
>  			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
>  
>  out:
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	return test_pselect64_interruption();
>  }
>  
>  static int check_kernel_version(void)
> 

We can do this, though the manpage states:

"On  Linux,  select()  modifies timeout to reflect the amount of time
not slept; most other implementations do not do this.  (POSIX.1 permits
either behavior.)  This causes problems both when Linux code which reads
timeout is ported to other operating systems, and when code is ported to
Linux that reuses a struct timeval for multiple select()s in a loop
without reinitializing it.  Consider timeout to be undefined after
select() returns."

So, this is not a critical change, just one that aligns us with Linux.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

