Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4D12A14C
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066155; cv=fail; b=FKSkvUNxEgUmRFczv2IMGbkyID2F/ERRbNNICG+S/i4hh0T0t6eDjTUHhtG0t/0JIqfwH+JvTzDF23trQc1LmwCWz/tMO52OGsHckrIplfukC+B3XPe+8s3AaOasfAgwFEdUoQPiw3GN9g/lf+scZhefdhTBi9nQOvcAqZ8ieR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066155; c=relaxed/simple;
	bh=2WUaEXBZvfqdf3VmmIoMo1hHIE+/aYVQ0a7j1WVDPnU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=bjBER/xXAzUZxio9KRjITsvKMNwbYepzKT2Jpr+Xf7IXkRnD2xy59ac+rWLf9p+g8lMMfQ5Lkrl5SVOvBq5sS8E68UC3Nwjkaa6V7BvTCJ5XGkAu3KVUR/eMyz8T86bPAMq4bEg6xyAkThkGqg+e6YZqf63YnesJeIql6jmmkvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=P3eBNx23; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="P3eBNx23"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwUeaFKX1fAtC1j5a2w6NdFPwdyt4qM3JPpDgZW0FLgw+NrB71zlr/3VeleJQ3JwgAsycfAnUXcViYj9m0+BY+iqrwZaf59A2+4Ku76X5Kty6wvq2oVLLeSHChegwf0xxjj+Kj+Nhjx65vL+Tgq+CVZtWv/XX4YjrZNw3cPn1kWS4p04myf46Q5CMI59uO+9ITl5LbvLW7m/8jbeW7T6YZyJ9D2fVgcrqN5H+EBdJ0NRmZHaDxxaA+WqOfJAS6XdOdz5WEi51b4WcginamZmO4fusTn+soadcxSuELdTxABRl2ah8xKwV9VntTL167R2+wiSnFnPrQ4NEsruEZXCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6O3gRUUK2GYsQn/4Vhp9T/zLHvrRAiq+Zszn8ON3N0=;
 b=kmbVl5fdVi/WuLgJJXA6lp+Me9sjXPkJWqvuhLgi1p4bJWNJ8VfLtLo4vsIRTjVE6d6suF8VWg5jceE4EDhEmbMHTGR7qWRvOyg2lJO86G86FrSqrSOPuZKHiAxC5RLQ3ko3Vvt6o2q7zoty9yrOYnTU8JWY5aQdIpV5dAsEXSkg85pCl3F1ihdb+v9SFNaj8EF5FeK0vaIzQk14Mqcz/F7ZPNZmCpNJkZETvxHE5loLvyjDXi7wMcfea+AnqQLD+d1dHeBBupppdlqixAPQeuTZkCuR5l1lAKqK55f7Yje2DIV8tC0kZ3Wy8NsS7kaj2rSpPFGG1z26eXP8eOzs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6O3gRUUK2GYsQn/4Vhp9T/zLHvrRAiq+Zszn8ON3N0=;
 b=P3eBNx231SSxyscFzZT0e+P3/hNxHGTwmLvwcm2BHomXeFlj2ELiG/zB7ErLnritGoY/0RXmoxWfkMvQxUe1bZOD9OcY3Ny7/u0JCe+Bpt6kbUvWaxmk7X+AD3VJkZH301CdbJuElJcWwzdDjsYOkWz+Q4m08clvGy3VhowIc3oTsj3mJe8QUCGoPMtn+ALTRN3x+byBTZbZCczpO1cX/Nyj88iYeM4rxVPY3QQBH22ttIUtPEim5+iD5LZDON2bv5+PxlVT7fLd2Ae/KOYObMKEh/7nENHSLiYo7/4yLOE+aHna0wPDOU/T19HODyE+CxuERpA/SymEHGOEOLLfsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 21:29:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:29:08 +0000
