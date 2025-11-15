Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD115ADB4
	for <xenomai@lists.linux.dev>; Sat, 15 Nov 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763191931; cv=fail; b=DM8lTaM8l8fIF22EDKI0Z3qwX6L1Zm550wbpT3eGDpfl2ZpaM5Gd1I39c4d5Hn/xcGTyAMCxszl/h4nyCEz+fxas2XcsrKKdbcB4bv+ZsjDc5UvQNZgf0hLtVlKiBnSHOKvxhPqz0SbxmknTtqk22Luacye08fKQeckJmO/X9MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763191931; c=relaxed/simple;
	bh=y/hktt7pemR30YzK7VmeciCzsHgp5j7y6vuspB/ycGM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k8KZT9g6iHuEu3+whbv+Nfb9gYjrOiaKehZ4LX1IYIXatRK/1IuPwmutInFChd+NCGfX4HukZ27yZaI0LyvUTp6dcK7OMffWO9P6XJ22My91d6lAT3wyzI7FrY6051hZ/nDfXNu/iG2yaH+xtKyKqD6l4pb8MgtZc3pvodf613Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DjBaQdmC; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DjBaQdmC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiAypqgUMGZ1hXb34phKywMlZSfcUw2btl2GN5a/YS3R30bdb3TO6ErPx7DQQirKOn/hlTIISgDu1RfgnJhoz7LXRiNprqp5SPLbaim78F7+UDdh34kQ5GTVSD+hJrtCpdSsBkpar57tIxhZ38Ya2QbsTTrvbyZhbrXP8arfVPEEiDYojxuVorzznDYFlQTQwQt/ypipZOfj84NLdVXrVIgi44PXL/0hiLLG5chtMYzx7UXq2B1aZlce2TsZulRAajmrLd0n3u8NUPNxkQ27r/BSENf2k69vw8eCyAhaPy0+LT7XGI5hEKCnU+gjtY/R2rO4AvqPlooL5w4MisIwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2kyvPcENHFEI3tDGi3bp6Ou4w2HNT8c0qRtnJGAL5M=;
 b=u9YmcScAGIrmC0LPulfFM8VTmdZkAHKtEfr5Zr8AN0uxOVkNkqWxF9dJWSLgSykdQ9mVbavhworKxWldZl7XZk0LflswPPEifMwh6xOHAYJ0Yn3n9JDebgNeja0Ic6F2Gsww8LURCMka7B+kmrmphPEYq+khndwvMjvNhQ7nEAu0MfL8cEBZHHs8viEIsU8jM45D0KwgGEQEuiF+9EvOnZdNj05mP7icEtFYz+/CP/eXutHWAOOttrYkCEqklodU/lao3nV3Lu9LELF6ftQ48EbP2KLNSOCUkPQRonwYVRvWeosIs8ibBVkj5P81Rj1GezZILr/vMDzZ/PEEvBW6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2kyvPcENHFEI3tDGi3bp6Ou4w2HNT8c0qRtnJGAL5M=;
 b=DjBaQdmCPNSGLHlLrzOMkZgbUObD7aQdSd1gfx5ex8xwC1qAq2pJGoLrJyMsfG0/HJripahZcwsAPhhuDgxIHeBr9ETnABPysK0GHACgnwOjRF6/wEllk+s6qfxAHSisnh7c3T5FsD8ZAyjTI18HPW7PR35CG3VpGjb41TpJkBsgcTN5NKotermwD1TefwccooMZ45Be2F61AI8EaR0WyFGVru9YPzlpGp8c77myPxgSA6EuJ3Fk8Igw9AbASDch//QAqA0qITS2NajRVcf7Ao4WBpY1cQCt5KGT1e3b3pJvr0qMJnuCqIsuWXLGDpL6WJ5Q2N/A0k0TeLtEJh/UMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5926.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:528::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 07:32:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Sat, 15 Nov 2025
 07:32:02 +0000
