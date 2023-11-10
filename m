Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E620323
	for <xenomai@lists.linux.dev>; Fri, 10 Nov 2023 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KQ2yj8Qw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnMlVcyeJp6U/tGd6YonwcK3plOLC7nvWNo0VSXrr5m7iCWpWtR7BDUml+4IhisRKteq+Lh0Y9WJV2iDK4aJx17kToUwxUhWIL9AFn8Agthqy34z7jzEe+ygMxdZdtqUAv4IBLPiCq050TU6BtMTkvbTq/gZZLxMfJaZply5/hJiWRq8s4j/bYNVTMW/KrHd0mABSRUBHIQSus5mvUtEN8FqgIPQBHpJlOjiqOXTKUw2xFc2XngOwNnk5erN0foOitE3xY2zWyglzi3MRxGQQXlXIu6bm/fy2JqDh8ZbYrUaQsyJv9lXfW4FvtJlsFllXAZnXFxy3WZ3RKJk3Vsqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28CtLRkai3mojqsJdnhkE2qMOmcJy31Q6pbe8F0dqxU=;
 b=ie5b3FAxJVRR9YffSuEcQ6GEoQFQQlvEUiF14X9mkaM6RKIEbxtkr5EKuybbk+3j74zUKjXf/pR6camyM4eRqYZ3SNH3Gh9tFdWwCXamEA8iAgR1f60UjcM/E6bH2pJnTniVDkazhnwH8vrajIu9kn4CVtWTzgcgoECuYRWld+onI5wZAb7kp2qjelZAzRGYEebiG8NzfnXJ3/16F+3QQCqIuE6WD1cMWDloHQvT6S72v0xUDj0zOxH9EYQVjrnE4aVUrwtzXuFTyUg68aVTwZRQhR+1EzrtFESLwEXn+LWHb7Ekb4ijpCHqyrK7Fh+s2ozctxKl51Xjp9X1D5MYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28CtLRkai3mojqsJdnhkE2qMOmcJy31Q6pbe8F0dqxU=;
 b=KQ2yj8QwXQTud2Mpv7BjlSVVRzF+5Jm2nkKa1XMr1rFJHP1ofdaDGUcYjyAtE2qNeSDG6W4By7ZufD2mWLJ2d9DWIGfQLi5jtqys/C/ctCiTtnujvoatCcO+9552CRGd4UZipE+uvLVZeVdkJXH8bRKBsGe9gaNZW9dSjFLcj6qYoJc9cVyKd6nuPjbnBZ9L9jDbrf/W6dhEE2KHhawMmaPpwxEQ9FxO/aF/jH/RYmY7J999QdahvvCfKl10MeUG6opl99W1gFFXAWtrL+r3jnHxWqGoOX31RWWFsk8ITByiTEJmlOW/9ILuxgUxralhJ0wMY2RRm1SAu9qIq1d4qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 16:30:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:30:02 +0000
