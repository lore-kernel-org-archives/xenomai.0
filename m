Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3667464
	for <xenomai@lists.linux.dev>; Thu,  8 Aug 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102855; cv=fail; b=bdpTonIZtRNBFVEzLq8owbRGFACPC9lK7pADFZxcZkNnLteYw2KSo5pKPxpi/GbbXdNHBtF1LUsRyLkbcMCpQ+/NihOFUCLoWCGrNVu1iF+mv3FBSWepMC66X09+AXUfeGpOXqaxzbMnVWsxCpcWxVyLO9MbN3mxh84VNkejaEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102855; c=relaxed/simple;
	bh=CTmgoTsk7xt8QK0bdFpjZ3NX77RpxWcmkZX8JRi5UtE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3Q8lhzMaaesVg9/WeMccuHgD5h4eRrdvVPw5P+gnQuocHsn8tv0SzWnVrzSZKoaw6k6x/ETqAWDwQV1fkmPnexTlJk3ASjFM5pyXXD6BrDF7QpN4J6UPf5L5Tl+gIEZdzQ59vMTkvARcPfiiql0lYhVYAY+wxp5QXwZiX8d8t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A9j+jC7h; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A9j+jC7h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY6Ca26tSodr1KuDj9ffqJw1m96deClLmMECDr+g5zCYqL1BnD4OeZQo/FyQBnDUO2VBsbac93Aru/hdttNpPxBuv6vOOsifkVDs89kmrF2TQWWRnaeMVaBk7avBYIgaRGJmCukEaSLlPoZRRYxrhAlL+Ctn4MTpw80v9jOUWIvv5rXbtfaFUb79KvNsDfGWZQMstOGdP/nXVwFsW+cNllqlMqgDp/elFcgEdBrIGNcEhJt4VNV+yPxSPw7v43PTY4tL53i2OnJvUUZyChX7rqYOjKXgZqYWEyk+OeH/+4HyedBiLM4kvcE9XyV6rT9Fv8yRMXk+6pb71h/YxNKFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1i/WWy9WDGf/miOjS07il32DCoYmvPkLlSH01lGfVE=;
 b=DXP+I22EEUtjg8gyPO/B5L+hDkGvyDZc9tBPCizXnn0pI3KrTT7eyuWAtzFz6rFeNW6oGN1/WN/8xaOJbDCxvr9cJu+BiubLlVDcyf7q0dLz4EWtKJgHTh3IztPZ+aQMpYtxVdaK5R+slLqkUq29s1f18uHeLMM3PEarPGSMbUNPff5PqVu6Hs02+WW8mPetAxf+Eo90ib/SrHr1vW4qqNWCBee5n948h5E1lPlVdRAnHM4ondzLiun3hs6fOKFiZuCBVfZU9cKW6eW101o+4jPRacB6DZgaJtDkaV22RbZhHkIUvo+ro/zNfnPMk1wsHt+Bk+5gbR6onKJ7TKTEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1i/WWy9WDGf/miOjS07il32DCoYmvPkLlSH01lGfVE=;
 b=A9j+jC7huF1AaavJpxos+pyBVXZVYCMBxVXYkVqFQuX+tbi4k+Br9RebZxFMHovw2ymPiFOQ+LpgrGJrBvv3FHpQSWIrlz7hOY9ovA03IBN0IUr4QdZGGzoe4Ma9pMWzfMle0xnvSb7W99cFxO1sDR3fyipqC0QsphBo9rHMlbXmV+eh0jpAZL0z9fTr5coh6aHVMp0PiQkm4sVEqZPiyHhtFNAiqKOlvt0B+SgcaWr4eG2EF9ChPFqmWwUhd9COBQOtmNb9JLvkcJVx1mQTfKNT+AW052UXOEotx7jEW5GMcCDSnYikafG0RT5feoHVL3wmtNjG9k1+u0tNfAsuOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8700.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 07:40:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 07:40:47 +0000
