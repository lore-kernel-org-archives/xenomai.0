Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935433;
	b=FS5JhmyY97K2vtS6Dw0pqRu/k6s17YGeD3Fh8iztK3bfjbBrurZ2RAN0KYQAelZPgs/1
	 k2dBCux/GQ0nOZvsTS4DvchnYjghWY4n71wKHheWe8/7d0v51v6wFypt7g3XROLlyfUWx
	 UeybcpmIRY/LnqS8W2jFGmB1VNo1RlOGKVuhrYp8EOEskPtbynwL0rJfQSTd3jesL5Jjl
	 whfTHd7TQ57oix9Z/6/FjkXnrzi+a+bqdW5P00C+AQeq0qzaM3JHVU7jeWuG11wWK8TQZ
	 MWDENgJw0XjrYSBVWJ35LsYIaq2srwTTb+dQQZJzJK9FoVOI13DDDuQWojQujpHudhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935433;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
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
	bh=bIp91OpZIGG9D2dOOKPo0ltINXyAMDxCLliFsPtfKEM=;
	b=w8kGjr+H8/vxH48OZ0quOTyBcB7y2Mm0X0pKXM6Z4QdMBbx8FzpcoxbrZ4siDS0zzXuN
	 oAKf/VfBl29aHkGODmVSALvJaOnZZkRY4kuo/zrveGQvIfV7QMNaA6U6EOctJ8Q9xiby5
	 uXiCOPXIq1ZzsmXVr7HUvVFOUSjDDRQF6Gs5gdarRVnEVGYit01SG+YiSj2OROqqpWOon
	 FgL58Pr2LKBA0nXE9DDj+5GafLYNtxwjEdvDhOQmcWCK9rC80c+WO/d4SQ4C/PcV5OyPw
	 bzX33FolX4j5eFWZvGMDZKNrGZPuZtf8uhyHSsMamCP+elNzdz8z0bCodc+sLo7Xr9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="Z5/MSy2a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75761606A338
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 17:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75761606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Z5/MSy2a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3SNRNOqu/yUkOTAVbWm0etpTItBMiSwKgfaEFwyyD8SwHwjd1X8cTdBvtI50cKDjqmj9Cs6LVawdqOtlzaUm7xq4v15zv+nSAZ0POTGSg1KeiS0Wp3baMd0tVr/RtaXUXzfXiI64KK46Nn65eN0VqCezYUmCr/B+LRcEncfqNSZQspj5kCrPY9yhZ+rNe7EP9cgx9rOOLAWCgJqzrSxbV6NSXXIv/Bg9ug9pemC0tSso+qx6TOOZoX9Z1PXjc7Rl+ldi605SlEN/mtuiws7ni3sMtqecUCwmAhYebAVKkv3SDEi8om0BB8AHFbfgWilUTz2aW5X2d/1zyEz4lxQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIp91OpZIGG9D2dOOKPo0ltINXyAMDxCLliFsPtfKEM=;
 b=zEkGncIY0xJe+BPI9h0UcSZr/jwvyjJnyiM8DCXZje+qyILzWrHTADZwa0G3yJUPUo52DOQSL9sbt49i3IbcAFrxqQBXHCbH3qhFdXVXl8h3OsfnHWDDUNsYOZVgmCG8dt/1CrI1rJHNkiENf7onoVCI39YeYGPAb7KDsBAgWJlxy8+HTREHwJuWI4Oj0OwiFFhnai+ZUVO2p+W+aqYpPa+/l8Qb1gW+gJshxP/4hYpiHl43tk9kG41jDc9XAv0KaZlbaPlikoVbGmKZv9WEfW8LjBQc0KvesaZNJC1VJUPtdvMe+e2qaWlVNDbmCdpPZ9bPBwZnynk3wIqhEfUxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIp91OpZIGG9D2dOOKPo0ltINXyAMDxCLliFsPtfKEM=;
 b=Z5/MSy2avNm2Mfip/Z4NVoLOm8YbPV8vmdPkO7eX+57Nkr+26XAOSZTIv38nmev009T3J80FBVmNWOblxHQEQudZSJ7m0RB0F+MlGfV/3Buzs0v6Hql2STtln5N16ONIrfsN87grZsSgXrW+pb28Q4czkr8y/SBrQ/hhqELCawJwDUQ8IGTvZIQUESZtUYNpH+ihJySBj3sGIMMeeFLYsjTFbLUfgNnJxeVorEFFjxUuLLn0+vK163aeKXo3qJuTy//WD2EPbhW51Fs1ub1+7mMMPA12L672BQNIsVDs1A3zAO96OqtL0Yd69P6lPsftuT6TS4jH37TQ1MWajY2qEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS4PR10MB5872.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:517::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 17:10:29 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 17:10:29 +0000
