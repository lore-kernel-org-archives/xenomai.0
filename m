Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D61A0BF3
	for <xenomai@lists.linux.dev>; Wed, 30 Jul 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904388; cv=fail; b=GilRVEn031tKLdJ/Pt8T34HFweWmB97RHVoRpii8yMC+cxZQZDrSV9gqEx/58nH9eDJa483jeIFwwK3KqSv8hMH37fjucQtzOh7K+sI+01IwQlq5c/KsBgC0iHLSEPf5LhwWXTh2+/yhMzpiiDRIbk6yFjwE15DTa5ykGdjjAVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904388; c=relaxed/simple;
	bh=t8tQcoSn0JtsOM9e2NX3jacZSlLeYkuB3UnqGagvWCY=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=GbS8hJS495+IyMmoiCFQ+LPS9vRfRN1C0B/1hJbvZBItJ5KUmTiCwklE6VeyReevawc11amn+xaeJZPSj6J+oX2u30K+1eekd3uNvMK9GEs+h8ZfBbseL4cFrSyWtOPhWbP1Nmu+IfM5XZbYAwRK/v4lm5Ptvy1YjJAez/CE0Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Jpk0SvON; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Jpk0SvON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt6YJnZZXeGlkOUI4yg2PJ3S0WGpyveM3J9hSTedIaI4G1WMdhL2OkmLY50/RIBNH6wbDGcwBaIR7ORyRl6yZCQjqd9xCx2wnHb5sKGUjMw7lo/cu2U6mbkQc96veNhDsjte+I4Pp23HGE6P47WG4eBkMCYZJX4z6r9foY8jxrYkEhJo0KGpvESJ3mtnjwM2HUNkFudyB0jthEFcw3orf3aYbKaxudZqQXc+ff1Gf492fP3FXzOS5Xu4wNKbgnAC6gr/E31jW3N8cpHTvMnOf7uLtU0JFNzszJ085KUWe2lrYZ0TyWlmG3f/NTGdxpIGbwj8y75xN0l4Vsm+ZwnFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNaKrMkdwc7tBV6Vyiv+MMS9eV8rbn0e1lYDcG4vuy0=;
 b=lsicUr0oa6Y3bwyzZ95QO8KUrin73mT1qXWzbBFSTYegiXCPQ7YAr+0aqx0MpPnSgShjWKyrQYFI28IT931fYgTgIKHBo/YTPTdKCQonEp9mlTghnMJzStN95iWdqG0PmduqhslViuK7LJJO21o0uoBOhkOi6cfP0nLq7SVmZyoH81MxoJlYPfC4GSLrrE3q6Ut/pVX7Vlh+PvCPshB+nWNLOGqvaoKFUlLKU5oyf8ssGhGOibm3P+tssjepJYYbFv9Kz/FIxKoFCmchNCZcn50zW+GbnktOS4mvVfnPep/0/iuXdOCKT5dpMPe0A0tcBfa6S9UW0joiSvf8DeUkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNaKrMkdwc7tBV6Vyiv+MMS9eV8rbn0e1lYDcG4vuy0=;
 b=Jpk0SvON7Bjzc1XQlj1wiXiWZ+gWliM0cFJFbthxLD33LWmJ5jfrske3iWpX+5OEcS4Gq5T1jLnNTdygku+qp9eyyTHcfRqv1aaEcDsRW9DkKCvhDS11oUz8d25dkyUv9DfjvVFKHL7S2+2bot7wuZo6C2Aw2TCpIrYy42FUPXyS66qQ1xa5GnpeocuJuGkjwz7D8fYswsd3TjDR8aO8NQeLbnv2ppvGPWssspgs2pe9KO0IlIpNOXZhw5+BVUBL5Wm/KOS+q1RZnBjPaGAREBdblY5O9iHK1u/fD25MrAB06+4O6+yK7SFZvZTZnFdlLTfScMSv01M8hkG5IPqvbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:39:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:39:42 +0000
