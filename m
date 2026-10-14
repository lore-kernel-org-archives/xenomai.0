Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04304DF4AC
	for <xenomai@lists.linux.dev>; Wed, 14 Oct 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971503; cv=fail; b=L9Xj6sf8Py7F8yjsK0ubnUO4qvNMxGZDCVet4T2B79R9U1o1MaDSBijOMiFceNC/DwRZgPkPRePFNI3YEWw41Y1XBZI5obRVB1jY6YVhwGx3M/GxmzR69LcBlUJ93Q3RxOTAFXTHoOkxnpYa9SuoP5r6GVZ+r3AQa4yV/46x01E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971503; c=relaxed/simple;
	bh=PBP3rBz6+qSUu00rInIAS0Y0mn5+7XwtC7PD4Ecno24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPBmeUUX32kfXLsw6RyceH762n/wpAEEr1fivuPC0WUC6zgBN2XCbSILQlURFbkEym7/M7kXWaJTQ/cbRdpK50XzpXREwNnfsrG+sXeNZljy/u5zDCCPApDs42irEQ4VAwS+Csjs26in5/KtSv8mO0Nh6Vc6KK/h2svzqT6pAWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VUNn7z1S; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VUNn7z1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd/LNNZhCN2cby5LXFn3OkebqFhUlSZgcaux0X+pP8vlCmddodYzz6RSjZqZvH4L+Vf4yRw4etQ4pxilG3QxqMjZhYrdVNgLTQMQFCeVw52BVLb+5/C03yrHYFnTG5BA7U/8XprcR+Z2ybPqRMznJAdB7APVr7W3fjnM67ZTH1uZzfTHNR1Ug/haJOFc4ZKCZg9KxiXCslei8h/U72Ast90UGiuIE/JSL8Nu0nnjjpvUACwFBP05YRL1sJzx9I1RpdllfjqnzjNPvOE52ynO/Yuykxhfm5SKO6w+QyVJuxiiPjn+Euq0DKB5ycMvQ4+aRY0Mg1J9yKw/k6RM+ALqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wgTwJhFaXKSdw7bSUb50pyuVh0CIIrps1WuqISXUgU=;
 b=dsQLIAaZjeVkpCjpWm8JeGPg7EwmNWfCR2+v2qxdGtcCVGbYSePc59uwE+udsGaUFZyX2viZBrZqcXMsUNYrQ43cW8AJuiiMIJxtI49aDYGjiin/bCa6QVLWNUoellp4Gtahq4teSYYCoVs+DHsm/p0DQzDex7id6euvaZTQVCrtZBe/rWbN1XSPGlFGn0qvhIL2gwqVwmaazCQygr8gjJHXm1CkH+pCGLJh29L/777cTVfTtag511RIXMCDEMXUb/+t9Ab3nkQaamO1avkJjclervGw/TiemE2B2oZdGl1Uqw/nZ1cLpWhygtvEyw90sgPwSi3Gu+F7dzNtyEZXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wgTwJhFaXKSdw7bSUb50pyuVh0CIIrps1WuqISXUgU=;
 b=VUNn7z1S0Fj6vUyW04hg2c3lkJxsOLlisCuPi2MklfZC/7RfB4mC48IsLCPRSZf40wYuR9mpo19KAtxuB9p+QALcAZUN6I1Pg/IydbV085FQPLpAJ+GdgWG4O041gFjYbgifbdkFCwSzykByIWqysxkkidrUAIlYBfhkrTowUH/5UATHpS94sujDtSz+kDa3AncHVf9K/syTybv3KWsaUoGmYadAr/A0Z1sdCe+0IWo1WC9F88eJELF1AnLJNAn4qgBD9p+UJ5hrZf+4v8ozYZVAY0xRbeHtKCkkeHmjRNaGZ8BnKiJxMGvx2lKIAQDBPjX0NPHiT4/NPXt8XPyjFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU4PR10MB8879.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:55b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:51:36 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:51:34 +0000
