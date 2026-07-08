Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55345356765
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490877; cv=fail; b=o49xxxCePt6luMKwApe5UCev7EVHOQekN500V3laF5+rWFmbO+QXdFbj/c8Xz1aXMlSSH+AOqebpy7htyVFxcW0Fh+TpXcVDJo6EszxNB29EWemplIweHO6lGlKnBsOffN1bE0zjy3xhURBYTRXpOgtCWbyxs/Uicz2fSULGbN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490877; c=relaxed/simple;
	bh=2yzpEVCEWqD6Y7vBnVgwWzWXRCT9t8MEgj4e2LszPiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+qlkGht74lND9WEbzmKZXhRG6nFGw54jJR7rgBA2uYcHQ4QNgd/C8yq6fVcNBvIV/MEztSxg861YXDdCced5nJzXtaFl3AXvY0zqbFZT0AIIaCKc1K11BFrdleN5wmKcRYU0pLzjUPVXdHy8qlGmMNWn+4C4j2FDZrjBnuCu/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z7F6I5O6; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z7F6I5O6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxtupr5d2QnSWWDJ5g6+YK/gDJ2CnT9Q//wKig6CjaKMzLTFrXMU/iYBPm93rAjPez4LKTiGC17ficR1DdT+QkEATXsNYT4fk/ikBqBNNcxbSH1Gx9ovk4rMeHOTFJ4d11N8z46nq2p7DRtgo91gxLwB6sB3TMDEk+ohFfElt8lhAxrodRu1VgEvF6FXlNjndQDbsjkZfJmwUggOgUB8giR14koHwUQjGvzlrARwsQcH9kwj5RuU6qkfcm7jFPxT2T9v/BtqePsteYmRfiAX+OPLCJWGhCqV3ebYUEpVEi8at5TDrVnjcMlb+BkPAgaKyhr6oJZ8K/eux+oVER7bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fwu14Pa198EOtmeNB+vDOlGouk2y5cTw+5sMPTRN/Q=;
 b=qLY5/FCf5COQSaOlRydvYWAoUNyjI01yrqcDF/Ar5qvjpW7uH2WEdP+y/pmm1YETuHJcJ7MkqtCHUyDnzRjMnxJyKneatORbiq7BjzMeRSp9lRvSnNOd3XqAstiUkJt4ZgUo7CnKphn5KpryJkiXxYWUgzaHUDN8zbAnXtYKOf36Z9C4gA0jYbpYqZXW1bpjdpbLdkgHupf3ClTarZXfmmPx81M8UDuTp11LPXVlbTvu2u9EpPOviKdoFqxBgRCSvAab1KNstSDi3mRF6Hnmc/cOPNWWtBaF4ZtijOMkYRKV4y9lPG096oL27dRr22zV/eSvYw5kX45qxaXzlLSYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fwu14Pa198EOtmeNB+vDOlGouk2y5cTw+5sMPTRN/Q=;
 b=z7F6I5O6UGWnLg3gMFvXmEx2904HTWd91PsyYQhk2KaYwMLFZUzO6uXaOQcXo8To+If/qgb2+mXNk/eD0OwfhQ7zfu/WQy/YCk9NdfFBf2YNOOuhg1MzTT6Z1lmBEcvWR/d2uLkh6rzUWX6NkmtmFcrMZPp43NmwiYTHrGzhJl64qtuI5+G2AEweDxl/GOW4d9n/FrTgKotGOzE8siLEmPuSAt6PfswUogun3rw5ACNMjqaXgh/fwVtpMvw+w9InQd8dWwtgiFRmL0P8SjMe2JAKP+qLiGl1PYaPIvUpxna6zOVAVY3U8OOlVTXJSMLZscE6tIbSO28yvBFac97Uyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:737::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 06:07:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 06:07:51 +0000
