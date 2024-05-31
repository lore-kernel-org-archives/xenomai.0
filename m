Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA1155C8E
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164264; cv=fail; b=G4ZKkpA5usf/mvmC+wRriBkvNHL5kieAau58qPigokvTJCixu2wteC3gNGFH0xJ52qkHo1G6F/81dCMHRhf+T+gdfCS4dF77g3LgyafzAWREo6dTxKrDchuRhqRfZWlbScVU49pJ1zsE2RaQiWneCGtAqa3CU8hXiovpOvrLl4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164264; c=relaxed/simple;
	bh=MH5fgoy8BtbrXJRNkK4ncBnexF+XibyjhdzVb8Ua8mM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dW/V+79VZG8JIFVJp/m57LetuEoPcDg9rG0UVJxqE6Yl0BPm50OuGMin65IBAsAzm/+SvW4omoSjzxwp5NQ/kZwb1VW95nzoYiFldDq3ncQpnwALqm4hKQ93/vs1IS8MXGoAgMjmYlGk/m9gna+vmRHsSxUnnk7mL8LM45dnT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Jq90Ldlv; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Jq90Ldlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SirVZspEj86hrDC6XO4vancmGpXpfLuw9OlJn1N9W++P0AfKDIPO4Q7YzhvBcV+/0DgENFvBQ+XyktRu3AAILGeQcVdzCPFufXP/DprxexAE/JNuGBXfWpz88hd93dR6H4H+SxV27AUNDN7ZcnUSDu1cTM76j76NouuDsGexzN69coutAOfe7BKQnyZYxy79qEBB3IKjU/TzW32F4hPy71IQKX5GgxQD5T4j0XAdvo468lWf7nQClOI7biNMZl/J8YaR7YhI9MjND9YttGCXLH+USy2R7iGdFWFtE9WE/sXPMenk2EOibyCzJC8ZGq7PBjMQdkKBgH2zo0QWu9AwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucfekZsSGsNhl4YMwNk5IpfLJp/+gAZ3FosQOUP3zyg=;
 b=LEA+X+vLblRpOaacfumlwZKkerIXP4p41R1ocBdlEnXJn18/I+BztQWt8BSooSNRhGSktDUYvVzNf7flW7h4eQxIOlIA70jaWS4qjbPmPl44oEB2vrUYXQaU/Fq8DSt9vLzWSlyC1BDrOomoa/qmr6My7+GEiMNAAJ2HDqjXi9+JKM+C6w1YN11OLP58YO9DVvGExe/SKMZTYBCqUkMOREA66flfLmOKzk9LNGQ8bMMB3vShV7bRHGYhMneCYS5LJrqL1UQVK+XnhB9X7DLNudoMHkHoVmQ32Tu+2krJzzfkjWJHfSMtVzJsg+ISWBbHfTTU30RS8kv++ve0oeVu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucfekZsSGsNhl4YMwNk5IpfLJp/+gAZ3FosQOUP3zyg=;
 b=Jq90Ldlvw5an6nerY/pOkXMGPejEpIpur62tjMMLSFxO9v02NoFk0UhlsUb3HjqODHOvTsAuDdz6j9NgD3E+j3MhgTLFanggIU4PO4nJdOB0vXxl9ArJPQlYHk5tekQefowvZuaf1oPIwzRzQgXMoujAqSGA4cJaSLRLWeRj2vZmejqaD3YEfXaPn1MLt6S4o2yOSeSPL1dOygeM5UZ+joiQVixShFYhghQXlWZHNDbfytoIUUpaWRMv95LqdzOUwl/YV8j5TLbENaBuUVhnqDH1nIT1jDCZhenUK4ziPSoFOqqRzxLFNWqGqwHcPVrn7UM+wXXzqksFiYuEXppngw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:493::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 14:04:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 14:04:17 +0000
