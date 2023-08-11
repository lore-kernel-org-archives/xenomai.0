Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37036EAF9
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 17:05:07 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 83EED200002
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 17:05:00 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::622])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 76A25D8004C
	for <xenomai@xenomai.org>; Fri, 11 Aug 2023 17:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4hdB2yexzUV+P7FYP14kKQ3JUsGD0Fsn6n5B+pqJE2C2nWm8C0mJoUKT09a4d4vqPRxqtMSLnwxKR62hOuds4caqxmy0ABbdw6wSpXMiOs/ivcLYelfQJ5jFeNHseNr+fUr8HUw0D8mAsD5Wz2zNVfZgZh43/MdVd8Dxgsf8zyRGe6zHkTFlax4LHx+OtxI/uAwTUvyTpMK4dI8MrSj8n0TmUoUeZAS4WbNlj7+AMo5smocuCPzHYjkVP5N5OPxQyf3gBbXi8kClVhz2E/piVkCFFkzfSSKSatgDT5pGlXkfxw3lHOIfxk/e90cZDxNNUkK7S/t4UQE0y1/Dq/kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/WTx2UsvHMj/THKHWoo3VQWRIFX0A+MbYU9WmanVeg=;
 b=ZkhKVRQ/cMJkVpr4rFPs3FCwzHwlbT99IvWRWz/W6FiCeR4pFFLqe+ry7lmrp/TBXpFWGI7Zp/lXz/6lN3pKWT0ng2SA7bFjuPEieeiLTaZvOVYEvAP6E1JEOWoP+cpKvkDbVD3SVtriOLP4VrgYcxVX6nDyiniYN8so4vB90dFieu32YYt5+rl+kTiCSfgYMnv9PdEMn2EmjNr0msYo7DQNHSHwK2E5uF8jQ5DFFTwPCHRJlF2kjje8ZeXYnQA7MNmDUhQYbDE8cmwWTdOwwDslIlURLFa+xVZ/ktLTBLGpPw9POFF913psJhwUDSh1JqpS+Psm7av2L+Y67iWHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/WTx2UsvHMj/THKHWoo3VQWRIFX0A+MbYU9WmanVeg=;
 b=zx1hegIPkQNOKeLXNlUEDJAmseQp1oq6rQYsY+PM1Q9uKYtiBUdTmGEzCG6u+5gkkKy+DvQbp2+A/bY5hKnx3YCGEfeLJ2Bd5+ZCZD+/TR+wKSzTIYcLBredb3F7qTtN6q364zZTOeFF2foC16hWX8db/SCDoSZGBWJ2k0t7C5PMrL5eZqk1jiZDfoUC4CrMAIYnm9QmD6gFxTmr3rex0IrQxoX9IA61JmUTM6Xy5bin2KloqVkHYB/uWXo6CyFUIUjUau256MV+k2BuBhuL3nqjwwWDk70h3RggktZcefLiuZu8UY/UJsNLCNFsouiMdxjwRJo5UiIqarUZPFbfnQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:04:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 17:04:57 +0000
