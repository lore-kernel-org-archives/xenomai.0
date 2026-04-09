Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC23090DE
	for <xenomai@lists.linux.dev>; Thu,  9 Apr 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717222; cv=fail; b=BieOXTSNxGqf6wOqT5CsOM2ZgqGhjUKWyx24+8Eyddt3q1OFZe0y8D4cbyQf0rnkxd2woiFugbeFvUtERfrZbXVGavTDHfkKeZkEZZz6xZEX5xOmnQs8XLxGEFjqciTcBvsFyKNcX4LSu5p55pRy0iQciDUGehJZBDqcg9G7Zys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717222; c=relaxed/simple;
	bh=VXrQZ57eGyEkQCjeJhonRdkhjKKD+KhztzjZQhoTRss=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eUydxH+Jvu2fsFHrGaCsuNQYDnb1gKZ4/G4oj8uddB2zg34n0KSj+0hWtve4clPG94NwrTOLv1pniaT43ecPGlbLbrVb5E0e6HPT0voQfKcUPPS/MOF630ZFJhfu0c9GM6nZsv7xgCYS9HFqOaRcI/hFJ9EVvaet3UHaGR39Ceg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gSH+ojL1; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gSH+ojL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2aOUTYW3CL0d8Np9uccOnfhlrWtVwczWgTiMYcuNXPxgduCkBjKXfL/9C6j06Dw0Tn83uPejq9ZpQoTgr9WAiHI2blqJCcS4AqMhm2NEQgkrdFzRpqvC8aVGsj4kAyeSdvMTOFE8tErA8K/XflsmaPuZgbGA4cOfUZu757Ndf+Tm9ucpMz5Oab9X3mB84DttxLkgXs6/nqE3pLNXyGamzCk+DkwpvUW7G9QD1Slli/L0sFBslfn0o/Xt1w1P1BLFETFjhdwG+IK4B6iNQsGB1d3MQXFD77J7QMirkkIH/rG0IqLXjR6k+AusxTsXKST81J6sq7FL/hq0QS32m/2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJtj38pB06B6j7qvugeLy7eC0dGwhBuDE+Mxrf4y6j4=;
 b=ruwuIavyM01b6eUatVv44kG+7ZyubwFYlIK9t5ARy+J5DokL8xweyGRG0Ezp9az8Oz9ogoyruhwac6k1AdpcGgiL3tj5AsJvjbo1NLNKodeFM4ubDRFaU3R+VrnEWjdAOF90jPxBd6QNvM0u/Xm8/g/WWKxqbS1pIECCW4wPzdnAKFt6ogJJINNiTXuDAsAHDNdwfr0ccCmNH6iFns/1nR2xewWc6sHDVnSQdIpmGwJ5+G+88a540y6+pM0AitSRYJLexVj+tdnbvQk37yueDh1uPb3HJQWOVE5pH8uxZlFw/lVnJj62nzyLlzb4FOdr4iIADsm5Kmwsk9bGmK95sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJtj38pB06B6j7qvugeLy7eC0dGwhBuDE+Mxrf4y6j4=;
 b=gSH+ojL1yWQqHsKZVuo1wUojK5TvPU5QdPrlkRwrEyXg/6S1OxzyrMuuT6F33ywvr88sGCoF7UidnDiOPiFLSV+/Jq31IdoBADxDyp1MmCGdpJYkt16mP4t8+yRkypK/GYATw9YAnYvvk7/Gayz3RaUTC3BX/saLiyrnwUZ+PqoCeeZRTefowThNOjIEpYGBA1TwECsgsixmmYfVavIgaNerOKgFHR95GJEdXBFG+p0XbQGjW36dWzoPec9CgJmvBSt/VBEKKTi0QXu2Zm1qF8HQL+Vu3QoUkfNQ7744Bw5YU0Fua2y8B78CMNuAEDfVTQfdYoYli8xj+ms8A+jiiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB8888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 06:46:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Thu, 9 Apr 2026
 06:46:57 +0000
