Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B355223
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282750; cv=fail; b=hAEsmG7fSrytCvkjCcXpVbU3B7yAPGlsVf6GQLOXbLRNapllzJ7hvzIu8iGMdlmse37UBQKquiJGiXwf2HkK0pkyegUPHVfuds32qlj/ZO+i/V3p1bki5HEXiwmq/M7OTxLcitwO16P0D/CJOG4cPEF2pcrDQreIcRaIRU9wn9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282750; c=relaxed/simple;
	bh=j/bCOwMc7/alukTCCp0ElXqmefBIOuHUtECx6tq+jos=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KeCZKzcC1yoQOqNJop5Gj/VrT9wvkNpRPwjx95e5yATUmAtc6BFPaagAHB0CybzLAAMbwtYF8vtiY+L3vZUTHVmm2yvbxggzLcehK1FvQ1w44qP+v12jPpoS6J1LBKnd6DtfEFXpPA0qbuPsFYgJrmw5meMc5lM3a/HncNl5uaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k+4xZyWG; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k+4xZyWG"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 45B46200004
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:39:04 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 68A3A7803CF
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 13:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vObZqRgET6V3ta9oYvIYeBXnxZHdC48YZc74ia234DZbN8nL5JpB+miczeBgPmgYHXxQqSV1nNooQgb4O63/CllwqT3AWN+zMQsJ4SNzHljsy6jRPsJ7ZN5rZZkUy2bvYBSI4Iy/D0nZ5ZA2cuhkvVYTAKQkuIE2JCYSzI61TYCCmQY5s8mlUQ6dE8p09kgUUSs6fYFGdVXq04JVcpG1E2tnJYfo/o7DTWss+TNemu9+Hkv20PQze/NNHe6sW8BgRQy0q+pSYxth7l+npUIkc52OELlhEYgFKVU9L8C2lUbR/ODU7NvD9c1KF2lMoaCpnEMbIHguT8PpETnX+lVkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0d2Qwy0FoNkrqb+YUHquvp0nwiinjib1qx+ZBrbEdI=;
 b=hetbyIYX4AVKi5x9d3A5aSbtmD/x9VVfR3WaCIOInMp18Oy9GpHMWWAGzHhWM9hnw7rBrWJWrzE5BhhcKc8gbQ1Ww1MEI5qgZLpEPOK/YDU8USFm9X0QP7FBr3326kMGhu9W3G7JlgUnEh82GQxPbjd9+/Ldbp8XmHrUGPnywXyREC6NHEFF/aw1mWNGcLcULleQGwptA9z9ho8unNdAuYh0uwxEoFdXmvMScZf5uWLkztx7YTLbjrz499UgPor1w5JmLfRt64v44QCIa/iq+8g4B29+qPeVyUWGALjHHaKwCz5jKOzs1Cuw7/pmhytwSKwoUmK+x+pwaXRWvt/IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0d2Qwy0FoNkrqb+YUHquvp0nwiinjib1qx+ZBrbEdI=;
 b=k+4xZyWGKM5ZfAk2+ytcKniOGg141lcYKUMkKVusONQVAZOnZH7lFwyXbUGyUQ19E1qjJFQOgMIX6Q2RF70DZnLiO4UhCc/9aTjXThT4LtrjAr7MN5R2QT2hp1cG8msSSwgO93Nbff1GSSyVDmp+2BWMtJh6SnqndSL4XPhpFcb0iPvqyW0XkJAQKYhCiQXQ6MzrWnxgeMzAMIZnKI2CRa1FQiijrWHTW+6ZoIiPS3cuJno7fnjWZLEEcm1jfyoIztQE2imamNYEb2/ivwpnAzB0aH3/Tc81dQpaghkmrAAoMFu6uGvBNxxIoa9dM7Y38kqzximN/zST6uhU4E5AqA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:67f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 13:39:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 13:39:01 +0000
