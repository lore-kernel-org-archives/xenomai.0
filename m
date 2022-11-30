Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1567BA51
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 21:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU62WKUWA0HodFcHkpOvz0gWjlh6+VvtbggvZCZZSitP4WEqlf98aoPd4kCN+6djVhEhdCW/5mL70G1szCapjHtyTED5zqWfV4KZsJYyd0GIbylSlnJXF+RRh8W+T/8lo+SMW9z4GFQJheHBVsJ6ecJ50yP72Ln3ZLF5R5mhWbhCKFFhr86EbjwUnlgk0u5v395xnoTrg98JBNXbIVUZGwmjfpcii6+5ScxOzXcDovmDIJEY+F3meJF7YgzEaEvQObE8rBwryCY309lMx7X+s10fPDNppB4Js6e9ew3eK+6H0fA5nidCxTRX7ZM9vmVWWMtgdh97GO04pWISGU0NrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwhLC+AmpLc2SQxR1+wfspQOwR0G/XKoOQjxeShmTG4=;
 b=gITCRkzA1ju7roVFSNJ57IMxC32GJ0rsQgiy6qrkuOvmLwDyBwi36jTI+Pl4LgTTSzZEGDJ+9XcPAlUYExMRF5IiiLuz5UV3xFX7EStNGCVdHD4Bm74Ok76uAV9/Jr8gz/Eo5nRGHnKLY5lFxrN4BOZ/INt9aheAhbrXBsN3UJ3YsleD9Z/HyF2o0DKseytOo2YxvlOrOyN/VV1qFkrm0QDFCV5AjQc4n6zpCvYAL7rGDGXCjgsw38wTzmpaesNiv7YW3/Tuz8urVcHRI3+4ql9AMY0clcekHHsJ1PSrAP+Q9RRrn1rKAbYyZdFYOoBD5Y4t4tkphsp+kA1g8txjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwhLC+AmpLc2SQxR1+wfspQOwR0G/XKoOQjxeShmTG4=;
 b=tEAFW/Q6OLzKdW/yJ1+j0DRWxjTDQInN4BbOxeXMm+2syETbsHrfk8yWlefBdf/apKkglrnDbLr79d4Ncif7rH7DDCdMhEmRHC3kYbKD6L/Rh1O1yArKMmSfXx9G0yu+wc2ptNZN2yUGPU6lsgM5Ng1nvnFebfnwdvd/fmolwQ8rvxTsLth0j/UcaRP9tf2pV3ZfRzWyHbK4sfjDCntb3Jf01VSIyv5kabXKY/zDfhmxOM3Z4A4zCH8ZRbOH379hUqxBx/eT1gXDSbfvn9z+SifeDad6nHKA8fEDGXhko0lTBXHWJT1U3mxx3Vi6hODDLHf4nQo2j8/x2ijwVMa4ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 21:39:10 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 21:39:10 +0000
