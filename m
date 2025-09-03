Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E32F1FE4
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895288; cv=fail; b=AFAdMRf+ivVnSxXqycPJXLc1Z2jE9tgS21QWZ4010JP5qiSo+3QIyhhHierjB+MPEmlu0mRwAJYaPJayXjkXtHk8UzL/bjP3J9qgsk2Nm7eFL0j/jxkHdUvFKeE66h3s29WkYsrAhYOisFJ7XZ9cu0ATld1+WlJPvgselsLCsTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895288; c=relaxed/simple;
	bh=ID5Lfb7LwZI9Ucm5yoyXzkBXGE/dvr4CJShUVU4FVJU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rY9BpbzxNCmDx2BkZxU28n82VZQmewAbEP6XLxIfzS6NDN4jV+ZGawNn64LXB+0w/Q25BjigXqNGdoxW051s3z58ycUhNb2RuoMwN6+UVHAK3L7nJBpR/XSeuIApuxJ4UWxitVSvASj2oa1yVpghgORoa4ZujAuUynT+ZPoN0u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EbSyRSMy; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EbSyRSMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrFwwkbDiuzL+FIv/sQD4gpmQp+HlEWl8NfkzdPaHqylJ/n5tYjtc6yzzs2sfpL+X76Bvwx+t+dFN7JUj3lLez5XF5b5SH2TqceRvhMWLEMQQh8jgnTCOrYm0H/yDGFn4BWKcfHTc9BI/RmhgI0wrC0ddVYstCTB7+CY6OCxHrfePF3esIC3yUA5ougXDoX6KpUuA7t6gnrujSIG0pddaFoseFrzEEGcb9o7iPjU1jmrQTwu0B+bnZmpR3YPES7hL3e5wTGJ0n6PK6mmILqb0B0rZhcOrDnJg3JbNU2KAwBJ/OioTP7I40cW23U3aGI5IltaVp8APqS4J7+/lCyS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t0Q5OnJuyoZIiaYY2LAFE7zlDwAFu48H7FmNLYArrY=;
 b=Ctt9kw92ANDoLo8m6pd6I+6aLBByL4iuFmvtEB4LRe4L4e7supUuxQCWx6je03IZHn307NLU4SkTBLDPvXusPVGY7MbHHxthvui8NKOreYPB1zeOpq/++6Qzd3ePkcIETjpzuzZt9jAfmDjZ0lziPgGf7S8iZwPhcQcbyLnHfxF+JnQFCuFtPJnQ05vi49xoohi2gNxINOAKgxet9I6WNDMdbS75A9LspQb7aJbu1VrfSnfEHHWCvGk9Z5ZnyFCSe9a2DpMHhjZRECAS2NXA1yw/BcFo+p09qIdYQT6U4S0sVSDuBY29KuuabDBrjy/bwCGToafZEeZkJhcM4EmlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t0Q5OnJuyoZIiaYY2LAFE7zlDwAFu48H7FmNLYArrY=;
 b=EbSyRSMyVIY2si39tP2wIJTT9QaUe8cMKF2YkEx5E+B5BjzYzgYXyR0vRqllkSbzmR20/c9LDonNBpQZ5i7nZ44JtE6QGhHktM9G8dOjXMAXjHF77fhOE8hQgJgdCJARKL2mpYpfDugPTSEeAtxQ5+FyQ7/Qr63zUc/vMPkuPawC0Vwt0bChIf3MSwJE0hKEOQ1UexqUBKVYWw6gSChZM8QFwIJQ706ExVCtAcFZFzB1XNFFq/a0QOjSWm8BIGQK2+5zU8VfXoYMcWniRdVe1fRDQG7G8azRfOmbmMRP2WPrU1suQpx+JaY+09MhJczKvDC/WRT+YmPh8AOS+wvXVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB8927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:28:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:28:03 +0000
