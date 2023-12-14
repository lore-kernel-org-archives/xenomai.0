Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9E79E2F
	for <xenomai@lists.linux.dev>; Thu, 14 Dec 2023 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rMDXwusQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4h7hA/LawD+7QWmjYsjqHGcRZsZvJ1ke9yi9jdLcMlCBp3LavEbiyNXuLR+lb8g6KZl4fO+6i57d5TBeP0JeWeAW5Ib9oC7hTyOaQw/6PpRYvG5kGAoJjhZ2uP+8yHUSJPpR/F3abCAXXe8mJ9TrDnyFBkLA0w+JPy4tMcv8UwyvhQR87n3JfYgOhyyHMjJTEdlZ25pAAwANY+xM+76lN94iDE0mtSO1SRVQ7a94YsKzBYaVq7oPEMht1Dt9dYlx5k0OMWCEJGg2lvF9I9bB3j3btHTjFRRmUWNkJXSTuCgJSxO0mZhWnlJ9BeP5obPy2VqsCc5vsW+tuheEK1KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQO5cYwcIKHmEA161+LlR7IoFdQPYvZNfBT/+GIgtg8=;
 b=JlXqIlxqEqRpizkx2c4xItEE7Og0MF5nRCFeee7HJOV8QtV2c0De6ELvXZJCeFJEGHjKWJVFvC+x8Ly4nV+GeTUzawkU0Cn8iQdWjIks10+U17KcWnRlMpaPjdhgVw114PkGPGzUDlirdB6/uHoRGr/Vhg8yIa9sOCvASdhqTo2hoS4oPYv9aCugd+Wl9fsRBL2k386Vc8ftH5lD8dQXq/8HbtPbCZmtEuRR2IQbYz3L7a1FJ2j1fSSLMqrvhG2rEJvSEIvCzwkWUkik4wNx4F44Iap/Hwdi/bKx2XYcNZ3fKmbnt12TRvB9d9UYlTfHNKoKOsGpZN5eJSZ+QQ2eqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQO5cYwcIKHmEA161+LlR7IoFdQPYvZNfBT/+GIgtg8=;
 b=rMDXwusQyTw9Fu5Zb2Nt/+ksbz9Lqp1r2enRpd79/m2FlzauZcS6M21kK/x7spbCQnZJifdoe6uWQDnLQvmGL+EiqZcIjvTi4A9m/6RhUnlpudhhdfsDIuvF99xeZARhmT0VpmYIBexr8RqtPSYTmP7Jh2R4zAr73cHieWYCARChEv7okQGTSCFQVO+aNOnK6EZPli4F5jdAEYw7EbjdRlWofuwdkz7OXJmVbkKXhxIMnIE/Wt5vklVcRntE5+9Hi5NOrwGNXBERdhA2iQQ+xKz0Jrhk1lg7AQ7r1XjqPpnLUu0eYqyfnHisa7e5u6HqfOG5umlG466fgRDrDuQqGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 14 Dec
 2023 06:54:12 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 06:54:12 +0000
