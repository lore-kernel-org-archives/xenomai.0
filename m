Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB93BBF1
	for <xenomai@lists.linux.dev>; Sun,  1 Sep 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184203; cv=fail; b=Ty+jsSeVJEbZUj7Brhu0yayjqDj08ExzzSh8pqdb96KXcQAp50MlSVJccI9p3zyMUsb0zZIYj2heU35lX5j+zbWuuyK4lcLRSPC2Gy+IY/dkv8WJKvBeXcfvcVXFoMp2tMxMwUXoUuyEzo6xLRcub7ZUiMRPpSxopljbUhluxMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184203; c=relaxed/simple;
	bh=vMLhNWNVJNL60zmwTfzB/yrDH4/ioIajQDeTJOUqLHk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfaUEGmxZdDWYPpi5DBO39Sd6WGOocElg/TaQ5FWM7y2OZWrx1c0EvUWiRUhp7ZK1Tr4JBEWiaH8D5FyWJOkXX2zM77Z4uzdLjeobO4SNOzAOh2IiuCegFylQSGQRmGYFJN91lIXyKkjdoZ7e1aGeD7ooDiYf/UTjszn982sQN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=URfzkO/s; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="URfzkO/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZSnNv4k9E3W4puTH3d6WonOSx4IL6FR1nGW3kk0luoOBnYTHyl936CrBqaU/0F1tYB2IWbAGbXVC8GfczZ+L6ZB0dxmEjsvu8D1vP77s4ZJ12clcbMIFFcVlzHEGPJ/m65eFY0PUgmy+RDSt+dvE4ofGSZE7g8C7emChWXrsRyM+wIyRYKG7ll2ylAJSOO2UfWDmxeU2N8dr+eAMHWH2lnyBJlZ3kKa2qYojO78ZyrRbWPpF0cbXMkDUR5w2uqXobm7L/Oid/j/oq4LuQYot7Y71fwjV/kbmB6OYJAWIwPjIwE1d6/Bhr28dxEUstaeYAqFVldV+wz17NryqevXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VInPlWWgOZEjvSyOZLKUxM9iRqh31jbWWkSCJ9PJJLk=;
 b=p+hCkIvX310Hphzb8FMyyll6QmA98fwR6/9aA+x5nYBl0jCtjjaydVICByeMeqoW6mEc7ksUia6NOmlZHt4Kp5Y4vQMaoTttzsgPD5HTXie8IxmtyJNBBk7rt171BYqjBW8VgNhHoIvDTm0pJrUvhO5ApRxP4iKVbFmYt1ZVgPLifCPQeKMfBtwwhmkmn2bgD8wFPTkDgQuGmBgOlfU5iSYTY67YSLjjvvueeO1JirjZL978GdUIn5pZGcgXf917xGMqJQYR58Yi7BrMxaQnctdBX/zOfvkZr4ydWk/8/jz1Vv36ShwdsUYyS54+m4vZDfCT7eGeHfCZSxwUFQVzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VInPlWWgOZEjvSyOZLKUxM9iRqh31jbWWkSCJ9PJJLk=;
 b=URfzkO/skOo77lRUiqCiMifQ2DC+bmiN3atj9zzZ4bxFw0vdVj8/C3MmEILjJqhDbKf4imRiMalDXCFLSWRqaBPMPRE01IiQNyubY0BHx96T7syeNLOiruxilKa2tazQo4XasbG9T6yXlSW+KFgIbADffayXTHCoqdnwkYHdkytS4hJg9vmoTJdrau+4XH7AC7b1dJ2SakXYqDsut24YVbBTJSje6C47q7f+NDqN6cUgLyfbRew2OZc/4mD/LqxBr5bbhsMWib23WCx1iNtN6F497VYjjH6N8yBySARtCl/P/4tWfHl/+TebZEdZ+h/3kIUhd6ex5aui2PYLirohHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV1PR10MB6244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:49:57 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:49:57 +0000
