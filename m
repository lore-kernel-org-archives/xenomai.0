Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245D19442
	for <xenomai@lists.linux.dev>; Wed,  3 Jan 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FXdcBzjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTW+vytzDSRH9g0ta5HZdnht6X7sgnUrsYRZD8NtodlwUc+q0Umo4LUdTnbb6iLo8V29EgvGoaukt3UVxP36tdMdVPsA0rBpc/iF5AKuTaloasVzaPRtHOzGp8ZvN77TTtmOM+iMelKiQUyNBCUbIs4GH+1GMY3h2+bbHE9ZDhZ3j3HPRmKE9wnK96JODqcwRySux3JmISNr4rNHoDoRmwf1UdNieZRDSl/VPX2LxJx2dsJ8XMjvh+VG/2SasRNTYOKTZwWGbwanEQcywL4AKVQlQcIzv4AuM0DcB2NXvuvZwfjjj9HuieBmAsmkmS7xkUjY4BSgPjp28y5+BVYNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3KsmfrY0yfCnt76ZjWxTC5DxmmGyYdwQweIYsiCTlw=;
 b=S7SNVQpg1emahhVMuYOg05vaaiHQxvrgGnf6gq2s1iRG3HOzPUVLBNV3azVSYfLcS7JuzEqls0H1TahAPmDJ0SiILSFZJWFTfxuM+eXZ3rCay3yVdnPBJQpQ3i5LQ/gbGF9AkbG21tG2qKvIeMI1+Q4YaNcH20sD9eN3ogLlAVrW3OMy2+ccmehe8qe129C7ie6OArV4yXniKGzBUOWClJtGjFhRFsiYXVrYY58+FysgnGNr3vSn63XMNWS65roCvKOx7tGi9j+0DvDbh1S5SJhZD3YCJUy+lw6oZU6RdiaQVLUHbhYhTgzfLZnDrzmOg4/1Dx8ZJ5V6HkNzdsdtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3KsmfrY0yfCnt76ZjWxTC5DxmmGyYdwQweIYsiCTlw=;
 b=FXdcBzjBqTFCXF4AyNKP1N1zx6TQW7wVJkcm6x26u6VjUckXS/VoOEfxQCk7e/d2l8mTQSoqEE+qzKCikHSqGPded3KnCQFw9QlwXGb/yJrQQ7zqkZjqnCMklJVpkybVlmDJdyDPL1ju0fIvXlh7k1Bhe48vPycBy2hxdlLRq7jH3FQrQTdtkb7EX0mc1q1bAV6MuE0HSYg0WMMDi75wHEeurqIQrJurdUAZOl5Wdm3jYyM7mP2US4TJ3TWJnyUa4V3SqQfrmYUtun7ot/7lptTV7PQwDQADUNl1HQJZT4XA/jQLg5yJqzSEk9KdEoIuI+5Dr2wEGAuYSUGlumjKLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:26:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 12:26:51 +0000
