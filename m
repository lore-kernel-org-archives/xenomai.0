Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6916132E
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903387; cv=fail; b=qjRsUl/zSrf3HbKbth32z6BvYoaEcesAARAtgDUfoVc2yDsyZRlsw3RMjYeJPsDM6x9Rymae+rA+Hpa1hksMi0BjZLQhA6WQ4BhU2p1/KcVCBqAd0A/9f9QNPjYzAW8y6XnEV1iNMby5KVZ9k4hI98rQuOEfVGcHjOynwGY656o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903387; c=relaxed/simple;
	bh=QRk/b5CBLrnxTL1LZg8al4bDvs0XqWdbAc8SxuHlV7I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hEDz/f8OBTmV6LHogppwT8rVK/X3cRgZzs5bCaj9GzE67Vd+C+rt1bOKWlNzet/EVY5E0Lb+x+hqctx6V45L9DHXBHox+Gitm801QCtYv2yhJpEHoM1H/Bt7y6Iu31V1HQJOOIx54hoSg1AipwVSUbZRJ5ZuHGEGntVOymy9eQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HEEfKWlv; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HEEfKWlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy1ilrIrIOmC7mHzDPxzYRFP7iIKfL5y1iKOtmcsnal5M5flo/drwByrmLqqTYODpl5z3dM/J7Pi3ZyGREn9DvcrtP/MN2v8GDySsf7HW4uREsrtaLElfm5ECdH4tex6PS2yYMRLhKbt0MUTiju3KTpm/+gJAlqQH7GbjNo4aA8iGpniYOCORn2wOEzm41MstgcuoPTBaOYxqJ6Irud18Nnsd0aSki8AhLVBj/WvoswLdXY+2MRz3ufIKJVKhLh1UIsFqo4xTvta2/AJE5VspH+i2NGSXp53QjtjwVdBh/RoV+G3IO3wwLtsMz8ixE+mqcrxO0+1hf8CxvfdX+nMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lkHecfivsAfsHloYVHKYV50CwzfG5JsiObG8aqxeKg=;
 b=Iey3kD+kU8A3Nr6oaPa4xUPoTV2gh3Vb9f5I1ERLhKxKvdapAJve3ic9HKw/OOrAnySdC4iV+sFzJi72MehajGS8xP4//HzBhBh0GjdFnNDt8i8iBKYleiAvnS7oN/iPvbEnoggCPB1SltCFFUe6+M40IIvQlVbocsj4UjGzbHhVg/1RtZFrB2k71+hQD1BP/IwFOG2am94hkWxXXJqPZ2+pZEjGaqFdtYMNB1YmCnw8+5SUgntsNIMYfoOhe9CfktATywX6p5JhG/Gxjsgk/l95MddkCnl3kIJwWHB89E67ymKUCzYY20/NSSO16ZMtR1cEUeXhXPxPSuhL4OaKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lkHecfivsAfsHloYVHKYV50CwzfG5JsiObG8aqxeKg=;
 b=HEEfKWlvgQQs2tsr+zSWinV06ucW4NhUc8a+G0SDtvxL9RgiV5V1S6SwohWMwSRfAaXdgi+fWxhZK5pihJLcMpBm8k8EnnkyL3CXH1P4rFx+bqFMEOuPHkZcoVRIoJ9MB3y5kYYUqGdhy61MMyhxHIldZc7jl1gUChTdyWXZStlZKWvgRb+RALdbHbCr1fdpZUucAAi7EY9ffkc3ZvIzuqfkHWs0RGccewUfNVIVOAf0u/9erXVU24dOlQaQvR5ioAVhYE/acuSqBOVcFeUFqyoHquF3TaoxWxzTfTT/uUH/0K+X+ekt8GUSjZ+aXR92hlR28IfioC8m3g+x8nSkWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 13:36:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 13:36:19 +0000
Message-ID: <3b4a7ed5-ac29-4897-9606-388106db0dd5@siemens.com>
Date: Tue, 28 May 2024 15:36:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: lorenz@sigma-star.at
References: <20240524083642.19434-1-richard@nod.at>
 <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com>
