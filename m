Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41584A48
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652054; cv=fail; b=iGCG7c5nxf7SK8ptBHQ5fzoUCVFMIhNqFCSy+3Kaj9rCaZP9cix7DJHP9oIZas9nWvH5ZOCHdgS+7kU8DKOj0+o6NL6fiMa7LBkcx4bcUaKjuM5FcGKEESbLsmwka9X5d3wX/IO/VuKX7xDD4mNhJx/uvZexvFLWjeqF8wwYn0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652054; c=relaxed/simple;
	bh=D89C/c7Vy7hn70sk0gXofBr7IDRBG5koFG2iMwOgwkc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WSQzKoyuYoBdQP7nCeqCAUyFXYFc4jfm0hFt+GvHRSO74iQ6iBqaQcroY6LldoRBO4562rdwZOq7Kvcevmvyjm/AJ5a8tSaJhGa2sHwVvVU0TylsCy/oRqBmPxoklHOBHyqFNIPFylBzUH3wswlc2mp1amaGH/29xgzwoE/ORd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QrItdCrG; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QrItdCrG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmScFIhte3L9QbFIvopkAi/0hjvBl5hPI1Y+dShSi5tezXM3Dc0pmvnQXFTQgw0v/lHD1vak0+FHmstxGm3jkbS+lNeMDLhawjaIHA7B56fEENAHUtkjPkUoF1SDXr5GcUtpRf4ioJaN8umMEFvyi6eGCyqu8QdNievHOHiUzpobnZKuH5atNVtXVSx5sxrDvnDJsbL9PyfDSevAWvjFdewhzsoDmpSh3XkxPNHFls2LodFxqo0RAux+T/uCVqQPX/eX092kCi6YcWDGuhFAL6TyGxMo99LMFrpKt/BYjYGXX7IKKOTxM+AXdQr1lBJIuvIsFjsgTn2+x11Gd/zuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLalKgyU2zq9oqPFLtRxnWjaUXUqlweRFvzpyVXCQTQ=;
 b=DAa9eR8duxLCWtnyzZoEUaqFYinTlXsbPvY2X8BurhHZfR4AGGd30iSNoupyrvVt43ipYnQcGSaBPg4prXnVcQFIkUxwRyarLMjIqsQAVvQnEPKl8z57T+vwd6WsXZAsnoNvHA3nQGXNBkrN7Z2ovhfRqBdhhjV2kdcw9TaNKmDEHFeMMcTTrUNDp7Resm5ylP8hDOJloN/SD0CproKhmeOG9nmD/NTHXvT2SFc8yZ0uDYQb+x/Vp8QYMhOkH74z+I6W8Xv73Pye4n49mgFFbeMdkrflaDcAHc3BB+0SWx4oKSCEKQDEkAWBfJ5HMi7DWhgrh1Fbt/5qFsthrig6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLalKgyU2zq9oqPFLtRxnWjaUXUqlweRFvzpyVXCQTQ=;
 b=QrItdCrGhBMVQrE8E7og4+Hojy7h2igvfmvMFsifoV/LO2jykwrHzSRObFpF7204bPRtndQcslovzEfi1L4X8c1D8d1n7T88G0ZpOympbmdkzhxVqypH1pHCyW+hMTX7cNln1ok0SJEdwA3j03z/1ZnoLuK0m625ndpd+54PQ97uaPV5EJ6YdtWv78RrMD6EutREoyURMyEMPL7vj/4nJUpEjG7ZL6+rYJGfGwdA/dmC5rTNvW92fMrrz73j4Jh5WtSEiqFjpM3aRq1UbWJj9oKb0W2VdRMCdlG+8lKV6yNLvAkYKygeYmfCEd176bWVsVDSielcMv4bcY3a7EbsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 15:20:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:20:47 +0000
