Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6EF3E5A05
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495444; cv=fail; b=aZXxyjASqxlPJE2mpBz8grNqvZWd0fY7h5GxL8VuqIuDjqtkb2JgEAEdDgfnBF3VIU00MU/lvZ/x5rVBEAZANsHRGSJ/QleJNpZLneo4vJk7LJwVuRi/EH2UpK4zhEQhoaG5ntK2fGH0o+62z5PkO4vLqXulsKhC2zObrLSbwxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495444; c=relaxed/simple;
	bh=+gDtuYh4FFAQvsOTpQLsuppxh40QaKTqYF4GceWSwTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXUYO1X/rTaXXy2D674FTBU6v0fkR3LOSSVgTYgx4CtcdgBfidunCbV3Vr/4YpdePdQIOMBWHExUbU6hFML4PucgwPJSy5KxAV/4xN8WbkDagkEjMQRjMrrVjn9W0PgI1ukVbEPVxVlc6Hyek6oiJSM6swCHF652PQurvnc4KTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NT75/jfB; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NT75/jfB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9UNvqoib3LTeyL0Ztlt16xWYFPsaPJlkfHOjrOvRN0k/ZLl7MwY5fyWPl/ZuCsLk6A6QHed5ZlthiBArx6wvOMnbJcOALsYYD8G0MOUTyJDCDhtyhRnWFdOUx5wVUAcv2hlFqOZxGDOaqDtFoOTqN3pHDU7PR9SaP4kgpEW6tfuBBwnkdQsKMGmGe0sJTGed88r72nQViORhk2Y8/GHa0qOD1HlFNzq9/WW8CpSUJfyPsC88A+uvSrCnPighrQmtztme33ND9otv/jB7CqHia4/lpPJVTurEF8w0tWxfJ4ET0gj2JaM8+3n9i5BIARLquvDa0FE6dFPL5Aerh2f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXjopCniBTruDskuroZgFB7lnszKZZbVCMhwy1NQIfc=;
 b=JVzTdyMH8AUb5u8ZidsEql/bR/wstbUSkR5gtJ9YqBJlD39Meu0Uqm7Vpp0MYyUhQSFB0ncGFif+xyYVWTLqZvM/4ST6KupCdTkziN8l39vqTnQ+LWw9JW3c03JoWIteTtjIsoEcRj0Mx0oBsnkc+iVCu/CXF6NivnnmW9VX+F0IlcZFlaAsvm1ebkL/MxxuBOnyYb25qJa/7mhLKjoxlvj6R3NZy5I7/UpB3tTJvVss1odAFrb21Q1Io5cFN0EWulbAPvBWb3d8kWgDOjFWJx6KtF8VAuv1o5uUYvUjYF5tb6vAbS6zMG5hFXND+Js3oWzgUSzvqXD9whRQp75yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXjopCniBTruDskuroZgFB7lnszKZZbVCMhwy1NQIfc=;
 b=NT75/jfBXXXIPF/wXywaQauhWiIOmT5RQJtp3WkTVXK7WWXGlA50YdbxOfLR0unzeDOcthbr/8j4JJnLinAOaHtLAanPRUEcQCNbG21KRjFRE3gfv8nuw1gEAPhcx8DWcac8wjO5/twmoTDHfvaW+XSjQN553FWDf7popH65k08BGC/XTlTcia4WCoJJYbaEQYC94Ax91OwjUOFxJOjxHg8InH8uDXAPYcFEBi1xy3oezBq2m+dPSzIgZ5GhjG0NBLHbHqWnBJmweZE624xxVwFBFPzm34kr3PnGCejtwhA0/XSZcAGrBv1Tu37v/cfvxI2gWfpc2tz2UA7fXrr96g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 07:23:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 07:23:48 +0000
Message-ID: <bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
Date: Wed, 8 Jul 2026 09:23:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
 <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3606:EE_
