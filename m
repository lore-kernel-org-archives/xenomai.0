Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143341B274
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G/B8tdVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8Yq+5XsroPXyS1/ryUyAC5VkModbiKAyAK5NCVxhMmhdB0PsB9mO97y0fI4akibWB5QE+BKAYuM19rTOYJFkbnfSPPwsk4MTK7ef8TO5Omn53cChfudJSykglo/GShzxuksFChwIfi2tKRIYIegOuoN9PwGay+cgIOgLpf7iCAgrBrhv6UzzlhBOlK7IdCoXr2GfDNQHQQk7vwlCCEdn2KlHsEIK1J16hXs1G5QOQdTBQl8icsTxk9jGEqDxaeoRTVuUZFCfinMlTA9aK4LOZ3e+8eLsvcJk3DiV23HajhVxnkRozZ9eTSsPTeXmaVhBIZOYai/k4lhhkrub6ZVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttr45jvHY3Q+0SKCbq8GNm01oJARTGFvuR3ze+GXsVk=;
 b=crZnzVTbMf3QtAiLUeKC1A8cxpPHKdL0mSYpmBFaFW1VsXucEnSv50OSq1tFO2V52eYkg1RYSDzDs53q7CzOV+DzPjBKDN6Y7AnDvPCUHPipBwJmyEvkQlnC+40mfVLA6n6aFQ4wAmZGxm9+a7/TtcqGUuYe54D77T3buE4VUt5eN1uzWJGdidTMl6uixiHFxNGulNgXYIQRHAC4w8QDpK1H7Yka3Katamr0q4nQUQAm6Iyr74AHZtl0lMtSqo3C13t4pHOvawwufyu+NS3AEE4iyeGALQqWfkhh6vzlhcJwBFOgyv1j8suQbN07rFlBwaBaTW9ugPBTnmXCYOZUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttr45jvHY3Q+0SKCbq8GNm01oJARTGFvuR3ze+GXsVk=;
 b=G/B8tdViFa1MgLvVStawy/M3aeVoQmHH5kEbkHiWoC1A6EY+fs9YI9Z8f46wkjbmYiRm/285sw6/2/jw1o4i+EwY4Uy8bVrm3zUEFAw5pdk0CBoimDTzDcBhACfjykeB/zQ4qCOoiTI8KKIxYcnACGafvtRpSQXSo7UGMX5afr+1CPXVbnSJuSUtcBBtkJ67RvGzKZS1uRigO9hzqYdTJzk/n+335NkPhEUX99ICDbY2INqprOxMEYsKIr8CITPmt9fWXLqK0CSmsXbN4rKI8FkwntcUtdBac8X9YeW1lIAFW+TLfqiectMqQd695LDYSDmJnZ770r3hLpbVPaR8Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 14:56:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 14:56:40 +0000
