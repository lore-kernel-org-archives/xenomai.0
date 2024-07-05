Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348533C7
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167052; cv=fail; b=M6a7b5v+JG2oSTB64P4830hOT7RYuDAhAEZ8D6YPt3QSdKKb/tOm9B9dzt/sfzR9d8E8hX2rIRYu8jpPgHDg3MiX/50pYY48Gb3Vio9GNp6Gv1xTItCAg5eKNJykJ6lA3i9+rTQadlGByQwD6PnDR4RcvyTIkLCh4uv72YQxQsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167052; c=relaxed/simple;
	bh=Bk+NuTYkSd3UYWmRaBNzB5B1mvabMJZtZrQA9TGIjeo=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=ao5eWzWSUOrlK6MStDCBRzD3/4fA7GIcNK5Mi3c3w/J0U/T8Ilr6heklAZxEPVTQn/fyOMP1T0D8Klzas02u+JWkKTuL8dGo9ryGJxk6ws7CL6VAjemjh9b0+7wbFLvZLNzmJTOBlqshZlZElZaGzXwdkuNhiBBqnHm4+MGeq/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QJZwsF+C; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QJZwsF+C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuOFK5JuKOfYpeMMQYWnx4QXO6GrXwRmbKGGayyUlMwt/mIyO12Ign4bdLn+tKBjuR5aw/kB1FT9DZcbod+PvyX41P86cnokHFvSOAW7B5+L7zoLAO+te6qC3RDRQk9TjbggxSsEQK4x7pJxAaorGcfZmcXW/Gcd8drqAc7JmpnTJDbUmp7LmFZHoDdT8cncfHadFzL7bsjv4S98Z8huidj0SxpyxCH2qOPTC6p90EsgPuVlZ1Mn5VZ9OyjLOX73w+LBJSdC1UzFcdHejJQ+uPCDAl864utvyByLEbAlejvi4XlnHIvlg2k3WI8N9Ga1uoVghqbaHqnjgY7BccheZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjuU+86KEe3h5s1OlEd5Dms5aYpkRA/NmFketTcdv30=;
 b=R2yKT1Y2UFaicJn7uUGYD7vqXtIN+mzu4QVqes9qEermicmpnDp1L7eMYl/1/5U2m3ySMUd+mqIlGuYAwwiQ+xarLf+5xj9j2judP1yXJCCOiPRavOfOqp+xLpumf3JZnjPGhafd3CcPkDL+dwRwdEGoDQPNRQLRBAY7axjazMeHljys4oTS662UD7bXVtEDLcHsLbtYMdZAcSBaiB7iaUe0IRiQzCkFfjBU+pBRwTv/1RYxZZjQmLq3UpWw1xSwpi0CjilWJO261uF391wpKPRk05aK1ArkbYHWKINRk/0fKtUQMJ4se32/fZReRv/5QUQY6hmlu5GAF4RxoYuGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjuU+86KEe3h5s1OlEd5Dms5aYpkRA/NmFketTcdv30=;
 b=QJZwsF+Cnu61qGz7zaMO4pcqdjlP+hDmX1BW6gK+q2KTeWp6D57CDtQvzcM/h0c8EHrwfgU1N/VQgZnYvmTfpnG+K7zCRJshnr8g23WqtGtHGx2ep/XStMmu0f8GW3XppqL9R+9e+GNqgo168VYlIJgdv04k0GLh+eFXSxttWK1LiYp3B1dgMawxeBaMjeQ2kKw0/yuc717dvp9LdsXlurVid/JQ+tRg6D2M7ZxOONia8wA7ZivxFTwc2YM9vrHUoOmMTjgz5mMrlwxWRGerCVuIrAQ/OThNhk/+ckjzw3SQfbMzSPstpG97P1kDPTfaWAGJ8xYHILAVRL/oHbJwCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:74::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 08:10:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:10:45 +0000