Message-ID: <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
Date: Wed, 8 Jul 2026 08:07:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b785a38-31a1-4eda-5a2e-08dedcb73e43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|4143699003|18002099003|56012099006|11063799006|6133799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ua1eIs+oY822PYBI1lU8wui20pnYLafInH1pScB8CXWjTjyfxXmagUBOW7KUfM0+/ZkHRs2wp8JXsvX9p9NGmuMQpXQ3W8sZC/fOz569FFtw4F43M3A/VqPYzBUB22zQbQvNqn1UzLyQdLEe86WBtVTMPakG7pViofyelojehgoz9FOHTAMRwvNtNukpGc5J2kjnyJKsVdkllr+5bmfv+pL0NEPbzWMtc7JK432RRpnK7OfHdepN+hKGMYnzaOrjZQ8uhhUNtUikDRq79xoV1JC99GHYzrvA1Jyh5gmHD8ZI2WauZlVOzKIwavE73ug4Vu/Kh9YkfNm0FVt9UmBeG5t/rN2b4bJyIRCsxzM/3FV92pkQFMbuiCjFJK26pGIvsm5hdHS5lOr+yqZ+mC9n9Ko6shlJY7d5pw3EoTIrAKvdcO2hwUqB1s0PoIzyb9fYZtzazmzvtu1DEAZr9p1PIXrV4d5SnR92zcaLW9h0Q2uznvxirVRG+lFEOHC7+8kQPFzsRDvXaWQmTliJUbXLh8Nvjz6esYruWIkhkq5/RTOyfg1uxbeQ66AjHrVnlB27G9BSL6hMlg0TkuYZciBGsmj6GklzVllLdLBFfzWr9qbEX2VZWr5O5cPdSzQMVay+Bwd9GeK0xXqK70Nv96AUrpF/7yj25kOcVVGg95TPzmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006)(6133799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFpV3RQMXZQaGUxV2pVZ3lUUVl6MThPWXRYcEs3ejBMR2RCRWsrRkpRRmRW?=
 =?utf-8?B?bzhVRjZGMWNSUFlEQWZvTjZ4REcrT0FtWVdIdSthbG9xTnRnaW1QQnBqN0tX?=
 =?utf-8?B?dktqUTB2S2czTW1Nb3M5bUZ1ZTc0WFMxS2tWVCtJd1h1aU5kTkRaMmpqTk5J?=
 =?utf-8?B?SVVXRUJlUHpncmFtdWs1UWtZVFV2SzFoQW41WWVubXVYMmR0aHVlMHNEZzhu?=
 =?utf-8?B?NU9kN2srZnVHV2E4ZEEwY0pxbHhVaGRhUitiMHFQTXNsRGtIKzNrZ0p5STlx?=
 =?utf-8?B?OUVEekVEdncwYUJjQ2N0ZzQzbTNEMGpTeTlJVlhHdlVYek0rQXp0YU1qeTFF?=
 =?utf-8?B?dFlkU2UrODVnZDY2d3VBMkhSVEhqQ0lyWmg4cDdaeGsvMk0xZ25raGJ6VlJT?=
 =?utf-8?B?QUNBSlFsZGY2USt2Z05lYU5QemtpbjdrVjBUNlRDL2s5UDh3OWJRdnMzUWsr?=
 =?utf-8?B?SUVTNytOMnFhNUx0bU5INTd2QjVnR05mWXdGaFdNV3FoRVlTaWZEbDNreXEz?=
 =?utf-8?B?WTlBa1NUWEt4TmNWbms3citHczZWOHVRZFJzZTJZaldCVk1wSDdmU3VXa1Jw?=
 =?utf-8?B?Zkczbm1laDFmZDZIeGp6S0VPSE4vcGxRV1A3cTJrZ25aWUt5QXNMTDJGTUVw?=
 =?utf-8?B?Y0d2OVhVVVdSdzFNZFRER0JobkZaQ3pQa2FTbHZJYnB4bUxmYjJtSEdNMEhh?=
 =?utf-8?B?NlkwQUcrS1ZXbEdqT0lTb0VSZnEwNS8yRUJpK3Z3dU8yN2RMYnlqTzVkMjU4?=
 =?utf-8?B?RHdMMjFzY0dxd0p1RWl2SGRZUE5Md0s0a0FVRlAvSHdiNHlWOWx2cGI5MVNj?=
 =?utf-8?B?WTNjWS9sZDZNNERWMVJ4Tmx3eFo2dU1xTHNZYms0WXRiVmNJZ1luMmsvU3h1?=
 =?utf-8?B?cktHVlA2dlZqRk5HVEZDQWR3Z2hiMUhQZmdRYWpNMEFCNU51TTVRMklMTlZX?=
 =?utf-8?B?eWowMVhNdEdZblg0RXFRWUJjdXd1TTZGMy8wbVRaYWJSYmYwKzlUczNyNnho?=
 =?utf-8?B?ZTlVM1pTYlUrRzFHUzluendCdmVYTDRERGoxbTIxdVEzYzJhZ2xEUVBLOUE0?=
 =?utf-8?B?L1dkOG1GSUUySmdWL0ZyOTB3RVBTRjRZSWo0ekRXZVV4S2duck5VRkdVVWRL?=
 =?utf-8?B?bEFyd2I2aEFJMHpZQnNuT0E1SHJIVWYzRlVzS24xbWN1bFpPOFI2SEpNelJv?=
 =?utf-8?B?S0d4ZytvVW1kNmpGdXdTaEpsOHp4eHNPY1FocXdwcUJmeHJFWU1OWTBheUsz?=
 =?utf-8?B?aG1EcmlhUzRYajJMNzNFbmdZcDQ5cnpJVEM4M3hpeDlQd1luY01DSEpUdStC?=
 =?utf-8?B?SHF2RmhIL2xlYVoxQWtUZzg0M3UzQWVmckZnKzk3SjNaNC9ZRGdEeCtCTTJr?=
 =?utf-8?B?c3RSd3pwMFRtdG5yRE5EUmpKZG5odytPeWZZNkYvSTFxVEg1cStKdVBFeThx?=
 =?utf-8?B?RjRHT3VqWE9XRXA2THE1U1Q4d1JHMy81ekpQaTVPUWFnWjQ2cUNwdGs3ZkhI?=
 =?utf-8?B?RzBKZ2hjajBzQUlpQWtzUVcvcUJuZU9aTk1oZ28yRW9aWk15am8zOVo0Qklj?=
 =?utf-8?B?T1V4QWhUYnNOMllTT3RyM1dJb0JpQ3UvSGZVZllIbTEzRlFweGRRVzZES2Rs?=
 =?utf-8?B?OGxUd013akxmWEF0YzBNaWw3MnYyNXZLZTk2bkhXZjkwZmRGalVDQTVCTDZG?=
 =?utf-8?B?NnByQUkzSkpUd3NuT2lNbThrUEVmb1NidGFSQ1NwdmpLemZOQWRZL0xOM002?=
 =?utf-8?B?WXRDUjU4dGxwTm9SSTZZQVVjV0MvVFd1OEhjVFhpVlVtZjJ4ZnZDc2w5YUQx?=
 =?utf-8?B?OVhDUjFIc3M4MzBNNFhhY0JnYWp5bHNiUWVMUDYwbHRhU2pnUElGZ1ZSUW5J?=
 =?utf-8?B?ZC9EcHBmNHN6a1dLdFUybG1na0NuUW5BMGx0aEwyclU1eU0yQWk1WHFTMTVJ?=
 =?utf-8?B?S1FVZWhoV3daNmg3Y3djY1NNSW90dFRMcjAzNkd5L1krWVdzSlZKR2tIaUov?=
 =?utf-8?B?ZTlmVkhhUkJodlQybTljRlpMM3FmS1I3d1NyVkRlVjN2UmJDZ21xS0cvOXV5?=
 =?utf-8?B?aDZndld1bFFrRzZiTmRIeGdHSDVtSndaMEc2TndBcWhKSEVuSEJmZWVXVG1E?=
 =?utf-8?B?eWx6YXRMMlZHT09SbFllcDJDenN2cmVCZ0xJZTJKVHNvSUZzdmRuR0t1L1dh?=
 =?utf-8?B?MUdEdEowNUdUSVlORnVQOUF6d3liWHhCYVV4S0g2K0RRYkIwUUJUYnduWlRZ?=
 =?utf-8?B?Q2J6RFIxcTkvZ0RrYnp3eHNyOHg2eDVKUVNtU05KR1RGb3FwdTNtUEJkdFF2?=
 =?utf-8?B?Y2I4c05UVTdZWkZSNlJUZlVBaTFyR1N4Q2NYMC9XTGRwNFI1ZGdsQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b785a38-31a1-4eda-5a2e-08dedcb73e43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:07:51.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utLixLA8vEm1ObF1aYXZ4Kmm/UjCQplLm7iuw8QkoM1wM1KLMTWgDPhLdPnJGU4cPvcDwt78YclVf5Tuwd1wgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9527

On 08.07.26 07:17, Tobias Schaffner wrote:
> On 7/8/26 00:30, Florian Bezdeka wrote:
>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>> Hi all,
>>>
>>> this series introduces an initial EVL port for RISC-V.
>>>
>>> While some tests are still failing, I’d like to share this early
>>> version with the community to gather feedback, reviews, and hopefully
>>> some assistance in refining the port.
>>>
>>> The patches have been tested in combination with the Dovetail RISC-V
>>> port on top of v6.12-evl1-rebase.
>>>
>>> Looking forward to your feedback and suggestions.
>>>
>>
>> I tried to apply this series today, and run into the following issues
>> reported by my tooling.
>>
>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>
>> A couple of debatable warnings like:
>>
>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>
>> WARNING: unnecessary whitespace before a quoted newline
>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>> +
>>
>> In addition to a serious one:
>>
>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>> <shanmu1901@gmail.com>'
> 
> I did not get any responses from this email anymore. I can try to reach
> out to him one last time, but what do we do about it if he will not
> reply?
> 

If I read that patch correctly, it's majority is taken from the
corresponding Xenomai 3 logic. How much is unique contribution, how much
was your work, Tobias?

Jan

>> My perspective: We definitely need that.
>>
>> Best regards,
>> Florian
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
