Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3716D323
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332454; cv=fail; b=dmP91mwm836zRB2t1OrqlFl/pSAoBCKXl8JZ+rn0rB2t+4NjmWDMb4UlZ06KVqenSZOp7PMupRTPZfMtAphOLtVlMywPvXkTPvyWCAC95OkghAY8iTCNlybxeAvjCScvoy7CYhSlti4Pl4yFPNWXxHi5i3gcHnOD0MqxLfHBaJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332454; c=relaxed/simple;
	bh=r+B8JstBMz/vp6FZKbAchl6ml7X2/IVGp2OulQXaotg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2tJAAHT3KnaNGu4+vJSkaCBysIuo9uYWIr19Ox6D+Y8IY7jVqykVYGM1/QfGGaAEDGXV5J2XM1yvOcEkIM9aDyjpslfHaZt1Gp6Cadt2vmabOB5cmAZNt6TYL0RCxOPqb0ZhaFUyM1JvtpHZFBnz9AzdLyXrYQ2y/bNda1abKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ehL0lnPL; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ehL0lnPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWZB5J/5EloLGA952Vgbj60bZT51JKxXjOg2sYCE/KWz6DHYKNFTXpYmBrQgBeiiu4MbDYFazpFk6iiCvLN71WziEAm80vZYxdha/0wAaqo5M6gXjDaVo81Akth0eUbuVMvOlIf0BHK8cv0U16KYDhPZxilX2sl+ICD9PFqFkdV7vCfuSyYSuOn2rujeC7UQI6n2sXuTE998NBT3iSNi7pc01jZgXgOxd6lWQINq5hRW8gW9ZtHwsmRzEYv5uh1fYJVXKvzGQXPMFf2YrWYUhfiRd3ix7ksQNkCZfqfgjz3BF/k3hqchQFZNyYrBICyqTsvaipR1hXtgLkT2pdkDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GoRkQEb3ZfGAEDgIh041mbMxonev1apz/AoWaHTHXM=;
 b=F73HJY840Ytnryx+iqEsGKnvQOmEyTJdMP/j7/ESYCR3K4KTXXchPr+2hWcJ2SlONqfyE5iWROCnPX74k5PQyJwmZ6XXAyLswR2rPxCIpQDbVD9BwgWZh24My59/XjiSQtr4nNOfTwUvBnSHolfRIctzLYaSwXsYyhHlk8heJBbISQpvOby1iaum8F1wEKTd9WN0QfMRA5GqNskmrYW01BXX9yEf9vmoyHBKSbfnknTPyaM3VNUp+8kVo1Sl0tRuikPIJcug01JQ7rLfg2tRIvLczyi6ZA0UlpjXyExJznoMahHawMcnVnQI8OjuCvjJAqgWohGIk37iVKMWY2xfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GoRkQEb3ZfGAEDgIh041mbMxonev1apz/AoWaHTHXM=;
 b=ehL0lnPLbOcxWcbypLtpPp73mwlnEgUtfXOyLg9KWS84M5eVFc5uWGQA487QhtcI1oVrg8xPBmNArNzbsJYxSS56qum1G+WDiE/v3uDagzeCMNfe9hhF/mY16uIcu28djchc8gqPuQa/d6C2RXODcj0pqvLWsvwKsXJKXCkoo6GXyK710r3bgAMbRbPkG8vCvl8kyFlMhL8FWJh4mQvx0sp6Zn6/53ILxXLqnPKTmuJib/p58g3Hd4pKFfZYOGoNhM1m6fuQDWTRxluBrhpglY7UIRFLUPeR1je7Zbt+tvCt60OdMLRxz2Uk2GucyuT4i4IJXkUGVXH5IPaG/teoew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 16:20:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 16:20:47 +0000
