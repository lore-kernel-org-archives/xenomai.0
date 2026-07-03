Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D53CB8FF
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079684; cv=fail; b=uNE/HdbzZ2Bg6Q8YL0Mx71SnKOrkl2l1CwflTXsP61sQhwyUgcvGoiIRWR1gBY1CaMQzZ9ZZhkDUSBBAMM8FnXROJYiuhzg8C+YH5Vb3iP+kcthrokce50Ur9++msN3GLyr3/M2wrjGQIpHjh7x9vzRA/L6Yk0lB3Z+pB5DHCl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079684; c=relaxed/simple;
	bh=FohB5TPX/GyyEWldY/pSgjfSOo0fLLSLwd9JPNdb+Ak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cTawBd+gJkbYQ3I1umaX3M316WUO4m6CZ4azPvH1HfWyY2Z2799uITUAdePm+LdljENQ2Xv/udMHZBVEuco4XXJAoL05nEcuvAGEPsZ6vBPRQ5rDrJkd3eKjKfhjPn3BEvdQKZcYsf2MIZVSYt9n662YGtoaGQJWQkvrpZPamik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lkchaSoi; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lkchaSoi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKp4oTE7Jz5eNjwbEG3STxGz4wg/Pg8QhABcRYeDNqwPlTc7lmF7sr6xX2BVpEqr2Y2bX0H+Mf1oHoMRKt/JFN4Co4riEfKQz1HKd7EKwCqNkNcajWdJcw7P0RG2KyhxgAzOrpOya03d+6MtctLiGlpjBTjLO0FMc5NRzIeNyqt5za8v/JAnJUFYneUZh3rbKBnYL5wdpfGNCq6AjgzBHhq8mxmdIOgDBC84YZpkCBqgeinFbKhLcasJbsA8OPpf7DoDAeUSrS0E9w6cL44WKDYa+dIBZQd+XgomNnecPseKAr95zZnyFSWc3c+NdoygDg6s1FntGaWfoWXZxXo0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DijbQBZban1hRZQd02YE06xokCwQlyTO6o3pI5y558I=;
 b=mrh/w0ILn+M4BXZ2IogYokc7D6Y+vnSVBy54TYSN4SSDl78sou0X+kjgfAUBp350dsOiT9F2ZgCiIEydqFFaEd6aOK2DrzzTDYxhchFDk0HfnAEyPULFO40doAIlf0HBkS8yGQM7vFsza3pMjnPF7iattdKFqwuflu4prJeSTNyCJA9XYUG5hxdtylE0HW7oV/kwztA1lriiih67/StnOzrOLU6Sfq5sruT5EAp4/+lkoFO20l/1O3yiJGPUFzX7OWUP6qQqXWcfb3NuZUxPZL4bdV2NC9FbfkPgXO/wAdaZNUtQzb7bHskoCNQokcAaQ/CmRXr7pZS5JhcCl7WdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DijbQBZban1hRZQd02YE06xokCwQlyTO6o3pI5y558I=;
 b=lkchaSoixFPTcMRCTpsZKR6PfLvZ1lej2e9tmyj76htp28NNClifqV7Ykb2G6w/TtC4z5S27t0swKNBuVEczrTUmzfCN8RQHHsFEV82PC1ehHOcVo4jEb/SMKjUVHDNk1dD8n32XAf6+87eMOdDHvamlA6n63DLelKeTYlYNQ7qseCb5M+kOUQB6AsJrE4YcBiIdBEc3VEi1P75tQikSjVmA5STCiAUXzL1kcs2+ETzaXdm2ChVitnoTw2CXeC5/7W4P3ZRRuVpNEkv4VcNM8oOB2Q44GjNlB2Nj2EHB0JPjTAtjAKTRZLSZX25VBs0qBdQv4R5S4hAy2+AKu+fZ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by MI3PR10MB9922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:74::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 11:54:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 11:54:39 +0000
