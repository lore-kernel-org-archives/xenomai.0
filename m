Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9E34CDD
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489921; cv=fail; b=NQigX1qpX134/2lDJOobaZ4gV5j6Ve8q9ufKtLi81kfKkYwtROr53gzsd04B96nqywd9tM34aoy7a53+Rh2eAOKyUf5Gsr2m8/dJTTcRTBBnjFB04N1nqNXOo7mn7UG686m2Y0P0CPXS0TeYLhh5z2N+Nco18py6wmvUiOsvNcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489921; c=relaxed/simple;
	bh=waGPUpWve9TphAW4HR3ymgp5KBlBGVPMwBrr2zV3gq4=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=kacYRH/+PDM44QoW1v8FlQVGsdJaj4DP4wZDID4Ge99w62lMHzIIK+i3y/mWc2y9BdBGzmSB00DXu5Cj8WpdsbZsJ4yUC7Lg6Wyy5Iyi1A634HmOwndSQbBfz/fG59Vdd1Hpv6tGWEtWRihScXjv3PkNmt4M6bqYOzddLdU3q04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o+vFV05s; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o+vFV05s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2SPmG0/FMY0xMi++EAZtTayhK7JNEIl1BRl59Kyqmc/gX55e6vsIoZfVFrf6tibhWGc3eJDbBrJzb6NvzjI7+FO9Vih2/d9IiXFZr0IwmD0sXs9UIfpmgVLAXtjUq092eDjKDpQioWbBsaZjQtQ2usPKkZ1Xw/x/kv6FfUDE/nm0REZDo/ZzAGWj7v2GgdPbIDDC7Zr1SST5IgyRMzETlAIBtK1P7DMMm1sW+47eXRXPdAGWhgRy16fJiP0vyfhqLGA/aB6ngv92Nzrvk1FVXHdQjk2quuTrxfku2IkzBpdx3wcoWaqieXW2yy4A0hiwrkSKcy4qhmP2COrHmP81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQewwEOUREou7obDMl2St0Jf0pgYe5nqZSldkbGRtFw=;
 b=gPgI/WnnCSXs/d/qC19XeEI9Id3Er53dTnlLtXdnovW91IQoekI101pz3slIjZEl4ipOfV3mgueGGfYZaCFHwRE+EcZ4Drtbz0AR7Ul1bMMRVqhQr1Bvu0lKWHYZDkhzoL0Vjs3tw5ZdO/BdfqGDeqiQHaTIFwzlh54tufTcNS5QzIWHfaOQENywBB1gwb+CTHJQT2YIeT21tA0kVVqGvoO4gfC5J0GNaI4bxdsQatTuuspwOjg10518GrYMbJ6OBgsQEaCCVZcBqgrzKCUbQts16zGXb8/f5CdIXviTdErcVojw+ApjNu0g7WPdzn/H47dgIjNjlemqdLhXdjq3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQewwEOUREou7obDMl2St0Jf0pgYe5nqZSldkbGRtFw=;
 b=o+vFV05s2vvKlHY0ArhWkf1uAjbFEE1FeGlW0776u0flzpY2n25iz3f+lfY1X0co4+rmv8avDuN6DiNHOyVIa+cxS6uB+3zk81VzEnGfLrjOGOp6e3Uovc+MWhMw1hG8PwDz+SINtcGhBmhuUSwiGfUk2R7tv6yfW8BK0thjOGKyRX8akIg0QMd20eVXlSCJ5I+ixYW3P15YI66Vp1w3w6HWmzue3v/+iYOPLhLzWqaP+s3KNizJBAWzeVKZllHJBbGDqqu+ZvUKLqHQQt1xgFnxdjwbY51ZRRPpyWbMBTZtCO8AxMYRcomMEJFLwcahJcBFbpGnXhjVUi6er6+8Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:38:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:38:37 +0000