Message-ID: <ee263824-c81e-4713-9597-c8fccac64b1f@siemens.com>
Date: Wed, 3 Jan 2024 13:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
References: <20231212-flo-fix-psos-tests-v5-1-60f2c0acbbae@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231212-flo-fix-psos-tests-v5-1-60f2c0acbbae@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: c97c74da-e362-4ba5-9fcb-08dc0c57439c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmh6KOazkQ14SRIUsCP4U19i9P0IinjIeEzGjdt9zr3w9/T7DqQguzehkRNyNLg3DA7t9vm+n2oAz2ZG7GUbyfSNv5zrP43f2Qmpu1qF2UdlkOwrm18xT23ZK1rOyMZABkoNmLmurhlK/ZdmoBA1w4JtXrJ1mXCoo2mgctDvFyWHpJJF4D14KK5E7gfozImk1xWgW6a8busZr750Y+KflUtN2nMNbggpBefq0wdE1GRCK34/xb+vHvUyhORHLmWmEdB191cZ5sqY+WKWsu1c+4iK1DCDQyxXi9EmVo32A7WOmmvhbtaYaDGmUlIKL8yf+c561vhmYiXgj1KLVgR8pU99QAGKFkuUtmsh7yPR4jQ94l/wKFNXpJ2bZl9BU7NfjcfOPMzbe8TdK5vtf96ZaRIvgAI6hFn2DzJ2UGE9KIu0P4XwxRzOArRyv5gIZlaotUNLF73x16qd09Ib6MYcvZtdn3c8I650dhyDKuqh4kt3PEbc7lNv7eXvI8QVkFJukT1tHuIkLzUFqsJ8JtWxnTszBoIg2DQsxf6H0zIjomvNYXxE7sioFGa8cS4szG/7DjTnTGHw24DZixUrYsFcc92paCUDDXlRf+dbRaCvfxrbSdzvk7GBcEKzuUZveh8FY32ZWsCOaAdT8+HNJGQELg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(26005)(2616005)(38100700002)(83380400001)(82960400001)(8676002)(6666004)(5660300002)(8936002)(316002)(44832011)(4326008)(2906002)(966005)(478600001)(66556008)(6486002)(6506007)(53546011)(66476007)(6512007)(31696002)(66946007)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0lRZzcrcTVSd0RaYmMzVEtLNDFJc2tFOU5oRkRlZWVFcERXV3FLNmhEQ2V0?=
 =?utf-8?B?WHdkRm9VditoWG02WS96cDJCajRnWDZnR082ZzBiQXluTGFKemI5K2l1QXUr?=
 =?utf-8?B?L21mdHpIY1pTUFc1WjFFOTlaTC93VWxGRkw1dy9ZdGo4MDVqVlVGU1YrdTRi?=
 =?utf-8?B?aWtEMW15Y2tGWFB0OWxCK0ZwZTEyT2poaWtCalUrUlAvQU5CYjlBRlRsRG4v?=
 =?utf-8?B?aCszc3pvN1JQT1d2UFR6VXF4NGJhc1Z6TmVxNml6czFXR1N5eFk5K2VnRDJp?=
 =?utf-8?B?eU9vTENIa3IyUXdxbHBNMWNDQk43TnFDQ1JSM2VZcWtxeDNZSHNneFd0T1VV?=
 =?utf-8?B?MXdQcStmL3JzYVlQK01wb3IvMjQxTVJ2ZFZrTVhxaHN3b3p1cFdRVHoxdk4z?=
 =?utf-8?B?alRnS01zZXBScUg1ZDc0SmVMcUtzWnI5b0xUY2d3eWd1dGZRT0lYQTc4bUhV?=
 =?utf-8?B?RGNTdW9SL295Mll3Q1dUL1lEK1NCSTF1dGN6MEZmLytJL0NjM1c0TXlMZFo5?=
 =?utf-8?B?UWNFNXhWbDhISnNGZkMwSHBBcmI5VitKR2w0RnZ0N05IV0hwZnN4Y1ZyaXN5?=
 =?utf-8?B?aUN5SlM0a3ZKZXpyR0xzWEJIZ3h5QnhyMGMwQWNxRU95UzFGVnNhUm9EVEdo?=
 =?utf-8?B?M0V0UEp5T2daR2c0YkdEbnM4WFE3S2dOZGpqZlAzNTMyOXVoeTZIVW5qdDhK?=
 =?utf-8?B?ZVpFNGE5L2pHbTA2ZkV0MFBZTUx6a3NDMEtWQWExSk54OGY1Ty9PVmZ1aWhR?=
 =?utf-8?B?WVVHcjFUYVJ4RVI2UkI4NnlBb2pCYXEwUGRBcmEvMXlmRjd3bFdVM1JNb0dN?=
 =?utf-8?B?aVk1cWFaSXRxOXpkZFB5d1N3b2g2ckU5U0VlTUMxRHdlc1c5S2Iwa3F2Y2tD?=
 =?utf-8?B?UEtTOERTeWhyQ0F6b3YrZE9oQWpjbUE1NXI2dGRaSmpWWUZPUzFQSDE2UVV2?=
 =?utf-8?B?dE1lMWVRSm8yM2ZhOUhidG95S2FpNHk3bWw3TkZJUVY2MWlYNGlmNmd4UTNa?=
 =?utf-8?B?VlMrN1ZBS2lmemt2Q1FkaGdJUml6TlN1UGFFakJEcDFFbGFNSGRTUkIxNktp?=
 =?utf-8?B?Q2cyUGI0YS9QVnF6L09Yc1o1V0JBY2dwbUxnUGY4RGNSYm9FVkpUSmlxVG8w?=
 =?utf-8?B?Sm9LclBETmdNMlpyS0hEMnhRd2FGd2QzdzM5MDZ5TUpwM0UyL1BWTTQ3ekhn?=
 =?utf-8?B?U3NnSWc2N21MZy83am4zemlrcFNVY0tmZUVpSUtLWVk1dHVYSGFERW9QWGgz?=
 =?utf-8?B?UDdicEJHMWowcEh3QnVISytOZWV2Ky9lS2tsTW9OVGs0UE5IR0RJdjRFaml6?=
 =?utf-8?B?Q09uVGt2akpJUDU3RHFrSXU4cFllQkw1ckRlbitvZFJYL2g5UDhoN1Exc3Fa?=
 =?utf-8?B?VTVxcHMzdFgzVGJpeGtIWkdWZUNOUjFFejJWcGZxdnkzcFR2dmVnQ1JGYUVs?=
 =?utf-8?B?anVMTG4xRmE3UHpPdEZUaFkzMmVzVHJ4dlo3U0cvUEZjYUNLOGhRZXgzaVEx?=
 =?utf-8?B?Q2FjRWdHZEZpS3ZWN2RndUZ4OHYzbGxGc3FDODZxVUg3SjVqNjVmTkJYMFd6?=
 =?utf-8?B?NEo2bFhFaWgvM2dKOHc5U1k3Q05NbjA4QzlaN25HeVNIZ2g0ZmFzNmYxdC83?=
 =?utf-8?B?QnRjZHpoRGpxWHJ0OGxDUENXSWgwbDlWditKZXJlK1lyZTNWdmxybTRyMU5j?=
 =?utf-8?B?MUR6UDN2QllLVUpBdzhFeDJPVDRBcWtHUVN4VEtGaXFWT01jQS9qMThDODBM?=
 =?utf-8?B?RWY0eXdrVnZyMDg1cTh3YmFHbytSNTc5SmNNa3FCbFZQekZWQ0NTcEwvU2sy?=
 =?utf-8?B?MDh4UEJyK2FGZkxpMWwxTWdJRUdQbGlBMDlKcTNhbXNHT0QvNmVpVUd5OGdT?=
 =?utf-8?B?YytaeFlrQzJNd0ppWTdTc1NHeXV4NnVhR1NUckwwTUpOeHlIM2hCS2QxQWw2?=
 =?utf-8?B?QzQ5YVBrZXI2aSt1dmMrSndiVnVHN1h5RXdOZGVJbkxBKzBQaGNzLyt0V3ov?=
 =?utf-8?B?ZFVEemNzWTVEZDlsS0d6cmhIa05hWkFVYlloRjJPeWE4ZkZpM0IrT2Izb2RH?=
 =?utf-8?B?VlNKSTBPZ0JuT0FvOHkralFaampQd2J1QW1HZmFXc2g1TWxBRVJsbXkxU0dC?=
 =?utf-8?B?VGxzMG9wb1JZSDk4SjA3ZFNMeW0zc2dqSy9uK29hSGpuYkU4Z2UwZHM5M1dJ?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97c74da-e362-4ba5-9fcb-08dc0c57439c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:26:51.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tqNtJDu78ohHTPkHHth8N2lu45gHEnuuUtc7eZesvZrLwL4VOhLDzwHK7qXF0ev+uqobnXl9TOlD6fE45ZtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7958

