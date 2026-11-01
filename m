Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793533212;
	b=WhuWI4OX8EUqMZke0cA1uA/aYqVP/hrzvrVmHSvQkjREp+rRctDfGM4Lg49CVagT+zS3
	 4+kEn19eoUDqlm8rUyE+Zca0q7CAIbHu6z6VkcrOBpd0gDZGWP88gtO1iwldTRbIUwNec
	 w42/q28/eUacSdbGCTwtnGU5Z1bPri6Yp5DtiHKz4ErnBYsklorZAykn3KWOmIBW7cTML
	 AhfwLrS4zpOdKgnxb20Q5ckCAhMqG8jDPm8LlJXxLVcJ4fWR9KxxbbxiDD0fNRlaGodCJ
	 zXS6Ip5yrcIrp5DHMIqwLPKwY+udiryHPODztm5XQ13tMmF8MOp0IxBhmNTfbDf0CFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793533212;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Cc:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=USnkL5fyf2n+fElNBx80QDf/f2nCn6GXErRdFrC2YbI=;
	b=5nvhH/bIKbyTZFMT59/Jgk2UGke3sx4HY7xrMomub5A9fA7PfsACWoa8VYWOCQslnRtR
	 XrZ46KfjA7FZgoKpd3PMUpGgZXtHegQLIunOntFkupuADhclfqqXHfJBDxO6J5Tv6dSiA
	 RpdjJsodafnOEGboE3TQD+8cBVauUyOhUSP+enX8YhnDR3jVYRC32L8QrX80BtJGSN95w
	 EsA6xlcced6ZyMQP6IFVDy24u/tH86LxRd+rzOqDcVh1KT5yjnsRJ9LcqxFRMt7Ipibz8
	 fX6OkFAr6NWUJUjBIv3s6xudnmq3ToiPumVLnh/Wk7V2hmLhvM8NKP7ksBHIGBtZuSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lp2EMk4F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF082606A324
	for <xenomai@lists.linux.dev>; Sun,  1 Nov 2026 11:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF082606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lp2EMk4F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+yYvFeMyKGKwRKWWHUf6gZ78uV/el5+5Lpj2I0QUXXX+zVEzHmNfcdIKjT20N7k18VRIfVdncug6BhtoODGM9+T/wUkVC8g/FsOMjIQO9EsYEuFufElMbukKSXDspjbLExHpPfO4artD6qpTgnszBGCZvxm41avP2/2r4n9wygA+ceur6i8+HUvoNdV8y6ug9eKmRzK5x0TJeOtgXBoe0e95zY5tlxRIjhwh3FpKTwlP/IjcoEW1hEdc+eYs1dqtRtEklyXD6ia9XE5rMvPjH6VyE301oZjNplf9k8YKIFrf2QIWPs/SLhU6jeIDbTwQh9pXDE478v8jy0wv9bk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USnkL5fyf2n+fElNBx80QDf/f2nCn6GXErRdFrC2YbI=;
 b=cq0UQCsmoJ4eoJ60LTdONKJJQ3/s4E7pFUzU38btGGmxXguHPVLHVvPDDFIZhnpQ4SIW1+OSTAhlJVgEaz5OiEvqF7tNrXqmxhYJKldOxq0+G3eaYzK8w6OCd0P9HzocbT6EW22vF1otKmZaIVA9p8YiZ5No+EW6fi4f0w/X2tzjSLyeDGrP2QJ1rh+ilvucLkCL3Wkr/YONbbh0+5lW7I9IH3QZyYVrfcTITsK+oEOb93+bXakSNZVkXWWa3GSFvfCGI8uJL0/tq6e0856PfapgfXLbZRvvU41mbpG5T0wwXmkvY//z66B2Ug1vBreuH2QS3nfaDN08doWPQbCDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USnkL5fyf2n+fElNBx80QDf/f2nCn6GXErRdFrC2YbI=;
 b=lp2EMk4FBBYonzwbASyUf3l6Hbm7ITuwC9kHZUo18yKG5Hs3rpRVUEnhv4jpEjsDv4WqIPvHXGiJlsFfiJyNJFIlN8UV1M8x5ap1LxlAIFg945yKVs2ZA69fqf8+cmeNUJj6tykYGEIZSj2IDGq+6ar9mAud1+fHnrLJ1W4LgymkGb3/MdBj1W4UgcTd3snoL0wUoSqTYZksiFTfvRI0vpD7qsqS1XUoJ5o6gj+2NNn2fEuSaPi+M91TXwYUvX8i0Bx7dxNEzX4Cfs4cnt43DkFevdpZ+jOE3xjlOdAj4XDVLkTFVeTUomFL7V+Y8rLiT450nUD2YTsMUdcvNfaZUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU0PR10MB5430.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:329::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 11:40:08 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.006; Sun, 1 Nov 2026
 11:40:08 +0000
