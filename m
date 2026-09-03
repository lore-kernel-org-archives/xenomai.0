Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D45490C1A
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432803; cv=fail; b=i3DaR0i+c+vsrx+d68o/rNqnPWXcZGZMgwKDeORKXlOeLzaFbA6sFuBuz9BJI8NQ+7pNosqRhYzgBOfqFQzgMNbGbQJKyPY+OGUhegZPxU9X5AVpZoOsKqxs5eF80S44F5Sva82BOo+aYrKUITMoDn5JOHVQZPDqH7K7wp96POo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432803; c=relaxed/simple;
	bh=4Ox3TBIl3tWEN03+4CJ6ES+wgGWHpvJ9QfuWPjWijsE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZwDcKlvX120jqJxeKtEtGgU4hUd7M4EIXApKOZrkInhoXRn3RFWbRbZ0/sIUG54f/h16nIVrAAQhkEuUqy6XU1DzpGjasJz5Tl3cSiqi9iqFrxTG8nGbkaFP/fzxvCs/kjE13pcIxwXufEo99x9aDA+vDIUebFrt0WHlt1MT54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HnvkrqlK; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HnvkrqlK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Echo+vMb7cEttvdePtrpwiXV3U/FymltlFbBBhTgAundTKMihzflnjavlpcMUmIA+qS+4jTUYDSuUZN3On2zSIfJWO20/eYhLB1Nu+LeTYv0G4E1r2I1Y2xUswYtdnnGJ67Nh2PqMcg1HMBufMy6oaVbu/YIJBXWiGbbgDRAjJQtSZCXGR1WnvewbOc0YJwwKRab4ips/U8/AOxIw19+Kre1kJZvftAWl6vpB/FG8Od71cidrO5QanBq6kOEPZ1IXEZ6TeRmtBPwRkGKJOUtuS1tIEuCsOhtcmRkQ72w+dd6veahmHXuFJduzzcDx1k0r1glGNdoQ9tHCboPgBz0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaxU/GsRXJ1e3hssIms9c4iXsb4VeCVzoHZWriyFRfg=;
 b=cPL7F0gLkd3aVj7uy8oU1KRupIVF+QQcdM+gr9stCDY6jTW1kNRIGwthN5t84kzSggEps3kS0jhZZo6hfwmvyk/aDHcDvLwDrCtRn9WUit1ogTJwXhqKsNAST+/6GWMguTrEFeEoLBAf7lp9NTYfAR8UHUiYYRJ7i38KuuKQDuEI1K1rZL5zpZQYya5tkbAWWNGOB6miqm+CBXwg2PGfosARkXn0/pux9wY8mNfqVvdEc865bFLI7Ut6Hp6L2w8E7MlUC8l5Fb5pfd6eiC6d7zo8aMF7q/nzai37CHpvSfDJ+akB3/QjQ5Q/x9qf15iOQvt/lt/y8FG5/Z3LKqHM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaxU/GsRXJ1e3hssIms9c4iXsb4VeCVzoHZWriyFRfg=;
 b=HnvkrqlKFsqqpfPqbF15vHthC/odOLQzKJsUShhiIfKaILJLI+j+tomQ7a+hrDjdGclZm/8lGzqSDLUGtFjInxXZce9j0me+vDgPGgXRlvN7WiQzjldRjCvZtQOro8+mvMP3e4SGubZEdB1N0yTkdNa1lugJn+vNt+OA09g/okary3sb3XSa4utLEuWagmVHKIZL42GaVmjOzY/2/qKh89vZx00i+e1o10XIQ1+DTENNBQxH9CRvPqaAwB23Q3h1ZE3nPnNupHOKWCUXCJ3xzZdiiqwEznL4hDAlO42ZUJsLnJIbTx9EhOgbUMq/esdnQA8eiyTc9meawrwOU15scA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:53:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:53:18 +0000
