Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA615202F70
	for <xenomai@lists.linux.dev>; Mon, 29 Jun 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740194; cv=fail; b=GuCvkxIKGj4KCdlkXIMUW7oLRzu0jkp7D0InLxw6lfmBZqqZjrMeS7vpd7vIZCuxnnKvrFf6IrPVNA54BsU7vWx6E7lYsJ1u3tUYOnsCcrI2ZG3IfWXbxnWXZDunxbM1ShD+Ox2EZlwtVK2N1fxGFjFY8a6C4lVZef7Z5Pyfy6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740194; c=relaxed/simple;
	bh=hd1JIjJGqxPHR/bkP89V9LjOmxtBexK6WZfMAhgRGq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UwK8L9ogmL4BdGjexCHkU2DHxKCuqNDlAcxVv/tap8Sh8TAOqgxylzWR4w7UNJ33aFs+6Ac5vH9R98Rmx4DVRJddx4VegH8PIb+g0oZXDhvODEaa3KlEsfzQ//NnGAxh1B4wezNXmzLvsyxtyv/hhldSMI/PSzeF98DtVxavPWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hLyvDjKj; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hLyvDjKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5TpTFp3Oj5xnko5QAB7AF2J0PX4rWqDo6VKLmx4ahs0RVqADijAKZTWQmCXzRfOxHZrI4sUO/5Iya9J8Cm051M2aeMFKvMdnrNMfWHTSMSxmw4l0p2Hy4Yn1zfMyYDvhePW+0rGKlQGhdqXiqa8UkGjhy3ld7w7dtbCYOnixjS0NX+ntSmMPDgEhzlhbNHsG8QvR4C4EjEddPB6dJj6UxkYoVDZkGpwapNF9hA5yOx0QzGtp8KJqxB9qEtQiIF7GBtnz50L8rmqmkcv3GkMOJnyMXzOKtqp4MefZzLE6pfnS9yDd0h0LSQ4qky1Qxe0+pf7K5zm/ewpHthDrMLPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVWhSKDwG5SGitUEsmPUMFZKaloXWpRyWWVms26IMCo=;
 b=YU1yoCJW+tcgr6PBi45woxtfKaTJZ3zd+feKMmSaPSskW87wPGzfYcNHB9gZK2fjAaoHaOC/wHW1ys2MbgTNtfRffPgWkHgGcqQQwm05TDcvYBvMvkGtAUMDKsy1FIzYlcGW8GNex+WCyh4gvUrcMbl6Z4Kn8XdwUKLYQOe/7KfMboPUmAqerZhDkfqmik/WSBEq3Gzw6iDILjMU8qnZwmMM2ql8Shpoz44bwVf/bO7gjSwGGBlo54iSA7pl4OC004ar+982p2pdf1tAMlVEHKPJmKBYvRYgvWrPvaBr3buEhLptuFgxm6oPtoaAF7e2fX6+w+Lo0+TY4El6MwlKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVWhSKDwG5SGitUEsmPUMFZKaloXWpRyWWVms26IMCo=;
 b=hLyvDjKjtW8RReqepS6L8wk2sLMrqp7oFRgYFjO+e7cZNOr82fE8qBMp5bKqfnSY+2/n1HmysegYhNJTdPcDH04EYIjq1DCh2xzZDCqRjWy6E83YwblLV9Ob0QtAad+xMxySKAfwfwdRfQB3cMfqAhBc7izew1iFtTSwMVsA5/KeLEBIq12vqhuAcDPq4mWiDLtrjODPSoEzTU/K7AMTfrkPw/A77e8mWa7vGkQ3E7XRBvNF8ZhX8VIo9CArkwQ1TWYv0SI2AQRUxrto2e5pirUUuUZQGWhoeD+gPD+LeGEBEiqlt3/d+crKtSsUTeSZ2TfxQIVWTt5sndgghqjIfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:36:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:36:29 +0000
