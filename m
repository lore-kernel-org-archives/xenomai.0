Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093C217668
	for <xenomai@lists.linux.dev>; Thu, 27 Feb 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637297; cv=fail; b=CMB/gak5sUEAiiXcdjkGtajyTXP0N5BMQrHpgSB0M5M+Q8jHee7WSzV7cWvTScMJcm4ijFdCXBPZvSiHcuj868ieFnvRQmUECrMOpdB0sgoDuSuIz2q6W6+RSWazloTztkuiL4iM8BsXrPj2PJr6aiUZ1Hius8kNZryYiYCC5vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637297; c=relaxed/simple;
	bh=ELz4IXn8FXi6N+EIdS3ept5QgPiJxYloDkxqd4OUOBA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZehuHnb8pxTSAgqmNEzwbLxJ9jzbVFBbPPw5YAD1E3g73sCAkH5VwMH/FwrYfvRpyudu2ROEQOw5ndzIcXVuZUEWVjFKWqOsdLze0Wcn/jLcAAeSKtEYDQ6Bvq0Fl1vBdAxV0Pi6t8sicSsncp5pH8zCP+f+m8EZJbDYYVUhNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xPlHiDKW; arc=fail smtp.client-ip=40.107.103.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xPlHiDKW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmrKeVkV3miv6iBHAXsccjJhQTdDKdL+uBzv8rsRSdSAFUJ04SBkG6NDJDhh0lPsuXb+Te927Z4ByQo9mvR4e3RDw6ZdW+JK3WnJ429eYqpg+1QCY4PlZ6rkJ32qIcxXZ3/d22nPE4wHUD+6saDmfns8oy7oyt3MuanV6QlfFRJE7aIk5udfW3wHqmVLuzcKye0pP2M99qsq6bUBZaW2iVvf/MS4jUhsLI/KnCWsaTH2Da2r3jpCZvgaWtF3DlI7wtF/zOnn3QpUFs8gwPvsyXEU3AGB4vCy8E05RrusJj8NBniuPEyBUf9524I5vGQyzUU38EyIu4kSH5qEUmE73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIzW3QFTYE5kcPFTG+tKYStetWTu2MQcB+AJLN78EzE=;
 b=YSZZ4Qr/1G2PKTHjNg7StQ0Op95+TuAJ50doPR95sNUOLRucICWykGlxaJIHo+YM2W+BaiPwOMuxzoicOi/W0s6UROxs2nwMX3CHMOCSHkeGjB99cFi+PmNbzoFtMlGoINu1xEOIqpfvq+cD9pfMQQgIjuKc1n1mhl41CpioR7TB4s3ycfR7XyP4P2gOwVoBdAVPZxHTR0qHwCVYTZd5QQJPuiGmBkqD77RhzOOvv6EELoBpU4cDWVVLiKQ4/L7fS4kSCNfNBrvChPtXs4/RE282AsY8nzCPK+8h99KpLAOIGZPS1lessZVHtsl/Ui0m+PjiP4SAsP7yDB8z3lwM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIzW3QFTYE5kcPFTG+tKYStetWTu2MQcB+AJLN78EzE=;
 b=xPlHiDKWFze16kG6xfZIQvFpG801hutP645DpcIjQcreMXMJQDhvlEIMpdoPS2XoiHOt7GmckCCIT/dsd68S7r/erlzQKyxCZl6O9GWyv3tYRnSreoJ7RYoHEpNLa1G+zp+cDJi/Z/HcJXYRoAYpwflFdddUfrpyy4WLvlouTv8xj6w8aR7pQTkYbYlBH5pqhIGmRAU6lB6AmYsK0hKhzYSZTKocvWPlis1KTr5WwUKY1SR2a+4EQM6OFrYNzxxwdfECTcHOTQjVAxO/pCZ/+M3TLdOV36rHQ2sC1SKicTbRARYmtOmav4CDVN99ELsX00v7Ap6bIuFaLE7/DQRN9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 06:21:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 06:21:26 +0000