Message-ID: <ae21a7d7-ac4d-4c1d-b83d-3963ce68c352@siemens.com>
Date: Thu, 3 Sep 2026 12:53:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs: Match actual return type for RTDM doxygen
 declarations
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <20260903083447.2220024-3-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260903083447.2220024-3-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: dca31f6b-3dae-43fa-33dc-08df09a98ffd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|11063799006|22082099003|55112099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	A5eK3d7kWK5NjaxPnvHPFgEQdwR7M84+kaSVdezmHl66E2U/TqCLf7sYyqvXm19lZ1NkT8sPFXUrwvmZvGG4anddgsff8SRFifoHxG1VkH2aHR9wjt3H3dymjxY8TgXt5JeoQ6PTn8bLupJpBYMmI97F+Be2z9LsZMteh3QPIba83UTzNaau93n/M6HjMF0Qtmdsj01hHU7R+K7UQy2kDorsa5KYogPofjNkoTeuxzoG0tR0ZlLUKVD2lj4ozExdvNL8izFaH66tQsNYRpWnumPAFJWmogV4NOLWEZF7k0pQ/3s0AOuTqs9Jz/r2kNBxhWa5wIjOo+BFTHMNRYaTBp9M6vxK6Noyh8mAO+tuU7JQM26yIDsdboJN9/afrX62tD150N0RxG2pxc93GQIC87J5z0rzj46V9caTyEIvcwLQ56mdJqLG1GklTaPriu24xuUtME2sCpLrMC+T+oYM4xu8eeLDxTRF4S1AhCR4r3+x4vMrM2wG5z+xNKhZmsbv6Q1KPlp+VxICdQULs4puA2YEPYtQXultvcQ3SlGiYsY5cwMioiPYa3oetrmN2cm7g0uoZS4yBr2ZXNehzOZ5zeK6GbQc6z1YZxv2kIDhl1RcdaK4mqmFMuhpry/Ti4tgLaL0aQruK6H7kdWPZUM4O7BgCNRIeeKuEdcpIndEFPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(22082099003)(55112099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExOQW84NzlPcVF4c3cvNlpVbVZTYVlyYTRVNGRnYm5FKzZUdlUyckc1QXEr?=
 =?utf-8?B?YVpQL3loamdjQlJBNHZuRVN0OUhZbUFVNFdPYnYwRlU2ZDRhWEw3K21ZckE0?=
 =?utf-8?B?UUg4NWk2VC91Mmd1eDJkdmNWWHBoVkNCcXBkS0FDSWQrMVozdjl3UFhNc1pL?=
 =?utf-8?B?c1lPb0o2WU53NTZZUXNsZ1FlVFVNSmlESUd5L1RKNGxyQW1LS09jbEk2WWs3?=
 =?utf-8?B?Vm9PQkRkOTN0QTRZRmdRY3JKRUJCSXAyRW1RRXRjaTF0blNuOEpsTy94OVMz?=
 =?utf-8?B?bm9vZnRtamJ3aTNwSXNqZXFEajJSbXdVSEt2TXc1dnFrbVhtc05MNWFUSTFM?=
 =?utf-8?B?ZSt0V3hmVElCVGptclU5Y2NqN2FaQlNTWVRyWVgzbnllRDk1dmRUS2NZY1d3?=
 =?utf-8?B?YXkwekdRVVJaUElZOGJUOVF2c25qZERFd0pINjRieWljUC85Skx3c1JrMCtV?=
 =?utf-8?B?YysvRXhicE5aeXp0MnNPTHZaNmJEN1Q4dmNqMW15Y0NWbTMxelQzYWhmY3dx?=
 =?utf-8?B?MGlZOTBnd1lYRWZOaDZndldGR2tXYkltZDU1WTZhT21Cd2JGZC9ZNi9BQUtL?=
 =?utf-8?B?dFNuS1Qvc1J3V25TMW84RDJKeUR4NW55RHVhY09ONFliWHBZUkUwZm9EdHhH?=
 =?utf-8?B?MkFOREZTQ1NyRTg5bUs5R0x1Y0MyeUkrUllVYXFHUktnS29BSlA3aHROQ29j?=
 =?utf-8?B?S1d6b2ZwN2tDbytCdnpqRjZBcDlHSkU0K29zMmh0UGw5R3h6NUNreHN4cHhu?=
 =?utf-8?B?VUFieStjU3dWcHNTaHRzZU50R1M1aFlFazFUTnRoejZhaVFORnByWjhxNHRG?=
 =?utf-8?B?R25kQUl1bDUrNmVubklpVUlGWW53NXhrWGRIcFZZQjFxeFlFRU5FRG4ydk1G?=
 =?utf-8?B?dlNXZ0dkTFB4bFBrbE1nTEx2MEVpT0U3a3hUR2Fic3pOWmNOK2FTdjQ1dzR5?=
 =?utf-8?B?Mjg0bWoyaHlUTEVJblU3SjVrSU52SVAvVmFBZkx0QUt3bU1FOGhzMVRxMmQ1?=
 =?utf-8?B?bEsvb1VJQnl1ZU1MREdHUDRpOW9DNldsTDlVL2N3VTJIakZHNjN0L1RmK1dB?=
 =?utf-8?B?U01lUnQxQXJmTjZqN0c3MkZCWXdueDhSMEoyaWx2Rm1ZWUxuRVRNU1FVcG16?=
 =?utf-8?B?OFFnUGdHSDlja2VZSFJad3QwK0dzQkowTHdqVkU4UEpLWG00dURLeHBQRkk5?=
 =?utf-8?B?SEhSQnhhcko3ZHh5TTBpNnZ4TmJnR3JCKytjZ1Nwdno0ak9pd0E0bDNBNzVN?=
 =?utf-8?B?NWkvUHFxMjlraG03KzV6OXlwK2xFWlAwaG9xU08yQTNiV05mNStMWGpzRkw2?=
 =?utf-8?B?dExHdlFKOC80SDFvNXhGSWJCZmgxRjdTQzRVVUpOQ1pkOEV6d1ROa2JNU3hj?=
 =?utf-8?B?L2tGeTB3RHJUVkpFa1I2Snl5ZWFFQnJZR0JCTUhoNkJPcTAxcUlQTDJON0ND?=
 =?utf-8?B?MTc5UkFyTk9XYVdlYWdSeE0vTThwdnZRYlZwM0ovd2JzRXVCazg4VXYyRjk0?=
 =?utf-8?B?TjFFVUQxclpHZllBS3dlRkVQa1VkcVJhRlRTVXdnZ2ZJYmNhSmlqWkRuN2pL?=
 =?utf-8?B?Sk4yY1U4bGNSZXNiYndtYzBsTHNYSiswdzNpN2M0emNpKy9HdUFFTkRYN2Nj?=
 =?utf-8?B?K1diaTh5WEpobDZQVG42b1haYkcrZGdiZGZGQ29ETWdaem1PWHA4dmU2N2di?=
 =?utf-8?B?TDVxUzY4b0xNVDBJMnFscjRaTVhFcEdlaDJzRmNkV3pqYnJrWUVtb0xiT0NT?=
 =?utf-8?B?eXlIZnFCdkpUbjR4azI3cEJjODRjd3Q0dzU1aEZhZlk0aDVjSm5OTW1MYkNZ?=
 =?utf-8?B?YWJSd2swZkNhZ2FVRlVtMnFzOS9LM1M4V1VRcTAxUy93cTRHakFIU0JvZEFp?=
 =?utf-8?B?VUx5anhFelgrV29kUlNXSlRBMlBEMXd0cUNTVENCWW1ZNi9tME1zR0NDSDZ2?=
 =?utf-8?B?TFpFTVRVbzRHVjVFTHhDRXBpT0MxaTR4Z0hpbTVkMDhXWHNUS0FHL0NVMVhu?=
 =?utf-8?B?WW5mQVBDR3R6N3VNWGVpK1VLQ01PSDlTaWlOU1NvTVZmU1V5TDZBUWpCN2dK?=
 =?utf-8?B?Q2pKNHNxa214Z3dtcG0wdVU5OERHandPMFdYWWhTREwvNCtRZXU1TXQwaHpt?=
 =?utf-8?B?aWtiWUpUSHpPYkV1NVowRVpuQnVqTFZVdVl5TkZKMU9xdHdwTHRPMGc5Uit0?=
 =?utf-8?B?VlA2S0tlaEFrQXEzd2RIdHYrbnJBeWM0NllTTTk2T3ppUTBBL2FJWG9kVDl1?=
 =?utf-8?B?ODZqbFp1UERTWXJRcDY3NVFOUDJnYkV5d2Y0ODRyS056S1VFZGNSZ3d4V3pU?=
 =?utf-8?B?TUhsMG11RkplMzZnSTJSY3Jyd25tQU1HQVAyRTJuVlk1QWRDcmhuZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca31f6b-3dae-43fa-33dc-08df09a98ffd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:53:18.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBmiyuJdcxntXM6KLSCCUWvy0N5voF0O5P69JqQPUxAFz4m0xkWtDG2HhTcjf7ERkSlFqrx0ouVCkJEw+ZrMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6297

On 03.09.26 10:34, Clara Kowalsky wrote:
> The RTDM doxygen-only declarations were corrected to match the actual
> return semantics (int instead void).
> 
> This fixes warnings such as
> 
> kernel/cobalt/rtdm/core.c:420: warning: found documented return type for rtdm_timedwait that does not return anything
> 
> See #18.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/cobalt/rtdm/core.c   | 28 ++++++++++++++--------------
>  kernel/cobalt/rtdm/drvlib.c |  2 +-
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
> index f30055a79..002fb51cf 100644
> --- a/kernel/cobalt/rtdm/core.c
> +++ b/kernel/cobalt/rtdm/core.c
> @@ -414,7 +414,7 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
>  			 nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>  
>  /**
> - * @fn void rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
> + * @fn int rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>   * @brief Timed sleep on a waitqueue unconditionally
>   *
>   * The calling task is put to sleep until the waitqueue is signaled by
> @@ -443,11 +443,11 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
>   *
>   * @coretags{primary-only, might-switch}
>   */
> -void rtdm_timedwait(struct rtdm_wait_queue *wq,
> +int rtdm_timedwait(struct rtdm_wait_queue *wq,
>  		    nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>  
>  /**
> - * @fn void rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
> + * @fn int rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
>   * @brief Timed sleep on a locked waitqueue unconditionally
>   *
>   * The calling task is put to sleep until the waitqueue is signaled by
> @@ -481,7 +481,7 @@ void rtdm_timedwait(struct rtdm_wait_queue *wq,
>   *
>   * @coretags{primary-only, might-switch}
>   */
> -void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
> +int rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
>  			   nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
>  
>  /**
> @@ -509,7 +509,7 @@ void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
>  rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
>  
>  /**
> - * @fn void rtdm_wait(struct rtdm_wait_queue *wq)
> + * @fn int rtdm_wait(struct rtdm_wait_queue *wq)
>   * @brief Sleep on a waitqueue unconditionally
>   *
>   * The calling task is put to sleep until the waitqueue is signaled by
> @@ -526,10 +526,10 @@ rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
>   *
>   * @coretags{primary-only, might-switch}
>   */
> -void rtdm_wait(struct rtdm_wait_queue *wq);
> +int rtdm_wait(struct rtdm_wait_queue *wq);
>  
>  /**
> - * @fn void rtdm_wait_locked(struct rtdm_wait_queue *wq)
> + * @fn int rtdm_wait_locked(struct rtdm_wait_queue *wq)
>   * @brief Sleep on a locked waitqueue unconditionally
>   *
>   * The calling task is put to sleep until the waitqueue is signaled by
> @@ -551,7 +551,7 @@ void rtdm_wait(struct rtdm_wait_queue *wq);
>   *
>   * @coretags{primary-only, might-switch}
>   */
> -void rtdm_wait_locked(struct rtdm_wait_queue *wq);
> +int rtdm_wait_locked(struct rtdm_wait_queue *wq);
>  
>  /**
>   * @fn void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context)
> @@ -585,7 +585,7 @@ void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>  void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>  
>  /**
> - * @fn void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
> + * @fn int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
>   * @brief Signal a waitqueue
>   *
>   * Signals the waitqueue @a wq, waking up a single waiter (if
> @@ -598,10 +598,10 @@ void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
>   *
>   * @coretags{unrestricted, might-switch}
>   */
> -void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
> +int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
>  
>  /**
> - * @fn void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
> + * @fn int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
>   * @brief Broadcast a waitqueue
>   *
>   * Broadcast the waitqueue @a wq, waking up all waiters. Each
> @@ -614,10 +614,10 @@ void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
>   *
>   * @coretags{unrestricted, might-switch}
>   */
> -void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
> +int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
>  
>  /**
> - * @fn void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
> + * @fn int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
>   * @brief Flush a waitqueue
>   *
>   * Flushes the waitqueue @a wq, unblocking all waiters with an error
> @@ -630,7 +630,7 @@ void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
>   *
>   * @coretags{unrestricted, might-switch}
>   */
> -void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
> +int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
>  
>  /**
>   * @fn void rtdm_waitqueue_wakeup(struct rtdm_wait_queue *wq, rtdm_task_t waiter)
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index d9de62946..c2e7e1195 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -2270,7 +2270,7 @@ EXPORT_SYMBOL_GPL(rtdm_get_iov_flatlen);
>   *
>   * @coretags{unrestricted}
>   */
> -void rtdm_printk_ratelimited(const char *format, ...);
> +int rtdm_printk_ratelimited(const char *format, ...);
>  

This is not correct. Please fix the documentation.

Please check once more that all the other functions are actually
returning something. Most should, but maybe there is one more off.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
