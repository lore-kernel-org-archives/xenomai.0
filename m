Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EF6995B
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229764; cv=fail; b=Q6WA2otMNafonfO5Ljd2UAZL6mDQOqI2E6vp7YX2j2vlRL6m1OzhZOvymsdMI1/J5P8eYU1/XmpuDl86TG+GQjOcoV//0DMV1Id6iOKb7Zb7ts3YZrIT/6/eMuJHn5Eln08ApXkrF2QHadJCjcvatqW8URwYx70RTqkI9vEsieY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229764; c=relaxed/simple;
	bh=b8qfB13TiZostl6WHvnRInpnECI1ObhqQIHTpv9mNiM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CrGpdgKDL7pryCCWXP3EuNiLu6sgIriK00VgazTgIWBMEvLwzypznz6iJbmbKAugTmzd52qUKDdV0WHptIrQkK7NbX6XCjISbsjlGTLMVgGLyOQfimfN4K4daLfA75WVTHmYaX7LQeEM5jmGLgX5wFQ174B7snVK8frKjGQch0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Xp3TYLA8; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Xp3TYLA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIKXeFTo1gabUaOM+lQIRJlVwqOKlKvePbIZjbev6OK7vtz69GsIfAo5QDYn+yPLnBQHhik5GcA4HKm3SyCgEbpxeZFE3ZeVoCP8HkT51mPr9TUcIb71znayOHgUDjnburclL1qNvYrhNieB7UFtarQA15rRfzt57VKYLROckNeCaGI3a4qloQiEK53CDXKit3temBdWyaSk3xOndc3i6i/8OMHND1+47r9d7Pfs0kWjJ2AFixF9PmduCFhbTLgI+PCzuSo5BqA1BNkg+lMB6IDQj4SGEbNCa66ucmwKLstj7UhjrA5By+DQtBUE/91wFz4MQckldCoTyT3qf44lqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXZYHcBvFeIADGInPF8wyVez2WcVr0cKJoMQr0lL5II=;
 b=jrKtReiMRHlS+M+iKUeoOTPkbYKN1Nwwh8VaNFoZPviEyTpk52GW2307mUvRkj+F6MOEoIHyKz2L4pQDFmZxYD3TerEA9CwO9PyEfHbVDLl8b+Qh5qsID4QwocMSB9Tlb7QwUEmNLL8eFMykGhPh3FYihh6pBtOHLTxdiuI6Yeiv2hkEROQoBHyjwt1uG/i1X9dVdSPzSniBCZfbPWS9NOWQTQlEj8igAx7ALEWvzF0Ras/t7braVpsxXi+gwFaApA3RySo9yIJ5rViElLrgTP5uZWuS2ySfpgmAmHoEjnhFjOqB+qrH/saGkf+mqDxnGyAwmchaZjCMS6czmsKaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXZYHcBvFeIADGInPF8wyVez2WcVr0cKJoMQr0lL5II=;
 b=Xp3TYLA8aB2zhBt9+rbTvAWyVFQM1bloiq1d7bylKs0vKriTI8nEjqhpPDBwmue2I/r5qeRLmDaW33JH7GlEJtdlEGz3Sx4NsY/nsdxiQ5IOoRfAf/bM9M1ftn59GRhaMa5zxvLTM0wPmXRPMDhDpjoPQ9p3q+QJficrOStOB7xFgQ67ARgMUUqpTKbBcauzeZdNBiyVR+mwAH22pgfgqH3k4PaIKGSJ6d31PyxvWp00OufqZOkoAn1byP7SryHyYY3QwxXbzTUZeW8jWDVm8tfqkVJMoyvdxZKzSqHARNfBZmW1lMdzEZxa70GRJFdu9YqV6Hs1wNmnuPB6jg4Zfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 07:49:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 07:49:18 +0000