Message-ID: <182dc5a6-5006-451b-a66a-f588bf1de294@siemens.com>
Date: Thu, 27 Feb 2025 07:21:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/tracing: Fix cobalt_tick_shot trace point
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250226142117.4057013-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226142117.4057013-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 446e1831-96b2-4c7b-a637-08dd56f6f728
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWM3R3NXbFhvVHZIUHZGMklmMlhkSWxxM0tXODRSTnJ2ck90d3Z0V3Rybjd6?=
 =?utf-8?B?cW0xQ1ZpU0h6NDlkM2VlYTVZQTNxVFlaNEZuMGdzQWlWN1ovOUlOK3FVTjVY?=
 =?utf-8?B?ZTJ1NUhWd2Z0dXJZeGoxUWVyRURZNE83REFMalpuNWhJTGdKTWpmT3FFSDg2?=
 =?utf-8?B?WS9qZGJtcnJQc1JzYTRVMFhFZlpVS1BhVyt4NGl2Qi9FMWJnTzl3NG1UL3ox?=
 =?utf-8?B?NWZ4MzBmbUhuUnZoNWcwemJsWnhvWG91ZmlvTFRrRmZGNmRtdWl3QjhkVXdW?=
 =?utf-8?B?cmZkcmFxWitRUStYdlVBL3FZTGUrOHYrU295Z2VsT3NCd1pVRWZUZERHK0JJ?=
 =?utf-8?B?cWs1SUNEQ1VQQzRiZHg5emEzRDdtdnZMMFh6cjM4OXNRSUJTVXdvbGlmdEFw?=
 =?utf-8?B?RmdkUW5JTnZHby9qNHM1WjFSMWprdEYzOGY2aWhFM3pkeFVONzFkNmhnY21t?=
 =?utf-8?B?bUVCamZhbXRZYjdXS2dSRTAxRjg1Y1V3dWZKelpzMEw1QVdMbzZPL3RtWkJz?=
 =?utf-8?B?YW83SkFzUVA4eG5VTCttb2tiUHpUeUpWZVBHRmZtNWg0eVJHRWdERG11bXhT?=
 =?utf-8?B?S2twTnk2cmJYbTN6TzFrUXVPNFZKUUJYWjhObEhrK0hZMzRUUXkyNVFwR3pL?=
 =?utf-8?B?dWpFamYyeEtBalZKK2ZRNlBYT2tNRzQycUlOUWxhMG81bzdjUGlLSWhyS2N6?=
 =?utf-8?B?V3hmQmZ5b0pzM0Q3Ni91bGVaOWMydytLRUZPdlczL1hLaFIyeHpRbDEwTnBa?=
 =?utf-8?B?Ty9jdkczeFZ1QTY5a01uQ0FkOWJ4REtoSjhrZW1PcU10TUZQRG5Yb0hPMjkx?=
 =?utf-8?B?dTVrZ08yOFdtbjZzL09wd1MrOFc4cWdmS1JBd2xpVFo0UytNSE5PWlE5TkQ4?=
 =?utf-8?B?UkRJNGlyRk1XRzRnTkNyY1FrN2htdC9pMkQzaE9BQlB0STR1allHalZrRUtB?=
 =?utf-8?B?T0dOR3N6Q3Z3aWVROHlaQms1NWovM0R6TTdkOCtoR3RZS0hPZkRNUy9ObXZh?=
 =?utf-8?B?Rm82Q0hLQlVhWXoxZUJ4TUpqbWRrMzFEb1lpUWcrV3FOYnMwTEFOeWpBV3dT?=
 =?utf-8?B?SjBGenl2USs4MFJCWVRMVEVHT3U3ejRBZDRhQVZvRXFXVHNzV2p3MnVLQ2Yr?=
 =?utf-8?B?bzlkTENzZFdWQzAvSlJ2ZWFGaUdyQUtIbjJWdlZBc2pyZ2pKMkhMSm42ZVI4?=
 =?utf-8?B?WG9NRHhHOVdpdDlIWnlNcDZHNDJVTVhTRDVnb2t1M2VOVDNPOU13dGZSM1RW?=
 =?utf-8?B?SUZUbEE5TU9uS09PZW9hVTFod0pMdEtjSm9UUUljVjcyNEgxWVJwRHEvNEJT?=
 =?utf-8?B?RVRBYVFTaVlzY3hFd2w1Ym9zdGxFWUtESHRCRUpTTU5aTm1RTXpkV2w2NDJS?=
 =?utf-8?B?SHg4N1BLcThYNEVyN2d6aSs3VWtPemhLeFNXN3RQT2lxeENNcFFuMS9rNXl6?=
 =?utf-8?B?cHZYZmtQaXFxNVFsK1VMVi85NjJwRis0NUwrbVR3d2xKKzliOUcyYUMySEVs?=
 =?utf-8?B?aGN0Q01CQVJaZmtKRGgrOGNjeTRCRE1nZ1MzSmJ1eFhNWHBrTTZtVTA1SUh6?=
 =?utf-8?B?T3VVMGlIVVVTNDcwL2JlRHRxNmdVeXVhbmNJOGJyK3dFRmd4YUozOWtvb3ZE?=
 =?utf-8?B?d01EUWFwNnEwYndxenJPY3laK1BNWCtBYlhRT2VybHJKYzVpaVp5M0V4dm5v?=
 =?utf-8?B?T2FuK0tLbjBkTUNtY2I5a0hWY05QYmlCRStkcDkzem5nU1BnbDBrd3FPTFhE?=
 =?utf-8?B?NEk2U091OUR0aTBVMVZ1TzBnejhhVHNxR255VnlhSHhzRmpKUW1CTlRmL2dt?=
 =?utf-8?B?cjFlQUFESzZ2WE4xdGxnVDFKU2dkK2pyRk13azJONzBSSUlpazhzcWJ4K0V1?=
 =?utf-8?Q?BUWh9Pdg4ySlS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlpNWtnU0hXNk9VZXM0bUEvN0RSYkQyam1KbEVkdEk4WVdNeU4yV0ZkQ25C?=
 =?utf-8?B?am94UjR6L1pDcHdZZ1RXR3hyaUVVdXVJWXo5K3Bvc0g1QVFNVDM1YVp5TCtv?=
 =?utf-8?B?b1NnRjFLVmlkVnBzc0hXQmtBYkdFUzJqYXU4MXhqMFNaeXZ6TkZOV0lvLzdl?=
 =?utf-8?B?QnR6Ykd0TVVET2IycFUyQWdCMDFGQ3UwQVhtWWF0eUgzSE00d3FaQk9UbkpN?=
 =?utf-8?B?cU5DZy9IMkRibkc3djd5TGxNQ01IOW1JUXlscStocVhyMks0ZGptTWZ5dlVM?=
 =?utf-8?B?TGZjZjRqS29wMm9BcElWbzl5L0tRUy9Fd0lFRFp2M056RDIzRDk4VDlMZlV3?=
 =?utf-8?B?QjVoU2pJWFROdXBKS3JPcmdUWlR1NldUSWZ2K0hHazgyck9md28rQWNXNDJE?=
 =?utf-8?B?bi9qZUZ0R3ZmLzU4cE9mSTNIVmtTaWF5WVF2aEk1cU90TFRqQjNzZytZelV6?=
 =?utf-8?B?VEFkZnNEOWhGOTRkaFY1ejlxR3c1cy9uY0VnVlowU3JTQ2YyajZud3BVd0Zq?=
 =?utf-8?B?T28zMXlMQ2pZN1YvblJrOHMxb0hFV0NxaWl0MXFtc1VmWTdFUGZtRmo4RDg2?=
 =?utf-8?B?cDZIUTIySVNVRXVpb2xqTlNNSHhsWFIwU3NOYmMreFpOVFhMWGpLOG9VOXhW?=
 =?utf-8?B?VmhneVJlR2t3WDQzaEQzN3V0cDRSanBWYWIrL01LaGhrdlhwTXBnallXSkg1?=
 =?utf-8?B?dGpjKzFxbjNsMWd1Zm5nM3dITU9uWlhIdXlSMXkxeDdFVXN6MkNsYmhmd1Rw?=
 =?utf-8?B?cHpkeGNIdXlkdGIwOWw2UllSb205VjRVa0Y3WFU0Vkh0Zm9TVENOL2VGenpG?=
 =?utf-8?B?dTBSQ3pSdXRKenZDbHZPcFRJeUIyNExSL0lEWkNaaHRWWWlWdm1pQjJuRkJt?=
 =?utf-8?B?RmNVN0lNT3ZhUkVXQ0NPWWNISW1HVCtDcDROYXhxd25sa2hrNldqWnhydkdJ?=
 =?utf-8?B?NWRyZTNHdEl6KzJ5YW5qZDNFOHQ4emc3UE5FVEdWUmhGc0xYTDVNOGRZaE85?=
 =?utf-8?B?RUdpNWszdThaQzdBM3ZzUU5GNUJTaHhjSUNhZ0hYbjVzVXI5ZTJKdlhZU3pl?=
 =?utf-8?B?UjgvNTh1dGN1U1JIR0pwbWF5dUkrVmdOOXpTTW55dVB3Rjk0OEt4ZFVGVWVX?=
 =?utf-8?B?WXgya1BjOE5NU1R5dzhWK25OZytINHlwS0E2alRnaDIyMVkzamk2K1doMzJn?=
 =?utf-8?B?YzcvRFJlckFPeDEwU01QdExudFZrYWF2OTFDQkN3dUMxM01tTnJqSEdSOFdl?=
 =?utf-8?B?b1gxaE84VmJ5TS9uZ3pJQnBBVnpiWXR2WXVqSm1haU5ZWEtUNGt0WlVUa1c4?=
 =?utf-8?B?QlpSMjFwcnl5OUpHYWFFcThWWWlMVTdPMGxkTjYzT29yTFRWRDF1K0RPUkRk?=
 =?utf-8?B?QThxaWo4LzVLNTlPSDVRR0c5OE5rcmdpdkhCVEtTYSt4UTlQUDczQWZ1OWdz?=
 =?utf-8?B?TmQ4eURCUGFjYnpQc1V4K09iUlpmSnNpZGU0NWJ3Y2dTZDJSZGpwN1BqY3Ny?=
 =?utf-8?B?bjBqR3FLYTduWUZZU3J0aGhBK25CMGdiQU1Xa0w2cVBxUjVMUndFeHQ3WUt2?=
 =?utf-8?B?d0s1UkxUc2tmVWVFK3o4UThpWWhCZVZSY1lzZFBsN0RrZXBGT3VMYlc2WVZ0?=
 =?utf-8?B?Vm42TG9SSmZjVFg0RmMzTlNwOHBqbGJXalhTeWF0K1VkZENFZW8zNjE4Y1ly?=
 =?utf-8?B?SHQ4NTNNanZJajY4NVJSWVdocC83QWNES3NVeDg3eUJlWDFwL2FDeW9IRld3?=
 =?utf-8?B?OTZrc2hlN0hkZGY1OGxocVFXZ2RlRGorUE1YRnRZcG1mUmdJVC9vcHJCQjFi?=
 =?utf-8?B?S2t2ZWJiUGRYQlliTnJKcTMwZ0gwUkVvSUh6YXBPdVJ2K0g2SUY4S1RUdnFX?=
 =?utf-8?B?YUJuRGJIT3NKemg5ckxONURZTG1EZmVTeXBYTVh0UWhjSFFaWHBxSkpIakkw?=
 =?utf-8?B?clowMDBObzd0QUJhb3ZFL2pyQTdIeWVKVXNaTFJVclNBMDc3WlJqZHBIL3Av?=
 =?utf-8?B?K0l4RlRXaW9HQ1doSDFJZ1VJVTVZbkZvV1ZXT21vc0l6Q1kxcVM1bENiTFpD?=
 =?utf-8?B?OWZIUTV6bGk5QS95MS9aeDNqUk12SlVXUE5NWlpEb0w1bHRpbUQ5ZUt4UThK?=
 =?utf-8?Q?5Fa2Sg3nKU8+zokeoQXxZ8X3F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446e1831-96b2-4c7b-a637-08dd56f6f728
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 06:21:26.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdvZLfqYJbn/eGQXomhFGxEIsiR7mCzDcCCsBqqxpBWJwX2WKeMBoozyB2bWzN2D+pmAwzWdgWwdBhPjKfN/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9133

