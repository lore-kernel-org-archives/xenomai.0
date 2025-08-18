Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430071DDA14
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535615; cv=fail; b=FAodEKma4vQ0VmGFt+AU8noMejTa5YhHoLTVYbY1OLHxvROj9AxAVtsHuY9bka+Rsay/iwGSOuCKiPLrD2eSILz5dhIsnP4nUpWJiDv+MOX0bOrAa698B/l3vOMMb7RXMr6LBiN6Zp5tMKybo3y43EGgN/eL2ONLtqHmf+4wK5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535615; c=relaxed/simple;
	bh=IluGg12tM9Hh2wB3UtzUQndxAiXX0FUsnIwvdStPC/k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNXFG9UyjUPjRhYHzzYcSxOdUGiIc5iOogkN3YW4A9VUSWZ+5XOIz4oztXWiUtONi/gfbFWazLvwAEi71w9snKtMuoWF+WYu2FLhmGGgmTCIGfsmHzidw8UuLLUhIZy0But6iYhsUE+oOP5/kpsutbc+Eb95Pw8PZ0pTTpk7euA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=S7ia/xLc; arc=fail smtp.client-ip=52.101.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="S7ia/xLc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOpLux0GLqcdCYSCE1dQVbpaJt4zEnpXwZy2Gv3QUiS96bAmJnXfsnd7NBIAIK6nZZk8qWn9n1K5Pj3mjH8BFKUnyRoga2RwdyrqlsQ6sMMVzAYShqk7aCOlmxxsvd/hIPRciyfrokFBOTPJAutdwt2Am3DeXa15Mf2sacHC4wxdQFADg5YS9ldrp1U01lg1cwDJD91qarTV+JmBl8Cinft+LhhoT1jRxiwKLcmeKozdDgyf4sLMBz67DuuwTJY7FdmF/PCb/tfkdQmhASs9LuAFwZp9oglRowFpEHT8ZzwmEowdsKKYFlc3HGNqMqmV0RvVafN79cOo8Cylvmi2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqN7l5uNSFXMsbtJHKQrqrLQO6EAKDmLH84NAfH8jkY=;
 b=bRaWm+gdUaJ8TqzkHUYZJ/ogMgkSuEDertiy9UUQ3xynzQIMzjPerN6uceOyc5qJ7nOcll4FkqOqzh8Mx9vMP/OXMjyaaoc/cbpaHdd60MaRRwI4zIgE7eFVREM24j8zF7l7IsgLkMpsdlRyWwM0gBFoDWvBcbt8nbWUeJn+AbZHeDwJt+/t+UZiBK/iFm4q91nyFrIEUZtvLWDUXK3szKGFnc5YYpkTGNMtajVyh7Uq6liAhdhvVmqtSqnL/WAQGdB/iSHxmJzZ7dK7m2Lj3bxfocsXRQLtx+Bw2dd0pAgH0bPbupxY0VH+WEvZ6R5yhNZaz3IMx9cf5/L1nsXAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqN7l5uNSFXMsbtJHKQrqrLQO6EAKDmLH84NAfH8jkY=;
 b=S7ia/xLcgAhlFCmgKDu9jVKnrWU4eiiJIVd1s99OMPghov+sPN0ghDvJNRFLrn6DeQqfiVJRFehBehmF7lBtj7s+lGdwb9KBV53xRVmG+KP5fS3XHQ9opo+5OK74r2MQzke6wePr43scNltEHJXmudT2GuM/3++qFgUlG86Uorj0GnG+GroIt4hsLqM5pdgDt992OzkTouWPhQhIz1XIX1PL446p8nB1FlBeiT3Oxz2Yxv4nUOacLLmEDVC02ZtMzuAeeMI4WUBaqYs/xzrmHv4hGtUzcrzmx9gN2L17V200xtTVnlXJuC8Qv7LDs+N8+b+SYomJMgltrn4unefLiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:46:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:46:50 +0000
