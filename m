Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC52FCBF9
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985010; cv=fail; b=VYHoeMOi6aaQfbAV+X+NZx57IvT02OV702559Ko/GmzUIP9RRc2VWQm7/UmoM3JUkchD8mxAZ5nly0jFXUErtIcSfy05rwo36F+Bg2IWAmkggEIsuWsb7u+3WdqOQg0GzuUgAva2V+x8TdvUiN6DBaHViEndkq7iIuP80Tc4Kzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985010; c=relaxed/simple;
	bh=9QDuYYZZOpHYMNimvy43XG3JJ0FRvE+YcwACItdEOhA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jfK4DRQTZo+59JYnX1Mr7JuMsrL6VhMmBtj1pSD0L3NR+ds0PZqy8UKVGt8WXrZmRWRdccXuP/UkAe4QreY3Dg/jlbflnqWG0rh8ugGpWuADIdUde9/1ACEFMoWp6tbDdVtBdgyvslt9/jc4g5xsS6zCebRSbJq6pfrNOUfSeN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bprmHjGd; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bprmHjGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woIUgncGiK6XVU2vyoqs8vYlxzpHs/SUxF9NUj1nTuIvJSf6hRa1DrDfCieh4rUVPuzZEqoTeiNWYUy6q8lw6n1fSRNMamOBG/cV6F7DnT12jewrNdsa+leHIkWOyiNokTzBsXhXSSSgXDJZ03L1WavCdJ4MFHAmoHv5eGzqYMdEkbG7ydeY8gAKro3mmCgwzF95UyHI2lxe4I3OOpYgsPZgj4ynIAS1yWmHwp5RG063AdMiSHOPyz3QWydXzQgHrGdQxmOMyq3DQtujTf66XXnr/NKdE58teW0wWtfDBzLxRQnyScPFHn3QPPmjYR3bXr+DGmnjFr7phPwL3wp8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xMBrcV4vJ9CJK7O/UL8eV400HduF2npTBuafT5EQiQ=;
 b=rrf8PU/pd2v5PXh7t7ZDggOM1hcBtFJ+GQjQqj9L1zf+NT5dv+lttPk23NvkQykzl+CECw0s3cMe7W6bBHyTpVcyFlkYYmRlMTYstigQo9jB0zPj3lePbHwSXbt40oLw3USif3PaCriAMjuvK8ubykQ+cOt4tRwY504yWAXz/uIuB0R/KpmbAZWSioUgdBPKmKAKrZlLL2grN4BNfi0vq1pdWj9cQevMdr+0rVofp/80QgrjqBI2J7r7s+n0rT3BB2sogVe96+5766LQQ2bKXEdOsvohBdRkATeECYOi6A6ARkVgTJzxabMxCSmFGwEoGDLLCd7pm7iMyq3zFZHDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xMBrcV4vJ9CJK7O/UL8eV400HduF2npTBuafT5EQiQ=;
 b=bprmHjGd+eBw91Sty8Urujt22dC/Y6M1MkU3v3FdmH2+l1Eh2Bfd+unUvi5l6Y0IsNYD7mv3iOzsjAGAGxyzQ1Mk794qmoGAtQfr6MfSRuzbVWqt7tH+O+481E6VB4GGyMde0VL7IrCXA3uNeKXLm/9IGWKkmjnNziQ0HEvEQI3s2PcJVtv80NA1tX+h7hkDzv0ttbL0SUAo0SwbmCQbRiZcgVIAQj/d8i6/avsgKPT9+OtYf5c62oTy4AqiP4rkxh+tETMN7MhZGlWzbKLBQ4RAsQICxhDhddNP5B4Bda1yqskokarNFab4Baf3gTo8ijN5f6xUXwkMWJ7cwFEZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DU0PR10MB7921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:322::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 4 Sep
 2025 11:23:24 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 11:23:24 +0000