On 15.12.23 23:59, Florian Bezdeka wrote:
> Fix the following build failure with gcc >= 12 and -Ofast (found by
> buildroot autobuilders on xenomai 3.0.10 [1]):
> 
> task.c: In function 't_start':
> task.c:398:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>   398 |         return ret;
>       |                ^~~
> task.c:364:13: note: 'ret' was declared here
>   364 |         int ret;
>       |             ^~~
> task.c: In function 't_resume':
> task.c:444:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>   444 |         return ret;
>       |                ^~~
> task.c:428:13: note: 'ret' was declared here
>   428 |         int ret;
>       |             ^~~
> 
> [1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a
> 
> CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v5:
> - Set err_r to ERR_OBJDEL in case threadobj_lock() failed in
>   get_psos_task()
> - Link to v4: https://lore.kernel.org/r/20231212-flo-fix-psos-tests-v4-1-8c694902c07a@siemens.com
> ---
>  lib/psos/task.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..b8b516dc9 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -62,8 +62,10 @@ static struct psos_task *find_psos_task(u_long tid, int *err_r)
>  
>  	magic = threadobj_get_magic(&task->thobj);
>  
> -	if (magic == task_magic)
> +	if (magic == task_magic) {
> +		*err_r = SUCCESS;
>  		return task;
> +	}
>  
>  	if (magic == ~task_magic) {
>  		*err_r = ERR_OBJDEL;
> @@ -115,8 +117,10 @@ struct psos_task *get_psos_task(u_long tid, int *err_r)
>  	 * holding the lock. Therefore we need no cleanup handler
>  	 * here.
>  	 */
> -	if (task == NULL || threadobj_lock(&task->thobj) == -EINVAL)
> +	if (task == NULL || threadobj_lock(&task->thobj) == -EINVAL) {
> +		*err_r = ERR_OBJDEL;
>  		return NULL;
> +	}
>  
>  	/* Check the magic word again, while we hold the lock. */
>  	if (threadobj_get_magic(&task->thobj) != task_magic) {
> @@ -141,6 +145,8 @@ struct psos_task *get_psos_task_or_self(u_long tid, int *err_r)
>  		return NULL;
>  	}
>  
> +	*err_r = SUCCESS;
> +
>  	/* This one might block but can't fail, it is ours. */
>  	threadobj_lock(&current->thobj);
>  
> @@ -447,8 +453,8 @@ out:
>  
>  u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
>  {
> -	int policy, ret = SUCCESS, cprio = 1;
>  	struct sched_param_ex param_ex;
> +	int policy, ret, cprio = 1;
>  	struct psos_task *task;
>  	struct service svc;
>  
> @@ -556,7 +562,7 @@ u_long t_getreg(u_long tid, u_long regnum, u_long *regvalue_r)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret = SUCCESS;
> +	int ret;
>  
>  	if (regnum >= PSOSTASK_NR_REGS)
>  		return ERR_REGNUM;
> @@ -579,7 +585,7 @@ u_long t_setreg(u_long tid, u_long regnum, u_long regvalue)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret = SUCCESS;
> +	int ret;
>  
>  	if (regnum >= PSOSTASK_NR_REGS)
>  		return ERR_REGNUM;
> @@ -601,9 +607,9 @@ out:
>  u_long t_mode(u_long mask, u_long newmask, u_long *oldmode_r)
>  {
>  	struct sched_param_ex param_ex;
> -	int policy, ret = SUCCESS;
>  	struct psos_task *task;
>  	struct service svc;
> +	int policy, ret;
>  
>  	CANCEL_DEFER(svc);
>  
> 
> ---
> base-commit: ed69c34214f9fcf57b459e701ed4f65f6753bb8c
> change-id: 20231212-flo-fix-psos-tests-d3ba4e7c27d4
> 
> Best regards,

Thanks, applied.
Jan

-- 
Siemens AG, Technology
Linux Expert Center