Message-ID: <404e70cf-d338-423c-87a8-1b02cb3797c7@siemens.com>
Date: Thu, 14 Dec 2023 07:54:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
References: <20231212-flo-fix-psos-tests-v4-1-8c694902c07a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231212-flo-fix-psos-tests-v4-1-8c694902c07a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: af36e0b8-8470-4812-46cf-08dbfc717a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRFrtwAfsXusG/NObkmren/cM2YmV6A6dtozCvTG1j08sW9N1NxXBk/ij6+BDUhM5JHSxfsC8w6QcXTTXr5igqWfDtIf7OQn0XIN4MIch9vZWmRuLhEW72MdInNuHpM08Z7XQC/N2PgNRnuQd9bPV0lgcAPPV1liHvFV76MRYEA87+RXz3hnrmJbH2neCcNrUO+aRjyXNAn48Lyvb7RpFhYvRBOX/CW2WJLAMoj/frtL32chxso7mkOR3h16rXXykQxAHkYtwhts2PdIy5PbMr2cIpmNn2zhLBCEJAR5lhUtuWPtFtl9Se5J/tggU7XRZYhE6MxdW8XjA8MiMoprAyQHew8ajTq3pryy9Imp0+Nbp0Wj8E1kCr74GxfBP8CkwdtPDJF2kSr+8DaF4GuqoaLkbP/FMs2AmRuN4X9hTgy4ND1nhZBMWSoS6BqeQpqcTkwzjDP37VRhWw3d6ROJkEuzZO7K9m3qmGWYKmfnMZRi7LC5Clf/mKX6cupmnkIPu6XgE0oVAO8HnhPQZjUSQRruh3f6f9jH17JEL+/nJo/BgR4VipXcXK7OW3VNg6q8gKjJLGHkmN9f2ABtg8P0xstDY7JTMwmZCmH/lETJu5h5WR6u4jQcBhLAkIwB1HkSOo3zATYjneOX9q9h0R7Thg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(36756003)(44832011)(5660300002)(2906002)(82960400001)(6512007)(6506007)(53546011)(86362001)(2616005)(26005)(6486002)(966005)(478600001)(83380400001)(38100700002)(31686004)(316002)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVIN28wa0Y5T2duL0ZQRGR1L2tid1dWZXBnUzV5Ly9GaEQzSHJTWFErRUc3?=
 =?utf-8?B?TEFVa3ZkKzZFMHBFS3F0QW8wTUxZajN5d1o2VGtVMGp6Z0FaT2tNVHM4U0hy?=
 =?utf-8?B?b21VTVlnOHJhejdOTFVKNHE0SDdBZDRPY2ZITm5tait0MXdhVUN0R3VkUUdj?=
 =?utf-8?B?T1JJZWVDelU2c3NEeU9ia2V2Rk9tSmprc0hvR2c1V3RvemVwSUJiM3NWM0NT?=
 =?utf-8?B?dko4cTNwMXJlL2RBOStQQ3ZFQW1qWlRqMmZhQ2JKT2xqV1ZIWW9tWFR2MGl1?=
 =?utf-8?B?T09ScnJjVTE4Q29hTkZXWU5YU2VIdmN4QzdDU1UxZ3plZkxRUXlqcUhockww?=
 =?utf-8?B?SW1Fd3o2OW5WRHUyRmRwMklZc1pKSnNPQVFWcHBwMWYzaVBXWXlMeVlPa1BW?=
 =?utf-8?B?YTVJT2FVQ0t0VUIvcU9qZTlIYytId2Q1d25oSExvd0xnbHprb3hCaVVmSENp?=
 =?utf-8?B?ZU5xMm10ZXNkd1Q0dzF2Z3RPRk05d3EyY3FNSCtFNjlJSlF4TmxKSVlwOTNH?=
 =?utf-8?B?d0xyZm9naDFYd1ZmZVQxTnVZQTMzdytDU3cvUFpzT2ZVZWJnNmJ4dnV5SzhL?=
 =?utf-8?B?a3ptdy9aekZxL3pGeDFyQ3haOU95UkcvZU0yeGMxYzI3emUxek1na1NZakt0?=
 =?utf-8?B?dWR1MDNoT3p0Vk9EYVVOZVR4bGdEdG5zUnJPVmNpeGp2dDFBM0dPRVcxeWRQ?=
 =?utf-8?B?aERqd2JtQVF4OTV5bnZMcmpVM09TcmdyTWRzVzdvb0xCK1VTZXZrUk1MM1pw?=
 =?utf-8?B?UlJMQndHdkZwdS9VVFoyVWZJYmtSUG05NXRCNjhzNUh6RzhwQzl5Sy9hdXNT?=
 =?utf-8?B?VUdwWStCNGtFT0N4NCszejZvUjNyTERxa0NOdGU0ZVRuOWFyMFcrWk1CODB2?=
 =?utf-8?B?cmVna0FLN01ReFNWVHd3T3E0bXlqSnlMUElibXI0eFU5dU05YzdkWlc3UWow?=
 =?utf-8?B?NWxKanBvZ2ZOKy9nSjZwclhqOGlqMDFHM0lEak5uekNvMVc2RzdCcE5ITE1n?=
 =?utf-8?B?ZmlXNXFBYzFGZG53bG1QRnZmWGZod3dtODVmYUJpVmh5MHhKN0lva2UwVTF6?=
 =?utf-8?B?ZWVzNzZ2NXhmdlM0OEM4SksyOWxROEpma2pMRnRQZGYxZVhZeDA4N3lvRm5k?=
 =?utf-8?B?cFkzWHlYZ1FtdmU4TFdMWkd3c3pUNnowQUYwSHBwOVB0bzA2UkNtMTJob2Jl?=
 =?utf-8?B?Ky9RM0U1WnR2KzFqc0RZMVZnMkZNb0hNME5nVDlKQkJpdVBYMytPQkdsRFk0?=
 =?utf-8?B?MDlkeU8wdnpEY0tKM1JYYnBDY2VrbFc2MjhOamQ2MVlocERPQU5VNjlRejJy?=
 =?utf-8?B?SHZZamlRblVBRmdMZXRqcUJUalJac0c3T2huWExqN2gyWDdPaXBqNGg2RzFN?=
 =?utf-8?B?T3ZLVkkyMmNjQkJCakFmcUo1RVI5TjBwUGwwZkExb3BDL0tEOUVKS3ljS2s4?=
 =?utf-8?B?WlVudVRiSFlYQ1VCVi8yREdIa2dseWpNdkl2NmJiRFJyVGRGTTZSS3R1bUdK?=
 =?utf-8?B?RTN0eFpWelRoUnRGOXI0K0J1RDJhcExaRXluWnFFVXRuVHpNUCtWbytWVmp1?=
 =?utf-8?B?MnA1eTBtQnprM0VyL0kzVDNsZ2dRUEVqMjBLRlZ0Skl4eSswYllXcUE3Slda?=
 =?utf-8?B?ZWRBTE11dFpKa2cxcDB3aUVRTTA2d3pFSVNndmdUaXJFaUcyZVN0clNnSUts?=
 =?utf-8?B?dWJia291UFFNWGUwVnpENGFwQUsyQlZTQjFoTFpYSkRYZDdKeWg5RFJ5Ymky?=
 =?utf-8?B?Vm9VNnU1R1VtL1dGSDJaSDVZR3hDaDd5RmpWMzJYbVowdFBZN3U0SkFlcm9s?=
 =?utf-8?B?Z2RpblIzN21WaGYzeUNUNmwrOUZGMFVJN1Z5TVdWMVp4NWJUR29GZ1d2TWVx?=
 =?utf-8?B?YXlTU0tJTzl5WXowQ0NIZW5Bd2poSTAvbFpLYmFaVzVEK1MzRW9wbU9OY21V?=
 =?utf-8?B?SnVheTFGQ2o0MUFVN0FUcEw3b2s2Y1dldy9pY2RqVE9WTU0rUDVGb3F3cktG?=
 =?utf-8?B?WHJsenF1Z2tRVGQvOG5JN2VRNU8zdDR3K3VLYTJZK1RVTzhCY3lTZHBZWEQx?=
 =?utf-8?B?czEydDZpNW9lV1dmZkx4eVpNYThkRmx4cmhwVGV6eUVuWlJkeFFtOVhMYkY4?=
 =?utf-8?Q?IXXk+VQUBrSzb768+GXzorPd+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af36e0b8-8470-4812-46cf-08dbfc717a9a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:54:12.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vm6Ya4HAksJVGtUlV6SkDzoTQ0M4gIhhGkaKfhIb47/3YVoGFENlUYdKFA8C6p/C/F0mSKb+IR46Z4gdBc0m0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5308