Message-ID: <b54d8394-da9d-40a9-9320-3bab5ced2da0@siemens.com>
Date: Fri, 31 May 2024 16:04:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dowload URL for ipipe patches?
To: Norbert Lange <nolange79@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
 <207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
 <5f546c94-440f-4641-9549-f6c27652caf7@siemens.com>
 <CADYdroPpqtYYwvAgmpH=E4a3u0-C4chaBqwioe658kN8Tx5BFQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <CADYdroPpqtYYwvAgmpH=E4a3u0-C4chaBqwioe658kN8Tx5BFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: a73a8f84-9688-4d8c-3dbe-08dc817a8f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE50YkYxYU5Yc3BOZmtIWWlyM1krWUIvSWFRZDRrbU5uaUJzQTJMWndlSDJC?=
 =?utf-8?B?dVVhT3RmTDdlbk1NalhaTDhJMkdsaGwwWlZ4aU1mSFI2dTZJSXZNbUk5b1B3?=
 =?utf-8?B?Q01DMnI3SWtmSGE1b08rZ1dRWmthNWpGejhqb2dkV3hXd09KaUpEZEd4NkhN?=
 =?utf-8?B?WFF3Mm96WWRHQnMrUlhOaVZQUE9SNUNBT2hKemZZdlB4d2hRL2NJeHpvbXly?=
 =?utf-8?B?bXVpWW1WTW1hRXZ2Nm05aC9VOWgxNm4zK2pHZ0x4K092V2tYdzBjamRzOU80?=
 =?utf-8?B?OXVpeDQ3b2phS0VrQnJjUTdsZW5Tb0JEWUgyMk9JWXl1K1lQQVQ3NGZGcGhV?=
 =?utf-8?B?NXhpM3ZOQnF3bks4bS80MjNsdFNkQklldUZTN092elhaVk9uN1hNT0NFclEx?=
 =?utf-8?B?bEl5UVc2YmNPR29mZ1oxanNzOXlKdlJoeFVNMWpEaVdDcnJjL09jRUtqb0RY?=
 =?utf-8?B?YkFzNlhGR0tHN1FqUjJwQWlTdldQaXNjNWpNaXY0VlBzT05QOU1kdFM5L2Rx?=
 =?utf-8?B?cU1pcU91cmMzNHFaZ0FORVl6OFpyazd0NnVDYS83Nk54aEd6YUZDNlR0WHk2?=
 =?utf-8?B?VXpPeEpRNzZKckEwbXh2OFUwYjhUV1R6VTNLblJIVXBKVWZhVFFtd09ZaER1?=
 =?utf-8?B?cWtQbUU5Z0dtWUNseUNPMEZKb2theHNZRXUwQzE3ODc3L00rdEhYb280V05Q?=
 =?utf-8?B?OE43UlNkcnZEUk15S1liNzVHZExOWXJrM3lpYjUxS1hodzdzbXVmWnhuaU1O?=
 =?utf-8?B?YU5ZdURtdHVvMjFhZTZjK3ltaGZsZVQ4OFBtY3g1ZVd2cXNHc0pLNlVwQnRw?=
 =?utf-8?B?d05VUyt1WmowU3NwenUwT3IrdTNuZFNNa1NBaWQ5RnJNd0YxWGlGeFNvT2s2?=
 =?utf-8?B?YkU5Q0RTdmNCaUt0U3g4NDhRWDhrSnZhMGlKeFFjSkkycm9VVjdFVXN2OEpP?=
 =?utf-8?B?Q1lLYkRqREpianQwd09uTlU2UWdiTE9nYy9FNmdmc1I5WmxsZmtFRTFsRDdN?=
 =?utf-8?B?aEtnRVVIL2NTaWNHUkNRckRMOXJSZURsSlFPVUM4NHJrNlNrZVdZUEEwODIx?=
 =?utf-8?B?bFNvMFcwSEN5a1NMUU1idDd1SkE5Z05rMVZqV0hiLzU0VHRZTlJYM2ZJeVFu?=
 =?utf-8?B?REs4YkV4OUhIWVcvQjZpdkpLY0NJT1JkOWNSQXUyWkRHZGZIMzFRV3hPS21y?=
 =?utf-8?B?ejlma2drMEdyYXA2eHRSYmZ5SXZwbElvcVJRaEN5TlU3Qm1JdDV2N1g1VmdU?=
 =?utf-8?B?UUlLYWpuRUtlQXEwam5ISFZOa0ZibjJ0Y01aT2pUR1I1UTR3SElKajNjUlhr?=
 =?utf-8?B?TWlwVVVOeDhXb0lBM1d1RnBFUy95TnlRMGluYUJFY2RuMGRvdVk1a3BFTno3?=
 =?utf-8?B?ZURJbFdKT215bFRRYWFCRHMraUNWQk1COWdPODd5WU1Ob2gvU250eWpQeDlC?=
 =?utf-8?B?anA4TXcyOWNOYlpEbXpZNmpaMkhxeWRNZm5Da3RsMFM5SWVTTVNBZisvYXZl?=
 =?utf-8?B?SXdDa1NOY0UvRkRLRmtPd0dKNE1IS1o2dlhpTWpxVjZEWjI5VmVuRy9mcEZO?=
 =?utf-8?B?QmpoK2paQXZodlQ1bFk1WmRkTEhuK0RNQndvSUp5bFZTRGErbDFQcEI3aW5v?=
 =?utf-8?B?c1ZwOXJ0bGJqSldJRm40KzEvcnJoQWtiYytUdG5GQ1A5WCtoYVhIVjRsUUw2?=
 =?utf-8?B?Z0xVbUR3bm5TVUJ0UUtrRXJlZUU4eW1GSWZyMEJYMS9XY1YrRU5senR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk5iaDN5Nkk3MldsNEdVeDM1ZXVjNEQ1NDRLZFNLZlJKTjFBOUswQ0VmZUNa?=
 =?utf-8?B?NXV2Z01rcFFFOFpCOUkyR2xJaGExMktXRUQ4Q2JzMWNZOEFjLzBqVlZEYVFn?=
 =?utf-8?B?QlcyYkdXTjZneUZ2YUxPL2x5UVJ1UWRqczVTdlFsM01sUmVsUnhuamJTSHlD?=
 =?utf-8?B?Mzd5eHBNN2hDWnBsNG83VlhBVFZpYWtmZUp2c2kxUWNJT0t3ZFNaeUIvMmU4?=
 =?utf-8?B?SVJjNTNCdmFIOUZMaW1mbGtjaVJ1b0hXRUZIVWRwMHhuYTl6UGtOcVFUS3pu?=
 =?utf-8?B?SVJwU0ZsbzdPMnFzUXdwUks2TWthRmt5MVZMUEwwQ2VmZjdpSnJLY05KSlFu?=
 =?utf-8?B?TU5CMDlqY25PLzZBbWs0dGNUNXN0cS9TTHIyTXpoSjdBNWdkV1VLTXdWYlRW?=
 =?utf-8?B?N3UzeXFnYUNlVXNRNUVyQWxBREpVRlBpdmYvb09ScDkremQzQlJDb3dMekxF?=
 =?utf-8?B?SW54U0JaRVNLM1Q4cVpjakJxRHhXMklZOXBFc1QvZjlIdW5QeE9SN3BLL2Ux?=
 =?utf-8?B?U0UvU3NvdGdnQ3hnK3lIdEkyVy8xVWxtZFduQkgzK1R6UXNTN2FiZytZOW1w?=
 =?utf-8?B?WGt3ZndDT0RFMGVJTDZEK2k1R0RIbGtZSUR1czd2Nk4vRk9CZER1WVdPc0dl?=
 =?utf-8?B?aWpqTERaYTJRaU9GekVmMjRIZ2xWVzM4aEF6eVZBR2l0ZUZBZytQNmlwZkZV?=
 =?utf-8?B?ZmF3YW9jMjhSTGZtUFpqcVVvNEtOOFRkVFBuK2R1MzdYdWZoaHI5WUtuM2xv?=
 =?utf-8?B?WVRVS1cyeVV6MjdvSyt5WG1oKzNkWGFLK3JBVFc3NW1mVVBOL2x4T2dicnFz?=
 =?utf-8?B?elVnbUppK2NJM0Z4MUVwWHFnVGRTQW1FVDVzRXJtQURnNmZ6QlUyMmM5OWIr?=
 =?utf-8?B?N0k4TFB3S1VHRnEyelBVVUE5WTV2dmppeXhSVmFYU2hVcEpLZStCc0RvSWRR?=
 =?utf-8?B?MkdWS0NBQ24yUm52V2dNU3Z5VnZuSXc3VkV5NStNRUUxMmRFMTlkT295YXVI?=
 =?utf-8?B?YzBoMU1tUlJaaVFLcU1HOFVVaTY0OWt3U1Nrd29VZkRjeThjU0h3Tk9rcWpl?=
 =?utf-8?B?Y3ljaVFneTBsMmZrRDNWZzF1d1RDZ1FnREVRak16cHpNbzArN3ZPSkFXWHZU?=
 =?utf-8?B?dUpWUUNQb0lyQWN3SG1lVEZLRDdLQ1BvZ0xkaVZhMDJCdTNldWlFVmlnTjd3?=
 =?utf-8?B?dXBmWWZIL0pZRTJRcWdQT1I0SmRLa0IxK29uc0crOTYzd1R2aGdOTzhnWFFQ?=
 =?utf-8?B?RTE5QjVvV09paDU3SS9oQkxFazkwaDdhVEZERnFmTXFMcFlvV21hOVFmK29x?=
 =?utf-8?B?YkR0d0pmZ2VvUDRuZnNGdWV5UzBuSVlGNkJac251QlVjdk95cGRVcVEvV3Rk?=
 =?utf-8?B?aWRSWkdTZC9yVWFuVnFoT3o2OVlYWlJVTGh1Y3JEM2dFbDVuZWtheWd1L1JD?=
 =?utf-8?B?ejFCU1pmRkl6dUpmZDY1VzJXL3lGRGVxaDNVaGQxYTZqRFhrbDVXUkxobjBE?=
 =?utf-8?B?QkFNbU5IY1BSd050WEMrNCtWdmNRZnZaNjZzbkowdy95Rm5uaUEySmx3cENK?=
 =?utf-8?B?ZzRIMnBlMURrYSt3QmtpUUoxL0NyNWZQWFY1Q1hKOFd3K0gyc2RDTnpqRjlz?=
 =?utf-8?B?eVNqRXBJK3E1MmdPaHBQQnEyUzg4aTZ0amlsTDVlUisyRFNiZjR4ZDhvS3lr?=
 =?utf-8?B?TmN3eWJ4NkJodTJvQ2dMNUorM2R1VGhFOEpQN3dFdUFvWktLNHcwNzE5YU9m?=
 =?utf-8?B?cHFnMWJSOE1QMTdYK082WXFKYnJOVXQzSWZhb1JuSXdPMWkxNFIxanZmZDBY?=
 =?utf-8?B?RDZia2xWelpVVGJZMDUvMCtoNXlNdTg0WEs1SmkrNGVIMmNoUGtGanRwT2dI?=
 =?utf-8?B?dGtxSWloUHBFQTR5cUhIQmZSYVJHME80Q2F5OVVSRTA5SHAzNXArU3R6cVFn?=
 =?utf-8?B?bDlmZ3JyeVI4QnB6OGRSVDdFWk4zdlpwZllRWE9Hck1UT0RhWjNaZitnOUxu?=
 =?utf-8?B?U3h6S3c1USsrTFE2SHN2cUtJWEF6M3VDYzVHZlR2MS9XOVpyS2JLbGxsWUlE?=
 =?utf-8?B?VElpY1ZrTU02TFFQK0lCRmY0UnVpRlB1UWdYNE5FaTB5SGxHb1dwYkFoMHJu?=
 =?utf-8?B?NXhzWTJqTEVVdkloR2hhaVRMS25EZkZGVVJGclBoUXZUTmxVYzlZS05uOEZj?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a8f84-9688-4d8c-3dbe-08dc817a8f56
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 14:04:17.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb5/gLpLu2KzRI+PzkSVonHwdQnj9UZFuKpmt54sLTJkUVgYVT2P88U9cWEUTIXLveHgQcIj3//zFrv6k554YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7694

