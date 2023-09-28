Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA06D18
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 05:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv2OSkWlu5ccbhhdmDIsfoH7Bbpuh/MlRgDwtF00rtB/2hh35jTs82yb0UmWjOJMI41hQLaOi5VGWzHXxjK3xjMftZqaaQy/pYWefKnLyezG5TZkfaA3Q7Th37FfiTD2EUMyHEnVcLw6NK2RHRbR11wWxVRln2FvePY0uU0adgj4ZcgS4Va2/+c2duH4Jy6yWcewP+EdZ1nLVerFN+8wL4qkuOAfLwPZ+QtHzxaAG2hnGf3jeWH3HqydoU61w2FxO7zRQGAPCehiiPNQNRBFn6BSnfuZ7pGi2Cgpn8kvoxCgt+lgHHM2Wr0y9b+VRzavcB8R4kyk0k1VVz8bNRWirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvmjSBrP3frFchE/glRr1F2tmvuaA0YQYHl8JPA7ilE=;
 b=IT/wzSn8efcisad0Pulkf/Rf5zOCded8cpfV/LPAaQQAKOT6TI5wOgkRWnWHkm58UfSLHAo6N0bTaXoG18gDBObWEKuau2YQ43kYlysLo/azZwFO/zkHLdfqwdsb1voy/kk0UkpMMkigBBofr74HzP1pI98azwEqaI9QFRc7kMMl1Xep1dU0/a0NyWlneAi/iawLDKk0gVczU7bgQeag3JQ/JePE4Oc67C53jziLsHLKbt/Ycn43rWl0KatwIm75LGQe+TbxPXiZqqf3wUwTRPsanmnp0cu+CC7HrWz+qicm1elh7QJwmpfbSj9HpkypXDqQkGNuhB2tymi9aGYmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvmjSBrP3frFchE/glRr1F2tmvuaA0YQYHl8JPA7ilE=;
 b=Zr2Yb+gkOI4B61Tpa7DhVb6/iOMj2N3ZAG060sLPyD46YRzPju6KFotGMNv+ctimUHYRkbELJ5e7R9ZP0oarBWjaEQfxKUDvAYKutUMM1Yr4Axp2xw6ttJsIt6BY1F3d5IAJf9VG/8wrbGn0MC73fdYBUxHcsINw8iME0dN6asZBOOCKDxsHOy8Z9hk/BkROF+RDLqCd76+r1MLqsM6d0r+vAAlfaaIqkK86UrcdiD/lT7x6CvMC7CFKt6g65tLSwzi4EzzBsbQYQwTeTlJJYp973O7ekNYDC9VLgB19JWT0NWOKuz720/DlCGtYhlHvfcBspjrVUF0j9t49IHCQ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 05:29:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 05:29:42 +0000