Message-ID: <1c471509-7423-443d-87b1-b1fca52cab8e@siemens.com>
Date: Mon, 18 Aug 2025 18:46:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: We are moving to gitlab.com
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <a1f7db9c-0422-4b1a-a762-d5ad2d9edf99@siemens.com>
 <bda4eb89-41d9-4b80-a332-194f1433294c@siemens.com>
 <b7eb0be4-c6fa-4096-a76f-d8d64cc21fa3@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b7eb0be4-c6fa-4096-a76f-d8d64cc21fa3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1e2ac2-9c6b-4ef3-a6bc-08ddde76d411
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2xBbTI4RjJmaVY2VkFZT2dlQXpEVHdUZ0Rlanh0OGFYVkhkR3MwbldYRTNh?=
 =?utf-8?B?U3hKTGFjUEh3cFJiaHhLU3k4K3VmeW00bk9qZkdQT3BLc3NnNGFLR0M1L3Nv?=
 =?utf-8?B?d1poV05OaXVWUU1YTnR6czdmZnBEYmVONW9FbWxsaHVYditGOGJCSStaQ1Fs?=
 =?utf-8?B?TGFEeS8zSzdpWGVTbnJKYlBrcWVUYlJYRDdJQlpTeXlIdjkxaFBoWTZWT2RF?=
 =?utf-8?B?NEcyOXlwYjZxTHJ5V3RoTTVvWS9pK1pkbkR6VWw2N1R4Z0hCNVo4UTRLOEZS?=
 =?utf-8?B?MEVSRWozZkRoVjlRZ280bVhwaW1yS29wR0NXRnNoTExtVCs3Z2hBc1ZpSDE1?=
 =?utf-8?B?VEhTUU1xeCtOZEtHWmlzY1pqRmZObjBoQnI4V05MRlg5aHREK0xiaUxGVllB?=
 =?utf-8?B?NGZJYmVpelh6OEVHbUJITDlYcjFMa0FYenVpeHhDR09iR2VsTi8ySEZ0aCsw?=
 =?utf-8?B?NC9YSC9qY0VZYzNPclVwNzZkblJabWxFVzVyZGpGZFRMTTRhQnZWcnJ5bDhy?=
 =?utf-8?B?Y3RIY2VzRTJpdTN3NmxZaDdBK1pKTDlUcldLcEY1c2ZIaWlDaE5PK29PRTZP?=
 =?utf-8?B?OWcrUTlkb2VWTHRKNTYxbVlvY0ZhUUhpYmRRRWJzN3NCY0MzRjVqelF4ME45?=
 =?utf-8?B?RE5mWi9FUmhkckphL3EvalBEWGRxTUtnRFVYb3dSbU5Xa2pNczdwTTAzV1pi?=
 =?utf-8?B?dCsyY3VhOVdHN1l0NEtrRnBjSzhGcHgxc1hkcmZjRVk5VEczTTRyajhVYzRV?=
 =?utf-8?B?cEFkMGROY2N6NTlXcWpNaUd4Q1FCcnBPQmlTMnJScGFmblU1YWxiV21VZ3hR?=
 =?utf-8?B?OXVzVW9RWmZiWjZVeHVEMlBwVXhTTGkxZ1RYOXRKQVVOWkpKeWNEbXVHT1ZY?=
 =?utf-8?B?ZTNZakVRVzVMVTM4S0xYbVBabXR5a3BFNVlubVRBaUxMZFBDNFhHTzNRZG5l?=
 =?utf-8?B?emVOMVppS25WZnpvSkI1NzZqV2wrNEo1anY4cER6L1lTZ2FRQ3pPOCtLaHJP?=
 =?utf-8?B?d0Z5cjNBUHJ2NDBnVXFaZ0x3OGpiRDJWTlBPNnFvcEs0UDJTNU5SWXlaZTd1?=
 =?utf-8?B?aHVBZm9mVnNyRFBwd2RERkVXV3g2c3lzWUNwdEswT3A5SjhzMjM2RzJveC9j?=
 =?utf-8?B?NG5JRkIrT1hITUsyTE9uWFZ5MUJmbDdyVk9MWWNGMERtdFhUSDlaTk4raTJr?=
 =?utf-8?B?NklOdkhYMnRUdW54dnNTQ1NaRkR5MnJvc0ltVUxqQmc3dkJBMnV4bllFT1Ey?=
 =?utf-8?B?d3pia0d2R1RCSGV3YmpPanlTUmt2WHZoV3FKcVNrV0xQaCt0MEk4T1ZzeHMw?=
 =?utf-8?B?UVhqTzhEMFhGKzdiRStJY0FUZ0xRT3d1dEd3ZHZIK2lvMEFlWUtkS1g2b08y?=
 =?utf-8?B?ZmQxRFFqOElPa3N5RWd4NFd5dW00U0x0Y21neTFsVkloZnhhQzhFZDNlc1ZC?=
 =?utf-8?B?QmtFS2UvQUgyUHJSY0haMVBQZG4zQzJhZ2wwcnFsanFKNG82NUR5VmpRU0lW?=
 =?utf-8?B?L3RwcTVSRmJiVDQ1LzVCbHBpNzJxMEl3a0FxY1NxL2pnZnpoT0NlVEJSMlNi?=
 =?utf-8?B?b2c1cEtTRjc1KzRzcmZqV0JsR2ZnVG9KSVRHYXYrLzRHNE01YnE3eHRmNG8x?=
 =?utf-8?B?Vi9XODBsdkYzV0tyUmpqcVVvbzJXRVBRK2kxLzNna2g1cndYakw2WEV3b0c0?=
 =?utf-8?B?MFNYYUR6MzRZWHhhNVZ4QUY3OFdYbS9YTVNab1NGeU9jNS9lT2ovUW5FQzVR?=
 =?utf-8?B?Y2ZHZjk4T0E0UXdVWWowclZiSmdaTnNiYTRFS3dvQmNYUStnTXd3MndmOEJx?=
 =?utf-8?Q?DIK+fKdiDUOVk/+9yrEG4iRDn7H0NK8A5EabU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlEweFhKcllEWGlBcXh3OTZnSnRIenJFSXYzNzUvZUhPLzdnYU92eXc5WWtx?=
 =?utf-8?B?QUlUOVNEN0srTk1jVFVTQUJJcGluQ3F3WjdpTHpEcXR0N0lMTWhiU0c3Q2Rq?=
 =?utf-8?B?NHJmZ201OGFIOGxwNnVaRndocUhQb3dlWUFqK3psbkVmdmV3L2ZpQXJrT2R6?=
 =?utf-8?B?ZVp0VHRYRm5oKzVGUnJNZW1vSE52SC83VUU1NmFPd1NpQlNVWWxsZVQvVkxp?=
 =?utf-8?B?ekRGTDZDNGNYSzhPSUhhTWJaRXQwMlJQaGFlM2NTN2RsOUc0YXpSNHZWZXM2?=
 =?utf-8?B?dW9HN0dDMWRZRnR5Rkd3ZXVmWkpheFFwTS82L3JLY3p3TVZ6WTFvYm9zRm81?=
 =?utf-8?B?STFQcjd3a1FtV3VkaGRZKzc3NU00NDdvb1BxaDVVUC9wRFM4TXlnNTE2MkRL?=
 =?utf-8?B?UjVWb2NKTUJCYUhiK0RZbEp1TEw2VU82Y21GZFR2QmRySko3Sjg1M29qNlMr?=
 =?utf-8?B?QzN3RW5BRXV1M1hvT3hINks1SGtpSVYzcDluczZOVXEwRUtGYUhCVTQ2LzY2?=
 =?utf-8?B?WXhTMkIra2VHWExtRnhPYzRiVkFEbFVJZUhON2RudW93NGduN0tUVzgybzJM?=
 =?utf-8?B?d1ZqbWFJb3NWTGhnSnJtYWJqbmtKL045ZFB3NEtHQUtzSDBEcCtZSG9pMTl6?=
 =?utf-8?B?cHpQRktrT1lzYnU1TXZDRUV2WDRJazlrRVNVczFFNVFqZW5EbitwaUZ3NjNL?=
 =?utf-8?B?Q2ZDUnBUa3RoL1MrQUJQVlZ0clNINittQUJUbEtma0FybDFFeVdHQ0g3dWp1?=
 =?utf-8?B?VUxhQzY2OE5IUkR1eWZKNFFtc0FnTllnOWNGT2llcXM5VTVyL09wc21NUzR2?=
 =?utf-8?B?MUtlMklycGtObThndWgvUzhXN29xQUo2UEs4WjB0c3hkL24vcXR6eElQcnBP?=
 =?utf-8?B?dTFHRkhTaVMwd3R1eUNaSFVnRVhHallORkFnODFDb3pDZnNSUUJhV2pLUklH?=
 =?utf-8?B?dnp4TTgwQSthY1JSSWJDcFRSVWJUTzVGWFByWXdaeWJ5c0NQMDRtUUJuSDRI?=
 =?utf-8?B?ZkVVSWdVT1hoSzd5emtDOWVJaGQxbVZjVHBlWGgrOENlWnpZcE4yVTNOZlNK?=
 =?utf-8?B?bDhwcHAxTlhoTWlZMWdqalMxY0g5V1hmRmFVdjlaMHBzeFVSbmtodUM5aTFu?=
 =?utf-8?B?a2JwdG9lRjNPRHNKME01MXdFTDVsRUxnOWdwelpNYWZCaHJneGhrMUZNSDdS?=
 =?utf-8?B?Z25ackxGWDZIb2RQZk1UMDRPU05Db3VCOVVaV2VMYkUzdHVkYUJFN2d3Mnd5?=
 =?utf-8?B?MUpZWHFTSDRxc3psM1Z1RDVGSVJlOE56UTF1QjNWRzI0aHJLUzRkbEs1ZHM2?=
 =?utf-8?B?UGwzdlJQQUg0K2tteHVtK1pYMW93ak0rUWlPcVlRV3BUc0JGS29PVlpNOXE2?=
 =?utf-8?B?TDlMa1pOVTlRRmU5Z3BFL0oxbHRXTWpkTjdNN1c5K1FTSFArK3ZkS2trNkdo?=
 =?utf-8?B?SlZuT0pFbFB5Z1QwbmRmSHc2Mnl5a2hvMWQzQVpKV3h3dFdSd0VBVkI2b0lT?=
 =?utf-8?B?NUZ4OU5HbHN2NTZmR1V0V1lHbnZ5bStOZ1VwYTZ1UnRRUkZpdUxLdmxyZThX?=
 =?utf-8?B?bjhpYWdDRUEwaFJ4NmFjZVJWTkNxMEJROWRDK01xUHlFd3NJTEpIT3MvSDlH?=
 =?utf-8?B?WWZBWU5Yd2FvN1UwL3ZDVk10a0thSERYc21SUWJZZm1ZMjllKzZzOFJVbkE2?=
 =?utf-8?B?N3JvaW05S0djY2FBTmhDZlRpSmFiWDAwMitmTFBkakZTNWZycDRFTHlUeEN6?=
 =?utf-8?B?ZmJiRTJONW50dlUvZVBGK0RIMkErbk1rT0M5cWxiTGUrV3I5c2NYY0ZMTG5B?=
 =?utf-8?B?NmxrZU1JQ0hjMm5EWDhpWWYzRityU2hqb1JKemRqTWZTQW5zWVF6WVp5SDFJ?=
 =?utf-8?B?TVJ3LzFvMXZKQ2JPU2dsaG5heDJ2YnJDU0lleTlXQXJDc0czN1NqTzNITHVu?=
 =?utf-8?B?Y2NzSks3MlVObjZBNlNZSjdVT0NielFEUGx0MSsxb0JkQTM0Q0MvTXFLYUk3?=
 =?utf-8?B?bUMvSUN0T2tRc1FlNng5cGY2eVZuaG5rQ3VYZkw2aUtnMXNranNHN2IxeXBZ?=
 =?utf-8?B?TVpDU3k1L2tPYWQ0dGZSU0FmYldYd3U4TUgwNVFBTG92ZE5hd2F4Zk5LOFdK?=
 =?utf-8?Q?AC1DmyhTKTnSCzU9q8FD8UDhi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1e2ac2-9c6b-4ef3-a6bc-08ddde76d411
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:46:50.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTKUVWb8BXO7M71Nx/krydY7OCb03wcHlU6j2WkX4BV22Z2gqulfcPms+2H8uYXCs4teHdzT5kIrHY8WTHksXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8839