Message-ID: <43ccaa58-1b6b-4bd4-ae62-713314be97c2@siemens.com>
Date: Sat, 15 Nov 2025 08:32:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_igb Ethernet support multiple devices
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGw0T0tOz9kYb0qmJaF0RLoKfDLJCbJ0Kx5yzvy=2icUw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPGw0T0tOz9kYb0qmJaF0RLoKfDLJCbJ0Kx5yzvy=2icUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d177317-6c51-4ad9-bb7f-08de241911a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFhyRysxY09hOFQ0ZzJRZ2EvUmpUeGFWcHVDbTBzY2xyY2dOL0VWNnBRK1RY?=
 =?utf-8?B?MHdka1BCU3lNdE1TMXVnQnRjVDFQZ3V3dVBCR0JiS2ZSOFdsamlLMVdYYU8y?=
 =?utf-8?B?azYzekprRm9VTXVnVlQxWGZGYldtKzcxb05OL3QzQk55bVBXdVZ6RzlHMFFJ?=
 =?utf-8?B?TGdjbFpmSjV3bk9YeTkzT3Jad0FwNFlXVkUzMndkN0pPR01uVW9McjhhTjRm?=
 =?utf-8?B?dS92aXliZDBjL0tQWVhqQ0tZZEYwV082QU9rV2k0SEdmcTg2US9TUW5Td3Jp?=
 =?utf-8?B?M2NlVExxTktEVjdRTm1qWWQ4QkpvaWJtRWRvaGpoK2Z0aG5HcFMzcHZZVld4?=
 =?utf-8?B?Vm5FeFhOWVBLL2JDTnA5NU5IdGdYMlV1K0ppcmVpTzNWOE5vbDVYY3ppSzJ6?=
 =?utf-8?B?MitMYVg3ZGhUbW55ekVka3g4ZjFxNHhmU2hBMmdWazg3d1p0OEhoKzJFbDBS?=
 =?utf-8?B?cm4wYXk2NjZuN2JSTkt0NHFmUnNBbVdQMEdEV0hMaVpzVjNTUmRKZ1Bha1F6?=
 =?utf-8?B?dGMzRGNEcUJ6OUJwVTN1VDFmTnh4VEY1cDl0UlUwL2JwVzVqRU9leXNua0FC?=
 =?utf-8?B?MVRmUVJYa29FWTFncWNscXVRSEZ4VmdWQ3BRR0MwU2dhaGU1VVZUN2JzWXUz?=
 =?utf-8?B?RUtmV2dxR2dLaWZMSDh6NnVFakJPVGdtU1ZEUHp6VmpjMjZLZW4wS3NFY3Nw?=
 =?utf-8?B?UVFiVk16MHQzWDAzdWRBbnk2aUJ2TjRLZDc5aFJtcHN3djlKQ1VXYmxuU0ZG?=
 =?utf-8?B?NG5HL0FQZGlIdFpqWGFZb2paVkpHVDVPV3RRUWtPOWZwYW9KbURXQnBvaDhw?=
 =?utf-8?B?WHdIME1tbFV5TnN6Y0c0dVMxMU1pWjZmNVh2ajhvVTlpOHNuNmI3TkU5MXdz?=
 =?utf-8?B?UGk2bEluMUpaSUFVSmtydVRaclZlNXdEMTBXOGhCSyszZzNKL1NqYTVmb2sw?=
 =?utf-8?B?YWc3VUdZQm1pQXJ2UStmdlUyVDNnaDdJY3ZwVDNMeUJxSm40R05GYjB1Z2Er?=
 =?utf-8?B?Z3hnY1ZPb3FzUDQzdDZ1Vk5xM0ZsY01MTU5uaVRHRTBHRG80Y0JKblRHTUR6?=
 =?utf-8?B?S0UwQi9uTlJaTDV5NjRFOS9ZdDRodGVkdENpczVKR1lGSTM0ZHc0cENlbTE4?=
 =?utf-8?B?ZmpqeXNsU0hhcFZjZnFRQjhXbmU4RjRVeWJPeG5KK3RYMExoV1BSclBIdE1h?=
 =?utf-8?B?QzhYMFhKbkZmc2RpYldvNTJ5ZGNldis5UmxPSnprUjU5NGdKRmo5NWtKMUZP?=
 =?utf-8?B?dUs2VEFlbVA4MUVuVCs1MkE0Vis2SjZwbk84WVI4QWVTcDZteWEvZHM2QWIv?=
 =?utf-8?B?SlcvN3JGaXFhQ3lBVTllZ0dCNzBFaWpwMGUxNmJTemh1dGdGelVMSGJVYkgv?=
 =?utf-8?B?eDY4YWhaL3MvZVdqNkl1eWorYU1KbFh1NjRqU3JEVENBMlhHWFdkbXpkNmMy?=
 =?utf-8?B?Tm1wRW1EYS81YkxEVllRVHdJUGdLa3FqVitQZklkSXpWcU9lck9DTDRmaEh2?=
 =?utf-8?B?OGdvR09DMklWUmNqRHh0Vy9NNGRJbWhvRVJIVDFiK3hsRm1qVFAvUzJPZFF6?=
 =?utf-8?B?cm9nVVhkMERYYjMwZTIvSXFXZXp1VEJOdGVzZ1loczExVVhiK3N2WVZsNVZ0?=
 =?utf-8?B?dUlsRkE2cmNWS095ZjN0bWpzUXZpTTIvZ1dhNmhia3BNM2hrRzFGQlY5aldP?=
 =?utf-8?B?SzBha2VCcVBkcjV2QkZmWkxPOTYrOVFMSkVXMFFDUWZPV0JpbHBuMFVNcmpK?=
 =?utf-8?B?bU5DblF5L1U2YVBVeWx0Z0QwYkM1Qmt6TU15TDNqNzZRR01PZ1JIUDBPU3V2?=
 =?utf-8?B?Uk9wckVVN1VmZlVLL1J5NEk5cTVGRms5TVFCcitXOHQ2Zjc2SVJNekZHQjRt?=
 =?utf-8?B?SGQrYmVueGVmR3ZnUzJSV1cwc3ZSZHk4WHJvV2EwQ2h0a1NKZEU4RkpYc0dN?=
 =?utf-8?Q?ChUlcXHWu/eGFcZVnhm2C/Dd+tGhEJlC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHZPR2N1d1k0OVkyRElVck5SWjlIQW1QdXNOZlBNa0VHdlgvWXBLZTMwQll1?=
 =?utf-8?B?WTRacGRXYjhlODJZQU9saE14am1sS1Y0VGovRFVOMWJLVDZlQWc0Y1hxbnU0?=
 =?utf-8?B?VHgzaEZTSlcydHRPczh1MytQUXF1ZVJYWjhGK0lBWHZGUENnckNsa0lKZHpR?=
 =?utf-8?B?akNHVWRQMkxOeTBKY2lkU1d3d0x5aVFqYUIyaVhLN1U5WWVYelhWVnp0TERo?=
 =?utf-8?B?VU1vQXI3ZHhkcGhGeHN2U1J5TVd6Y2hVYXo4MUlPRmd3RWNad0d0OGlaWDFn?=
 =?utf-8?B?SnJNb3ZlZk8zcDdLcVV6OE5ZL0NhSytvdFV6SU5IR3huZ2VFN3VmY2ZoT1Ru?=
 =?utf-8?B?c0E0anlDZDdWajZzb1B4QmgxTE14QnJOMVFsUTlpSDNMdjdtcG51KzFPbUN6?=
 =?utf-8?B?N3pMeDdMWHhheGFoUThjcm5xbXpqbHlnSmJMVVlFMkJUcEE5RVd0cWEvTUdj?=
 =?utf-8?B?bDJtdTVCa2prY0VZak83TFRMTkZTUkluQk9UZ0tyMlpYSXdpd1dvM016em0z?=
 =?utf-8?B?TFpEMVQ4WGJBeEg1RGdZMGsxMktGSm9ENVBlMkFaZ01XYUpGc1RiYzRkWktn?=
 =?utf-8?B?VWNDaGhuQnhWTVJBNXVMWjJON3F1b01FaklWNzdaMTk4U0tvaHphMXUyYmJB?=
 =?utf-8?B?V3ZVekE4WTVlRHhjWmNUYzZtZjVwTkZQbS9QdjBvakJTTVVDWmxoT2tWeDV5?=
 =?utf-8?B?czlTTVpZa2o2Z1gxNTBIdzJ4VStGUWdGKzlGaENwdnFpZDI2Rk9KNmRQQnhJ?=
 =?utf-8?B?WTNCT0k1YjRaN0ZadjVtcExRZlIxMGJYRGt6Um9NNGRxSUlXL212NStkSUUv?=
 =?utf-8?B?cm1vdHh6aWNzVU1HYWtsRWJBWUZhcDc4a29FRmFDckE4d1dlTW9WL0dDOEVw?=
 =?utf-8?B?cTQ5U0FLU3lQdE0zNEdMY0NnMnZTWFAvc1hTMmVHYW8zR21sV3k2WGxmdWVX?=
 =?utf-8?B?VlJUM21BbWZKUWdpSnR0OEVxeHZmUGI0R1p3ZXRLclZBMWNOK1R0NDJGTDJC?=
 =?utf-8?B?eVB0ejVqN2VacXd2RFI5emJQbW84dkgrQk5xNTRzV1F3b1VlR3lhRnFMMnFQ?=
 =?utf-8?B?Q0VPVnBKOHovTDNyMG5OeGMrY3N1M3VhNXRNZEFPK3Npb2prWjRpVjBWbFpY?=
 =?utf-8?B?REFONnpQbVBwZXYrMjhxaHdYREJsaXQ5SjRMc0YrdjZDZ1lYTmdEOHNJV3Ns?=
 =?utf-8?B?U3FFTXlMbjduWWJTVG9XRDFaUXVHK05pVnZtN2FoVDVTeDZnS1o1RWRlY2ho?=
 =?utf-8?B?dml0THNnUGxaOHk1NXZOT3Y3QVhNL0UvTFJndW9MQk5ESExsVUpTcHlDR01r?=
 =?utf-8?B?eWtjTE9odTRrTFprUVNTS0daYU9Fc0lxVjZTdm80OVJyZXh1ZWl0OGhyd1N1?=
 =?utf-8?B?RjZ4OC8wcC9KZEU5RnIxdUJ2M1MyYi9sUDFSRUM3OXRwNjY1UVR1VUhrWGZW?=
 =?utf-8?B?REVUK1oxNVVROVdsUWhqeEkzNDM3K1JRbmNvVU5MMHROQkh6SWVKY3dBakVI?=
 =?utf-8?B?K2VDUFBXS1ZzRitUTDdhcFVzVWVQNHVFcUtrQWtQTG4xUXo1NTdGSU1mdmtx?=
 =?utf-8?B?UU9iUWRYQ2VybVVBWk1hMFVVbUhkWG1SMU5QVGM0a0NwNEZDOGlpbzVJMWtk?=
 =?utf-8?B?YUNQVTFPNUZlSmVIWm5McU9Wb25mVlpkYXVjZCtZeDEzUTJNcEcyczRmcXUx?=
 =?utf-8?B?UVhqQktkMWcxT2F4K0Y4REhoV1RSRmlsRUdYdWZNR2VYM3ErbFBZSVM4dGt0?=
 =?utf-8?B?ZHVxWHRZdFJnd0dPdHdsdW5IMG1QSEZ6R3hxZS8waG1JbERlQ0FDQk1naXBL?=
 =?utf-8?B?MEhVMHlvaFhoNVdoWDZwQktpc0dyUzgzcWxrU3RKNU5icGRiSUUwK1M1QUxC?=
 =?utf-8?B?dHJJNjliVGRSOWdxc0QwTXBKcTIxeCtFS2REUGZRQit2L24vRnVCT05tWFh6?=
 =?utf-8?B?WUVTb2Z1a3pCNWp3c0x5RnZNUm9WNDJqVk5FSVBTNEZRN2luaURoa1cxRmp1?=
 =?utf-8?B?dmRVR1BqR2FTQngyM2dUOHZSVVdMQjNVdGJ3RFN6SElSdTFFTHYvbXpzTmc0?=
 =?utf-8?B?VkpYNEwyck5KUW1tS3dEVUltWFdkMFJ5OHV6OWdPd1JvQTlDWjY4aU56NExm?=
 =?utf-8?B?bEFkZWt6MlZ3dnkxOWQ0VlQwU0NaWFpBOGdZTTE3eWI4Z3RJL3ZWcm52akJ6?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d177317-6c51-4ad9-bb7f-08de241911a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 07:32:02.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiZRRUp20svQfESmV2Qwn4L2dy0e6q/sVD2oWnUi1Y/2KSCoe1/rkuGgwgtVaV9TWslh3c0Kuoki2L8p7RXu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5926

On 15.11.25 08:09, C Smith wrote:
> Can anyone verify that the rt_igb module will handle multiple NICs
> simultaneously?  My motherboard already has one xenomai rt_igb
> interface which works fine. Now I want to add an i210 NIC to the M.2.
> slot as an additional rt_igb network interface (with a different IPv4
> network address). Has this been tested?
> 

I'm fairly sure that this will work as there were measures taken to
limit the number of devices. But if you want to test before buying
hardware: qemu has an igb model as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