Message-ID: <08212b2e-8084-a48d-f2df-c83860536c29@siemens.com>
Date: Wed, 30 Nov 2022 22:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/5] switchtest: test multiple secondary switch cases
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
 <20221130141134.2503172-4-tobias.schaffner@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <20221130141134.2503172-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AS1PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 30338e6b-81d9-474e-bf62-08dad31b5115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RJc3Rl4IX1LkoQnIwQIFq1QGMBFq8nqpMu1KKYZ75vYFn9iiYh8jIorLtQzDgcv2oa7Kqc3YQ7FQPJl1m7BB1GSD9b0Am+DlSV4LW2i9sd8u4xRNd0EeMCjKnDS2aOjtOST0+5ejjL3fuo5OkTbuzSScrwbZxFePVso8IAJHi1pgcWEpYO9EtZRFiRRM1/4XkhqFAROzWu062EO97241pKonxTHYzFx3LK+WXqDkIN38bMa1uqoTBYCucx91k+7sBeY2r4qzZK5J9os1ckxnZHYp5AWeEMdE2sDnF2aYOV0b2MtGPWffC+Y4LA0Gxzryolp4Xr48SR2cRCxWSH5ZoZTXeQ2k2ZW2kNqe/N/vNPFlOZYDzkjSIYB2Qz0iIsdwT5HAXkwQwpIn/XCDH3JBd32KUCnKyRUlH6hFqfbKMEPD4BL918P92XCMnVy6W2deMaRbtOQ2nf5eE/KDrNYU+fcSPZCEXsL7PmafikEFpBTLGstz8tqcGYa6QktYAGXRxmow3UVlVqIPyqqqnNpqKVaHbC1vGdsZ5MbuLlbOfoKx2gp8xzKfucQxC8NE3GJYW0h1RlGQV/R7uWbJ48gpNB9D4GLY7a/DtlxWkM+aHhUZJxrEJpbpKoHnOHZqlEPSit8QjqK39iKY9vfXxczGJBcnnBL89yoJx1om2PEyBn6L9cUTLGKORWO6YBzmm28XASr5CgXPCfdIFJXfwZQEhGTxXLwhOic4HFM+jBDlra8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(107886003)(83380400001)(6512007)(31696002)(86362001)(186003)(5660300002)(8936002)(44832011)(53546011)(6506007)(36756003)(2906002)(2616005)(316002)(41300700001)(31686004)(66946007)(66556008)(38100700002)(66476007)(4326008)(8676002)(82960400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eml0YkhxL2orNDJIa05RYXpFSnprQUxGRW5RRjh3YTRVbjlFOWFUc1VoUzBN?=
 =?utf-8?B?TmxETW0yaG1oOXdVdmE3WDlDUmRPeThuK3QvWE1SK0ZjblBZODZKZytEdDl2?=
 =?utf-8?B?M0NPdVQxY21zSjRJa0MveVlKVk52SkF1dTV0MW1nakN4aUJKdUdTaFU2bmFt?=
 =?utf-8?B?WjlZcmduTXNEZ3BMdGp2clFHUVI4Wk14NXBIMG1uaUFUVTl1YnpaZHJSN1Zl?=
 =?utf-8?B?MU8zM1ZqSVhER21LdXNxdzNkSFhtS3JmUTRVOWRHMGQxZGdQOHNGcEZkOEI0?=
 =?utf-8?B?czdwVVNFVEdZK2h0Z3pHRlhnNkk2TjVuOXFSWkVybHh0MHJ2djhRSXdQV210?=
 =?utf-8?B?RktRS09tRUxaeU9KQkNNL2tyZkw1YnhkZG41WXQvREZRcTBwT1NJeXp3NmxD?=
 =?utf-8?B?SG1SakxONkFLR3hTWGpvNDRTYzRWc1NmckZiVExHYVVlMGZwTWtlM2ZKSGtO?=
 =?utf-8?B?NlBlMGhtQXJKWkNUbGh3eVAwUEVXODBLcXF0NElaa1IyUFJERlVXS0lkdTlj?=
 =?utf-8?B?WTU1Tkw1ZDI5L3dXNC9sRkpTS2g1MjhzSjRXTHRpK0ZzeFh3SlFUSTBzR2dt?=
 =?utf-8?B?cVM2TmZkQnhWeFBIM01PTXRzWW44Lys1Wk9rNkVoeGJwK3ZzS21LcWNKZFF3?=
 =?utf-8?B?SlhMeE93ZVJlaUdTdk5yNlZZdk1yYU5NblZCeFdEbWg2UEw4UGVjZ1dlSVR4?=
 =?utf-8?B?K2RIREtTWUdIZ3ljMG44NTBzQWxNejc5cFhLUjZJMEVoUi94WEJrRGwxYWsv?=
 =?utf-8?B?TkVUTUFZcFY5YWh5QjR3cU00TnZsZm5lYjNHajNvUzl0dmVhT3kraW5obTVa?=
 =?utf-8?B?TmZOWTZLTFBQQ0dNTS9tUWRVK1NtTzJmWEIxYlRBM2VxaXZsK2kxU1ZPZ0NE?=
 =?utf-8?B?TStYQ2NidXpraDhnSE5UN3JYSm9KYXdidzdBcHRlditGTmNWcEIzVTlrdlho?=
 =?utf-8?B?OUVnMFprODJRcGk5TlVNUmsvcEcrMEdERVAvR1NZOEZTNE9vQldrWXhQSXll?=
 =?utf-8?B?V1RKajc3YTN0Vm56QTkwQmFsMWF2TC9peEFsT3ZYSW9uSksxZUNubUN0dXNa?=
 =?utf-8?B?YlJsTmtlYlhKY0hCQUhuVCtYMXpjSUpWR3FNY2pOWFJta0hubmxaR2diLzMv?=
 =?utf-8?B?dy85a3NOTDJtZk80Sng5MWQ5MzIyQzVyRzRSejdvWWlWUG1tbGxrS1RpblJw?=
 =?utf-8?B?Z2xVWm1hQ2lKckJzS3JVOC93Q0JlQkw0bVRWUE1XaDRla0dpY0pRODlaSHFH?=
 =?utf-8?B?Y3B6N3FuYUhsRzhha3g4S2poaldLem9pMCtORHJpYm0zYnljQXJHcVFCRFFY?=
 =?utf-8?B?WUFRQm8vYlVXWlF6SDdTa1J1czFwcitqMUxIVkp3aFo0SUNvdGJaMlNtMGtw?=
 =?utf-8?B?VXpPMVh6MnFHazUyTnBmS0NWd3dCbkZhQUNRaW1pMHFnT0NEd0JSelFpWmUr?=
 =?utf-8?B?eXhTdFE0SEd0QTc0dldpR09mdDNudTFKV2hvbVV0aUtOdFBUWVIvSmlYUm5J?=
 =?utf-8?B?WDRxcUkwR1BoQzBQUnlXNlhObG9DNUoxcVBjMnhDTWt1U3VqaWFWd0krRlVJ?=
 =?utf-8?B?QjdieVE5MFV5b0VYdHNtaFgvVFpidjJvYmFvakRJcStTczdQek5jVUROOUxG?=
 =?utf-8?B?TktWelZka2JhL2hQSmQ2OUhVdlEzRWxBVVgvTklUVytWcmFtZ1NZMDRnR3RM?=
 =?utf-8?B?ZE5MejJxNE8veFh2enVlR1FoZmNkK2NuTCtwTGFDN1ZBNithbFB2KzlrcnpS?=
 =?utf-8?B?MFZhVzg3N3pXdHg5UVBreWpMbWNXMGFoM1ZVL1YzR2k3ZGx6Q2xaaFBVTDRS?=
 =?utf-8?B?dXRRYjFDRzUzVDFxeUR0SUZOcWhZZHVBdXJtQjVHOXBuNGFDRlBjWDlrOUt2?=
 =?utf-8?B?VGlMdmVMT1NnVjJiQnF2blRWcTRKRG8vbFVCK0d2dnZwV1hUdndsOWJtSDNN?=
 =?utf-8?B?OW4rejVwUG41V09yRUdPR1dmOGp5NFhLOXV0ZWZYZ3JFK0ZLTWxLdXdWT2Iy?=
 =?utf-8?B?YkpMRmJuazdFVW5abnhOTUZ0NzRJbHpoY3Fweld1U1AxV0hpa1lKdmhXTmpJ?=
 =?utf-8?B?MkFZamplaHhWZW41YkJrSmZQSTNweFo3K1dZV2gxeHJ0U0dMYXc5NmFzYmlL?=
 =?utf-8?B?TFo1aWhFTDQ4Z3RYODY0OEdxenRTbWxISkx2eklHaWFERE5tR2p3T3JmeG5N?=
 =?utf-8?B?Z1dqRzYrTEF6ZHBwTkxKRHpUMzJiVW1TUkg4NGMrZ2RCOGNFand3WVdMdk1X?=
 =?utf-8?B?RDBjZ29RVTNFWDZCWTF4Z0FQRFhnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30338e6b-81d9-474e-bf62-08dad31b5115
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 21:39:10.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkRVMUaKjpZFAjr2sBmhRdJLBME+fj6vwfcOSgm+ho5CjNZVQKWOHj/cV87ABiAwl3Pxs2PMo98VSE9F5Ula8naJc6P6sFwlN1/0PbQFwSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5578

On 30.11.22 15:11, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Switches to secondary mode do not only occure when a relax is explicitly called
> via the cobalt api but also e.g. when a linux syscall is called in primary mode.
> 
> Also test fault related cases in the oscillating switchtest thread.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 84 +++++++++++++++++++++----------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> 
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index 3a6126a81..f3737d193 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -34,7 +34,9 @@
>  #include <semaphore.h>
>  #include <setjmp.h>
>  #include <getopt.h>
> +#include <asm/unistd.h>
>  #include <asm/xenomai/features.h>
> +#include <asm/xenomai/syscall.h>
>  #include <asm/xenomai/uapi/fptest.h>
>  #include <cobalt/trace.h>
>  #include <rtdm/testing.h>
> @@ -297,6 +299,59 @@ static int printout(const char *fmt, ...)
>  #define check_fp_result(__expected)	\
>  	fp_regs_check(fp_features, __expected, printout)
>  
> +static void _assert_primary_mode(char const * calling_func) {
> +	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> +		fprintf(stderr, "Switch to primary mode failed in %s.", calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}

The same applies here and to some more functions below:

We could reduce the code indention level when we inverse the condition like:

{
	if (nothing_to_do)
		return; // all right, bail out

	do_error_reporting;
]

This is normally easier to parse/read.

> +
> +#define assert_primary_mode() _assert_primary_mode(__func__)
> +
> +static void _assert_secondary_mode(char const * calling_func) {
> +	if (!(cobalt_thread_mode() & (XNRELAX))) {
> +		fprintf(stderr, "Switch to secondary mode failed in %s.", calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +> +
> +#define assert_secondary_mode() _assert_secondary_mode(__func__)
> +
> +static void switch_to_primary_mode(void)
> +{
> +	cobalt_thread_harden();
> +	assert_primary_mode();
> +}
> +
> +static void switch_to_secondary_mode(void)
> +{
> +	cobalt_thread_relax();
> +	assert_secondary_mode();
> +}
> +
> +static void switch_to_secondary_mode_by_using_linux_syscall(void)
> +{
> +	syscall(__NR_gettid);
> +	assert_secondary_mode();
> +}
> +
> +static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
> +{
> +	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
> +	assert_secondary_mode();
> +}
> +
> +#define SWITCH_FUNC_COUNT 6
> +
> +static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
> +	switch_to_secondary_mode,
> +	switch_to_primary_mode,
> +	switch_to_secondary_mode_by_using_linux_syscall,
> +	switch_to_primary_mode,
> +	switch_to_secondary_mode_by_fault_in_xenomai_syscall,
> +	switch_to_primary_mode,
> +};
> +
>  static void *sleeper_switcher(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -440,24 +495,6 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
>  
> -static void switch_to_primary_mode(void)
> -{
> -	cobalt_thread_harden();
> -	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> -		perror("Switch to primary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -
> -static void switch_to_secondary_mode(void)
> -{
> -	cobalt_thread_relax();
> -	if (!(cobalt_thread_mode() & (XNRELAX))) {
> -		perror("Switch to secondary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -
>  static void *rtup(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -699,15 +736,10 @@ static void *rtuo(void *cookie)
>  				handle_bad_fpreg(param->cpu, fp_val);
>  		}
>  
> -		/* Switch mode. */
> +		/* Switch between primary and secondary mode */
>  		if (i % 3 == 2) {
> -			if (mode == COBALT_PRIMARY) {
> -				switch_to_secondary_mode();
> -				mode = COBALT_SECONDARY;
> -			} else {
> -				switch_to_primary_mode();
> -				mode = COBALT_PRIMARY;
> -			}
> +			switch_funcs[i / 3 % SWITCH_FUNC_COUNT]();
> +			mode = !mode;
>  		}
>  
>  		if (++i == 4000000)

