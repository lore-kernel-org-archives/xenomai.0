Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4318306A
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240797; cv=fail; b=Pcfw1JjjY4/ZDPVnz9tPpNfCDzRv9fTZoPSONHwH6fk9EgyzxaMM/WDDlH8UbzV1VQNWiHe6B3G4MSLaZNk3bDPTkbs+r0Xq3XkpX5rBLFJvPsyhKpJo453Ke7RZugqenCq8HAyIUVp+8mH9rBR5bMpSqFUstLc6U5Z9w1+PVtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240797; c=relaxed/simple;
	bh=ohVWqNfpwSRzTJN0s3l+lGFnWwVqL3xPfOCWwsJ7IOQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Aik4nfg5hyXMFBid6CENeT4w2eBsV4fZTLJR5HtL0i9Ua8+BQ6iWkbkpcO39SrnpBfS//WhLAij5Y5n/mK9EKUjR4Htkv3oq+wDqEA4B2jB4PdfeVIsezbv5ExA+3X4EgOfai3dZbhLdkqC7FufhKSi6cVyC+YEO7vIYsSwFpF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v2EBsxhU; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v2EBsxhU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbKo4Nl9jpJ4q2e2bzG9EOodIqKprbCDfLZrF3A9BXOErp5pVfEpr1ueufExvnmvnKIIzspCEZQ8rBHdrTjeejKynbghOnJwyHdAjgnfymn0MER2Qhs6bLtxD9ReQjjc0u3rS4O8vIRDzhZyGgtEQn2uebxQnEpNRWT8LiEbuDmRfXrfKFBjiipjkkooV5/kCe92DYxlOztkNBjFNttBG4PFo6wTuBsrF1bqIskBhVmi5Avy9olEq/tdde1mHLPKyHxXZ7JN9Euoqb/W8rNQkH4517P7OjHKig94ZlKDdiu9OdT9h5zH2NN23x0u9ylAhDYN/jTtfQ+Y0OOGV7FivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmCYhBWI/7WO06mSWmB/mtzyWx+pK3JR9MnNl8RFXj4=;
 b=Xo7X+ZyC7GJxCDa2QOuE8o8QGpT0W8cGS+xC+mQAxYaGDX7w8Kr7drTeY/aYKVTvlvSd+25Ct1CsNGTKQLVKoKUtGleMhkzLhe7OLZ7UmwpGAJ9YjZCZPn8QjPwkHP5Pxp2Jx3ZQ+GwkxBhr/cYbNsXeFs9tPPFpiq2PKcdtnztvA5OVQaXwGj5gMWGkHTDsVyWQss5ynmYSPZF3CFvRW/8kEtcmlexZD0ouRben2XpdgXYjJmPgaY3FVWKaDMgxh5iiwYKjIJHeMbvsHts/B6vGAMVfYGCg5ILz09vxHHJOGM7ijH9KcsDVn0uuXa0enOCzRZ/d36NknUHH/6NIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmCYhBWI/7WO06mSWmB/mtzyWx+pK3JR9MnNl8RFXj4=;
 b=v2EBsxhUwrQe+h6tvlqEsfyclwcQTxfVUP0w65H97xehtsEEKUP8SRL2OY+V63zAoKBkwjD2BcP+3eiVNQoXy1BWKGUokcA3jg10NT+huWuwYAS44hfNdlbSeQ0nzHaDBN6Lq68sym72vcMBbXsBOUn8v1taW3XN1TQrwPthWBBV1twZRM9/h82AwzS5jhk8C+j8GKGDTpfbxHb0GrXHPctr4MStAdyykxu/pzBocur+81hcle91aVLkE67u5fKmieJXEZ6XHDARe9azAkSFYskTjWjTpb4ZnqHa05IsQO/XW9jETpLiplcrYAROCDiGco+PrYOJUoMa8a2ImZmBmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 18:26:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 18:26:28 +0000