Message-ID: <abfb1d64-5310-4227-91b6-4fd962a4424e@siemens.com>
Date: Thu, 4 Sep 2025 13:23:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: check the device health
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
 <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
 <85b19acc-fd42-4a59-83c1-0063afecff62@siemens.com>
 <170648d9-b953-4827-b79d-6b5f22c7ff96@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <170648d9-b953-4827-b79d-6b5f22c7ff96@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DU0PR10MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: d551ede7-9a55-482d-9ad2-08ddeba57609
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXU2bnZFTEhFa2M0V1JTOVo4V3pBNCtHa05IMXdMUEZucVVNYVdoYkFsdTI4?=
 =?utf-8?B?aVdDYk5LMnFheXVWYlk0MUw2WTR1djhYajYyWEZjaEp4Mk9yRk00Z2F3c2Vh?=
 =?utf-8?B?WmI1ckdiS25ta2dXZWtYR2FtUjgwSjVsbGJoRm5RQVJmTTZqYXVxTFlGN2x2?=
 =?utf-8?B?cHhoSUM5UUg2cGo1VGZ5TXhFMkpQcUV0OFRIVDZmK2ZDa1JyMHdPR1JKdHBM?=
 =?utf-8?B?NWtteGY4UUxPbkxBSHZHNjJiSHV0M2dNNFBRVDF0US92UFNXRk16NnVkSkIy?=
 =?utf-8?B?TTVTU2VlSVQ1c3Nwcjc4b3FxZXA5R1JzSHZDbFNyQlgyUStRdm50M1VuOVJu?=
 =?utf-8?B?ZUlFMEkybG5BcUVDb3kveEliNTB0dldGT1ZLQTNaTlJZY0ZUdXcvdG1IK2pj?=
 =?utf-8?B?d0IwL3ZmQzBvTHJuK1ZmOTJmeDBwVVZRSkxIKzBzeU1wL0lWMkhENE5tWjFS?=
 =?utf-8?B?L1FGWWxqWTJrUFZVanVRL2gyeXpLNzQyUGgyNkdtazlvQzgyTCttQTVPT2xK?=
 =?utf-8?B?T3dnTU52MnRnTkF6Q1ZCTmdXNXlaUEVWRDZXQmh3MG42anhqWFBJY3Z4VWM2?=
 =?utf-8?B?ZDd6dnlJTHVLa3ZuUnVPWlRrOXVPWnA1WGtNcUtyY29rNmlNdWtXcVZjZDZ4?=
 =?utf-8?B?SThudjUvbXlZZVM4NlhTSDRsVldLM0VPM1UvbEhYcXlxTTlyQjBQdjMyTWlT?=
 =?utf-8?B?UW1KVG85cmhwQU14NHlrTTJJOXZDa0JTajJnUlJxaDRVVkwwbStRZXFRUStm?=
 =?utf-8?B?Y3hKZzdDdVV0ekJISm5BdER0VnRyc2w5akJiS3FJR1NkVy9zaVpoZmJLS0ZC?=
 =?utf-8?B?bVJlMnVPQWpKUWRtMTgvZU13b25HWnRqY1V2bHcydjFhNUZVZGVCUFlQSSsv?=
 =?utf-8?B?TnFWQWlEbTk1dUhNZE9Icm9vL2I1UmpWV2ZmZmk5eUI1cXR4T1REVXhFOFZz?=
 =?utf-8?B?RUxPamlKVFR2eFJnZjNtZUNuR2c2OU9lODdPWkI4QTlOSE8za2JoeXJHcTBC?=
 =?utf-8?B?ZHcwRU41L1g5d0pydlJ6ckc0U1dJNUVUWUg3WjFJcXlBZXpiVStyMG5iNGd3?=
 =?utf-8?B?bGJkVXZBcjZWb1kraEtiYUwyaWtaT0xvNmgrWWRJNVpmUmVuaUpmWW8wY2xi?=
 =?utf-8?B?UmhtenRHcE1wblEwbmNObk94aFU2aFB4ZCtGTkJlSW4vUWNtK0lGOHFOS0Zz?=
 =?utf-8?B?Yldhc3NOeW9ISEtTeU5JcEt4aHFvVzRueGRuNVRUVXVRcFFITC9mTml4TzM4?=
 =?utf-8?B?Q3dFM2FxWG5TVmk1L2xqU25Xd3VuZ0kzZHNtZWlDWkcvWm01QkQ2RHVGcjBR?=
 =?utf-8?B?VW9OMU95SjNzY2hiWFhaQkdBNlUwalRiZVJFams4ejU0TU1sYzhzNXFobjY1?=
 =?utf-8?B?U2tyTTBOS1FKbGRzQUo2ZzlPMVFNaWlBL2RuR0h6bDlrR2k0aE5vQjZ1S3Jm?=
 =?utf-8?B?N0lmZnVOSzJGbjdTYkg1VzVva21SSGhWMTV4Qzd5dnhqV2ZjZ08yemEwQktk?=
 =?utf-8?B?YjExM3FJNXg4NVZoWVdnZ1MwMHNoWU1ESUhkUUNpMUM3djVrK1orb0tqbUox?=
 =?utf-8?B?YWZVVGRhdnBQU0ozQi94aXZyRmZkK1E2TW1qOXpPOHIrclVucks3aXQvcDRZ?=
 =?utf-8?B?MzBtL0NKV3c2eUovUjRRVUVWVFVZQ1Z3U0ZtbkN6SlhyRG1oeTlSR21qanhO?=
 =?utf-8?B?eVNSOWpNNVFIeGxDV1RER0V1NWNNT040dGtibHdyQU1wRnFxNkRNOFFEZWxM?=
 =?utf-8?B?a2hWaysxQjRnaUpkRk9YNjNGbnRGTTFPOXp2T1V3em9NUVRYQThPeE1ldFZi?=
 =?utf-8?B?Y09vVmcxVEc1eHFlbXhMOGhkRnY4OFdGaWFUajBTcnIvdFUyKzFsMTEwTVZj?=
 =?utf-8?B?WlczVHJCaHNLUTJLSHhweG1SNnFBbENyM3pSWTRWUERPb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TytCNHBmVFNISkV0WDBjT1NiLzFVK2FRckF6MmRJUWJEUkU5R0thQjZlaDRy?=
 =?utf-8?B?Z0ZLVjFueks5QVFLY3VwVkk5VTNEZzNyOGVLd3pDRUR3T0hldno1a1dmQ3Fw?=
 =?utf-8?B?Nmtvd21CL1ppVlE2S0c0MHJGU0NseXladkhyOXZ4amgvRmZJZ2w5Wno0dUE3?=
 =?utf-8?B?eFZJODN1d0lNQityVkJOQ3Z5S3NGMzYvc3drNkwxLy9uM3Y2Q1E2MUYxOFlv?=
 =?utf-8?B?Uk1oUExpSVNiaGI3YWZRYzhhTGM5bXNJQW9VbDJqdzVyaHQvY1NoZHM1WDVv?=
 =?utf-8?B?UDZQWFdRY2JCZ2tZS2pkVk1nV3ExWUpFRm8vYmpNUC8xZTJkcHNzSmlaOXFj?=
 =?utf-8?B?Y2ZXaGpseGxXUWV3K3FvOW52Yk01TGsrTEkxUmVUYmg1emxubDJOc1dtNUoy?=
 =?utf-8?B?Y0w2ZGx3VFFyUlREb0ZOV3J5SW4rR2J5cjhDUHpRZy9Oc2d2UXlaZDhyZENq?=
 =?utf-8?B?V3BpYS9BV1VBMXdQRWJwL28reHhVdGNvaFJ2NTYrQmNybU8yQytsQWIvTjVh?=
 =?utf-8?B?TW1raDN3MUN1SnhSZUt3eHpTL3NyTjRSYWlMSkxGM1BlaHZqWTB0T2JHampI?=
 =?utf-8?B?ZEt2eUlGUzBoZm9EOCtPSnZubmRidUNHdVQrcWpFalZiYzFXQ0xpckl5bTBU?=
 =?utf-8?B?ZnByZU13YXUzK0dPLzVHam5yTDJvY3E1a3p1bVVTMHZNdDY5Y2xDcDYxY1ZD?=
 =?utf-8?B?SnV6cExWUjBlZDBpcWg0bTRCOXNnTFFKbXVraG54dG9ySHQvZTZLaGxPelBH?=
 =?utf-8?B?bnUzeXlKcjBTMzdsKzNOdldKQ2tNaTRha1JWYWc3RW1CK2tZbU1XMnNhdEFE?=
 =?utf-8?B?VXJmTGJQL1l6Ym1laEp5Z3IzWTV4ZjY5cHdxR1J1eHFxYXFoVnkxcW9WMkNq?=
 =?utf-8?B?US9XSDY5TlgxVGN6dmszYXlwdFpsRHFKd29jeUpsY0VaVWJnRXRza1BDRGxK?=
 =?utf-8?B?K2RiVmlKSUhicmJrd1gyazQxUUFWWEh3bUJyaGhFWERBZHhlamdObk81eXZt?=
 =?utf-8?B?OTFNWFpJUTB6endjM3V3cGNITStwVlY5d2ZzRytidjRTNnE1MEVKZDBGSHlk?=
 =?utf-8?B?bDI4bVY5T1BDRHNFZnM1VkZ4SmtnVWpJem1iMHl6NHhyRThPVVFmd2ZLZDda?=
 =?utf-8?B?cm9qaldkR1lSaUNYUnNNdGw0dGxtL3pLYmRGY28wM09yeHBHck5ETGY2OGN6?=
 =?utf-8?B?ay9ISFFCVUE4eUdadVp5QnBWR2tQZWNkYmNrQ29IMjJVL0NDNW9sWXYvNjNN?=
 =?utf-8?B?RGd5WFJhN1plVlVBbVdyY0djZ0xmMWdyM3FhZlMzeVU3dGxxMWgraWxiQkRn?=
 =?utf-8?B?cU5nbk9MZFJ0czZ4VVBtK2ZaUjRVRVpHQnRXRnhMa3dxNFF6aWNKWUFjZU1M?=
 =?utf-8?B?NEN2c2dmMXpGSUZCSVVZZnh2VzJvNGtmajRsekMrTGNSNFZWZjlweGM0RVpw?=
 =?utf-8?B?T05oenI5V1czMC9PSjNwUnFNa2hrUk8zcWtJM1lCZ05qRTkyc2xzS2tNZWtM?=
 =?utf-8?B?YWVjT1crVFRyaDlpN1ZzcURhVHB6VzRiSWdRMnBkZ0habzloSFkwRkF1OUQ0?=
 =?utf-8?B?THc3R3pzak9zcGJkclpFR1QwTUNNb3NwVkprTkwxcit4cmllaS93V0ViS1lK?=
 =?utf-8?B?UGpieXFuNzBORmJoWmhzd2ZUbjgxQUtiRmdLYitpWTdGTXYyY0FLWTV2RlMr?=
 =?utf-8?B?eXhtcUJHdHlEQXBqR09JdnpqNTRrVllNUUJRT0thSWFZZGYxWXpFcHJLVzZi?=
 =?utf-8?B?ZlB4NEJlc3dpQTdBM1pOc05iZHBsVmVuUU1NLzZFWmpjYmtzZzcxWkR2eWhW?=
 =?utf-8?B?dFFzV1RWVE03UmJJT3dacDlYelZ1STBqVVBQWWp4blNOUjMzZDFHLy8zTkM3?=
 =?utf-8?B?bVB6U0tCSmQzWDdJM1hhZ2RYNERBamgxQTkwNFBKZ0tNRnphOXlielFHRWk2?=
 =?utf-8?B?V0FSNm0xaE55MEFoaktoTWVUVGhpVStzdHp2Q21nSnJycUhpdkRzcVpFTTRZ?=
 =?utf-8?B?dHRFR0FTWmpjYjR2S0dLNGEvakF3aVp3ckpwWTNmTUdHTnNndzYwaHFETWU2?=
 =?utf-8?B?dDlWQUhxOFRLaWMrZkV1WXdsQmlWQVJ2cTYzUmVUVnNtanVwNVFVMnVSazQ4?=
 =?utf-8?B?dWR2eUVTMURUNTdmUmRlWXFua09DYzdpT2pzdURjSFNoNk1jYUhZWDhIbFQ4?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d551ede7-9a55-482d-9ad2-08ddeba57609
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:23:24.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgX43mG5v4YEjOcIjzfNN3qxIjlfDIJg9xUG7dA92U4jcUtWUMFzsla49k9AOn8npuaQMyBqueEg9jEpWdIGqsGof3g4gAMVko73JiAxv3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7921