Message-ID: <e4d987de-780f-46a9-b642-8acd9b0766a4@siemens.com>
Date: Wed, 10 Sep 2025 09:38:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.7 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3662:EE_
X-MS-Office365-Filtering-Correlation-Id: 821746b0-0551-4d94-c462-08ddf03d0dad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5KTFRwK2FVSEFacUx0TXJtbXhFeHRaUFZ2U0daanZGOTdXVW8vNGJCMTcz?=
 =?utf-8?B?SmlGYVU5V01meU9ZSldIdk80UG95OGRsT0pnM3haMGdSV040SDlTV2x6bVZJ?=
 =?utf-8?B?V0dXa0JseFcyMjViUDNacTJoUFZKeFBXcXR0ckdtMWRWY0VpVGFTbVErT1gx?=
 =?utf-8?B?RGpObnVWSHJrL2FUQXFTbFJqNUw0c2p6aVJCd2Era3l6RGhkY1laNXA4Z05F?=
 =?utf-8?B?enZwdUJiOWwwaS9PZnNOZUltWm16WlFKeHlROHVkNmxWajBabTVESHJheE8x?=
 =?utf-8?B?WE5PbE1NaGtJdVFxdlFaTXBxTTdYb3VwTzdZREFxRWZ3L1laZWZsZ1M3azRj?=
 =?utf-8?B?ZHhYbjBmKzIvWTVhMElxOHd4VGxVd2JHZ0xmRTQwS2xHYmp4WVkzM1pFaCtk?=
 =?utf-8?B?cjB4c24wRG1ZS3ZxY0F4N0tIWHFYNXlaQzJ5ZHFCMVljM0sya3J4NUFSZWpx?=
 =?utf-8?B?UHh5ekNTOW9zeVB0R3ozOU5zSzRGbzhCZzFzYWVPbm1ndzRQL3ZNQUxJNzdE?=
 =?utf-8?B?dXl1cHYrTDM5L3BxL25Qbm1qT21hT2lqbjFUYXRCTGp0SHBreUxDQ3dvNGcy?=
 =?utf-8?B?UWJGNzErRitZTGUza0ZpakViZlpUNkxQVmVnSk14ODgzaS8vWG9jZzFuUi93?=
 =?utf-8?B?ZWpHZkFoTDFxYzhjN253dEN3Q3gwTXhpS2Vtdm5iRG9HQ252MHBIZUVNZVVL?=
 =?utf-8?B?aXlIYkREQnBoSjFSTm1sMDEyQlhJM29wRi9QYXM0czJpaUo3ZEpZOHFBNDZi?=
 =?utf-8?B?ZnVWaHMrd3ROc2YraGNuck01TWtsZHNBZVpKZGFBNWw4V3RDemp6TkFuVWdP?=
 =?utf-8?B?ZTFKOGV4RVZ6VGdZRXNOUkJDNEx4b0pObHNlV3NUM0NzaldPclpIMDdDSXZj?=
 =?utf-8?B?S1dzQXY3Uk95bnBSUGhkY2NKN1JaQ09TRnhtN3kvek5ra0wxanpCbXJFejU5?=
 =?utf-8?B?R050OG9oZUZTR3dXZFVIR3lwYzAwN3VLTTBreTZEa21yK2RyYm9GcFczNEpE?=
 =?utf-8?B?K011MDhndnZKSTFxbHhHcUY3Z04xVWNrMnZBUGliQ2RUZXppTnA0ZVFJUGZx?=
 =?utf-8?B?dXpFZzJtMHljc2c4SlcrendTR0VXSVFkZllsUHAwcGd4KzIxTUVheXJQaWhC?=
 =?utf-8?B?MlBnaWRWa1dRWG5JTEdwOVIvVmIyenpoQ0ttd2dXNzZjc3JCbEdWVTFmVVJl?=
 =?utf-8?B?Y2tqcFVlbXhyRU56TE5HR1hscmlqQW95VFB5eFZPa1RoUkM3Y0V6NDVEYjNB?=
 =?utf-8?B?Z0xUM0ZBQ2lPZTUvVnQzKzU4THQzZ2RHYkUxYXh1QXlJRTZqeVJaRVVZaUxj?=
 =?utf-8?B?eHlkaVNZc3pnYUhRWjRxSUhXMlQyNkpyeGpkdFVML0lxNm13SDBza0pTZVU1?=
 =?utf-8?B?dUtYaFNOK01XYjBnSklkcDdkeXNRVWZFVU42U2k5NC9BdXgwU0xVK04wNU9y?=
 =?utf-8?B?Y2xHK3Z0elRMK1FBdFhzSUxDTjJhc2Zha1orQUV4Wm9YWlZSYUhETkZYQ1hV?=
 =?utf-8?B?WWtIVFdiTGI1V2lOd1h2dzE2OWNLdFVWaHZWQjAvbVZMV3BuQXBaajJ6c2Fa?=
 =?utf-8?B?WGd3VE41UjJwMUpKaHNSM3lKaXAyZzBwcUFZQ2RsY1ViR0N1NndnbFM3azJN?=
 =?utf-8?B?M1l0NmZBSUE3cFB4NENCaXRKeDdQMmtJbjVzM3hnM2M0YzZVaThlYUpvUEth?=
 =?utf-8?B?V1EvSWpkR0FIeDV6REphWmNqMGxjSENlOS9yV1hpVTE0N0xSc3hVaFduaWV4?=
 =?utf-8?B?OTRRVmxKa050SXVkbTU2TXVFTlhKK29Eakp5MUVhUnVkRjBWZTc5RTMvVmRD?=
 =?utf-8?B?TTBDalc3UWp0WThiVUVZWWpKS1Vmd0FOVUpjeXYzc1hrQU5FYXQ1RUFkRzZ0?=
 =?utf-8?Q?qAU3K5ER6+NPD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5tbGV1K1p4VThpZ1k4V3I1THYwUUhLYTJ2eUxseW5NaTFzMFRrU0Y5eHdt?=
 =?utf-8?B?NXdQZm1sY2orZjdLcGxubEhKcitjUG8yZmkvdHNYNXVkQnltWm4zT3B0ZFUr?=
 =?utf-8?B?QWl5R0FqZnQ0UHFhWVFQU1V5eWtRazhjV2drU1ZEblJQREFKdUdyTDFqcVlP?=
 =?utf-8?B?WHFETkVIY0dyaVRBbis1RG94VUJ4K3FsSkI3Ui9nZktyN2ttMURyRVljeVVG?=
 =?utf-8?B?NmFnMHFXWjR1NGV1WTZvUUxQQjB1TWlrVkh6cm0vZXhpemNScWpFRm9xYmJt?=
 =?utf-8?B?YzRTeU5pdWY0NW1TejFvV3ViVWxyLytOS2ZHcEVLbmlJM2VaZ2FYU1BTVjlD?=
 =?utf-8?B?dTBXNE5xMWlrQlN5cGFhVUV2MzdLcDQ0dDdqNnV6anR6Z0owYUxJQklLOHJZ?=
 =?utf-8?B?Nno3WE96Ulp3c3Z6bUhER3RlM21PdVo0QVZXdTdjSG1xclRkcFFEbW9PLzV6?=
 =?utf-8?B?a1FjSFh1ODY4bExncXN6a1h0Um8rd1ArMzN6UHlmWVpnMEhXTVMrOXdtOE5P?=
 =?utf-8?B?ejNxRHh0VExtT0ErRS9xZ2ZmVHp2OStaZHFtM01MTVZ1SFFFdVRXUGt6bFRs?=
 =?utf-8?B?eDlST2hXQnhjenppeGVobkJaVDdRK3BMWFhkUjlNSldVaCtXQzVVVjF5NDRh?=
 =?utf-8?B?MUNHZzVTMHZjRTNhNzJvWWlveUpHUk5zazJ5a1ZscCtxNlZzeHlvZTdYSlAr?=
 =?utf-8?B?eXBWdUZRYlhqb09vYmNKQnBlQytkUTVxbisydWQrc0JJV0ZMbStsY2dzbTF2?=
 =?utf-8?B?cS9vMEpKTTFQai9tMmEwb1RxTmlNdzkrUWZqL3NrVjdHcU44bFFRaGkzZmlm?=
 =?utf-8?B?YytLRHUyM2MwVC9YS21zMjBTL3Y5Y3pWQnl5TVFTOThpbmRrdUl2L0hESEp4?=
 =?utf-8?B?OExSQjRUcFdzRGNEREcvTGRrVkdocjBVYlNGV3A1Yk1sMTRLdEJqbTFja0l2?=
 =?utf-8?B?OU1WZmhNaFFLZVE1Y2dVT0g4bHd4QkJ4QVgwMnVHd3ZJeWtwV1g4MjkzcC9w?=
 =?utf-8?B?RWFNckJTWjBxOElHZmUxMzd5UjE4OFlCczlzd1h4SFd4QmQwVEVGeXhGdVls?=
 =?utf-8?B?OTRBUmQrVFVBNHRtQ0hQRGZZMy9GK3dvb1R4N3Z1V1QwcXgyNUxIWGxKZm5p?=
 =?utf-8?B?VkU1d1h0NmhjT0J1OXdWbEhmL25Cbnh6bDY0MXR6aFVLakliSUoybE1lempQ?=
 =?utf-8?B?bHVEK1kwL2F1MGNLd2VsalhFbmV3eXp1blhkSytKRGN0VlV2aURLaDVpTkh1?=
 =?utf-8?B?c1BqanhYbnpaWDhJLytvNitEYXZ5b2hpSWxuT2J6cXFCWUVyaUR0azRTdlpW?=
 =?utf-8?B?ZzFDOGgzQnZSOUFMUjBjVmdQMjI5S1dHVnFEK0t5bDJhb3lKd3dyNjZZN0hk?=
 =?utf-8?B?VWtseVo5VFdsNmJra0doMFRiTzJqai9hTitFWlFod05lYk9CRjJ0cG5QM2s4?=
 =?utf-8?B?RWxzbDk5Qzc3aDlURzE1Zy9IZDlGMEZkNCtiTE9rNzB3Q3ZZMHpBYnk0ZVU4?=
 =?utf-8?B?b1RXS0QzY3dOYkNydm50WEJFbFVNM0dXYldpUFQ2bllpamZxMkhwWVlBZ2ZZ?=
 =?utf-8?B?c1FXSDhXcWxPcGg0QkJ5ek9TQ1dvSUFHelhBc1FOOFBkRnUyTjRZaFFEUEIw?=
 =?utf-8?B?QlVWR1ZhK3c4UG5xdHlYR3pFeDEyNXZrdFlvcHhPV3FDSXB0c2xkNmFzRE9i?=
 =?utf-8?B?bHJ0YjlqNG5UamtQd2R4Y1JTenB6SmNQNWUwZmMvV3lzV3pqUDhDUDdPOWxw?=
 =?utf-8?B?Vndva1ZjUUJhZlhDMjhNWS9LRXNzZ0hJbEVycENEY0kzNUtXV2xOZnFzU2xT?=
 =?utf-8?B?b3ZKRGlnRUthcDVRNVhSOXplWU5qQ0xHaURBSWtUbjJEMWtUU3NVd0xoY0Fy?=
 =?utf-8?B?MXpRQ2dlTTlZaFRsTFJiUkZyaVduZWc5TEI5VUNhdHdmS1hrMFZtZmJJblgx?=
 =?utf-8?B?RDZaQVhVMytNeGJ3U3NhWjN3Rnl1MlpmSXI1WHRqTHFRSDVPMjZ6M0U3OGVD?=
 =?utf-8?B?NUNXVXBpOVE3Q0hHTXRoUHZJN0Vjbm1hdDRrR1dpbnlUUjRmQ3JGYmVCdm01?=
 =?utf-8?B?WEUvQkdKbjJCeTREZGJBSlhvTTR3U3YwWi80U1FWY21hWE55RWRuRzJJUUdh?=
 =?utf-8?Q?oRZ2mq6wmx2JQBzqcGZJDhw0D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821746b0-0551-4d94-c462-08ddf03d0dad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:38:37.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD+pCJbLaM9TEaGBHQUgLhUZ5/n59Ea2C5sZQuAah7WrAaqWnJqL8rYOyCWcgpC2JrIJiqcXQFhS7o0tzjB/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3662

Finally an update for the 3.1 series, an even smaller subset of the 
newer stable series. Also here likely most interesting are the fixes for 
cleanup dead-lock in libcobalt.

Download: https://gitlab.com/Xenomai/xenomai3/xenomai/-/archive/v3.1.7/xenomai-v3.1.7.tar.bz2

Changes since 3.1.6:

Florian Bezdeka (1):
      demo/posix/cyclictest: Fix building with glibc >= 2.41

Jan Kiszka (9):
      lib/copperplate: Handle allocation failures of pvstrdup/xnstrdup
      lib/cobalt: Unbreak sigshadow installation for statically linked applications
      lib/cobalt: Fix cancellation issues over pthread_cond_[timed]wait
      lib/cobalt: Avoid deadlock during cancellation of pthread_cond_[timed]wait
      Switch hosting URLs to gitlab.com
      debian: Enable parallel build
      README: Update project URLs once more
      ci: Pull buster from archive.d.o
      config: Bump version number

Jan

-- 
Siemens AG, Technology
Linux Expert Center