Message-ID: <ead172a5-f9a6-4334-b312-d79b6229cc25@siemens.com>
Date: Fri, 5 Jul 2024 10:10:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] tests: Drop lava smoke tests
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 1454e087-4889-4076-59ae-08dc9cc9f8ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGc5L1lRbDFlblE1L0pSUzgxb1JHVk1rdXpnUjNGbUtUc01RT2U4aU4yM2NE?=
 =?utf-8?B?RUVUaDdJUU4yYlYwMzkxVGRNWHlxaEdmOUN3aUg2b01PbS9kYTBrM3UvVTYx?=
 =?utf-8?B?RWdVOGFHYkp0OHFDVmFyM0ZiTU10VzJ3K0ZuUDN6eHBiaElBWm93NmsxRmlS?=
 =?utf-8?B?YkJFSlF4V0xtUEdPemJMS1ZjR2dtQllsbE1JbDA2TXZrU29TVjFFL3dPWTJF?=
 =?utf-8?B?SHJocXR0SUh4TXdLRDVqN1F0Ri9adVcrWGt3blQ1TTBhbUkzdENBSEZHSVRu?=
 =?utf-8?B?ajVJa24zaU11UU13RnVoMDc4QmdiWENtWG9zc3NnZnh3YUlkRUkzeGZqOFMr?=
 =?utf-8?B?aGQ3c0hHRStDQzN4VXl4MFZqMmp0SzJyYzNaZXhSeVRaTzJlc2xWTlp3NW14?=
 =?utf-8?B?SHUrNlVSYnVVTGxJOUVYZlc2blBLYUtQYWlkZlFYU25TTmtMbUhoYUFZNjdC?=
 =?utf-8?B?a2ptRGdPTXkwNmw4OHBIZ0NmQTVVLzFuT25uUkVUZ0pYWTN3SzFKZEZDYW56?=
 =?utf-8?B?Zlp5YlJtSUtlOWlGQldyUk50VzMrWGl6M0tzMDFyUEVkZHc4bm92dGR1N3g0?=
 =?utf-8?B?eGYyN0RSc09NaEN0Um5oMVlJeE5MbkZidE9pbWlha3M5YndpUFUzSGUyL0Z2?=
 =?utf-8?B?NHI0YkdFSzd1TnhXS3d1bnBwM2dIODRTQTNpRThJM09NQ2R4b3MrVEhsSTY0?=
 =?utf-8?B?N1M1dWNpYnlNcGNZNUhXeFRNK2h6eWE0bzZnZmJMdElRVVh2R2Nsb2s2cVU3?=
 =?utf-8?B?YlVVZThTNjRoeEpKREVkenJ1cDltbHVQM3FZSVRoSHczd2FYWkhtbno0YXpq?=
 =?utf-8?B?WGVNSmxPcE5JSEk4OWhUZCs5Y0hkUFN6cG95dWRZVThaZ1ZpSkY1Zzc3Y3A4?=
 =?utf-8?B?SnBRYlZDTzY2TWZVM1VpbE5ONnNhc1QwMGZTcjdLYXdIRE9lc1ZPV3VKMFRY?=
 =?utf-8?B?U2dKTWxQVHAveHN6MEdNdGRNN05wZjNhRjVMOTlpakNlMTZHbXJQU1M3NEov?=
 =?utf-8?B?ZElhNytTcUhGeEszZmNNQ3lmQi9pdnppM1BEOTQ5dVBROTA3UENuSXc0TXFF?=
 =?utf-8?B?R3NEenhaMWs3bzc5bGJMNnltazhEbXhuNDVnakM5OFdjWW5CRFU1aXBDRjBG?=
 =?utf-8?B?NndXQyswMXV3a0Jub2UzbWhMRlhWWkhTaTJ0NWpJeTV0RitvQ3h0a1FaNUFz?=
 =?utf-8?B?OUxwZitxeXFNTWh1Ti9ScjQ2Slk5Z21ZMmE5d3FlbVFwTmZJTzY2SkVQeE1L?=
 =?utf-8?B?TCtHcU1zd1VxQVBZbkVGWWNuUGlMTVBlWjFlYUpMOUVtSndTWTMveS90R0xu?=
 =?utf-8?B?Q1YxTDFTS0xFRE5SZTM1aEZLWXFtSlpWL0pQRG0xRXpKSFBsYXBsMFA1bjJU?=
 =?utf-8?B?WmxxWUVabkpyT0tSZlM0bS9TUFBYblpCa2lFU2xVUWFOOHVKUEphcVB3MDhw?=
 =?utf-8?B?SjdHYzB5QmtCOFo4NjFqcGxLR1dEbGx4bE9UQi9SSHJHUytJbHBNSjRJbE9q?=
 =?utf-8?B?OE05MU5yL1dGU1JiYkdrWURnTmhVZ2JxRHU4WU1qRFdTdnNibkF1eDBXWGhI?=
 =?utf-8?B?ZzMrODJadzB5RW1OMnkzZkpCK2tzRUl1TlY1MlhxTGFJc283VDJuUGo3a0ZM?=
 =?utf-8?B?dkZMZ0ljV2RPRDJMKytEOFhRMENxWnBCZ3BvNzJ4WDhlOGhLSFlRd2hVd2VY?=
 =?utf-8?B?bUdxZ1F5RGd1dXVhSXlnaXprcW9oQlh3dVVrUUVCcTdZUzNmdE1tNUJLVzZT?=
 =?utf-8?Q?PPqVYqUk5grmnxJYqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVhPT3NmSGY0ZmZKekRoOUxKa1hDYTQvMU9ER2ZHZ2t1d1RxNVhCWFA1aCtw?=
 =?utf-8?B?ZUkzRFltZktMckwwYWhzM1FNeDZLZUdnR3YyTWtZdUtGMEdzWFU0dWdzWmZG?=
 =?utf-8?B?OW1kck1LK0hXM2xyeDdYQmsvWnZNaDdOb0tTTzJaa3pwV0FWSGJteXNRbTFv?=
 =?utf-8?B?ejlFcGtXeHByTDZkYkIzdXlGWWxmdjhvZjQzMGVHVDlyVUZuaksxeEREWHpV?=
 =?utf-8?B?L00rdWc1YXc5S3FrZllYQzRVWGpyb1kyTUozMi9xWXd6a3hXT290ZDZ2SVlW?=
 =?utf-8?B?MHhkUnlVNVFwblFzY1JoWThoemw5dWRETHpraTdCUDdiamZvYVNJVE5WV0tE?=
 =?utf-8?B?VVFtOUZ0M24rK3VHR3IrTHV4YTFHSjRpWHNHRVdDd2JrZGYyZjF3b01vOXlZ?=
 =?utf-8?B?bXhsZWtkYU9tRnR4UFVhVjJVVHBkZHU2aHpoK3ZoODEwNjNwcnBBRGgzeXJu?=
 =?utf-8?B?ZVJENk1KQzRtS3NlSFZqY1hjWENPR08wMUt6TWlTbjNzeDhJblVnVktCaWli?=
 =?utf-8?B?YUNmNGlLc3E1SUdKRHJSOVBkYUJjTTVFN29Gajd6aUJpSUZleDdmd3pWR0o0?=
 =?utf-8?B?Um9nbC81NTRYTTdVY3lDejRBaEVkdjA1Qzdrak9MYk5DUWtjMzArMjJZdlFa?=
 =?utf-8?B?UVo1WndHV3o4R3I5eXlBY21jMXZsWjlNVHE4WlZ5MGIrYy92ZjVFR0VPdVRQ?=
 =?utf-8?B?VFVEVmpTUmtBYUVCUnZieE5oTG1ONnE5ZXB1TFpDdmxDejRrYTgwcTd0emJ5?=
 =?utf-8?B?S3hqLzNOSDMwcVZYU2pLQ2hqR0pwUkF2MXZPL3VPcTBCdDRvYWxGRGdpbmRw?=
 =?utf-8?B?bjdCU1ZJL2h3Q3pXWFlUVDNWaDQwaGtXYWwxSTJ3Wk1rU0RqZUkrdzZLdERI?=
 =?utf-8?B?dDFEV21zNWJDZ0lDYW9JRmNvd1VHZEo0cWNNaFdQL1M3UjFaVVdYQlhudUVG?=
 =?utf-8?B?VzEyN1l3THU5R3hiWWt6Ymk1anJRY1Y2RHQwM1FEbFQwYk1uUTFUS1FjM3Av?=
 =?utf-8?B?MFhTOC9kNEtOejFIWHpZY2tCRVZaeldkMlhYVk9pSm14VXMyMlROK3Z4NjFa?=
 =?utf-8?B?MTBSdUF3dnFMUEYrVlQzWnIyY3lwcjJtYzBwcFBqMC9idUZGQkphMjRYUUVR?=
 =?utf-8?B?V3daRFM4UUh5TUl0RFpzQXZCZ0p0ajB6ZFVvZUdIYXdDdDk4eUdZeGNFcWxU?=
 =?utf-8?B?YXFsaWdodTBpQzZ4bTZrUWx5YktPWXhBZ0hSUGZuaW9sRmNISzdlMkpkNnUz?=
 =?utf-8?B?MkgwTzc1Y3ZxUHp2VWhPLzE3MklxbVp0cTJTQW9mZ2hCbUdZdVBUODVOanMw?=
 =?utf-8?B?eXhDekZsSkJwbUtENGtWb2FUZ1FuWnZVRGdvUWNvblFvUW1hcXBzQ2hReTdz?=
 =?utf-8?B?VEh4TGN5bW5NUExvS1QvbHZScGZaaXVKWW5RUkljc25xN3g3ZG1NYU9NODdC?=
 =?utf-8?B?NUg5a2hyT1VQdTFwZjdvUlVDUExmeGJueUhqSWQxc004MUIrdDVsRzRaNm8v?=
 =?utf-8?B?U2NKTjVQYmJaU3g2NTUyVmVoQzNZRmZNSVVFYkU0MmJoNklBNXVYTWhRYWdO?=
 =?utf-8?B?d1dxVVRpb2dtM3AwemkySFdpN0Y1bmZCTFdhNDVwZE1TTUluaFhtV2FFVEFh?=
 =?utf-8?B?aFZ0bk84SnNERlRsK1RvTmwwdUxtWUo2dUExQkh2Z1VpQTRlZVdaeFJWSk04?=
 =?utf-8?B?cUdUMngrMWgwOVhOZTI5WHplMXBxVjBodHNlWXpkb0lMUi90MUpJeUhlVGdJ?=
 =?utf-8?B?eW4waVVLWTJLc1kyMlZodWk1WFJhMDVLditpcVBFVWY3SEVVOGVMdGZxSG9s?=
 =?utf-8?B?eSttRFZ1VFhkVkxISW9ra1ZISzZLZXlHbDZwbit0TWNzMkNxNWI2SVY0NWQ1?=
 =?utf-8?B?N1EySW91VThWbEcvaFQyOWlJV3hpc3Y5T1o3MTZueERvQXlXRmJpUFQySEZT?=
 =?utf-8?B?QlNWUy9OR1o4b0xVeXoxM29UTVFUMU8zM3poT0RYTG5QejVSWnlUYTJxS09Q?=
 =?utf-8?B?V0hFQ3VFdFdmZ2lpRGlyV0ZtOVdERWVucXY0SzBKbW4yVWdHS2RJSW51bzYy?=
 =?utf-8?B?QjhndlN4NGR4cG1EbDQrVDN5THF4Nm1EbDh6UnFYV1NlQkZibmhkalgvdll6?=
 =?utf-8?B?QVo4WEs2bjVwR2txNHZTNGRZNXkwY2dVRTRDYUNKekovaGNMWTVmYm94NFdO?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1454e087-4889-4076-59ae-08dc9cc9f8ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 08:10:45.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w/MYF1Ax0MOq846zdZHX51gt1B2jCvb6Hh+nXuzpzGDmuSNyF4QLcIRKJaizLV0BoYNraTn23IWxEZoYNbyUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6282