Message-ID: <3bca4441-c7f3-44dc-a07d-865205db4b7b@siemens.com>
Date: Thu, 8 Aug 2024 09:40:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: Account for different platform driver remove
 callback in 6.11
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <c91fe1f4-5f33-4bfd-b869-be2d9ba352a2@siemens.com>
 <bf4e1f32bdd708d5a438e87e697e40c404b0865b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bf4e1f32bdd708d5a438e87e697e40c404b0865b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcf8cd5-cb1d-457a-41db-08dcb77d6ad7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlZQTU1ZQzVmWVN2SmpYN1VtUTlZTVhPVlNFMDAvMmhQRDNwNUFTdHdDcTBi?=
 =?utf-8?B?ZnZuTUorWDRLNXVXd2U4a3BNZjI3eDRnUjk3dW5xZldNZDN5dWNKV1JtTTE1?=
 =?utf-8?B?eG9GUWFUR1JqMGJMNkZxWUhnVGtXVUtvWVkzYXZMcTdzUGo0WWVhMzdISHAw?=
 =?utf-8?B?a21oMVZhZS9MV1o5NFpkWm9ISlFlWHhPdC8yN0lOZ3FaVTNnck1KczhzNWV5?=
 =?utf-8?B?OVk4VC83ZmJTMWJlVGFrUkpTaFkzdHdpbGxyaFh4cndXM0JCaW5TWjI4Mlcv?=
 =?utf-8?B?OTZUNi9xd2tBTWd3YTdZZ2NKdWJ1UHI4cGdWZDhyQ3V2RTMzUzNUMFkrQmFr?=
 =?utf-8?B?Tk9wYnl0UEViQ3lkbjVwU0NtZTJ0NEZKeXRtOXhraVpld0hnQ3NLUjcyZENW?=
 =?utf-8?B?ZUViblRlTFRqWEZSUHhvT25RYmtqSlZDVGFkTG1DcVEvakNRek91WmxFcGpH?=
 =?utf-8?B?SHpBSkZGYW5ISGFNaHExSWlkdWhmTlRFenlBMDh2Y3BjUDIrclhUTGpXTjRH?=
 =?utf-8?B?VlBSN0FKRVBNNTR2bHZNbms2ZzB5UXVCV2E5ZGFMemUwaVNUV3YvMmFVcjh0?=
 =?utf-8?B?QUNvbmJWK3dWcXBLMzRrRUFPRnZJMW5nbG5Rd3E3RmtMclVPNWJsdXY2YVdi?=
 =?utf-8?B?SzhHZmM2RXZUZG9oUzMxMDF0bS9YV2NVajhwSTVIelFEWWJ1QVUrNW0xMWdV?=
 =?utf-8?B?QndRbGs0dnBZeTdqenl4MXZmSDV0VjNmSXdiSkt2bThsWDAyNTd5OFpPMmNi?=
 =?utf-8?B?d1JERlJMMTkwcUFySHU1WFg1VlltUGZRQVV5K0dqZkhqZW9ralorU1BDN1Ry?=
 =?utf-8?B?ZndEM1Y4ZlpTTEcxQkcwSFhCR09jaitsQ2xrTmM1NTE1Z2lLbEdZSm5LYW5o?=
 =?utf-8?B?MVhFUjBLdWZGOVpEbDJJSE5VbTVKS0U2c3VMYzJnZFgxV1FxenV2b1psM1Bx?=
 =?utf-8?B?TndZZ2ZmcUdkMW5vVE1HNGRwMUNzbXpSRDNPaXhadnhoY2wyWXRseDVNZ0dY?=
 =?utf-8?B?ZzlndkFncnlxc2o0NjJiNFdjWldtTFEzVlNkNmVzcXN1M0VoYWIxdDVxS0lz?=
 =?utf-8?B?ZlBXczZBTEFuU3N0a2gyNTdRbzZVRVFBejMvV2kyN3RZZWtRaWVkbFhIVW8x?=
 =?utf-8?B?UjhsMlJFcjNEWVN0SFNUQWdsMThoV1dWaDk0bUxtSVdxZ3N1SHp1d2cvNVFX?=
 =?utf-8?B?Ky84b3ZaOS9mWHdNdTdDVFMyUEdvK2NZN3FqQUF5OU1WVGk1SmlwUkxadVZO?=
 =?utf-8?B?YUoreVZUSUdCVlYvamJWYnBTTWlPZEhhU2hHbHlzWGJqOEIrNk9JMnpNUHdy?=
 =?utf-8?B?b3YrSWF2eFpIbldrdHBQYVJGemNKUkFDRXRrNk56NENvUWlRUDZuS0U5TG1M?=
 =?utf-8?B?LzFkMjBDeGV5YW9EcXZkRmhtRDVmNHhtc2ZCRDlzUncxcEkyQ2Uvbiswd2JX?=
 =?utf-8?B?VnAwczV0SUFnKy9YUFg2U3p4MG4yalFzNi9mUllUVXVQZVBUaUpGaldhNC82?=
 =?utf-8?B?YnRzS3pVMGRlYWxiYkFlTnp6MzhYOFl4NXJ3cERhM3RUSVhnVy9rZEpNOGZa?=
 =?utf-8?B?UVRpY3NzaWs0VlJiaE1xY1ZpTkE4L05YS2UxZHhEc1lqZEhmK2EvZVptNEZv?=
 =?utf-8?B?ZHQ1b1E5NzRVN0hvc2I5RWZpWVJqSXBwUThTellsZ01DS3BwdDNBL2dHTFNr?=
 =?utf-8?B?TUlRUEFPb1hWVUwvakwrNm51RkZDYWE3RDBKbnF4MUFmWWpPWXpjdlJCUWZB?=
 =?utf-8?Q?7y3ycHw6lkF7bciwpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhDdWVtR1pMWDhqTzVqTkgzWlc5WWtUb2Z5dUx5UkVTaVJvWVdJeEZ5b3Nx?=
 =?utf-8?B?UlMyZ0JGQU1kaWRob2p4Skc3Ulpkb2Z1Q2FiZkxHcitNSTNUbFU2VG5adEw0?=
 =?utf-8?B?bFYwbHg5KzlxUzlLVExJRU1FL0dJdHllRUFyV1dyK1F1SU1VV3F4WGtIUnFW?=
 =?utf-8?B?WEpmKzlhT2tOUXZHYzJaNXF4cnFISm9pU2tlNEJhdERqUkpGYlNrcndabXU2?=
 =?utf-8?B?NURHejAyZ055VmM3OVpzZEU3bWtXTkVzYnMra2I3NWY5eHFFb3N1cUxWVFFU?=
 =?utf-8?B?VjVWTVRIbG51ait0WDZuS3RxYXE5cWxpRnVlZjJ1d0tIVmFYUW56OUo0NjJk?=
 =?utf-8?B?cnNoeWp0aE5kTU01eUw2Y0lpbFRqK1VSSkY1S2d0TlRLTFlLRDZnamFYRDcz?=
 =?utf-8?B?cnBnZVVWRHp2aU5lVklNNTJpcE5qeUJmQnpmd1R3TnppODZsaDZockZlNzB6?=
 =?utf-8?B?bmVyY1pnbW91dG9LZ2RXM2lVNXk0d1BHVXNCYm1sWTBwRFQ5Z2RWWkRLNGNY?=
 =?utf-8?B?RmdwWlljWVZ2ZHErZEZYeklCSlpNYVVRMGJ3bktIYmVJWk1Lbllkd05RSXk5?=
 =?utf-8?B?dk9oMWVuMlZrejFiRlUxQ1hRRElmV3Y2ZDl0dGFDdmJ4ZXVzUXp5czQ3THVB?=
 =?utf-8?B?a0R4UXZmaU93dzBsRkpZNyt6d0lOWHljcEZvdlREeVBBMndFNmdodzRpV0s1?=
 =?utf-8?B?WmYrR1c2ODZOMG1rTG5JVWVwbHlreENLaGpDaXJPUnNEcHEzSHY1QUcrT0gw?=
 =?utf-8?B?VVVOV0xMU3JIRnp5bTk5RENBeFVQL2JaN283R2tsZytvejhRQTJiOGpQT3pv?=
 =?utf-8?B?UFZ1d2pzM1o5KytrdGcrcjd1Z3VONmdZdk15RkxlZm1pWGZBSWt1dW1hSjBo?=
 =?utf-8?B?Nm9uRitNS25aWHJLK01TR0RCRVhneTcwbG1FcnhRZGgwc0NIQnlZT2x5anZw?=
 =?utf-8?B?TC9qVGVaR3VBcWVLTHlBTWV0WXVHMm92a1c5UG14WTJrVVVmN0dIbXlGcUJ4?=
 =?utf-8?B?K1R0NFdzVzNYUmcyK2c5M0FjeTQrMGtOdy91QlZtcVZXRHVFUFVERS9Oem84?=
 =?utf-8?B?RnVoT21nSExqVkwzYWVCRVo5bkZFUW9TMmtBY2lEbkRqTnBRVHM5bHZqY1ZX?=
 =?utf-8?B?SlUrZjdvWkNPa05tOGNVZmtwQi9wMjV0SUovV3NRMml5VmJZdnh3bWFNRGdl?=
 =?utf-8?B?RS9qNlNWNUFVMEw5WTBKM3YyNCtQbnVJekhSdG1YWjhxK2lIZW0zNFNvL3VF?=
 =?utf-8?B?UklWOERXZkwva0lhOUl0c2lDblBzeUZDMm1LVmdMdGdLLzc3UmNXcDBqZkM5?=
 =?utf-8?B?VmZ1YkhoNTc4VTI0RGdHeGhjZ3hVYTZpOEZtZzFRc1JINCs0Tlc3RDNJcTB0?=
 =?utf-8?B?c25oRDhNT1FOMWZJM1dBWjdsRHdDc0dWenVuNlBLdzU3eGdiVDlsTkxsK3Z1?=
 =?utf-8?B?U1BrRWZselM2dEptN0xoRVF6YlJubFU2amRFUGpsOXd3UGVUR2lXTnlXMEJs?=
 =?utf-8?B?UjdTVmxyOGIreTVHZGlMZ1R0eEtQS3hKY1F2eWx0aWwzRkJpUnBmb0djKzRi?=
 =?utf-8?B?WXRzQUUwNnVaNzVPWUR4bXBYY3ErVllxY1puZHVkTEduaWlLc3FtWGcwRXov?=
 =?utf-8?B?T25QMy9BNW92dmo0U0VaeEszclBKUFYvcHFnVmdzTis0UTBJM1BFQUxYL1FN?=
 =?utf-8?B?OEp3U2MraGgzYzUvcDh6ODAzQTk1UG1iY3hCNmFnbWJmR0E4VS9ZcGFxMC9P?=
 =?utf-8?B?MHN6R1RKNkZ1VmljMGIxUUxaN2xlVUJVNklrMWU5VEFITm85U2gzUlpoQlZQ?=
 =?utf-8?B?R3U2cVlISGZqeEZVSDRUQ3lBeVVYQ0U5MDJvWmI0RFkweWtXZVVVS3owbmVT?=
 =?utf-8?B?cXhwNTk3SjArK0VQb0E1M1FDcHh5TCtQbnE3eC9CYXRMUHd0Q0ltQzJva3dR?=
 =?utf-8?B?RWhobitRMUlVV2pWczJpZW8rdlY2MXBZcUxQRTlCcnMrQXJsMjlleHNUNjVS?=
 =?utf-8?B?SDVtcG1BVnZoL3hzcTAxK3dvUnZJTFRRRGVRMi9iakhEU3c1dmVFN0tZY09i?=
 =?utf-8?B?SDZ2QnhLUWZxQ0lySkRHbDkrVnNxVjcrYVhPdzdHOHJFMWpkOEgyd3dySUJi?=
 =?utf-8?Q?VCa/LYrWVYHcx3auVXYqkP/q/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf8cd5-cb1d-457a-41db-08dcb77d6ad7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:40:47.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jgE8Q8CE+CaVXV4fiY1IMR2nyWqbXnSSYIO3NW/GrCHOy8koJXAoCRYg07rsrG7lHpOW+jRcEXJ+2JaP3hurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8700