Message-ID: <a25270be-8539-43eb-945d-40600f975971@siemens.com>
Date: Wed, 3 Sep 2025 12:28:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: buildpipeline for xenomai3 docs
To: Markus Kurz <markus.kurz@sigmatek.at>, xenomai@lists.linux.dev
References: <7e7f370a-ac07-4a0b-bab4-deebb80c2569@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7e7f370a-ac07-4a0b-bab4-deebb80c2569@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dca3bd9-9ae5-4abd-2b71-08ddead49038
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXRTQlByaDAreXJ4Zi9UT3VNandaVlY0VGNPK21mRG9hcW9aTjd3NnhtdE92?=
 =?utf-8?B?dGpBcHJUeVh3eWl0c0NJWHg0QVpIUWxKTTk4dTRDaWxocEprd0xnanlianZL?=
 =?utf-8?B?bnZwRzZ3T3QrQktCeHNRcm5OOHUyQmZKWUEzckMrdlNrNHM5OXo3Vlh6N3FN?=
 =?utf-8?B?S2NBQjR6OTNCbzlsZlY0WEN3MVl6cXFqWDZiMWdlcWZkQ0lhcnQ0d2wxbFVt?=
 =?utf-8?B?cnZaVkdWZTdHMVVjWHAwS3M2NUVmcE4reU1OWUdITysrOTlMWVlROVJoZnl5?=
 =?utf-8?B?WHBTU29ZZ2tOUDBzMDBaZ1lBWXNHejJHRStPbHBDYXNGWEZVWFc2YWdNSmlK?=
 =?utf-8?B?aHNENWNvQmhuRG1sbG10VFRnam9XVVowdllnTitWb2ZJNXpsM3RFdTB0eWU0?=
 =?utf-8?B?dWRQVXRzb0lkZnRyMGxFZ1Z6R2svcU5YcStGU2hjNHRHazI5Y0V0MTJWdGt3?=
 =?utf-8?B?N2pucXBpN1hxdGY1S0tpekhYRUVTTWgxWUJVOVZQaFZPemV6RHNXNWQ4ZFJQ?=
 =?utf-8?B?M0FPeFlweTROc3BUN2RJb1V0OGhkeE5RRnBBUkI5d0l3VS9DVW14QTFqbytD?=
 =?utf-8?B?SFBvZ0VOaXdTa1liVTNpV3ozVk51bmlpUmdCT2hETno5NHNLaHRZdVFPUVI4?=
 =?utf-8?B?VlZLU3MyNW83RWJiWk1GTGU0YmNIK0tjSHpxaExKSVZNTFM5dGxHTEhmMmlL?=
 =?utf-8?B?Q3NJZ2w1RFNLUGdUZmtrdjE4ejV2MXRHMUFkSnJGVXJKaVRmS0N0TkxVOHV0?=
 =?utf-8?B?dGNmVkt2OCtrbnRiWE05UUVMRVVYMlFVdkV5QS9VdUdxam5YS3JXbHlCUXNZ?=
 =?utf-8?B?NVZ5RTJUeTdyY3NTbXRQbjJpMnIreHM0RlBqWU1DdFY0QW5UaEZ6bWJYY0M0?=
 =?utf-8?B?RDRIUkVLNDNZMFNGaGhkSGtnd2M4NlkwSTViWkdTWVhzRFZBcHhRaHZSdkd3?=
 =?utf-8?B?RFVOazk5Yk5QZ00zTWY2VXNQV1pFNmwvMXBoWlhpeUdNVzBkSWdVSXJZRjNt?=
 =?utf-8?B?UC9LVzVPclpwRkJIbUFPMEhoMThwejlkZTFqdnY0V0xNOC9jYmJ6dTduSUxs?=
 =?utf-8?B?UytRemZKYlNzSFJ4c2FMQTkrcmlvbUg0ekEyZjB0RFZNQUJwUDZFY0dqSnhI?=
 =?utf-8?B?QXFYdTM0c1NJdGtNemNOL3ZuZUhlZnM1NVdwZXpDN2Q0T3pLRGxGcHJlVGpJ?=
 =?utf-8?B?eTVJMVE2NVZoRDhlUWFycGFrVXYxSlZRRm9uajJtUTdiTExLQW16b0ova0Fi?=
 =?utf-8?B?czYrYW5CWW1HYXUrc0EzK2VsM0ZzUHdzU0tEYXU5dWZKYlJMWkFUcHREV3VK?=
 =?utf-8?B?bHpOenhFMEo3TllWNEVXaTVYcnI5U3BsT3V4a1NtWHhPbGpJZzNBTDA1WHVD?=
 =?utf-8?B?WE15YVhPckVCczJNemRvSG5aNGhQejh2NmJFamgrSjlCK0gwMEJJVGlFZzEz?=
 =?utf-8?B?d0ZkVWhJeWx6U1EwWHhOYlYzMjVQTjhGckFwZ0VWWWRFak5VY1haTFFHR3pY?=
 =?utf-8?B?TDVtZk0wUkhCY05VeVpUaUM0bHhNc0lwSURFNHRjdUd1UlFLVHgrRW1jdUNh?=
 =?utf-8?B?TmhkMFhJV0tCcmQzdEwrcDVjK3lxb2c2T2tXVU12dkFEeHhNV0F0eSs1YVI2?=
 =?utf-8?B?VHRRQXNMamRLTENWcVRsMTBNMDV1ZG1UZjlkWURuVzFqN1REVC9wbGROVi9L?=
 =?utf-8?B?emZ6VUNWUkJHaDRSdWd5cHNXM2NjbmtQTWprbWg0K3hpSUVCNGRocmJkNDhY?=
 =?utf-8?B?YWtGajFlaDk5NzJqSWVyQ2ljSUtjNFQ4OFpGMlB3UktQU2dpZ2g2QnloRjVC?=
 =?utf-8?B?clNENzhnd2dpQkxabEh1eG16ZW9pZk9pRFFCeTd2c0xKTStuRDlHcE1hZG9s?=
 =?utf-8?B?Smg3b3NYcjhqalQyRTFKdEZDZS9sVkgwank0VHJmcktxWXVaVE53cnA3YVJn?=
 =?utf-8?Q?/gi4fIM1Hpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eis1Vk1qcWl2YThqbFl4S2R0RXFWVDduYW1NQ0JWQm9lNExvNnRSbHRtVUJN?=
 =?utf-8?B?Z2FtQ2x3Sk8zbFdpZ0JaR0lvYW02TG5TL3VZYzZkNGFldVVrTXdDVldibjRW?=
 =?utf-8?B?RWhRODYyMU4xZTIzeTNzeXFlREYzUDRyVm80VU9jUVdiTW9VZUdvbXNBVCtP?=
 =?utf-8?B?WmFNclpNREg3K1NsTkRBY0dDZWhZWnovQXArMzZ0K0VYZ1NtUEpOMXQ5a2Nu?=
 =?utf-8?B?TW5KOEMwTVo3cVJGckdDR3EzUDUxb0xJWWhOWHkvT2pHb3oveHlWR3NLRmFU?=
 =?utf-8?B?d0YwMXZBbmJvTDBVREs2bHNWZVRDbnM5RnVqMnhFSHRycDVvY28wSDJlb2ho?=
 =?utf-8?B?RGxyMU5qRkJQVEhRWEdWZGhKY254YjZucDQvR0JGZFpPemFGWUx1OGVBbVlR?=
 =?utf-8?B?ekNFK1FwYXBVVWhQaXNadHpXZGM4SDNPY0lKY3BpTzg3Rjd2d0hoK1JXVGpS?=
 =?utf-8?B?ZHBnWlg0ZXlzZjFnWGRDaGhrTk5WRHhKcTdMb0h6aitBOUpEK2M5MzJ1N09W?=
 =?utf-8?B?NjEzSGs1aTBlUDR0bGdRYm9DbklwRSt4Sll6VGQyN3JkamRuZFp4VS9wSmlQ?=
 =?utf-8?B?SHlucU03TmxPbmdMR3V4RW9SSEplbmxrZFlnaSszcTJaenZwNWhYUHZBVjlu?=
 =?utf-8?B?L2p2Qk5RVWlHWWRlMzYrcS9HWDZRZFRSdnI3RlZGVGtONDZoaFJVTkMwdjJX?=
 =?utf-8?B?WG5kVFlyWEdyejZDYThRb09LbW9YYVF5aDdweEM0dURRVll4VmJTSmNhYTFp?=
 =?utf-8?B?ckVkVWE5ZUIrSGd6UGdaNDlHVVJDTDk2L0lEYWhra1JwaUVRQ2Fvc04xWitr?=
 =?utf-8?B?ZkNCLzZTY2FuZHZhTUpnQU4vbFdiV1BGYlhCb3NleE9GRGpTYnN5REdmSHhj?=
 =?utf-8?B?SGdsdmNBeUM5aERFRW1pSDFpRk9DMXBIdm04Nm1maDZkZmxzZ21LV1RwYXRZ?=
 =?utf-8?B?dFBIV0tNTlU4YTloZnlmK3FNYld1Rm02eVFwRlZFL0p3bngyQU9vN0Q3ZVo3?=
 =?utf-8?B?cVdRQ3VGbjNWVDcwYXhxdXRoNmVTS1A0SE9GSGJiZFFPUnphZXlnSGU1aEJE?=
 =?utf-8?B?UzNtMzR4QXFtSFBSUG9tQnlPYzFubVdVL29DNllsNFdpUUxEVG1NOGI1dVlx?=
 =?utf-8?B?eGNmcTVvVzdQMDZoMUY0cFI1aWQ3bVoraEQ2R2VNQ2szM3RkelhGdUhWOHh2?=
 =?utf-8?B?NWd5NWxSUlZQRFlDcEpiSnR3VGZhYm1kQ1FOWnhxNVBiSjdqZ040WDNDK3ZY?=
 =?utf-8?B?VlZndm5hWDdINHhESjdhUkt0QVkzSDR0Q1VhT3BKTyt4aGZsaThEMzd2NklZ?=
 =?utf-8?B?b2VnV3Y2YlJaTUN0THNtZkNvaHJ6WDh2WndUZjExZ1l1dUd5K1Q4aWNPbWs4?=
 =?utf-8?B?MHVGYU1uU0tzL01sTDhJNytvcm5DTU5kWXN0L2NhOTdyREFCejNiYnRkWkJ1?=
 =?utf-8?B?STd5U3ZVNzNTY2F6RHYyMUhTMnFJcmFSN21IU3djZDdTd3RDbVFKbjd4L2Za?=
 =?utf-8?B?QVkxWTAyYlNOOXRwTklqb24vQW81VHViUXhzb1ZxSXp3RXlET1lpa0V1N0lJ?=
 =?utf-8?B?eENRV0tIVDd4WjdnaGVzeEFaT3dXejZpT3JPVEZmeWlXQ2hSWUVKdDlQU0k5?=
 =?utf-8?B?a3drcU85bEVXcW1QbzE0SlhBcUE5QTVLN0s0ZkVCSlRhZ1M5WlBJYWFBYWNk?=
 =?utf-8?B?R3gvVXplZXNselFXSG5VbWd5SDZ2dStiTFFjUWVuV1N4cGtMOExCZTJaV1Vt?=
 =?utf-8?B?SmlQa0RIMk8xTndjaXhzK1FyZHc5SWdnZzhVWmh3MnErVTloN0ZSQ3hLa1oz?=
 =?utf-8?B?ZUVFajgyallaOEc1djFzUE9qSHcyMFpmLzdOMWs4aUJ1bnhaczBnWUpkZmxI?=
 =?utf-8?B?ZDRhYlZFY3FXYlRINkpRRGdYajd4QlJJT2l1K2N4SE90NlNmRkZkTlU4eWZZ?=
 =?utf-8?B?ZmpLVTNINnVwUXB0MjJCelMrTE4xWCtvSHI2cEUwamIwbExBVW4zWHB1bVI2?=
 =?utf-8?B?NjNnSVNIQlloYzhMWTlsaGtjNkJTL2svK2dIVXZFbnV5d2M1T0Rzb2cyV21x?=
 =?utf-8?B?Ym01b2FidTU0bHEvMjRhd1VHSkk1UUN5Ukpqemw5RlJRaFdWZDFZQk9sWUsx?=
 =?utf-8?B?SVNSMUpJVWRLVkRLZ2xmR0srZ1JuWFA2ZlQvY3NWckdiTHRQUGFoVW1ZL0R3?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dca3bd9-9ae5-4abd-2b71-08ddead49038
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 10:28:03.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmuZqunqpOk47hj77zBzPs5GSRG3F+7V/8McxhSlTgzFAjF5u6b60/uHReVWTf3aYbMabGnPnp1I/+e+O3ywFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8927

On 03.09.25 11:59, Markus Kurz wrote:
> Hej,
> 
> as discussed today, I'm currently looking into fixing the warnings
> during the build of the Xenomai docs. Could you provide me a link to the
> build pipeline, in order for me to check how exactly the docs are being
> built. Then I could correctly check the errors and fix them accordingly :)
> 

Here it is:

https://gitlab.com/Xenomai/xenomai3/xenomai-doc/-/blob/main/README.md :)

There is no pipeline for building the content, only for deploying what
has been built as described above and then checked-in into xenomai-doc.
I think I was using a debian:bookworm container last time I ran those
steps manually. But it might indeed be worth to create an automated
pipeline for that in xenomai-doc...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