Message-ID: <b6c73b70-fca1-412d-9930-d53ff1ad3952@siemens.com>
Date: Thu, 28 Sep 2023 07:29:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [stable/v3.2.x][PATCH] Fix detection of dev_addr_set availability
 on 4.19 kernels
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <5379efca-76b3-4413-85ab-41db5a9e7524@siemens.com>
 <756760aba823b02730cccf4e995019f889777567.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <756760aba823b02730cccf4e995019f889777567.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a53255c-fe1f-480f-0c89-08dbbfe3eae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z/LmN60yG5wfTSKx3hieCSHGMgD4NV1H0RAbizhRIieDESv2vJrP8oXBmz23xG4L7b2TtBF849o7dNW1LjKL0CpQwVfPjSDdfRDAlmrsZT4lvq1HvO693SgqfuPfPkgM0//KgLHPH4m07CkT04Nt6xkBeLJfmHlIEr3C4J6dTk2S1/QlGzWk+lgry5cN0lHkKD0YHYrj68alvin2r6GI3v4UdLkxEebzrONi/bZ/uAMnRHGUt/rhmOsqyvQD+jQ94BwWJNUoejhvrZhuGmb5n6x+9G6x1O7DZC6icYGZBeJz7yMzr1bWscK/BnQQA5UMmwKKfx9hplYfCK2InkWmM3z8SfK1Izst6hlvM/6doqR+IjxuwBhZz/PYDxI/6cOMiqy4telilXfxBP7qt0CJw/sz4CN+DLtRcXfCGU6fnM+Nb+5GT6p51f7InrlOAIlULQ8HYf6hRhyNfJ81JbprWTaAF9WZGJybmmPlZl7vck2emUVwIwtKuQkF4Tt+X7vvlowrGQEMQ8i588+5X21gQUAzFBagupGWGeTghjn2CYh1TtoLYS6yTFAkgkEJzDJNRtBsT+ZkfYCEHPkXAmRdZaSD7IlNMsqeu3oGrvx0FTr6HVvaBB0xWo1LQpwY8kBabt2LEXklgl5iJVqYyCt4wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82960400001)(6666004)(83380400001)(38100700002)(6506007)(66476007)(6512007)(110136005)(53546011)(26005)(66946007)(5660300002)(478600001)(66556008)(8936002)(316002)(41300700001)(44832011)(2906002)(2616005)(6486002)(8676002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVRQU91eHJFbExuTURHWHFybGZQVG80Vm4yQmJGdlloeUNWcmU1blZveVFE?=
 =?utf-8?B?OVJoY2ExM2pKdnVOWldhNmQrc3o0TWVKbUFwSDhnV3NHcnVUMEkrQTNxVkZE?=
 =?utf-8?B?QTNuUVdpRlpiNkFNaTBqei9hM0J3UUVzUW8wVUhDeTVrd0c5Y3p0Z2F3bER3?=
 =?utf-8?B?WU4wUHRFckhqUUVhOGZiMWZYYWlBM3hwYmxrOVVrUFdZSTY0MUcrVUdZaHc0?=
 =?utf-8?B?MmxZcFdQVnJqdmk1WG1pREFCZGp3QlZiMSt5aGc4cEo4OUdkMlBvZ0t4ZWlu?=
 =?utf-8?B?dXNMamhvemU1cFhKaURmcXozcGQ5U1FmSFRPbzBVTm9qaVBSbCtDWElLcnlx?=
 =?utf-8?B?b0taa2xiN3BRN2RFdzhTN1Q2RjF0VjBOZ0VFUHhnaTg0MDF1UjZVOUo0Nzhv?=
 =?utf-8?B?V0VmZk1SWExDMWFDdGdoSENRSjRnSDh3OVdpSkVtWm5HdThNcU0yV0cyekd2?=
 =?utf-8?B?bDRacEp0SmVCU3NKR1EwamYzbVhzNy8vY0MvZFJ2K1Q1dGFDZlEvNDlXRXpD?=
 =?utf-8?B?bmQ2YkJwMlNDN0dhaWw4VTVqMnVobjRGcjMxRzhoMm8rMGsrWWp3MmRjdlZI?=
 =?utf-8?B?RG1MdjZMK3N3RjhzdHNXS3VzMXB6UytvNmZGL1ZQM3hTeFFjaGZPSCtZYXVU?=
 =?utf-8?B?WDVRRnNHa1gzMktSbWtUczdORjREcEpyWG5PNng0M0RodGxJeWxZNU9EMHZj?=
 =?utf-8?B?Rmc4S0pWcTRjcThUalV0eDhwOVdMR1BISk54SHcyTHRkR3FiNms0elNCcEMx?=
 =?utf-8?B?aE00OStFMDVrZXRwamcvUDcwMG1HVUl1a01uTzlmZ1JnMUxna3RPaHA4V1hM?=
 =?utf-8?B?a2ZZdmxuVnM1MTN3Yk8vVUczZlpFbE9vRDlEWFRVM2ZzSGdGeit4RTFFbml0?=
 =?utf-8?B?d09NUXJRNVQrZ3VJTE5wSjVOM04xZm9LZWM4bUR1RFhLTHZqeklrWXJ1bW1J?=
 =?utf-8?B?ckNYZTBzbXBXTXlVdTM1Q3pPWXFUK1JTVjk4OHJRbTU2a2M0WU9xOVVpODNJ?=
 =?utf-8?B?eFRZUnNrYU9jZDJHbVJIRDRDMDh1eTdPQWZlcEluWFFCczhZdW4xbGROanRi?=
 =?utf-8?B?YjArTDR4VHIyeUVlL29mUUxEL2c0eUdseXZlWkU4YXZaMjJtbDZ1V1FXbGZw?=
 =?utf-8?B?S3FNMldGdWEvN3h4NGNSTUdYTUt1OERqWVV4Y2ttR25QR1ZMUlJGaTYzWlZO?=
 =?utf-8?B?TVZPWXZ2UnlHVnc2VkRGWVdJOXhPWjlIWDBFeW1DK0pHcjZEaVFRbnFuM1U5?=
 =?utf-8?B?MTFOd2FZdkZiZ252bEh2V2lOVE9YY2kyRjIxWnZYUFVmTTZQVitDT05KVTIy?=
 =?utf-8?B?K1Z1dWNLVE5MRlVKazlpa1ZnMU1HZzgzMjZLR2pGaVlhdEd2dS9Ld1ZyYXdu?=
 =?utf-8?B?M2JzQ2ppaXUvRnZ3TjhnemdXaFRaMkdTeWNZSHpMa2t3bTdhY2wwNUg4TUVC?=
 =?utf-8?B?WjRjQkl5Mm1hdmRCYmRDTHlxNkF2VFlYSzBNTXJFb1pHTVpvV2hxZkVPb21D?=
 =?utf-8?B?QlZnOU5HZWlpVk1mdi9QWlpYaUtQRFNGNnViY1BPZGJyUVhzRzFxdTQzUTBU?=
 =?utf-8?B?WE1xdDJvRWJDcmJCdXh0c0xlblViZEVVWXhEYm1vUUloRElzak5NM1YxS0pq?=
 =?utf-8?B?anFhYmtUd1BZclZORzF3T2pWYW1QbVY0cVNjRXhvMTIxY3N3aUNCaHlzSDVQ?=
 =?utf-8?B?c1J6QnZzZWdRK1RoZnFvdCtWTHdJeWVPS3d1OFBUSVppNVpUeURVNFhpT0lx?=
 =?utf-8?B?MERqd3U2K1c4OXIxakZZN24ybC80L2doT2JJRk1VNlNzbTVWWWNLOW42ODBo?=
 =?utf-8?B?emVsUU04WlNVYTRlTHFwU282VE5yYUJrRWprN01rc0lmU1lEZzdLTW9LbEZI?=
 =?utf-8?B?K0lXYkN3cGQ0Y29wczdqN1pvS3ZwWEhHbjFqMWNGODJQSWZDZkk2alBDWThB?=
 =?utf-8?B?WFNZc1AzVi9BbGxpMmFiNXNMWEdUd0lVV1oxeTJKWTBmSndLMUI0QVdJTmpL?=
 =?utf-8?B?MmttNm9OekRqQlI5STE1YitaUHhRVHBYTkl4YysvblBQWWdQVXlXdldhUlBT?=
 =?utf-8?B?eWlkOERxOTlTcGo5SnIvSENFWER1WENoWmhIQ2dnT0FUYzlzVzZKL0JTNWNP?=
 =?utf-8?B?c0tnY0xnOGI0eklHZ3NpMmoxV2RJNlUzQkVkS3VrL1c5N1BDNkw1cjQzOG9P?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a53255c-fe1f-480f-0c89-08dbbfe3eae0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 05:29:42.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg3/X/+MavObUQWuxykMWSXkTX4HbYiH/CBw0/KfCPSKOXRG/JEMvIwelUo3IV5XNyWF3oikvakZy9VP1NDugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6194