Message-ID: <48922226-aaa9-4fb2-9403-2a899d01d8e3@siemens.com>
Date: Fri, 11 Aug 2023 19:04:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: XENO_ARCH_FPU
Content-Language: en-US
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org
References: <1bfb1-64d66100-5-66457a80@79680807>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1bfb1-64d66100-5-66457a80@79680807>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3181:EE_
X-MS-Office365-Filtering-Correlation-Id: d32c4ad3-0781-4b3d-ecfd-08db9a8d16bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c3R28YnS1KHafEKOz4MTcUToPvQCCSsI0qDtLsLebVN/uWj0iJZ9kk+7eZ875PHtZolW5dZFYkyr87F6xZAxo7M6jSQdvMvSLF//XTL/v5BenQ+qUtm4DDd+a7w5qTH748WJ8MgbKUnKEUg41BNIbD1Z8+6eVDcnOLTXAFHqunr9N6+L1QLntssGOUSm8Nis0tgz7nWBG6A1+y4fVy2ZhK1m05lgswAEu7OfljmzpJ8weOC2ZUlAaG4XczvjVQvY9gb2pNbtyT3IVZAMphCUbJb6QAUwzsxGquY5+C9hpl8uuIvTeZ8UOQRYhTRuGCFQbwLp2NymrgL8+sdRSVKYCNur1QIh1ztHXiiGskIpxzSOMqAy98nTeuEdHFaESckNQWVkfWFzp80m+MRfT0enQo0TJtXLdk32mGaj2IvP+/e5rQJ8jIod67mVKx1DH5KoLiPjur6j6RC4AGeP0BaO8y5LiFa30atf3/7GgcBybS1QE0y/qyMaLZlgRYsG/86VLX9oKPECjO5VCt7UOjKLlykw7fmNtSZxScQ9nA1xej+T9pACpwIzCzYQiKqF6Z5egheRjBitvl33VbPLXwsTFpUeNjan698H7P0m1bURv5EfZ5UmUjGpgA4z6UdNWBQaM3ThJWy/N7weH70hc4Dvog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799006)(186006)(451199021)(6506007)(83380400001)(2616005)(53546011)(41300700001)(6916009)(26005)(2906002)(316002)(66946007)(66556008)(4326008)(478600001)(66476007)(7116003)(8676002)(6512007)(5660300002)(6486002)(44832011)(966005)(8936002)(66574015)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG51Z0swVzdubDZGYWtwNHhpejlTcFJoTytzNGJDWE4wUTNyVVo0dFI5cE1F?=
 =?utf-8?B?ckU1L1hYbGs0Q0llODNZRG1TN09kTG9UdHRuSzVrMU52U1BCRlRiMG4xV1Zk?=
 =?utf-8?B?WHgwQVVoQUZHdUhLQ0VNRHA3VUlUbldwYUllRnY0T2xTdWc3YWpVemh1Qngw?=
 =?utf-8?B?cDVlTklLOFZLWER5Rmloa05EbCtGeTA1RDIyRlI1Mks5ZE9JaFcyb214cG4v?=
 =?utf-8?B?YmR5bm9HN1lyclFDang1RFV3V24wZ1NIelE0aDhlVm9JK0w4ZytDdG51Rm1r?=
 =?utf-8?B?Q2F1aEJIb3BXZFpJZWNzSWVxRW5iMy9DcDNIM1JjbFVyN09mWktleWtvUnlR?=
 =?utf-8?B?aStBT0kwZDdaWWNZOWgwL251U25oM0p1WVdweEJxalFlUXdaSHZIWktyaUNv?=
 =?utf-8?B?dDBQNmxWUnlESG5hZlYyT21wSW5XRjZEcEhnQXFRYXF6MGMxa1N4WDdBdzdF?=
 =?utf-8?B?UlZzaERpWFR2TEV4Nyt1UThwTFNOL09iRnJqZlJlRlFZdkR6Y2J4Z1lVdlEr?=
 =?utf-8?B?VjZQTk5tMVh4aCtyeGRmNFhzNDlWc1NYZXdUVG1EWERWNDh6T0NKWjdxZlJR?=
 =?utf-8?B?WHVrRjZ4SHA5TTZrcGlYMWk5blc1cXFrY2lJUTd2M0c3cW5FODJrbWtjdzAy?=
 =?utf-8?B?VlR0SnBlbDYvSEJaUFdIWDRnOXlXaXhzaWc5RlpuN0xwSzJsR2d5a2tUR3Jv?=
 =?utf-8?B?ZVkreHRXRXdadU1IWHJSeXdWeWpmV3RpUXZibTN1T05WTzdHZEprczRDanVV?=
 =?utf-8?B?eWw0dUE0K1NKZHE2TEY5ODIyczB6OHNzZ21EelZBZXpuL3FkaDYzODRNNEFt?=
 =?utf-8?B?NTBxVVp3bzYxQStBMjNod1V2a0x3Q1V0MkRVQWl1SkhScXhWZmkyS3c3NTli?=
 =?utf-8?B?cklVNmUzdGRibUJzUE1LbVhNRHFtSFcrcXFod3gyZCtxdmtGcUhmNjY3cm1K?=
 =?utf-8?B?STdtaEZBUDNoanZrL2pQVC9vaFJEVHkrOWFlNElXRkIxM2k2K0pqN1dzeko1?=
 =?utf-8?B?OCtxU2VIcFJ0dGxuYUtBZEcwc29lY0NsNUhxVFZLR1BENkNCUFlaOVhFTjcv?=
 =?utf-8?B?OUJmWjZCRlhjU2JtTXB4Z1NNd3R1NFR2V25zSnhQRlljQ3J5UEZ1cW83bWRj?=
 =?utf-8?B?eEZaNG9pUmg3cUQ3MmRxSThPbTk1S0NJMXBzVGRMSEJrOUpSM25RaXVLbzdh?=
 =?utf-8?B?cG9PdzJ6djdKK3BFKzNwVHVKQy9xVXR5MlhZbUJuQXdMSEprMlJ4UmpxQ2hs?=
 =?utf-8?B?TWgzS01UWG5yUWpSbjd4dlRKZjVKYUtvbFFQcHJDOW5TaGJtdVY3NEk3MmhJ?=
 =?utf-8?B?QTJiOVkwb0dVVWNPVlY4eDlaL0wvMXhDanFRK2I5QUFmK2FyRFFEalZ1YlIz?=
 =?utf-8?B?WUc4WmUyUGhQdGIyT3BuWE5qVTF2M3hOZFM0R3VuVFRVZ0ZVVS9UMFlXRzVZ?=
 =?utf-8?B?eDd0Mi9sNjZRWFdCdUlLMzhRK2JrdWJyQiswSXQ3STdjSXFkTC9FdWRHaHMv?=
 =?utf-8?B?THhvaUt0N0tiK2kxY0d3T0psRTB1V3J4clRhbkxuUlFiamdZUzVUVGt0VDFE?=
 =?utf-8?B?c0NZcDZ6SDhHT0IvSXF4SUYrazhVUFp6cVlyOE8wQW5HRUlONHhYaXY0bktJ?=
 =?utf-8?B?V3dkdmxKOFBPV2huMkFpYmF5b2NzVjcxWFdSY2laMlR0TTMzdHE3bVYydFNx?=
 =?utf-8?B?aXVWZURGTUJsRW9yRitrOFlNMkxkQjhFbXpXaGFORU1SUW9SVW10SzJJWDI2?=
 =?utf-8?B?alNQMThHUmI2aUNRWGVjbnRUa1BNNkV5VHZVSnVRWTZhSytUV3JCM2hFWFd1?=
 =?utf-8?B?MzVpN3ZMQWtKbVdDMnZ0ck0zbDVhd3FNYjlkUUFsdk5ZQUIxNVF1RHNFbkpy?=
 =?utf-8?B?Z1BsVXUyZG1HVkVtNkZZeXF6akJhRk5LWUFtSGUzYTc2dzFONUw4dXRSMFgv?=
 =?utf-8?B?VW9PQVpKczlERG11QkZlVUp0OEY3M1FRZ0FNOGwvaXk2ODJSR3JPZWR1bG14?=
 =?utf-8?B?M0xudWE4NExkckV5K2duYkFOc1R2Wk9DYjErM1dwMWpQdTlzcTNybUVjaGto?=
 =?utf-8?B?UzFqZXliS3BuLzJjdHZtbytKMVdpMjM4ZnB5WHp1VWNSZDRiRWp1amk3aVpH?=
 =?utf-8?B?L0pOYnpVTmZWNkJxWGFrQlljUEdhRWVVdGdqSk5ReE43RXI5ZktZQXZ0bCsz?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c4ad3-0781-4b3d-ecfd-08db9a8d16bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:04:56.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lKVPxqEyhvawR/vjv9Bgu1ApSRag1dWO887KcTkMEeHKnkEbsByO5d15usNlQ/CQvBmJ+yWJZCKfXibnZpliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3181
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=zx1hegIP;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe1e::622 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 11.08.23 18:25, François Legal wrote:
> Le Mercredi, Août 09, 2023 13:41 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 09.08.23 11:17, François Legal wrote:
>>> Le Mercredi, Août 09, 2023 09:38 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 26.07.23 15:39, François Legal wrote:
>>>>> Hello,
>>>>>
>>>>> upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have a build failure on kernel/cobalt/ipipe/sched.c :
>>>>> kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration of function 'switch_fpu'; did you mean 'switch_to'? [-Werror=implicit-function-declaration]
>>>>>
>>>>
>>>> What is the kernel version you are building against? It's kind of a FAQ
>>>> by now, but 3.2.x is only supported up to 5.15. Newer kernels need
>>>> current master / future 3.3.
>>>>
>>>
>>> I'm usign 5.4
>>
>> ipipe-core-5.4.231-arm-6?
>>
> 
> Correct

Can you tell the difference to the configuration we were building here?

https://source.denx.de/Xenomai/xenomai/-/jobs/620838

That succeeded. I used multi_v7_defconfig.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

