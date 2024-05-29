Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9C1591FC
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002231; cv=fail; b=YnWmHM0pHCVcY71WA2cS5/GK6FW81hVaPrhQOcVYrxgYq+o+BybeLQBJLmFgKneEMM4xODYDEOZwGtlan2BAN+a4Cvmo5/EWx3gn9teMJc09uKC31wRLjfWV70H5p0bBSslr6Hk4a5IEH3/RvPvWboiEjb4Pwfvo5w03ttAR4xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002231; c=relaxed/simple;
	bh=fevO6VPy3orgO1fE9E5BHCJg0WXB77qAp94geC04/+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrbjWOE3iileVMRvRlyUS2ZKFcVxSK2Qc+8OdLZWah4QpGyqFsOfjO52JQWyCP6L2EdB0lBxMS+WJrFvbJBdTrJJkwuGJ3oumT2HrCFGwAT/P/P7FbtW4fJXSpwAlQ/He6Dk+C3c4CM/hA6LI5+KTdmZCjK+SS618lQyzaUu5WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k3ZBput4; arc=fail smtp.client-ip=40.107.7.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k3ZBput4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSxVphZAS5giq1oU/dm8Jm9SFozthsalLcCDWuD1gJibxB/9p+kUslLJv5OhhAvI4/YUpALo3Wuj3h4IYCFL8bDxWMoBRGQv9+RQR4g7vm39+s2+vya+iKQgRB1LqcY0QPk75ZJwVlBlSVpFXrH8mk55s2uf5vogLYIklb4QV6miQFshMVV61xRZau+NmL03KAQV6FZwxxTrOcPAYOvB4jgRFassMV9Pre4ZRhgg/u4D289Z1eGLVJcyNNWV+P7hC57y9N0Jhn/RqCIg2nbHKrC1BeT6KezH2tXbjDChE8b2C3Mci9v2pndjjRH6g+WnrpjWO9bFQhTz++3sWr8tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgnXHEOe4ZzYkWzllyMlY5BOQosXkBL4rEQVGaw2QLI=;
 b=F5q3JA1Qxy5ycO1WPimfUzCJiktiOyoBim6nBWWEV22UlabsOkbw7bFcxYll8Qv44/Xdf2HhAVVlqeWUjf7Zuawy7kouJ9j1TVSJkZl50jJDK2HXJBUXpMf7XtUe4HtbbQZG/wAI5ilzOAVSBBHbBh5vvENWKhzTgWGnzkNM0vOb83EuVZJbbCnVBIjbM4WL5+zN11o+q4/DYFYaeOSI+ZOn4aJLzkJUXXLHkQqZ515AajXv3S7wxyZqNEVr+dGeJLNcr3LfkYK8oRY4Z33cosT1k9af3QqIhhR7CNR3Z18TJ0Izyz/vSGbfChoSJ6R6v53BABA7P8Pw5PKrJBfpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgnXHEOe4ZzYkWzllyMlY5BOQosXkBL4rEQVGaw2QLI=;
 b=k3ZBput40PW7PScjqo6q51s99rRZ/Nsk1iysJ/CumIwF03wWdwsERqNe9saN4L7d9JmQf18PIjTroujQcTrbVYempHhejVmeBhUxiwy84x8OC+aETbNK7JJfDe63UimbfD050fn4Iub+bfl3jekphOm5wzIfuIbipSH5bjQhpUTlHd/K8sdb0DJI3gANuXRXZiWAMQL6/7Kx3RBQ/75CCEgapUbXq4R2P5iWDJbCjnq8Hqn6/18myaf0pQizGTVFQxPWQHHn8VpgZlrwBJcgQ4ZUHXJHfGE8CSC4YBklDCV8os2l30XFD6VgspqXIG+0+ISIpC+2bb1Sp2g+ysq0sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:03:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 17:03:45 +0000