Message-ID: <663887db-5cfb-4a5e-bf29-ce2c2ccf1093@siemens.com>
Date: Tue, 12 Mar 2024 08:49:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/gdb: Fix race-condition
Content-Language: en-US
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: eebf974b-a2bd-49e8-b6e4-08dc4268ec0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rwd7+1ziEIuWfAqBpgMTc0+QwyKvQDwOrc/+juSacfIlF3/flW1gxIHBQzhATpDeZXFOqL/xbt+ugRHMLP3qKeK6zvUZQbHwDfPR6Ww9mJ0ToEBCapHKGfT6WexajD39k62oKa4zAc5nm9uxKPpreqWElQwtLmCDLpckxsDfr7qT2W7AdM8hR9EF27+NBJR7TCtebvhJ5L3UX4EWuFm1/1LXGS5HrAn73vOAX1EIplMagTWM5og7KkafLe1icvEG6u1I8VGlSeMVie2MLQ8lETEfPlZU0h6oUp6ZznGjGxhEhPHs1fdDdtvnjBecIf4RvUk0jwM9g1DDtVW6QHrbo8JZYeqHXgHR7uUwvnyw6GRlL2k2EIDwdSXl8f+cD3t65KBYkDTwk1k19w0rOejIntgn+6boKLs9ahehrc5HFzTp5SP+M5+3Aiidk8Q906VdfE4LRVJllH4Rxu6u05GjUjldl+IXuzHLXuxOdxek45XuSwV30Kf3Y6hnw4EHU8npRGJBoVbfScp+l0DMaFW0g+3pdl32FqMYqwYACsUTxFF0pFq2Jq8cGo7oQEsZDytKNb6Vu2vUNpXkbwxx7z61ayekYoT9Z2YVkPafxgGBu6YPbzcpt/t4VkOpkO6L9SJclIA0Q+jhnghCEO8fnKbzNaVRhDytJgaiw/Jtlg4wrE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEluTlJOS3VHTVJiSDB4VGN3a0NDWUl5c1A1d090eWRkaGJJaDZCV1luZURw?=
 =?utf-8?B?UmF1RWdDM00rTEJZZUZxbjJkdzg1YUlrbi9vdGYwdElxa2wySTBLSVhoeFBY?=
 =?utf-8?B?b0wvcmVqQ2lzUHJRQ1gyWFZSWjFzbi90R1lCWWVsRC9vc0ZMSDJPYjNEeGlo?=
 =?utf-8?B?eGVzUG5nWUVXSmFoeXM1dk13cDZaY3Z3YlJDdVJVVjFmR3JMdGUrMjVhbzZU?=
 =?utf-8?B?eEJlTzFGaEo0UzFnazFaTWViVE9jZEVMRWIvRHJ2Y05tbC9ER3hPSjBQZVZW?=
 =?utf-8?B?TVNmK2VSdFpja2NMckExZU93TXFkMkNHT21XMnpWWXo0NFU4My9aSFpKNmxW?=
 =?utf-8?B?YUY2bysvSlkvQ1NibTAyMy9hRnd0dEY0NVNwWU1Vd2JHOC9KQ0t2Ti9CSGJB?=
 =?utf-8?B?NTQyMWZNUE02RXdJdnNucXArT3kyNm4wNTRCVGFYeHFYbUZKUG5BSGZUTHRx?=
 =?utf-8?B?c2JuZlcxZkkzR1IxelR4VFgvcGJqYWdWL0I3RXNUZWE2VXZpMlJERWNyMnVv?=
 =?utf-8?B?eFcyRktWUVNmOVhTTS9UYVB2U3pGcUdlZDFaM1lYYmpUbHlQcGM4eGtqS3JP?=
 =?utf-8?B?UmxwcEhTbmlZNUpjU1pTQzhISXdzUjc0L3EwZWZRV1pwcUMrKzJtZFFXQVcy?=
 =?utf-8?B?czhjM01iK3ducys5ZWJXNGVqdllQMnVqRU5LMnhjQVJuNXVPRURsQjU1ZFJv?=
 =?utf-8?B?NExoMjVkUE5MdWFxdkhQVVgydkFPRmZoY0VkWUk5a1d1SkdYUCtnbmVvL3BC?=
 =?utf-8?B?SCswWlMzamI0OHFOZ0NpaUd5M05hYmhOUUdCSHpDWDlqcmZOSVFRd21EU2d6?=
 =?utf-8?B?bVM2NFZmd1pGK011c1pkTlN1aURyMENtTU9vSDdvUE5zcjg1TFBMVVpOSnF2?=
 =?utf-8?B?V1B6aTk1S3hKOW0wQ2c4ZlU0Q2tYbkFNS002WWw5VVE5bDlYYWxNNXBNNDU5?=
 =?utf-8?B?elY1WEZvbHYveFZVd0UxTjVSM2RYRWtYT0dJQSt6UEM1Qm5SS0lrMUVUYThP?=
 =?utf-8?B?dUxmWWliakpKMU1hN0prRng1MkZRSFJMM1RHOEZQN2ZWdEF1YjZhd0kvZEp0?=
 =?utf-8?B?bW1mUEI1djkwMjZqSVNxSWpQenFGaEk0U01aTHp0ZTh6Q3ZNbnhiUG1PdVQx?=
 =?utf-8?B?eEJndEgyeVFCdEQwTGtFUDZwWXM1YjlBVUprN0RpWDZRejBWN2dyUG1LWUFE?=
 =?utf-8?B?bmR6NTFOQ3JseGwrQko5eStkNHRTakwxV2ZLWnpoNzg3TGhLS2FvbVJXLzEx?=
 =?utf-8?B?YUJQK3p1UWwxay81eFBGamUyQllzU1dvblZKUTkyRVhrWXZuWXM1b3l0dm5K?=
 =?utf-8?B?UW9WaHNFbDBpQlVsRFBERll2WnhTVS83Yjl3UDVYR1hadnY1OUdvemZzdm8z?=
 =?utf-8?B?MHluVzRyZHZsejNaQld6eVVwcmJVOTh6Y3FhUmY5NWNITGszRmx0YS80Wm15?=
 =?utf-8?B?aHNaTHM2VkplOFZJOTROUHV5WXhzcmdMU2x0VnJrdG53WmZsSTJxcjNFU1Vr?=
 =?utf-8?B?cGlEckdlcHIxTVV4L2U4cWx0Wm5qZWxjQllCUXBKRnFKdEZQZW8zaHBVL3JS?=
 =?utf-8?B?Rm9FODZpVkF4TWI1eUNYbE9ETis4L0lMK2hpMFFyeXllOURJWVltenQ0STNa?=
 =?utf-8?B?VW12QldpQ0g3VWVCK1crNW9GZ0ZSTE9jc0h4VTRsK3I5YkViYVNEZnBVd2pa?=
 =?utf-8?B?eWp3aWtTaDRWMXRTci9nb1Izdkp6SEVSM0cxVXRiM0hWYXAzTEZsbWxzeVFX?=
 =?utf-8?B?WVdOSHRqT0h5Y2VYMnMrSytsTXhqQXYzbHBEcjd0UnJnOVhxOWQ1SktMNzF2?=
 =?utf-8?B?R3l1NVRMWTlDc2pKWUpFQTd2OGNjRVFvZFh3WUJ0MlUyYkRzS2luM2o2NWJY?=
 =?utf-8?B?WmNKUGVvSGR0T2VreXg3QlVzZDlCeVhrbkpXb1E5WUs0QklOZ2FxRDFEQWdC?=
 =?utf-8?B?cGlSMnM5eHpTVnJVMUdKY2FIYzdVdzdOamJURGtzWGVrZjFqRzZEUE1iZ3ov?=
 =?utf-8?B?alB1S0tYelNBOUFJbityei9TV0VCQ3ZUZXpnakkwUEFRK0x5a29PMzJWVEJw?=
 =?utf-8?B?Z3QwOE94WDZxdlRjR3NZbmZ4Q2JieVh6aTN4RlgvbkY3RlhEOWJuOVp5UGJn?=
 =?utf-8?B?NHVKZ1RnNXQ1N0Q1bVlkL0xyU1lKVTdoMm9SRGdwZk94M0lOb3hKUjZxNUxX?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebf974b-a2bd-49e8-b6e4-08dc4268ec0a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:49:18.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+B57cnvHtD4KzH4CkpLRlo31IQ1TE+rt4rfG1ntbj89LRwxNWsJ2Ap1bmPFRDIVsmCzdZX6dFNyHj/4YIlT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8300

