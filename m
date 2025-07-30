Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE91A0BF3
	for <xenomai@lists.linux.dev>; Wed, 30 Jul 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904401; cv=fail; b=UQ0WR0WbRhHE1TyeAyLBRb5ALaeDRuzxVbltGZA2Joe2ZcDCV3i+GHHz0b6PmAVJtnon4fIBRVgWq5WQnkWltRQurCAabXTzf1j/ahlodJVphGxRPZLxI6VcFTqami9bnbrDNzzQMfs4kH/RsIy8x3dLXsZazfpUs+FjAXqvhNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904401; c=relaxed/simple;
	bh=L65Gkmdsc0ZqaIs6r8WMNQVMqvnqBLkM/nNGleANvZc=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=pPeOD/2N0MxyJ+juZHdfFUXy80QMyvtHoKiUGbSzxhoOAxfFXXPoZO4L/SHMPd8pIfTqbWaN4FPe3owCCEnzCBE5zoXvCBFEpWsAC7jeOr/wphYurqTPK2+qloGoXsBE1BsBBo+/GbZQm5Wr4hz/LRqgaO12Ixwu/6jBK94BoWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ccrRd/Ip; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ccrRd/Ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Dlkz5VlmuMOaphnA5+lkIgko9sfYfcxViS9ASJBTJ7goHSmdOISJx/G/eEO3t99flX0UGVQ9gmrbQWDUwbyAQlpVw/rBoqWfNl/l5OKC8iSluLwR8KqLxWD2//alj9XcpBnn+/mSivkUxe6EW7dNqN4cN4SuSFZsYyk0fbp6goV8qupVk97GowVkzesWhdi+QMvGs0ggCwzQ2UApjQnCA9e2rj9+B7s1ZKFHj4B6lBZ01XtBADkLYgjkl6QObnXz5S3Oz1YDiNDbEPe5WMgEVgSnv6+wdDrEKG187qHPeDtDpuHR5ikgdsq+H1t/jJfM60YEx04mcHLLQcKd+CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3FyiZTdRTVv1yxFGQs+DKrLZCiQKLEmeTuGO9PVcf8=;
 b=UoVpnwkkFyyXMlXKffCi6sxCaY3c8Zjsxp0iuJ4gYV6iBeMbzRzq8EuchPWcTGt1a2h2XpgtANzP7e1vvpT3IConmm0PT//0S+c1Fmwz7qUfmILEkGAxb+j2KVI4/o3YfFfSfmkZ0eAE6WbDOxKPna01Em9f+iprjUTeMjOQvlAl/Ig+j0N75AermMNRF2ZPvhgmGH+C8pQXsPNNidsbHIFkM8WQr7/SVELl8xHcWE7jpEzIoUsWUihSCIZl5/bR9e6gvR2b8ySy6ZMISlQBMtu9doXQuYwNaPFOtcDGVB8VwNzw+O70s+B7MtEFp04A0roRFThqzoKcy0qqsTgkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3FyiZTdRTVv1yxFGQs+DKrLZCiQKLEmeTuGO9PVcf8=;
 b=ccrRd/IpfeYwWSDZ3tdaG+QYrSp1wNzz5QH/vGwopZAbUP2WWaT2fWkpy5yweMlPt2Nx+CEHMYIkFLfdbxe/XVj4awtvVtIw5fbTs8C+PhSM1fuaJ0fMJRzzHKW3OGWileyXZywXpZk0VDVhRLj4YResIo1/lFPrGPhS3ZYHL29jsWs7dGznecRyhiPWRQ8kLwXJb8gszdhL4kjjGNCXWACg8g4qM2KPj2IY1dd6RZ2x2uAMXQTiChJuY8l3g4iLdiT9d4j1tQVdslq1O7TCMIxW0kaSNqR/F9Wyv75veCdWuzE8OT7OeKNvR4N4MapY7ildhDTbxmpsMDiJfNoCpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:39:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:39:52 +0000