Message-ID: <3331f257-aa7f-4f2d-be03-542cb0be58ac@siemens.com>
Date: Wed, 29 May 2024 19:03:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>, lorenz@sigma-star.at
References: <20240524083642.19434-1-richard@nod.at>
 <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com>
 <3b4a7ed5-ac29-4897-9606-388106db0dd5@siemens.com>
 <1871297586.157252.1716906580685.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <1871297586.157252.1716906580685.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3694:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cbf0f1-cf04-440e-cec9-08dc80014ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clZwVGg0Zm5ENEJ0My9VVngyd25leDZGMkk5dGxPU3M5eXkvRDBwMjBXOEJ4?=
 =?utf-8?B?RktKS0E1dThTNkxySzY2bFR2YUtWOEJQTVA3NHF3Zmx0eENuMk5LcGJxcGJW?=
 =?utf-8?B?S1hVR1MrUFdyRC9EZmpFS1pySmI5djlOL2ZoNmozMmRkSm1tS1JHT0pTL3Ax?=
 =?utf-8?B?cUJwYVVoYzJTZXh5c3UyNDRzVVJpS1BGUk1vYkpyQ1ZFNGpmQ0NQeFdISHB1?=
 =?utf-8?B?OW5UOWdWY1A4Z2FlNlk1ZDV1UWZqb296V091RXFOeWhmM2RTOHk2K2NDQWZw?=
 =?utf-8?B?eGZwWUhaaDdTU1dkUGE0Ui9ydFJmZkpheUoyVXdxdmYycllqZnZ6eUtrSkdj?=
 =?utf-8?B?TkxOVXNzODdPcUVDUkFVMmYwOVZ0NmcvWkxGczRxT0swYlVORVlFOWlMaFYr?=
 =?utf-8?B?K2tSeWxobXB2cmhBeGJ1bm83RDVReCtFNW0zVUdpODB6M3djV0NNZ0U0dXk1?=
 =?utf-8?B?aDM1eVEyKzBwNGl0ZHp0VExzS0QyU2dlOHdhS2dzbmQrSVlKV1lxaHJoeUZE?=
 =?utf-8?B?OXAyUXVlOUN0THczbTF4YzY2cXlFZ3hqbEVqR3ZpMm1qSlBxY0pvK2JaRFNl?=
 =?utf-8?B?NmpYMy9qZEZrZU15dmNRQjRsTWYzNUpUU0kyVG5DUHB4MTJLN2NnUVE2NE9K?=
 =?utf-8?B?R3JDRXJlcDAwMTQydDF1UlFkekJad1VnTW8rZ2piU0NreXpjaFFYM3VjTk1B?=
 =?utf-8?B?cm5WVlJjWTJ1Ui9tUTJKaE9XSmRBWjRMd2lhN01UTjRHcmdTZ1F1blFIS3Nz?=
 =?utf-8?B?cTcyS0JRdkg2NXJkQTZoR2Z1dEZnUnFsM01RRnhpbjJjQ2Fpa2tvbCtYOTNN?=
 =?utf-8?B?NCtjSzd5VFlMYXhiSmt4bVM1cEpqOGUyOGJHQlU3K0crZ210bVVhdzZXSVhD?=
 =?utf-8?B?SjYvT013aDJIY2plZ1BEdUh2MnhDVjN4aUllRjNKVTJxanVjR0dKVWNCRngr?=
 =?utf-8?B?VE9QN1VaZnNBWGJXdW0yS0dNcFNjVU9Ia2c0T2NNdG9XS3dHVDBUUFlLdDFl?=
 =?utf-8?B?ZUIwOWxOUFhQR1FCdG55OXYwUWdjano3Rnh5RnV0cW1uY1Z2NElzTHNpanZ1?=
 =?utf-8?B?ckppT1NxYlUwZ2plSVhDWkRBZlgvZlV0dHVqc3I3eVg1L2lwbmE5QWJzcHZY?=
 =?utf-8?B?R211OHI0bnJ6UnFUcDNuVWExQndZcTRnQllqZFZ0R1kxYjJFMXNuSkN0NDhQ?=
 =?utf-8?B?UlNJeEROWVNxdnhQcGR3UFJ6V04xODNBNFZzekNJenRRakRDVnIzc09rb1l0?=
 =?utf-8?B?RnNlclFMUXFCRTVCNzJuRXorelNGSjF2dTZKT2h6cDZxSFlLTlAxeEljcDJu?=
 =?utf-8?B?MmdMekZHV2lpVWdRelpiR3NtRWhIL09LSGUrVzYyZGlkOVA5a1NzSXd6SHJY?=
 =?utf-8?B?emE0eE5nWjBOUmhxVkdrdVZ0YkZyMmdNeGVZKy9pYzFRQU1Nc2dSaS9JTGRp?=
 =?utf-8?B?bHFieGZiZ0RoN2toWktKZmU2WHBoSExJaGtocTlaSk0ySDRpenRyVkJiSUlY?=
 =?utf-8?B?bHRCR1hWY3RuSVZOQkRZTjdvdGR3WXpnd3VhWTJGY2JQcTh0dEZJZy9FZ05R?=
 =?utf-8?B?ZGtuK0F0b0FlTTZEbGdVRDVQSTB0UUFvL1BFZHdZOVpJODQzSi9mSThwc1A5?=
 =?utf-8?B?dWhsZ2l0QzhVOUNpaXZpVWxSVFZmT3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3U1RVE4OU9VTlZTcFhMMnhVQmNNdHFYRHhtamZxUU0rLzhWdTQxcFJHQ2VW?=
 =?utf-8?B?bmN1OFczM0l4Y3B2d0o0Rk9hRTFoNGVxampQclR2YTYxS3MvZGhWYU0yWTlx?=
 =?utf-8?B?Qk4rUVpDbW9kSG05SDV0Q2xod3dwRnA5V1huamNPQ2UvQkVIRE5jeEVKcXp1?=
 =?utf-8?B?aTRaMWtRanp4WGpabk9qUGthd3A0M1VlYUpmai9Ob0hjOXJFdEVHS1hwd3Ja?=
 =?utf-8?B?bWtTcFcxd3B2Z3dIMDEzU0ZhOThRNDBJUldCamlZNVFEelZVUmN6U2dNNkJG?=
 =?utf-8?B?M0pmcUpGVVRvekJ3V1lBNWJmUG9hY08rdzArb0RVZ3VMMGcvMUM5NWtXYkJY?=
 =?utf-8?B?dE1yeDJ2T0pvUWc0SzRTTWJkMjd4L1FnWUZyODJWdGZPL0pzUXFBZGJnY29H?=
 =?utf-8?B?QXloQTVrMldvTG00L2NETmMxa0JxSGtiNC9FL24vQzllaktlMEJSeDJheXNv?=
 =?utf-8?B?Z3Y4ZW0rR3kvcUdHYVpVY3BvNTRZRlpHSitnTTlicllFY2E0a2VscXkzRFZN?=
 =?utf-8?B?bGpLR3lURlg1b3BkSG5oOEpvNTZhUGNNMFBJdEdDcnNQMSt5UFd2dDc0cDhQ?=
 =?utf-8?B?T3ZtdWpTbitDOFJzMXlPVGczMmZUQisrZ1VOeERxYlhDK09KSVp3b1VmSG1O?=
 =?utf-8?B?ZGNqc3FzYzl0TWNMUU90OXlvc2tiZ0dHNmlHY0xGY2NEK2JwN3hNV25sSTh2?=
 =?utf-8?B?b0o1a3NWS0dzbXhMVWpESU12QU9WMys4RmppQ1N6SGxrSkpEV2diWUJzYkUz?=
 =?utf-8?B?T3NueTdKdmlTazVZQm1Td3pOdzh3dVhKMlI1ckNLUmlZaCtuT053ZGRYNXZH?=
 =?utf-8?B?aHhwTzd5T2U0Sk92YjhxOW9VaDdjbDZoVEZHaHZEVDUxNEVmUy9TVlM4M0U4?=
 =?utf-8?B?eEZPTERSK2FsdUVnOWpxZXFWNkw4czBUa0tHUkFKSjNEd1Z3eGltSitqd21t?=
 =?utf-8?B?UTBmTG5NTmo1MGRFUmczZ1VIM28wNnBvZHg3YkFDTGNXZVgyRHhDYUJ4ay8w?=
 =?utf-8?B?Q3p3U1VmTmFhbmE5WmpCQnBnckwwVmdFTFkzMmdXdmx1aEtwREJnYWt1OVpw?=
 =?utf-8?B?VklsSlVsU1YzT1FsbTVGQnd3WVZhZ3Jpakg4dFdsZWxxa0s0TGltUnpHYU1D?=
 =?utf-8?B?N1UzVVgzcG84T2xKOFBHd3IwWWt1c0lVNlQzNnh0WGZMYlhBN2ZtMkNvNGhW?=
 =?utf-8?B?NlY2YTBnYzY1a3RDVVNQVGMxbitEWGxmWllUdDdaYURIMS9lUGM3c2lrMThy?=
 =?utf-8?B?R0RLUjJNdmFIRVBNSGNES0R1MkwxbmVNNVh3T3pta0NMdVJWcWY2WTBQWERt?=
 =?utf-8?B?V2FuaUhhUnV1SDdwYWp0T3lOaythYUJFNFp3ZFlrM0xIaTFJd2ZUM29oQ0Ew?=
 =?utf-8?B?WXNBSjA3YXRTZ1JUenVZV3BIUkVJKzhCWHpScFBpeVBrVnZVd21BaWlTOHJw?=
 =?utf-8?B?ZVdaVE9qL1ZQNkh6M0szWGRxVmRQOElta3RDZjJJZkw3bGRzaWJTYjlwZGpa?=
 =?utf-8?B?K3c0L294a0ZsU0MrTUZJM1JXYlNFT0hYYnpKc3orZnhoV0VQUnZ2NDQ0N0tT?=
 =?utf-8?B?NEFGaHYzWWVqaTl6OUYrZ0dEMFQwQnZMSk94bWRUV1hCWlFlcGdPWGg2dzZT?=
 =?utf-8?B?TzFRLytvMmVaTi9xV0d4L1ZCODJkVlFGanRYNVBZMm9NZHpROHFDRmRWck1M?=
 =?utf-8?B?d05ZWEVhSkFLbEFFV2ZzZ3I4Q04rUDFyM3llVzJZa1NZYmFlTkErNzZFZmJk?=
 =?utf-8?B?WDBRMTdZTGxydjdKaUMyVjU1THAxZWhkZ0NjQSt1NGZWdXMyUk9nRGs0WUVl?=
 =?utf-8?B?TFNaTDNHWU9KdWhMR1gwM3IvWk9BSnhoVlBDbzRYM1dWVU9KOHllRGJxYWxZ?=
 =?utf-8?B?QWVHWUVmdlRCSXRmMkY1OCswWXFrZHpUQnZNOE5BeDVuVEgyejFsLzN1M0NU?=
 =?utf-8?B?ZG5KQk10RkJtK0tPRzVrd1c4N2M2TUJIelh0UXFNbUJqK29GTEJNMFFIL2V1?=
 =?utf-8?B?NFZwajl5WFFqZGJ4LyszYzZ6Zjd1clg2SnVtTko1Wkl0Z3hQUDN3alpjMzkw?=
 =?utf-8?B?L2JlWkxBVktZOHVvRno0azB3ZXIzOVBQNUVBNmM3cmw1TXRHbzcyclZVRHRp?=
 =?utf-8?Q?rZsVlo0P3vIaXlBvrzRcBJiaa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cbf0f1-cf04-440e-cec9-08dc80014ca6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:03:45.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLts/w5cqjKhXbQfLkqLfw2M//4Aql3jvI6Sp6KtAI9Ob8+zVwEiFIs9faVENW0x+KNVfncEtY4Zn6d9InOGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3694