Message-ID: <f10afb4e-2aaf-4a3a-8bc7-893c1a09cdd1@siemens.com>
Date: Thu, 9 Apr 2026 08:46:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel WARNING in Xenomai3 with RTnet
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev
References: <4742f315-9fae-4165-b5c0-066e6500baed@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4742f315-9fae-4165-b5c0-066e6500baed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 300e09e3-6820-40b4-ae36-08de9603caef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	dU+UsJVY2I2aQwNAg3lngYw07dY23qYS7azPqi5SeE0pgph7gwnY0cX49INhX2Nbl7Q/5TPtx1zI2NYeVd3GOAE6sQfs2b+UaB7GEpFuw1vrtIfSXFpcjB9VERNksaui5omHWpDR8g1eeBpYrFpfxc+lu00sB0IHSsHfnNE+Q4BUXCaNRTVH2vrZCaYt9DvpD1ofi7CzUk0YWc3GSHo7ohO0UwNhaqDM1jH769G6N2kHzSlK8xj86DnfplqkUyT6NCwtO09CockihUPTjXVo4USKyhuQmGyp/V0FJ6GJNzxyq0cp3RwsUbCg3kAQGp4eWkfspC79yKIWNGCTjz/3VBNE85n+R/SUCxeKw+8xsJ+1+nYFipENsZvlUW+jA9YP0o+praZxRnErsrhJgNF1/oebr6q+/4pgEKAMiopMgOiIX4cLW0N83sMsA1QNGOr+EMPuZ/qcTvDR5TaiYB9EY4pvQzmL/OQnTkGO6CrQZza6Fvpl3qRWTt+r6j0xZUXaLZA7RtQwCv818LUJX8TO6YN9ifV2vtDTJlZyzNLej60M31bVor8c5+zItfml4Q51vanUt8pcnpX/OuSwpj6nBW+n5n+Du8c9Ku/rGiFy5irs9r0j0H7HAU0Jvu2L+qlwEga9jBEzS6U1uKEgpgadgXAOtHiQT4yPN4WGarjokjWR9GVSITlTHxJpEEn8fMR+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djcrZDczVGtxeGZaM29GMzU3aTNieG1RWGlhV1VHaTZMVXpyZk1PbEkrbTlW?=
 =?utf-8?B?MVA5dmtRNWJNUUxpclBCSjZza25kY2gyMHRiNEg2MjNWaVlPUEJLMk9nTnJO?=
 =?utf-8?B?V3hucmR4WTM2cEVsQWNSMDROMTFTa3NrMzhacGZicWF6STBRS1RXcDNldXFD?=
 =?utf-8?B?NGlZdEdxQXZNMU56dlBrMXc2WWdHcWN4R01yRUlCNEN5VXF0N25mYlpqZitZ?=
 =?utf-8?B?Z3ZMVXBYYU56Tkg2REd5Yzh1Sy9OVjQwU1JRc3pERUtlb3FaUHhsU3hlQ3Nl?=
 =?utf-8?B?OUZhb3RTbk9RcWFFMk1ldm43OFordHdkUlZ0RG1CU0xRR29DYmdZV3dIQkVN?=
 =?utf-8?B?Z0c0Yk9sbmJjdUx5UVZ0NnJaSW1ORWNuMkVzTThNb3VPY1lOS21pRzlITk5B?=
 =?utf-8?B?cUd0b1grK01yd1BRNVpNVzlTMnFXNkwvYkdwQTVOYWpyWWQraWpwRDdMVUEx?=
 =?utf-8?B?Z2VXNDc5TzFhVkVGRXJWRGt3dzVJaDRQeDBZaGptRk1BL0NxbTFESnF3NjBp?=
 =?utf-8?B?a3VnQkVzRDJNU3NGTlVvQTMxR1hNa0Q3ZVlwdngxVVZ1OTRpL0VCL0ZvUjRO?=
 =?utf-8?B?eURTL2c0QVlLRTBoR0xxMU9OY3Z0TDJCd3JmRjVEYkhtUUFZbFpadlBiZS9k?=
 =?utf-8?B?ZXVKMXcvRTgyVzlMTmhVdUF6eDI5bEFTTURvYkdROFFCa09CZzFDVVBEbXpq?=
 =?utf-8?B?Q09LWEdYd21lMHdsWEw2UkVPZFROYm5EbDJmeUNCVStxU2JodHhhVjF1bmpL?=
 =?utf-8?B?eVREZk0vS3pMNDVqd0lRa1BvdXBZT2lqK2IrQ2h4VXkvc0NEYVFTbGhRa0JT?=
 =?utf-8?B?V3NGYVVaZnY1RVQ3NUVaUDVpb0crOTBFOFgvMjFCbHdUK1Z4TFcyK05pWk94?=
 =?utf-8?B?UUswbVpWTWtURmFHUHpZcmhzOVRpd3NpaUtMT0Z6UWswL3JudCt0eklMZDRo?=
 =?utf-8?B?eGtHSXh3dWJmYmt2aGVUd3ZOTjZuelZoVXRLL0JQUUJ6QTNCTURtN1FxWHgy?=
 =?utf-8?B?UFRPeVJxOWZsNFVJcVpSV1FEREpWUVBGbUlYU0Zoa1p3RmRseU0za3Z5bDVL?=
 =?utf-8?B?ZTlSdXJ0QVhGQitxbFFMM0NhNy9NaDQzWUtITjkwMGxTS2dJQ2Rqb1c2ZS9j?=
 =?utf-8?B?UE8vRnVURUJtN2pITURNbGlmU2RRY2RtRDhDSExJc3k2UVBvMkVnZjE3Ty9m?=
 =?utf-8?B?eUJ6U0pRNGNDZDYzQXo4M2R4RFZDS2N4aVkzVzBnOFJGKzE2QlVORHVJTG4r?=
 =?utf-8?B?ZzlQbHVPdXU4bk9Ma05qRXhKNGlhbW1RTC9HbGk1R1FUZWZYaytrczAraG0y?=
 =?utf-8?B?Y1FTbjNhNXdaekJNemNDa0ZzY3JyVitmNmhMcGJLKzFlb0FVekg1UmNxZnJU?=
 =?utf-8?B?bURlMXZFQnlIVDNkTlpzbVZBSHVnb3c5dWNTVyt1UERrc2xWcGlCR2NvdkhT?=
 =?utf-8?B?MzZrc1c4cTlMRHNIV0hOREZQMjN1dXZpaGtTMkFxRGhkaDhOZXl5QVdOZVpw?=
 =?utf-8?B?T2dVa3VJWHR2aHlrSWVxMCtocUM5WjRUSTEvLzdpKzRzeHZQRzV3VTVWWkN3?=
 =?utf-8?B?TjFzWDlJOXhlakRoS3FWR0NhRm9oWHhYV3VBdEdHdTBuV3FCOVAyQldqNE5v?=
 =?utf-8?B?aUY4WW1qOURSbmVHSHVkbFd2YURBbHFQMVg5QU5rdjVWNGl3ZTJWTk42d21H?=
 =?utf-8?B?dmN1MVhRUGw1V1JYSG5rUnhzYzJjSUVhRGNHV0JFNnMzazU0VjhVQjJhblEw?=
 =?utf-8?B?bERwYjlxcy9xdXhZTU5nVkNaWnYzZkpYSEZnMy9SdU0yRG5SOWFuYlpHbHox?=
 =?utf-8?B?allQOVFhZ0hDQWwxMlVRNU1VN01ldjVSQ25tUXhycitGMGljUEp4R2NZYkli?=
 =?utf-8?B?YXNkVDZTU1k4Q0ZTcUNZQkpPUnU1d2JkR09kaHNleTNBY01TMmdCV3BOeThj?=
 =?utf-8?B?cE9HVG1zWFBCcE1zRzUzaWdxV2ZhbGo0UC9mWEl0aDZMakFvcDQwWHhLRkxL?=
 =?utf-8?B?QXRpcHRvaW5kSXNPYkxRdkVVQ3JOWkcrR2JmTHY1WTYyTFR1NGxHQm9vL2Iy?=
 =?utf-8?B?Z1lUTkJidWNvTXdZTktzU25Icmh0RUlleGhramZDcFFJellYeDBmMGpOaW4r?=
 =?utf-8?B?ZnhPZzlXaHA2SGVxcHlzbGdoYVBFYTltNnpPWGhFYnMvNFBIaThvWWkxclJC?=
 =?utf-8?B?QnlLNm43MzZ4Vk1pNElrZElicG5OQWpGcE9JOEpuOW8xY2JRTWpDamhuQVh4?=
 =?utf-8?B?TlVsRWw4eExhano5bmVhSnppWjlUNUc3eUtMclJQd2ZkNWZra1l1TTA2UTBL?=
 =?utf-8?B?bDFWSWYveVdKTkRVRmRQSW5rWFFpMk5BTDJNeDNsUHd4OUptT2gvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300e09e3-6820-40b4-ae36-08de9603caef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 06:46:56.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neCDGZxCL0BiVHjQ73AxBnstwyS9F0ybDMjki/Em9ED/fPQKAcKr2MvzuCeO+bBNSXps0IuUlMJgWH0W/L1wVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8888

