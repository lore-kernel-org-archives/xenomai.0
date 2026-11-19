Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.233
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107186;
	b=zt6ekSbmzcoRq702Gv3inuujwfS3ZXKyMJF1Zn8ppgOCVL/X4Ss1y1VNIjxOl8UDjfIz
	 77IC4sUbn4bjlfd9ZWf8NeZOQYqbPubDO2II8ksmSpwNN/6gydzakq/Dm1F62HQr370yU
	 fAcIyQlByj8jLYwaFKG7K2l0Hqfduza5gbDpifhn9UiPHMO6WWBLYpf9kisiD06t/5akd
	 lXOy8Tw4EbhXVsCEhP/ndbiZ5kamLT+r2+ZNXs1Vm4G/+zKkuJGo3AOa9w7CXos7ZDvXP
	 rasUhC5PKWGPByPvxFwmTysX7qEMKNf9J1Ozu4nVJhtwio8j+4/TcZF8/gI0xEOMzxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107186;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:From:To:References:
	 Content-Language:Cc:Autocrypt:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=h+GSr1e/iS2aEH70eAjyDSPa+kypKdVmN1ZNYsUpxw8=;
	b=NC3gHL8N03JkHUnt8BClRSdZ3ciFPgMEAfErKdRhfDZx60d5p2lYGR21T1jTaXoA92kI
	 Q7l8+eqI338PIc2wOc6vMAxkHSDXYvJAk2SVAg80An8n4qfTxZ3j4ixAKOarlM9d4Q0l0
	 3Ihp9h52olnS9lflo0K8SIGTBbbSrnm8ybTiMh6mFhkFM6sawh99I+uarzNaL9CTIinZZ
	 etjjWdowy0wJzMqHY+mFSyqlrSU+o3SRjv4pn53y9nwDMsY/I+JdQbZkJvh22jRBW9dgR
	 cxDvJSGNBNjBDCWzNtXSYPjrPh9xr50H6PldN0VNP1f4qVL5n7w8TUdsNlkgqRfNUoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZD4b1Lva;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FA606A33F
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 16:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854FA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZD4b1Lva
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 96B723E97E
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 16:53:02 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6F06A5601DF;
	Thu, 19 Nov 2026 16:53:02 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=ZD4b1Lva;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAPtDP6K+ff/ISzTeig4S0ZmJIXmx2rUD567bAXobooqbQs7K9jsTP2qHGxwdj10pv3bR7dnPj2w40HCVB4sB+F8dIJix2qd+IewXhQkrpFagPBxrVINlHGKoJx4lXOz0h3n5uhTB/tgMYEAXzWGYN4W5u/PoFpXi9xe2YiVfME9E8p9oDPyz1MCTpyxH+wJEfGtb4ZhMyV0phkRh7rtLLcffGpt2T/0Auuo/YaFkJ46zEOHDJiSfI7i3cPew4IZG49B4n8gI4M7gPL1QvsvS4X8uZijReUbVOTbJvt+O04XTTiRs6PytDq5bqp9t8r9zfeeBdxU5ht1ubCWJY65Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+GSr1e/iS2aEH70eAjyDSPa+kypKdVmN1ZNYsUpxw8=;
 b=b8qEgz2ePkkucVEGkB/fPYcTrM3aV0oxOhjRnw3no1+TRlSnOhknL4GE6AUxWVHczTCj1BSn9MeQuBoiiGd/C8HYS1tUfNOKsvfDovnMHx9mZ5GUI/r2Cpbn90J94/3UwLmrHWdwbJwlb9txEHVfZc6JtIZDuAvbARVaxmtpoAAy8kk/DFCTQHGQLvf7mbWHHKp11u/9sZu7e3O/NjQr3sFprwe/OrYoWElYBM+0Iz5a7PeZpaQma6l58jcVFp5iqZoPxPxGIfqTG4tzBRS0NcFS2CKn387oAepCi2/jk2xZSkHkfkVg4/iW/S4kEGfZRnvifllYwnx3apeKC+aOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+GSr1e/iS2aEH70eAjyDSPa+kypKdVmN1ZNYsUpxw8=;
 b=ZD4b1Lvax86xcpBN+DjRb/rzYj9qu2/NzneGERvMYwof3J2uEpRbSmd3WMJlLrZjvd3nHpoqgstfnSA8k70uW2y5+u2zUueg0F1cQCKOETpLaomlIX5XzHbvQYKNnXwd7BtFspay0aPfdHfaTzjUeFcK8KhbdFFO0CmO9PXFcw445ltgpTJxP41KJHp5tsiUnonkA7/q8wG/z1U5KYKcWWfuZ6tNioKXmbq/rGrk7FETalHEqIh5DcK65b03J1rbKSPoAvacOkp7gdSjEiYbxB+dYd1jFVVcL1tduubGD/iUIKG7jmdq/QHatDbV5MaMh/no/sspq6P3e13soLnAwQ==
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17) by DU4PR10MB9166.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:569::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 16:53:00 +0000
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063]) by MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063%5]) with mapi id 15.21.0662.000; Thu, 19 Nov 2026
 16:53:00 +0000