On 28.05.24 16:29, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>
>> CC: lorenz@sigma-star.at
>> Gesendet: Dienstag, 28. Mai 2024 15:36:14
>> Betreff: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
> 
>> On 28.05.24 07:24, Jan Kiszka wrote:
>>> On 24.05.24 10:36, Richard Weinberger wrote:
>>>> Changes since v1 [0]:
>>>> - Better names for EINTR capable functions
>>>> - Remove want_eintr flag and loop around __pthread_mutex_lock()
>>>> - Correctly integrate mutex-2 test into smokey test framework
>>>>
>>>> [0]:
>>>> https://lore.kernel.org/xenomai/91a15d69-ea68-49a9-8daf-d52ae31f6d49@siemens.com/T/#mf76a46eaa5ec033bacdfc63ca219af3bb84356b3
>>>>
>>>> Richard Weinberger (2):
>>>>   Alchemy: Fix rt_task_unblock() for RT_MUTEX
>>>>   alchemytests: Add test case for RT_MUTEX and -EINTR
>>>>
>>>>  include/cobalt/pthread.h                     |   5 +
>>>>  lib/alchemy/mutex.c                          |   8 ++
>>>>  lib/cobalt/mutex.c                           |  44 ++++++--
>>>>  testsuite/smokey/alchemytests/Makefile.am    |   5 +
>>>>  testsuite/smokey/alchemytests/alchemytests.c |   1 +
>>>>  testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
>>>>  6 files changed, 164 insertions(+), 10 deletions(-)
>>>>  create mode 100644 testsuite/smokey/alchemytests/mutex-2.c
>>>>
>>>
>>> Thanks, applied (just not yet pushed - our lab has some hick-up).
>>>
>>
>> Now done - all red:
> 
> *grrr* sorry for that.
>  
>> 2024-05-28T11:51:59 FAILURE rt_thread_body:117: pthread_mutex_lock
>> returned 4 instead of 0 - Interrupted system call
> 
> I'm pretty sure the problem is:
> 
> ... while (ret == -EINTR);
> 
> Should be ret == EINTR because -ret is returned.
> 

Seems that was it, fixed up now in next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