On 9/4/25 12:47, Jan Kiszka wrote:
> On 04.09.25 11:58, Jan Kiszka wrote:
>> On 04.09.25 11:42, Florian Bezdeka wrote:
>>> On Thu, 2025-09-04 at 11:29 +0200, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Check the device health and the device state. If the device is not
>>>> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
>>>> minutes until aborting the test.
>>>>
>>>> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
>>>
>>> Hm... Not sure if I understood the problem correctly.
>>>
>>> Assuming Jan spawns ~5 or ~10 jobs for a specific device type when
>>> pushing to one of the Xenomai 3 stable branches (or something else that
>>> triggers a lot of test jobs):
>>>
>>> - One job will get the device and will run
>>> - remaining jobs will wait (and time out roughly at the same time)
>>
>> Right now, they will not run yet because of resource_group:
>> <desired-device>. But if we removed that, we would have to take the job
>> runtime into account while waiting for device availability. However,
>> there is no reason yet to remove the barrier.
> 
> Unfortunately, this is not true for qemu devices right now as we have 3
> less than when the Intel lab was still around but even then not enough
> when a full pipeline run hits the test stage more or less at the same
> time. We need a much higher timeout now, or we need to throttle qemu via
> resource_group as well.
Ok then I would send a new patch were we ajust the time out in the 
.gitlab-ci.yml.

Quirin
> 
> Jan
> 
>>
>>> - one of the remaining jobs will get the device and run
>>> - all others will still fail
>>>
>>> Correct?
>>>
>>> Does that really help? Maybe one more successful task (when the timeout
>>> was enough to wait for one test-run), yes, but is that enough?
>>
>> The main issue this change is addressing is that NO device is available.
>> So far, the job would wait for hours then before timing out.
>>
>> Jan
>>
> 