X-MS-Office365-Filtering-Correlation-Id: 35875fa0-6165-4c4b-7524-08dedcc1da65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|11063799006|56012099006|4143699003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pTQ/JMl0JgoB8wzZGfp75T5HbuMYMN//wfZGLc5ZPSlAoNTzURQTNuXmMd/5jDsG9uEE2MaSChDX82SCGLvn7camX5xd7zcoQ8m1ZKcX+2yv8XUlP7rNhcnDHiWhGr0XsQXz/PaBsmQ3Cuuj3J1w+Ry402JztEEM/9GN9DSXx68OCQTzZPTx2SGgk8FEUQuFcLcavokaHhUdz3tY29kW3Ojhx0yzFYaWu5aCmOLdCkAuki5W4e96ixWlFWKtyysLSQcZiAVWAM/vO3x2S3lmVvELgtkNru0BUZpx53n7fzL3e7DpuoLikjPo7h8MSOuqG+3qDxHRjNiVvVdh1eMlt7FJnHtAHxuFezbmfwOOQgub6IsiLd5zXI4YsXM9E53EJzf5DCOSdiZW5Zzmhlz6blE+AVMUi1o56WgzlpcGToeXm0j+xUrwJhZqfIjwP/L5klZkn+036wjw4OqmsYsNKEFN146wU0ThcVkuzo+IMFVsRLzQsT59bVOnf+a7OOT9vliCPa4TXbLb8kOuztongNqU/TiJN8op5IkkDM4624D5ruAPAonnST6ctsxSygGsw9m3ncU4h59DfnadWUXX9WM6JYi5zoKGKOaioJ50esTbxJ7zz5bicuvf/MvLqX5RFxBGj9HmmvV6rm9kX2/6eelluNN43qCGE0Yj4ghVArQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(4143699003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW1SY25Sa0JxQmYxRFZSOEZuNTViZ25UM2VRT1ViZm4ySUdyaVo2OGtmdjJz?=
 =?utf-8?B?SWhxQmFYZlNBOFhGanh0RnF4cm5lOUVzZlpQWkZkU0ZETkVvUUQxU054Z2JI?=
 =?utf-8?B?VHNZaklrcS9GeWpWVHZGZS90WFRpZCs4RWxpSTBWN0phTG9DOWx0YjR2bnJu?=
 =?utf-8?B?MUNSWSt3YXpIOVZjRElXTWVoSzJxN3hLZjJnYk5VN0dxcFg2d1JRL3JCNldu?=
 =?utf-8?B?dDF3a3FUZ0haWjBmQm5aS3ZZRUpOMDhaWU1qVE12QXhtZm5hU2VnejZidTJN?=
 =?utf-8?B?OXNZZmUzNlRleGs2Z1pLUEVsN0dFODBILzA5Y0cwdXdiclhGV0JUSDJZVmRG?=
 =?utf-8?B?UHR0TnVFRjZ3Z1VpbFBweE5PbG5zNmhYb21JUklwTkZncERvY2hOMFMzWTVY?=
 =?utf-8?B?bWR5dkJjbXVLVXNwMVI2bTlpNmdtV0x3MVg3aFkwZjhVRlZxM0JKenQ2N0NW?=
 =?utf-8?B?Yk9ob0Qzdkh3bHp3blU0L2pQNC9QWDgrbzhSYkZTS2lCSXVlTXdmWVI1Q0ln?=
 =?utf-8?B?OHJ2OE1aRjJBRHpycFpKK2xtK2NtaDlDb0VNRStOZVNuQTBrU2o5N29LQ3cz?=
 =?utf-8?B?MzVxMUluR3h3ZTdOWXEzRWg5QUI3T2VPdUxKTWZoV0hvVHlWdGtoTnlRaWxj?=
 =?utf-8?B?dUdTL01waE81WE5FakVQdkxnQW54MGFBb1c2OTBmTWthcWZLb0YzeTYwQk5z?=
 =?utf-8?B?SzZZWnh1STdrNTZwZzJNNmo0TENwNjVNQU9DbDh0MTdsZUwwOWY1QTBUamNy?=
 =?utf-8?B?VXRTREMvUU5QTEZkV1E4ZlZLc2pBK1BPUlFUOEY4MHM1VlVObHhYUHJLV2Zz?=
 =?utf-8?B?T3hUSVI4aHdkNVdUTHRDWXp4L3JlQmVQQUxoNTM4MS9XRHJBSEgyYVVEY0VQ?=
 =?utf-8?B?U3BzS3hmN1FRODRYYk9HS1lpanpHcS9wVmxmNU85MVJQS3VKNkNNdEpDK1oz?=
 =?utf-8?B?UFp1UGs4S2hLYy9kNXpVbTFsdnR1T0taZ1k1N0hiU3hPSVl4YjV1SEF4U2k1?=
 =?utf-8?B?cHBwU3hsMnpLOGFPK0tkUjArTnNMTGNPNW5FWnZIZE1mYm1PTk56L2NEQU81?=
 =?utf-8?B?Nnh1WlVrR0ZuNTFkZitkYmdrNDMzVVJlQ3NFV2FyY1dqUGNCMEsvK2FjcEVz?=
 =?utf-8?B?aU95ZTQrSUZuRTBuOTZVWlJIdXlTK1JOUGNCT2pVZHQyNFdOTGNhNE9ONjZY?=
 =?utf-8?B?ckQzS0ZndUdvcmJUY1R2ZUMxeVhuQWdDMXJhL1luenB1bjBpOGVyZDZMMlNH?=
 =?utf-8?B?L3BiRVFiM3JTN2JZaTh2QkMraVZGenkwN0VSaEhwRHlXczJ2RmViZTNISGJM?=
 =?utf-8?B?TUtOakk0cjBGQVp1b3Q0NmxIR2xtaWFWQzN1VXhqVC9qOXVoSk9iektjQ2JU?=
 =?utf-8?B?dlJaUCtyaExxY3lJOFV1dFpuVFJwWG5wRkozb01uajE2TFJmZFZENE9UcDF6?=
 =?utf-8?B?UVN0VmErRzRCY3o4b0djOER3ajMwOFQ1QjB1TWxoaVl3endjK1JpSXhPc3Nq?=
 =?utf-8?B?U3NWa2ZOY0VlWTh3QzB6dk5EdzlaclFQcllCTHl6QllFSDlsaVZ0S2dFMzVu?=
 =?utf-8?B?QzJkMmNSbEFXdEM3R0YvdXpiTVVXR21GMkxJRStzNjRxMjRVT3Flc3g5UzRt?=
 =?utf-8?B?SjBxTEZBSXY1bHhwL1BCOVpEbDZhQVppd25vZHk2VTYvUGJPVkwzaHY0TTk1?=
 =?utf-8?B?VjRHYzJVdW5PQlZscWY5WWNKdHNQc1BEZWdqOU4zbnZCbzlwblhLdjRybXZS?=
 =?utf-8?B?citSZFdoeHJEUGM1Z1djMk1KVGlOVjFFSkNxMmxYb0FRbkhyWFM5YlErbDIy?=
 =?utf-8?B?V001VnlxdE80WUxMVnNvQ1dGOEc5UzA5YUxOMlgyQWRtK1VmQ2M5VFpVazlI?=
 =?utf-8?B?WFVrOExCNGtzYmlVT0o0WXJOSUdIb0kvSW5SSHpwWDhWckEzSG9qcTExT2tH?=
 =?utf-8?B?OGhxaHByS2JPTlo0cmRUUnprbVFrSzdnUElqQk5iRWpJRUR4dUhZaEJ4WHFP?=
 =?utf-8?B?VVFxazljV2xnUVp2QWo5M0dFVzhkNjFrVkY5c0hZMktIM1Z2NmpTcFo3SmI2?=
 =?utf-8?B?YlJLaHBDL3ovNVZoaWFqL0t6NU92Zm1Zbm9kM1FENlBERFZXS3Y5eEZxbWJU?=
 =?utf-8?B?NWo0bnA5Qnd6TVBLZmVGUlZDQ1Iwb2lmcjZCRTBZMmpzMHhjUnQzcXFYMHZD?=
 =?utf-8?B?T29FcnlOL1VjUDd2QUh4OGtPMXRvNkNBNjczdnIxWmtoNDFRNTR2MUVZSVo4?=
 =?utf-8?B?R2VTVEVmVVh6ZUtWRW14RVljMVVDVnc4c3NydWg4WUlicXIvR2pzc2svR0Jj?=
 =?utf-8?B?dko0ZjBFYWEyQUMwalg4QnpIVDFxNzN5bmJLL1IrVTdiR0JJcjRPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35875fa0-6165-4c4b-7524-08dedcc1da65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:23:48.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSGhhbHCyWFD90OFmBlm9MGfusNxDr0zMz2SbtxZMiJyDJjumqNXDGEPXEw+9yZCqLUCOIqN2B3FFgOii9K5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3606