Message-ID: <576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
Date: Thu, 19 Nov 2026 17:52:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR10MB992304:EE_|DU4PR10MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 67638c91-e9db-42b9-ade5-08df465d91b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|6133799003|22082099003|261009223027099003|55112099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qWD22bJQaRiZoj21/KIE0lu6Tkc9732qc6GXPjaepzCUGp8Jwumb1J+QZ29+CQB5pp1esEylHjzNUUoyhEnK4lHW4yYWQSDLRbLYvzj1Nb+niGnYRdRcr2F89EGvQ9W1Gkr1GDQhZA0vTW+vcKuEdaEKCAc76wXUqwS37aj44HqatWkqxGUyB3HP3kNpALEJpFbKUfcvYruDcKb08q4XcZeAZrBw/EJBa77ARiueE/45rZUmEWYIQrJUj2r89p0mz3L4Sz2W9/EN9WWFUIbqxuyeCSKmzBi8twvK7IcZLZ6jzhp0mxFjyL2uotDMv8bdcU5UOA24PtK5bUSSFVf1Pvq8fSTl8tOK9CVnIZaqOgz6eqxt3zjUvJUzPHGYIWMSttWQFzJeaTfZGacZaSz4YUVYuxyy5xJAuj1qH0gjKHBDgrxL5eW8qDEWaa2LRlbLNVf6dAQpSsk6erzx/rbBg2E0pLzuKEJGCUpa88NTwU/Fg/TBqDi5L9H4BM1qLOW/fcqH9zT4tkkRJDJC6KglC1CKUEiCH1l1MpPEaDfZqM1kW5Wy5yWUOKuGSfoChCc1j+DUWlraPC8Khw6g/6aRs0McRxZ0Hz90jgTNWcuukiyr6AJA93u6+MQ8GLoHidkUjDyJ+d091YTK9XnhouXiY5ARz7MYk33cTu08tc2GFfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(6133799003)(22082099003)(261009223027099003)(55112099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUR6aTVFMHFmQ00yQ2I5dGpSYzNHRnRZdmtMUlYwZExBWnRXYmh4WEVkWTM3?=
 =?utf-8?B?bG1wVVVhNXJrR1p4c3RCQ3FjZWZhNTh5OUdJditLTW9uNGY5cWFWYjZ1RlNt?=
 =?utf-8?B?NGVMZ3R3L1NLOTVZVHlKZGkrSmJSd0k3VWR1MTZKeExlYXlGTW1WR3ZMbG5N?=
 =?utf-8?B?dExOMzZNUHV1NEdUNzEvRzdYdVNaa3c4UkxzN1VvWUFlV0xva2h4alA0anNx?=
 =?utf-8?B?WjBRVzVIVVJFeHNTT2pRSGFrVHpPL2MwcWpabDhEelZVNW1aNVhMZklkK2FL?=
 =?utf-8?B?MHpkTG5PeHRraE9mNXdSU25CS0lHYWp5bFo1ZFQzVWIrMUtWMXJaMEVtRjNS?=
 =?utf-8?B?YUhuQzBGTitJK2NUSEN1elVuMHhtRTZ2VkdRcE1BSWdKOWlhYnEzS0dYbFN2?=
 =?utf-8?B?eEI0ekRvOHFHOWNWQnpNYnRNT2luU1hQNGh4V05NS0U5eVF1d1Ntc0RTYldt?=
 =?utf-8?B?MTZESEVrZVVDZXpWcGh0amZRL1hHd3cycU04bjRLSk82aWVVUEkzWEJOR0Rq?=
 =?utf-8?B?b0dqai9EVGg5U2NoM3RZaWU3cFR6MVVNVUlvQ29ZdkJKRjNFSFU3VWludTVn?=
 =?utf-8?B?NlRDRFJYSit5NXE3bWRjMkpoMkZhNUIvQzlKNng2YS9mbkRqU2NRdHNzaWow?=
 =?utf-8?B?WXpNekRmMEEvT2NqZHM3bUNBTDJONWlseFpld3dMMHhVQ1dlMWZpa3hyTXJO?=
 =?utf-8?B?RkFxN01TUGphMzhDNlI3UFFmTnZxSzRURHZObWc1Nm5aTXV0WjdRUVRQcjFw?=
 =?utf-8?B?UWszWXVoV1QyS0VQN1doUFp2VXZFY012Wmw1RFlvcm1hd3pHSUFrRnpaQjRG?=
 =?utf-8?B?ZUkyQ3FyMTNpa3hWL1FwREJTSHdKQVpyN0hSZjJTZ1RHZHliWDgyeGNybWls?=
 =?utf-8?B?TDRha0NnWTJEWCtKU0VSUXlMZ2orK3puMG9jQkhGWERwMzN6VEY3ZFliOWV1?=
 =?utf-8?B?YnErUmpsbXJaenF4SVJNS2Z2RHFES256bWg5N2JQL25BUWZCSHM4cVdLQTRE?=
 =?utf-8?B?Q05kbmd0UExpTDZINXI2OXQwcEpidVF2V3Y3dVd0UHlLazRqZzNNOVViMUUr?=
 =?utf-8?B?dnl3blNkQTZOeXNQSHRrNkxLMENIcUVYSkVkVjFLNnNQYmJQTFoyOGZDMW9E?=
 =?utf-8?B?VEQ5RjB5VUVLZ2JOaTU2N29sZE02dG9VeDVmUml0bTlLSllGZmF2TXBncGUx?=
 =?utf-8?B?c09ERkZkQ1hGTU9JN2dGVmxXWUdZRmpWbDF0UEZ2Q3F4b1pHTTRsME1HMHYx?=
 =?utf-8?B?MGJKN3Y5MGFuS0hyNURranVjUlMvWlgyUUN1N1krTkMrODdyVWNDUjJTRVFG?=
 =?utf-8?B?NDNjcmJSODJQblEwdS9NUUlUaVppcVVYdFR5czJQM3B5cTFBS3dYZld4ZE51?=
 =?utf-8?B?dndBekFPdE8rNVRBVklBd0R4TERXL0o2d2xTdURjR2d6L0ZBbVRvekszTWNI?=
 =?utf-8?B?dlBKT2ZKTGFvTVNoSjVCNUxwc3dveGdGSWwxM0hwOU9MRkM1V2k2dnNHRnVI?=
 =?utf-8?B?UmptQUR4eERUVmV2YUxGSjh6SW1tb0tzbFhUTisydWlDM3dacDRIUUFQTlh5?=
 =?utf-8?B?eE9rNGpvSG1Obmdub1NQUTY5RnJKYUNsdFhQQVFYdE9HMjBmWTY2NmROSmdu?=
 =?utf-8?B?aHpnUE1JaVY2YUI0b3J6VExRRXlQMHNOREgyejNsdmJhb0F4SkZ3bjBMb2k3?=
 =?utf-8?B?ekFaUGdVQm5ITEFXbFJmYWltVUxMSU1DQ0lnT0NzY2x6NW5oQjR2TUN6K1VS?=
 =?utf-8?B?QkpING9ZTDdzOVRLbnRlSWgya1NHVUlMcjdpVFZQQWprUXM5cXE5RTd6NWl6?=
 =?utf-8?B?QnYyNmM2Z0ZkcWl0VW1xcmZBNWszT3A1YWJSdUdKbUFkRXRpYmI2RnhQRFdv?=
 =?utf-8?B?UTUrUkhUZ0tXcjVld3A3ZEQ3R0VGTmJ2dDN6aEFRbnJtVVFycUJOWlZKNWtI?=
 =?utf-8?B?Zm5yRklNcFNmSWxoVEQxSmdmcVRwWHRyRTlhSlV3TmwweVUwRWUrUWU0TGZx?=
 =?utf-8?B?ZzdWSHBOTHo0dEVxV0s2VGNQL0cwNUFYZXJvMDE0YkFRMWd4WmJOR3RxSzU2?=
 =?utf-8?B?U29JbnBDa1lhb2lxQ2FIL3JvKzd4bkMwNGxCd25QMitESW5MTXZCeEJreU11?=
 =?utf-8?B?dENabGtBbFdpNCt4aHBhVkMrYWlYMUw4OGMrK1paOVBaVzEyR1NvTTJGT3VZ?=
 =?utf-8?B?L3FUMDZvRVR1dE1HVWVkZ2crRmtUbTBHZzRaTHM3SEFFdEw0Y1FidGt6aDBo?=
 =?utf-8?B?ZzQ4bmV4S3NoRHJiaEV1bGs4TUFTYlFXWldlT1N4ekc1bEtqTS9xaE0rSWYz?=
 =?utf-8?B?M01kSFRlWXRJRi9nNWFxano1bkRoQjF2ZVNkbE5Maklyc2ViL2JXZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67638c91-e9db-42b9-ade5-08df465d91b9
X-MS-Exchange-CrossTenant-AuthSource: MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:53:00.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4wD7uWei6K9GaiOynAPDYgm7fZUgIhx3xr0l+XJ/S4QsznxQsKYJRa8+oPSY2CkXdh6AvZdW99yrTgj+IUxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9166
X-GND-Cause: dmFkZTEa9zZGvcHGZACiKhIMDKTGIKdiQEcoygPV4xW/hnJxEgZWEmTAoQmWudfPRvWKmZJYyZl82lL17aWKqfj5FeVPLSu/+vtdAHSD2r6X/4Awtw33++p0kOXo8Rq4NobGnbK9d7S8d3Dh2nKl/rQgnpqvgNw9Phg6bsKbyoxLmSjL/lcDEw+LW5m0MkmGqP6awA0OoaahL6JrhDYzE7uN0aLvAQsdAz3ll0wzQSMYqVqY0YVRj+l4reKTf+68jfZbq+Bk5657sz+rWJFf79O3tzTJQLfaYpuuxAxDCbs78byTxvbRcpAGyyBcpf40lQ12nSaFBrWbAgeqr+tWVLGfs0QKs0dvKfiTo8V1nFTtcuDOUNHpLsijjIad2JHNhoAZuZvpJdRrNlHTzFdW3I2dUxF4mw38SdYRknuvltBoTYzPlezPA67t5BGfuoQk4Pu2BUnTlMbhCxgiM9IiqkP10a3O5kFZE1g8+SEfAyn9LU3MSYS5sN+1AxWmf5/iHTOSnp7eU2+AQAxrLvlQ3iz5O8SjFA+5vKS2ZE9H7lIb2lDCalpDJl7qK0uS9t9ujcWAyHoC4JoHr4r8RIELElX4AcJun20TURs2VmA1qrOe4kmbGwtGVUsl3qCHH+9udAmOvF+PPJQtJM2tW1fOGPFhUf/y82wlVt3WVDnlRlmuYg5AOQ
X-GND-State: clean
X-GND-Score: -100

On 11.11.26 13:10, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
> calls into the companion core if the flag is clear, and sets it;
> oob_trap_unwind() calls the exit handler and clears the flag whenever
> it is set.
> 
> This does not cope with nested traps. A trap handler running on behalf
> of an oob thread may trigger another trap before it reaches its own
> exit annotation, e.g. a user access from an emulation handler faulting
> in a not yet resident page on ARM:
> 
>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>     do_alignment_ldmstm()
>       ldrt/strt to user address       <- translation fault (SVC mode)
>         do_DataAbort()
>           do_page_fault()
>             dovetail_fault_entry()    <- notify suppressed, fine
>             handle_mm_fault()
>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>                                          wrong frame, and the core may
>                                          switch us back to oob
>     ...emulation continues oob...
>   dovetail_fault_exit()               <- no-op, flag already clear
> 
> Since _TLF_OOBTRAP is per-thread and the thread does not change across
> nesting levels, the flag alone cannot tell which trap occurrence owns
> the notification. The exception frame can: every nesting level pushes
> its own pt_regs on the kernel stack, and the frame is already passed
> to both the notify and unwind helpers.
> 
> Record the owning frame in the task struct when notifying, and only
> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
> exits become no-ops, the outer exit unwinds with the trap number and
> frame the core was notified with. oob_trap_regs can in fact encode the
> semantic of the _TLF_OOBTRAP flag, thus drop it.
> 
> A forking parent can never be inside a trap handler, so neither the
> flag nor the owner frame can legitimately be set when a new task
> inherits its state. Add a debug assertion for this in
> inband_task_init(), which turns an unbalanced trap entry into a
> loud warning on the next fork instead of silently propagating the
> stuck state to the children.
> 
> Assisted-by: opencode:Fable-5.1
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/include/asm/thread_info.h   |  1 -
>  arch/arm64/include/asm/thread_info.h |  1 -
>  arch/riscv/include/asm/thread_info.h |  1 -
>  arch/x86/include/asm/thread_info.h   |  2 --
>  include/linux/dovetail.h             | 12 ++++++++++--
>  include/linux/sched.h                |  5 +++++
>  kernel/dovetail.c                    | 10 ++++++++--
>  7 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 23cae59037c1e..12ab7e49b7b76 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>  #define _TLF_OOB		0x0001
>  #define _TLF_DOVETAIL		0x0002
>  #define _TLF_OFFSTAGE		0x0004
> -#define _TLF_OOBTRAP		0x0008
>  
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_ARM_THREAD_INFO_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 48563d782a99a..934b080246146 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>  #define _TLF_OOB			0x0001
>  #define _TLF_DOVETAIL			0x0002
>  #define _TLF_OFFSTAGE			0x0004
> -#define _TLF_OOBTRAP			0x0008
>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>  
>  #endif /* __ASM_THREAD_INFO_H */
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 820a596d9bf65..11164e12317fa 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define _TLF_OOB		0x0001
>  #define _TLF_DOVETAIL		0x0002
>  #define _TLF_OFFSTAGE		0x0004
> -#define _TLF_OOBTRAP		0x0008
>  
>  #endif /* _ASM_RISCV_THREAD_INFO_H */

This hunk was forgotten while merging the patch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