Content-Language: en-US
In-Reply-To: <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:610:119::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: f2437ac6-f00d-4304-7a48-08dc7f1b27e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1JCbVRKblVmaDBpa25DNkZUbjkraGdPVFBKeGE4Zy9zL2xkZGFIQ3VsSXZw?=
 =?utf-8?B?MXJhZlppZ3hjaTR0a29UMlY1aFlOcnN6NUV2eXRxWDRkR042RnpFUS9TV2xy?=
 =?utf-8?B?aWRKengrQmVYdGRHNEo3b0lrTWM4ZGYzTGI5bU9tbWdqRkxKVVBGVjU1bWlZ?=
 =?utf-8?B?dE56RWtSajVBendNM1NQanhPaTYzRUhRMFhmQVBsT0hKK1Q4eTF2Wlcvdyt1?=
 =?utf-8?B?Q2d3UXZiYXkrWm5UclZpY3RDWis3RTRxbTZNU3RuMExkVjJFZTZSeG9yUStV?=
 =?utf-8?B?TGcyTG04QnlncVBoa2ROWTVtaDcvOFNSOUVFNm5jb0dRSDZMdi94K1J5R2NO?=
 =?utf-8?B?cE5lQzUwR0pBT0Z4U1JEMGpQZzhKeVNYZnNoN2hIUE1aVWdEQlV6YVpFK3hs?=
 =?utf-8?B?TEVyRmZFeGUwNTdoMjhqbVFRZk5jZkhyZ21PdDA0eEZUK3JEYXFaSUVPWjZH?=
 =?utf-8?B?Wno4K08xR042T2doTzRickJ5QWxDb3djek9zZXNqQTF6aFhOY1FNUU11V1I4?=
 =?utf-8?B?bFhrbWdIUXNLTWFrbXdiV3pIL25SRHYxeHZld3JXazExanE0N3J0WjQra21n?=
 =?utf-8?B?dkNqN1IrTTBFNHVyRzlzem1qSHl1eDlEd0tlYlA3UUh6dkFON1pxdVFOK2Nv?=
 =?utf-8?B?Szc3UjA2SC9say9mbGV1OWZDektFK1VvWWQvUmhKelFNMzhMb0pBVTJ6SGs4?=
 =?utf-8?B?cE43VkJjNklFRjBPM0xKQXF6T1k1SGZKTVN5cFZNUzk3YzVXUE8zKzNoUWVv?=
 =?utf-8?B?ZUgyRFkzOVRhQWZDYUJPdjFrdFh4UjNWTU5tYUVsS3daZTBiZGtuV0x4cjBF?=
 =?utf-8?B?QWhuWVZJekk1TzRjTGJWUkZKaVlvdlppb0Q1akk3RXo3U0c1REtoSkR0R2ZR?=
 =?utf-8?B?OUgxdzlScy9lcno4SVIvZnhUTituWWttcFZETk5oZW9KNHJoWHowaTJTQlhk?=
 =?utf-8?B?TFFBTDlXNld3L2xWR1RKRjJKaENNYlFXb05UVTM3cE0zNVZhSUtuVWduSFg2?=
 =?utf-8?B?S01Hb1I4d2p0UHo1RFh0TUh5dTFwbmpWMm5lUnJRWXYzbVhtSjJHVmV5S1M5?=
 =?utf-8?B?ZkNaa0RVd0xpZFg4UVFGWHQwYmh4YUxFLzAvZGdUOHBVVnVJYlh0djRnTllY?=
 =?utf-8?B?cDFneUVSTXQyVUszOHE0dE8wNG5zYnVEeTREbDBoVkJrR2t0RkQ3SDFSRVZS?=
 =?utf-8?B?SDlUNDF3SVpqc1l3bHBwa2NoRkJGK085UHNXcndPSU1udFRCUm9JQ2J0MVBx?=
 =?utf-8?B?SGJmQXBoZ0I2OU1VNjNoeG9oRTkzbWJQY1BmNXp6T0I1WmExajgvekdJVkFm?=
 =?utf-8?B?d2VVMDNkenRDbitxcHBvVTdrZUlWRVZaNjNEVlhDcUhZOHY2Y3Y0R2pyMklL?=
 =?utf-8?B?RE5mUWJlem51T0hzRWJZUmo3T0NwMTNPTmlYeTJ0RFI0Qkc1YU52TWZZc2ZT?=
 =?utf-8?B?WXJFUFA4NndpZ3BxdyswWU1vQ1dlQlRHS1A2c1Z6Znd6dEVXMjUvTkR2bC96?=
 =?utf-8?B?bmRUZEZWajNhcGZzZVM2bUF4TDZscU1yb25uazY1L1ZNM3Ftb3B2Vksxd1hq?=
 =?utf-8?B?a3F6SXQrN2h6VU43MXk1UHN5R042OFgwRTJJVlRnSmI1SjFpUHd3UTVVMlBM?=
 =?utf-8?Q?gxwtATJU4y20jhMA5EqGxBl2mMj4UDntM5IZrRVEBeBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDlHYXIwSm9xU1dDMjlCRmluNDdQK21LNHM0S05OT2F1MVlCamxoeXJWeFZv?=
 =?utf-8?B?TzNYdTFrQjEwRWg4S0lKc3I3OXpleXpyY2xjdFN1MWNxNHhWckU4ZGN2ck5j?=
 =?utf-8?B?THpWRVZmbG1Od21sUzBqYWgwaGR6bXRjaUtab2RuT253bDF5T21qbFRyYWpv?=
 =?utf-8?B?OGhpUHBUZ0w5WlRsRW1Hd0VFVzg5ZndST05DSlNsNnd5UEQ2TDdJRHJ2MTA1?=
 =?utf-8?B?Z2dSMVNJUUdna0lGeHNZcjh6OWNpa3pmU2pYTUx6aVdwZWwxYzdTeGRwQVlY?=
 =?utf-8?B?VkwxSk1zd2VqZ3BZbkcxWkVzS2RPWE9RVDArZFZRS293NW1tK1VBVUYvNjBx?=
 =?utf-8?B?Wi9XaXVKRU1zRDBRSW5qYjJraG8yYis0VDlsUTdKMHBXenh4WW9mVGg3UXJr?=
 =?utf-8?B?K2dmODYxMmxzWDd4VDY1TjFrRzViVEU4MmJ1K3p1YU5WTXNoU3R4WDNqSTJQ?=
 =?utf-8?B?RDdsZkJYOXNhTnlmY0tCOURmWWxKNFdHYWVrTDlKVDUveEVTTXBVcitJaE0w?=
 =?utf-8?B?Q0UxdWxPOEl2TVJDTHJQZnd1MEp2L2R2Ymg2M0JWcDJzY3lQcmJKbis2L2RG?=
 =?utf-8?B?RDd5dVpsLzNRNFV4SHdEeEZSSHpVeFdyL1RPaWdDd0c1a01yK3FVbG9CMUJU?=
 =?utf-8?B?YXIzUE4rakJYbGJueTlWK2xnQTJJTzh3ZTNMU2p4ZDdKWnlnVjdsRjFGZkpa?=
 =?utf-8?B?VUgxUzdsV0FCOEYxTlhaczFoZWpaSWlUOHpFRzhIL1RxZzJwUUVpaGZSWmRW?=
 =?utf-8?B?Nmx2QW9mRVpNUG0wU2xuVE9BMThVS0ZiUWNsTStZMUYzZWtLdGVSeTBHd0Z2?=
 =?utf-8?B?Y0kzL0w2NWxzNUdmTVJqMFdDM3ZsOS9MUndqanZ3Ly9ZYUNackhUZHJ2Y1h4?=
 =?utf-8?B?eExHQ08xV3MyZ2liRDBkM0dVK1NOaGZnT3pneDMrR002ZVRCbWdiUG5lT09w?=
 =?utf-8?B?bHorUkdnYXIraGtrcXVLWGFlQzdBWWhjemw5RjlQTkVwN2JKTGYrb1pKRWNp?=
 =?utf-8?B?NDAyUzdtZHFaUzhzd3pUYWovKzBTaTh4b2NUUkIxbHp5eW5SU0FvQStucm9B?=
 =?utf-8?B?Wmd4dzFZUVV3MUpiU2FEdjltSVNVL1JSWkNpcUROekdRWHJQNXp0NE1kVCtK?=
 =?utf-8?B?azVlZk5JSTZ6YysrNzR4dHl4SWx0WTY5S3pjZ3pQcXBWQ0hxK1BMQzMyb1Np?=
 =?utf-8?B?NmxLUk1tVk5CdTdmNUphK3FKQWxJUzNGc0NDNVhkK0trUUN1V29WSStyaEtU?=
 =?utf-8?B?RzIybDdtaUFoWjRGRS9iWkNBWDc4Nzhoc0lRNFl2QlBocm5XaURNN2Npc1RO?=
 =?utf-8?B?OGh4UmhtWGY0akt4NndJcitqVkdNRkZlMmtBMS85VmxjeXZRbWErTlRZQVo3?=
 =?utf-8?B?RWh2N1ZYNHhQQVRkNUJMazI0TDUzZXkxVE5FV2hEOUdWRkEyZWhDaWNVa25u?=
 =?utf-8?B?NFk0eTBXSnZEc0NEc0ZZQm9LUHNEeTZoYmM4SmU5M1QrdmNGaEd0T2pLMmlC?=
 =?utf-8?B?a1d5N1FZT2doZGFZUkd3dVg2T2hYT0ZiVk91MHlMdjZ3U1RVdnVnYU9Ba2Z5?=
 =?utf-8?B?d3ZXbnhrSDZydHVvVm03L24vOEw5R2NIeVlZMTUrdjFzc2NwcXFMdUJaWlQy?=
 =?utf-8?B?aE45S2VmWmZ5Vzk3OGc1YnUxVTRUSGtGb2hFZmhkUGdWdnRKNGttYkhiekZt?=
 =?utf-8?B?a0svaE5LTDVsTGdab05mZXlqak8vL0NBbmhTY0FtMUY4VXZ4M2Q3cjJiR0pP?=
 =?utf-8?B?Z0RhNlo1OXpHdWt0L3IzWEFmZFlWbU92aWNsMWhLUGlsTUtnOC9ybTR2bWJB?=
 =?utf-8?B?RU1jMzNUY3hTazY4UmROcXd0MXNsbDA2WkZJQTFMcGZzdlQ4c0RWWUVmVFlT?=
 =?utf-8?B?bTdJMWJ0NG5QTFRNdnpoUjhsR01DRGZlWUJQZHRiRzhlMEpWVDJKMnh3Tml4?=
 =?utf-8?B?WHRnZjNBKzltVkJ0UnYwaFhyVkRkRVA4NzI0MzdRVUlSeHRkTGlFU2FqQm9H?=
 =?utf-8?B?cUZMSnF4SEZrQ25Pc1lNWlhjeXJtZk9QS0w1ZHZnNE1lekRNcCt1cmFpRzR1?=
 =?utf-8?B?MTdJVm1Wa2VtUjRJc08xUHNiOGlVN3ZmTlpkRWo5S3NjbXJyUlNTM2pGZTBj?=
 =?utf-8?B?aThiNnlmSlRzb0VhdFVDZmk1RzN0U2x3bm91SEpHWlhSblpuL1RuUzRpb3px?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2437ac6-f00d-4304-7a48-08dc7f1b27e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 13:36:19.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YRr+JkDMspoiQ3GgsmrA1r3U2Ysn1Lx5ZZ3RBuspMa6DjKgXrJTALuXX+MFv1kpe/14oEtKT8l2+ZgU24sZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5784