Message-ID: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com>
Date: Tue, 17 Nov 2026 18:10:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] x86: dovetail: preserve in-band stall state across
 handle_bug()
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:408:e6::24) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS4PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: dc79c6d6-ff8e-429e-e8a6-08df44cdae37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|260925021311599003|260925021911599003|260925022911599003|10067099003|11063799006|5023799004|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261028144727099003|261022115727099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DKU04rnf6YqudqzRTKWCKNkw82eLWTSFVJxPy4reKWXF60FMZUpe5RvS6hcXZv2WvFLFNV5yArY20yS8hda811mWCV/bIcU6uFV+CoqO11ZyM9uMPdoWpR/sEgk5PipPJ5l6TRoakYP+bE7eZ0fjhKoc5lwFl8vtAt6DfDGEbRMxjhZdaRpfZKTCb2cS+hN1t21jqIIlzUaviA8i4YTqYDGUxXR61TjAkVcNF9gIDJwUOO9p+j5emX9qTH0OiWcQr9rT/NN4mSRLjvgiqvNa3mWIiYoZi25J1WPI5p8sWEw4zB6RTsdM2tkT88u8KTnoEPgDs+VcFIy5G+zx/aU44nfZ9cWOBH2RRMmiNtaHdIAizm06RPfXZLgf0mXmwGtXKZKNodGCj3sBVGqqiW19pSxIchNVk0rJ+xBoPYLs17/pixoLLiMU4lrMjtqIFD3rqXwdCpTO80UfvA85KZ2E0SrEOZ70QYDRN87W7uXIuWTOzpX0L5NDzlX4j0URWS7PVfq2YMCwGBAvGNlv5mQ3Yid8HQC9js/sAg+KYZ5FCFGZPfpLUMtAakvsDOvqWTdbCImymdHTL/VczSkueCh/vSp6d0PuSRBgYA1XFBgijn6je6SA0IhIFbd5a7HagsuBY665l3Z52cMo+Ns6b33I5C8b/1EJL5Si26BWX0eJTFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022115727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZtM21WRlZyTzRqUC9Cejl4U3NUZSswZzI0bTQ4MWMxbnhNZTlNUDI4eWNM?=
 =?utf-8?B?RWQyMHo3a0YvNDVVTWh4SWdMcWxxWElOdzd4aFNoL2dzeFZJNTg5b09yaTVm?=
 =?utf-8?B?SjdQdE84OG9zY25wV0ZnaG5DZmNZNlZBZE9UZUJ0bXlodk9xMHA1SUxFUnBD?=
 =?utf-8?B?UDk3YlF6Q0dnWjNLbTcwa2FodUZSS0xlOXRSY25WYUpyU2U0dE8rQzhmZEJh?=
 =?utf-8?B?RmxNajdoTVJwS2Q3RjlOamQ0MFVTQU40UHdTQUYvcStoVUhpYWJ4M2RFRXl3?=
 =?utf-8?B?OS92bzVGNTR0SmNncUhJN2lHYTZCZ3FKOGVQQTNKcGZYSllKMktGODU3bWE4?=
 =?utf-8?B?ekpzQ3NUYysyL0pXTUpSSVZpT1BjaHBNSVpOaFA3WmtXdlZ2d2dGN3NONDky?=
 =?utf-8?B?TVo0ZUVhbEF6L0FWeStaRWI0eDdRRjZVbUNQS0tvQ2FqUWlCM0hLR0h1dUFQ?=
 =?utf-8?B?ay9qN21GS3lKMTVjK29hWmxwZ1lPdE9MQ3doUHlaeXdMQ1llbFBINHpINUMw?=
 =?utf-8?B?OHU4N09wR0FBbm1RbzEzRmhFS3pPL1ZOTW5pTEx3Qk1ZSGpWRXcvZ0ozNDMv?=
 =?utf-8?B?MlhPMGhYbDh2QUw4UnR3K280OEVtS1h6eExYTnZNZTZqdHpPaU5mQUNSMEsx?=
 =?utf-8?B?dnJGajBGY25KNnBhT3Eya0paR2pvQ1gvRnBiYkxiYUJKek9PZE1VdjAzUmJp?=
 =?utf-8?B?UEFqRDlFWFVSYVhlNXdlWnl3cTFYY1RXYUoyL1RJTGVudlAvQWVxSU84ZzlQ?=
 =?utf-8?B?VDBTTXZNalZxa05INEZHZ3FjRzEwRTZoUVkzZVFwRTBQTUZtQzljZU4xcUpW?=
 =?utf-8?B?S01jY2RCL2dra1lyZ0dPYXpJdHoxUm1DRkJTbTdXZFZPOXE1SG1oa2U1WU1z?=
 =?utf-8?B?ME9NQ2FoZEVHWXRxZTkzRTViUlRZelJDVWppQXdMekh5T1dwVGZiL3dsOHI1?=
 =?utf-8?B?Rm05anNpcVMxNlZzc1ZrWi9hNjFrYm0zdHRydEVPbUM3ajRLVWplL2xiMXJv?=
 =?utf-8?B?aFUwdkJTQUl2d2Q4RmRpbnF0SVdVYi9JT08xNWlVQlBpVVN3dGZabmNkZ0Nt?=
 =?utf-8?B?ZEZNTVlJTFlqYkFkN3VueGl5V3RXcExURWZNN0pwS21RZExuN0JiSmZML0JO?=
 =?utf-8?B?MnloWi9YMWR5MGtuRi8yY2MyQnBQY0pKdUJFY2R1K3Jib3YyUHBvb2dZRFhS?=
 =?utf-8?B?MU9QK2k4WkVGNnhkWVZmdWdjWEJPaHlPQWp6UzBOalJUMkNOL2lmV2F4Z1c4?=
 =?utf-8?B?RjNITi9TVUxNeEpjanZmajl3aU1RMlcwS0VuVEFNcFpGVmJtMXRjZ3lQY0VK?=
 =?utf-8?B?dmNsNDF5VW1UanRWRVFNbmd4cWhYeFFaRFBvelhUU0NwZThRM2VrNVBaczYz?=
 =?utf-8?B?TFBkaUFXdGc0MG82cVdramNHZWM1RVc3OHp3NitkQ2VlUjdjQk5KSnUzeHpG?=
 =?utf-8?B?ZEwxRE95WHNvanFtYzlnWkFmYlpqMGtzWEpGYVlZc0ptNDNrS3FJYWp4SWlZ?=
 =?utf-8?B?WDNGeDdFd3VVVkZQaStnU2xKak9XaEVZTDhpbDN5VUNQcElSekR1aVBkaThH?=
 =?utf-8?B?ekI2YVZVYitTQVlBVm9QMDlHaEZzUUU3cVNsNyt4QlVmMzdnNkhjSkk2b1Rj?=
 =?utf-8?B?UU53djdsbWRCY0V2cHh5c2labXBSUndqZGtrNXJOS1FEbE1MalJBUytlWHRX?=
 =?utf-8?B?OG5CeGVxcVU5U1dGWXArZjh3WnhtSVlkcjVsYlRmcmZUV3BvcXJ4dGJaTHU0?=
 =?utf-8?B?NnE0UXVFeXFiNlVJTm16aWRFOEVkRTdjb0djblg4aVBxZTZMa0JOZlFNTmpp?=
 =?utf-8?B?VGJ4U0lIdk9mSTVtMEloNGpCNit0dzBmMnFRbmZUY1RKbjBDaVQ2RVpSVERU?=
 =?utf-8?B?SlQ4bVliSUNuNFdkN0pmaVRCNlRPb08zbVkwV2FhYTAyaUdvRWg0NUt3OFhH?=
 =?utf-8?B?SStldGE1OEVYM2VvcytPcFNsTlFub29Db29UYlB6eG84UnhzT2F3Y3owbWFB?=
 =?utf-8?B?alNTUmlqRGRTSkdzYldRQVRRYm5tTWQ5Q3RIMTdwVHdkdGtZRHNHRE91Rm1l?=
 =?utf-8?B?SklqSnhUc2FHSTJEYUNsTXRJMytRcE50d21NVitKVGxKQnhGdnl5Z0lwbDZW?=
 =?utf-8?B?Q1BQQklHRnFqY29YczVxREp2QTdSOE9HZjZBTFhBWnVlQ3E4blRnajdtMnVG?=
 =?utf-8?B?WVFoRzNKZ1FtVW1RRm41QnhEVzVQeExVYzhSSUM0S21RZUVic3Y1TmRsYm5E?=
 =?utf-8?B?Vk1PRWpRcXhHOHNlSHU4QWYrTUxrTmpnVW1VZW1PSXZnYkd2QnFnc2FSZisy?=
 =?utf-8?B?ZFI1dklQcVhUN244TVFKejdEa2ZQWFFqdWtqT1U3WTJQVEsvQmpCUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc79c6d6-ff8e-429e-e8a6-08df44cdae37
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:10:29.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiBWSWWIwt+Jmb5PNg+h+KuyRFkEHIRVXorCquMcO3PJtEHlRZJVYv4J62xdhrsh6couTFYJdqm5hRzBKMOuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5872