Message-ID: <9f598cf9-5a8e-4f3e-84ae-5e1ca7bb66de@siemens.com>
Date: Wed, 14 Oct 2026 11:51:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Call today
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 "guangfeng.wang" <guang_feng_wang@163.com>
References: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
 <CAFLxGvxKcWEvwOBnTOX9VQ2wQiUsML7r267zRMD_ixL3EyUCdA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxKcWEvwOBnTOX9VQ2wQiUsML7r267zRMD_ixL3EyUCdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU4PR10MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cd5534-94db-4a01-8164-08df29d8bb25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C/RmFqKqNpYWxDp2PkGREvb6uxDHxatuxeJJ9CZtOZTDhAwGtv3Z+YLBdiUgifHzjlY4fkD5zDSbfTEuz+U5RBmyOJlMwxiz4MCOxp3ObDfq3U36tRxt+m9h0aMDhi92VUA/ZmOwVCQNOoae081Aa6b/fCeX0yWEui9ovnwecB1jgyKQ9R2dxFm6A1yks2+rj1bne06eSms0EmBFe2DRTR7ZOK105pQNZ8SXzIAFENwwFouaeB0lVGcZpGfR7KfNrIx4EK36otgK1NcJLcy/SovEyAEnHX36QXgJ5xkhxxo7pl2+8Vw+qpOabc0rYqhGdpXrJkiZ0tCikduTvmkOCQBFjRqNA9bw3Tpx6VoZUlmCfNo5q57pja/EljbL3CE9JD5/FGTDh0152jI2sPsJJXh56WLrSoxiVYnRPXKwesocTV8T6op7LMU8Oo1tbCdRZ92n3Lzcjx6ekLp9h+eMdRbAIteZdu7mqoqGpfswhJ+K5Bjq+3TpU3oPo+NK3jzvRHsoq3PHl7/lSaTP1xeengCOUeaxtmTLYN6FSZ4/yTReI4xRkNuVFhWhd1vvvW4rYNeZVuufkBLiY+KP+5KOxWFjVO+XZv3IJt0FTmkJqbRV91+tqqynR9rS1DYjdq3+ZjPK7IJyFVJh+1b6m7VWgpSZM0SlTpJiqnZypB6fep0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1BTDJLWWYzMVArd0NwaTdrRDM2SU5lN0tVbFBtalNoeXVSZXlOWVM3OSsr?=
 =?utf-8?B?MVdtcHFyU1Z2Zmc1U2g1a3RqYmlSOUFMcEJ4VWt0cmJSNk91M1hmVFdnNUdR?=
 =?utf-8?B?bmpUbkFob3VlKzZOUHdtREZBY0lSRXpSQ0JZYXUrU1ExVzJJQnVGNXJhY21L?=
 =?utf-8?B?NWpBV0p4emo5cDJqMEJ4VnJaK2JvdU5IL0tFWFBPNXBDMHN4MmFrM2FFMnhs?=
 =?utf-8?B?REVqeG1qL1dmVVo0UkVIZGxDc0c5Z1RJMFdtWDQ1cjZGOUUyeWpIcHR0c3hl?=
 =?utf-8?B?TU1BaVgyQWtjSHVnbXl6RHUxVEpzS0IybGQzdGxUZGJ6N0FVWkdMbFY4MUtT?=
 =?utf-8?B?U21KVWk4RTFnWWRSMENmMmFpclZtbTlvMGU5aEI4WHdNbGlieURoVU9QcTM0?=
 =?utf-8?B?bWg1YnppTUJOa012V0dwTVBzTjZYdGl5Rkp5RUU0Mkg2dVN6bFUrRWpaOFYy?=
 =?utf-8?B?SXhnaG5ScHNyY1ZzZyszakhKZGNkOUIrMEtCWU9LRURMckMyUWd0TFBjV1NL?=
 =?utf-8?B?VW1YUVZCeHlhaVg2djc0QXpEdzc0czlpdWF2enp2WVVnVThtdTBnVHAzZ0tm?=
 =?utf-8?B?K2Q0MjU2enVjSDVwVmdWeDQ4cVhmanZlSG84S3BtUFBGK3ZkSlZ3NVF0dmo4?=
 =?utf-8?B?MVJGeHMvZ1lxVzdjRXZXQUpSWnFlVC9kUVd2NzhSUXMxbWNyQkVPbzVia3FY?=
 =?utf-8?B?YVlYZ0lXaVhqSUVPQ1RzRzVjcjFPZ2s1cTdPU0FXMm1CRlNmOWlLUEV3dGth?=
 =?utf-8?B?eGR2ZlVzS1FMem1mbHovTE0xdDNRVmFNUGNJOXB1Yi95VWhKd0VFNTVqbTk4?=
 =?utf-8?B?dExsR3o1V2dtODhtaEhWS2E1KzdrMnlleUU4ampBT2VmdXJablI4cGN3TGVa?=
 =?utf-8?B?YnVtcC9yQzNWVGVpZzUyZWUxWTRGTWFRM3U5WXVTaEhwUWMwRkdlbDhnRFd4?=
 =?utf-8?B?T01na09wNzgyWi8zbjhHVmY3a2RMcFV0S1I0OTBoSTRnSEczS2s2S2Z5Zk8r?=
 =?utf-8?B?cXg3N1FxMzBpeHAxUmM3by9QbXRUK2JrVFNldmo3NHprVEtldldpQTd4aEht?=
 =?utf-8?B?aFQ2QXo3UXdWdDJ0ak90Qis2L1o1RVFPV1lscUFCZFFXajlKNExUbmVWdmJm?=
 =?utf-8?B?UjhvcGhHQ1NQcnFDNlZ2OCthKzloRDJ5WDdsMUtIaDhFZXp2T3RxMDdaYUZE?=
 =?utf-8?B?Ui9sQzBYTllZU2Z1WjNzVEl2RlVtNE93QWRuMEhmMlpUejIvbHNqTERQNVJa?=
 =?utf-8?B?R1gyMXBnWmRXOHIrS1pNQXJXcnBkNHVPam1jNXhUUisyWXNjTnlVcmVROFpN?=
 =?utf-8?B?c2NDVkNJSzI0Ulk0T1h2cUdiNEZ4V2t2Vnc2UkNuRkJNSUlRV1N2cEtZVHdP?=
 =?utf-8?B?ZGQyL1hiV3RpNUVxT1g1SE43YmZCR2tnSXJCWVU4NG94dXZsY3BVbGMwMjg0?=
 =?utf-8?B?UWk2bzVmVXE2Ujk3YXVvOVEwSytPUjJSNVdvVmhwVHJCOVJXWGU0b0VTb1Ft?=
 =?utf-8?B?ZHd5M1V0RFl6c0QzOE1qa0ZZU3oyZ0NWbW9ib0xLeldLendaa25sdnFOSFRy?=
 =?utf-8?B?c2s3cnZoVUFtT2tpc1Q0VXJpWmFvMm00QVhHb2RuMjl3Sk9iSERGTkNZeG9E?=
 =?utf-8?B?TUs4aUVibjA2d0JMakx2UU5ySllJV0xJaWsrd0h0L3JodS96WHJFcFZ5TzJH?=
 =?utf-8?B?MGFFSDI2ZWdsakNqdEg0K05TU0Nma1NJTVQ1aktCbDVocGFJQjlpUld6WGJJ?=
 =?utf-8?B?YVhtWWNZcVRXbEhBODFlVTAzeTArOGxrOEdZL2FibEJKN0tkN24wZmhBcG9o?=
 =?utf-8?B?bERvOElYa0YvMzNiMlZsSklhaWpVTDhqaFkxN2xLeS9BNlJrWkVySmtXSEpZ?=
 =?utf-8?B?V09GTmhXNk5uamNZbC81dWk0a21wandHQmdiLzl5dmZzNUpmdzZnNW41cUlI?=
 =?utf-8?B?MVdqSFU1QlpONk9ZRHAyMHJlbGpvaTFER3pzQUVaQ0hLTVJFWVlnSlhLajlG?=
 =?utf-8?B?QjhnczU2Q1I2RFZTWFVIMzl3UGU0NjNPWHV2ZnZTQjZKK3dtWGdMNnVWRVJt?=
 =?utf-8?B?MzFIRzdwdld2emRPMHRubzF1Sms5QVRNSklTbE1PSjhKb1owUVdNWDBXcC9E?=
 =?utf-8?B?OHQxMHppZTdmSks5TW42ZkxyeCtaMm5pYnpCUVIzc0NHLzRuK3FENGNlVUJy?=
 =?utf-8?B?bFZNVGtQTU1hQlgvVXl6ZUlSV2tSZThZZWd5SkNYeHYwQ0VVVFhXSFFMZHZq?=
 =?utf-8?B?VkFHNTE4akV1b2pvZDVSYTlFMFhmMzdGRlpnd2JvZVBCZTMyVkZGZWMxSXdu?=
 =?utf-8?B?WTBkOW5JN0psWW51eGE4aHVTd2ZTb21sdUIrZW1UZnBEbm51cnFDdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cd5534-94db-4a01-8164-08df29d8bb25
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:51:34.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j6Zy9WpOdnMvH/T7zo7giiQ2FsXtI2bbf5awazAJpDtpp5C/umLAuDvz+IUanQGlHsAx7AWB9NwD89R2tb21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8879

On 14.10.26 08:56, Richard Weinberger wrote:
> On Wed, Oct 14, 2026 at 7:10 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> Hi all,
>>
>> sorry all, I won't make it again today for our regular call. If there
>> are topics, please drop a note if someone would still like to hold the call.
> 
> I was about to ask whether somebody has (long term) latency plots
> for i.MX8M mini SoCs.
> 

We do not have one in CI lab, but Philippe has/had one in scope for
Xenomai 4 and may have related numbers from his lab.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