Message-ID: <e1b5b523-36e8-45ea-bb0e-52e131d96fb9@siemens.com>
Date: Fri, 10 Nov 2023 17:30:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Testsuite cleanup - continued
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfaf13f-4cf5-4aa1-e060-08dbe20a49e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/zKW74OFdZKpjSTGLfcNQFMV+fxnQtADmhFFoK6GzDYWuQ4VArFHA19jxk34ZYwyCHwZUzcaDPuWx7a0rT5Y/eoYQ1Fmqc02FOPsho65yTibt66pUJYQ7AWVQ3lviY5cDiaFFNaerpOGMT5KjpLjLKWMEbYLIBmaEQV9GnIY5qaqxSQ4hLQ7f8sNhqD4uThlEBGuL2e3roo4btVaAXHpq48Dt/3NgBmkxOm1QJuUB14z2NzLqAbW9TVEp+/xjkr3t4fP64HEWaI+rnmhmW/MPFTDMnCPGnjYL5EcqAlK1PiVKiUK4t7D1m2L0StYd6CxkS2NxV0hbLJRrlpV3p+0ZT6/nImjj8MsjtL/xeT+ybSOeL/o2o9VcwcS1+GRlsUEgffVym2STNsg0pXT71mdg+ccvi/9BcNTD5/OTPJCUUGGnCHaiJ2k4dd0nszCL3hwvR6CvRNlu3oIpiT4x1DaVixB76vjl80wg2A1M7PURkXExtl4ZgyUgDFJ1myEtDtWY71dDv5njp8V3r8AQlBMrr2DeUMF7Jea+KfjGbOy663J8ge8Z52+YU+TUjdo7NntEQHqfusWURAmyNbTjpzTOQppXbgiaYnkf8+sQhhKbEqiFPs74cv0YzSlNVpOdvxNQxUdA+g88cekl/+ax5nuRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(478600001)(6512007)(6486002)(53546011)(2616005)(44832011)(83380400001)(8936002)(8676002)(316002)(6506007)(26005)(5660300002)(2906002)(66946007)(66476007)(38100700002)(66556008)(82960400001)(86362001)(31696002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJyMXY5T1RPRWgxYUZsRGV1VGtDWjVxQ3BuQzdDVDRJRVZHQUpOamo3VFJs?=
 =?utf-8?B?eFVyeHFjdXJyaUtoSEhJbVNpRTRKbzBWR09kOU1rbjE4Q0NDSGFXSlRXUWFO?=
 =?utf-8?B?eExNS3Z5UnU5elpER2REL1BZK3hNTU1xOG5kWk5vVnV0Uy90YS9ZcStYaVd1?=
 =?utf-8?B?d0JPUGdYSlgvb2kzVk1IMmEwZEoyTWJVMzJoYVV6MFhmdmJmTWM2b0xDNHJa?=
 =?utf-8?B?R2NtQTMrWTRHRDNDLzQ4Vi8wNVd0SzZhTGFsNVdlWWtvUE5NWXZFL0Jxc2Mr?=
 =?utf-8?B?VjM0RzBsUlVtY3ZVbmxyT2Y1VzFoTDFMRU1xYnl1K1VZdEU2MnJrNDNITmZt?=
 =?utf-8?B?T2lGcnRFakNoMmJJZjNyK1JwOTQ1SkVZdXFXd2lzdU04cWluMElPMHBTVUJS?=
 =?utf-8?B?WitxOGFjNVdZaXJ3VWJvZTJSY21SM2l5N1ExY3FBaDk4QXg3ZjVNckoyM0l1?=
 =?utf-8?B?MVRYU2k1SnNtWjVWMHUzSGYzR01haXNUZnNRR3BlY0xxWUUvazJWTFUyeFN6?=
 =?utf-8?B?em5yZnRHbCt2VXZ3aVNDRXkyaXhLbkhNMmNPWWxwd3FNRVVlRldIVElRWlls?=
 =?utf-8?B?YUpGZW11NW94RkNuNkVWejkyU3Z6ZklvSkhGVCtmclRwUTJPTHpmU1B3QVg0?=
 =?utf-8?B?RU8wQTdNVnpZY09qRnZNK3QyaThoQW1mVThGMk82eW5QV0l0empzZHNzVVFy?=
 =?utf-8?B?Q3hkWm14dTRIR0lzZ00wWWUvTVRIVU13ZHY3MG1HdkpXaEFiMER4SlREL1Z0?=
 =?utf-8?B?YXo1ZDQ4VFROcy9FbDh3ZSt2L0NtdG1EY3JycGJJSm9TaDZwdW1sWmhWdmxO?=
 =?utf-8?B?UXkrUkdoNjkxYWxWMjBEWi9vWkpzL2ZXVWsxN0dlb0dhbm5CVkVwRU43K1E0?=
 =?utf-8?B?bkk0NUl3YU01ZkZxYmRwbGNWdnk5OWY4eENSdjh1YVoxRUpvVWNYekJFQTRp?=
 =?utf-8?B?NWVJbjAzYndVYnhtQW1YN25RYTF6Z0VSZ3h5STlkUk9HdkhXd2M3MWh4T0Ji?=
 =?utf-8?B?MGJTRW9ZTXJVTURJZmcwOE5CcGhCaXYrWC9BazJ3Szg1UEhLcTVIOVBUL3FS?=
 =?utf-8?B?TDdmbGNQZFplK0ZZeHI3WldqeUNILy81b0h4ZVprbkpmQjB5aDQ2WTJKSFEw?=
 =?utf-8?B?S0ZWbUZnR0tEZzZvd3QxazBWL0JXYjhNRm9zTzlDZk1PVS9rY3J3UllEQyto?=
 =?utf-8?B?OFJtcWFXWTdjMFZZcnZJcWo3djhkSnA0dXlUZzRnamdNMmlQa0VmMFVGaWUw?=
 =?utf-8?B?VWdmK2oyZ2Jtcjlpb1FOQlc5N1NBK3JaM0lPMGh4bm5TMU96TEdBTzJ2eXVL?=
 =?utf-8?B?bU0xcWNCUWE5ZWtad1Nlbnk3cnc2VkhRcjB0Y3hRQi9DVkU3ZzMzamt3VHRM?=
 =?utf-8?B?TFBjTXBGWjVBQm1TUXRBdUhiWkFNTk12bEgrWEw1QXlLTURRd3gzOHRIR2xs?=
 =?utf-8?B?L3FuRWg0WEJjNG52MElpeW5FWGtlblRGRWF2T29lVEdjQm5OelR5VVNlVHVr?=
 =?utf-8?B?bmhRT2FpdmdkRVM5UzJsNGxqTys4eFVCZjg0TjBLbTB3MFl3dC9XUXhQbitV?=
 =?utf-8?B?d0hxL0NTYWk4bDBxeU5ZK21Tb0VYSUVTc05VRUZmdWkzcnVrbU9CbXBrVmxu?=
 =?utf-8?B?L0hMMkxFbHZxdzJwQlhWRkRFRHhKdmc5OHNuVTJYWmpBUlIyeDNrKzBRNmJ4?=
 =?utf-8?B?aE1GVUVIZjN6anhuZENoRm9OOFhMbCtYNU82U3FuUzB6aHlnMWQ4QXpkdlAv?=
 =?utf-8?B?eW5WSXh0QkNMQTRpandzWmxYRnVUZGpVOTg5Ump4eWdCVDNKa3VTUEJyYlg1?=
 =?utf-8?B?eXQzRTRNZDNZeDRGMVJZS2VKcnd4N0RpWnV2RW10R2ZTNUJpU2dxcmRESnFZ?=
 =?utf-8?B?SklMQ3d6Q1RsT1VEQ2RsOEw4NFZZb2s3QnlMOU5yenU5S1BRWWpmMGYvNStQ?=
 =?utf-8?B?ZTdHdDFlSGxQTVltWkdyRTFpUlRIQTZDRXQ2QnF2WFo4bklsTDhoR1dISVd5?=
 =?utf-8?B?RDc5WXlPeHVxM040cWNXZVpMWVFVZnlqbHp6Nlc1M2h1ZFBBalFFVTZlR0M5?=
 =?utf-8?B?dE42UUlTK0YyWjZJZ05NYUVadnlwbnRuditCTGpDYlc5Nko2S2NIUVlUUUFW?=
 =?utf-8?B?NTJCY01PMW4yS0dJL2NuWUtMY010Sko2amVLNlNWekRmUldYcDRGeElnQWx5?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfaf13f-4cf5-4aa1-e060-08dbe20a49e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:30:02.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVrEvkrtAzj1i8kgnbaQ1iPOHs8S7oKlewqKRAV5ZXokKtwkhHKQjo7NxkjIn2MfYcYlXIUNewZFfcRA59iueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7331

On 03.11.23 16:23, Florian Bezdeka wrote:
> Hi all,
> 
> Jan had some further comments / ideas for cleanups relating the last
> testsuite cleanup series. Here we go with some further stuff that
> jumped at me while working on that.
> 
> Feel free to drop patch 2.
> 
> Nice weekend!
> 
> Best regards,
> Florian
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (4):
>       boilerplate: Define ARRAY_LEN once inside ancillaries.h
>       boilerplate: Rename ARRAY_LEN to ARRAY_SIZE
>       testsuite: alchemytests: Try loading the xeno_rtipc module
>       utils/analogy: Cleanup of unused includes
> 
>  include/boilerplate/ancillaries.h            |  2 ++
>  lib/analogy/calibration.c                    |  5 ++---
>  testsuite/smokey/alchemytests/alchemytests.c | 14 +++++++++-----
>  testsuite/smokey/psostests/psostests.c       |  2 +-
>  testsuite/smokey/vxworkstests/vxworkstests.c |  2 +-
>  utils/analogy/analogy_calibrate.c            |  4 ----
>  utils/analogy/analogy_calibrate.h            |  2 --
>  utils/analogy/analogy_config.c               |  1 -
>  utils/analogy/calibration_ni_m.c             |  8 +++++---
>  utils/analogy/cmd_bits.c                     |  2 --
>  utils/analogy/cmd_read.c                     |  1 -
>  utils/analogy/cmd_write.c                    |  2 --
>  utils/analogy/insn_bits.c                    |  2 --
>  utils/analogy/insn_read.c                    |  1 -
>  utils/analogy/insn_write.c                   |  1 -
>  utils/analogy/wf_facilities.c                |  2 +-
>  16 files changed, 21 insertions(+), 30 deletions(-)
> ---
> base-commit: e66b97f8d02d0fdc3f5f8da7197d895df95dafcb
> change-id: 20231103-flo-cleanup-testsuite-c318029e2d17
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