Message-ID: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
Date: Sun, 1 Nov 2026 19:39:41 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops cleanup
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU0PR10MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed43c7c-beec-467f-17d9-08df380ce1ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Iz+UDXu/rWmaJ9uiK0Vp9BPThshO7pIN1vpnodGbEPb7yjvtY6yz17Gp9NNbcq0mm7TWcv/yvcqrDhCdqdJjWBHraSylF3OSKMFc8yeTgPKrofjijjq0kw63/iVKgb1uSXp6tljCCPlnFFzpz5MVHhPWZ4OZI6jyLCH+8uivOOuFS6BdpZWYWe/jI+ZAriO6Dq/q/ioRPcn0ZAd/aq3tBjMj9tRIx69MlFBTum6+nMyzoRO7My49TLlc9Pyyn87q+iPg776LN/L0249uwoJT7XZXHhA4A4GksMXDuAdjaczvz20u+JcIg8FVmb6Tnw2eGw+uCB82B6lk0RyuP02TauLRdNYlve55bWwaTfGWsW3yDlZl9MO4gxZrotyR9FmO0fdEjn/xFkzqOjURkyicBkfp53mqL8SOraHpwEOTEomw1k0b/6cQNnN9dFTyGxxbbK0dLnhpDz2CSyizSIMsHd/xbwAN6XaZw7Of6tWfCJHELtM4SoDBlq1itYiArkQSU19rQWbUJSOy4ASOZjtJRm90tFQzNz4UOEW+ujXXGvKqnQsEU+12ItsQ/UMZhdeHgrf79wcjqgHswbejDY4iD/EiTGXSnry/00G0k0/W+GPFxTgku0Gubur15Z3a7zd3KyfJ/rWnWuJoCB6qGT9FsWPyIvToPjXcLuzPNmMiW3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFhmelpTUXhYbEdRVlRTcWVWenB3MklZOHVyUWZISllUU0pRNU1jK3pSY0hi?=
 =?utf-8?B?OWxhcnh1ZXlRcWhRVGtJMWxLK0RqSTVFWjhFVFFUc1Fja0duVzk1bUhmenpZ?=
 =?utf-8?B?dk5aSDFvK1JMTDVxaGZYN3lWcldNelJZM0gwdmk3NHhzVlFCWGZrRGM4RjFh?=
 =?utf-8?B?S0JqQ2VQNWhDNkxjeVVOTkNZRzU5VU5lcUE5RklORWUrbmwzMUZpYStpdDEv?=
 =?utf-8?B?RG9PTjJaNkV1cWNWMEVCRjNwcGJxVXlYemsram9OTmxUaUxqbXdXS1YrVGlW?=
 =?utf-8?B?d2NJVGJQVjlUSnNNUE5nVGlscE5yRVA2blNlbXpMWHRYcFFRemRubWNKdEht?=
 =?utf-8?B?ZXdKRGF6L1dMTDQwaUtVY2RUY3F1NDZmQ2V1WHJLbkQ1U3QwbnNxa1pjdFVt?=
 =?utf-8?B?c1FkbDJEWDdabWcvSEQ1a29ZWHpydjB5YytXSDJYSW51R0VENWtHUHZ5MHd0?=
 =?utf-8?B?Mk1yWEtaWnVDSnhiNDNlTGZHTm9TRVJFWEtQQ1MxQlJHbFV1VTAxZzFWOWRl?=
 =?utf-8?B?TTQzL3pFalNOM2dQWnNJRlNjSzhKMUtjdVJmWmFOVDN2V1ZiQUNTWVNjTndL?=
 =?utf-8?B?V1ZCWGx0SVd5T2hYMTdaQUlHOGRvcUdvU0EyOUN4OFdYSE0rMTJ4Tm1YLzM5?=
 =?utf-8?B?MWZYRGdsOXEzejBHbW9zYU9TbkR5cytaWHBVK0FJTDFvSUZXVDQ1ZHBtLzdR?=
 =?utf-8?B?SGxXa05pdjBNQTZrMFUrKzFBeG5ScGU4eTFNMFJSa2hRSFJFeG5CZFk3cGVm?=
 =?utf-8?B?eHNFTGVjT2NoN0lieTg2NUFKVWp0TjlDdGV5byt0MmdYMUgyZEdwTEUxZzc0?=
 =?utf-8?B?SWZVRU9aNkJxcCtzN0hNRXVzWXdTR0hSbzJJTU9zUlB2YUxZVTA4a2FYa0Vs?=
 =?utf-8?B?WVFaeHBnbTdiWDlja2M4Wm1KV1pDT3N0V0dBeWpCRlNJUjNsdDhOMzMrSmp5?=
 =?utf-8?B?L1hsR01meUJtRVJld2VlaEYwY2xGR1Q3MnBRL3k2QldBN1NGdGthUUFEaHRK?=
 =?utf-8?B?bmZsbGVCRnB0VGN1OXJmd1lsMHArS3NMeWJRZHJSaVpZTzc4anhvR2xxdzM3?=
 =?utf-8?B?SmFzeHhwZUpXUUFZd2h6RDZ2bzZVdUlkMG02YUtMRVZIc0NzT2EvMFY0ZEM2?=
 =?utf-8?B?K0pLVXFEL01nVTBJSFFwSmhKditPM1ZXYzVIMjRvMHdVMDNzSTRBczltZ280?=
 =?utf-8?B?ZisyR2FDYi9OZGs4eXpsZFVGTDF6SHE2TDZMdm1QZmVIcXFnckhXV2ZKd1ly?=
 =?utf-8?B?dkRVenJ1a1lqQ3pCM1M3KytQaDNvSS9Hd2s0WERJZGp6eUM0eENTN09EMk5V?=
 =?utf-8?B?NFBxSHRsZjZ6VEQraEtNZkkvRlFxSmZBQkQ5TVNmYVB4TkhSSHowK0hPQUJu?=
 =?utf-8?B?LzhMVlVCUWt3OUttSll2dXIrQVluWWU5dUcyTGpZRjd2ekJiVTFkNnR6bXA4?=
 =?utf-8?B?dW9GblIzeFo4dVQwbDZRbHI1Rjk1RkVnN0ZXeVJBZWtyaWxqb1NzUVA5TUEv?=
 =?utf-8?B?cUQzUlFLZGVQM0wyT3cxS284OG9QNzFLZ3lKcjhPRnFqa1B5RzRHbDdsYjdm?=
 =?utf-8?B?T0w4U1I3VzJ3cFZCU0M2SGJhV0x3d0YyVm1tKzdIOWlJYWNlSUsvNVR0SW4r?=
 =?utf-8?B?UW9JcmdiaEVHOVdFaStzNElPeTJEYzdtQkdYeHhjV2VtVlFwOWlNM0k4ZGdN?=
 =?utf-8?B?VWxtRlhIMnoxeFlhL0w2ZlVDWm92TzZiekFlV2FvRkx4SnZ1VVlCVHZuOHhH?=
 =?utf-8?B?MjVTTkU4Q1J1UGVneVBNS3AwSCs1SXkwQ1NMMlpDeXY0ZngwalcyVlI2MmIr?=
 =?utf-8?B?cDRsR3k5MzgyQnZBMFkrOVd1TU9lZWxhQzZ0ZHRwZDBnY3FlemFQVzJmUEhC?=
 =?utf-8?B?SjJPTHlaUEduN0RzZUFHMW1QSVJhRUc4YlFmd2ZXamFsdDk4Y3U1eEJyNUNr?=
 =?utf-8?B?R2liQnp0UnBBbFBCOExTTWVsWVdSaDJqdUx2UzZyeWJrOW1lSUViQUp1OGVC?=
 =?utf-8?B?UGZxNURLZ0JiR2xzRWNWOFl3WXBWOTh2VXFLNlFKZW1xUUJ1TkFGbXVWWTN0?=
 =?utf-8?B?V216U3dKZHQ2dmZ1Zkd5RDVZbHFTOU13eVdtK2NMaWhKZEVQa0V4QjE2L2Y1?=
 =?utf-8?B?eENlM2N1M1hEUFkvenVVbmpWY2IxZUFabWM3WXVNSVAxK2Vaek1hUFIra09Z?=
 =?utf-8?B?di84R2tTU1FOcDZEeEF1K3kwNFg5OUNWaHdERTJ2WWg1SlRQMGhON0h1aVFY?=
 =?utf-8?B?KzhFM3paUzVRakJwbllwNlowMCs4NGhpdE9XK0Nyd0RFeU45c0ZUMVlsUktp?=
 =?utf-8?B?c0c1R1BnM0hUN0tvK3hxRlhWTnBzckgvN3dVSHNXZnpyb2VQV3VMdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed43c7c-beec-467f-17d9-08df380ce1ae
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 11:40:08.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 414fUUdl/poPvuvM9kyUp1suZN8I5Hm3PUmXUsQqgLZ7YEXLcetENcLK9kDh+u2eAbvtW0tcmDpwBf9vwq+8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5430

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes: 2db757ed1c20 ("net: dovetail: enable out-of-band networking")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Should go into 7.3 as well.

 net/core/page_pool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 13ef7c723a89c..6136471425fe3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -338,6 +338,11 @@ static void page_pool_uninit(struct page_pool *pool)
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
 #endif
+
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
 #ifdef CONFIG_PAGE_POOL_OOB
 	kfree(pool->alloc.cache);
 #endif
-- 
2.47.3