Message-ID: <d22f0f7a-a55b-42f9-bdd0-3827677b57c0@siemens.com>
Date: Fri, 22 Nov 2024 14:39:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: LS1046 support
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
References: <CAFc1U0uhQg4UBLg=qQb7Lvc72FEg5c1hi+s98hjvqGuuS0D27Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uhQg4UBLg=qQb7Lvc72FEg5c1hi+s98hjvqGuuS0D27Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:208:55::38) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a1ba7d-882b-4078-2aad-08dd0afb0607
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnhHZ2lzNXgvY1c5T1RNUFBUL0hkdjNqS1RFanVnaWl1TVhrVFFzUjFINkFi?=
 =?utf-8?B?UjZiUmlxNGZEZ0JPR1RobjV0NmFDczVuREUyejlzL2ZCcU5WcW1qSmprcjYv?=
 =?utf-8?B?TWJTLzd4UFNZR0x4eTNWenFYcDRnSkpQekZTZnM5ZzVDUjEvNmRLY0dsT1ls?=
 =?utf-8?B?ZzJiRENxUytmMXh4bHY1bEt5Z1NyWDV0TTdxV0hjKzIydm5iL0UrbVN4U0Yv?=
 =?utf-8?B?RWduVjlxQTRLQ3p3NHhMR2IyZ0lVd0hKcmliZW9nYTZKZHdGbW1IWmU4WEdo?=
 =?utf-8?B?ZjhQeTl6TkE1dUpXRjFYV2g2MmVlVXhJZmxFbUlacVRXNDk1bHQ3UWlpTjhV?=
 =?utf-8?B?S1hFNHFpV3JxUStUUnpNWVhQVkVrNS8yci9KQkNxZjJ2NHVpeTJEOUljc0F4?=
 =?utf-8?B?dGZJWXlFYTdCd3F3OSsvcVVFbWRxVjFKU21qMk9nOWsyMjRwNlY5aWEwNmts?=
 =?utf-8?B?K2k4eWlMNDlUSzczamwxQUZ1Y2IvWThjcU9kSVJRRi9VdVpTS0wyUnBCSGZ3?=
 =?utf-8?B?Rk1ieXNWM1lTbDJMaDZ1Rzg2cTlrT0J4VUdRQW5FTlhvNmd6TTNzOTNZdEhO?=
 =?utf-8?B?clpVcnl4NnRtQy9yWWJPMmllU1hiR0orNzB6bmJpVXJKd0U3bXRwd2hQZ0lS?=
 =?utf-8?B?ZWM4clJUQTdTZ1o2TWh1Z3EwQ0FMMDBEOXRzdEZoMkFlTE9jcmhjOWtnRDNk?=
 =?utf-8?B?Y3NCRmJ5ditucjRHTE4zak81RlFic2dJckt1TlJXS0g5VXJDSTVhNVlXTnp4?=
 =?utf-8?B?cHNBWUR4U1lkc0JhaTUwUmt1dnljZGhDWkhRUEp4VUQ3MXgzbkYwNVhpMmJC?=
 =?utf-8?B?bEpBM3lzNy9mRC90K1U5UVJsRk9qeWM5Q1JBNE9NdE03MFFPYUlyYmZhYW1l?=
 =?utf-8?B?cjl2OVgyZDIrRG9PT01YTmxCNmNjU3NhQ2lSdnNUV1hrdW5iZG1ETllqMVBS?=
 =?utf-8?B?NmI5ZlFPUGQ5VXMrcllWazM0NGthWVZlV3RvNVJRMHZvbm5UbnNmbExndDEv?=
 =?utf-8?B?Z0ZWOEQ2c0xiTDFsY1ZjUlBqTk1nQWVFSzNueW1DYUVkRmNoZWk5Z01TNlJL?=
 =?utf-8?B?M0RERE5vSkJNWXREeVVuM0NtQnBFMWpPK0h0NlBzTmhkcDNNSUl5a2hJRTNO?=
 =?utf-8?B?VzJzQ0JEbSt4K0dPQ0FkUGpJNHNucjNYZ0dDSkpGZXZaVlZQWTlkc1o1QXJB?=
 =?utf-8?B?SkMrTm9BY21FQ1ozYWtVamhld3ZNWVE0NlRQU205ZFYrREFwMkNlOXh2amhT?=
 =?utf-8?B?QWkxMlFoVFNOem9jK3pDYiswNTNveC81b1ltTHN4eUNpVDRqbGxhS3BsZGlX?=
 =?utf-8?B?aWpNUnhtVy9nZWQxaVFBSFlHVWZnbFIwLzhIVVVGajhTaFlMbncrZlhIc0Z2?=
 =?utf-8?B?OG9reTRnYXpwbHdZR3FJVmlxTmVKVUZ3bXJDMTBYalpCcjZtSXZMalJrL3JJ?=
 =?utf-8?B?UWRMeDFWQWt1cmtMTWlLNlN2emw2S1BVL1FTYUhkRGx0WXFlbEFlbXFOYmp5?=
 =?utf-8?B?MHhFOEpOSFFXdG95amFvck95WEVZdDBDWnUwWml5OGU0N0ZiME9IaTlITExS?=
 =?utf-8?B?S0kyTGNjRUdSTDduUXhmanpFU0dYd2YvNjRJem1rYzZHQzBZZllPWEhwZDZh?=
 =?utf-8?B?ZEtWWFhHSU4wWmwyYnVCZEpFSUllVFRKVUhueFNJeHhwZUJicEhOb0xwOS8z?=
 =?utf-8?Q?1Iuk0RBIYOnHiQL0pphZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2xRblY4SDR6RUN0RUx1M2sxZDV0aDZpTC9NYmpBWjR1eGUweGd4TXFCS2s4?=
 =?utf-8?B?WUYvQlVWdmpHNVJsUWt6UmVnUkw1aEcwRWpQVHBRcDdHWlNzZUo4UnZqVk9L?=
 =?utf-8?B?SWNHNWlZNGh3VmwwVEpiWFZJa1NoQXJUQUV0ejJCaWpScm5VYkM1OGJBMS9j?=
 =?utf-8?B?bjVLUUdJZXpiS3Y0U05UVVVZeU5NTEV2MWR4NEcybWt6Qk5WTWtxQzNWcUdt?=
 =?utf-8?B?ZklLVzRCd1VTdjIvaGhGTmhQdzkrM0lyeHZXL1E0UVJ4Qi8zRnZEQmlHeFRB?=
 =?utf-8?B?NzUxdVF5dXZSS0E5SU9iUjRkVU9EZnJHdDBEWEx2Zi81U0tWckJuY0tDdVhX?=
 =?utf-8?B?aVBEQkc4dW41S0JUTW9nQ0o4dFViRXQ0ODJxT244eFNVZk9OMktoaWVaTlZj?=
 =?utf-8?B?dWVwK2ljYlVxYVUxajU2RTJtdmJMS0pTb2pCaXdnNzYxbUQ3anRLU3l6emhE?=
 =?utf-8?B?RXpPSjJ1eVlibmV1bkFhWjduZm01dytGT1BQdEJOVXppQ3ZFVjFPMlo2UnJS?=
 =?utf-8?B?VjBzSU9jUjEydjJ5Ky9tZk5MR2s4endveVJoSnRmM3ZwbEVYUml2Z3AxUWJw?=
 =?utf-8?B?V3Z1UnFzS1JqaDN5Z3lveHdJMzVsQnE5V3FnS0p2RzVtTWMvay90U2dWYkhG?=
 =?utf-8?B?K2pDcFRkYitJR1RWZXBHZDlSb1lYU3RJU2Y4RXE2UVU1SHNEL1cvT2FreDBo?=
 =?utf-8?B?cDNGdkEzYnlsa2o0RCtRcFZYeUZDRjlQbXk4VGtTQVlIbjV5elFWQnBIZGVs?=
 =?utf-8?B?TW5VaWJ3NlZhZUFXQmxiV1E0MGZIU2JkSkZNNGtMbHdveENxT2laTHVRVUUy?=
 =?utf-8?B?dUtDc1dkUlJkbUJYOWFEQzlrWjlpaFIrWW56dkhxdlNvMForSFBsU2VzeG8x?=
 =?utf-8?B?NmVzQ1Zuazh0dVR6aDNTdTBQTUpsVWpzbEJjZlNTVCt2bTZWb1VWLy9KazQ4?=
 =?utf-8?B?OExqUGxYOUdvRWkyaEV5ZEl3QXBqNFZRTGp1TmxCTi9DSmUxbGtFSEppYkVx?=
 =?utf-8?B?VkJ0ZUlvMzY1dUFzM1ZCRWMvd2MyWUd6QlVKbVRvUEFIeThQL0thT0NUdnp0?=
 =?utf-8?B?eHNWb2tjRVlsUUFyVi9sUmpkWXE3TklGQktrZTR4NjZSTzZWMStza1loSS93?=
 =?utf-8?B?OVZLT3cwNG1IMklkUFdXdFNubmtwN0lTN1RBMm8rb1hpNVA4SngvWlNzMkta?=
 =?utf-8?B?ODhIRW1xVkpHZmFtdlJHS1Q2eHdlQjF5RXk0NVNuUjBHNWNBRmRKbU9US2d2?=
 =?utf-8?B?ZVUzV3EvdFpRcHNEZ2pXYW84RDBWVUdBdEMrUVJIWnpPZTN0UFJCMWVvTUtY?=
 =?utf-8?B?c29Jb0dlK2dQbk9SQ3RyUG56WG0xUDQyRktQZEtKRHo0Q3M3ZFlMemUxazVS?=
 =?utf-8?B?MjJQYlc5dEYySjBnQTROWU1FWmFqMzI0ejFFNGNUa3Z0SUNaZ1R6NUIycmU1?=
 =?utf-8?B?SWEvME1RZkxnaUZ4QkI3V3FPSk02ZXkrekhUMDZrQkVsclkwb0tyK0JWMFFr?=
 =?utf-8?B?U3NaeGdRMlBIeVZjeGZkcWxLSWVTUGhJVjJQZjYrREQySmZUc3dybU1Cengz?=
 =?utf-8?B?MTRxYm5RN2ViU0Yxc0JSOE1tdTJPTEQvVk1FakdyL2RUd3ZyVzhSM2VkRzIw?=
 =?utf-8?B?SkJTSUlhdFc5UUdZZlcxNWFISDk4UFNmS3lYUDFJM0xOdFR3QlNhS1YxWEpr?=
 =?utf-8?B?d2NrZmdTK3ZyOXRlYjl2SjdFL3JhYllSdkpwT2RCQTA5SkpXZWlQb015OUtV?=
 =?utf-8?B?d3JmaThMT3ppUktVZGZadkJRVHgwZnZCakV0NGQ0VjFxL0ZrSlk5a0d1SE9p?=
 =?utf-8?B?MEUxTGYzQmVGVUJDa0JrZmFoRXFTUk5xMlNUQnFHVUIxUHJXQWVKcU1aVDRV?=
 =?utf-8?B?U29kYzFHTWdqY0hkTVpUVk9OR1V6MjZEOC9OZ1hMRjJrRDdVdzhOSURIeWdX?=
 =?utf-8?B?RlRkMlpUVE9SdG9kRzV3QkFWMUxNRWp4c05NTTZGZlVSSFI4QWViNnpzU241?=
 =?utf-8?B?QVdrYkdNWjN6VUk2NXlCMzZkNWJ0M1o1OFM0OFBUZTNZc25ORWhZb1FSeGJI?=
 =?utf-8?B?UlFhVEZ6c1dWMDdsZ3ovUTJPNXZxKy9OMkc5WmtGZ3RCK2dzcURjREZyaWFO?=
 =?utf-8?Q?1NDZW6YVHJH+ucNc3yi9gqD+q?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a1ba7d-882b-4078-2aad-08dd0afb0607
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 13:39:01.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8esWkST3drL6Lg37+kemcpTM/+R3FKbUaMnKVfy1I0VV2WqYmAjnigrOO+YPDPWBsp18o9/NMHcXm3Bd+vCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8270
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=k+4xZyWG;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c20f::7) smtp.mailfrom=jan.kiszka@siemens.com

On 22.11.24 14:16, Pierre FICHEUX wrote:
> Hi,
> 
> According to NXP documents, the LS1046 is supported by Xenomai.
> 
> https://www.nxp.com/docs/en/user-guide/OpenILUG-1.11.pdf
> 

"Note: Xenomai is not supported in the current OpenIL release"

But that PDF is from 2021.

> Xenomai features are supported for LS1021A-TSN, LS1043ARDB,
> LS1046ARDB, LS1028ARDB, and i.MX6Q SabreSD. More information can be
> found at the Xenomai official website: http://xenomai.org/.
> 
> I don't see it in the official ports (3 or 4) but I've just read some
> discussions on the list talking about layerscape.
> 
> https://lore.kernel.org/xenomai/87v8uykfew.fsf@xenomai.org/
> 
> What is the current status of the layerscape boards?
> 

You may have to ask NXP. I'm not aware of community efforts, including
contributions by NXP.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
