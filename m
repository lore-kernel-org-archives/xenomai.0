Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE04921AD
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999296; cv=fail; b=AtaWUEhaIIVEpW09vGqArF482EBnrZ+v+lh90MzE7nFmv8puJZiXQyR5n3X32MvuW0XojNkiwGK6WGbWArSedRftfW+O+5DD4n6KlBJWHgn5NVhhOAXTfLmcsKrLTwc++TtSqMx/YWlcwfWU763KPs+avpsInRTPOKYfUuClNdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999296; c=relaxed/simple;
	bh=Nmq5rUxQefoxQzKroozz8EofUyC5G5G3om433qEEfeM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=nxTIWo7SKD4llkHMr6rs9QS4b0jbNVYMw/axos7kVgAmlH8evQoVEJ18pqn8m6xNvx5NqBcZxbFYq6Gtog/RF/ocP5iXoJScN1iZFoG7ya7FvN+n6Jj4BFq0g9DveYsFZpLUdOblnY0+KDBmZU+96k9AMHIgbl2Nh5XtailfhOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=INL7ewLM; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="INL7ewLM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iehjcDVUa9vvXPWdZWZtWDcJmvJKFilOb1bXYpIdhejSrtm1rdyA5iTAlev+dH9rlaM3k90orFx+JsMplId1lLX+R91ykgSNVYTYl6+GD+uooRx+5tjwawAIzRoYJUFSN8OpdUrhC2GRFhG0q/Eofq8YodVk+dJ8jsLspgwaKj65D5Uk6WCx/ILd6nzqp7nMkeXlNvbcrCtmaHK4Zs1vjPUVCwhVXx7Zt42sJGmGGf9h0hvfH2fmAryDsxVO6Xd1JvsAD1ic/DMGyviAQHzlVILzwklT88M4nOt/b6WdZq3t5osnjjTawUg2ySB6S0vnrUzrb5vspI+JqkQCzpZxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKDxjNtwJzpi0cwKBnJl4dTgNZmAFSyZdv1DR2w+Bgw=;
 b=qpyi5XhiF3Zei7fUgNzmoA/IsHQZDLT+jsmONQjsnCM5M6tG+0iIHoKswG7o0puANKqNRXCChpG+yaluEL3YNqf5/+plQErXpX6+iUSQWeAkcGpfWnjOt8Zu0h33PCenwirKrKh3wBde0RCwhpMh/0omk5yrPdYySOXPoTFyuWTfvNWQ8DzMlhLIK+WlZSnFajqJUXQhDapE0j2IuICNwiuA5mid78pqflgKvGpmWUt5pyj0dagBJ/GsEgNUnlnPchBe/vszasgmWNn/zqDI0BUmQBnBYYeq0HQ+Nvy0v0H5Y6e6nGUuJuEhkIKyNasXM6q5zrG1lGszQiHPWzjc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKDxjNtwJzpi0cwKBnJl4dTgNZmAFSyZdv1DR2w+Bgw=;
 b=INL7ewLMHXdvrEwalN2ARtH3gwUWvl9ITvy3x+w+syQa7Y98KvKmMfun89UjSyP8jwtA4CNrbSxFFqMNGhYJkMVDW+NoYSQcdUdGKWwVKOCJDroe473m1+yUAtDlzb43r+9xYudwCWj1YNFlsUYqrJ9YdH6kaMm/Rk11FambQjakK2Nn6HT1ACf4NEW+dwomNyErLwpkksLnsSFaocj+ic952cMQc/rbHSkTYyEucHRQ81NNZ4dBzEvW6tJa1HSf6kiFi/E8jzdnMq2f0y4M30pShvJIDatyJ00Mx7nHLESvoVWvdMVuU29Fx5qFkn8E3RgnPVb8Jxy0VOHuWz/KMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:41:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:41:31 +0000