Message-ID: <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
Date: Fri, 3 Jul 2026 13:54:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, jan.kiszka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <20260703114846.24710-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|MI3PR10MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 57363b9f-522f-438a-98b6-08ded8f9dc30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10070799003|18002099003|22082099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ui6sd7SIZPzAOLmkLPpc3sLmrbDnoBp5FqE02fAIcx0hd+UEVP1sDFOh0L8npoPfPjekIpKvWItXwqhWvkOnLLx8wIpS32FN/elwsdc/3BTFgYUqpt3EFnltruCRwRVlWn0JnXezCv8PUvWVF93Q5WcvwWMoVhZPIjp8OIOTbjlJfBzU+SSu2IICdlFKzSDHCrery5OoUpX6qzd5hfT8pD6c6hbSLZnx3OLjdYLJ0YfdOZgHcoiOHlrBO0r6N0vAuIms2S7dlhdULIyqOX+9DRKw0YFBHduM3SLgbmBBu55Bk57dRaWRM0pZyMtf9R7nIROlJiteg9cKLlJhXy0MFyPY/r91bRgoApoxOPimdPhVOJ+LZDxc3tz/KTkm4idwy3k+5ZrorkQPiPNvqrDsn66DXJBiO/sxuWPtz9UQiC8dKFd0lsszWM5m2PuJbAz2pKmhDB7S3vYlkn36302hV3MutzXQ9fOnmZvMrg9U4LmTiS6hJHzIshoQqc0Z8QxcVq/sIJObb5ZUYYZ85C09f5M+WLU+D5pWGKp53bUB8C8gI2aXNR1yKj8JtzF/wETwJrzteALNHBuCWZu+rL7y0NnXsvwzLcs69h+7s4jwBn9t42tLgDAYfyRJ5PehkcbnlfvQQIxZBI2CfGwfK8HFqQ7DzL7DfYvc5FZlHSZfIFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmNzY2s4TTd3ZU8rNVhHSFUyTjBGRVhjbS9GMURMVFVFNEwxaVlaRDIxejFr?=
 =?utf-8?B?Vy90VUNIaEtOZDlweC9MS0hHU2JwOHF4c2N4ZXpEN1hyQndST1A5cXBIK2Fz?=
 =?utf-8?B?YVdmeDJWRTZJS0JWYmw4TW9qczN4NWMvUzdIaE9mN0N5ck9YWDhDTHdaZUF4?=
 =?utf-8?B?UFhqamxNRUxtOXhTWENUQW01MGZmV2RqZXlqQnQ3TXBUVHR6T2Y2WGxMcjJw?=
 =?utf-8?B?QTY2QTFYUmxvWk9UV2hJaXpHS3I3UG1YbEZOdHBySCtiWXA1NlhuQlVrYzFh?=
 =?utf-8?B?UENEMnFaNjVEMUpTRURRdzR2M1JDcUJzRVBoMFVkZzduek5IbHo2cUt4aU1V?=
 =?utf-8?B?Z0JpUkxvZUw5eHc5enpKblRWRGpTQjgramFwYVVmczlBblRjSE1NRndlK1Ny?=
 =?utf-8?B?K1h4clpwWlVKOFJDbTcrOWhIVmVoYnBXVitSU0lYVmNRWDBrbkJwbGkrRDlN?=
 =?utf-8?B?NEtBQ0liVFRoKzhxV1hST2EybmMwVXBZMXY5cGRYaVlxVTFiWVhnVlBiTTQ1?=
 =?utf-8?B?Wm53SjV0eTRWZG1nKzNiSnhSdnN6SnVMTHkzYkFvYlNWbjFCbEtpbklRd1R6?=
 =?utf-8?B?ZWY0R3ZwMEQ3ejJDVHAxUFBoU1hZUUNScEtKZm5qSjNqeE4rSkorNTZLL2o5?=
 =?utf-8?B?VjJoVjNVVFFFWG0zSnRpc29DWGtZTDhvUXh2TjRnRGNhK0tQZ0dvQ2RIeTIy?=
 =?utf-8?B?SFdLclc3NXZXaWlIdytmSjJrbUFkRFNFakc5c2hpV1lYeXVoZXNPSVlQdEEw?=
 =?utf-8?B?NjNvUUlpQytUQnIyTzZTYXBVTUhnRGQwcHJYTTJLR0FRTSt5a1J6alJsNXA5?=
 =?utf-8?B?WHhtOFdqTEZucHVZalFBTzhmeFMzdDJvMUFGd2xQNUFpaG81cXloampFN2JS?=
 =?utf-8?B?MFo0QUxPaFZwTlRvWXY0bGM1WkgzZ3gwV3FmTjEydXhOWjFuQTlobkRCRkNF?=
 =?utf-8?B?V1AwSmpZbStzV0VTWEQrWU05d3hLRTlFTkZqMVNsd0hybjY4bU55MCs1Nmd4?=
 =?utf-8?B?T1YrUnlBOWR2ZnNwak1XeEJRR3NpQVBPVUVQYWtXU3RaS1R2dG4xdno3NzlB?=
 =?utf-8?B?YnNhU2x6ckdKb2NqUzFJRStGRUxja3BIbzFQRGZBU3U1YVFVTDY3aU1TWEZQ?=
 =?utf-8?B?bmpBQWZFaEJLNndFcmlSZUx2MzR5YnBmV3FqNWJaMWZxS2l2Z1FaSDFHRTMz?=
 =?utf-8?B?ZlU0THh5L0FwUXl1Z3BPNmp5K0pBRC9HQWNvY2ZDQjB1ZDlibllra21rQTJm?=
 =?utf-8?B?OVhJUHBqaGJDNi9QbUpheGxET2N2eUlLUm5jdkZLRUpUUFdPcjh5UzAwamlY?=
 =?utf-8?B?SitFQXlOM1NETmFKYmJZMmNnZDVlemhlWmNNTWdENFc0NkpVS05OZEE0T05T?=
 =?utf-8?B?bGkvdUFTV1Y5ZFFLMjVqamhSNG05ZGpnNlkvRk1sTWJIZGxuQUVmRFpENkxr?=
 =?utf-8?B?OW5aOWNCOEd6dERUbFFqNExRV1phYmdMMWR6aTdDdUpJQTF1d25MU2NOVjlO?=
 =?utf-8?B?WXZUaEJhbmZDa1ZocHhydVdCNVlFd0t0azR5OEdGZkJnenFhTTk5eUFpTGlu?=
 =?utf-8?B?NEVueDROYUJCWlFxRFhYanRrZHhzdnFGUVNXdEJjVWZVUTBzSlczNzdYWnFU?=
 =?utf-8?B?TGRDM0RNQ2c3MzBsbnpWbzZkcWxZNUN5cVcvMTliYnlzZXhPL2FBZkJEcEJY?=
 =?utf-8?B?d1pOOGJkSklvZTNYT2NlYXIrME0rSG1kdkhPT1l3Kzh1d0x3eThld25VYXht?=
 =?utf-8?B?VjZVckU3VkszV083VngzbGVqWlVYTlQ3TmJnMUp5M3IrNW9zQXRoQStSeFc5?=
 =?utf-8?B?bllTaUZTc3lOZFZUNXdVTHNQQkJZK1lNb0NhU0RQSTh3bmJDRTBHT0p2UXFR?=
 =?utf-8?B?RUVMMTh3d0VseDhzV29RVFcrOVhMamZPNXVMWGVkb1JScWhiZlYvaFFCQU5L?=
 =?utf-8?B?aHdoNWw2dW1ObEVibktxZ1Eyc2VNSDZnaFk0SjNaS2JjcDNjU2h0Uzl6ekh1?=
 =?utf-8?B?UWlsRnNQUmF1bGZ3ZUx4ajA0c2JvTXM0dERYdExGTVREKzd6Y0QzcW5vanEy?=
 =?utf-8?B?L1E4Y29mVUZCaXE1ZnYreUZpV3plSFRyaFBQcEF3cHVFU0RTa0dCMml0Njcr?=
 =?utf-8?B?ekRDQlM0ZGdwOHZ0Zmt6MnJVQUh1N3BsSHJGMnVtVVIvNnRBRE9ES2xIaG5u?=
 =?utf-8?B?UEpjMHhuZzdWOTFaRTRybytxT1grN05wc2JuUUlIWjcvaHhMMUg1djZoU0Fs?=
 =?utf-8?B?Zm53cnQvbVdYdVR1TzMxYUpocmMvc0pQZHR1anczTEQvYnNTZHJhaTlLTFVq?=
 =?utf-8?B?RnVYekViL3JNYXlHRlBmOG5uWDI1bVc5UDM0bWFkaGVHdWRLaEYwVGtBR0Mz?=
 =?utf-8?Q?a+X8Y/djHGHhja0FLLNZJ4dtBK3Ci5WbN421bI+RCMMig?=