Message-ID: <d96e1040-357a-40f2-b651-659c715af07f@siemens.com>
Date: Tue, 25 Jun 2024 18:20:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240624203341.6263-1-richard@nod.at>
 <20240624203341.6263-3-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240624203341.6263-3-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: e141d545-bcef-4640-8f4a-08dc9532c559
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUdRemw4MnJaQkVIVU0rNkZTb3JqNHdTczluczRiRlUzWkpiMlhmT1RFVnVl?=
 =?utf-8?B?K1lTM01ySjZQZjV3aFo5N2h0dUFqTTUweDAyRlU4QWlVTTFHRWR2WDVmRlpk?=
 =?utf-8?B?NG9TZkJDcHM0dllaNjFPUXduWGJRV3Rrb0dpN3I0UEJaNFV2NStob3M1R2xs?=
 =?utf-8?B?UGV6c0h2QzhmbEE1NzkxZEllNXpyK0Nlb1VVQjVMSTluaU9MbDQ1ZVMvazY4?=
 =?utf-8?B?cGVTMVdCTWZ4Z2I5REQrVHRiVUpEU3JJdE1jQkd1Y1Z4SUdyZEt3OFdBRlF6?=
 =?utf-8?B?bTF1SVpjZXorR0N1Rkxhb1hpYVo4NmxJbTVyUDc4aFZwd3VsbmYxRmQxbXZk?=
 =?utf-8?B?RDhscGdLVEVvNkdJbm9lRllwNVdXQ2JLSHlkV3ZjRG9DdU53MldSOWNhYW02?=
 =?utf-8?B?dmplRmpmdjR2bGRjbE9nYVd4YWhnbHp3aEJIRnpMWU8ydDN4cHJhQ0daSldt?=
 =?utf-8?B?eXh1ZmJEWms0ZG1YOHliVmp0VFVYNWxnOVVpY1lOMlUyVzRoYjRpejcyUFAy?=
 =?utf-8?B?Y0drZVo1c2VzUWlIWnczQmI0MUM5RzFKc095b0tWRU82aVlydnNTbWpwN1Uw?=
 =?utf-8?B?NWlIaFZZRzQxOEdJRzV3U2NBNTFBKzVZWUlhYXlWQW9oM1JQZ1NoSFU2dm9Q?=
 =?utf-8?B?Q2RWWlBjQ1BZWDBpbnNvK080cmFRTHgzOGlSQUV2bTdaamJyU1VQbklzLzYw?=
 =?utf-8?B?bnFVUSt2dlpiZmRNSnphYUNUajdlT3BNZXFXckU2ZDJMVTB4OU5CbkE1Wkt0?=
 =?utf-8?B?c0lwSkFUaGZSaDZrdjkySDB6VDk2anRoTU02Y1YwVTB1azUwd0pLRmRMWUl5?=
 =?utf-8?B?SkNxaCt6OVdJdk02RnJqdUZuZnVkbGhTc1BhWURHMjc0SnNSeXl6N2JkVVc3?=
 =?utf-8?B?NmFmd3V4SStqY0xRcFd6Y3RWNGNHL0lXOEZydmcrV0VHcHNUQVdKU2k4RUg3?=
 =?utf-8?B?a3I0c0NNbWt3bFc4VzNWVVpMQXovaFJURXYvdjZxbkI4cW9mb3kxc0wzOU1E?=
 =?utf-8?B?d0dYMTdhS0YzcE1ZSFdhcU5wdFlVSkZLSGRMaWVvWVVCKythWU56Z1Roa0Zl?=
 =?utf-8?B?eE9jWlV4Wks3TStYQmFMQnBrU3ZCVm4wekJTSFlKQU1LZExSWFo4UEdoRGtG?=
 =?utf-8?B?YkdZYjNyRjJ0NHhjR3ZpazBQWGROcUdZK1BuYlYwczh5WkgwM3pkSmFIU25N?=
 =?utf-8?B?TThwaElsK3dXYTc1ZWM1MHVuOFBPSDd3eFVOWkhUb1daTXRqV1ZNZ1RTVTZQ?=
 =?utf-8?B?SGI2blVNMzE2c0hXdm12ODIyUnVRMHRjelMvdmFiTG1yNnhFS0xZK3p5UVZC?=
 =?utf-8?B?ZWgzNVQ2eFhqVmQ4bnRRWjcrWHdHbklCYzk0QzM1aHk1MlZKeC9TOW5WeFF4?=
 =?utf-8?B?dk1pdmdsdnBvdFl2ZkgrMVBONTh4WVdrUjUweXpCUnY1TDFPWEFITnBkSy9a?=
 =?utf-8?B?WU1pd3IxRnh4UVJjRFkrQ25GY1VNV00xNENIN1MvN1ZMWUoveXN5UkFyRVFa?=
 =?utf-8?B?NUQ5WURpTWVQczVUQ0xBd0tQYWVYRWtyQlNBVG53SWQyU2czUUZMaHI4UCtz?=
 =?utf-8?B?Uk1NN3VUWWUramRrWWdrSDB0dEhuKy9tWWJwTWZ0eXh5ZnRGSmUrOUZkdmp5?=
 =?utf-8?B?dGYzRU9pcGwvNTh2QnA3TTdWTGhiZGd1cXYvTUR2YTJDTjh3WC9qazZsRVNB?=
 =?utf-8?B?dG5Ka0xxMGZGVVdqS1RWYjAxOXZDVHhtL3dFSm8xcm5PQ1NHdnEvL2NIYlox?=
 =?utf-8?B?UndZbldvdGpMekJvaHZtWFl2UEoxUkhNUzFEZmc4MFZ6VGgzUGpYeEp2WFZJ?=
 =?utf-8?B?ZzJRemNWZllMeGZKdzFkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVyTTBmMVg4djFBbG9qTXdxL2Z0YTBCNjVvL1BXMi9HMmFOQVl3T2hRamJo?=
 =?utf-8?B?NTBRdHB0SVNyeXhUYktoK0Q1bTdSU0NZbVdaV0ZmNkNyb2VvbkxJSWlxajBU?=
 =?utf-8?B?dDV1QTZqTGFielZJdnVlWDZTTXYvOFRhREF0SlRKTG1FbGRMWDlwdFRxNFUr?=
 =?utf-8?B?OTlwNnRhZDk2OGhJdHZnZlpSeWVzWVQxVUVXSjd2STI1NmtGRGJxVnhJalFX?=
 =?utf-8?B?YUI4NnZscG56MVVjM2tOdG5qbEIySCthRGJkd0k0QXVzYWtyMENnQVJUSHMr?=
 =?utf-8?B?ZEo0RkxLMndzK2ZIY0FsUHNsT0k5Z2hlNmtRK2hpbzRJUjM2QUwyQXVZUDh4?=
 =?utf-8?B?U1hBeFZOZjJFNzU5cFdSLzVOMGN2WnA0VHdoY1lkbnAySWdjU3VMSkttRlV0?=
 =?utf-8?B?Z1hSR1VvbHlNdzA0YXk4Q3Y3OUdxYVpZRkZIZU43OGhUWDVqN1BmRU5uYlBQ?=
 =?utf-8?B?V0tPalBxOFU0MWhYbDZzbW0zVG5xUmcvRzdBMEtlbzZidXAwWVVwQlhwRHdu?=
 =?utf-8?B?TktVMzV4QWsxdkFKVHpLM20rYjV3ODNvVmFQVnVnS3EwMHNDcGg4eG5QNmFp?=
 =?utf-8?B?VXVMbW5jYllOUjYwWEhzZmFDZTRhZ09rMlNQaC81aXpHWFFFZmlYM0RzTTc2?=
 =?utf-8?B?bnBWNE1WVWEvQVd5S2RncXNkelNCKzFkQ1I4M2l3NkU3N0VrLzhSQWtOZ3hZ?=
 =?utf-8?B?T3RCTlIxaTNlNnBmQU1HeTF1Q055dnZ4NUJEb0VVb0NyUlNRQlRzUEx5UnZx?=
 =?utf-8?B?OGtaamtIYnVvN1ZRWDZWbjV5Wkt5VzhzencxSWM5SmtMREZqWFVkNXh0UFlx?=
 =?utf-8?B?RlNxZW12TDdqSkhaV2ZncDhsN0pjZ2pCMkZqSDhkOEpsN3VIM1M4WGkySHJh?=
 =?utf-8?B?WURwc0FCQlJNZkRjVCszaHlzTHdaWElZMEJ3RmtFN1A5RHRzRWlkb09LVTBp?=
 =?utf-8?B?VGhRSTI4S25hTURtMklvTE9rQUJxeGV5eGhFNkxTcHZNZWcyMzRmRitzZmt5?=
 =?utf-8?B?eFZTMmxSYXVESG1kT1JuNklLZU5GQy9MVnM4R2JyRXR6TWNFdm9lVjRsNU5z?=
 =?utf-8?B?UFhudHBnWXZyUXdZOUZFbk4rMzEvUUpDT3REdTdVb3lVcm8rZTdEd1ZtWVRY?=
 =?utf-8?B?MHZIdm9vNFRCRmNyUlAyb2IyRzBvQXQrQ3BJN2M1cFZuU1hrQ1UxWnJMdzNs?=
 =?utf-8?B?d05HZTRpMXdNYVRYOC9iUFdsbFdURCtBL2NpR1VBdyswNjRxelNsclpvM1lp?=
 =?utf-8?B?QkpIakllWm45SXFBaGViYnZQRnV3TndQRHA3QWtOUnUxeWxWa1RoZzJqRzNL?=
 =?utf-8?B?SFRRSFZvakZKWEpGNERlK1VHb1FORkVpb1dGaDFQUzRCQmN2cEErcFMyL2Jw?=
 =?utf-8?B?Slo4VkZaVDh6QlZ3MnN1NW1FQ1pSNDVnTVZMTGlIYnhNYk93ZVFuUVZFb3pW?=
 =?utf-8?B?WnQ5MDhkVEE2VUxWRWpoUlNzRzduWUpNRytieXVWeFdQZlpMNEtWU0ZGcVpE?=
 =?utf-8?B?UTZsMnB0R2lhT2xIQ0ZhNFhKTFRmQjY4ZGdGbjlFZXJxMThpSG9RTTdVa1gy?=
 =?utf-8?B?Y215VjNnRDZhYkRpbDVZbThUWVdqZWVXNTMyRGJmVmR1bS9QWUZzRkJMSUt1?=
 =?utf-8?B?Rk9ha3piemgyTVhIMUUvU09HZ1J6bVA3UDRaK3FYSHJVTk1lTDY5Nmd6a2ZN?=
 =?utf-8?B?UzFNaFRTRUlwdXU5VVpRa0NUTVZVYUVoWHJRcVFnYStDYVNMcDJzVGpOWlMw?=
 =?utf-8?B?alBCaHFtczRXVERHdDhtMWUyeVFqcVA4Tll1K3M2Y3ZvWXFHYjN2QSs1L0h5?=
 =?utf-8?B?SVBCcVNmY1FNSnYraElOZEQxNlh3NlFCMTlKUHJiUDUwcmZJNFR0UWFpNkFS?=
 =?utf-8?B?MkZSRFBHUlJKUWFEV1pDQzVvQytna0RPSGtyRDdzYkFOdU5DSWpsQzdubjRX?=
 =?utf-8?B?SlMreGhlUUVRMFJaOXFEU2hZSVVXNGFldzhaNUg5K29QckV1SUI2S2NEd1FX?=
 =?utf-8?B?WUoxNzNVWC83MiszTmY3bS9jOXBvejU5amZRWWNaeWkwNjA4SVhvQ24ydktM?=
 =?utf-8?B?RXpYekJEVkdhSXUxWFUvQ0JNZ3o5eG1oZUZtNUk5WHlTNitCVXdFeXc5SE1W?=
 =?utf-8?B?dkU2VVpLZjRaRktrQVFxWlFPc2NSSnF1d2ZLSSs4OXc1MVlBK2x2eW1uMnpa?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e141d545-bcef-4640-8f4a-08dc9532c559
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:20:47.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1rgrrJfmPmmZiZaqhlwECD8DhyPiO+StWTVgMtoJhZ0vxP92DPn5T+/ZF6s42Gowgqd/5L+QdVqMAnASdgNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5270