On 28.05.24 07:24, Jan Kiszka wrote:
> On 24.05.24 10:36, Richard Weinberger wrote:
>> Changes since v1 [0]:
>> - Better names for EINTR capable functions
>> - Remove want_eintr flag and loop around __pthread_mutex_lock()
>> - Correctly integrate mutex-2 test into smokey test framework
>>
>> [0]: https://lore.kernel.org/xenomai/91a15d69-ea68-49a9-8daf-d52ae31f6d49@siemens.com/T/#mf76a46eaa5ec033bacdfc63ca219af3bb84356b3
>>
>> Richard Weinberger (2):
>>   Alchemy: Fix rt_task_unblock() for RT_MUTEX
>>   alchemytests: Add test case for RT_MUTEX and -EINTR
>>
>>  include/cobalt/pthread.h                     |   5 +
>>  lib/alchemy/mutex.c                          |   8 ++
>>  lib/cobalt/mutex.c                           |  44 ++++++--
>>  testsuite/smokey/alchemytests/Makefile.am    |   5 +
>>  testsuite/smokey/alchemytests/alchemytests.c |   1 +
>>  testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
>>  6 files changed, 164 insertions(+), 10 deletions(-)
>>  create mode 100644 testsuite/smokey/alchemytests/mutex-2.c
>>
> 
> Thanks, applied (just not yet pushed - our lab has some hick-up).
> 

Now done - all red:

2024-05-28T11:51:59 FAILURE rt_thread_body:117: pthread_mutex_lock
returned 4 instead of 0 - Interrupted system call

Please have a look.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

