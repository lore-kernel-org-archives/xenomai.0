Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D97580A
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357635; cv=fail; b=EvFYOXNMTt7Y2m/CSm2eW6tQZhNQxDaMIelTjFhzhh15/+Dhtt7qxo6i6MDbKYYpdLRogfl+lt5urBS5T+5CFhC0Gz9MPSOfP6nN8BcBHE45aoCvM6bz1JT+PF37kbr6RScfa/w2gs+bjX8vuj2We17iNohwL0xEJOyR+/lwf08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357635; c=relaxed/simple;
	bh=qQO6uOgSkziacwhPXq3EZg9t/qNP5LuYwJ8Yrvljz9k=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=YBUeKZ76yJQovOpJK1gWvuAhcm7d1SCmPFtxr7LmOHM6J6PhR8mA2yRJBZO1MFs50rWN68EJw6Fkp3HbgJRorNqRAwxFywhEcIH68xqucWBoDVrQOgrROhi/7fdQp+UOnqu0w3QFxxAyf/+/jUwtJyNye3HaGNtsPOZLKS0qK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qiS5Pm0e; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qiS5Pm0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyQllgad6/ZL1I5g26S2upQ8qAwhp8IifP6qOsq0jZ/aUgiFWLnhn5BdvHIziJQUA/n1Me6LPiPuHu3ssuWqHdZfRZa64R7xyKVNOQvLHVb7jReQKf6WppBVhHhlzVg/+sJxL4nSH5zeeUOqUReEp6pgEPyP7u7+IZxoeiiUmKU0DyOZvCyWB3sN3nWSiVZ7JxsCWvK54UdJRLUykWDx2tJfZax/cWnmXPka02kgDxUykaIuAEj7aUTAZlVW5VwODU3AeYT3fN98l1myZUIjgifB/XxRK4KgqsKGmJMLqjbnbKS07tbENT0ulR5rzQ8uq/v8flh07807yn5elBVL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CbVAF/MR+In9Q4kZdBCByO80XJWPBShVvqyGaM23tw=;
 b=ZIfmLZm9JZ+jkci6tz2/ACw617/4w8y9+MH93P2kTLmhTrvQM4hglCMv/kVKfp8VfwJ8O/0kzi5qEYHGQENZCkDRB9KrRXUw0mjpSX1WeVgbqM6qKXYGsOxfXWkH9hntMLg29dkDCGNOODp6XjX8DJn3nKdWrhRsLjH3BCWxv0Emj0RAOgvzPqqee+eowK4G2qeNUZ6o6rqMzItK/Qk1j+EYE59EY1hLHxqa6KjCs6T8z60T2AiI1i7WNxurZhYaht14OCOLAGbA/gGjPBtJ8Tag888y5q9S34l2Fp/CbARd4VF/sw9cSEve3qljuf1jdHZlnt4WNZbmhKC3hiIN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CbVAF/MR+In9Q4kZdBCByO80XJWPBShVvqyGaM23tw=;
 b=qiS5Pm0eF+sNiKrbVqt3iJdP150gZeDxkZ8/zfYQdb7i4KLW22zh8xtMkYGH6dhJ3O1H860xWYVPKVNzPXCleHQ6nJ/+4yMn5KEJ8FxCLXkOtj0IWPuolhOoKopLs1PTD6gV8Nvy5TkL5cLODhKInPsHEN772NnJ2s6spsqlvSz9tVEXNmDD/EKy99/YSJy93JQJ7uAVTh7k8qynZGFzSwrM47mLx0MrbPOmtRq1ViJ4LauA4/4D2ZNIEO9FlQOeyywSuMLpBe8i6Xr9JtlJl4HAbQImV3i821M3z4MO1JhNPE19YguaTylfmFs02I5OnWKjN4mg/1d5QwKnUNuV5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:00:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 06:00:26 +0000
