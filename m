Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4563C1F
	for <xenomai@lists.linux.dev>; Wed,  6 Aug 2025 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754453239; cv=fail; b=I1sKL4xoVapl7oBSAETElfDWsMZ5t41S5JHvfZTIFNkv7FN4Kr99Nq1kGN2RqDe4cm3FdKH+Q6jSWEnpIwTxDpQ5lBRq+Rp74zwlMTh8iO5bM0Gy1X55alDteS/WAzj6XEdwRvVVETHCT82UKbuhj9Ng/+HppzC+qBPUtDY1MhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754453239; c=relaxed/simple;
	bh=Jan+bIsAE3nHEzGCdiA7LcdyHGoQ+0o2Ok/N9e7PWlY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oZnFcvkTXdpAp/bZt6P/Lrxu0M0aY1t4FjeFtWwrR3702GEQEV5OKggGa5r6XQlFsKqRZVXpCYw/tq96utEcibv8Nz7Mi5Z0UIn9zEnhBGx2Mbs3wsjjlQ8+QVLHh3SGfC4ljFyJM92feZ9kJnwbj+LOyHgOYSknKzSU1BrLu0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dsXRomg1; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dsXRomg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMIT/q1Nkpz7IDWkTAHvQwpLVOxd1oHjmaUTmEBpxkBozWOjAIjh3byztEkyHIy6gAmjh6qM6+WKRMgpCj/MRApr0N9vSqOZIxPKdsUAKfKhx43TrKA5N6BnQaN7+E2941HFKvnbEfjZp/++THwY9um/p/e9aT6PRiTNgw7iZrklBJ3SwG5WRtrcfOs6thcLxitLRC7ADY5KgFMc/OudU23sk/KLQUd2WN6x0uSdSrKHDrnzNvDNz4yRVoxnA4H5PxEAFWnh1ZDK8dbefhpKHl/kM+fxnKMMW8dIAnmU0IHIvKaV/LnkQY086w48Ma671Ghpf82q//g9HaL38xVP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14NtNeR4bLbcpgZrAkwf62Ywe1CvBNg7h6YRyuSBgjw=;
 b=IutGfN343jNKCEgPihESQwbzNBxS+RooQg+Gpt5gVH2X6djmjOAzg3+Hp5rX7azPl+ECJLS/IZHj26l7CgtjpsoynAW1dJbqXMAHvYr8Rl6KR7KI5Buuur4Tjp734NTKMyB30+IHAQsRdN+R/P3FQXqYa1aStTH4oLbkNkVhmDcTPrEUdYsJPGa8T3al79zhLoaliuMsBQKMlM+GeL5xg1r4KAsogB6GHoNc9DUi87U2BwuLJDR71Zz8ktrg9DLdGivHvOvgy9o+5INCGoNwXmDY4+6jgkPpi9OOZzZN+Oix5NZcKYX/wpDNWVs3RhAYBNjgzZZBNFQmn7S1lugHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14NtNeR4bLbcpgZrAkwf62Ywe1CvBNg7h6YRyuSBgjw=;
 b=dsXRomg1Gei1Bz6MubfaOzsZ0Saw2P9ZwguxPFNd16lnn9Sy5Wqcy2HBlmBuMRdZBJFfYNOqAsyFJpC5Tcj08tPM6MJOz9UFPV1PJGOU6RjjQd1P5Nt7OD+NvexK8UDc/3pAtf3nkVrA99gD6oXLf62RiQ+8WEWkBFX6YLwx2lH3CF4KeHoK4lxCGhRt9Yb+VknvvmOamnC2qFxO3PqdVrgxqxmGi1KBzvaPM7S3ZdNEKnUPcPVuuLmojXHjpakdWH82+xRaE1oF0jrAWrG3SscD0zk6v04i9WDZFhF+Lbd9M7DDPaSSBrveANbhAH+vRVIVGiZZUiNjFUlP8LoLhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:07:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:07:14 +0000