Message-ID: <f8383caf-1549-4623-b116-39c51f2e97e7@siemens.com>
Date: Wed, 17 Jul 2024 20:26:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: ada11227-bdab-4598-9923-08dca68df9a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TSt0VXpmb2drZXNIQVd2dnNEd3VxanYvSXRaLzVuOHpRTmN1QTBwZ01Ybi8z?=
 =?utf-8?B?ZWVPV1NtUldhMnJ2a3FzUXVtTUN0ZEZuUWNwbEJqbmdBNEIzUVhBbm12dVp1?=
 =?utf-8?B?bzZMejdkVC9Ea21tM1k0b3pWZTF5bEFKUWxXN3IwOEQwSTArVzMwWVNiZjBC?=
 =?utf-8?B?UHNLNzBmVDlOUnBkSE1BREdESmtHd0h4NVZvUzBGMWNYU2hQUEtLWStYcUoz?=
 =?utf-8?B?QVJJOTA2aFVYZEtRNWFzbkZ0S2ZHOCt4Q0RtbmlidmRWVEMwQjl4NmFjclBw?=
 =?utf-8?B?bTJtSHVqL01ndWVkNEIzYzgzQkhhb2xxZWQvNG84K08wZzl1ZjZxKzF3bENE?=
 =?utf-8?B?MC9GZG5zRTN2VFBIYzlBYnQ3Q1NiRzZ6M2h2VzR3NWZFVFF1NGlQLzEzRFQz?=
 =?utf-8?B?ZWVlZ2dPRWhFRmFPc2dHMjd4WEhNWkVjSTFmdzRoOUxTZHZhcTkydTlVM1BW?=
 =?utf-8?B?N0UrMzRubDRTWU11cVM3dXQ1WS81eEdkTXRHeXFSZHpkRmwyVUxDK3FxeW90?=
 =?utf-8?B?QnpBOWNLZG9WanA1MlJaWFYrcHhEN216S2Z1RWVEWkgvTksxTmV2MTEydC9K?=
 =?utf-8?B?K2Z2N3hueVVnWG4zUldSSXNyelpHd2I0cWRsU0EvWHhRekt2VkN6aXNEcEVI?=
 =?utf-8?B?SDFmT1hncnFkTWg0QWo3RHpIcmtzc3dPMnppa00razE0WnZpN1crY24yVzlQ?=
 =?utf-8?B?YjYyTVpDdEkxcWdnT2RpNHJzWnlyenVydEpXTXFZZEtCS1NUb3IwRU44U1ZS?=
 =?utf-8?B?WXE3UGtueTlabWFaalJKUjNuaXVGYUpCbHNGTEdrWXd2dGlPL1ZsY09pMits?=
 =?utf-8?B?dXBsK2VLZHc5QWNTZVpuOVk1clBLS3BiTC9XZGcyVVFSUzVYa3ZNZHd6dDhX?=
 =?utf-8?B?T0dNTGxPRU45OG9YemExVFloRzVyT1hKNm5jWm9NcjIwWC9pbzh3UmJKcWJG?=
 =?utf-8?B?cjFPcURLY3ZhbE4rcm1JMWdQbFppWXI2TE5sdUFQY1hLNEorMzA3QzY3S1dU?=
 =?utf-8?B?dWE2M01xQUZNK3FIT2pnRzMxdWw3OGpUU1hRMm5SNG5qYUZ2WDRiRnZLdkhT?=
 =?utf-8?B?Mldmay9wWktVRWk5cGJIdmpvVk1Kd2FyaUtyT2VUSVM3RHBJZXNSVEdXWi9L?=
 =?utf-8?B?Z0l2Q1Y5cHRQV0kvNzk0bHB1cmNsZEQ4QjlmQURYbEIrdFlPeVlEeWFtZlk0?=
 =?utf-8?B?ZjdBcDdRVzJGdWZ4YjNvVVdPZDZVdjZ1VDBZdERPRTdqVHpraU5xcDlPUU9q?=
 =?utf-8?B?SWgxOVhPalJlSU9NUkkybDAzc0NxQ1JubThOWVVVTUc5dkRQVVZrSmlxU3NG?=
 =?utf-8?B?eXluOVgvSCtlMDY4VTRqN1VMbW12RGJyUERVRnNXdHkrKzdDWW5OZjRHVTdH?=
 =?utf-8?B?MmJIWk9JWitsSW9ueWwxL3VQaUFJUWFSQytIb1ZUNGQ2WFpNalNJc0M0Vk0v?=
 =?utf-8?B?OWFoRVhrWHUrMHhXdXRiUVlMaTZNU2JwZlFHK0N3cHBHL0VYVDFvSElmZURD?=
 =?utf-8?B?R0VoQXU2S0dJVER2V2VlYVhkQXBxTms1N3VLUUJRVXNCTGNZUkVjZnp3RHFQ?=
 =?utf-8?B?VVVZNVFqcUh0bm5HeGZ3UGNrQ3M2SlE2RE5wbXJHRVhSd1FlY3loV0FkeHNV?=
 =?utf-8?B?OUZRN3NURDROSDIrUktPc1NLY0xvcHA1TTFZSE1XV0FXQm1scDZ2M2E4WDVQ?=
 =?utf-8?B?WXNuNVE4UWd0bEVIeWZjWWZ5ekxQRTVUQWd4ZkN4eSs2UU5VTE1Uc0M3dDJq?=
 =?utf-8?Q?l6IrlD81NbJ4IQQlno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2MxV2w2WVJTVzdsdmVWSHRJOFlDVmJ5V0llZkN6Q3NiN1hGaFVTV2VXTUV4?=
 =?utf-8?B?UTFQOWRTRnNja2xFV1dOUjR0L1plaFgyUytPZXBPZDhpNnozbnVwS0ZPeVJI?=
 =?utf-8?B?MkZiT2QwUmI1V0srWEhvZHBSS3krajRPMk5vOHRld2NSaEJMMkRJNThEekxN?=
 =?utf-8?B?bVlXZ0NtbnN0cUhQR0xmNVpueFFkenByVnZ6SDI5N2FiTy9MSEZuRC95U2NY?=
 =?utf-8?B?QTBZSlpPTno5TTJrRjRpRlhKUllHTUJsbkNkczVuWk92bDFvbk1HV2JmMUYr?=
 =?utf-8?B?dUtmRlhtTi9tckpUZzNwMkZuZnp6VE9GNS90VG94Ui9LVk5Xdzl2TUpIaWxt?=
 =?utf-8?B?NWZSSjJNY1ZWOHpKaGpGbjhRSnhsak5kWU03aW1YUGhEeTlxTThBby9kU0hw?=
 =?utf-8?B?Mk1WTkIzRCtqVHBPTXR0aGVOaGwydERXNk1ReGI3Yk42VDQvTjZEUkdwaWFt?=
 =?utf-8?B?YVI3elAvZkhaT2tSMSt4ajBrOVg3dDhJM1RyRHlWOG9PNm5QTmxXT0MzMUU4?=
 =?utf-8?B?N0w4Y0dWdEZtazFUM1lBS0xFeEMxZnZueEoyaEt3WXVlUy8rODhhZlJ6Mkl6?=
 =?utf-8?B?M1B5RUdrazgzL0VHWmhQU1pEMXE1c040MlZjMjVTK1ZpT3pVOVJYSXFXLzVE?=
 =?utf-8?B?dkpUZ3N4QmhMdWlveEZ5YlYzR0pzNTR2VU9uT2dJcWtmMHBJYzVBNFBYKzVV?=
 =?utf-8?B?dGF1R2lPZEM1Y2U0Rlo2bTBRaUhzZ1RMY0hWZDdwbU1uajNRU3VuditlMVhq?=
 =?utf-8?B?ZFkya3dlcWR1Q1JleWlaeFJWMFo2emIwVzhEUjFieE41L0dyT2VoaDQ5RmNy?=
 =?utf-8?B?KzdXN0lQSDlCRklKVTU5akwxZzdORmhicThTWVZ0RE9mYlF2UUE3YkUzOElX?=
 =?utf-8?B?QVcrMzVNL0E5NjVrWHVINDdKMDZaQnZYZElzaVV1YmRxMHVSTGNmcGt4SE1r?=
 =?utf-8?B?K2FwWUR0RVlOeEl6eFdhNkJWZGxMTDM2YWk0ekE0dGVqR01wM2VlYnY3MXN5?=
 =?utf-8?B?YXJJMmVKMkRTcG5DblZoYW9sV3I1bVRRZVVTeHRmYjhNUzNKZDNSalVGYWVr?=
 =?utf-8?B?aG1xQzNQZ29QT3QyQWg0WUFhby8ySG5CUnJuaVJCcC9mZ3VyYytzYU1IYTRZ?=
 =?utf-8?B?aFArWWZPMG1HREhYZlpFcnpGY3ZiTkRsOVBQM1cxand4NHJIczNWNWlvVm53?=
 =?utf-8?B?MWdheTM5ZDlYS2hCOHV3bm9jVGtiRTIzYis1eVMxanBvM21lZkdVdDB0S0hU?=
 =?utf-8?B?TzlKcnA4aGJWelVqV1hyU3hZNVZWb25jVXJXSktaRmVzZ3ZucEtLbnJ1U0Uz?=
 =?utf-8?B?bC9rbVZvWjNoUVZYdStuaEFVOEhiRWVVbnhTeDVnNVdsUGVGWUJDZTJ4TlBZ?=
 =?utf-8?B?Snd0RVBsdUpuQUVNVk5JYXQvRXBvWGorTW5wekEvbHQyK1hMZWsweTBzWXJH?=
 =?utf-8?B?RHErNTVpZHRWZk1aQXBNWU9Zc1RLc3BBZzl4MzJkeExFRU1sdWdKN2NtWWNW?=
 =?utf-8?B?RlVBdldzUDdLMkUxSGpBOHZRSnZTS1Y1ZjRpZStWVWo0aVh3eTYwUWFVM04x?=
 =?utf-8?B?YldUTXhsOEllTnYzSm0wbElaMzVFMEdSVFNDNFpQcjJaWVF0K3JJTkdSanNi?=
 =?utf-8?B?Ti9oNlQybmo1TXdGak9aWkxscGEvdlBGWW5UR0o4enpUL3N1bUNuNFNkM2Qx?=
 =?utf-8?B?UGM2NUJpRVNhUWZFRVhyOU9QdmFqVWM0RnhtSlkzaEZyaldBcU1FMnFhS2Q0?=
 =?utf-8?B?ZWcybmFwQW11ZVRScUc3K2xLSGxPeVNpRU9xb1d1bjYzS2pWUmZ3c0ZWb0lI?=
 =?utf-8?B?bU5lelRFbk5PS3ZxUEI5K1d6cGhUanhLQXliRFkrbDBLQk5WcE1OK1krZU1u?=
 =?utf-8?B?SjR0b3lwalIxS1VBZkxNSUE3V3VPNE1RVC82SVp3QVN0UHdnTENDNERaS2ln?=
 =?utf-8?B?ZWhEeUc2YkkzcFFSRERFNlRpN2ZXUnZCcmpLSUh0d1gwbHVFdS9kTlMxLzZm?=
 =?utf-8?B?VE5wdk56OTRDeGxsN3BPV0RIUWN4VjJxejlDTytMM1hlSjh6WjUwYnh3RWFT?=
 =?utf-8?B?dENIZFZFeWhnKzRuMjJlUk15NFVLTU5ScDRpU3NOc2F5MmdXTy8xNXhrVnRW?=
 =?utf-8?B?ZVFzUXJyQ0U1Qkp2QmExZ1hQelBHYjNxbDVSSEFVS1A2UnRLeWs2QVlCSU05?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada11227-bdab-4598-9923-08dca68df9a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:26:28.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inFlaw1xUHz2Zah3UbzHts0TdLJTfnnukboksUQN8+LsanQrm48UQJQkX3kzwUiFhQNyGyCI1kn1sNUFIWm1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8640

From: Jan Kiszka <jan.kiszka@siemens.com>

Housekeeping, no direct impact on us.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index e63bf3f..c0cce41 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 962a4ee24854db8b3cf0ff2499e26705f54808ad
+    commit: 1372f428223aea046e8efaa04202093d0d73c52e
     layers:
       meta:
 
-- 
2.43.0
