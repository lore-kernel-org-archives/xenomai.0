Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBC2E7185
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680836; cv=fail; b=EWhm1QLAT44j98PMbueO5/A2YeNbIdeDdb/tJ3YA1cJZkS8zOvVnmWdzdbqxjovqm5Rxzww9IVSlgyx2CYaoaPavpRy8HZsRquWefnZ4eZqF9aQDprUESO1g8MpcjP4OBZAM6BxoIKktLPeeHI9ht7U8E4LQoQ4yCHY3JGeghz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680836; c=relaxed/simple;
	bh=VvWnmeTJH/gCy+7BQ5ZqPhqEYF/E0Z7GnJdO8wbaUDU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvQYmOb6c3GV8ScElSNsqUdJr6xAISOzz0oDHT7gBFEqU0CjW3mRD1ouM9KV9fbT2Lld+ENK6mv15RK9LDZ4Fn8tffk8Jors+MDYc1M+nwRHl6JDPQIOGLzPf+IZBvO4+Og4L82pIrHrmYA5wpov//k1zBUgNYxkm3QtBQTQbmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=b1Ic1Log; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="b1Ic1Log"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmDOa7D54JSp+WdznHGc+rB+1Hr63la59zT/MNcilEXDDz6XVtw+NR9R24axoaj/RfzUIAH/iHLWTgymoZXhD1XJv48xR89VVVKL2u8sK3//cLZBmGXdmTPk3HasodA9fcrGncuDtfa4KuafRORdRNvfdYcC6SZ3djX6dgJ1qymPfupN/RbUl70AeUUVs7c5HSJA+8Edw/BPelKzQjVbx1M0AXxedLXH1kyvxu/nhIFKldJLwbXy+3fXt2DrwVjEjjHgujH5QP0TbOPJdrzvfqdWaKAuEdm/QqonOPoAVBa/Tlx9kwqeuB8fASx4eZcNXXCG8EOSeGgtUgXswoXYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umCYnSXQVkgE6CBX9lQH6KIzE/pjdMsb9k6bUVl2LOg=;
 b=iR24OfXUZKwWYxZZUYzHEqTcs3mx24/RY5XDIfCp2SxkSUL7kL3yyzEDUazqitzYnm04QdeBtl+dUfmwezH+sX2s0A0z8fiKl7fmLcr7T6yY8ytPO3QieyNgwQPzg6kfymFTaXw/ZDScnvQc+xUPcgk4V7GL7wQMS9BToCdyxlyeTVXY15R3XUBylKKv/9kplAEQln6QS6rFRzIx9ANSYORavA1c9/olNtmQ1yjpYl4PwcixKM3k1mXmuN7jq8D4342+CZuNbAHrmmijuM8081+VVW6geATMk83gHZExGzGWAuGXSrYj+LeZ4WUpIycI5kQeW4A4WXW0uGSFfS1Uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umCYnSXQVkgE6CBX9lQH6KIzE/pjdMsb9k6bUVl2LOg=;
 b=b1Ic1LogONi88fVuacdrDD+UUw77Ur4oxvGii/+d7uqYTJma/ySyZuFuHdKmzRUApttn/SMXtWm09OCAVrqBUKDwPDTOrlMH98qsS/sduqU3ns5HIF1DDKnoBXIUV144RGI8j1I5y2pJ3k0CM9/xedvwgx3P6/D6AQrm9Hg0GX1ucjiQE30fLKT8ZCtr+k45AkWV0rwKJcucorNurwzgKBBYwYsYCuObguHnz2bgR+L7adGQUmpZgm3U3naP1nkn/mO8isJRJTCkQrOGyFPtQ4e4Pg9BA5Pviqr//WCtMqekeDZ1GXT+DG5tYmThEvCFkVs1xj4WeWIgqiTAA97qXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 14:00:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:00:27 +0000