Message-ID: <70631a2a-e88c-40df-9407-ce19d96bb854@siemens.com>
Date: Wed, 6 Aug 2025 06:07:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers/net: fix compilation error caused by
 RTCFG_DEBUG
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
References: <20250806004919.314981-1-liuyang@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250806004919.314981-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: d672715f-d55a-44c3-f423-08ddd49eba10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGV6cWE0ajI5Zk85WkVmS1JmUGlqMFRYM2pIMnQ3MXBNeTBoS0lFQ1BHUjJY?=
 =?utf-8?B?aStwZjU4TkhCSEFYcDhoejNPVXFkaStkd2pReTJGUTNVZ1hWZFdxWnd3M09W?=
 =?utf-8?B?Zm14eDN1cjM3UzNWRUM4Zm5sSHJXWXNnREh0d0NLdGl3SWoxdlliam9JajZI?=
 =?utf-8?B?aFJxVjI1K1QxN0V5bDFBMjFzTm9aa3oxcDhaUGdMa1ZFc1hkWlFiVm5qYzlk?=
 =?utf-8?B?WGZ3RW9qWEtJYUxoMmNJUlczUjZVUStUMlkxa2JIUzZ2cTc4eWYrUk9BUFd6?=
 =?utf-8?B?QkJsK2tjcnREMnBkdkgvUmxsTGZ1amJKZUVJeTYyc3o1dTcxeEFZTTdsUzRL?=
 =?utf-8?B?OVBZdys2U3VoNlpsWUtIMmREcnZoc09aWjU1U2tvMHp4ZDBwSW54d1NueVdT?=
 =?utf-8?B?SzFycFk5Y0FKWVVMSWdwV2tUa1Q1d3JSMUhlYWw1amdWV1oyYWIyTXd1YmJQ?=
 =?utf-8?B?VFpnVTZiY3MzckpSd3ZHMXZ2QnJzb0ZSYmJHVlJwSm5RVDRUNnZYdE5nbVFM?=
 =?utf-8?B?TWI4MFB2dklPUVhzcmw5ZXZtWjh0ZXArbEtZbVJSd0FHbXF6OER5NzkrOTBw?=
 =?utf-8?B?dm5vK1JOSUlvQ21QS1VwZXUzcThFelNwekY1aGx2c2x2VHQ5S3ZBNWNxSDBC?=
 =?utf-8?B?VTQreUl6SHJkY2ZoZ2NlcU15azFJOFQ5TzVmckQ0alZoTUdoNTR5OE5tYjVW?=
 =?utf-8?B?alM1RHBaWEdTYUNJd2JxTGtBTGNRSzBsenJONVZWWExneFczODhXd3pEZzRJ?=
 =?utf-8?B?K0Z0cm9GOHJIaERwVXQ0SUZjTWVaQ05hMEFLMVZDMTJnSTJXZmlnMTBRY1lT?=
 =?utf-8?B?VTJaQVd0UGdtY1RaVW5VK2ZHTWd3Ykp5dGlVSXZrR0VlaW01MEpIdER2Tmtu?=
 =?utf-8?B?NitkMnY2cjZyeUdKaHNXcEZzYkR4Q0tDOGs2cGZ0NEdMTXpIaGhWMVdYTE5q?=
 =?utf-8?B?K3dlVnFpS2NCWk45cEprclBwOVdDS2JoMXROa3A3S05HVEYxTVJqMDFGZ2R3?=
 =?utf-8?B?RXZuYnRXbEV5Q0NDeWFLODJVTkxXRFZKWHp6M2p6a280VlBiVkphUVBTNi9H?=
 =?utf-8?B?RVBDU0xpQkY2dUVyb3k0aTNFT3MzQ2VBazkwRzhkRHhOL1h6L0pQQjYvYkNr?=
 =?utf-8?B?bnpPakVFekxtMWcxalZ0Q05uUER3OWZBVDlKNXh5akZEendkemNsRzE1TjJ3?=
 =?utf-8?B?U3VXME85RUZkbnVqZUUweUg1TWhMaUhSdHIrVTBCa3Y3K1pBcmQ3VWZKYlY0?=
 =?utf-8?B?ZkNRRW51cHV3V3V5NDVoSDdWMU9HQTNqZUZGVDZsTXRxVmhuTzA5bDF3YWxw?=
 =?utf-8?B?NjZzcnlPcGxyUjVkMEN0NlpNdmV2YkY5Ty83dUpISEpyMGxGNFA4QW5MY09C?=
 =?utf-8?B?Y2sycC8zVk5OdnR6S0ZVOUxXY3cvck9ZMmw2dFJrckZzNkhVdnlxVDNuY0tB?=
 =?utf-8?B?cmNnSFpGclRrejN0alBCdTJPQk1DZmRnNzArTjdHUUxnNW5IRXV4RVB2S0J0?=
 =?utf-8?B?QXpHczh6di83dWwwSDdtYmtCUTdmdHprZmZ5OU8vZlAyZEFhWkZwUHhVcGs2?=
 =?utf-8?B?WjFONGxjTzNiTlNBb0xCcmx6MG5sc2ZVY0tKRzNyVEtXbm1OZEhKVnpwZFN2?=
 =?utf-8?B?Qm5LZlJKTWVpNHFNUWhmQWVQR2UyN3lVTkk0cFFadXM3TVoxdVl1d0c0ZURJ?=
 =?utf-8?B?NWhwaEhEVko4ZGV6YUJhSHNHd0UwWjF1Q0M0QjErUlMxS3AxYkt3NFVOQU85?=
 =?utf-8?B?S1JJUU95ek55V0Jxa3pveGNLbFVYQkZWOXYvYWovUGJUck5qY0Zick4vV2Nm?=
 =?utf-8?B?bUsxUU1XRlVUVkJXR09qb0luODc5bmlYNFBOMUVGTzVvWE9CWVE4SXZZYmRq?=
 =?utf-8?B?b1hmNlpPK2l6SHVrK0pFNDVFbkpyMmUrUmFqQkJ6WlB4YXVjSEppQkRwcW1E?=
 =?utf-8?Q?2/YWrsjuhbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVlYcHdiNEQzREtWeXdhREVRakhwclZLTlc5VlFSaHFKNUZKSk56MjBmdjAw?=
 =?utf-8?B?VFRjbDNFQ05hUDhLS1F1T0ZqVG1Pck5IdE4vWjN5TXVITm5IZHFvWmNBcVlI?=
 =?utf-8?B?aGtSdE9SWHhHcU9pRXVTSTlvREh0SzZvQ0N4b3NsMTZkQTBDUk45d2xvdFlL?=
 =?utf-8?B?bmJjSVJ0UDJGeFBNWDVkVzFQeDZNcFd0Y2RscnZWclNVeG5ZK1JwQlBkZWNi?=
 =?utf-8?B?MTVZdkkvSkUzVzY3MUdjL01NS1NERkNzMW5raFk3R1NaMDd0dXJYS2ZFbHdE?=
 =?utf-8?B?NitXT3BhQ0hvcytBSGtIYkdqdkVDQmowaUF2VXByUmNjQm84cEo3MkIvWU82?=
 =?utf-8?B?cUdrdWVMc0NWckRFSDVUall4S01aWEpWQk1saGtLa0U2dW9wSWZ5bmJvdEUr?=
 =?utf-8?B?SXNVMzNTS2I5cG8vd0k0NFM0RWpza0szM1RvVng5eUpTNTZFU25OY0JJL0l1?=
 =?utf-8?B?NWtGczdZRzZSKzdYZlZLcWkrTlhMMzBtWlBpYllUYThQVHVFK29RWFVENzhn?=
 =?utf-8?B?V04rUVVRZEZrb1N0QXZTWGFFTUhQaDNKc2doY1BRSU1vRWlyaklDWkNvZnlN?=
 =?utf-8?B?OFFOcFFtbU9xV1J3amtrNnV0d2w2SElZR1hQcjhwSmVSd1JFTTRGWDVEVStY?=
 =?utf-8?B?WmUxRGVjT1NYWDBrTmZQaFpOTFRkNENkOEpzNnFhZUYvei9yR0ZxTmtRby9E?=
 =?utf-8?B?QjZ6QkRzNHhUOFVRRkk5Sm0yRXQ3WHBRYklweXVMZnBxa3dncmNGN0trcFF6?=
 =?utf-8?B?cFBMZDRMSGx2ZC9jVjRhelFhczdWMkdzaWExKytncjRTSkd1M3VRcFBaQ0ZK?=
 =?utf-8?B?VnNkNkZBMUZsZm1DVW40Sjg1VGQvVDBsMDY4TElpemt6eHpNTFJEWHVhN0FK?=
 =?utf-8?B?d3JMTjF4cDlVYWZ4V1lJV0R0NGI1cjU1cThWYmlmZUNLYzJDUml6QmxTMUZl?=
 =?utf-8?B?d0pDYUpzOXdnTmUrVzV5djRselJHU3ZlRWpXYng3bk0vYkRqU3FxeUMyV1Rv?=
 =?utf-8?B?Vlh5QllGZE9nRU9QayszaWwvUlU3OVJHYVo2amFVQVlnb0hGcDhaZ0xiRUd4?=
 =?utf-8?B?RkRCbWNoSGhPTURldzh0dFhiMTJxbVdqWmRhektZVU4rTkdDZXVsNHZaQXlu?=
 =?utf-8?B?b3dpYVZvc2RPYXA3N0RXaDNFaW5lSGJCRVIvdmo0R29HUkJna09wbS9kNWlo?=
 =?utf-8?B?OUJxZEpoL21PeTNtRFZWOS9CRVJ3ZjIzZkEvc3NTTUJZeFNSemt1bGZBaDJp?=
 =?utf-8?B?cUI3SUF6VVJaMlZ0Ti96bVJRODU4dVFUMWlTWlQ4RVl3bTR6N0JRK2VNaG5K?=
 =?utf-8?B?ckF5cnRIeFg4YlNxUlI3bmt4K3pNRnFBK0JEc080N0dnbG5MSmhHeUR5aWx0?=
 =?utf-8?B?czkwZk0vcnZkaXRud1J0UXBhcHRaR0N0MnZVVnB4Z1RHS3dxeCtjNjlXTjF6?=
 =?utf-8?B?NzloSXBienNoV3I5RXZzdVcxdGFjbHo2bkJ5UlhNTkFETU1yMXYwRHRFZVdF?=
 =?utf-8?B?THBJOVk1T2h4akxKallxV0Q5S2hmUmFHcTNQNXZ1SFhSckgrNXVlTkhxS0ZG?=
 =?utf-8?B?K0k1YWNmM254bWwza0xpMXlMQ3FQNUt2UTRVRElQNUhpQlpGVHNUa05GY2xp?=
 =?utf-8?B?Ym1OS2llcktKSVVmbWFYbnphWUs2aVFtZ1ZENzA0TnhicWwvRGdtQkFSWDd1?=
 =?utf-8?B?Q01FaUwrNm5LTEtHWTVQaUpIbGtiODdzQjRMOEIrUmxwYjdKbXBHL0lGMkNV?=
 =?utf-8?B?V3MvZExLOVdCdzUxTElKeGJUdDdUd1U2OUs3Y0VtT2pzczR6cWpqRHNqYW5w?=
 =?utf-8?B?MXVyNUEwMW9TYlkvUEVJU0hsQzdBYk8rbjRrOEdIZUpUV0tPd0ZhTi9lM3Nk?=
 =?utf-8?B?bXphUEo5dTVNZXZWVEtQTXdRM1VWekQ4SUtVd05MT2xpMXc3VVI1L1NwTjFT?=
 =?utf-8?B?UXpLUm1RcytXeUNsN3VTKzB6WkY0RlVselJOU2hOWkExWFpxS0phWmJ4SUZM?=
 =?utf-8?B?a0ZTS3ZLWXYzcUtzcXAyN2ZYVDRwNnp5WWJnK1lCRVJuUE8wa3F5YWhUZTE3?=
 =?utf-8?B?Nm9vbjgyaldnZmdvUUFmS0RnOHlaOEJHOTIraEgvZkZTb1Y3UVNYWE1mTDMw?=
 =?utf-8?Q?qAhaF4rNmdKU0los/s1ytyov2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d672715f-d55a-44c3-f423-08ddd49eba10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:07:14.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1vJ/en5XE5Uh1mCpA4oC8+TlxoGrZlKPsQ0zDEiCsf8a6Co0/Ja3X9/OaWRQfSeumu5d73QS9cO3pvy2eKGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7492

