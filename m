Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2714F9F7
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687329; cv=fail; b=FgpSLgHDB8bBKrH7k7T/R9eJFgWNgxHzt5BgWd/GvwRvjXhryj5ST/rn2VP5p2G4NkVUgAUji0kDt8Pznnj2uvz090z+o0IiWLlkBfcqng/Di+LcjbnVL1icTIivBVjjyLKf7zMobgBO4C3y8gA1uzR+3gaYL4yt5oxtP7cztWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687329; c=relaxed/simple;
	bh=3gO9pTl/kVTQpisctP2N2R3bMPmYnUzG10pdIynr28o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iKrEzNXUCt4i06f0b4APqa+OtJZ4NW1vag0t1soNmGk0HsB5slC6Otw3wDlBkzHjZ1HvKFL0fXpaUcE5sw1hftFqwXEzSCmy8I1fXq7y9HtiA55G5fd232wjW2XDn9/5i0ac4Lu3LKgRawRTlcdYdsIb623cr1kUYQcT5PwX6AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IqldN4JN; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IqldN4JN"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id AD0FA1A000A
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 16:15:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20606.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::606])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D671E941959
	for <xenomai@xenomai.org>; Fri, 15 Nov 2024 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnjtHqRt3FEMR2O1xYRje+rWIAfNq10hJ6FlcYmtT6oK0voL19ZlpmF5HXi4o6OsxooiKKOPE9bQ/gHjBvyDdm9JIUOevwPGB4caswqG+Z6EmPhOWdGH+TsfB9vAdOlhNkxCxJBFCBQXOGuL/UL/v5Xfqy7jlhsdmMKAJrM5opzkSfmvROKTNlds3bnU5tlunJlydM1kYiN3i3aG5nDNE7PaMlqToNGUmt1WJ6whnsTOLyi/14uH/qFHYBw3iLlhLw2PERfX+TZIG4Rkk7Ou1aPUTJSHaTlxQdOjhEl5S7xCbyxUEuLe7bVDefR30VIUk5hW41ByX/J4/JQjkszy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs5C3gJcarXGgkR1r7AWwMlCbcHXDHoNPsHrSjrOCOM=;
 b=JEYPJO7lHW/FtXH9hXNcn4cTGtp/WvqOLq7bX77H3f0BqjTUqNtZOirZ9kKsqJ8bgiWDZwlcECmL7JgUWVDZn6AdofOFUdCR6bxB8hE8gbsgGa1euQUJHMj4oZS85Cm1Qri2k8lyOJ+ikQC5G5SY2CHu6sGas2ty8XBDdYcdqtQ5RsmfhBNHL4uglJ8r17G44umWy/3Yz7xE5VgUHA/5/FL5xpEZZFc8ij3eUgLk93o+BQKuzW+2RBqRSypyLg++edr6nGw2TQnXGaaocuX024dy5rFmXdiwWBLKJ6fXtpurgwq/4w9mRFDTvL8rqm3V4UBYpNDkaLkKW44yekTvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs5C3gJcarXGgkR1r7AWwMlCbcHXDHoNPsHrSjrOCOM=;
 b=IqldN4JNDqU6Pixr0ksr5I3pg74fABfdVLPM5ThUCgwlIhyfMDGvHa1sao4Wub6Wdt295lFlQyr1aG42n1XRjjFQleu1io/jmV9L/cQgteWC8P8wUUujyTzML4MDiTtAaAjJ5h+cB7OAn9cmOMDkHmPy3yYaj2mL0bK2dv9oDjqv7UqL4jh2py1DCVoXgCxdKNC4T6hVUNwdEQGRiHUffcYwM7YV0cr1H4mJ0qL0X/rPjfhoXZaQoWD4YB2M4IABSgHhL5TrPwsNiCHeaSjICLCLpRNgkUOwDC6+WnPXmAhETiXIzFyk29KmGb8GJkfdwvfKz6qG+ykml7sMxhHFzg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 16:15:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 16:15:15 +0000