On 12.12.23 16:43, Florian Bezdeka wrote:
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
> Difference to v3:
>   - Removed caller initializations of err_r
>   - find_psos_task() will initialize err_r in any case

And what if threadobj_lock() fails in get_psos_task?

Jan

> ---
>  lib/psos/task.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..6d075c19d 100644
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
> @@ -141,6 +143,8 @@ struct psos_task *get_psos_task_or_self(u_long tid, int *err_r)
>  		return NULL;
>  	}
>  
> +	*err_r = SUCCESS;
> +
>  	/* This one might block but can't fail, it is ours. */
>  	threadobj_lock(&current->thobj);
>  
> @@ -447,8 +451,8 @@ out:
>  
>  u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
>  {
> -	int policy, ret = SUCCESS, cprio = 1;
>  	struct sched_param_ex param_ex;
> +	int policy, ret, cprio = 1;
>  	struct psos_task *task;
>  	struct service svc;
>  
> @@ -556,7 +560,7 @@ u_long t_getreg(u_long tid, u_long regnum, u_long *regvalue_r)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret = SUCCESS;
> +	int ret;
>  
>  	if (regnum >= PSOSTASK_NR_REGS)
>  		return ERR_REGNUM;
> @@ -579,7 +583,7 @@ u_long t_setreg(u_long tid, u_long regnum, u_long regvalue)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret = SUCCESS;
> +	int ret;
>  
>  	if (regnum >= PSOSTASK_NR_REGS)
>  		return ERR_REGNUM;
> @@ -601,9 +605,9 @@ out:
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

-- 
Siemens AG, Technology
Linux Expert Center