On 06.08.25 02:49, liuyang wrote:
> when kernel config enable CONFIG_DYNAMIC_DEBUG and
> CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG
> The RTCFG_DEBUG macro uses a ternary operator (?:) to
> conditionally call pr_debug based on the debug level
> (rtcfg_debug >= n). The pr_debug macro, in turn, expands to
> dynamic_pr_debug, which is defined in include/linux/dynamic_debug.h
> and involves a do { ... } while (0) construct. The problem arises
> because the ternary operator's false branch returns 0, which is
> not a valid expression in the context of the do block, leading to
> the error expected expression before ‘do’
> 
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  kernel/drivers/net/stack/include/rtcfg/rtcfg.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> index eb9ad076e..df0e8e06d 100644
> --- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> +++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> @@ -41,8 +41,11 @@ extern int rtcfg_debug;
>  /* use 0 for production, 1 for verification, >2 for debug */
>  #define RTCFG_DEFAULT_DEBUG_LEVEL 10
>  
> -#define RTCFG_DEBUG(n, fmt, ...)                                               \
> -	(rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
> +#define RTCFG_DEBUG(n, fmt, args...) \
> +	do { \
> +		if (rtcfg_debug >= (n)) \
> +			pr_debug(fmt, ##args); \
> +	} while (0)
>  #else
>  #define RTCFG_DEBUG(n, fmt, ...)
>  #endif /* CONFIG_RTCFG_DEBUG */

Thanks, applied.

Nit: If you send a newer version of a patch, actually increment its
version ("PATCH v2").

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