Message-ID: <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com>
Date: Fri, 15 Nov 2024 17:15:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Error building xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
 <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 77447945-e9cc-4b07-0359-08dd0590b04a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODJ6UWdVVjhlcmxxa3VXVjZqQVlKTkZvaHhBSFdpOGJOVkpqWHlpaXUxMjRm?=
 =?utf-8?B?VkIzZ0R0L256RlZPd2JyMVdGbTZ0SGtzMHp4SVQ1UXdINUNicWU0Nmx2MHpY?=
 =?utf-8?B?Zmh1eGVFbXpZcXRQZlhEWGZhQlB3NHFYQTQ0UkZmNG1ST0lnTjhLV2lrdlBG?=
 =?utf-8?B?TkZ5aTkrWkhIWTc1anFSbCt2OHlaNlZEVmQ2c1ZSOEZ2enk4YXJBVVcwTndF?=
 =?utf-8?B?RzRQSlR6bTc4L0cvNmNFK1VuOWFFZ01lbitzVmd5QldGaFpYU0RaTXZCcmpS?=
 =?utf-8?B?Vjd6ZHhUZDlzcGpzWWZ5Y0J2aHMvSmN3VTM0TlFZWklrUHpCR3lZWW9PSnZL?=
 =?utf-8?B?L2xEeFQ0UThsUHhHdXlOUHJWU2JLY2c5QW0vSHlBNzJlOS9lTTlWSllnOERM?=
 =?utf-8?B?RnpnOGo2R2VNaS92SkpXMlJxQy85OTc1NjlKSnNXYk41RHk2a2hJSzJ6MXQz?=
 =?utf-8?B?eG85VHdoanR1b0xNM1EzazUzWFFiM2pEN3hJVVEvWEUvVTd5RzloenhlM3VT?=
 =?utf-8?B?K21zdC84L2VTZmtsc0x1bU0yTzU4QllmanlmaWt0ZVZ2WDdORGFzc1UwUmU0?=
 =?utf-8?B?cU1WUVdqTWhiRGNXb2lEUzJnSnNHdkh4SkV6TUpibW9NNUppNENnWTlPOTJ5?=
 =?utf-8?B?QllKSUVnVnpYU254dk5tWlkyV2RUUVhCeTJabVkyOU5GTWVuVHAyd2xvR1Fq?=
 =?utf-8?B?MDlsaFppWEJGMWhGRWdPS0NBcXpoV1NyL2JQcG56a2kvOGNtNHRMMWJQNEtl?=
 =?utf-8?B?VWk0SkgwbDhsVXZLOGJXR3IwOUhZQTUzNUh0enlqbW41TXBoRTZJWXBXaWpF?=
 =?utf-8?B?Tzg1NU9WODFzaXpBenR0MXFFVk43SGdZcTM3MWwwWEtEZVlQdDJsNG0rT1Uz?=
 =?utf-8?B?L01UREFmcWJuT3RuZnRCUjl4M09BOWpCVW05cFNBZDRUcHVwajU4Vlg5UWkx?=
 =?utf-8?B?RmJ0ZGQ1WFo5MDA2ZmZoTFJ2OWZVaTFZY0xlQUgya3AwaWQ5T3M0VWN0OU5t?=
 =?utf-8?B?Q1ROVktYOFY3NHhaSFM2NlE4VzFTdGdBVDRpMkJqREV5VmFtZlpuSHRwMHdK?=
 =?utf-8?B?bUVTSVhJSndMUlJqNHdNdlpvdTREOFFlZ28reTdvZFhyelNTYlgrNFdXcjVa?=
 =?utf-8?B?Z0YrczRJclRROHcwMFZSZGpDZHQ4NjZKdk90a3U3cG1CWmF6OGgrV3dOOS9E?=
 =?utf-8?B?OTFFRFdiK2s5S0JtOXAwUWdSQ2x1Z2FiL2JLQ3FBcDZUSmJJK05hZ3FJOEw0?=
 =?utf-8?B?cElJZEdwSGhHSFVYWENBMGtuaGlMcGlKanVtLzF0RGF0Sk9Ub1MwZXJXSVIv?=
 =?utf-8?B?Vjd0QzI5OXFnbENsWlFaaDFNYk5BZ1lBQUVycFhPUHZvV0JoRDZHRW8zWkhv?=
 =?utf-8?B?d3lIN294WXRlbUNWbzJOeWxtZkVmeHdrdjljNXFWbU1PSnpwYjdKdlF3RnAy?=
 =?utf-8?B?Y3o4Qy8vMlRodEtQUkhheEhKakYxQlFGNW9tOEJteGV0T0JJaGM0TXdlUlNW?=
 =?utf-8?B?Wkg3TkcxQ1BxcmJNR2VSWjc4eXdkaGVuc2ZtVmdUL2JXeWY0NVFNSnJWaTlM?=
 =?utf-8?B?UzY5TGlOYU9JMWdOdTJuOTZUWEJQY3FtUFBib3VxZkNhd1hVcm8ycnRjeVhw?=
 =?utf-8?B?R29VdmtxTThRNVpZVnJpMnVJZSt6VCt0SC9iWHloRXZyK3JSSGM0d1NUNnA2?=
 =?utf-8?Q?KZ3Ar06K/FX5lcERMcZV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXZ4cGI0ck5lNFVvOXN1NlNQM09PUzliU200QkNuWDNNazZ3MVdaYlVvYVRD?=
 =?utf-8?B?bXNGZjRsQ2VJRVJxVHJCK3FlaTF3elNJZlI5bTZsSUJVdmpqU3YvU1U4WWJS?=
 =?utf-8?B?eHlqOUt0dCt0aCtvQnlneUZhckJWdzZwbzBzMTRPK1NKc093b0JHM1htVUdD?=
 =?utf-8?B?SExZbXhrWFJrNk8wenFIRW5HNTVQZjY4aW5peFE5TU94OUxNaGRLbFp3dElM?=
 =?utf-8?B?SmR3V25PUHF4UnRRaEVmWHFoQUtzUlY1Z0NTTGg1YW90NXUwVUlVblN4Z2lh?=
 =?utf-8?B?ZUN0M2JhdmJqOEsrbWU2YjFtdWlacmpYbWZsU1VGTGZ4MjF1Vk9LMjJFWk5r?=
 =?utf-8?B?UjZkWU1wNUtYd3ZjajlrazIrcmtqd1pSWDAyd2hlcVFvUDFGejZFOVdWVURI?=
 =?utf-8?B?YVF2eXBMTTduMnZjL1FvMjhRQWRLb1J6eVVZTkRUNC9NT1A0cTg4bkFQUWhL?=
 =?utf-8?B?djcyb2FPcm9PYjM0M0xOYjUxTDdGRnY3NmZXMk5EYU4zbDZzWGU4aVhZZDFH?=
 =?utf-8?B?dm10dnY4ckhFSm80ZER5Z24yUzBjbW9GWG9VNlhHU3R5a0lOWWdxcHZkTkVO?=
 =?utf-8?B?ajZJeVBUKzdBbEFLZER5QW9EcjBLRGlWNmNrQWw5L1VXb0t5b3lsbUs1UU93?=
 =?utf-8?B?L1VBWEV0SWhqUzMwUTVjT3dGRHYwZDBHMkd0NjB6dEh6bCtydml0S1RlU3Rz?=
 =?utf-8?B?SHFLVEdFUXNjMm9XZ1JETUxxOG50ZXBPVWEwUG9KZWJPWGZPT1JXc2Y2Q1Zm?=
 =?utf-8?B?ZVJzaTJpTCtaVThUMUdZNjZ0UmV4Tm93UW1LeDNmcUpydWU2T0hXaDZ3Mzho?=
 =?utf-8?B?OW5XRFNvbW5nQlR0WmxLY01tT1I4clJ2OFBYN2E4VDh5amRWYTJjR2JqS1FX?=
 =?utf-8?B?ZmkxZHI5TEVIMDIvYVQ2TGFQeGxJRFlaV29LVG9aeFVwUEYzTFBIYmNSUHh5?=
 =?utf-8?B?dTZmUXZmRU5LN2RvWXFZOFl3M1ppSm91T2NXZzlGYi92Z0JWTDcxRm5UdU5u?=
 =?utf-8?B?QlpxTGRvV25aK2JhSEw1Y1ZTV2M3emUyV1lvNXlIVXNycUkxV3pMMnY5MjBP?=
 =?utf-8?B?dFI0NktGNFJkaDlheTNHUy9yejZueHlJa0JLUW5Ua3Ixemx0TEJ1T3IwSmdS?=
 =?utf-8?B?aFRRcmdKTU13aGJ4V3RaWWkvMDNFSm5ERzU0SDBzKzBiSnF1c2RDNW51U0t4?=
 =?utf-8?B?am5ZclBLeUZ1ZDFqcjBzSmNFMUJuM1U5VkZSUEo1dkJmYnpwZkJCMmtVclE5?=
 =?utf-8?B?VnZxZVd6NjZ3SGliRHFIZFp1TjUwWXI0d1JEeSt4bm1PT0J0bmhZcEFUQzh1?=
 =?utf-8?B?emFTdWoxMlVvWEVSajR1clVnYWpNbGZOV1dQTUVhcC9Hbm5DdUNkUXllV25h?=
 =?utf-8?B?SFlwZGVvMFdqNVBGUVRLQ1Q2T2F2Nk9HTDl0eXhWQzRyeG84Z2EvdEt4bHlo?=
 =?utf-8?B?OHp2aElyMXpWcUFtakQ1Y2ZHUXlObytEUThFRVJ1dkUvMi9kNm9yYWVrWk1l?=
 =?utf-8?B?UDlqVXhhbVg3c0FGd3FVY3MrMHNsYW1xVGdBZ3JmYWxJbDhaZDB3NERQSWUy?=
 =?utf-8?B?M1N1dzkvcjNtUk92cGw2UzJvaGNYVjJkSHVWMFhzVkNDYTRqSW1RNTdsQlBn?=
 =?utf-8?B?RWJaMjBVV0J6L1pTcFNZbVVzdXlsbkFkdGFqdEtncVE2ODh1R0VZWkZmTzFQ?=
 =?utf-8?B?SmJlcFpXU3pyWTltekpJZU9oSk5OS1JKWk42QjhCSHBwb1lVOTJGWU1TV2JL?=
 =?utf-8?B?RHkwR0U0R0xDNmhYVU5lMWlIQ2Z0ajdyZzl0VFN2bkRoWUJWU2R6NFE3Z0FT?=
 =?utf-8?B?NURuRTI4R005MURJQy9HL1MvckUvd2FZLy9vQmdiSjFOdzNUd3hQcDlFMmU1?=
 =?utf-8?B?SjV5NWx0WTZuZEpUR0Q3Z3V6WklmVUx5cHNIaSt5Z0tJWkF5eUdqNmZDaDNI?=
 =?utf-8?B?QU5BaVpTL0tqNXkzaDdEdjNXMGk5YVVpREpyZkFYV1g0MEJEYnc4MnRjNVBl?=
 =?utf-8?B?NTdleURTZVpVcmFBWmRGbkcwdWR4RGl4dFJwemJ1aDY5RDh6elhMQVpVdDRN?=
 =?utf-8?B?WndVbE9aZkNiWGt5YjIzR043azRkek5DNDlIOFBKcC90KzlGbE5qbE1yMGxh?=
 =?utf-8?Q?sjPwIYJM5C8o8SWDlsErgNddy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77447945-e9cc-4b07-0359-08dd0590b04a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:15:15.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaZq+i+0NzUi3gt92/pPkRsWUQ1sgI0rcLw20M01SPkt8nVn8Z1u5ZWBN07xfx4Au/EjBNA6GSOYnJIY/lpKzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6347
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=IqldN4JN;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2613::606) smtp.mailfrom=jan.kiszka@siemens.com

