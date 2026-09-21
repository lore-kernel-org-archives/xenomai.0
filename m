Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F94324B0A
	for <xenomai@lists.linux.dev>; Mon, 21 Sep 2026 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967205; cv=fail; b=aDRJnCVj+9AKunyiNO8Ab1jac3j9vdV/799LdGn/7Xk+kiJdIn7UixcFPQjqzPY8LSXwrDkaHksOZYSu3OhPMahfmTECOg1Kr6VPvKVba21worX+8Zo7VTXBCTU3v+AsS+rCl3MKBihNIGkuPyC1PaP84HRfDVUXWxy3ZmRSRxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967205; c=relaxed/simple;
	bh=aZFkNus43vGgM9+1vg6xuG9oIofwQ1DzlTE2RaCeVr8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fNYqgN97NKSEnbIyXSVh4+O51ziAlagTwTABzxREY4/MutXS47jaTtNqEOycqXQOgJbMi4s85j9y34163R4xIAeqieQ12Es+J/iFFe9Lp1k4Hk7bVIyu4lYQPEp3SG9OFc72ICGXJuWP7HNQUu/3Wy4ZwIQwGx4LiJ12x+HgDRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M3D18iqM; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M3D18iqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY2Rr8p/LvDMoCjQ9VZOYuc0Hw1hxNynMoWAtY5dOnXSU5ghYE6WBwRLdohiXSx7lDFYT7mokeT1+kZUyn5/92lD/jY7wxREe6PLC+ED2IQkFR3t3I+8ImAcnp2ulIH21EFz97wLW9MkA7h5e40my02OSNylADy8tpoGd5EbTcjfmG/L2LfregycXCp/yETbuPHRloJuiWk9uixJtOo3tMYHJAnQClT92XUk6ro92wqAVVQQgkVI/CsNeAuXdjcTIt+fi01SymhT2fBynXTxiEQnEkW1MhtJ5YyDRyuBZKO0rwdYLQjMQVzKEdEmHMcF7D1E+o8KIwxYfVmkvwH84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uDV1PluXUza0uIxCjl14koE1mjc3ffNIa5hm2e1rwY=;
 b=RQJ29ydE19b+V6Q5zZhy+4QGk3rxxi8P6dwbCoaiqzVgSdMCrkH8cnMhr5X7k8Z8Fz9XT8aeVKl/5so5A/gjo38jOqEKU+d5pzQvlTa+Hqn6xr+JRG43yJ5u7tVq01nYv8aFfQbPWwfnm80J7/78JOWOH0vbYKq7j4ldvd+8wvTgwbGpC67pEXVG3QvlR39zNaqqcF2u0Cqe0zgB0iN1GuTiGSMGFcQ+hg0n/iggtiKlLVtw1SOCmgICKSbABiAjC5YGuoQL/uh6BlcieK0I7srMjlf8EUjCAWz6/Qpa2KpdXwM35Izw8VLeoj56a+Z5NqTAUQD212eaNyTDMdQyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uDV1PluXUza0uIxCjl14koE1mjc3ffNIa5hm2e1rwY=;
 b=M3D18iqMdGPaLOq4qMdPvjl/cRXweScaSNmxJufMru9Kf32AgddhTmnFpEuUfNfcOJN2RW0tzPh0K/nrJPNMxD6tGdzbfX4rmGZUGDgDpOlYkLbhPwwOhtVszaziUlC6KD7f0+suSVytdkPQzjv3To8Zitn8c/WJt9iKt82589HP104ix6CCmk5HxySuPgCaqL0C5saWbkM50IFaY+pvAQEVKvoI2tSvSemKvRDkTa9AgY4smqtXW/FFV/HjkBFDfoYxZI4WprBcWqKsCpCiWumLftJZvtNttKCZF3b1idM5iD2uv+VOfrFc6Pp7sPeUVma8LSJwNTOt5oUjRx2plg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Mon, 21 Sep
 2026 05:06:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:06:39 +0000