Message-ID: <2b4cfc7d-1f9b-4f08-99b3-daefc5e6bd2d@siemens.com>
Date: Wed, 13 May 2026 16:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <20260513-wip-flo-gcc-16-v1-4-120ae1287401@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-gcc-16-v1-4-120ae1287401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b902f4-db1f-440a-ff14-08deb0f7fc85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|55112099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	mfBsnQpoA4hm6IE3kYl/uIsrIDLZvwSfwEFVzbYTJNbK5rV/wHAhVFHvAQERqjWXH9a7IFrXUWnl+w5eCBczmQa4j9PtSIjM/vuOfyCtguWw7/a5A+FiKoeOfJHflDKZB7JghK2SEFMmeBV5zIuMmPjRu//ysw1WGahcWzXUA39jofq+nCObsJdp/gZwZ5lu5F6o+4udcfnav9P2LGChcZCtnLICzbPPbIC0DLIBfP2IiRi8PBC/k5NluA9AKGaW/xvTOhzftzYuCBVKLJYTpNU9xSHud+715LT7T++0exHiQMxxJE0A2uNdcwmYZNVRH/7Aho/Im1Agypf6jg2CTKNaMXGOAOa5jThWjvrh8K8dB/94g5+XsTF4sLBWSbRMf5rDn8EVO+zYyxWxdnzMwE68W8j0u/sBr+MPzc0pmWLohjg8OytOnbmy8zL3xQCNoI98VzU8zpxNsqOtrGmNUL4xVivorCyucMWlLnq6JiAn6EBoYv8qNtyv4vkccDPOOxNZgHs6VIb68v0WqNFM72Xt0d7HpnRwf3XTsuzQf8iB5ZXwm+t6wvEpNu3hEkEYVLINuNiLyEWIPp1rKjhjECGcXJtJExGFFTzpHjJIc0AZ0SJBi0pluWNrQxFrO/50vY8zQVfRZaPYd+nwhdh4kZle15RrZLTnJJ0AGOu1yYjgqdGMufDv2iPfP5is/kP9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdVbkhRTXZtdzYzNEsxdHFPYS9PODhXSEtVTXlDQkVOeDJzZjJ5ckJvN3lN?=
 =?utf-8?B?R0g5eWhmbjBVSEIvMkh1Vnl2SFpRY2ZvQXIzU1dKYTZlZCs3TkxjbHoyRzMw?=
 =?utf-8?B?eTFWOGw5RnBiTEdGbG8rQUdDeUQrb1AzU0dZWUxmWVJCUkNOMGxIV0U3K1dI?=
 =?utf-8?B?NDdRaHNrNHVGOGRSeXoyQnM1NkFRNjRISGdwbS9KNlhPNlB1Tzl5MzdIUDIw?=
 =?utf-8?B?Z3NocFpjNUlRQlJ6ZkppZStieXlYTlAwTm9ZR1cyYWd5NW00Y3Y1OFlBaWdn?=
 =?utf-8?B?cGZJdnozdEc1TDBmaDFVcXdkNHFFUnZpRUQzeDlsbW1BSTk0QmVEcFk0eXZk?=
 =?utf-8?B?N3NkTi9ockM4Z3VZTVZkbUVmclhzSTIzS1BZNzVrNERaZ0hkN1Fsd2h1S09V?=
 =?utf-8?B?R0dnNGlYeE9YdlJwSmFsOG1rU1g1NGM5YWsvR0tzZ2xPcXBDNFpldW1Cb3dt?=
 =?utf-8?B?K1RmSS9QcVZxUTROQ0x3YWRUTXFpRDhOVzRjTUFzWGtFLzEvclB6UXBUcDIx?=
 =?utf-8?B?WEdxeHJVU2FJVVBoNEtRdjRjWUU1OEpMRkxaNDQ4VHZoZDNWWG1jVXpIek1q?=
 =?utf-8?B?MURzcmhzY0NEdytsa1VoM2l3MTQyOHFsbjBCbXhIRkNaY0F0M1hvUHhOaElv?=
 =?utf-8?B?TmlVV0h1c3FzRVVuUE5TTWd2NlMvNDdWWENBblczU1lXbDQvRGJwaStsVWsr?=
 =?utf-8?B?M0lZbkE0S3JzL0tldlFud1VMdWVreFhvMFRmR1lHK08vVDVVUEUzS0NCaXJP?=
 =?utf-8?B?M0hycG9jd1laU3liOXVXZjRjWis1Y1p2VnZhV3g3dWdFcmNjY1h1UW5pMVRv?=
 =?utf-8?B?NTNxZ3o2WkpNZWhHVUtxTzA4Yys5VEg2aFRjelFUc3pWK09CRnF5NkdFMmhu?=
 =?utf-8?B?clIveFJjZ3RFTG42Qi9TNTNiSlBUQ3NqMmxEZzY0Y0UvbUZ3dDlMaU1leFV4?=
 =?utf-8?B?TWd5MGFmRkxCcmNBNzI3SHNXcXZ1dEthdVRONlU5UFBtQTk5RGhmVTBEbVhS?=
 =?utf-8?B?MFJJOWg1ZnhhV3QrcmZMZ2F4NjZHc0FpRDVJK2hTNnhsM1Ewb3FZR3FwWVZV?=
 =?utf-8?B?YUcxdTVweEw0bmhBZUE4T2Y3THc5cnZFZ3lMQ1pOV2ZLd0VOTGVmbDd2M0NL?=
 =?utf-8?B?eHBlb0NXWFBWcHIyekxObmFLdlVaa3lRQWNTUi8wNEhTV2cyTUlJWC9BcXZl?=
 =?utf-8?B?RVl6azAyaC9MYk96clIyZDcrT0MwMHp3SmlsbUMrRDQ1QUNzanVNQk5JZitt?=
 =?utf-8?B?RzdYZm9IOWkwSDBNUHpzQnB1RUl1c0tDNS9WY1NiUlhBOHAwYmNYa3ZIZVIx?=
 =?utf-8?B?b0NTZ1BCaENET1lvZEVENnJ6RXZrVFBDRy9HaXZzQ2FiOTY5cXhGMXNkdndK?=
 =?utf-8?B?RDJTNEVieldlMklaRWUvaXFNc05VOU5qQm1yTnp6bDczNEhzNUk3QkViNUVq?=
 =?utf-8?B?cUdHSzZFUFZQRCt2U01iT00xZmVmeXpjcTJqaUdjYllOVTZjWDlHZmR5cnhF?=
 =?utf-8?B?RmpadWpOeERhdzY0ZEhFTEF5dEtXNENxcHEyUzkyVGJrMjk5R1ozWWQwUHVq?=
 =?utf-8?B?UVVjT3p5aWdlYmRhVENhd09Rbks0d0VNSGR2MEFOR2Z1N3dlcGw0NlhFQllr?=
 =?utf-8?B?bnVHT3pDZjRjbmxTUW9wZDRub0lMcmlWbVlmQzk4dmVvOEF1aVZwS1hSWm4x?=
 =?utf-8?B?RDVGMjhnUENUdENUVEJrWkVsc09DVzhjME1tMkwwQzl0Rm55amNCVnFYZFRI?=
 =?utf-8?B?Q1dnSjZZSmpPc0kvVzV0YWI5Q09Gd05lT1NMU2k2MDJ4eGZzcEVHYnVLL3Yz?=
 =?utf-8?B?QlB2ZWVnT3Z2aTh4WFhuTGNCcnBYeU5wNlkwbUNOYWN2L2NnSnFqeXNEU3JU?=
 =?utf-8?B?SHg3bXc0amFma2pQMnRHRU9WY2tISzgzb3d5OW9Ba0YwNy9BajBNVURNZ3hZ?=
 =?utf-8?B?aHRCdzZxNUF1UUVTTEhjdm9FZ2lQU0ZrQ3FHU1ByVVU5TldJeko5TmxCTkJJ?=
 =?utf-8?B?c2VMUjRFaUppa0xQbzZlVGJCeTdqRnYyMkZzS2dKOCtDZnBDOEZRM2JnUjQr?=
 =?utf-8?B?L1UzNGVwbVlyM2FGZFJzU2ZGV2NWYytZRVlqM3RmcG1zNDh1aVpLSjBYaW5G?=
 =?utf-8?B?YVJxVFBsUmxpTnByY2ZHdWRQbkNlMTc1TWMrNC9SZjZIZ013aTg1TVlaMWlz?=
 =?utf-8?B?TlAvSTBKK2IveFczaFFwVlFUcWpwODFOa1BNbXQ2YjhhcnJIa2NxSjV6WlNj?=
 =?utf-8?B?WHIzT3FEcSs3UlJ3andlZDMvQzdybmw1U0t5WnBwWnZ4L0RmamQyUGQ0ZnY3?=
 =?utf-8?B?ZkpZU3h5UDIvOWlwa01PZUx5SWJtcXpNeEdhNzhvWlF3MElHbFJuQi9hOXVl?=
 =?utf-8?Q?QzNFKsVGeSWcJn78=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b902f4-db1f-440a-ff14-08deb0f7fc85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:00:27.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3SWOvG1/JIaN3aMKxs+fIVINLEhm5Xjwis5KUs4xk969FfNN0NRfvvo3UYd3M2d3gmbkXVMtRjICCzDEko6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7548