On 08.07.26 08:26, Tobias Schaffner wrote:
> 
> 
> On 7/8/26 08:07, Jan Kiszka wrote:
>> On 08.07.26 07:17, Tobias Schaffner wrote:
>>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>>> Hi all,
>>>>>
>>>>> this series introduces an initial EVL port for RISC-V.
>>>>>
>>>>> While some tests are still failing, I’d like to share this early
>>>>> version with the community to gather feedback, reviews, and hopefully
>>>>> some assistance in refining the port.
>>>>>
>>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>>> port on top of v6.12-evl1-rebase.
>>>>>
>>>>> Looking forward to your feedback and suggestions.
>>>>>
>>>>
>>>> I tried to apply this series today, and run into the following issues
>>>> reported by my tooling.
>>>>
>>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>>
>>>> A couple of debatable warnings like:
>>>>
>>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>>
>>>> WARNING: unnecessary whitespace before a quoted newline
>>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>>> +
>>>>
>>>> In addition to a serious one:
>>>>
>>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>>> <shanmu1901@gmail.com>'
>>>
>>> I did not get any responses from this email anymore. I can try to reach
>>> out to him one last time, but what do we do about it if he will not
>>> reply?
>>>
>>
>> If I read that patch correctly, it's majority is taken from the
>> corresponding Xenomai 3 logic. How much is unique contribution, how much
>> was your work, Tobias?
> 
> I added the evl_set_fpregs/evl_check_fpregs content which is a
> translation from what Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures
> with some isa enablement bits added.
> 
> This should be the initial version by shanmu where I added this on top:
> https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/
> evl_port/arch/riscv/include/asm/evl/fptest.h
> 

At least for this patch, I think it would be fair to claim authorship
for the final one and only refer to shanmu as provider of a baseline.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