On 18.08.25 18:44, Jan Kiszka wrote:
> On 12.08.25 16:19, Jan Kiszka wrote:
>> On 07.08.25 11:04, Jan Kiszka wrote:
>>> Hi all,
>>>
>>> we have been informed that source.denx.de will eventually be shut down.
>>> There is no exact timeline yet but we better act earlier than later. In
>>> fact, there were already signs that this resource is at risk. Therefore,
>>> Philippe and I were considering options before and came to the
>>> conclusion that gitlab.com is the most straightforward path.
>>>
>>> So I started to build up mirrors for all relevant repos under our
>>> pre-existing group at https://gitlab.com/Xenomai. At this stage,
>>> source.denx.de is pushing all changes also to the corresponding repos on
>>> gitlab.com. CI and websites are still on source.denx.de but we will
>>> likely change that next week. Once those services are running fine,
>>> repos on source.denx.de will become read-only, will stop mirroring, and
>>> all development will start to take place on gitlab.com. We will let you
>>> know.
>>>
>>> Still, we would already recommend to update your git URLs, which is
>>> basically s/source.denx.de/gitlab.com/. If you find any glitches, please
>>> let us know ASAP! We specifically interested if Xenomai user in China
>>> face additional access issues now. We already have some mirrors in
>>> gitee, but their quotas do not allow to push complete kernels there.
>>>
>>>
>>> Another change along this: We currently have so-called hacker spaces on
>>> gitlab.com [1][2] which were created to allow any gitlab.com user to
>>> create issues there or actively pick up todos from them. Some frequent
>>> contributors also used those repos for pushing ongoing work. We also
>>> planned to grant access to the projects CI and test labs, though this
>>> wasn't realized so far.
>>>
>>> However, with the main project moving to gitlab.com as well, there is at
>>> least no longer the need for separate issue tracking. I therefore moved
>>> all issues from [1] to new main repo at [3] and disabled issue tracking
>>> in both hacker spaces. Please continue the creation of and contributions
>>> to Xenomai issues on the main repo [3] from now on!
>>>
>>> And if you are using the hacker space so far for pushing branches,
>>> please speak up so that we can discuss how to handle those use cases
>>> best from now on. It would be possible to grant developer access to the
>>> relevant main repos, but it would obviously be possible as to push to
>>> personal forks.
>>>
>>> Note that this move does not change our patch workflow which remains
>>> mailing list based. No one raised the topic recently if we should
>>> consider a merge-request workflow, and as long no one does, we stick
>>> with our tradition. :)
>>>
>>> Jan
>>>
>>> [1] https://gitlab.com/Xenomai/xenomai-hacker-space
>>> [2] https://gitlab.com/Xenomai/dovetail-hacker-space
>>> [3] https://gitlab.com/Xenomai/xenomai/-/issues
>>>
>>
>> Quick update on the migration:
>>
>>  - gitlab-based websites have been moved to gitlab.com, sources.denx.de
>>    pages were decommissioned. Please report any broken links if you find
>>    some!
>>  - we will switch the primary repos tomorrow morning (CEST), but there
>>    will still be mirroring afterwards, just the other way around. Still,
>>    please update your git URLs!
>>  - ftp.denx.de will be shut down as well, and we are still considering
>>    what to do with the historic bits under ftp.denx.de/pub/xenomai
>>
> 
> So, the moving should be widely completed by now. The content on
> ftp.denx.de is secured, we just need to re-export it differently (via
> github pages as well) - a minor change.
> 
> More important is that we took the chance and reorganized the group
> structure of Xenomai. You will now fine Xenomai 3 related repos under
> the xenomai3 group, analogously to xenomai4. That means:
> 
> Old: https://gitlab.com/Xenomai/xenomai
> New: https://gitlab.com/Xenomai/xenomai3/xenomai
> 

Forgot: We also have a legacy subgroup now. And that holds all those
do-not-use-anymore ipipe tree, the historic download bits I mentioned
above and our suspended hackerspaces.

> The other repos in xenomai3 are just about the website. Thanks to
> forwarding on gitlab.com, you can still use to old URL, but it is still
> better to update directly to the new one when switching from
> source.denx.de anyway.
> 
> Talking of source.denx.de: Mirroring from gitlab.com to the old repos
> works now, so no practical change yet. But keep in mind that this URL
> will eventually break as the server will inevitably be stopped. We just
> don't know when yet.
> 
> What is no longer working, though, are git clones and fetches from
> git.xenomai.org. That is because we were not able to forward that domain
> to the right repos on gitlab.com. Please update your recipes and scripts
> accordingly. And if you spot any references to git.xenomai.org in your
> docs, please let us know.
> 
> Jan
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