Message-ID: <46703208-74b1-4531-8112-064a11183f62@siemens.com>
Date: Wed, 30 Jul 2025 21:39:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers/net: Account for renaming of from_timer in 6.16
Content-Language: en-US
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
X-MS-Office365-Filtering-Correlation-Id: cd76ab63-e865-4e5e-aaf5-08ddcfa0cf76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFNXL256b3hxUHJ4WFRtaWZybytCOTVnVkZaTnJ0aHhhMmM5UlVTTmZ1NUV0?=
 =?utf-8?B?bWdmdU9XMDQxMjVFa3gvak1oVmxVQy91SEVCUXF5U0Ntd3J3ZncyMEZ3RzNJ?=
 =?utf-8?B?NHlvQ1VYUzFUWkNWb09hRndmbVJBelExdFJSaGdrb0c3N1Vud0NZbFN6VWJT?=
 =?utf-8?B?MVl5RWQrVnppTW5ScERPcHU2bS9VWDMxcFNCMkxZUGJPWWluK3d5ZFgvVjEw?=
 =?utf-8?B?MTRIRG9QSk9NR3lhWDl1MWxnTFlKMGxTamVVZTR4bHNXdWhpTS85OHYzQk9H?=
 =?utf-8?B?MkRkVFBRZ2gwcTFzZ29FejBWQ1NuYXJaRkhRbk5UV0hPb3ZmMUoxVElZQTFt?=
 =?utf-8?B?dmhDTDE0SWptWkxmNU5vUmVWWkFMRSt4UGVwRkQ3czRDQTVBTlVId1dNNldX?=
 =?utf-8?B?NGtSZEpXOWZZR1R4NW1INmEwVThjTEVjQTVLUG94ejFsUmg4b0hIK2h4TVdn?=
 =?utf-8?B?aDBSaSttYmZ3Z1hlVlhHVmpCVSt5c1NXSjZSTm5aOGdyM3dRMElWMThQa3h2?=
 =?utf-8?B?cWI3U0dTS2gvaHEyT05EM3VjbzFUVm9Gc2RsaTN3cUdsQjBGQi9NMEM5OFBS?=
 =?utf-8?B?ejJuVUdVL0QzNzBEWG82UVlPSmZJQWRKUElhSWloTDJTaldSakJ0UDUwcllX?=
 =?utf-8?B?aHdUbm5jMTA4QitBbkNmaVVXZ3ZWZEZUejVBVUdwS3hCZmNMZTltUEZ6elZR?=
 =?utf-8?B?c0lvbjVrQ0JVV3VYMDRGbXp1OTdmUUhSb2dZUHJTM0sxdnNoVmY4aTFKYTFW?=
 =?utf-8?B?ejhEa0hvMUhHODhQMGwxKzVSbU4zOVJIWnlkSUh5WE9YZGFCR1RxVFQ5Qmt6?=
 =?utf-8?B?RGRtMFNQOTZMbFd0Q0l4Tm81RHVvQ3ltaE40Nzh0bHlScFlQYTBpR2Vra2Fz?=
 =?utf-8?B?bXl4RzE2ZWJMdlN1cGNXTWRjd0twTGw1eHBBc1Aza1ZXdHFhdkdyVWc5enJQ?=
 =?utf-8?B?Yml1Wis3RnE5VmR4S0FaQm9GblZ2RnJ2TE93LzdhVnJPby9Tb0R3VWFNdXdz?=
 =?utf-8?B?dGRXc1Fmc0c2ZjZoRGdnSGJxdCtNQk1qMkhrMnVnZ1BqUDlIQlhGdjlRRGxB?=
 =?utf-8?B?V2dSeElFVGVvYm0xYUxGSHRCRUFGZU1LM21xc0xoMW8zcmZEMmJDTlJLL1lM?=
 =?utf-8?B?M2M2N1JKNytqRGN1dlF4bDZ5VXpjUDBpTHZXdkUrVWNTN3ZHbmN5M2F0Mmxu?=
 =?utf-8?B?NWJweTBJcXAwV2VCaVBwdkoxa3VuYUhmdlkvOEdBLzdMNlRMQUNLN3dMWkhl?=
 =?utf-8?B?R201b2k5cXVZME41VUJBMG1WUWpxaEJjbDA4am9IWlB3M3RhOUd5dTNPM1F6?=
 =?utf-8?B?b2NhaGpTZEJQNktLRnhzeXYyTGQxQ1hFZXpvdUlHVFY0dEtLWDlsU1RYM21O?=
 =?utf-8?B?Snd0U0twME85bEFrMFJSRG9Tb3ZSZGdRdktVUC9jTGdiR3JSamhoUURkckFM?=
 =?utf-8?B?LzMzTmU5TWdyOEJpTFo5Nk8wM1Z1Qk5nRk9qc1RXTXI1S0VYZG0xd2txUkxa?=
 =?utf-8?B?MVc4YVpGeld0NXlicWtxSWRjUjVWNnU0NVVrMDlqa2VLNlBiTDhjNEZFU0hu?=
 =?utf-8?B?TXBNdjQ3elpxcmtXa01JaElaZ0hsQmNFZUd0dW1FSzBQOVh4MjFiQ0huaXA1?=
 =?utf-8?B?T1krZHJ1Zi9WRzhQZ0UyOHBhZXFVYmZpaUsxYmZYbEpyeTREbWxNeG8rbTNJ?=
 =?utf-8?B?TElkNHRMWXdzWWs2ZkZqZ1podC9jVXVVNmh0VnI2bFgwZUVicmpwaS9lVWJO?=
 =?utf-8?B?S0ZXTnpHZFY2enpiMWZ2L2JGUlhDTGJIMThkK0ZJNXJsZWpWc3NXZXljVlcz?=
 =?utf-8?B?bUtzM2dyU2Zsck5FN3JiT0hCRXZQRDZ6S2FVbGlTRHd6a2pvVWdaTTh4b0ts?=
 =?utf-8?B?dFRhN3F3djBPRzlEWFpITVhTSDNDa0I2WlRXVlBuK1BPeUx1NjY5dXIrd2xa?=
 =?utf-8?Q?7eVhDJMGSVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlZ6OFJ4ZG5hVVZhTHJXQzNHc1kyM0VRTHNIdUMwOHdVUG1taFluK0E3QWlo?=
 =?utf-8?B?T3dTQ013NnZXKzhlbXRlaGxuSnF1bDhWNWZneG1pR29jb2JZa3NIMHZEdC94?=
 =?utf-8?B?cCt4dC9JT0hYU2xKcUJZdFAraGdnVFMrOEZsRFdUUzN6NkZZTSttVVBTcU9t?=
 =?utf-8?B?RGJ2VWJSeHJqUlBoWS9BWVQ5S25JbWVCMWNDSW5JalNyWFRPWWNWVzVJc2pn?=
 =?utf-8?B?MjlPR2ZJeUxDUGZEZnF2V0VkeEh2aDNDMHdqbTh3eEt5REg1RzVoSTY2b2Q3?=
 =?utf-8?B?TXEwRkY0Z1hEZTFjaDdRaGE5RmdqK3RmQndqOEdxa3p1TG1yUVFqbmkyY1BM?=
 =?utf-8?B?MmFkeTdhbVZzMllNWHFKQVdMaVJuTFA1S3RXMVAvNUEyNzE1RExtblJ5M2lx?=
 =?utf-8?B?dDVtTWs4ZmNZMkdaNExEQmx3aElPQ1lqempUeGJtYUxoUlpJekRpUkxFckNH?=
 =?utf-8?B?SkJyZ0IzK3cxVWtUWTFOMWFta0VJalBSNDY0MHlMR0VHMVZiN2F6YWhIcURn?=
 =?utf-8?B?akFZZ1BYVnp1TTMybkxvYzl6N2lBM1RjYncxWUczQVV6bDVUNTU0VjNyNGs0?=
 =?utf-8?B?VmtHWVRXSXZIYXllQlRyS0NRREFmQzlYaE0zYjBZUHJKa21ZbzRtQitBZ0tp?=
 =?utf-8?B?dDhETjFHV1RWdUp5VE1uV0YxT0NycGJhNEl6ZHBmM3JBNkdtQlNSTnQ3dFZp?=
 =?utf-8?B?WDI2bzdiMncvTnptOUNyaHhpcm1kK2M5Qmw4bndIcFRDM3QvT1kwVnZ1Q2pQ?=
 =?utf-8?B?SUdFR2hxUVBxTXlqeUkwWHpxMFFOalI0WEZCU3h2SnVSZTRvekMydERWYW9L?=
 =?utf-8?B?Zys4b0RtelBSWno5UE1FL3FSL2Q3SSs3a0hnWXpHVXhUcGVqRUJFdysybnp2?=
 =?utf-8?B?Z2JPdVZORkZtNWI1Q3lNTDZ2VG16d3o5RGg5dWd6Sk1yNGVpcGZsN3dIdS9C?=
 =?utf-8?B?L2s2d2Zld1JDb3c1TGhVOHA1TitvekxPTkE0L0R6NlRXbi8wT05ZMVV5cVBV?=
 =?utf-8?B?bUVOWHRVVW5CL2ZsSlM4R1M4UG0wUG5IM2R3QTNwcm9wamlRalpOSGJLMEIr?=
 =?utf-8?B?ak9NSDM3ejNFMTYwSUd3NFprUnAxOXdWdUV6YzhXYlpKdC9sTzBPY291VXdT?=
 =?utf-8?B?QW04TGpFVFRIZkFUSm9ZYm5RSENhblBHUE5UMGFaRXNXL0V6MlNPc2xiN01n?=
 =?utf-8?B?NmQ4dmRKaitJemtTOCtic1NHTDBCeXRuaTB1ZUplMkNCQlBJYWhjajFXNnBO?=
 =?utf-8?B?bE5zWVR0V3ZwbmREdmpHMGhnZ1p2eDZwNEVseG50WnB5Y2RRUDJvY1FHWmVp?=
 =?utf-8?B?blZDYVFhZ1ZYdnBBbCtPNDNZL1ZUcmNVRGpJY0F5MStmOVpmQ1drSkZ6RXov?=
 =?utf-8?B?MzF2aE9PZ2lsU3gydm9GK0ZzSklsSzNubXdybzRvQ2J5K28yK3RmNDMxMlcv?=
 =?utf-8?B?RzBWZ1k0V0xUOXhLSStSN0lZbjBMVm96OWN3N1NJYU9hK1F2R3VLcDM5aHhv?=
 =?utf-8?B?bTNiQTJ4Y0lXRlpMS1FqcWttSGdaK2szVDhqZ2tRcXRxdHBSRURSOFRCdU45?=
 =?utf-8?B?TXgvbGN4dDV6eXpjdUlWdEt6SmJnNGYwTVhSSWZuYXZPR0k5bjNkY3VaY0Jl?=
 =?utf-8?B?Y3BrZlI5RnR5RUowQ3R4Q3FrWFdFcHROQ0xZN25DaWx4ZEFmNFpLSVNIczBw?=
 =?utf-8?B?dE1xNEpDd1lsN2xtNkZ4WUpTcDZ2cDVFYVRjR0ozMHZnUjVnNTk0MXB3U1F4?=
 =?utf-8?B?ckpVZFBSZGhySEhMaEZzNUYrT1NQQjl5NExuelhYRUo1TllWZ2pzbWc4TEo3?=
 =?utf-8?B?NDVyd2xHc0xlc1lVNnB5Qi9QTWNsSDlJZzNrR2owZHZubnlxTHVsbXpYVzZM?=
 =?utf-8?B?a1FxNlNSR2xkdWVqV3FoTjZINW1WdjRzbElpTnhuVkJCWHFiUkF2Rmtab20v?=
 =?utf-8?B?anFuUmVaay96TDlhMlB0aENHTVpRWTVNc1RVRkhXdHovcmNXMDlRcG1xRGxJ?=
 =?utf-8?B?NDFkSnJ0YjMzNWtHNmJuYlZKa3IrYjlmOHIvVEVoTUpqTkpkcHVFM0RPV0lQ?=
 =?utf-8?B?bFdBTnZvVi90bW5aRTZoRzBUVmZKRzZ3YWdTb2IwRitZQUtsVHdlN2k1dGVj?=
 =?utf-8?Q?opcZ6699b+S8KfYGgAHusAcxw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd76ab63-e865-4e5e-aaf5-08ddcfa0cf76
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:39:42.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnXmA61B4wAk7PNmdn6a8WDOiW2DUnTKE5iHceO5g80hjdd0m2MIwfYyZtF2hr8yYBqCsd8k/3Lh+rWBVht6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5628

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/drivers/net/drivers/e1000e/netdev.c           | 6 ++++--
 kernel/drivers/net/drivers/igb/igb_main.c            | 6 ++++--
 kernel/drivers/net/drivers/igc/igc_main.c            | 6 ++++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 6b488d0f26..b611c405c8 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -91,4 +91,8 @@
 	(__mm)->get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,16,0)