On 15.11.24 15:40, Pierre FICHEUX wrote:
> Hi,
> 
> AFAIK I use Docker (and Ubuntu 22.04) .
> 
> docker run -v /home/pierre/Yocto/xenomai-images:/repo:ro -v
> /media/pierre/SANDISK_PF/Yocto/xenomai-images:/work:rw -e
> KAS_WORK_DIR=/work -v
> /media/pierre/SANDISK_PF/Yocto/xenomai-images/build:/build:rw
> --workdir=/repo -e KAS_BUILD_DIR=/build -e USER_ID=1000 -e
> GROUP_ID=1000 --rm --init -t -i -e TERM=xterm-256color -e
> SHELL=/bin/bash --privileged --log-driver=none --user=root
> ghcr.io/siemens/kas/kas-isar:4.5 menu
> 
> 
> The log.do_bootstrap contains the following:
> 
> DEBUG: Executing python function sstate_task_prefunc
> DEBUG: Python function sstate_task_prefunc finished
> DEBUG: Executing shell function do_bootstrap
> W: qemu-debootstrap is deprecated. Please use regular debootstrap directly
> I: Running command: debootstrap --verbose --variant=minbase
> --include=locales --components=main,contrib,non-free-firmware,non-free
> bookworm /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs
> http://deb.debian.org/debian
> /usr/sbin/debootstrap: 1764: cannot create
> /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs/test-dev-null:
> Permission denied
> E: Cannot install into target
> '/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs'
> mounted with noexec or nodev
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your workdir does not allow the build to create device nodes.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