Message-ID: <f524d73e-5282-4256-ae7f-7add90312c43@siemens.com>
Date: Tue, 5 Mar 2024 16:20:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt: Print symbolic code location upon mode switch
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240305081815.10560-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240305081815.10560-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3744:EE_
X-MS-Office365-Filtering-Correlation-Id: 560dab54-3413-40cf-3409-08dc3d27d56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PtCnG9xwUo+ePG6gPs7BlTp5ONJ0lEmL4MT6xu0DeBNGRKOn1+IknDTIhVaervP+W9hpcJsqBPbdR0v85xSQY9uJ5Krxj8nCTwedu52/LJHMTXMC4EknqTGP1NGw9BSMJnnWJ3je4igeZ+B/15oNUc2ARfKMvRcrYHMLIdJIRmhUc3jdmymCBV2hxypOQ9H0qvNKYS6c6Q3cjKdN+/Ksy2MA1KyAFqMN/MhGYrCyDqaMUVslRpQx/lcnC0OOnO7woDjnzA2Ckb+ZF6QvhqYgQFTtPR5KSzf3161lUdDB0oZfiRs54s9F+XMNSd/GWixI08irr1iZz0xCXc3QRzqbDOsyOWS+VKI4wM/H9DhhOVJjuoAZMfiZV6oNlejZSy1Acb8PZnhfsvXr9WPHjSeqAV/LSLiFPm8Qb17kegOdETsPjv/NSdIOxxpgsR/jbIQ7zZpY9TH5OisBVWBXNkcA5etKrkv2B/3J8D3ti6XcLkLEnlNHI64RGjfuV8M6FviEl+s4E/Da3c1D/aWv6a6jdV1ZLiYiHO3+1KJCne7g2DOrjF/lDQBoFrdu0sDmUsZu3zl5stMYZjGBU0TBZ2XogKWIv+bWUSr1pEg07eKXu3fdp//HQFNiZcOQf5iXquKsKMNTipgsH5vihqsy16CkIrxQ3h6vOJwuhvg8otG2LgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1IwSWlLK0R6aUdmYllkczh6N2lySDRCRVNJNnJKQUdHc2ZmbUg5dGs2UW1V?=
 =?utf-8?B?elhielBoYWpXdW9xK0wvelZtK21Td3lWSmFaYjMvYzFSWG5YREc5T09SVHA5?=
 =?utf-8?B?a1I1MzhxcnAxa3FYVVBmMzllQU95YUlUTHpMRlNhQ1FrSE1kdjFwT0Q0eVU1?=
 =?utf-8?B?QXlJdk5BRTBnd3FjdjJYQ2dST3hhcDhFMm5zWUdrM2JPLzdaaWliOWUwY1BR?=
 =?utf-8?B?emlwcVNETDZBOU92cWdLVksyUnNvMTlnUGlwaFljd2VlVk9WakZDVWhhZmhk?=
 =?utf-8?B?YUF5TmNHUGt4T2hPRlY2SjZMVGV2bWp4MzFReWU4R3ZDN3FTdGdYT1Y2THcz?=
 =?utf-8?B?SDV3NjBCdmpmbzIxaU12UEZIRFd6N2x3dGlUUkd1MnJoK1pGK3VBTDVNc00v?=
 =?utf-8?B?cVpnR3V1SVhJYWhpaFQ1UHZRRmkxYkE3aVBOQWdQZGJmNGVPSzE5TDl0V2R0?=
 =?utf-8?B?WVZiTXJaODNTR2YrRytTaEtwaHA0NmhibU0wRE93RWpqV3g5MFRUTDJwY3dK?=
 =?utf-8?B?Uk53UTBKaVdHRjFzcVZDdVN5VktOQ1dGTlRFSEpQSXcvdUJzbGhCVFBuQms1?=
 =?utf-8?B?aFgrYkQzeHBBN3N0clUrdVQyNjNER1BLV2NrODMrWlVaVWFnaUJjb1o3ZXc4?=
 =?utf-8?B?cU5iNloxYUZxdFpyMTRqZ21oWXprcG1uUXFhR0xrSm5MdzVneXptZ2xmZW5S?=
 =?utf-8?B?ODVnanpUMUk1d1RuNlN3ZFppSm1uK0xicnB4NW5nWU85VXN6ZTFuejNZWTl4?=
 =?utf-8?B?aHd1U3BKYVhYamFycC9NVzBpZnE3NFY5Zm1GMjVmcEh0cDMwcDN2VGpPTTdk?=
 =?utf-8?B?ZS9sb1BZQUkyN283d1duQnpONHJ1Q1lEL2xId0M2QVJOS2hqLzdSRUoyNkFK?=
 =?utf-8?B?R1RZYXo2Z3ZtMGV5RVBqd08rUXFXdmNJTDVOcjBHT2duMmpxd0tUS0REK1dE?=
 =?utf-8?B?cDdQSU9pNzhWcVBSTStMYnlGVVJGeGtmMU9sRmFMQTN3NEdUMDJVNE45RThL?=
 =?utf-8?B?Rkw3SHBBeTY3cE53L2Z1KzVXbGtvcm1Qa08vaUI3cEZmQlJDNU1wNzMzS0l0?=
 =?utf-8?B?ekRISWlWaWxtd3RUYks4dTV6RTZjMkdLZ2pmTXpaQXZJWFhwWnV4SE5nc0NL?=
 =?utf-8?B?SVJ6eDRvZVFJYmpUM3FOajE5L3hmUlFoM0JYUzhvck9NZUNUNzJ6RVZwTDZC?=
 =?utf-8?B?a1AxL0xKMWNnN1czeUhpUnVkdWh0WTFOUWNvbW9hZldkdEtDZnViWW9IWjZu?=
 =?utf-8?B?K3Z4OTBXa0tBY1VlNStIdmpjLzZnZFdtRjJyTU1INk9ZUWI5WmMxenRlY1Ny?=
 =?utf-8?B?dFA4aDBockpSMzc1S3BkdGxJVDVub2VkOFlJSE9ua1ViZWs3L1I4REJJa1NH?=
 =?utf-8?B?WUVxQTlqdkhWbWlwOURZMFVWV085d0RtWmZUZHdydnFUU2lzRURRNjFYdEtS?=
 =?utf-8?B?eStxOXpVaUtUZ2RTVTFQVG92ZkQrLzFaYzZVcXlOdmRYMFYvVUFCU1N6aU1q?=
 =?utf-8?B?NWlGTjFFNktZWHNHSm05emZiYkpJZW9lVlkyV2E5NWNlYVZReCtPcTgrTTk2?=
 =?utf-8?B?WDdBOTNndnptMS9GYkFZaUg1OGNvUWduS2l1VG1Wb0RIS2lCdmNuMG52RVFB?=
 =?utf-8?B?M3BIZktOY0tOU1Y5blJFTWtCTG5YaUlvZ0VhQ2M1dHlTZnErVldiSUc5SEZV?=
 =?utf-8?B?R2JNdEcrbzJ1dVJHcU5EQmdnNGI5V1UybVlkVXB0S3IweW5OZUFIRWFLRDJk?=
 =?utf-8?B?TVRuYTNzOXUwS2FIWGIwcDhUbktwQzd5MUFoSEgraFJ1dGlnMTBsVlp5UVpH?=
 =?utf-8?B?WXc2MS9BemdCWjFzRHVJeDJ5Ry9RU2Q5aGFyUHFpMWdjcmhoUUtzNERpWHNr?=
 =?utf-8?B?NnhVTFlPSGRwWklKampVd29NS0lxYjJxQVVwS09kcDNmenlXcnFRMjJzdC9B?=
 =?utf-8?B?RGdoK0c4bTlkYTRibUJybGNXMHh3T2tMSnpmLy94ZVpqUWJOSk9FWmNEV1Qx?=
 =?utf-8?B?VHJHQWs5eWxMUDZqZC9nR2FKSzNRRjFlUnlvMjAxMUphS0xNV2FpeDlWSXFu?=
 =?utf-8?B?aWJFdENEUUxuaHAvM1BUSUJQUHM4clNXUkRzQjF3Z0pnRkxYQUFlOEtRbUJr?=
 =?utf-8?B?V3NjTmZpYnNLblcxRUU1c1gzbTBmdC9MbjRuaEJrVmljWEE1UFNoWDVCVUFx?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560dab54-3413-40cf-3409-08dc3d27d56b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:20:47.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxkXkhb05aznQYbN3T9/KnCJ0dG1dmnroDLkpKrU/6mQLVqUiIRA0fI49LApFoVDx5v/poT9rKuHDdfnEW+fdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3744

On 05.03.24 09:18, Richard Weinberger wrote:
> These days the raw program counter is close to useless, do it like
> the rest of the kernel and print fn+offset [module name].
> 
> Example log output after this change:
> [Xenomai] switching testx to secondary mode after exception #0 in kernel-space at test_ioctl_rt+0x14/0x20 [maptest] (pid 879)
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/dovetail/kevents.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 817aa954dc01..f78abbdc792f 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -65,9 +65,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  	if (!user_mode(regs)) {
>  		printk(XENO_WARNING
>  		       "switching %s to secondary mode after exception #%u in "
> -		       "kernel-space at 0x%lx (pid %d)\n", thread->name,
> +		       "kernel-space at %pS (pid %d)\n", thread->name,
>  		       trapnr,
> -		       xnarch_fault_pc(regs),
> +		       (void *)xnarch_fault_pc(regs),
>  		       xnthread_host_pid(thread));
>  	} else if (xnarch_fault_notify(trapnr)) /* Don't report debug traps */
>  		printk(XENO_WARNING

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