Message-ID: <e5bfe28f-dc21-4623-b037-a905fb2b4f29@siemens.com>
Date: Tue, 5 May 2026 18:41:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update Isar to 1.1-rc2
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: f87b9707-5992-4e58-c26e-08deaac529aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xYbXEM01rMLXV5tuLo6Tg4G1JNujH/6wZm9424MOVsgHvti36eis2q9cZHd8BlzGISNDJ+1qihAgWUbmaLeRWd3GgneMi7izz528G3fAcYY666cca6lDbp4eBOJ1NdS3bhL4iNqNbuztc2EYZz5xtmF3PsZhf2ZKrSXxyTzzAI6l6iEh/xRr11whF+u4WHvJ9a8jFUnYHwk7Pp9wzf2F1ilGIeMFq1Lw3kZBKoWEH9JfEZiI/EsepWhlxDct2EH/FSvC5ST3lFXtW6mTVqpV6uVwg3z7mbKjWJp/pVWeLCJWzujdkbUCfaioKjroPsTCvQ29ZkmURL6DokqI+7ezl6Vf32ndANuDgLC09fb5AHg/gNUCgSrLWVv9ZUapjYqMNBWoR5Na3BFc1wcOyvg4TAGmf3YFz70cLbvUs7SIaqc8Db4nyXiQ4TbOWGyqsXpiLUR9+68tYBAWJvnbxLyTIYF9owH7awhtwveSNduWNeR7kvURd54BtSKmar10A3dP+cxI05XaNRa0qeNAYyLTeDvecS5YL4rXS8GkKzq//dj3z5rtfBu6cn16KAN8gOaLHm+EzsHsv/saXHRlIfOeD0NMzqRIhfuQbOVlNJ4nNYoW/9vRB1VeL/0iONxc5ytRRsGAt9dgDOPGFHC8zK1vz15pszprRiHESQRQf+t8VRtIsG2a+ueddFGg1zsyDmtaXYi9pozJDdZc/dPjy+llOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFSaDhsanNTY1V2RmQ4S24reEpoQzhUdE0zU2FLcS9vV1BvbTg3cG5malll?=
 =?utf-8?B?K2N0Z1E1aXhZa1NJRlcvOG94bVQ1bzc1N1FNc3d3c0pIeXNRaDMwaWllVUtO?=
 =?utf-8?B?cWgrQjNpdzd2TGoyd0RHcDhtRk1pMjcreWlPREh2cHZ1YmdOTWFrWWMzU1Zw?=
 =?utf-8?B?TmpTQUZrekVPSjF1L0J0U1M4d080Z2tPMlVIQlJUbm9YQTkvY3UwWmFhN0RQ?=
 =?utf-8?B?Wm1jSUExS2E4a0diSEdPbFZPaGw1L2RIbVFZVk51ekN6Z1k4OE1BOVRpdWpu?=
 =?utf-8?B?ZXRVdGhPWlVDK3Ftb2YzU1lWN09Jd3hTSUZ1MXMwQVFCZjFJN0dJckluV25Z?=
 =?utf-8?B?ZWRCWjlCR2h0bUtTNnVjYXg4MG1pcllMWHhYL3A0R2FKaFlwWHdIblRiSGhk?=
 =?utf-8?B?MTFDR2o5elFQeVVsMkJNUzBGNnk2anJ0SUh0YVBrR2RTS1RTdmQ0RGN2VHN3?=
 =?utf-8?B?NlgyYnp1a28yeHRMRzFZK2NNTVU5ZlRiQnVFRzdFM0xwdWZWYTN4MXNYT0pJ?=
 =?utf-8?B?NW1nRGZKbkNvV0RJdkdWd1RMNkZnM0paUFdBYVZVVmxaamNwUllhcTZBQzly?=
 =?utf-8?B?eE55QVlnSXRvWlR3Y0RINHorWERCZi90ZmtGNnFNQ2dqY1RUTVlPc0dpdUIr?=
 =?utf-8?B?NGFlcjI5ODFaVlhCZENoVmg3cU9XV1lZczRzbG5OVFhWZ3labFhsWDVCZkYz?=
 =?utf-8?B?TEtnVHVvZnVNSW5JRXNXMlArSHVzcVVyU0MwRWtDQVJOYXFPcXhBOWRVRU8v?=
 =?utf-8?B?UHFsbmNjOVU1OC9VRmo4dmV1cCtnSW1UMEtBaWdGZTVLdUFDVDU5Ni9QUWJC?=
 =?utf-8?B?Vjg3R2tVc2JhdkE2dENHU1Z4Y3pscXAvVDJoSUs4RDdjd3FCUFpjZVF5SUxw?=
 =?utf-8?B?QXhJbEFGcEJEV1JrZ0N5RmZLcFZCbDZHd1pNYS90RDM5RTJDY3U3OVZPc1FF?=
 =?utf-8?B?aHM0MzhXZTcrVmh6UlBXM0g3UTE0T3hMb1BseXJiSDY1Ty9CK1dadERKWEZz?=
 =?utf-8?B?T2pGTnFBSnV1SlV3Sk5NUEtHNkxrS1dPTkFvaWhodjlFbDhRNHhhekZlY0Ja?=
 =?utf-8?B?R1ozbmtnZHVRNFgzTEJqRHMyVmdYU0c2WEFwWlNuVDdmc1UyRGlBcTdodDdv?=
 =?utf-8?B?UktnV1JyQnR4WEJ0cVFBLzZ6R2ZVbUhDblF1NG5hNDVsSkowekRsV3kxQ1Ft?=
 =?utf-8?B?Qm15WkVQc1hiVHA1dVZFenNFUEF6S2wrK1UvR2hCYlhWRlQvSzBpUHBWWitY?=
 =?utf-8?B?bFIyWDBobUw3TC9tZ21Ha256dUdyNUlaTnc0U2VuNWk2ZWJUcXhvOVQ2TXVG?=
 =?utf-8?B?RHYrSUluc1FvYm5zS1huL3ErK20ycmRyU29zTlVieURFQ2g3UTlhQXp2QWhn?=
 =?utf-8?B?QXMvL2xwMXpISXpIY3ZrVlVIc3ppMmJHVEs5cFV3M2ZHV2FUTWdyL09qMWVV?=
 =?utf-8?B?N2dNNWpKMVc4UzZ0bmE5UFVTVUJrRkkvZGNTaE8yVzViOS85MWtCYklSQ3FV?=
 =?utf-8?B?a3VITXdNNE9EaUZVeU4vQ3gzeW5XWGdTenRIaFZQNEJGb3BpV1lGdGt0Z3Vh?=
 =?utf-8?B?RkpwUXdzTDd4aFhGNThFUXpRVlpYaVFwMFlGYTNRZncrVXlKMFV5NjZKY2tT?=
 =?utf-8?B?OVFUYmd1L1JrejlzMHFLZ0lkc2hkZmNMWjdNalJwN29XZG1nYWYvNk1ZU2VW?=
 =?utf-8?B?cHVLQ1Q2UzQ0aHBvU3hUUnM1eGpvNURzdGl6ZDh3K3hJMytvQi9MQmZHc2RR?=
 =?utf-8?B?aUpiVDBwS1EzSmJDZDczanY0R2c1d3VrQzRwZzNzZlI0WGx5Y24vS1YxWXJV?=
 =?utf-8?B?Ym80dTFHckdJcmNnS1dUVDFnT0NGOGhmaG9aRUhhaDBtRE04cWpFOWtQSGls?=
 =?utf-8?B?L21xaDBYNFlqVmUyeUpUTkJlUEVTb01MQktHNWtCWThsVldvdWE1VldPQ0h4?=
 =?utf-8?B?WGZPcEMyQ1RybzlLSlhKSEdZaURPU3FSS1pLc1dXdUJJODRuZElhdXlUTW1K?=
 =?utf-8?B?R1Z0akY4UGpnV1h6VWNUZFNUSkdWL1YxVHZWUHZZVlFaSVB3OGtDZGU2MXZl?=
 =?utf-8?B?QjNwME05VmJQcmJNTkVDK1lWVWRXMm55UUJJYnZGNi9JZHVONC81ZXcvZ1lT?=
 =?utf-8?B?WEdKcm9NUnJRdFNodGtPZ014THVQZlVieTh0bGp1T2xwMDVOb3FWc1ludnhT?=
 =?utf-8?B?U3E3QkdWSG1QUEdNUllqRjU3L2VudEJMOTcxaUwwNThncFNJVjVlbzVvS0Rp?=
 =?utf-8?B?bnFpZi9vR0QzOTRuZHpSWExWM051QXBhYlpMN0xUTzlRUjBiYUoyS2ZVYVBQ?=
 =?utf-8?B?YlU2Z1plcS9NU1BaWWM3VU9jMzNkMFBWUkVVREgreUFaVG1vN2VOdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b9707-5992-4e58-c26e-08deaac529aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:41:31.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54IEn+BMNeHge0Jehi6u2UobZGmL2tLfgLKBEg4RiszChqf51dAChQnG+9Th/yEA5ot0U/ZqJihfXfxJSlR4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8392

From: Jan Kiszka <jan.kiszka@siemens.com>

Housekeeping and a bit of helping upstream with testing.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yaml b/kas.yaml
index f856ae1..1eb2469 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 9792d18e9334b3cec72e2ade6a1065084c0c24d6
+    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
     layers:
       meta:
 
-- 
2.47.3
