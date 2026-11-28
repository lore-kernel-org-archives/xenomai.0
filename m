Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795872872;
	b=AeZqs3XaBR+iRRqJWnrbNBnjHPafeByRbHq7XFjVdpGs6+g3pPd83Ws86jbP8dzx1Pus
	 vpcDwkRcX8h+nxfReMeVSNekLBEz134OVS1s0EV3gTpcR9RpEKu+CFMnvGA+TCetynxVr
	 DUbT6Md91S74TU5VpETtK7ZUGqncEJpffEpPFUKA+sC31S+yBzJ9NxcudE0h4HlhL3K92
	 dJU9Ed85tNdhF/9mrZf8R7qdSDsIaSjeVU/vpsqYNkPiv/gGwxNnnJVetcFbiyOH6QwjV
	 5VhyEcrXohpmyE8Oi1lRnJheY5U0DfRkgcBjPqsqUU0PDk22Hh4uC25LpCGN/3gAR6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872872;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:From:To:Cc:Subject:Autocrypt:Content-Type:
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
	bh=ir1XhUDSd1gNB7nzMykNrv8RrQbwAud8obQqFUH7aeU=;
	b=et5tn9kCTZtQLewcIyjwtaTSD0SrhNulN0yUQOscKuppfxpw/TGfN8d2ZRGW+qkjtBbY
	 4/ndIC57oRIM7PHtuicDPs+LLlDM+RiCAJLnTQ27bY0IRtIIqr4LzjKcuQZfA2WAr2GPA
	 XDzO9aDVVvAwy7x5S5fm5KEzHyKJnOg/AzLQ067ARIXo298a8GwAByjcNcfHslV4KV0ke
	 XpLIrcSSkIead6qjfPwy9iPT6IqFkdiLCr5EztcavkBbaq6imSfbYzXHcaAXke5VAfLxO
	 CcGWwxw5vsrVXxaedL0NepAu4NRKOw8Se54dm16hXZuwXRr0pTZJWamo9zVKuMLVS3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=STgtfJ2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF4606A31C
	for <xenomai@lists.linux.dev>; Sat, 28 Nov 2026 13:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4AF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=STgtfJ2n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtkDGtW0HwgtfO0nRifne72kA3nvfHtyUW4kyjdziRVOetLjtokWgUvgtOoIK5+TvDHS3d27lXct9uPeYKlYN/exjXVR1qCmySlh5TK/YQ8HUn9rdcx4Hbhv7eR5p6IEwdiL+lTRV7vSGl1WzKmNcFSdFLciUpPkX8bpFWhOPCZh24NGt6XcaA8O32teymfb3EDF8OIyWtum//IOMhxP6CJy+Rg/XBykz9QcRnE0KHaZYAbiSLt1EEOWvd8DNrE/qPV8jw9SvB/seFfU8EE9rTOFEwVLlwHekdr0zbvAZIRgNPBePL365EyNEDlqZS9OGEL/S2lzDaTdSFxq0q99Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir1XhUDSd1gNB7nzMykNrv8RrQbwAud8obQqFUH7aeU=;
 b=Uqejso/qTrlun1NPpUMYM0ZhjfcpQ8AjXpjyw166e0s9Y/YSn6YgxtB9Czk4NTGmfcBnpxFlYv5FrrRQHIXviGl0tqOcFa6Dfig8VWMx7gsvxTnZy3qvWjr53KUzom4Uoyze73QCzpyuH9B2/oUlF0oTqQXqEcn/a+1XJblTRLcatHyHKcTi17tKn7AmsWkegzsTKNo7rSN3IbwNOFbsb5LiB0qgT1hBCe8kl6MrFAd3/WwUVDALMbl9UpPk630Mny+ln4inGfDAblxOUxU/MSBmHiFvK0EsCZrLsn5x8WcEP7IxScZT1NtFmj7AF9Bxa55d6T177cTBKudORouUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir1XhUDSd1gNB7nzMykNrv8RrQbwAud8obQqFUH7aeU=;
 b=STgtfJ2ncHnCDbdxB31oV6HnGcJI1g8HoWX5H6U7eXQYHlg1PDCUK6DBW4hK7Riz+winp1XHUVoocAinaAKKx0ti9+AxSo+EcOgKwYMWMbYm2Yq8xrhUkUl3rzZx1xCGjxEBgN5NOfwwGc5NZnEeLRo1PAAYhio0MLkW3RLQH1OOupveQoWUVZ1NnqEdIrdrgYevNwr1EbHkf1+N9Dhc+GHYhbFamJ5Yzbb3K/8Nal8AUiRW3rCjC5NK80EJE+baVbZuhR8zRtWypJv3H46rhQo7PpiMlYoZKjc+gkR+ur3OmaeI4B3jyEEUK5yBteLYeNPboXN9vRCsQhgW/FGNew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB6774.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Sat, 28 Nov
 2026 13:34:28 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Sat, 28 Nov 2026
 13:34:28 +0000