Message-ID: <284056a4-b1f9-4642-906e-1ca208d722dd@siemens.com>
Date: Wed, 7 Aug 2024 23:29:06 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Don't do any kernel checkouts for userland jobs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: e13dcf3b-6da2-456a-4dcb-08dcb727f896
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzZwd3ZMR3gza2FOTGVURlhZZzNSVlRSOE5vRHpqT3c2cDM2MEZoY0g1OWVN?=
 =?utf-8?B?cm9YL21PTnBoWkVGUlpQZUNFR1g5dkxoTmUraEo5S1VkYUN3aXY1a1puYjhP?=
 =?utf-8?B?MXpZRkJKc0l6THdPWm5QN2pBMGEvODlXZk5UeUtYanFkNUF2d2dnNzEwZmxY?=
 =?utf-8?B?Q1Rqd3RNdnRwdTdNTDhQaTJSdVVqUngxMDcxOCtpVE1VRWQ0OHoyWDZtTGpm?=
 =?utf-8?B?MklQOENvanhVcEFLUkdYeDF2TERVT1FsU3dCcmNuUXpQR1VDOGg2c25Lc2hE?=
 =?utf-8?B?T0hSR1RvTzc2ZDZOeXh6T2ZTWm1xL3Z4dHhmQzc4NWM2blMxM0ZPZHBwODRy?=
 =?utf-8?B?MG5vK3pGTmFJVE0yUDNjb0UvSDRyVVpzZFQyQjhiQjlEUTR6QnZKUzYyQ0Y0?=
 =?utf-8?B?aURXS2g2ZEQ0QlpGTnFVOTRtSVprQ3JnbGxISHNWSW1ybHlsN1daTkpVSTYz?=
 =?utf-8?B?S3luY1JWblhON1JYWWFVWC9ock1jdFkrSnBacXRXWFcybmZVdU1rNXM4UnF4?=
 =?utf-8?B?aDhsOHlTVk0zaWplWmtEWmhFbUd3bUVJZDY4dzlsbU1xWTNORUE1YU96OEF5?=
 =?utf-8?B?YzhZVTRrTHFKTnRRYTYrNUdpNXJHbmY1OWxMTEI4SjltK1VBZUdBYnJMUncr?=
 =?utf-8?B?ZUNkSDJmS2NXQmY1cWkyL3ppRHVGLys2ZUhhVFB4SzNCWmtST2llbGFrM1Vy?=
 =?utf-8?B?dVNUQ1RHTXVCSHBET1hMclNwZWVqZGJhUDN4eG1QMUNXSXRwcmp2WkJLNnJp?=
 =?utf-8?B?a252VnBIS0g5SkNCQXlUMkVqdTNScW15QzhxcXZhNStMbjZUVDAxRk9CZFFm?=
 =?utf-8?B?U2dONnp1OEdWSU44d0lvaHRMM3c0eXhZOTYrWTE3M2x1VWJJVk1mZWxFS2Fv?=
 =?utf-8?B?SGNHUzU1UUtIaFgzM3V5WnNuNHpoOE5VaEU5ZnVwc2hNMm5FRVhoWmllQ1ZI?=
 =?utf-8?B?N2RqUWxOZ2o0TDFHOWp1Ymlqdzhhajl4RjZnbTV6YzBnY0JFTTF3YWMrUGha?=
 =?utf-8?B?WVNaR1Fpc1Y3UHhIcUxsdHNrN0pqOHdxdWhXQ3Q2NWJXS1IxVEU5ZnRuUWQy?=
 =?utf-8?B?MnBJaHdhK25KUTBrNllMVHgvalltd2w0RnBkS3ppb3FLc2Rab2hIbEl6b3VF?=
 =?utf-8?B?V255S05zbjlFRlM3SE9MQXo1RFVLTE84ZVBCak5IQ0IvT0lXeUt3K2MyMTRy?=
 =?utf-8?B?Tm9pM1pOQmNlQ3lTWklBZGJLU2F1cGNKSG1LVDk2KzQzUElCSXdmam1Db2dN?=
 =?utf-8?B?ZUpxMDBJMkU0UEovT3VRdjNKN0JYMzNWWURUUTZPWUl4WmlUNVN4Qk90aktp?=
 =?utf-8?B?cGZpQVYvL25IUWFtd1FQTDZNekVLNllKRGNxVHdxOGJ3ZDN3TjlJMHlzWHU4?=
 =?utf-8?B?eENQc21najhQKzRiZFU0Uk9EQkFVQVphUTRIYUZEVGlBeFhLenJlYVZPUjg1?=
 =?utf-8?B?VTF6RE1aM1I3Z21nUGVDb1hGSi9KcTNDUHE1dXltTFlzSWxuMFJCMkl6TFFT?=
 =?utf-8?B?QVd4NFZmdkozYTRoaTQ2N0VpMFRtTno2N1c0QXFrZDdPUStHRDV3cmxQTFlS?=
 =?utf-8?B?S0VEdERlRzRVeFZoOWtiSDZSZEhTQ0pNZ0s3NnpzWWVVMW9GKzJKYnJMOEZi?=
 =?utf-8?B?UDdhbXRrYVFPUHFnMzNEbzFMMGorM3Aza0trUnd0ZHB1ay81VlNKMElVd0Nr?=
 =?utf-8?B?dThVaXVIbXF0amdNN3o3TkpHcHJmaHNWTmhoT0ZtRHhQSndycjJseGUxQjU4?=
 =?utf-8?B?Qmw2SzdFVjQzU0I2eFRHTmdvQkVNT0o3SWh3VC9VVVJUSGZ4aG1TTEtQMDdS?=
 =?utf-8?B?TnFMdENBNEd3MDU1UjdjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXQyTFFGQWdwQnkzNVk5M2NkNGFScWljZUVVOGNGcTFoTS9SRWJUWVNSN2VQ?=
 =?utf-8?B?ZThKK3VKajZwaWVvbHA5Y2k1VlZlN2hNUlBxWmJTYTFNWFc4UmxXWW9KSmRh?=
 =?utf-8?B?QWpneThUQnpqOGFYeG5SSXlTcjJ0TmtHcFRRWjNPQnpXdDlLcU44VWVZZ091?=
 =?utf-8?B?MkpSV0UrZW1UVVlBaEZMaTE5YThqaloxNEd6WmRYbDV3WkJOcUp1dXo5NU51?=
 =?utf-8?B?WmNic0hicDlpYkpVRlN6ZlF4UWdnZ1lETGRwbTZOd2NXUytiTENTSXVQN1pt?=
 =?utf-8?B?a0NuZjczL0JwVDd1T25Ydmt0d0VockgxK1MveElYbEs2dCsvZHY3VlVVcWZQ?=
 =?utf-8?B?ZG1BMkg0VFkyV0ZacE9HYlgwRUxsWk91eDRRRWpaVDZkT3d3ZU1ubGQ1LzJa?=
 =?utf-8?B?NHdBUHRTcDZnT1dtZUpDWklINTRMdVNhby9GMmlSeThCTVFGUFRMYzBLZ1pI?=
 =?utf-8?B?UTBRWkZxSGFsTDUrZWVBVlNodXdjMDRHZC91Nm91ZWRTdFJGY0Ruc1RZaTNw?=
 =?utf-8?B?bENpS0hjVUVmZDBLWGdhazVvbzN1RjJsNXVwZmtzNVZKbDFrUmp6OWJidW1x?=
 =?utf-8?B?UFFKSUlEVllEdmRHVXhqdlo0QmFoa3VHUlFMK1hKRlVxNU9JaGRNczhWWHY5?=
 =?utf-8?B?QjFydzEvNldXdC9WUlBrbjFWNGR1SG5ZTHl3QW9Xd3h4YlR0czdodFlhZXNa?=
 =?utf-8?B?b0xWTXhSc1FuOElJdjRGVjBWYWsrdHJsQXR6SHQ0RENRWFdLVDhHaWh6UDdr?=
 =?utf-8?B?YU9BdHRlQnhGMCtKVTNxQUljOEFVbXlwcnRUU2pKN2pVOFJ6UlA1dG9uem43?=
 =?utf-8?B?TnhCUExCQ1Z2bXM4YlE1V0NVUCtZd1pvK3MyeC9WRERTY29na2YwbGdzTjlm?=
 =?utf-8?B?ZVYvK0F1V3J3dHg2STNlRlVWTUl5eVZXanJTQklJTFR2NkUwenZldUcyL3Mr?=
 =?utf-8?B?OUN2VURUNzFRSGNJRTZmeEpQbzFDNmZYcEM4NE9IeXNvM0ViOW5rVnVsUERO?=
 =?utf-8?B?cVdWQlhIWkRLVkUxTUpJSlVTVWxKSHJPRy9aclBIVXJnSnRScDRuUkJ3ZXEz?=
 =?utf-8?B?U2U0VVN0Vkg5Z3JQZHZmZGZGQWFBa3QrdWIrRzNRaldZODFVWU5YdVVhZ1pU?=
 =?utf-8?B?NTZ2Z2FscUtnQ0VrTTBZM0VFRXRncS9pSjE5MlBxSmtKazhFSFRvM2NvUGh3?=
 =?utf-8?B?a25UWHFZeWxHa3psVnBFVkFBMkNJWFFUa3JRd0JRYU5RVGliMml5ZHA5aWo1?=
 =?utf-8?B?TjBjeDYzckh2blRiQnU2WEFLdHlsUzVWYm1Hb2ZEblJ4S2tMOHZqUjhFWUVl?=
 =?utf-8?B?ZFVsMStMZVJodzlERUJRUFp2ZDV1WXVDWjc4dVhMOFB1djk2d1FHRGFVazVp?=
 =?utf-8?B?WHN6RUZkb1ErTGpuamVqdjFlYUp1SHJWYzZzbHdlM0VtekJ6ZTFPSjhaNVRm?=
 =?utf-8?B?VDE3ZlBkcVczZkVQa0pYVXlTdDhwVjk5U0VCblRtZzRBbmR0Tzl0UHlHUnd4?=
 =?utf-8?B?STAwL2MyRTlaL2dTNEZ2Z0FhYmJET2dNU2NyRUJmalE2N29IRGVGWk9WVXE4?=
 =?utf-8?B?MFp2dVdFdVVwZDlFT25YWVVuY3RGdmVzaG5YZ0Q1bjZ6bFFiWGRGeFgzT3Ny?=
 =?utf-8?B?TVU3dko3elNqdlgrV0RSV3pKUlVGUkR4bVdtYW9jbUM3NTBnd3pLVmRRZ1dX?=
 =?utf-8?B?VUZUZHJzZWcyb2VxNVBRTzVUTUMrQVA1aldsZFZuNW9YRFp4NXo0SFh0Q2hs?=
 =?utf-8?B?d3BhL1QwQU51bjdGRmgzaXA4ejU1QWRvRWdmT1BRSER4cjE3amNwT1ViNWo1?=
 =?utf-8?B?Z3dLTlNURkJ0WkV1Zi9xOUFienR3dzNQaGhkeHlsWHpudFgvT2p3SXFMV3FO?=
 =?utf-8?B?REg4TDJpRUozdG5Pdkd0aG5iOEk4cWtRejZOa1BrMzJyT0JXK2RmbWRqNERN?=
 =?utf-8?B?eWJDUk5WYVA2QUNzVk5OU2gzTVh5T0xSNmU3VVdiVFBGY3hDQzdZQ0dqcnk3?=
 =?utf-8?B?SnUwbnVzRFV3WVJTSnhMYmV4YzZMS2hObitsZHIwS21PN1Rxb2ZFRlAyYnJo?=
 =?utf-8?B?YUszU210ZkFIaDIzL05lQjhuZkZPL2RSS0Z6WDJUb1A3UlBtZXhuazBiUkg5?=
 =?utf-8?Q?rXg/H/riEyLYpmBpuY6/Km8jg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13dcf3b-6da2-456a-4dcb-08dcb727f896
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:29:08.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+E+bKUGQf8ZKqCLEwldWRrPlAbckSZBkb0A6ebVtEAqtS/S85mAxQnzx3i5RxgsV+oc7jcqyLiQcIVeOJ+iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8084

From: Jan Kiszka <jan.kiszka@siemens.com>

Testing for PIPELINE_KERNEL being non-zero used to work but became
broken with 2e92c3ae2e22.

This also fixes sporadic failures of userland jobs over the evaluations
for setting REV.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 09702af904..975c4e573d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -41,9 +41,9 @@ variables:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
     - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
-    - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -k 1.4 | head -1)
+    - test -n "${PIPELINE_REV} && REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -k 1.4 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
-    - test -n "${PIPELINE_KERNEL}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
+    - test -n "${REV}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
       "arm64")
       export CROSS_COMPILE=aarch64-linux-gnu-;
-- 
2.43.0