Message-ID: <d7ea6f96-4855-40db-9980-a8df4a186008@siemens.com>
Date: Mon, 21 Sep 2026 07:06:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RTDM Monotonic clock diverging from userland monotonic clock
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 xenomai@lists.linux.dev
References: <1209-6aad5780-37-5a2d1100@173656648>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1209-6aad5780-37-5a2d1100@173656648>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: aedf3521-ee96-4147-e65b-08df179e1e5a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3xIA9hxeLjdlD5zYNL2DC7BZrccbCuLMUlKwJ1E0nTOQabVVRLU41huoHrCQ/Np/iJkUiYGoBZW3wmYGfD3Y0fQaZTNQHtmj2i2xgjrP5usHhz6ULVsEkA+CB7Ux56SWR6XO0JP2xUO6GYjtgaLbKoTXmgtlKYkJqyV47jnH+WV/ZjHhSTfHr8Q4zBd3GJfJX8WpYUQpV+EtQbdII0ULNn67pwqyac6mHcUv8RR0oo4zDZuSQ2XMv9OjG8Xdq2+myaGObPTu3OUMuidwxyVXTqTxAkywnXzExMymt7F856VVAEvMgDFrDCtC0V7ZBD70a/zSJ9Agae6Pzzajf6Xx9zxftt35F1RQWRCqb27pmvq9mtvLS5ZfprBD0ouougy610LiS8ixdzS1PcEtX80m9F6TlxoZ4iHYpzUW4qsuwx15N1XwoaP9zfC2LQzlxxbWukDZBSGX5XgALgZDMKgMp1+9onyhF1aUJNLJwJHOZTP4nVoBSNsD+uv+DY4OWh3Biq3M5gNzSj+LNQoUPXWF5RusFZtI9eWb8Bh1RFtdpDpr2rZrMHYOROHZxmma8KdmpQxFj2fcq2YANMyUej0wy5vpPmUSvvrld1x0HEdYLKW29N37KgWfeRgfCgO2w8P0HZBuWi6N0ieR1BvUgnODIOWjOfWMuzZWBbY69k3Yajc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRwOGJZQTZqSDRYMytZcEEySk1rZE54cjlhaml5elpHMFN0dGlYVSs0MWlx?=
 =?utf-8?B?STFmUVo4MmRFN0t5R2FBTTVCNUNKS25ROTJLNGZJREZaeldSWXJXNXE3eExk?=
 =?utf-8?B?cTBTSDZiSTRYUFloQUJ4L3l4Mm4rSUxWOCtENjlUQjR3cGxzOUdncE1PZEdO?=
 =?utf-8?B?YTh4aml0aWRaT3lVQU94WFRjL3BmMVpmWmxGd2YxVExCN3l4WWplTHRqV0ky?=
 =?utf-8?B?aGZvN3Vha3ZFT2wreE5RMiswdHJyQzdlK1RNSTZZcmFkam5ZSnRBTWZRVnox?=
 =?utf-8?B?Nm5yNExIaGpTYU9KY1UwTEoyRTRyWmhvR2FMUzJWQ0JTV3V1eXZsckVQUzAy?=
 =?utf-8?B?NDFiMTdJNGFGc211Y0NnRitBQUU4UkJIc3c4NUZYdFdsc29PR2hiMHlOaFFk?=
 =?utf-8?B?YzYwRlBuYXFkQ25zeVhkdUh6YUZ1R05iM0VENmRUV1RtMHM1VDN1MWpsenNx?=
 =?utf-8?B?YTZyK2lxTm8wQnlCb2kyeXlHM0JvRENDcEdUY1M4YmhKeEo2VEh6cng2eTVw?=
 =?utf-8?B?Z2E1enpjZ1JnV0NmR3M5QzB1ZVQyMkc5SDFUWmxET2MzT0RZcCtzdUEva2Rv?=
 =?utf-8?B?SWRhc3JDNCthcWM2R1l0QTh1MUxTQ3lqc0ZZSWFBQ2RteGNtaFNZTTNwNkxn?=
 =?utf-8?B?eWl1N04vZTlxU1BDVHZKbVpyZFZDYlNtM0FnSGk0b20rbk95YjdMajhDODRW?=
 =?utf-8?B?UE5McjhSWjJNaUZnNTA1QUpHMnNhbWtLMytIZC93MmlkdlNRRnMzS3BsZG80?=
 =?utf-8?B?WHhYMWNkWDVxU1JMSmxySGlEOFE4dTFIRVpiajRONGozNW45c3dTZlhFeDZh?=
 =?utf-8?B?Z1JKa3hSNFB5OFpaUEFXV2t6dXlwejRpazVrbjlBR3k4SSt1QytjREUrbDBn?=
 =?utf-8?B?S0F2dWxBWTk5U1VvcmxSQXNlMEVUWWx0MFYrYWFRQU1QVC9EMDc5WlRoOUdJ?=
 =?utf-8?B?a21SOURtTnNkRVE5Y2xkRzc3eXp5ZWNCVEhuM0U1Y1dzU0xHb3RTWDhxcWRm?=
 =?utf-8?B?c2poQjFxUVlxSzU2QnMzRjI4U0NNRk5CaWY0Y21NWjNuY0FMQXR6YzJxM0dy?=
 =?utf-8?B?MjN6amlPV1diWHVBbWVvS251QnYwTjV0T1hlbHlTaUF5RktTZHZ4dUVBVldB?=
 =?utf-8?B?VVdySDRzZExUSEREejd6elpHLzdISlJJeGhxRmFBVXI0WWVrY3Z5TVFDL3BR?=
 =?utf-8?B?U2RiTXhqYnBocGw5MHU2SjNCdDVJdE5GelgydUhVdTRxUHVRb2tFc2kwc3JW?=
 =?utf-8?B?UEpBUU9naEhYemNuaWFLVHZ0Ny9sTllRYXpMS0FkM2xzM1dsOExROG1sekRM?=
 =?utf-8?B?SHNidkVjcGpWTldOUmpHRnNsOFIxUkU3RTZRMHBRcFdpeDNQdlVhQkxDN0ZK?=
 =?utf-8?B?UEUza1k0YThYdHFMck9jbm5oU0JiSUsrd0s5YU1BZnlvQUN1M043V1dMZzJi?=
 =?utf-8?B?OWFZcXVDQjgzRWlkcE9SUmV5d2J2STcvZVdTRzFPTTMyS1BJZ1lXMVptbi80?=
 =?utf-8?B?NkUxVnFyZ25PUVVKeDBpUzhMeEMxUHFKR3doMVErZHVkNGV1N0QzN1F2VzFH?=
 =?utf-8?B?V3JlK0NHamlCL2R5TkxOejM5WG5QN0tIcFF0ZkFScHkrdHI4Nzk0QVN4MVB0?=
 =?utf-8?B?UE9oNE5HZDRjMys5NXd5L3FOUE95VDYyc2lETnRIUVFlUUxwa0J3ZWpHMG9m?=
 =?utf-8?B?cUdVbUMxNXU4Yjh3blBqbmJEY3VoNXpBNHU1aXNmQ05ZZHBadTh2STVtT1VJ?=
 =?utf-8?B?ejNGczN4d3VDeW93c0pWNEJaRVQwcGRmYmxXQVpUK1pHdUYwMmtBcGtERTda?=
 =?utf-8?B?L3RPcHYxeHlRVm9NY0NaVXE2N2FvYWUzbnpmUmxGKzlRQmQxaU5seGJwSjVs?=
 =?utf-8?B?S3ZPT3RhYStzTE4ySnNpNGwyeTd0U3EveUpRTThmOTI0SDFERUJvM1FXWEZJ?=
 =?utf-8?B?Z3dYVnc4S3dZSi9ES2lKdnU3bC9wL010eENMbUNuNTJHZ1d4NFJJMW5KNktC?=
 =?utf-8?B?Wk1ld3IzcFJCdVNVOE50V3dKK1YrblcvT1QxQTJ4RE1yNk13N0NudEpJaWk5?=
 =?utf-8?B?WjVKTVNTbWlxdmM5emRCbk1rbi9MbTd3OFF3eFpiVzJHNHhLNWsxcFlFWFFI?=
 =?utf-8?B?SDhFeHljMndHNkl6OFU2QkwwbUYybEI2UFV0eGFJWmk4Vnl4SDZjMEpPRVZV?=
 =?utf-8?B?eGx4NUZOUkFld0JpdlE0SWxJQWtLTnhTWHRCS1FKUzIyRjByOEIzYUlxVWMy?=
 =?utf-8?B?S1FJTnU0Vi9KeDN6b2dWVnNYZEM4K2loeTEybVZUckZVQlBrSDJaZGh2NDA4?=
 =?utf-8?B?ZWQ5ckRDUFpiemg1RzJKaER4b0o3T3d1NjlHLzJyT05zd0YxdG5jQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedf3521-ee96-4147-e65b-08df179e1e5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:06:39.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO+w4Clmzk9hnrq3kHNcdCVzO/728bMdlIRgvNa0tU/1q+yoI7I/xZeyhAVjhGCW4RckAFCzpszqZNuqrtZP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5730

On 18.09.26 17:23, François Legal wrote:
> Hello,
> 
> working on a xenomai 3.2 + linux 5.4 platform using network packets timestamping in kernel, I need to compare the network packets timestamp (retrieved with rtdm_clock_read_monotonic()) to userland monotonic clock (clock_gettime(CLOCK_MONOTONIC, & time).

Kernel 5.4 was retired last year.

> 
> This seem to work fine when no network time synchronisation is used, but whenever I start a PTP time sync daemon on the platform, the time from kernel and from userland start to diverge quickly.
> 
> I'm surprised because clock monotonic should not be modified by time synchronisation scheme.
> 
> Can anybody help me ?
> 

This legacy issue is related to I-pipe-based Xenomai using a separate,
unsynchronized source for its clocks. That is already affecting the
offset of CLOCK_REALTIME (therefore CLOCK_HOST_REALTIME existed), but it
is also impacting CLOCK_MONOTONIC when the Linux kernel starts to tune
the frequency factor (e.g. due to PTP sync).

Upgrade to a Dovetail kernel, and that issue is resolved (plus you have
security updates again).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
