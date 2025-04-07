Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4B1F4193
	for <xenomai@lists.linux.dev>; Mon,  7 Apr 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038201; cv=fail; b=DUT8H78Voge7Om962REwgNYepHlKMnXzwk3Qa08zqliycpcQ5t8XPUrmAHsZLwY37erezMIkZp+zwjJPXgjjxQmGcKFU1yzF+x0TUndmp3Tb4XJn7a5pjm/cAvj6jLgYAxIuypypgP9rmtyLeody466Kcs0MVGU31nr37Tfnk/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038201; c=relaxed/simple;
	bh=7kRwlmuuhIGBHYSBNQSdKkZNynqSxuQxhIMJnIpfg8E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=rm4BM582oc2+lRm7CyVcoAYy1EkpnC9QwCuoQRG/wxTOWB3FUEh5WqwEokzrYbYLgPeZsDpRZGNKXBsf5NnHUDPYqfaeBSZIyhf4h8dat17ICEXQA0OFh2IczBc4gcFFPTporLmZlnDe+bWrIMrkCceC7tuW+J/PAyj5+bRxlqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ve4or2WW; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ve4or2WW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAjLcErukV7Wo5LN9HbPGV8LNr971/LuewwzyCi7h8N9sLgXV4zA7+lapVkZTETPq5YQfQxzJNwDGUwEqvKpAOVlG53kb5gSV1+BdXJGmoUiuDaFhoMIHM+ne7u+7+499pVUIgYSFawEfKXenO4jXsrbzxLAZgovLjp1DzPQhhwnpfqWFuRlIqmlZnLQ9mgUqY5uSksDPqdWWXwFY/b1mmHiwxIwEEdCXp4A7GrSTiCK6BJW08+NWTlOWHFPN8U4XJW43bwYqqdaQ3SJUIVW+7ibLAcINHfnfbP/452kM6G2WkOmQmR9Dqk8rJKYwk/z37PRTaxPl6mAcwuaYS5GbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t/4XqOTOiTsQ5I6z7xS1M8VDPdRSfSpj2HdhJ3unXI=;
 b=ngOF4ct9AraGSZTCVJy3P2QOxFtXVi2cg0bzRT0YH5bbZgV1brV3EIlhB1XyZvAXClQCtBxwuisEejJoH7YniWRAxUeRpztFqcy/D29Hr9//BAcNEH+BUD6LIN0qePus2dV28psMvUzJ3YlEPHgpfub69ci8iNLiAeH8pQOOY1VSgpVKhnSDwxYsYVN+XzZNJ9qah2XmXKB/utOdrCHk6dDah+8ZegazhaNP6xFF9y+eahyKfmquAPGJvlRiEmZFsEL2DaWclE9Db1vHKCcJJwyEG7OjK0NaptcaiV4ItMO5wkbWD4hWnnWwg1wSdq3TSNfDPXZ2XyV4WG9z8fvKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t/4XqOTOiTsQ5I6z7xS1M8VDPdRSfSpj2HdhJ3unXI=;
 b=Ve4or2WWpRbf1w+AV6DI5mZgwbtlDG8ZGtiVTTt5tdVCLP9RUeF0PikAqvZRLtYSti3KxHx/0jESzGmGpwiKPFYxRFHLF2OcWwf5GQhrPvMwn3mywcxFJWx8JkKgekiuHrgBgHG3IRA3s4yPANhxPV2SJJHV/K5gDyzD8IFQJsjwlf19tOXnZVhc/KEes6AF4JJmijpe6JR5lJjexHjA+FCRQdkG06+XcjoaxvliLNulFZy9tf3AbodCJvDF7vg0jUE9b5s1YWCXFtt6sg/JO1LNojA8MdhL+Jc7JFnCP5Uf8gfn+VBGaxD7wwybO7m8vy7oIuclgSxo/iYmfV9dlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 15:03:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:03:14 +0000