On 13.05.26 14:50, Florian Bezdeka wrote:
> Fixes the following compile errors:
> 
> rn-1.c: In function ‘alloc_task’:
> rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>    16 |         int ret, n;
>       |                  ^
> rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
>    15 |         u_long size, alloc_size = 0;
>       |
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    19 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/psostests/rn-1.c   | 7 +++----
>  testsuite/smokey/psostests/task-2.c | 5 ++---
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
> index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
> --- a/testsuite/smokey/psostests/rn-1.c
> +++ b/testsuite/smokey/psostests/rn-1.c
> @@ -12,15 +12,15 @@ static u_long tid, rnid;
>  
>  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	u_long size, alloc_size = 0;
> -	int ret, n;
> +	u_long size;
>  	void *buf;
> +	int ret;
>  
>  	traceobj_enter(&trobj);
>  
>  	srandom(0x11223344);
>  
> -	for (n = 0;; n++) {
> +	for (;;) {
>  		size = (random() % (sizeof(rn_mem) / 8)) + 4;
>  		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
>  		if (ret) {
> @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  			break;
>  		}
>  		memset(buf, 0xaa, size);
> -		alloc_size += size;
>  	}
>  
>  	traceobj_exit(&trobj);

A ... non-obvious test, but it looks like those vars really never
contributed anything to it.

> diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
> index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..dfe9724a8325b821a13c34c9ddaa3aa4a0e37073 100644
> --- a/testsuite/smokey/psostests/task-2.c
> +++ b/testsuite/smokey/psostests/task-2.c
> @@ -16,7 +16,7 @@ static u_long sem_id;
>  
>  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	unsigned int safety = 100000000, count = 0;
> +	unsigned int safety = 100000000;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> +	while (--safety > 0) {}
>  

Same comment as for patch 3.

Jan

>  	traceobj_mark(&trobj, 3);
>  
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