Message-ID: <d6bfdfdd-01b1-41cb-acf8-d0d641e94c7c@siemens.com>
Date: Sat, 28 Nov 2026 14:34:27 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: RISC-V CI regressions
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f048e6-c4c2-4200-dc60-08df4d5453a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|6133799003|261009223027099003|55112099003|18002099003|260925022911599003|260925021311599003|260925021911599003|56012099006|10067099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022115727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	KLVqJ+Dd00ZoJIc23H9ZI2eSHUn0xZXb4djgYJDRrpmTFrfZ8PQDuJsw7FMpO7OvBwthOC9Wr+EJ6w+KPmJcgnH2ZnyB/833FBpqLimk2HtpwgkAVNeH8DpgYsMHXItjY2WRVYyrGSzl6DjC6y2uWLjWjYTdgoNqdnHt5lqBQ80/mjo5F7WNtLkxScjKG+CJh+vyzHWvR6wvLvj1F0lc2W5wVVVNiZqi3IhIFVfxVyBEnLw5We6WcSmvqF3GVdtplGWKrHfWSyfInzrcvyGCgydaOCgUZU+vZyX5PGUU8sGHl7lw6zf37LeqLusRoSSYrIoPCHmFo402Z1yiSXOD8zAblZhlT+kFgkQTaS4DnGxg5Aaxb8m/7UyrdbT4i60tvY6Q68BBOtKhpSl6t8jq+arXpyoy94CgBl3gavg48ZO6R+pnkOK4Z76H6VTK5RIu5gpO5Haxy6M9wi6I48/do7cQY9s0sh3NkjN2W5rD9r1W0eNtm84QOfMfBSeXfCwwZuit56bpbtnzHqi1U3MtUgl0aATWhGz6jF1jz0u2TcdVRLC3ihsvfZe/dZFGEOaruNaYxKeBCDoJ1mwYNxUqmYDOhZV3ISxXNVhI69HCwGdu4deEmps3J8w/CJ15LvxSBej3ALgEZJmSvzMn6FBCZeRUVJbBisCnp1Gbx4a9x1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(6133799003)(261009223027099003)(55112099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(10067099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022115727099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZSd3VxT3pkQi9qcks5d3BLOTZ5aHlkT3dZRVo1QUVOT0pHaXdQNHk3cFIr?=
 =?utf-8?B?MzV3TmNPQU90MjBONmc5SWJOT3NDUWdmNFhuWDYvZ0VVcXBLNjc3TWhyZWcx?=
 =?utf-8?B?VnZaVmlxaHhid29CRWtJeER5MlhLeTMxZFlZVTg4M3pQdjd6ODFlUXh3Umtw?=
 =?utf-8?B?aUllSGNJTVFRK1NuL1NxcmoyUm5XRVdVLzV1cnUwRHVZNWpVUFRUTmlYV0R3?=
 =?utf-8?B?ZUhwSDZsYXl5NXJkYkdmSFIrRUhRV2NzNXU1Z0lkNjNrbDA3S2ZIVUM0R25F?=
 =?utf-8?B?dHE0QnVFaGMwYzF0SEVsUUhPVU9FSmorQkJHTk1ab0phdHlFMy9NNE5MY2ZC?=
 =?utf-8?B?ZThub1E2M2lNQUU3SjVmOEJWWGtIZTZvVEZicHpsVjh4N2tuMEkvdzJxeFVI?=
 =?utf-8?B?R21BcG1TWWdkK25EaXBUNVgxaWd1VTBOSWdrRVRqYWxmZlhoQkFtc2lJc3VX?=
 =?utf-8?B?ZjQrSnV4QTBqSytMblZia211SFUvMlgyTmloTlBPQnFJd2JRVHZRN1NLb0lD?=
 =?utf-8?B?MVBCTDVqSUQyQVN2bDYyN0R5RFlKMDZ1dWpwYWtiNzVZYm9ldlNOMkxDSHht?=
 =?utf-8?B?YWlMdHZRaDdPOWdaaXprSmZXRXNScWhsYnVZZTBMaGJTaTBWU2M4ZHc4aHZ4?=
 =?utf-8?B?bkh0SmR0MnpPaytzVFVROEtvVEZNQWhGSzBrQ212cVB2Z3o5ZzlrSHpEUTd0?=
 =?utf-8?B?ek9ualp6S0E4TWYrb2JITWwxZHpMdURqck0xbG9UbDZwdTk4d3l3NGNNazZX?=
 =?utf-8?B?Uzh2VldzbDhwR2xUeGQvV3ZMakRHcDlxRFVZOEJNdXVEYklLNFQ4Y2J5Z09W?=
 =?utf-8?B?VmhxMUJsS2dyNkoxTXhyUnRpbmIrOHJjbTdLRmthMUgzREJwUHZUQWdOUGR0?=
 =?utf-8?B?U2Jick5UUmpJUXUwUmI2ckNXNmIyWllqK3hldjYrOGsvbURMaFBOUjdyQXVK?=
 =?utf-8?B?T0pNUkV3TDlYWXE4T1lnWGpCQjc3eS9OQU9VRnY2a1hoWHkrUUVvSjJRVFBR?=
 =?utf-8?B?eU5rL0NpdnB2bVIzSG1ZcjErSXFpTVAyK0tnWDZLUHd4YmJIbnFGRk41anpF?=
 =?utf-8?B?YXhEbHBJclphc3lJbjBST3hjTHliMFZHSU1vb3Q3Szg4VUxJTGdoaEV3MmQ2?=
 =?utf-8?B?QmgyTmlnOEVFN2lROTZTL2RuUjFVRFdVY09KY1hmS2Y2MFZuSXFZT29nRHA4?=
 =?utf-8?B?NjllVngvVlFRdVJXNmM1OXlhNkdaNnNOVFFaTFBmYmhEdEtONlpsTVQ2Vmxx?=
 =?utf-8?B?eXdxN0h3a3E3V0Y2N01OT0lmVEJNN0xNMUNZRi9VVC9aMWN5T3kyc04rK3NF?=
 =?utf-8?B?SXFwMzVIck5PTUdrekdyRmlQNWJDc2srVVpDVDFmd1YrQU8zSGR5WDR5OGpQ?=
 =?utf-8?B?MHRuZC9yVVVYM0tsNjkxZ3FxbHJOVkE4MzFxa0ZjNDJqOTNQeEdNalFOMGgr?=
 =?utf-8?B?alQyUEkyOWZmeU9CeFdweHMvNm9rOHVjbzVENjJBc2RZdlFaMTN4djdDN2RC?=
 =?utf-8?B?SnhkVzhsazNnMk9uL3A3KzVFOGE5NWZuRWdZcG1ncm94NVVYOHd0SDAvQlNr?=
 =?utf-8?B?WHJ2SU4zcWo0UGFJbW1nMlN2cEpNclY3elYxcFR2SHpxVTdoRkhBOEV0TXlm?=
 =?utf-8?B?cWhHc2FHWEkvVkd3UUpkU0pNd0JVcVdVREphRkFXT1RudE1zRXZyUmliYTFq?=
 =?utf-8?B?TFdyOEF5Y29XcHd6TGt1a1BrdDl5ck5NdE1TUmM0WXcrU0Jxcy9zSjJyMlo3?=
 =?utf-8?B?MkZGU1pNdmZhYWZHMy92YjlacW1ScUY0cElsT3NPMEpCRG5NQXFxdStGQWFR?=
 =?utf-8?B?c0YxblFjZVpjenR4VDNpTDB3S0htRHRnZTJhRjRFaFRzYm9mWXRENEt0Vmhm?=
 =?utf-8?B?ZlltWFY1a1VWa3dpUjlEZG1USWlzL2JvYW9peHBzNm9rNHI1bkZjbThBZDBy?=
 =?utf-8?B?dVhlbnVHRlpYT1Byakl5d2tQVVh2ZVJGY2pMcGNMc1NocHhMSHkyK3laUGpP?=
 =?utf-8?B?TkowMmQxOWQ0SHNtNUlZNUx1UGJBRmNFcWpjaGtoUXNzZ2g2YU1RVEtLR2g4?=
 =?utf-8?B?ek1VTStWeGlyZ3EwRGVYQW9OR0xTQk1jaUdzUFhpOU1NR1BZcmtSL0dYWWRz?=
 =?utf-8?B?QUdYNlVUUjFUTi8zVXZpTEFZT2k3RklLSklpaG05UHV4eTlCNUNSbW9KZmli?=
 =?utf-8?B?dGd0d0Rxc3ExQ0tsRXV3ODhTWUdDTUxOeTMzQ0o1U01VR09oS2VZYURtb0t3?=
 =?utf-8?B?VjRGR1p5aFBrS2x1S1R2ZlBwZlNhQlV0OTJkNVltNHJEWGdvSlFnczlUVURV?=
 =?utf-8?B?UGJWdTdvWEdNS0oremZJOGdveXBFczd3VmJHMGpUMnNiUGt3Rm5SZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f048e6-c4c2-4200-dc60-08df4d5453a6
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 13:34:28.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB/71rtGoipjuZ8JpyXr8hZCQslDkdVDmDHUJwZRs/ydpDsOknshcuDupJJu+n3yvDw54f9Y6RtMww4I1g1ljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6774

Hi Tobias,

could you have a look at CI regarding RISC-V on Xenomai 4?

https://gitlab.com/Xenomai/xenomai-images/-/jobs/18450211216
-> stuck testsuite on starfive

https://gitlab.com/Xenomai/xenomai-images/-/jobs/18450211215
-> missing qemu-system-riscv64 - please fix on both QEMU targets so that
   we can drop that tag

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