From: Jan Kiszka <jan.kiszka@siemens.com>

handle_bug() runs from the raw #UD entry, before irqentry_enter(), and
returns straight to the exception site when a WARN() was handled. The
trap only cleared the hardware interrupt flag, the in-band stall bit
still reflects the state of the exception site.

When the site ran with hard irqs on, handle_bug() used
local_irq_enable_full() and local_irq_disable_full() for the in-band
stage, which also unstall then stall the in-band stage. As a result:

- a WARN() hit with in-band interrupts enabled returned with the
  in-band stage stalled, leaking a virtually disabled interrupt state
  into the interrupted code, until the next in-band irq enable.
- a WARN() hit with in-band interrupts disabled (e.g. under
  spin_lock_irqsave()) unstalled the in-band stage while reporting.

Only restore the hard interrupt state, like upstream does with the
(then non-virtualized) interrupt flag, on both stages.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Taken from the root-cause analysis of
https://gitlab.com/Xenomai/xenomai-images/-/jobs/18096537042, forward-
ported to 7.3. I asked the LLM why inband stalling was added, but it 
found "no reason". I asked if something in between the inband unstall 
and restall could expect finding inband unstalled, and it found nothing. 
Should be safe (TM).

 arch/x86/kernel/traps.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 26a30aa31960d..afc73bcaa285b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -476,12 +476,8 @@ noinstr bool handle_bug(struct pt_regs *regs)
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
 	 */
-	if (regs->flags & X86_EFLAGS_IF) {
-		if (running_oob())
-			hard_local_irq_enable();
-		else
-			local_irq_enable_full();
-	}
+	if (regs->flags & X86_EFLAGS_IF)
+		hard_local_irq_enable();
 
 	switch (ud_type) {
 	case BUG_UD1_WARN:
@@ -528,12 +524,8 @@ noinstr bool handle_bug(struct pt_regs *regs)
 		regs->ip = addr;
 	}
 
-	if (regs->flags & X86_EFLAGS_IF) {
-		if (running_oob())
-			hard_local_irq_disable();
-		else
-			local_irq_disable_full();
-	}
+	if (regs->flags & X86_EFLAGS_IF)
+		hard_local_irq_disable();
 	instrumentation_end();
 
 	return handled;
-- 
2.47.3