Message-ID: <832ca94d-d8c8-45d5-a8af-3f86baf44e1b@siemens.com>
Date: Mon, 29 Jun 2026 15:36:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH website v1 0/5] doc: refresh Cobalt installation guide
To: guang_feng_wang@163.com, rpm@xenomai.org, florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev
References: <cover.1782585785.git.guang_feng_wang@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 394c51f5-2a83-42b0-5fa3-08ded5e36ce6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|55112099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xAS4O3F7ZuM1T0aAa7e+5h1s7GWggniudTDWj0osZMroQZaOrKYGrkuOKvAtJBIljdaSGmhGP8IcKPRBvep1LSTd6jxaLfa5edxFX1nqLfzU8MFD0dNyfruzacIBNf0Iid0/JfIuuS7K24A+DriHbQrt6H5EyXKyZ19dJXpHLbg0hNNxmH5hENmv1zBsZ0sXfqjNpdCCWBYPUe5USNwzXDjpHCNuBjjLmpcUeCr0yaCMJFqiur7VcEmf3MjECwEdgF7L6/U34t5PLFBFFJpTlG3lGKvJdLPIkmiqQRb530ELBPxDEOwtRp805exsf2vawur0ISyHdxEXEuKOTdxyDWgJXKKKOVEvSCD+Ft7qVzMLcBETv3vkuhEemT3V2qFVT3NQuPtLo1Xz3NkFlqIFCn1q/ljaFciRauzF7pYsKt/qu3yTMar5QMnx+EAoq8UZiv0i+E7r4/d4iYUSfVS5vIjbWgvni/iESHp1AFoDAtSwLoMBCWhc1XYb5wTwYHCXv7JCc6RqLEYTEDHowJhROjvdWljYW/zYjebSL44uARSBgxyQcsS53t3tML52j0szJTw5I+zajsRbWszK1DjutynPZyRtpFUBHQTl/azcsQDGB1dAultA4DwLNrGo07Pkv8jDiJ3zconFziy96QRXUz/0qnOzGXsIUWrUA3ECBWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(55112099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1aWWtHYmdKQ0sycUo2YWFBK3pnaERrQnJSWVdNUmVFYUorZUNSaFVRK3J1?=
 =?utf-8?B?aHQ4S0NWR3BPSmQ3Z2dVaHdVVGNrV3MyeVVmOG5UWVFIYTFsNFE2cklKbFd2?=
 =?utf-8?B?L2c0ejYxc0hEM1lGQVdVeXlVZlh1M3RQV3V1cmgvNDJsaVFESWVZdGhyREph?=
 =?utf-8?B?YTZmWW4xbUJoZ2l2ZnlBaUlQTGI0ZndnenIzY29OUDA4R0Eva3paWW1BbFpx?=
 =?utf-8?B?Ry9MNjdzeERWWkJjWk9uY2Q2dklPVTBzbSthajZmMDFlcUJwVHFwMy9Nejhp?=
 =?utf-8?B?Nnd0ZzlEM1pLUzJkYktHR2NoQkZzNmpaaDJnbHl1TTJZdDc0elRBSSszMGRX?=
 =?utf-8?B?NkNPTnBhZjdmdFRBcWNZL0lmcDRMdUFXSWhXSFEwYTRiY3BsKzk3RWZVeUVC?=
 =?utf-8?B?T1RVVnorVkNTcUo3aTA1WExWb1UwbXVta3RqVUNuWjAzVWlLVmtSbWUzY2NG?=
 =?utf-8?B?eVQwbVVxaUx0ZGQ3aGRYd3owS1R0Smg5L2JMckE4eEFFbEdBRmlHemVQVVBR?=
 =?utf-8?B?TTRRSnRYMHFLb3pNOFVtNmxhVkFJcm8zRzUwS3JkdlpTd2FabkhIZDhGcXZn?=
 =?utf-8?B?VlBZODEwb0szRE1LaG9mbTVySlM2YmdBcHlCdmduMFBrd1lKTWVTbUFRRUZT?=
 =?utf-8?B?SFUyM1NWb1ZUMVdqSVA1MTFZcVhlSFlZOTQvMVNSemFpcVpuaWU3Z0RDOHNk?=
 =?utf-8?B?V2pDWE1aVUNmOWwxUWQwVkZqR2hGaHVzY2lJaDl5OHlsLzNXaEp3MFZlaHdM?=
 =?utf-8?B?WmttbDAyWGd1SkY2djBqbEg0eUxQaFYyU1FzWW9VNkF4aEt5UXVjQUVQNG5Z?=
 =?utf-8?B?YXEyV1l5bVhYRFRLOTZkS1lwbVFWb0lIQk1kMnN0eC9oSnB1bnlKZlR6QUpM?=
 =?utf-8?B?ME5leEtpNGtDTTQrK2NWdTl0dHRURlpkcW1uTStjTmpoV2d3MUVJT09DdUhX?=
 =?utf-8?B?a09zNm1TM05oZEVVVHUxUG8yR1dUaDhUZlBidUFyYUdHeENvM2V5MWcwNmRB?=
 =?utf-8?B?eFpUNmZ2dUVGQWpsbHJaNitFOHBMaTNhY2pKRkoyU3E3MGVFaUdlTFo3L2Ra?=
 =?utf-8?B?aEp4bjlheDFtM29Zbm13Uk1KUjVRWUZDK3VlOVZ4eGNWeDJjOHV1bGVXMzdT?=
 =?utf-8?B?Y1IrRjN0MmNvL1FQRUsvUEVzdTBTT2pYVTZLYXkxWlBBakhITzRVVVVaaWFv?=
 =?utf-8?B?RDBRZjBtZlhNMXJZK05DQ0RtNFEzdjEvbWJBdmxuakFqQm0zRjFzNURMRUd5?=
 =?utf-8?B?bWtZMGNnOTR4a0lpVjNDT29FSGx1V2ZvWW52MVlKKzFybUZVVEJseEdRdUsy?=
 =?utf-8?B?SDloWlduRS8xL28wRXNrMFlsK1BOVFhkMkZ3YkRpT3l2MUlaWmYzWFZoVDhn?=
 =?utf-8?B?VmR1RElScHhiS1ppZGlrbmVsdS95MVFsREtibGtrR2VMNHUxOGJhamdyanVr?=
 =?utf-8?B?UzZwU1ZPQlJRdEtLVXI0OVFrWCt2VFNJL1EzUnhIa0lha1Vtd3FEdnh4c25a?=
 =?utf-8?B?RXUwOVhWdmhDT3VLRjA0MXJadzFCRTgzQW96MEs5RStPRWFrWUc4MDlQOUJH?=
 =?utf-8?B?VEI0eXpDYnQyd1dBdGlvNVR5SDc3aHdIMFhSbEhKM0lhTXEyODZPVndubWFv?=
 =?utf-8?B?VWh5QjNkekRYamFGTk1oQUJ3WVQxc1hkc2ZkMG5YK1pKdFVtRG9YUFoxR3lw?=
 =?utf-8?B?Z2VpWXNuMWtFQkNDTmw3ZlpiRnY0a0l2K3p5NEVCRVV5M1krazdsZVBqSW1r?=
 =?utf-8?B?RkI4TiswK2Vya1YrT3V5eTlBcm5JWDhOK3hyRDBvQ1l0ZExsWE9xUDVLQmpV?=
 =?utf-8?B?YU54OWdaa0xvQjJFcjgyWmFxT3hnUXMyZXNiSlBmeVhjY3pMM2NvTENyZmZm?=
 =?utf-8?B?dHJJdUl3RS9JZmxaWW9mMFNUbUdXY1IzR1FjT2ozMHVzMEFVcTErcXFZd3hl?=
 =?utf-8?B?RTBhQUp4c2hQU25YbzV2NWFQYkVKR3JCZkZpck1CYlRJMm82ejdPTTVEa3A0?=
 =?utf-8?B?VXNrbm80dDBuaTFTb2tjRk1zaGNoUWwxQ0NWU09NNnU4Y01RR3dzRGkwcith?=
 =?utf-8?B?bEpkTWRkTGdSWjNBY05jSnFGYlJ6UTc2cnV0ZW9NaWdCNmlsVGRWa0R5REZv?=
 =?utf-8?B?N2M5MUF3SkxROGpOeUFVdlo0VXlLQWtxSW9DbU5RN2hNSFNaODUwdWpXQ2s0?=
 =?utf-8?B?bGdyeFZDbzJoZzd6cFBGLzMySi9LT2kvaGdTR2tvdUwzZzB6NVBzQjJ4VUc0?=
 =?utf-8?B?dWQ0NzNIYXZtV0xPdUpFQTZ0eExJV05nbmhrZXZyV2x1cW5rK3lTazArNS9U?=
 =?utf-8?B?azFYVnovR2RoalRkbDNSNnMrN1dNWHEvNFZ2YmYxeWd0SUk0Q2tvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394c51f5-2a83-42b0-5fa3-08ded5e36ce6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:36:29.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16Hxtt6DYNWbXhPhugBxRqFl94ZuteJhHs9xXuG/vHS92efe7e/xfkSyiXhJKjJenpiID6Hr/rw2efKe72dBeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366

On 28.06.26 06:50, guang_feng_wang@163.com wrote:
> From: guang feng wang <guang_feng_wang@163.com>
> 
> Hi,
> 
> This series updates a few stale I-pipe-era references in the Xenomai 3
> installation guide, mainly around the Cobalt setup path.
> 
> The page already documents Dovetail as a Cobalt-specific requirement,
> but a few examples still refer to legacy I-pipe references.
> 
> The changes are limited to the following patches:
> 
> guang feng wang (5):
>   doc: replace legacy I-pipe usage with Dovetail
>   doc: update stale Cobalt kernel preparation example
>   doc: mark old PowerPC and ARM build examples as historical
>   doc: generalize ARM64 Cobalt build notes
>   doc: update Cobalt boot log
> 
>  content/installation/_index.md | 39 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 

Thanks for the changes already!

I just realized that our repo is in some limbo state: Philippe, you once
worked on that "v2" branch, IIRC to update the hugo theme. We never
merged, and I forgot, why. Do you recall?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