From: Jan Kiszka <jan.kiszka@siemens.com>

They do not add much value for our setups, and fetching those from
git.linaro.org only tend to trigger network issues.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/README.md                          | 5 -----
 tests/jobs/xenomai-beagle-bone-black.yml | 4 ----
 tests/jobs/xenomai-hikey.yml             | 4 ----
 tests/jobs/xenomai-qemu-amd64.yml        | 4 ----
 tests/jobs/xenomai-qemu-arm64.yml        | 4 ----
 tests/jobs/xenomai-qemu-armhf.yml        | 4 ----
 tests/jobs/xenomai-rpi4.yml              | 4 ----
 tests/jobs/xenomai-x86-64-efi.yml        | 4 ----
 8 files changed, 33 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index c092d54..c3f05cd 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -28,11 +28,6 @@ Currently the following tests are executed on each target:
 - lava-smoketest
 - xenomai-test-suite
 
-### lava-smoketest
-
-The lava smoke tests are part of http://git.linaro.org/lava-team/lava-functional-tests.git
-and check machine data from the target.
-
 ### xenomai-test-suite
 
 The xenomai test suite executes the xeno-test tool from xenomai/testsuite.
diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 9a4acf1..17e807b 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -56,10 +56,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 4b2c033..8489594 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -55,10 +55,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index b989576..62a268b 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -72,10 +72,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 5bf513e..9ce451d 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -76,10 +76,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 1ab35bd..070b801 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -72,10 +72,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index 4416a64..627deb5 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -55,10 +55,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index d71b5ae..f4f631a 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -56,10 +56,6 @@ actions:
     timeout:
       minutes: 30
     definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
     - repository:
         metadata:
           format: Lava-Test Test Definition 1.0
-- 
2.43.0