Message-ID: <7e199e8b-3d17-4885-81a4-6297863fa2b0@siemens.com>
Date: Sun, 1 Sep 2024 11:49:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
 <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
 <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV1PR10MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c875c1-b8f9-40b6-96ca-08dcca6b704c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjdlNjZiNFhoVnBxN3pTbkxSS2pzRlc1aU5QVGtSLzZYempEWVhFeElWY3Jm?=
 =?utf-8?B?VzgrczVSVmdoc0NJVWcrVmFnVzlFT3JoZE9WTmY3ZG9vSXBjT0NNSmw4QnRa?=
 =?utf-8?B?SU9ackQwa1puM2JIVEcwY0E2VWp1d3JuZTU5MXphOW84d0RGbWpmWThYai96?=
 =?utf-8?B?dDVNbmxXQ2tKRk40aitIdnpUZGFiL2xDWnE2ODRSOGhBWEgzZjR1SmtzQVJB?=
 =?utf-8?B?bERiR1FKZEl6MnBnTGh6WEZaVmU3S1pQamtJVEp4bTkvbG9STDZoL2tUVm5j?=
 =?utf-8?B?MDJhZVh3TGVqek8ya1oxYjRPcCt0OFltdTdPZVlkak1GelJveVIvQjRjMW9v?=
 =?utf-8?B?dWUxNG1KOXljQ013VEdFTTcwTjRaM0tncEhxZTdoWVZxVkdFOUFmcjJHODJW?=
 =?utf-8?B?ek93U3hVL0Y1dGZ6RmxYbVF4eCtVRXpFZ0x2SGdyUkZGVmJWVGVuei9YSWZ0?=
 =?utf-8?B?Y1RxNmNIblNnUjFLbUpnUFlkRTNNcXFZcWY3TzdqZXFjbHdPZ3FNajUxUHhv?=
 =?utf-8?B?bUwrU0lzd1BZVG9ZUlc3SVNFbUxOUHN6Vkdoelo5NjBHdnVCSS81TENzUm1X?=
 =?utf-8?B?SXlDUFFzQSt6OVNRK1pVU0l3R3dyQmUrNTBKVUlaS0RsR3MrNllCc3pBaWJG?=
 =?utf-8?B?YmhyTjFXZThEVU8rUXNpR1c1c0RJdm1NVjgxaXRzOEVsb2tEWDhnMy9VV01E?=
 =?utf-8?B?VE1ZQ3ZJdFFvSW9ZUnZqcm5iaVdJOEVKT2RITVdLVzc1Zkk0cmUwRW43K25V?=
 =?utf-8?B?eU9rdzlaU2xjeDNJYkxSczFDaVNJaC9vK3F3L1ZGL0VPK1N2aTZFVWpvYWJq?=
 =?utf-8?B?UE91ODdCZTRpOHMrUjhqM3E5Z1ZlV2NyK1QyN0NTdVE1cGQxRHNzRDZpMXJB?=
 =?utf-8?B?ZnY0Wjdnb0dRMGhoYksxNTNTSWZ6VlZKbGpINW95OWl2RWNhbG9rcUJveElx?=
 =?utf-8?B?MjBpS05WZlNBZkkxTjdXUFgyeGg4VVFoczlpQm9yTXdnWEJYcjM0TkZjQWhR?=
 =?utf-8?B?REUySlhvZGp3a3YwT3JYdXA3Q01PWUtkZDgxQW5uWE9QeWlYajd2OUVWQS9W?=
 =?utf-8?B?M1NGZkxTeS9ZM0NWajFHcW54T2QxUkpNVUE3c3pYcEtYTmRwZ2FQZllSdHZD?=
 =?utf-8?B?TGVIWkhEYktRd0pxVEtpcXVqQmkycHYyZ0J0d2ZxblFieDMxTlFVSzY2MVBR?=
 =?utf-8?B?VDNqUm43Um9DdThEaDF4T0VTa2w3dENEYjZWUDYzMHR1V2lXOUVRVGxocmFq?=
 =?utf-8?B?SkdsbXNUb3ljWUpNK2s2L1had3RKRW9hRnEyeVY5b2k1RHF4L0xtVmFOZmpS?=
 =?utf-8?B?amhVeHNFdGdlZ2JuWk9jcHdhTC9SM2VUUk9hSzhTK29GS050UnUxOTNvb2RP?=
 =?utf-8?B?a3ZoUlV1aEN5VkplT1FqM3hsUUZzdTNhTXNpVlZrR1JmdWdDeVgzR0Z2UG9z?=
 =?utf-8?B?TzBqbXFUbkZKSVk0U1J0TVV6WVVFaVk4SkhHQSt6dFhiV2RFSVNhbkdLME13?=
 =?utf-8?B?SWhJQzhKSzlJSWU2V0JqTkxGczZYVGV5TFhQMHMzSndGSzEvT0ZqSEFvTUVn?=
 =?utf-8?B?QnFVY1NYeTk5OHRWZnN2bW5IcWZBSGN5L3B5STFNYVFRaDJ1d3R2NHdCNFh1?=
 =?utf-8?B?REFLdk1ad1ZCY2V4aXh6L3lDN0hOb3IrRnpZMUM3NnBzQTEreHVlOUhiaCtt?=
 =?utf-8?B?NC9ObnNZQlp0R3lHQmJvL1pLTEN2bDhObVRjSHlTTlA4cVFOSTNaVkJxWkxC?=
 =?utf-8?Q?Z/C6IIJ1GjxZhj6TQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVMzT2hucDV5Tm5XbnNscXJTWkU4amloUHAyN1FNUUNLMHhDS0h1NkJKR2Ex?=
 =?utf-8?B?bnFqa3lUOHpwUVhrcThYR2gzTkl4cjR5K0hLR040Y2FnVDR1N21MOGI1SzdJ?=
 =?utf-8?B?MVo5c3JDempRQ3dmcE80L0E2bEFPOHhReVJadWN0bDJrSUtQNncxVVZoUDRm?=
 =?utf-8?B?THIxcVZnL2cwMnFxL3RuMFNGbDRGdXNtSStET3dWM3VvSlVsZFZtdzdYUTlB?=
 =?utf-8?B?aC9zMjhyZmVDK293TVdmbG9WSkREanFvVERHU1VHUXM4N0ZHWGdyQVJzeDNZ?=
 =?utf-8?B?S0xpZ3hNTGttVHkyRmVnVURkRzZnSHRrYk9ZMXNMSWt6Sm04L1dVL3gvWGNT?=
 =?utf-8?B?TXpUQm5pWEtYcG5NMDhtU0lkblhqVDgwbVZPK2d4K2hCdHZpUVVEdEx5RU80?=
 =?utf-8?B?cVh5WXp6OGk4Q0ZjeHNXd1B3OFZpcjExYi9rMHg0eHcwa3MvUlU2T3NFaGFl?=
 =?utf-8?B?bXUrM2xBTHYxM2p6TGNlUm85ZmI5K3Q1ekt5WTVpMnR0N3BNbU16ajV3SFVm?=
 =?utf-8?B?OWVtNFlVenNRZnhRWDJBdmhMQ1BoYm4rYmsvY0M2dFF1Q0ttY2N4TWhyNndG?=
 =?utf-8?B?TTl6dlM4dkNZZjAwcnNjSUhCQjBQWkRheDA3d0pISjNpNC9tbHFqaGtKQVNj?=
 =?utf-8?B?REdBS2Q3YUFRVVNSa2pabW50YzhzZ29ua2puVHFLZko5NCtGeUxYdGthS3VS?=
 =?utf-8?B?VGVmWTBIVVhMeHBhV3NqejJveG1Gcm1uWlFMK1dDdk1qREc3aDFtelFVTmY2?=
 =?utf-8?B?VnZLcnJYNHVrcWRuSE8rMGxQQTlhRElZcFBpdFBvUGFXWWkwT3Nqekx2NGlR?=
 =?utf-8?B?MWN1amhMRlk2WlpmUG5hMUZmdTE0NlY4cVkxL0pSd3QwZXp1eUl4OUQ3VDZV?=
 =?utf-8?B?Rk1KRE5lRGFlMHNlNVloTU1DSy9sUzFVOU5LUzNlbTJrQzNCNXRJQytLQXVi?=
 =?utf-8?B?MGZyTkFYOVc0MlNLcmprMENWckYyUXZYQ3pTMUhKcStCMkJTL0xicEovSXg1?=
 =?utf-8?B?UlhGK2JJM1Racmt6TFFwdjNZakhDazIzK2cxQmhZMXpCSmRHMGVLakl0dE54?=
 =?utf-8?B?YmJFbGZIdGs5ZGY5WHZnemROd2E0R0tWTnpKejZOM1hJZGdjOVI5eFB1cllu?=
 =?utf-8?B?V2FtZW5SeUlqdjlnZW9xVjllemxJenF5dFg4dktYcWw1VE9LVGRHMnFCQlVV?=
 =?utf-8?B?Rno0aDhrbGdHeWpPaHNPWjUwdXMrQ0txcmpacnEzSWFaSUNLZW5zRTRyNURr?=
 =?utf-8?B?STVtUFRKdXBmb3RQSU5pNXJrMFpDNzZtZENyQzZtb1dybXhsZGpBZ3FPVkN3?=
 =?utf-8?B?OFFUYm1KZ281L1dZUWxTTTB5anBuTGVhRHpxL0RSZXR0aWQ4ZUQvZmJyME1K?=
 =?utf-8?B?anBJV2FQSUtJM2ZqNUNVZ0U3cTBQTDdCMlQ4WnBLL0l1MXFIMTFaVlN4ek52?=
 =?utf-8?B?T0RZQXJhc1ZIdjE4ZWI2cXQ4YU5LSm9namJzb2NUUHRRclFnUjAzbk1rRUxw?=
 =?utf-8?B?MUZrQ2g3b1BSQnVIU1VDbVZIWG9ralVsWGxiYzJKaUREVjJ0b2J5dzM1cjQ5?=
 =?utf-8?B?ZmhVblFFdjVua2wxazI2T1RKZ2xISXNJS00xZWFNWi9OVmdzSi9zdzh0Sndx?=
 =?utf-8?B?ZTR1RXBNZlJCYlpVMGtRc21BN3F5NXhId1NyRzdORWZzcWthMnVRMXRwenho?=
 =?utf-8?B?bWRkMXJ6a1R0eWNwRE5lTTZ5b2VxM2w0Nm5FdG55cm90dFI0WTZLdzVMRWJM?=
 =?utf-8?B?dmxrbUpnU1d1VCt4U1drUmZNUGdXUEk3dTFYckZwcTdRVjNsYjNyOTBvVDg0?=
 =?utf-8?B?YzRSMkZCQm1ZbkQrSDdaWHA5MjM2Yk9BRkxWQVZsbUVVdS92am0vbjlPbkpC?=
 =?utf-8?B?YWJwSzFqVDV0RGV6TzBOSDRGSldVU3lEQWlkczY2QURWQ1JDZXArZ0xsUzV4?=
 =?utf-8?B?WE1yd09RRmVUNzZpaG9VeVRKanNvdnF4azRUQXNySXpwR2c4TzhkaGpIbytx?=
 =?utf-8?B?N2o3MWhoMlVUQm9uSmVHMVBieXZvb1hoeFIwSmZhdEN3SW1HMmwwZmZOMUJj?=
 =?utf-8?B?RXdiMjNCNVVRM2NPNG5ubUltNDJ0UjlJTXRoc3RsQnBpTVlQemdvSEdiM01U?=
 =?utf-8?B?UHkvYkhYTTBpVFRjSTQ3bHhvNUd0T05pR3ZrcUNNRlVhVWRYaWtDSm5aQnkw?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c875c1-b8f9-40b6-96ca-08dcca6b704c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 09:49:57.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEwmeohjLYzFYvDUktjVyqZVLzOslly1nUSSZDX8pzwZQGxNh4CDpS2tjyidV40x4c6f7+q/2SuxDTVL+TAGOo2gqVdyl68M4B4WDoxzhBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6244