On 27.09.23 20:03, Florian Bezdeka wrote:
> On Wed, 2023-09-27 at 08:15 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As the SUBLEVEL in LINUX_VERSION_CODE is 8-bits only and is clamped at
>> 255, we cannot detect this way that 4.19.291 also gained support for
>> dev_addr_set and eth_hw_addr_set. Upstream does not care about
>> out-of-tree, so work around this limitation by extracting the true
>> SUBLEVEL in prepare-kernel.sh and exporting it via Kconfig.
>>
>> This is expected to remain limited to 4.19, thus is stable/v3.2.x only.
>> And since 5.12, upstream has a KERNEL_VERSION_SUBLEVEL define in the
>> generated version.h.
> 
> I'm not a fan of this solution, but I don't have a better idea ATM.
> 
> There is a strong feeling here that this problem will come back at some
> point in time. We enabled 6.1 support for stable/v3.2.x recently so it
> is not expected that this branch will disappear soon. Let's hope we
> manage to maintain it over time.

For this branch, we now have a solution. I think we won't need it
anymore for master as only 5.10 could be affected there, and it also
still takes a later breaking backport to actually trigger it.
Nevertheless, I will split up this commit into infrastructure and the
actual application to wrapper.h so that it would be easier to
cherry-pick the infrastructure into master/3.3.x if needed in the future.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