Message-ID: <fc9137ed-d2a4-41a2-98be-2645255ed348@siemens.com>
Date: Wed, 22 May 2024 08:00:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers/gpio: Account for changes in kernel 6.9
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 185b79f1-a6bd-47c2-6d25-08dc7a247a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1oxdWxRQjhEdWttNlFiK1dsdWNoNDI1V0NkWFNXQ1dSaWtaMm1GamJMSWZH?=
 =?utf-8?B?bitLM1VmdHFVRER0ck5vNnFwZjVvejRiaHFhTEF2ODZqazJVMkRobng1aEQ1?=
 =?utf-8?B?eCsrS2huRmdxQUtXZDg1cWlOak1RS1F0T0lmdFIxWXRtTFkrOG5Nb2tZYmh0?=
 =?utf-8?B?SnE4Q2JNaVRaYjJnMmxEUmdDTTV1SkxmMnRjOEt6RW5OQ1BIbjcxSmtFZlFp?=
 =?utf-8?B?VUQ3RTF4U3ZVTUNwaHRxTVFNMm5BVmJVMHZlRFJTcTA0L2ExTHk0M2QrUDMx?=
 =?utf-8?B?bHBIUGo5ekI2ejFuY0JCREwzQkZzcWN3ck1KTjJMeEVITWxQNDdUYzZZK0Ew?=
 =?utf-8?B?MmV0TUU0dTE5RGxtMUE0M08xWkt1YzRtNUgxbFRhRGMxaFBOZUdvVkRtZGV5?=
 =?utf-8?B?dHhrVUY5eFEyUWtDdFpUY3U3eHZVVmFRSTJxcjNRN0o4ekFEMWxpZFEwTGlF?=
 =?utf-8?B?dkQxdVlBWHBXb3YzN21HZTY0cHpKTTlUY3Q5MVZTcWdsOFp1azYvUEg2R2xu?=
 =?utf-8?B?dCt0SkdFTU5vaFdYMXUwc0FaNjlUd0hwbWNTaUtjODA4Qkg3cDRwNGs5Rmw5?=
 =?utf-8?B?clV1anEzUG5CZ3pmaGpJVlhTSG9CYnhQaUx4UHV4WnNkU3FMc2tBNisvM3Jk?=
 =?utf-8?B?MW9xZGMvN05SZys2VWM2OGZiREtHUEpXYk9sRkY5RzZGa002Wi8vR1pKWWQw?=
 =?utf-8?B?aDRTR3pZZnNTcVo5T3RUQWhIb1FtK3FGNEJZTG8rY2RKZklNU0xLV0ZJb3Ny?=
 =?utf-8?B?NHp4NGYwZUVPNi9jaEh2TExVa1NxZUdsd25VZU5yZUpCZmt3RzJtb0VibEpP?=
 =?utf-8?B?UUNFRFpsb1AzZm05aWtHZmo2T1R2WjZ4R3p2WUtvbWFBd2tQSEp6UTVNVVRH?=
 =?utf-8?B?d0NKS2xNVVYyVmxKemJSd292b3JUYXYrMUowRmJhYzZWZXYrVGZYeGZtU2JU?=
 =?utf-8?B?VE1WcmUyMzh2UkhHRWFVYWNETm1ZNk9RVjNrY29FMTgvSXloK21ia1ZIRjE3?=
 =?utf-8?B?OU1JZWphb2EzZkxtVi9WT2ZUWjVrOVhraEJUbVVvYlFyV3k3RmEzT0t4ZWRy?=
 =?utf-8?B?OE5kS1ZDVGxROWR5MmpFQ3I0SzBPbTMweWJYT3lSMWgxZ2tGRFo1MGFYQzRG?=
 =?utf-8?B?d3cxMjlmM2pNSWpzME5KcGRoQWg4TFBWWlRkdlhzT2ZidEk5VVhxQVVCaDl1?=
 =?utf-8?B?dktydEhUMlNPMHZhYW1Pczl2QW1jL3l4OWZCbHFoUEVKbVcxZ0dRV2hJbXVX?=
 =?utf-8?B?RTZKSGJnZzNCRkFrZXhYRUtHenJmbmd1b3p4WVVzK25LcE5iZHVRblNrWVBE?=
 =?utf-8?B?cDNYclhhRk1adnMyZUxiTmx5dDVySlkxWWtIT2pXcVAvVmxXYkhFNWZ1K2Rk?=
 =?utf-8?B?QzVlZnR3ZzF5N3Q5MEszSVF0M2lPKzlBL1J0V0V4M1J1UXROUkt4d01WNWs2?=
 =?utf-8?B?c3ZNYnZSbXRybzY4TkpTclpOMmcrazFWaDRkUldWeVJoT3djYnNxYnZvOG1h?=
 =?utf-8?B?VmUzQTBtRkl3WDdFQU5wQjVaSlk4d3hMTjdVeHJib1dpa050bElsRUcxVlVD?=
 =?utf-8?B?U1JCaE9vNWZKVVZlN21aNGticmhCRzBBT2h4ZGxLVEZaL2JBeU5md2h5V1Jl?=
 =?utf-8?B?RHRKaXRHekZYeW52QmdUUDNXRXZSRWJleStQZGhMM0xRZGFqa0FvSDUyVTBY?=
 =?utf-8?B?UVpkcGNlTjdxS01NR2cxOGs2YjViYU9KMld0Q3FuaEZVbUtXeVhWcXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZPMVAxb1ZSMTFHUW1IVXN3dm9RM0pyQ3VEZU9jYnpvTEdYbytvWmwwdlQ0?=
 =?utf-8?B?UExraUVQcTVnKzloZ0JPTW5kY0FwNjVQZHZPenNEZWZnbEFOemo2TmVaWGtL?=
 =?utf-8?B?QTV0ZUZ3Qk9VSlIyeWphbkl2M2tja29FSkF3R3lXRktNempzMEh2OGowd1pQ?=
 =?utf-8?B?ZEVzRURTYm04eHpFL01XTzAwNlZUZ3JQWmJpeVhYWXE1bXBJN1AwaGltcTZT?=
 =?utf-8?B?TU52K1B1Q0U2ckx2OENDWTBsNDVEcERQRTNKN2tGcG1nc3FqTnN5WGRNTk1S?=
 =?utf-8?B?Tlc4Szl1dGljMEZuSzZtYWprZVgrekxwWXJBSDdHRXAxQmZWazVUK2tMOG5i?=
 =?utf-8?B?KzJmalJzS3gydEljMEpKR1VCSXhVSjV0bmY2VFJ1QmhQeDYzRjlMVlVBeThu?=
 =?utf-8?B?Nmo3blRwS0s0WjIyZnJVVTRtdzlQc202eHlGUUJnWXlhZHVBd29tOGdUUC9s?=
 =?utf-8?B?S1R6SllIOWtLWTBvOFAzWUpMZVU0bzdWVHNMcUZPUmdjajdPV25ENllIbjJM?=
 =?utf-8?B?ZVowRk1TV2NLWjdnSVg5ZXU0Rzd1cWZIZ1k1bGZNRHpLajhZUUlROE85dDda?=
 =?utf-8?B?ZnlYSjlzM0xTSWdEdzk5Mm5NM1pEd3NCZllSZUUzY3A4RE5acVhUTE5ld2RU?=
 =?utf-8?B?MEFQb0pHOFpKNHoyWWszWDltNnpBcVV3NmpKRm9waFRIMWJSajhKejFrQmpn?=
 =?utf-8?B?d3BMc081Qjh1MExYQnNYbmg3WWJ3cGQwVEdmWWNvMGhENXNRYmRlM0xqb2pY?=
 =?utf-8?B?SzN1QVpDbllBa2ZqRW84cHhoZXF6MkRLUlVTbXJPRmZCRHc3bk9uaTZpUjJ1?=
 =?utf-8?B?ck1ycnVGK1N0WnNFQ3pDNnkyTjd0ZzcxSmJFUUJmbmJybHdLcTRZbDJCSC9M?=
 =?utf-8?B?d0lRRGpjeUJtOUY4emJGYnlpOUR4dXMwMGRZbmU1WE1sUGpQckRqZDZ0dVhp?=
 =?utf-8?B?QXhyUEpRajNTb0JLZjJod1c4bDdzR2tzSkg0UEMyamI1T1RDeWRuUE9TSFFR?=
 =?utf-8?B?SW9YK2ZIL1RyOHJ2RVFHV3owY2FtdHAxaVBNUnhzSnF3ek5tNkpTcU5yckxL?=
 =?utf-8?B?RVp0RFdLTDU1VVRHUG1xK0Rzb2JUOVkwekwyR1pRYkVtK1RvM2NiY0xnTGF4?=
 =?utf-8?B?QURmRUcrV3ZvQVA2ZFZJdGdtc0VmY0dTZllhYTZUNU9sTU9oZjh4UUpwVEVS?=
 =?utf-8?B?ckU1TEY5Qm5XQTdjSkMrUG9uRHR0WkNBUmxjajlheEY2WSs4WGNOM3A5Qmdq?=
 =?utf-8?B?MHhCT2w0QTVJVjdPRWtTNmQrWmhGY21oTmVBOWtlTC92bHB2L3M3N0tOVmxM?=
 =?utf-8?B?NmJENnJTblhCZDYwakFTaWEwU1lkRkI3TStFaDlxZk9mWDFzTzgxSk0rRkh3?=
 =?utf-8?B?L1NsN3hJdUswbGxtOVdrbTZnWlRpRzcreFF0cDIwRE5OM3FtdDk1c0tWZkcw?=
 =?utf-8?B?bWxUbkVmcmUrd0NLd2NISUJ4ZW0rVThkSHhpT1RTUmZNYjBmZTd6a1huQkdn?=
 =?utf-8?B?ZTluUExlVTE2ZlVGTTF5dXN4NzhKRVZrS0svZG5wVDdrQlNFMzNoMUdsYUVP?=
 =?utf-8?B?aWpTQWVPTWpyZDhkNDZ1dU8wL212YzBjSnovd0w5ZEJVWGVMV2RrNDE1bWND?=
 =?utf-8?B?WjlrV2N1SU1NV2t6dnVmTXorc2E2MHVRSnYyY1FZbk1wS0hjOG9DMWdHZEV5?=
 =?utf-8?B?WFN1VU5OUWZWZncrMHFQSmczVTNOVUlOV283N1hqTW9mNU10SjFrK3czdUlu?=
 =?utf-8?B?ZWVNQ0hnNGlyeGtUQ0ZKVzF2ZU8vazBBVFd5RHUyVnBEN0grbWhhTGx6akNl?=
 =?utf-8?B?QkhWb2dzRjFFKzBpb1ZsSEoyUUJwSlFsNy9uc3hTZjJWbHVGei9nNWNaa292?=
 =?utf-8?B?d1VIaXcyaXowV0hxd1B1bkdtRHlNRlBlUjdpZlRiYXErSnVnd2dqMTZMOUV1?=
 =?utf-8?B?NG14eGhoa2YwV3dtYS9JeUd0QjZHZUlHSkJKaEN1VGJtUUd1cktpMVRSQVIr?=
 =?utf-8?B?eWVuakJnZk15Z3VwQ0NTZFhUSVJoY1pVOGRFMC9vNW45djhRUGVmWHRIUEdS?=
 =?utf-8?B?T2pJbndPQm12Ym56SXAyUDVnZ2NIT0k4aHo5cEtPN1RiYXpXa1ZNMSt0NVE5?=
 =?utf-8?Q?pX0tWVG48fU8Mn925Afr6gHnm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185b79f1-a6bd-47c2-6d25-08dc7a247a06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:00:26.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXS+Tk1Q02y2whsMvHc3Hux+ePPpjAaQQRZDj08gCGwgS9RSB8ZBhymW0FbcHJ6Y003NZq8t+CtUdERIRguSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5864

From: Jan Kiszka <jan.kiszka@siemens.com>

gpio_device_find now takes only const data, but we are feeding in
structure we need to modify - typecast accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 5cf59c4688..a3cfe66ae5 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -610,9 +610,13 @@ struct gpiochip_match_data {
 	struct list_head list;
 };
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,9,0)
+static int match_gpio_chip(struct gpio_chip *gc, const void *data)
+#else
 static int match_gpio_chip(struct gpio_chip *gc, void *data)
+#endif
 {
-	struct gpiochip_match_data *d = data;
+	struct gpiochip_match_data *d = (void *)data;
 	struct gpiochip_holder *h;
 
 	if (gc->parent == d->parent) {
-- 
2.43.0