On 24.06.24 22:33, Richard Weinberger wrote:
> There is currently no way to undo preparing of a kernel, except using
> --outpatch and reverting the resulting patch later.
> But in link mode the kernel tree needs manual cleaning,
> which can be tedious if a git clean -f -d -x is not possible.
> 
> The new --reverse flag offers this feature, it removes all previously
> created symlinks and directories.
> To be able to undo effects by patch_append(), keep a .orig file link
> as the script already does for symlinks in the linux tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 71 +++++++++++++++++++++++++++++++--------
>  1 file changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 9299aaa97..f294ef0fa 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -55,6 +55,8 @@ patch_append() {
>  		if test -L "$linux_tree/$file" ; then
>  			mv "$linux_tree/$file" "$linux_tree/$file.orig"
>  			cp "$linux_tree/$file.orig" "$linux_tree/$file"
> +		else
> +			cp "$linux_tree/$file" "$linux_tree/$file.orig"
>  		fi
>  		chmod +w "$linux_tree/$file"
>  		cat >> "$linux_tree/$file"
> @@ -66,6 +68,16 @@ patch_append() {
>  	fi
>  }
>  
> +patch_reverse() {
> +	file="$1"
> +	if test "x$output_patch" = "x"; then
> +		if test -L "$linux_tree/$file" ; then
> +			rm "$linux_tree/$file"
> +		fi
> +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> +	fi
> +}
> +
>  patch_link() {
>  	recursive="$1"		   # "r" or "n"
>  	link_file="$2"		   # "m", "n" or some file (basename) from $target_dir
> @@ -104,11 +116,15 @@ patch_link() {
>  		f=`echo $f | cut -d/ -f2-`
>  		d=`dirname $f`
>  		if test "x$output_patch" = "x"; then
> -			mkdir -p $linux_tree/$link_dir/$d
> -			if test x$forcelink = x1 -o \
> -				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -			then
> -				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +			if test x$reverse = x1; then
> +				rm -f $linux_tree/$link_dir/$f
> +			else
> +				mkdir -p $linux_tree/$link_dir/$d
> +				if test x$forcelink = x1 -o \
> +					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> +				then
> +					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +				fi
>  			fi
>  		else
>  			if test `check_filter $link_dir/$f` = "ok"; then
> @@ -120,6 +136,11 @@ patch_link() {
>  			fi
>  		fi
>  	done
> +	if test x$reverse = x1; then
> +		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
> +			rm -rf $linux_tree/$link_dir
> +		fi
> +	fi
>  	)
>  }
>  
> @@ -135,8 +156,7 @@ generate_patch() {
>  	)
>  }
>  
> -
> -usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
> +usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose] [--reverse]'
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> @@ -172,6 +192,9 @@ while test $# -gt 0; do
>  	--verbose)
>  		verbose=1
>  	;;
> +	--reverse)
> +		reverse=1
> +	;;
>  	--help)
>  		echo "$usage"
>  		exit 0
> @@ -221,6 +244,13 @@ if test \! -r $linux_tree/Makefile; then
>  	exit 2
>  fi
>  
> +if test x$reverse = x1; then
> +	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> +		echo "$me: $linux_tree is not prepared with Xenomai" >&2
> +		exit 2
> +	fi
> +fi
> +
>  # Create an empty output patch file, and initialize the temporary tree.
>  if test "x$output_patch" != "x"; then
>  	temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> @@ -229,6 +259,11 @@ if test "x$output_patch" != "x"; then
>  		exit 1
>  	fi
>  
> +	if test x$reverse = x1; then
> +		echo "$me: --reverse and --outpatch are not compatible"
> +		exit 1
> +	fi
> +
>  	patchdir=`dirname $output_patch`
>  	patchdir=`cd $patchdir && pwd`
>  	output_patch=$patchdir/`basename $output_patch`
> @@ -364,10 +399,11 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -		p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -		p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> -		echo $p | patch_append arch/$linux_arch/Makefile
> +		p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +		p2="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> +		(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse arch/$linux_arch/Makefile
>  	fi
>  
>  	patch_architecture_specific="n"
> @@ -375,11 +411,15 @@ test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append drivers/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse drivers/Makefile
>  	fi
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append kernel/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse kernel/Makefile
>  	fi
>  	;;
>  esac
> @@ -387,13 +427,15 @@ esac
>  # Create local directories then symlink to the source files from
>  # there, so that we don't pollute the Xenomai source tree with
>  # compilation files.
> +#
> +# Keep link dirs (4th parameter) descending, otherwise --reverse
> +# is not able to cleanup these directories!
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
>  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
>  patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
>  patch_architecture_specific="n"
> -patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
> @@ -401,14 +443,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
>  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
>  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
>  patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
> +patch_link n m kernel/cobalt kernel/xenomai
>  patch_link r m kernel/drivers drivers/xenomai
>  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
> -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/pipeline
>  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
>  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> -patch_link n version.h include/xenomai include/xenomai
> +patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
> +patch_link n version.h include/xenomai include/xenomai
>  
>  if test "x$output_patch" != "x"; then
>  	if test x$verbose = x1; then

This breaks rtdm/uapi/rtdm.h, at least. Didn't debug yet, just bisected.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