On 26.02.25 15:21, Florian Bezdeka wrote:
> It's not allowed to call div_s64() from the TP_printk() part.
> Fix the tracepoint by moving the call to the TP_fast_assign() section.
> 
> The trace buffer looked like that:
> [UNABLE TO PARSE] secs=%d nsec=%d delta=%d
> 

Just ran into that yesterday again, but I only thought it would be
outdated local trace-cmd. Good catch!

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/trace/cobalt-core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
> index 22e4adda2..645d3e3ad 100644
> --- a/kernel/cobalt/trace/cobalt-core.h
> +++ b/kernel/cobalt/trace/cobalt-core.h
> @@ -822,14 +822,14 @@ TRACE_EVENT(cobalt_tick_shot,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->delta = delta;
> +		__entry->delta = div_s64(delta, 1000);
>  		__entry->secs = div_u64_rem(trace_clock_local() + delta,
>  					    NSEC_PER_SEC, &__entry->nsecs);
>  	),
>  
>  	TP_printk("next tick at %Lu.%06u (delay: %Ld us)",
>  		  (unsigned long long)__entry->secs,
> -		  __entry->nsecs / 1000, div_s64(__entry->delta, 1000))
> +		  __entry->nsecs / 1000, __entry->delta)
>  );
>  
>  TRACE_EVENT(cobalt_trace,

Thanks, applied.

Jan


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