On 12.03.24 07:38, Fabian Scheler wrote:
> When quitting gdb by sending the quit-command, gdb may actually finish before
> the father-process calls pause. In that case the father-process would wait
> endlessly.
> 
> The fix now uses waitpid instead of pause to explicitly wait for the
> child-process, in contrast to pause waitpid also handles child-processes that
> already have been terminated.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  testsuite/smokey/gdb/gdb.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
> index b09b78b4e..5e9e9d101 100644
> --- a/testsuite/smokey/gdb/gdb.c
> +++ b/testsuite/smokey/gdb/gdb.c
> @@ -77,8 +77,7 @@ static void handle_sigchld(int signum)
>  	wait(&status);
>  	if (WEXITSTATUS(status) == ESRCH)
>  		smokey_note("gdb: skipped (gdb not available)");
> -	else
> -		check("gdb execution", WEXITSTATUS(status), 0);

Why do we have to remove this?

> +
>  	child_terminated = 1;
>  	close(pipe_out[0]);
>  }
> @@ -202,6 +201,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  	pthread_attr_t attr;
>  	char run_param[32];
>  	cpu_set_t cpu_set;
> +	pid_t childpid;
> +	int status;
>  	int err;
>  
>  	smokey_parse_args(t, argc, argv);
> @@ -257,7 +258,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  		err = pipe(pipe_out);
>  		check_no_error("pipe_out", err);
>  
> -		switch (do_fork()) {
> +		childpid = do_fork();
> +		switch (childpid) {
>  		case -1:
>  			error(1, errno, "fork/vfork");
>  
> @@ -283,8 +285,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  
>  		default:
>  			wait_for_pattern("(gdb) ");
> +
> +			/* the signal handler only is used to skip the test if
> +			   gdb is missing */
>  			if (child_terminated)
>  				break;
> +                        else

Indention via spaces here.

> +				signal(SIGCHLD, SIG_DFL);
> +
>  			send_command("b breakpoint_target\n", 1);
>  			send_command("r\n", 1);
>  
> @@ -301,13 +309,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>  			eval_expression("thread_loops==expected_loops", "1");
>  
>  			send_command("q\n", 0);
> -			pause();
>  
> -			if (!child_terminated) {
> -				fprintf(stderr,
> -					"FAILURE: gdb still running?!\n");
> -				exit(1);
> -			}
> +			err = waitpid(childpid, &status, 0);
> +			check("waitpid", err, childpid);
> +			check("gdb execution", WEXITSTATUS(status), 0);
> +			close(pipe_out[0]);                        
>  		}
>  
>  		signal(SIGCHLD, SIG_DFL);

Nice catch!

Jan

-- 
Siemens AG, Technology
Linux Expert Center