Message-ID: <1a0d38d1-00aa-4c49-a3d5-6a443e1c6a84@siemens.com>
Date: Mon, 7 Apr 2025 17:03:11 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH stable-3.3] kernel/cobalt/posix: Stop supporting timeout
 parameter in recvmmsg by default
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0738.namprd03.prod.outlook.com
 (2603:10b6:408:110::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: f664c37a-4c9c-4837-0a3d-08dd75e55248
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnpHa282ckhPc2QvRlVqeWJxVVBudE1saldGUkJiRndyQWV0OXhTeHkyV1Zv?=
 =?utf-8?B?RFdFRmZkTUlUV1NjbEk5VmluSzlPY2dlNnhlSDdpd2xXazlpS053aE5sanFJ?=
 =?utf-8?B?OXdLMjFiZmJjZGhra0hZMmRGbXUreDQ2OWNKT2s1Y29mQ1BSa0k3MzRaWnlz?=
 =?utf-8?B?ek0xMDVRRGlpa0xBeHQwNmRkcVJLSGRaQWVCcGpGZGN6eE90c3RzUzJFcnI3?=
 =?utf-8?B?YitFcmN6eUJFdU5vUUlNY0RVbGZBVDFySyszYTRLTm9XRzdSMDRvOVV2NHdW?=
 =?utf-8?B?cFRBd2tCWkMvb1BJbjljOFdFSis3cVNkc2ZpOE5KQWlpMXJraWYrcmxEV2hB?=
 =?utf-8?B?TklXUGFhc3ZqaU9vQVplOUVlWDZSSXBIRUhnUmR0enJqSHlMdGhkMGJyMDlS?=
 =?utf-8?B?QmVPUGJYV3REaEV1MGRuNkF5Q05pcEZsbU1zZWxDTVdiajRmbGtBbzZwbDZ2?=
 =?utf-8?B?ZzlucHppeEVvWnVsRGpDQ1ZNaUtEeUZ1aXpGbzZseFBiTVFqWGEvZzhDSUpC?=
 =?utf-8?B?TmdQZHFtRDBaaFVrOGJkQm5Hc0NLZFZYekI3TXAvanJWNWloMmlBakRpaXlZ?=
 =?utf-8?B?VXEzWWJNMXJrNVZaY0Nubzd5algxK0VVTllwZ3p6dWw0bXM1S3FLdVJRUEQ3?=
 =?utf-8?B?SkkzazJaaVBhdDFwUGx4aHVxNS9Rb01KdVRMcmNyUE84dGV6Q1RBN3FpZVcw?=
 =?utf-8?B?L0JFZWhEekMyZUU3bjJCK2Rpeks2RnJjR012NmVmMVVHakN0M1RERlBwQnRp?=
 =?utf-8?B?WDZ1R1dSdXlVbC8vdlV2R1JJSHVVN0Y0K1hZaGxVSjBleGoyWHBnVjVpV3M0?=
 =?utf-8?B?QXBIdEozOTdKam5Kc1F5ZWxteThGSC8zMWxPSGlQcGVRNWQ2ZHJ4YWFjbUlj?=
 =?utf-8?B?WWg2QktQL0hHZ3VTc3pyMzJUNDc1ejNsQ0tvTG5HQ25qUjIvZFdXYnhMejdk?=
 =?utf-8?B?cC9jNEpxVjlMKzBVUnQzeXZpOVYydE9tYkg5T241Rnk0Uk52ZXJvOVo1ZWVw?=
 =?utf-8?B?bVUvNDZWbFRhU0NLdVFTQTRjZzdYQS9aK2lvR2xJa3p3ZUJWSmlLWmx6WlJI?=
 =?utf-8?B?NW16SUhxNHhIdEU5eXBRSGgyS21Gd1NUaEREV3lhcStxRFJGWWJPRDhkb1ZQ?=
 =?utf-8?B?WVAzTG5ma1FVMVRIVVdkYjR0RkpBSEF1NWIzM3I0UEJoZjBicnNWNkh4SHRP?=
 =?utf-8?B?bnp1MjViOTh1TTZPZDNUaFZxU0ZUZWFQZHVseHBxeDd6TEtmWnhmZENjRzVI?=
 =?utf-8?B?SksxbkpLUjJWNXhGK2dKSURiTmhGcVAzbmlrMHdkUHNFZjgzMXJMUXg3TDVL?=
 =?utf-8?B?RmFqTmhUUy80RElsSm5jY1U1cjNZYUhtTWdTaWE1NWNQNy9jelhpQ3Jqd0N0?=
 =?utf-8?B?SDFlMWR5dUJ4V2lIS3FmTTRqOVF0eU45aHA5ZGplWEw0NHNOdng5WUhrS0FJ?=
 =?utf-8?B?NzM3VVl4S3NKRmdVRjN4M3N5VkpKMHh4YmUxM0RnMXl4T2hWVHp5RCsvNEVP?=
 =?utf-8?B?WXUyczhBdHZhUVMwNXcyUmplVEMwL1BkYm4zc0FnKytzMkpaY2Y1TVpIdHRQ?=
 =?utf-8?B?c2ZPanBRTnpBQjh2MVh6NFhVMEZYVitvQVhlcGxxdGRPZGVkZXNKZi9aanZF?=
 =?utf-8?B?bi9xbjRKNnZzVUE1Mnp3QlV0YmgzMHh4b3dxdVdnMXBaRTNDUjVVVmZ5WDJy?=
 =?utf-8?B?MFhaS25MZTF4NFhwQWtMYVhmU2Y2a29PcHhPYzMzRVBMbi9ncmt6elQxK3U4?=
 =?utf-8?B?WC9XVU1taWM5NkRHRXN2YzRwcm53aWlyZ1hEdXBaazVYcnJPbFV3LzM1djA4?=
 =?utf-8?B?cS8rYXA4T3JzMlprV2dvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OSswby8rSEluS3c1eE5FS1lNNXFwTkFzd29GM3NaNXhiTDhaMHBlUmV6MHpE?=
 =?utf-8?B?QXVMUXpnYXhMQ21WVXBENjJVRTcwcHY2Q3NBcUtzdkpxRFF2MXo0WE1KZ0tF?=
 =?utf-8?B?cFMyM2xKMmJLbTVLV0ZkT0NyazNMMytHTlhvMGNWMEhSNDlha3BxZExKQUF5?=
 =?utf-8?B?Q212cWtNZmVNT3dlUmh3eEtNaEoyMTFLMUxNVkwyTmJxT3Iyemh1SGkwbWtw?=
 =?utf-8?B?Y0ZxdFRWWHlvdmJaMk8wZFNVeDhpdlpDdFRKbVJGeENzZktYdkVjanhvRmNT?=
 =?utf-8?B?U1FHSWx4M3V3V3BkZXRZK0w4dTRPVWkxOWhZUWFvWkJyMnZPYkx6Zk1sblUx?=
 =?utf-8?B?WUU5QUZYNXkxbjJrQ0VwUHBYT2EvR0I3TzhiSHRhaUFFQUp4WTYwancrUTdD?=
 =?utf-8?B?TjJjaUdHcnFsR1lIQ3I1YW1GZi83SVZhelh0aXg2TDFYZTZOclF5UkJCOTlV?=
 =?utf-8?B?Nk50SzlJY09WQzlldmV3bW1QTjMxV1pDVzA3REVoRU13YVVGcDYzczVPZW13?=
 =?utf-8?B?Vy9QTGVObUdrZTIxbHVIK24xdENsK093cjFwKzN4Z2VVWkpmVnIwRVU3eE83?=
 =?utf-8?B?UWRONHQzYTFqZmNBM1dDL0Q2RVVpTGo4YW5YRTBxYXgxR1RaclVERDlIN3Fj?=
 =?utf-8?B?ejg2NXRDb3NzVDBPcGh5cHhrbDl4czhGZW40YWtMVEdkaTVDZWhVclVDTTZm?=
 =?utf-8?B?ZjhWZWNKdFo1OVdWbWx0dkdDS2ZGQmdDcjljNmhob240cFYyVzRFUkxZczhJ?=
 =?utf-8?B?YlU1OHh3M3JhU0hhMFIzMjdQMk9QeVdCeXVmcDB4cTZqTDAwM0RSbksvRGtx?=
 =?utf-8?B?WnR6Qm11NnNNYmYvQnpIZldYTVBxcWw0alBFVldvRU8xb3NCRnVGMDNzUC9x?=
 =?utf-8?B?R0dVc3FLeVNXSzFPbjNHNEh6RlZkdm1aeElXV1FaaVViRVgxRDkrMGhiNTZu?=
 =?utf-8?B?ak91S3VxLythcXpKcEdzTWcyQ1J1U2ZPYVh1TUNJVEdsTjFrd2Q3RzJuRWxy?=
 =?utf-8?B?ZEl1THd0elY2bk03ZmVYNStPMk5sY1R1R25Tei92azR0aTZXVFBpOEtjTVRl?=
 =?utf-8?B?bnZzZDAwOXBmZWpRdVF6OUl5ZHhQVXEvUXg1K0xtSXBWUVpuSWg2RjJwaWFZ?=
 =?utf-8?B?S3p6UTVqVC9kYzVpYUxJVkZvTlZ3c3VLc2JTM3FzU3k3UEFEVXF5MHJMcldU?=
 =?utf-8?B?ckVDVVdwZGROR2xnT0tIVW5TemtMUlBIZkRQZC9SSG5OZk13K1hSdjkzbWhL?=
 =?utf-8?B?MnlzNGFrWGpFMjFHK1h5cWk2QUJJTDFYWUhsNklPaHg2ajZ0RFdDbG9QSnVi?=
 =?utf-8?B?QlpsK2lOcjZOOHEzc1FsRUVNbmJoM2lUczBKSXFVeXhUbUFFZEdCcWJZY1c0?=
 =?utf-8?B?YUZ0REcwUldSZmloNmY2MEtTVkxhWlczRmI1QnpzZk1zK2xvUjc3bG4xTm11?=
 =?utf-8?B?SzcvTTczNzhITTdWSXYxUlYyQXl3WlR6RklvMHBJclhnN1FJcHZYWUNsSklP?=
 =?utf-8?B?UmdlY1dUVmJuZVljWDA5ZmF3eUpuQ0NTd3lQNmxBbjFhaEJucVNjMXJVLzd3?=
 =?utf-8?B?SzJXSzl4eFV5RVBmdm9vbGk5UWg1cUF3RnF0MmVydWlxeFhRZm5ZOUFrZU8y?=
 =?utf-8?B?NHpmK3Y0MXpSZHVUMXpSaHJZdklYM2NUNE0xY2tmUmJVeHZnWkRWTXFYTm9s?=
 =?utf-8?B?QkUrMUhSMEtvUWkwbU9QQm9iQzlyR2w1eHZIcEZnUXpFMzFqZXVPN2lDQnNR?=
 =?utf-8?B?QUx0ek15MVhWWTJDcXB5WU9XM0JoUElYSE1oTHJubThNUGFDOWRnV2NJdU00?=
 =?utf-8?B?Zjg5bkVsK0pJZWI1ckpod0xsYkpORHEwaWEwNDdRcVBxeldtVnVKVXNaVXBj?=
 =?utf-8?B?WXFqejhCVURvdHZzTWZyeEN3cWZqem5nSitJWWozVDBEVHNiZHE1a24zNGx3?=
 =?utf-8?B?Y3U5NEMvdXJlNFRsbWNQUkN4RXZMY3M2MUN0S0pSd2JmeVIvZjRBc2I5RDZX?=
 =?utf-8?B?NlZVNEQ5Z0trcUJBdU5ZYWxQTUJwTTF4VDBnZzFtUEN4RW5JR2RhNFZ5bGZ1?=
 =?utf-8?B?N0xlKzc1ZmFrZi9vYjJyd1k5eUlYanNlQU55dnFvZS92QlhDcmZPRll3cHV3?=
 =?utf-8?B?amMwaXkxRXBURHUvdjNWd2dkWWp0clRUK1Bla2VqVG0zSXNNZEVYblJzeHZs?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f664c37a-4c9c-4837-0a3d-08dd75e55248
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:03:14.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1qTxUASuRWbXhhHQOgzU/ZzW7519jwQ64S0JuEA5imS+xaq1O8RIANux7pvftsgFZWYG1hv1AjZAluczl3sWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5506

From: Jan Kiszka <jan.kiszka@siemens.com>

This is a conditional backport of 3d6121a5f5dc to stable, allowing users
to keep the pre-existing support enabled during build-time if they
believe they are safe and need it. Default is off.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

So, this is the compromise I already indicated: stable ABI inside the 
stable series, even if fragile by design, but only if explicitly 
requested.

 kernel/cobalt/Kconfig                  | 11 +++++++
 kernel/cobalt/rtdm/fd.c                |  8 +++++
 testsuite/smokey/y2038/syscall-tests.c | 41 +++-----------------------
 3 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 6ba4cdc5db..b7bce8914a 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -217,6 +217,17 @@ config XENO_OPT_VFILE
        depends on PROC_FS
        default y
 
+config XENO_OPT_BROKEN_RECVMMSG_TIMEOUT
+	bool "Provide support for broken recvmmsg timeout parameter"
+	help
+	  The implementation of the timeout parameter for recvmmsg may
+	  cause infinit blocking even if not requested. If your workload
+	  is relying on this parameter AND can rule out being affecting
+	  by the race, you may keep this feature enabled. Note, though,
+	  that later major releases will likely remove it completely.
+
+	  See also https://source.denx.de/Xenomai/xenomai/-/commit/3d6121a5f5dc5eee80945856fccadc6dd9e2e104
+
 endmenu
 
 menu "Sizes and static limits"
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d5813a16c2..eac577f73a 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -697,6 +697,14 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		if (timeout == 0)
 			flags |= MSG_DONTWAIT;
 		else {
+			if (!IS_ENABLED(CONFIG_XENO_OPT_BROKEN_RECVMMSG_TIMEOUT)) {
+				/*
+				 * The timeout parameter is not supported.
+				 * Use recvmsg timeouts instead.
+				 */
+				ret = -EINVAL;
+				goto fail;
+			}
 			timeout += xnclock_read_monotonic(&nkclock);
 			rq.waiter = xnthread_current();
 			xntimer_init(&rq.timer, &nkclock,
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 135f230dca..30c3317582 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -974,9 +974,8 @@ static int test_sc_cobalt_recvmmsg64(void)
 {
 	int sc_nr = sc_cobalt_recvmmsg64;
 	struct rtipc_port_label plabel;
-	struct xn_timespec64 t1, t2;
+	struct xn_timespec64 t1;
 	struct sockaddr_ipc saddr;
-	struct timespec ts_nat;
 	int ret = 0;
 	long data;
 	int sock;
@@ -1036,9 +1035,9 @@ static int test_sc_cobalt_recvmmsg64(void)
 	}
 
 	/*
-	 * providing an invalid timeout has to deliver EINVAL
+	 * providing a non-zero timeout has to deliver EINVAL
 	 */
-	t1.tv_sec = -1;
+	t1.tv_nsec = 1;
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EINVAL)) {
 		ret = ret ? ret : -EINVAL;
@@ -1054,41 +1053,9 @@ static int test_sc_cobalt_recvmmsg64(void)
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EWOULDBLOCK)) {
 		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Providing a valid timeout, waiting for it to time out and check
-	 * that we didn't come back to early.
-	 */
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t1.tv_sec = 0;
-	t1.tv_nsec = 500000;
-
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -ETIMEDOUT)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
 	}
 
-	t1.tv_sec = ts_nat.tv_sec;
-	t1.tv_nsec = ts_nat.tv_nsec;
-
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t2.tv_sec = ts_nat.tv_sec;
-	t2.tv_nsec = ts_nat.tv_nsec;
-
-	if (ts_less(&t2, &t1))
-		smokey_warning("recvmmsg64 returned to early!\n"
-			       "Expected wakeup at: %lld sec %lld nsec\n"
-			       "Back at           : %lld sec %lld nsec\n",
-			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+	ret = 0;
 
 out:
 	close(sock);
-- 
2.43.0