+#define timer_container_of	from_timer
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 882d731804..0679688e20 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -2866,7 +2866,8 @@ static void e1000e_update_phy_task(struct work_struct *work)
  */
 static void e1000_update_phy_info(struct timer_list *t)
 {
-	struct e1000_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+	struct e1000_adapter *adapter = timer_container_of(adapter, t,
+							   phy_info_timer);
 
 	if (test_bit(__E1000_DOWN, &adapter->state))
 		return;
@@ -3011,7 +3012,8 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
  **/
 static void e1000_watchdog(struct timer_list *t)
 {
-	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+	struct e1000_adapter *adapter = timer_container_of(adapter, t,
+							   watchdog_timer);
 
 	/* Do the rest outside of interrupt context */
 	rtdm_schedule_nrt_work(&adapter->watchdog_task);
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index a91f8a1de5..d757396479 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -3514,7 +3514,8 @@ static void igb_check_wvbr(struct igb_adapter *adapter)
  */
 static void igb_update_phy_info(struct timer_list *t)
 {
-	struct igb_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+	struct igb_adapter *adapter = timer_container_of(adapter, t,
+							 phy_info_timer);
 	igb_get_phy_info(&adapter->hw);
 }
 
@@ -3604,7 +3605,8 @@ static void igb_check_lvmmc(struct igb_adapter *adapter)
  **/
 static void igb_watchdog(struct timer_list *t)
 {
-	struct igb_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+	struct igb_adapter *adapter = timer_container_of(adapter, t,
+							 watchdog_timer);
 	/* Do the rest outside of interrupt context */
 	schedule_work(&adapter->watchdog_task);
 }
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 9c435d364d..29501b6108 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -2849,7 +2849,8 @@ static void igc_clear_interrupt_scheme(struct igc_adapter *adapter)
  */
 static void igc_update_phy_info(struct timer_list *t)
 {
-	struct igc_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+	struct igc_adapter *adapter = timer_container_of(adapter, t,
+							 phy_info_timer);
 
 	igc_get_phy_info(&adapter->hw);
 }
@@ -2898,7 +2899,8 @@ bool igc_has_link(struct igc_adapter *adapter)
  */
 static void igc_watchdog(struct timer_list *t)
 {
-	struct igc_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+	struct igc_adapter *adapter = timer_container_of(adapter, t,
+							 watchdog_timer);
 	/* Do the rest outside of interrupt context */
 	schedule_work(&adapter->watchdog_task);
 }
-- 
2.43.0