On 08.04.26 22:53, Hannes Diethelm wrote:
> Configuration:
> 
> Debian Trixie
> xenomai3:master
> linux-dovetail:v6.12.67-dovetail1
> 
> I have the following warning as soon as I enable the network interface:
> Apr 08 01:52:12 trixie-box kernel: ------------[ cut here ]------------
> Apr 08 01:52:12 trixie-box kernel: memcpy: detected field-spanning write
> (size 80) of single field "call->priv_data" at drivers/xenomai/net/
> stack/rtnet_rtpc.c:93 (size 0)
> Apr 08 01:52:12 trixie-box kernel: WARNING: CPU: 13 PID: 2480 at
> drivers/xenomai/net/stack/rtnet_rtpc.c:93
> rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
> Apr 08 01:52:12 trixie-box kernel: Modules linked in: rtudp rtipv4
> rt_loopback joydev uinput qrtr rfkill binfmt_misc intel_rapl_msr
> intel_rapl_common ccp kvm snd_hda_codec_generic snd_hda_intel ir>
> Apr 08 01:52:12 trixie-box kernel: CPU: 13 UID: 0 PID: 2480 Comm: rtping
> Not tainted 6.12.67-xenomai3-73ad3b #3
> Apr 08 01:52:12 trixie-box kernel: Hardware name: QEMU Standard PC (Q35
> + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Apr 08 01:52:12 trixie-box kernel: IRQ stage: Linux
> Apr 08 01:52:12 trixie-box kernel: RIP:
> 0010:rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
> Apr 08 01:52:12 trixie-box kernel: Code: 26 50 00 00 00 0f 85 d1 fd ff
> ff 31 c9 48 c7 c2 00 13 94 c0 4c 89 ee 48 c7 c7 48 13 94 c0 c6 05 06 50
> 00 00 01 e8 51 d6 97 eb <0f> 0b e9 ab fd ff ff 84 d2 >
> Apr 08 01:52:12 trixie-box kernel: RSP: 0018:ffffcdff82ebbd68 EFLAGS:
> 00010286
> Apr 08 01:52:12 trixie-box kernel: RAX: 0000000000000000 RBX:
> ffff8988585012c0 RCX: 0000000000000027
> Apr 08 01:52:12 trixie-box kernel: RDX: ffff898b6fca0948 RSI:
> 0000000000000001 RDI: ffff898b6fca0940
> Apr 08 01:52:12 trixie-box kernel: RBP: 00000000000001f4 R08:
> 0000000000000000 R09: ffffcdff82ebbb28
> Apr 08 01:52:12 trixie-box kernel: R10: ffffffffadeb9ee8 R11:
> 0000000000000003 R12: 0000000000000000
> Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000050 R14:
> ffffffffc0cff5b0 R15: ffffffffc0cff6e0
> Apr 08 01:52:12 trixie-box kernel: FS:  00007f1499d11740(0000)
> GS:ffff898b6fc80000(0000) knlGS:0000000000000000
> Apr 08 01:52:12 trixie-box kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Apr 08 01:52:12 trixie-box kernel: CR2: 00007ffe3de7dff8 CR3:
> 000000014d74e000 CR4: 0000000000750ef0
> Apr 08 01:52:12 trixie-box kernel: PKRU: 55555554
> Apr 08 01:52:12 trixie-box kernel: Call Trace:
> Apr 08 01:52:12 trixie-box kernel:  <TASK>
> Apr 08 01:52:12 trixie-box kernel:  ipv4_ioctl+0x16b/0x230 [rtipv4]
> Apr 08 01:52:12 trixie-box kernel:  rtnet_ioctl+0x164/0x190 [rtnet]
> Apr 08 01:52:12 trixie-box kernel:  ? __count_memcg_events+0x67/0x100
> Apr 08 01:52:12 trixie-box kernel:  __x64_sys_ioctl+0x91/0xd0
> Apr 08 01:52:12 trixie-box kernel:  do_syscall_64+0xc0/0x230
> Apr 08 01:52:12 trixie-box kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Apr 08 01:52:12 trixie-box kernel: RIP: 0033:0x7f1499e2091b
> Apr 08 01:52:12 trixie-box kernel: Code: 00 48 89 44 24 18 31 c0 48 8d
> 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24
> 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c >
> Apr 08 01:52:12 trixie-box kernel: RSP: 002b:00007ffe3de7e9f0 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> Apr 08 01:52:12 trixie-box kernel: RAX: ffffffffffffffda RBX:
> 00007f1499d11740 RCX: 00007f1499e2091b
> Apr 08 01:52:12 trixie-box kernel: RDX: 000055c8e00d60e0 RSI:
> 00000000c0500285 RDI: 0000000000000003
> Apr 08 01:52:12 trixie-box kernel: RBP: 0000000000000002 R08:
> 0000000000000000 R09: 0000000000000000
> Apr 08 01:52:12 trixie-box kernel: R10: 0000000000000003 R11:
> 0000000000000246 R12: 00007ffe3de7f818
> Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000002 R14:
> 00007f1499f60000 R15: 000055c8e00d5dd8
> Apr 08 01:52:12 trixie-box kernel:  </TASK>
> Apr 08 01:52:12 trixie-box kernel: ---[ end trace 0000000000000000 ]---
> 
> This can be fixed with the following patch. However, I am not sure if
> it's the right way to do it.
> diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/
> stack/rtnet_rtpc.c
> index cd5f0546d..caed27269 100644
> --- a/kernel/drivers/net/stack/rtnet_rtpc.c
> +++ b/kernel/drivers/net/stack/rtnet_rtpc.c
> @@ -90,7 +90,7 @@ int rtnet_rtpc_dispatch_call(rtpc_proc proc, unsigned
> int timeout,
>      if (call == NULL)
>          return -ENOMEM;
> 
> -    memcpy(call->priv_data, priv_data, priv_data_size);
> +    unsafe_memcpy(call->priv_data, priv_data, priv_data_size, /
> *embedded variable length data*/);
> 

Yeah, good catch - the kernel and the toolchains improved their
diagnosis features a lot since this was written more than 20 years ago.
I bet we have a few more of those variable length fields in RTnet data
structures. Those should be converted to flexible array members, see
also
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays.
Happy to review patches!

Jan

>      call->processed = 0;
>      call->proc = proc;
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