On 08.08.24 09:35, Florian Bezdeka wrote:
> On Wed, 2024-08-07 at 23:29 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Unfortunately, this requires a bit of #ifdef'ery.
>>
>> The fec driver was the only one actually returning non-zero as well.
>> Adjust it to what upstream does.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../drivers/can/c_can/rtcan_c_can_platform.c  |  6 +++++
>>  kernel/drivers/can/rtcan_flexcan.c            |  6 +++++
>>  kernel/drivers/net/drivers/at91_ether.c       |  6 +++++
>>  .../drivers/net/drivers/freescale/fec_main.c  | 22 ++++++++++++++-----
>>  kernel/drivers/net/drivers/macb.c             |  6 +++++
>>  kernel/drivers/serial/mpc52xx_uart.c          |  6 +++++
>>  kernel/drivers/serial/rt_imx_uart.c           |  6 +++++
>>  kernel/drivers/spi/spi-bcm2835.c              |  6 +++++
>>  kernel/drivers/spi/spi-omap2-mcspi-rt.c       |  6 +++++
>>  kernel/drivers/spi/spi-sun6i.c                |  6 +++++
>>  10 files changed, 71 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
>> index 0d29d98771..aef6f8895c 100644
>> --- a/kernel/drivers/can/c_can/rtcan_c_can_platform.c
>> +++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
>> @@ -432,13 +432,19 @@ exit:
>>  	return ret;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int c_can_plat_remove(struct platform_device *pdev)
>> +#else
>> +static void c_can_plat_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtcan_device *dev = platform_get_drvdata(pdev);
>>  
>>  	rtcan_c_can_unregister(dev);
>>  	rtcan_c_can_dev_free(dev);
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver c_can_plat_driver = {
>> diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
>> index edaaad7031..1658599232 100644
>> --- a/kernel/drivers/can/rtcan_flexcan.c
>> +++ b/kernel/drivers/can/rtcan_flexcan.c
>> @@ -1482,14 +1482,20 @@ static int flexcan_probe(struct platform_device *pdev)
>>  	return err;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int flexcan_remove(struct platform_device *pdev)
>> +#else
>> +static void flexcan_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtcan_device *dev = platform_get_drvdata(pdev);
>>  
>>  	unregister_flexcandev(dev);
>>  	rtcan_dev_free(dev);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver flexcan_driver = {
>> diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net/drivers/at91_ether.c
>> index f8223b0bc5..a5ef40c579 100644
>> --- a/kernel/drivers/net/drivers/at91_ether.c
>> +++ b/kernel/drivers/net/drivers/at91_ether.c
>> @@ -421,7 +421,11 @@ err_free_dev:
>>  	return res;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int at91ether_remove(struct platform_device *pdev)
>> +#else
>> +static void at91ether_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtnet_device *dev = platform_get_drvdata(pdev);
>>  	struct macb *lp = rtnetdev_priv(dev);
>> @@ -440,7 +444,9 @@ static int at91ether_remove(struct platform_device *pdev)
>>  	clk_disable(lp->pclk);
>>  	rtdev_free(dev);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver at91ether_driver = {
>> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
>> index d1b6fd166f..9561fbc589 100644
>> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
>> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
>> @@ -3522,8 +3522,11 @@ failed_rt_init:
>>  	return ret;
>>  }
>>  
>> -static int
>> -fec_drv_remove(struct platform_device *pdev)
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>> +static int fec_drv_remove(struct platform_device *pdev)
>> +#else
>> +static void fec_drv_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct net_device *ndev = platform_get_drvdata(pdev);
>>  	struct fec_enet_private *fep = netdev_priv(ndev);
>> @@ -3532,7 +3535,9 @@ fec_drv_remove(struct platform_device *pdev)
>>  
>>  	ret = pm_runtime_resume_and_get(&pdev->dev);
>>  	if (ret < 0)
>> -		return ret;
>> +		dev_err(&pdev->dev,
>> +			"Failed to resume device in remove callback (%pe)\n",
>> +			ERR_PTR(ret));
> 
> No bailout anymore?

Yes, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/freescale/fec_main.c#n4571

Jan

> 
>>  
>>  	cancel_work_sync(&fep->tx_timeout_work);
>>  	fec_ptp_stop(pdev);
>> @@ -3547,13 +3552,20 @@ fec_drv_remove(struct platform_device *pdev)
>>  		of_phy_deregister_fixed_link(np);
>>  	of_node_put(fep->phy_node);
>>  
>> -	clk_disable_unprepare(fep->clk_ahb);
>> -	clk_disable_unprepare(fep->clk_ipg);
>> +        /* After pm_runtime_get_sync() failed, the clks are still off, so skip
>> +         * disabling them again.
>> +         */
>> +	if (ret >= 0) {
>> +		clk_disable_unprepare(fep->clk_ahb);
>> +		clk_disable_unprepare(fep->clk_ipg);
>> +	}
>>  	pm_runtime_put_noidle(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>>  
>>  	free_netdev(ndev);
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static int __maybe_unused fec_suspend(struct device *dev)
>> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
>> index 77957d9062..6da5761479 100644
>> --- a/kernel/drivers/net/drivers/macb.c
>> +++ b/kernel/drivers/net/drivers/macb.c
>> @@ -1769,7 +1769,11 @@ err_out:
>>  	return err;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int __exit macb_remove(struct platform_device *pdev)
>> +#else
>> +static void __exit macb_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtnet_device *dev;
>>  	struct macb *bp;
>> @@ -1795,7 +1799,9 @@ static int __exit macb_remove(struct platform_device *pdev)
>>  		rtdev_free(dev);
>>  	}
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver macb_driver = {
>> diff --git a/kernel/drivers/serial/mpc52xx_uart.c b/kernel/drivers/serial/mpc52xx_uart.c
>> index 68d1a4cbda..1347ac0b38 100644
>> --- a/kernel/drivers/serial/mpc52xx_uart.c
>> +++ b/kernel/drivers/serial/mpc52xx_uart.c
>> @@ -1360,7 +1360,11 @@ out_kfree_port:
>>  	return ret;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int rt_mpc52xx_uart_of_remove(struct platform_device *op)
>> +#else
>> +static void rt_mpc52xx_uart_of_remove(struct platform_device *op)
>> +#endif
>>  {
>>  	struct rtdm_device *dev = dev_get_drvdata(&op->dev);
>>  	struct rt_mpc52xx_uart_port *port = dev->device_data;
>> @@ -1376,7 +1380,9 @@ static int rt_mpc52xx_uart_of_remove(struct platform_device *op)
>>  	kfree(port);
>>  	kfree(dev);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct of_device_id rt_mpc52xx_uart_of_match[] = {
>> diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
>> index 2b2dbeeb72..bc5f4a8ed7 100644
>> --- a/kernel/drivers/serial/rt_imx_uart.c
>> +++ b/kernel/drivers/serial/rt_imx_uart.c
>> @@ -1597,7 +1597,11 @@ static int rt_imx_uart_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int rt_imx_uart_remove(struct platform_device *pdev)
>> +#else
>> +static void rt_imx_uart_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct imxuart_platform_data *pdata;
>>  	struct rt_imx_uart_port *port = platform_get_drvdata(pdev);
>> @@ -1610,7 +1614,9 @@ static int rt_imx_uart_remove(struct platform_device *pdev)
>>  	clk_disable_unprepare(port->clk_per);
>>  	rtdm_dev_unregister(dev);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver rt_imx_uart_driver = {
>> diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
>> index fabfd4a59c..4a1a6f201c 100644
>> --- a/kernel/drivers/spi/spi-bcm2835.c
>> +++ b/kernel/drivers/spi/spi-bcm2835.c
>> @@ -670,7 +670,11 @@ fail:
>>  	return ret;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int bcm2835_spi_remove(struct platform_device *pdev)
>> +#else
>> +static void bcm2835_spi_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
>>  	struct spi_master_bcm2835 *spim;
>> @@ -689,7 +693,9 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
>>  
>>  	rtdm_spi_remove_master(master);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static const struct of_device_id bcm2835_spi_match[] = {
>> diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
>> index 976d28dc5d..6b5c11b71d 100644
>> --- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
>> +++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
>> @@ -993,7 +993,11 @@ fail:
>>  	return ret;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int omap2_mcspi_remove(struct platform_device *pdev)
>> +#else
>> +static void omap2_mcspi_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
>>  	struct spi_master_omap2_mcspi *spim;
>> @@ -1010,7 +1014,9 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
>>  
>>  	rtdm_spi_remove_master(master);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static struct platform_driver omap2_mcspi_spi_driver = {
>> diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6i.c
>> index 72a4abd0d7..13dd325c91 100644
>> --- a/kernel/drivers/spi/spi-sun6i.c
>> +++ b/kernel/drivers/spi/spi-sun6i.c
>> @@ -629,7 +629,11 @@ fail:
>>  	return ret;
>>  }
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  static int sun6i_spi_remove(struct platform_device *pdev)
>> +#else
>> +static void sun6i_spi_remove(struct platform_device *pdev)
>> +#endif
>>  {
>>  	struct rtdm_spi_master *master = platform_get_drvdata(pdev);
>>  	struct spi_master_sun6i *spim;
>> @@ -645,7 +649,9 @@ static int sun6i_spi_remove(struct platform_device *pdev)
>>  
>>  	rtdm_spi_remove_master(master);
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>>  	return 0;
>> +#endif
>>  }
>>  
>>  static const struct of_device_id sun6i_spi_match[] = {
>> -- 
>> 2.43.0
> 

-- 
Siemens AG, Technology
Linux Expert Center