X-MS-Exchange-AntiSpam-MessageData-1: 6Hn4qHO3MWyBh8Xmf2JtcPHtGdsor41ElIk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57363b9f-522f-438a-98b6-08ded8f9dc30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:54:39.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKTf/C5jIg6SVX1FE3HQeIZ7B9VUp3ONEyvRpywNqDLq2ItuyjONKpkYivVNwgSB3SF+vU8omIycMOxxaXgsmdOHRchmYovoHdqYZlKxylw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB9922

Hi all,

in some of my test runs the sched-tp-overrun test was failing with:
2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED: evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN

I only see this on virtual targets.
e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/jobs/393605372
Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.

Best,
Tobias

On 7/3/26 13:48, Tobias Schaffner wrote:
> Remove the broad skip list previously used for tests that fail on QEMU
> targets. The list is not needed anymore as the evl test suite autodetects
> if it is running in a VM and relaxes the tests as needed.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>   ci/lib/gitlab-ci-base.yml | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index dfb33ad..0540628 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -123,7 +123,6 @@ default:
>     variables:
>       ADDITIONAL_XENO_TEST_ARGS: "--vm"
>       ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
> -    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
>     rules:
>       - *test-qemu-rules
>   
> @@ -174,7 +173,7 @@ default:
>     extends: .test-qemu
>     variables:
>       TARGET: qemu-riscv64
> -    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
>     rules:
>       - if: '$XENOMAI_VERSION != "4-next"'
>         when: never