Message-ID: <fb79d12f-2915-41b9-9c8c-c3ddbb15708d@siemens.com>
Date: Thu, 2 Nov 2023 15:56:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] testsuite: alchemytests: Skip pipe test if kernel
 support is missing
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
 <20231030-flo-cleanup-testsuite-v1-4-0fb7bbd2d45f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-4-0fb7bbd2d45f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: f94869a7-0316-4908-7a18-08dbdbb3eb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1kh4SrQmrDdyVgrUSARY1ChfD4V7S1v+UE5DgDJeRoYrnoAHCBCOhtZiy3OSBmkw7rYmqhEp6h/lkhy7IrZvFCkr5OsHO2EdHL4gLqJiqrkPA4opsU/F/T/jD5FXoYsYAr+LxAXaFHLeTVsYd+LS8Qo7T1UrdkBZjI+wfJZ15wjQeCkuW1KdRkr+QwlKf4F8fKWGtzoK8et6f3mIVDCuDedgerAyH56VQH34pg4d5KHY2v8xjR6vKsSdAhYqOukl+EirgG6fEKiklIbjnLGuNFl00XI5DXvW/aGPFdxTPZsI1TO7I4UTyhT5XvZ4PAuZCwfEtHITQJtZb7MET9MaVEvDWgbe6pQValGqTuf3INqRnPMJF/67iYr1AcTczYnmslmzXkE98YcGg3dEtzOKU6oPJTuDz9Yb/5OLOXdZrhm7LH9mE8mxgHmR+x+erhdOZ72WXO+1VLzS5JtRCNCeJsFWL4imYaTG7eHqDl9kKF+TjkUlVE3VPq25RI+i3dshDPXGG2waWFEeIzflQWVFTYOwDWPY66gaMgSjtXpDNKeSMEzNFZthn7il/CW34E3LR6maYW5nfOIvMHDgT3gJKz3zVjoGrxm2ihP3aVycn5JWpm+dmUv9eCIfKxSinwt/BSCTuYy2i1jOeDGscq7ChfFL/M5m7yJAkn6fmiDRmmw8oYL3hETOtZYzbOv4GdC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799009)(2906002)(2616005)(26005)(6512007)(6506007)(8676002)(83380400001)(53546011)(5660300002)(41300700001)(66946007)(478600001)(44832011)(316002)(8936002)(66476007)(66556008)(6486002)(38100700002)(86362001)(82960400001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRHNTRDbVNWamJ3Vis3NkNHOTVkbXFIYmVGaFduYVoyRmYwREZCWEEzV1pl?=
 =?utf-8?B?MkZQY3lQbElOMG5SaTR6NFowUU1HTUNuVS9jaTdmdnRPTjlvWjBPN2s0dXhM?=
 =?utf-8?B?aFlOVzV6cElGYTBIeEZLNTU4bHROcTJVcjhjQmRNN0FHRzB3a2hrVHNHMkl0?=
 =?utf-8?B?NDVSWkF5T0dCbGRVMFV1TGpFTHI2QW1GVzljS0pvSXV6RXBjbjVJTHBXNlVR?=
 =?utf-8?B?SXVJL0FTUThFL1VNYXA2SlA2aHNudXVYWlg2WGRkSEE3bnYxd0lwZHR0QmJa?=
 =?utf-8?B?cW14RWdFc1BVN3ZPUTNCK0JobEhCNjlRc2lxc09CL2E3Y2tnWmI1bjJFa3Bj?=
 =?utf-8?B?YmdwUWlxRC9EbWNqNXJQR1ZpS3l0M2FWTHBabEtJVGZiRVQzdkYzRUFnTmN4?=
 =?utf-8?B?NkNpZlZmUnUxV3hBcmEzTzhIa2ZRalFoL1RWWU9VTDNZTUFCbkR0RnFMVE95?=
 =?utf-8?B?QTA4TnV0ZktSN3ZUeGdhRWpCbm4vOXgwaENkdENFQzlmWGFkblVTcjdPdjAx?=
 =?utf-8?B?WndqdkZ5Ym9xNFE1NXhIOFpHWHBQcmRvL3dSUGhkbXVMbGlVaEo3Wk41OWVP?=
 =?utf-8?B?Y25lTUc3dnAzdy9HU2d4L1U2dENYc0J1TWRNR2M3RHU4ZlluZzB5VFBYbllt?=
 =?utf-8?B?Z2J1TDNsdlM2T3pKQXlNaCtvdVNZeXp3bEp5SUFJVmduVUJCeWpCLy93enZF?=
 =?utf-8?B?d215RHNmWEZiQnUvYjBIZXVIbjJpR0greFBHWFBRWjhzNmlWWHJBd01wS3pW?=
 =?utf-8?B?WGZsRWhnQjBHRWZheFpSQzNPazVSUTB4clRXSXFOSGVyY094U1V5L3UyaldQ?=
 =?utf-8?B?V2lobDBjVEd4MlkrVnpjTUk0UGszUlg4SEQ5MnBxZU91eGljenoxbktEMnV5?=
 =?utf-8?B?ck5GWkpOczc3WXFabzE5MC8vSHFJZnVZRjBLUTc2elEyVG92MTZTTUVoRWVF?=
 =?utf-8?B?K1BOQ3MrNkpTdjFobjdPSFBQdTlWaGZnMWRNaHFEaG1VakJaZlprNlJFaWZt?=
 =?utf-8?B?RmduYmV1WkszN2swZHovbzZJb0tXUXhHMFk0SkRRZWhJRm1TSnZCamtIMlNl?=
 =?utf-8?B?K3ZiTm9OMXUxZHNtb2ZYN01za1BZT2lZSG9CeDBLbThVekc1VVFkeVYrRFBN?=
 =?utf-8?B?Q2dlZ2tySjIvMHVQRTdVOTBZTDlPdnlBbkNYcEUwc3JxdjBmRS9aZXFGZFBW?=
 =?utf-8?B?eU50WTNxa296OTJtTnRDTjdnTEZwTkpuK3dIbmcrMllQRnNSK1AydU5QYTJr?=
 =?utf-8?B?dGhqcUtIb05tY2JIak11bVp4Zk5kTVJqOXBmR3VzbXZvb0EySUpzQURxTzAz?=
 =?utf-8?B?N29BMXNHOG9wMitpRmticmlvajlEZ25pNDBHaE1iM0tLbG10RlZrcituMDl1?=
 =?utf-8?B?OEFwUXRSMUFMRjMrZXZQbG94OElXcDRMTUZrakx6bnpEZE5sOXhyUVZmdGtF?=
 =?utf-8?B?b1V4eStPU3BhZUFqYm40K012Ny9LRU1MbWlUT3krNjQwNXhPMC9QZkpKdEQ0?=
 =?utf-8?B?MTIyMHlITU1DejcvSzZIdEpiQjBUelltTzZucTBhVDFONGN5U1pjT1FtZXhP?=
 =?utf-8?B?V29CYkVOSXlkSnozUm1PN01wS29GNTVzT29TZXpoL0ZxaTFLYTFSZzM5RUl5?=
 =?utf-8?B?Q2JUTzF4K0EwR2hoaDJ2TkdRYnVnSkxhekp3UG8zQjVHZjF0V1EvUlFtTktr?=
 =?utf-8?B?YVpuYlRWT2dmc3FJcDV6QS85N29ETE9JSmp2T3RMLzUxTUdHZzZ4MW9qeTQ3?=
 =?utf-8?B?YTBVa0Q1bjZUaC9yV2tSUVdDamxJWUtRRGFkU0szT3gvZGNHeEdCL0VEcllo?=
 =?utf-8?B?N0d6MTJpQjVyUXNrMVZUckV4STNBZkF1cXJnTWxxQndQQ3NFTU9Qa1JyZWYz?=
 =?utf-8?B?S2U2N1I0WFcyaUdvU0V3R0tpN01MR0p4V1drbjh1UVdOc2dqa25kSEZFTTJa?=
 =?utf-8?B?M3VvQlN6NStDelJZMFptZHBHZmYxeE8zREs3S3pWdXhpVmVPYXZ6eUxDclBX?=
 =?utf-8?B?OGdvWTVQWkFOQlczOVVuNzE2d2p2Rk5jY3IzS0pVL1NzTkVaaERqcEVuQ0sw?=
 =?utf-8?B?Y3RLM085YVpPd0UxUERzemJmV090a0I1SjRyTEltS2llYlZSZ3pIQStBT3JW?=
 =?utf-8?B?MDB2SlQzVUxDZjR2MDFLb0xxZjBOZCs5L3JWN1VZVk5ldHo4cWhkQ1RvRnZh?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94869a7-0316-4908-7a18-08dbdbb3eb91
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 14:56:40.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlVE/JYATonOKFjHQaxSOeo6G6cqCQVZnUc660CJ6oIIgGD5URXrFhlnmjerrg7Zc6q+EwfOoh9oQp7HrX3wqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7544

On 02.11.23 15:41, Florian Bezdeka wrote:
> The pipe test depends on the RTIPC/XDDP protocol which must be provided
> by the kernel. Skip the test if the kernel does not support it.
> 
> Might be that the module is not loaded or the kernel configuration has
> CONFIG_XENO_DRIVERS_RTIPC_XDDP set to 'n'.

For module loading, we have smokey_modprobe. Maybe extend with that
later on.

Jan

> 
> The error message reported by smokey:
> 0"000.543| WARNING: [alchemytests_pi] RTIPC/XDDP protocol not supported by kernel
> 0"000.567| BUG in __traceobj_assert_failed(): [alchemytests_pi] trace assertion failed:
>            pipe-1.c:88 => "ret >= 0"
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/alchemytests/pipe-1.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
> index 488c0ee3b..8989f3a46 100644
> --- a/testsuite/smokey/alchemytests/pipe-1.c
> +++ b/testsuite/smokey/alchemytests/pipe-1.c
> @@ -6,6 +6,7 @@
>  #include <copperplate/traceobj.h>
>  #include <alchemy/task.h>
>  #include <alchemy/pipe.h>
> +#include <smokey/smokey.h>
>  
>  static struct traceobj trobj;
>  
> @@ -85,7 +86,10 @@ int main(int argc, char *const argv[])
>  	traceobj_init(&trobj, argv[0], 0);
>  
>  	ret = rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
> -	traceobj_assert(&trobj, ret >= 0);
> +	if (ret < 0) {
> +		notice("Test skipped (no kernel support)");
> +		return 0;
> +	}
>  
>  	ret = rt_pipe_delete(&mpipe);
>  	traceobj_check(&trobj, ret, 0);
> @@ -138,5 +142,5 @@ int main(int argc, char *const argv[])
>  
>  	traceobj_join(&trobj);
>  
> -	exit(0);
> +	return 0;
>  }
> 

-- 
Siemens AG, Technology
Linux Expert Center