On 30.08.24 15:44, Jan Kiszka wrote:
> On 07.08.24 23:52, Jan Kiszka wrote:
>> On 23.07.24 16:08, Tobias Schaffner wrote:
>>> Enable isar sstate caching to an aws s3 bucket by using the
>>> SSTATE_MIRRORS environment variable.
>>>
>>> The isar-sstate script is used to upload, analyze and clean the remote
>>> sstate cache on every build.
>>>
>>> Cached artifacts will be cleaned every 14 days. This can be overwritten
>>> by setting SSTATE_MAX_AGE.
>>>
>>> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
>>> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
>>> download caching.
>>>
>>> Currently the size of the cache is ~20G in size but I expect this to
>>> rise to a multiple as soon as this is used in productive environment.
>>> Keep an eye on the output of isar-sstate info.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>>>   opt-ci.yml            |  4 ++++
>>>   2 files changed, 44 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>> index 1dc05a8..f5009e3 100644
>>> --- a/ci/gitlab-ci-base.yml
>>> +++ b/ci/gitlab-ci-base.yml
>>> @@ -24,12 +24,39 @@ variables:
>>>     TEST_RUNTIME_SECONDS: 300
>>>     TEST_MAXIMUM_LATENCY: 0
>>>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>>> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>>> +  SSTATE_MAX_AGE: 14d
>>>   
>>>   default:
>>>     image: ghcr.io/siemens/kas/kas-isar:4.4
>>>   
>>> +.sstate-prepare:
>>> +  script:
>>> +    - kas checkout kas.yml
>>> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>> +
>>> +.sstate-analyze:
>>> +  script:
>>> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
>>> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
>>> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>>> +          --sources-dir "${CI_PROJECT_DIR}"
>>> +          --build-dir   "${CI_PROJECT_DIR}/build"
>>> +          --pedantic
>>> +          --exit-code 0
>>> +
>>> +.sstate-upload:
>>> +  script:
>>> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
>>> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>> +
>>>   .common-config:
>>> -  before_script:
>>> +  script:
>>>       - if [ -n "$ALT_DNS_SERVER" ]; then
>>>             sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>>>         fi
>>> @@ -40,17 +67,22 @@ default:
>>>         fi
>>>   
>>>   .build:
>>> -  extends: .common-config
>>>     stage: build
>>> +  before_script:
>>> +    - !reference [.common-config, script]
>>> +    - !reference [.sstate-prepare, script]
>>>     script:
>>>       - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>>>       - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>>> -    - du -sh build/downloads/deb build/downloads/git build/downloads
>>> +    - du -ah -d1 build/downloads
>>>       - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>>> +  after_script:
>>> +    - !reference [.sstate-analyze, script]
>>> +    - !reference [.sstate-upload, script]
>>>     cache:
>>> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>> -    paths:
>>> -      - build/downloads
>>> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>> +      paths:
>>> +        - build/downloads
>>
>> Strictly spoken, this chance is not needed because we only have a single
>> cache entry. Anyway.
>>
>>>   
>>>   .build-qemu:
>>>     extends: .build
>>> @@ -59,8 +91,9 @@ default:
>>>       - if: '$ALL_QEMU_JOBS == "true"'
>>>   
>>>   .test:
>>> -  extends: .common-config
>>>     stage: test
>>> +  before_script:
>>> +    - !reference [.common-config, script]
>>>     script:
>>>       - scripts/install-lavacli.sh
>>>       - scripts/run-lava-tests.sh ${TARGET}
>>> diff --git a/opt-ci.yml b/opt-ci.yml
>>> index 01d5c07..e1466a0 100644
>>> --- a/opt-ci.yml
>>> +++ b/opt-ci.yml
>>> @@ -23,3 +23,7 @@ local_conf_header:
>>>       IMAGE_INSTALL:remove = "sshd-regen-keys"
>>>       IMAGE_INSTALL:remove = "expand-on-first-boot"
>>>       IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>>> +
>>> +env:
>>> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>>> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
>>
>> Thanks, applied. Let's see how it will behave.
>>
>> Jan
>>
> 
> Only saw now:
> 
> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_ACCESS_KEY_ID=[MASKED]' detected, please migrate to templates
> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_SECRET_ACCESS_KEY=[MASKED]' detected, please migrate to templates
> 
> (e.g. https://source.denx.de/Xenomai/xenomai-images/-/jobs/894592)
> 
> Is that an isar issue (but we are not that old), or are we rather doing
> something wrong here with the export?

We could evaluate the environment aws variables in Kas and use them to 
create an aws credential file to fix this. Maybe also because bitbake 
prints environment variables when running verbose.

I already proposed a patch for this some time ago on the kas mailing 
list. But it would need some rework and I am not sure if this is 
relevant enough to forward more sensible environment information by 
default. Whats your opinion on this?

Best,
Tobias

> Jan
> 