On 31.05.24 15:53, Norbert Lange wrote:
> Am Fr., 31. Mai 2024 um 15:00 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 31.05.24 09:11, Florian Bezdeka wrote:
>>> Hi Norbert,
>>>
>>> On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
>>>> Hello,
>>>>
>>>> the older URL's dont work, and I did not find any reference to the
>>>> replacement, even rather recent releases have non-working URLs [0].
>>>> So the links dont work, and the gitlab repository doesnt offer them
>>>> either, eg  [1].
>>>>
>>>> Whats the plan going forward?
>>>
>>> the main point is: I-Pipe is "dead" / in maintenance only mode. The
>>> last supported Linux version was 5.4. We have dovetail for modern
>>> kernels, so the way forward is "use dovetail".
>>>
>>> That said, we have a downloads archive [2] here. That might help to
>>> some degree, "newer" I-Pipe versions are available through the
>>> architecture specific ipipe git repositories, so no "ready for
>>> download" patches anymore (as far as I know). For x86 it's [3].
>>>
>>
>> Right, we are no longer having infrastructure in place to format those
>> individual patches and push them somewhere on a static page. None of
>> that is technically impossible, but given the current demand for
>> restoring this (you are the first to ask for it, TBH), we were not very
>> motivated to do the required work (likely more than some hour on a rainy
>> Friday afternoon).
> 
> My  main point being that *all the docs* still refer to the old URL,
> and the method
> of using an upstream-kernel + i-pipe patch.
> I don't have a problem using git repos but I would like to use the
> correct infrastructure.

We may need a friendly janitor to update the docs in this regard...

> 
> As far being the first to ask, first we have all we need stored
> locally, so we can still
> build our past versions. 5.4 LTS should have still a year+ of support ahead.
> Changing to dovetail is not really an option without RT-capable
> network drivers, and would
> be anything but a simple change. Is there even a plan how to support
> for ex. reading PTP Clocks
> from realtime?
> 
> FWIW, given how thin the RT-driver support is with Dovetail I dont get
> the point of using a hard RT
> OS without getting your IO in hard RT. I get that someone has to do
> the work, I get that the old ipipe was hard to maintain,
> but this replaced a much more "complete" framework.

First, I-pipe support is not completely dead yet, 3.2.x still has it,
and we are updating 4.19 and 5.4 in principle (needs a kick, though).
Second, dovetail does not imply moving to Xenomai 4 / EVL. You can
continue to use Xenomai 3 with the driver supported there.

PTP clock access is an interesting topic, though. You get it "for free"
if you sync the system clock against one PTP clock with all dovetail
kernels. Precision should not be affected by the fact that Linux
organizes the sync. However, there are no plans to provide other kind of
accesses so far, specifically if there are multiples clock or if there
is no synchronization to the host.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