Message-ID: <cc22b13d-7324-475c-b060-641a9ec617d0@siemens.com>
Date: Wed, 30 Jul 2025 21:39:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH dovetail-6.16] generic: irq_pipeline: Fix fallouts of lock
 guard conversion
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: e01f5993-ea49-46de-d2e4-08ddcfa0d973
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXdCMWNNTDN4T1QrcUlMcU5tSEc2Zmg5S1drUmlTS2Radk9hY3N6L3pIOFRy?=
 =?utf-8?B?dHdJeWhVUndWaVNXQUJuSUlCZGFXa2JwRnFlbXEzaDhMcUNxeUtmR1lLcnBv?=
 =?utf-8?B?bjJuSmpGOElmVk9zSk5zbGo4dUk3dnV0ZmVDbHh5Yys0L0RTWTliMTVML3VG?=
 =?utf-8?B?enJPQmk4YitDK0lJYThVQ1YrclNPVjBwd1FXOVRxeXZTZmxIMC9uTVRIdGN5?=
 =?utf-8?B?MVVyUmVtM3N1QnBSU3hYQkhvNXQ3Uk8vMStqTW5laVBPZjJMUmYwTWRUWkZt?=
 =?utf-8?B?dFZSclpONzQ2MFpQVDhQTVVWYzZuTTZYSkFDQXNzZU4xRklnWmxCQVoxTVFX?=
 =?utf-8?B?NnkzTndOWWFKOEZpRi9JQWQ5V1lkanFTelVIaUNiclplclBqRnlZd2tsV05S?=
 =?utf-8?B?bERaQ3dUNHBKNytpRTJJcWNqTkdmenBBeXZ2Y0JoTW9GcFJlb3hHbXZkMHBV?=
 =?utf-8?B?Z0hYMkNWOWV3MEg2K1AxWHhxOE9jSFZlaDVVUUJGOVpxb1RKWlpsZEtiTHNw?=
 =?utf-8?B?UWlZbzVMNGk4bVR5MzFQVXRsTVZNRFdjNDBQb04zQ2xCd243SlMrWXNkRTRn?=
 =?utf-8?B?THlJRnd2NU5IbVNvMEJwaVRBU2hldzFHbWZuS2dxV0lJNDBJT1BIa1FZeTAr?=
 =?utf-8?B?RUpJNU9ObEtyTVpTLzBocFlwV3l1Qm5NdnBxYy9FVjRTSFQzOGw0UEs5OE1h?=
 =?utf-8?B?eStvVW1sdWtvNnJRbCs2N2hHY3RDZGgrZzd6VXdtNGo2QTF3VXJzcUtqRUxY?=
 =?utf-8?B?RU13U0d3aFp6MHJublBURitZWFFmVXpVZmFSbjQyWFhLWmxUUXhmaHNNeVNv?=
 =?utf-8?B?MTZWMklaNW15blJZa1dPeVg4WE9WK0YxQnROYU94blo5QUtIWmpGS1BBcEZC?=
 =?utf-8?B?UDBCSy8xSHQ2cWdRTEhKamxqWkQ1bHJJbUFKZU5JUzdZOUtOdjhMU01JeVhh?=
 =?utf-8?B?UWdmQjlyMnVkVVIzL1VDaFI1UmdKbnYrekQzcWloSFpwYTZSbHFjcnlubnMx?=
 =?utf-8?B?bEgwKzhiL1U4RHF5ekJIWTg4QXRwY21RSGhJaXJ5V2RuOWE0dWhXcFNzTVZh?=
 =?utf-8?B?d2l0S0NJV09Cb2FSTnNTbXovb3A0VjBKR0V0bm1rWXlwV0NMbUFqaXJyNnhj?=
 =?utf-8?B?U1FJUytkUklYOFlScTlyK3ZjQ2p4akpIV0lyYlFIUmNseVdrMGZ6RFNBODVq?=
 =?utf-8?B?QmF2RWpDMXVxU3Z3eVJOZ29ITkF2QmJ3V2w2YThoZnBJam9QSWM1UlRJV2FH?=
 =?utf-8?B?LzVoaU4vVzFoQm4zdmloQ3o2SDFPQk5zSjl5TVRrZW41LzA0NE9qVDF6ekFu?=
 =?utf-8?B?WGZ3OHFzLysvVUhlNzlHUC8zSW1YSXpMYWRMRXNXbTIvczdWczQ4WWZaVUFG?=
 =?utf-8?B?LzZSN2lIcS9sTExFWkN0bzEvMjVTVmV1Z2QrcFhkK1JFUnNpQ0oxNHdJZHg4?=
 =?utf-8?B?elZlMFNtdzB1QWFrSUZHNkRzYVdrZTc4eVF0SFY1R1pzUFhvUHE3eUJ3OVAz?=
 =?utf-8?B?Z3RWc3g1aEFjenNLL2xxckczM0VpSElyWGx1QjVhR2x2TXJYY3hRYXg0N3hm?=
 =?utf-8?B?QkRad0djS29oOUkxdHBiSlZnTENaRjlkZlVxT00vZnh3V2gwU3owbzh2STlP?=
 =?utf-8?B?Qm56ajNDU25IcTZFbmt0YlZMbUd4M2VNOHlxdkhEUHI0TjdSV0c3N3ZPOHBU?=
 =?utf-8?B?UjF6djA0UnF0QVoxMFI2dVNLeWlIMk80aG9WQWs1ejJoUDVFdyt6cDdXc0I5?=
 =?utf-8?B?L216NlNOOTBIblV0UXBDamNUSFdSaTc5K1FydFQ3UDJmYUhCdVRHZWRBWDNw?=
 =?utf-8?B?RnI1OERuMytSaHBxdWozSURTakRxdmJ3Zm9PYVpuZHZDbzNza05JU0o2MUYz?=
 =?utf-8?B?Yy9OTmZEMzRkYjI0d25FV2Z4R3JVWHIzZ2VUV0ZuZmpDb2VkaEtMMDZ1TEUy?=
 =?utf-8?Q?qJnpcu+bgZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFZ2bTdUQ3U4UlhhNzNTalNwb200R3NEL1RWV2JUODFsaEJrNGxVZXJFdWU2?=
 =?utf-8?B?eE9jWWhGWjl1TDdEV1JncnBTYU00NDNVNGpDWjZDNXpGUXVxSU9PV1Q5K0Qw?=
 =?utf-8?B?NkhrcWYrdzA0RHVQWUFteHgzZmhUOWgrVGx5Uk1oa2FmSkxGTEJGaDh3ZytQ?=
 =?utf-8?B?Q01zM1dHY0lxdzVKMUIwdFVJQk5xSnA0SE1LdUhDcFcrYUJIZnpUNExnQ0RZ?=
 =?utf-8?B?NktRaDRlQTZjYWN6NUtEV2lCbVZxOFNrblJOb1p4akRzSUdpeFR0Q0dLUllh?=
 =?utf-8?B?ZVd3elZZbTZTaEVBUGtYY0N2UmFoRnBZSHZrcDh4Tk8yejZDckdZWnBZMnlC?=
 =?utf-8?B?ZmYyK1ZJbmluWEg4MlJCOE9qVjVYUk9UY0pSdDJvakRHdFFCOXB6M3crUWNz?=
 =?utf-8?B?dXRhblJMcCtuRVM4ZlhzcHYvMUhhRXh0aUJuVkdGM0E3N3BMWFQvVzl6Smc1?=
 =?utf-8?B?U1cwTnRnMDJBZXlGRFJDRVUyRGRYUklUZHFsMHkrTzM2aElxY0FpajFhVmI3?=
 =?utf-8?B?OXkvb0xoOGxoNlFkS3hieC9EeU1OWHJmTjlGN2Jyc3EvWDQ1ckk3OE1jZDBL?=
 =?utf-8?B?S1I4TDFCMWFIejFuclNSVjlvYzNURnVDTUN2V3Y1c1hNY1ZqTTRLdVI4Q3F3?=
 =?utf-8?B?WG5DaThqRHQyZ1FIYi95amVtQ1R6MnpnNStKNmhxMlk4VXcrZElVTVpoRDVW?=
 =?utf-8?B?MFZoclhQL2lUZVNxMzNpNk1rejM4WHlYVHA3QUVpMXdjM0luZEdUWkxXaTBZ?=
 =?utf-8?B?Q2piRWdBcHByTHhHUGxXVEMyd0N4WU5tZm9ER1ZLblJPaHVzbXV0ZmNwem1v?=
 =?utf-8?B?eE5zemlkUExGR2orV09IV0JVVmdPOCtYYStUbXE0M016dUN5VXgrME4xYzR4?=
 =?utf-8?B?NWRJNm55eVpsSDlxSFRWREoxM1RydjArQ0RTaG91bE1qbC9sZkNoQXlFT050?=
 =?utf-8?B?WG56NG45NXRMb3dCKzZIeUkyaEFrT0pXWE9sVEp2SkhDcWlYV1JTNFpyKy9q?=
 =?utf-8?B?aEdvYkoxK2pjS1JzUlRpeVFnODF1VVdxc2VzWm5rRUFsNWhUY3phcWdyNm93?=
 =?utf-8?B?MHFNN01tZnE1WHQxUEhKZ3BrZDZRWnc4NVU3RjBkUVhCbTVNMTI3Nndoa3ht?=
 =?utf-8?B?RlVOc1NvaHNmd2pDSkZ3Z0ZHQjhJUmFvUzY5YzZOb1lxSjcvVDRHa0xrdU5u?=
 =?utf-8?B?RnFhb0RxczZhR3lyVVF3SFI2YlZDK0orQUdXK2lIcEYzTFo3aG82YkF0cEh3?=
 =?utf-8?B?bVpKdVE2YWJxT2krdEJGWkZQaXcxT2NtaTUwZjVlUllGNnFIc1p3ZEpQdFhJ?=
 =?utf-8?B?US9XNG9FSnVXd3Bxem1aaXNISzZEd1NTTE9iK05aalcwNVBqV1JRc1hOOVFt?=
 =?utf-8?B?aVNvZzlGK0x0VmVzQlNEUHI2aXNnZTBRc25HVGZvZ0tmR215QTdzeWdyU3dj?=
 =?utf-8?B?T3hxSDNvengzbWFoSUUxVnBTQ1BvYThYTVhzbllDSjlXdG5hcUQxL0h2WmJj?=
 =?utf-8?B?MXVwejhLRVpzRFIzZFZhSExCY3hOTXpKNHdoT3QyYld4U3Iva0RMTmZTTEVh?=
 =?utf-8?B?K2dlRXQ5Y0d0SlNUMzdpaVBHVWVNVlFkNVBGTnl5QUtNTXo5OC9HenRzQVd3?=
 =?utf-8?B?WlhLSUdhbFJ3ek9TWFBxcnhNZlh1ZG1UanZJek8rUHo1SDNBak4vbXhpRWJO?=
 =?utf-8?B?enNxN3pDcWVVT3JMU2hGOUtac1dPb1U4T3hSSWtreSswQ0tyTHk2MDNFZ0U3?=
 =?utf-8?B?ZjBDWGZMaVhyOExlRzVSdUZ3YUxKYUg4Y29BeStodmd4VTdCRmFzQ3g4L0JO?=
 =?utf-8?B?TDh5TTcrL01FU3pZM0pVcnJiZWlGRGFzVXRNV2ltMjlzU05Jelk0RDdzaDFB?=
 =?utf-8?B?NXlJbzNlVDB4aVUxakVnNWE1NEN0MmhINFI2YUY4YjdWQ1BMaFlwMXJibis5?=
 =?utf-8?B?MzRkbjBDdjJlc2kyL0tqVUZFS0I4clJIL2x4emc3cUlHQWVRcEhWT0s1UDdz?=
 =?utf-8?B?Wm9mL2xEaERYbjh4UWZnWDQ5Y0NyajZBdldlVHdDbnhFaWN6aG1naE1teCtq?=
 =?utf-8?B?RWVoNVJHbWQ2TEV2NGxmdmR3MHFrd1RzWDhNd3FHdHNqUE8rR0ZhK3k4eGRx?=
 =?utf-8?Q?UG1HNqymSVg0Is50kU2ojb35D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01f5993-ea49-46de-d2e4-08ddcfa0d973
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:39:52.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoNbIAsR2rsfU6ybYYOJ+Q28jHYgs3GQkR6hNKoTygN8oi0H6OSdXtSJw2EcXmIysMucNJ44uELncTXOqh5yTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5628

From: Jan Kiszka <jan.kiszka@siemens.com>

The irq_chip_generic struct uses a hard_spinlock to support the irq
pipeline.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Should unbreak the Xenomai CI pipeline.

 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 drivers/soc/dove/pmu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 28cebe480eb1d..a2f8433d9a564 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -68,7 +68,7 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 		int hwirq;
 
 		gc = irq_get_domain_generic_chip(b->domain, base);
-		scoped_guard (raw_spinlock, &gc->lock) {
+		scoped_guard (hard_spinlock, &gc->lock) {
 			pending = irq_reg_readl(gc, b->stat_offset[idx]) & gc->mask_cache &
 				data->irq_map_mask[idx];
 		}
diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 7bbd3f940e4d9..142ccda535176 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -257,7 +257,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
 	 * So, let's structure the code so that the window is as small as
 	 * possible.
 	 */
-	guard(raw_spinlock)(&gc->lock);
+	guard(hard_spinlock)(&gc->lock);
 	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
 	writel_relaxed(done, base + PMC_IRQ_CAUSE);
 }
-- 
2.43.0
