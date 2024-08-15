Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769A17C984
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729002; cv=fail; b=tlJBfeyer4SuiO5Nds8X3iNPywIjFx8CW6dj0HRxClG6GGMG1PHKkHOVzQzj1vCwllAXwPxsal0xaSK5sFr4p/iCD7xwJA8IUQZS3mIFdOm6D+IcQivU1tzJGRxWXb+m1AFUhnMXBpm2An8Wsd+4ccuq2vN5biR2YFvDQcNtMLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729002; c=relaxed/simple;
	bh=1UDscstWwQmtPlDsWsCb4JCj38UhA5E61x+HyBeX0mE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gNym3gRm2YOugm8OhTIBX5rpidWWJEzYk/GU/AePAjclh4Wq4FLRMA0jf0R9z6gz6fEnVfLPBZqh6esDEAeisB8Miv8+F9JDmDAw/ft/ULJVWfkP29w2MBwgQ11LA1+dbn5og+KyGrDdJpQIC4uxtDHBzjl+TnZ4YRbGPTcHIjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=onsXSI4t; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="onsXSI4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AekhV22k/bXDSX1P8+DXlVRA684T+pWX+7ijpzK/WN1yVN5ysw2EfHig0QpUxzTa77qEx5eVHYW5grmtlUcpOZ1TdhnLYR18uqh/Q7rQjo+lwHmP9qfJxhGkOU2w+dTHknBkMgdTR2072unPh6ZwssGT1Uq4XBZhrnzai6t0MwcQHeEdtutiMyrzEYrE7ebLTGseBtw6YpgN/JXL8JzyK7zZ9JByV5+wbGrFaqmuIHfx5bW08YeEF9j7noGkyuZxUOPOsPUrvJY6Sp8HyhOi57MF/UgMYZp9dClOKf53yZ8x7xPHFSScGYqpNDNeh5prHcH7QITXVZ1tepRkQyOtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxYomk2b+9pDJLAwWefZO2Vt7T1gtpQqbQacaymm7v4=;
 b=vJIMO8RPieGxbLfZMnd8Y1Mg3nLwV54OXQyhdnnZpFK6DyPcMkDRzzXJfbMqXk6avWiuKQ5ssRNJKq9/u+3y8ag/1Nn++pJX73kYAG8C/LSSwkhdA4NaWS092Kb73ST1tPzYr6Z83OkHYQiJ2EBR+4tJwtiLQP06+32aCzBz63a5jWBg1Uy3SyyR+gPls+AaA8HDG6xHX+59XBGhb6p49LhIsRQgN4mCP6gug7AzF6ZV707fiOd3Mq94j+LuPGfkP5J18wr+pgIjxU6O5QRsHsxL2ENuWTcpXmv7Jzq+qJg2GKgoM2JBjab55zc7x5IhEPgJ40JP0CkR1ErQ2tjhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxYomk2b+9pDJLAwWefZO2Vt7T1gtpQqbQacaymm7v4=;
 b=onsXSI4tXLtiqHuQuuhbSnF79zi1qC5eHFmyD7bd18J57bS4TELBijymOPISR32vz9pNgcNx+Nn7vHplvhEcoMIKxGKCRcbY/z0tvYJhpjkeoaryk1hmXM8QyEJTZCqWfyxRBkOZzbIO/2/XJQJTzVyooBVpW1ljbd/qBHAs3BclnFg1KFlXDoW5yaMWEj0UmatXlgrpRWGideHygsGZ7ZA/zObyntYSiHyrNGjt8nC0nKisE1MK/6RnUuPvLDyJinI57prG+D3FPp6KqeHE7dF6A9dfhy+z7kGnNOzZM3+6xPvvYxjfDTSlJ3j033cDANVg2PScAc3BUF6EpWrewA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 13:36:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 13:36:30 +0000
Message-ID: <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
Date: Thu, 15 Aug 2024 15:36:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Vienna in September
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
 <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6379315f-0f0b-4f26-86f3-08dcbd2f452f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhqeXRsWDNVVWs3U1JoeWM2dEtHZjQ2T3Q0d0ZIdkZWV0hBeFZkVmFPQXA5?=
 =?utf-8?B?SW1zQmRPRyszSGk0anhQdGs2b2pWbTF1OWdJWlRzTHhaN0lUZDRBS0h5YytZ?=
 =?utf-8?B?czZ0TWZwYnNSNmUwZFNXR1NmQldJTlROWTVVQlUzV0hvYTBuWjdranFHSGpL?=
 =?utf-8?B?aEhzUmcrSEtZWHZVYUVsTSs5NnZWdnRzMlJZdGtmODBpM0E5Y1RheHNaQmlW?=
 =?utf-8?B?RXVXOGU4WE5tUVRxSEtQckxKVWtoUkxkTW90MEsvejFVbEhVQjI5QWFnSnNT?=
 =?utf-8?B?OStKNkVTVnRMa25BbmJNZkl2NlRtRHJ1WWJrME1lZHR3Qk1HLzBzM2piL2Nl?=
 =?utf-8?B?YnlKWm9jaGZSU3l3RlJ5bzNyVjNIa3dKL0ZDSU1EZUhLZ01XL1JsRjRnR3lC?=
 =?utf-8?B?RHBMb0dPVHV6aENEUEpIUjVnRXdlR2c2UWJsbnlGRXlvajFDOHJQS3N5azdD?=
 =?utf-8?B?VUNqS3VrbjB5aDhMSW15R01LbVY4WCtxekxzS0k4L3E0TDFmanc3Z1duYnRC?=
 =?utf-8?B?ZzZKR0FraU9LU2dCUEorNDRnYVRBeS8zNC81OUNDQlY5SDU3M3E2NDNIUzV6?=
 =?utf-8?B?NnUzMko5V1ljUlJxZlZyUzlqRngrMG1qUWRRemRUNjZlMmJQbXBuOFZwRmlR?=
 =?utf-8?B?MlBtRUJYb2VGZDhVRDBKOFdhTmJOKy8wM0pNalU3L1c4bHlBclFzQnRZREJD?=
 =?utf-8?B?Wlh3QWlkL1k2ZWRKWDlWREJEZjB0MkxkdVdpZ2lGYmNHd0s4RjVqcjhYdVRp?=
 =?utf-8?B?cStFbzdPYWhQaWRwT1BMN1d4ekVacVJsZi9EVEtpbnU4Y1RXT0czd05TKyt4?=
 =?utf-8?B?NFNMeWRTR0JJU3pEdlUyVDY0aVdyRlVKYW9Ub3U4WitrV1FUZ2Jab1RldDdL?=
 =?utf-8?B?RFZTNGFSWGxuN014eSt1UnhCcXhvK2JyeDF3U3VsOXd3a1FGbEJrU2lpR0V3?=
 =?utf-8?B?VE5JckNnTWpMdDdRY3VmYVBGNkJtZ2Z0TXRaTmpiV0Jwb0xFRitEaElYcSts?=
 =?utf-8?B?YXNjbkcvdGZYYS9JZk54ZXVtTzUybGx4eVFLZE5xbjgxSURwc0hWWFk2RnhT?=
 =?utf-8?B?OUlISERYbFBVK0wzUFVXRitYUjVHSTZQekVGdzJhZll0SnJhbnU4QTNVOUcz?=
 =?utf-8?B?S2Q1dWxUaDJEKzN1eU00dkN5aldtK1JHNUZVNWdCWXlWZW4zM3FwRzRWODht?=
 =?utf-8?B?cnZsYnBxTmR2NWhWT0ZOZGd2NGJUcVE2bzdxOE9mOGNVOHZRYkxUdE9FNUc2?=
 =?utf-8?B?WjZ6Z2R4TlFqS25GUzBrdEIxd0ovU000M3ZEdDVHdWZnWDNWaVMyM0lsUGd1?=
 =?utf-8?B?SDdCWmF5eEVjZUNGR05WZW4wRi9NTUxzQVhxQk5QZVAza1VKbEw5akRDK2Rv?=
 =?utf-8?B?VnR4OW9OVFJiSHdCZEExeXBFM0JPRDJEOUUxcXFBN1dTM05MUVE0bUx5VlM3?=
 =?utf-8?B?cGRJdGxSbEZnMk1PTGFjSkM1dlZ5TEF3TTUwRGJra2tHQTh5bW5SYUhrWTE4?=
 =?utf-8?B?aGtaOGpuRGlUc2tYdTZpV05tenQxUytEMVRkUGR6bzFIcjVHcmp5K2JSNU1V?=
 =?utf-8?B?V1libWhCcHNXbjJuOXNCR1FWUjNKeVBZR1FjYkJSTjEwNUo0ZWZUNkZkWVp1?=
 =?utf-8?B?ZnlXWHRKeklWMGh6bWlQeHFycTRXQUUvbFJ0VGZhcmo2eTkyNG5xeTE2VFp4?=
 =?utf-8?B?NXd6VnNGa2xIbXZINkd6eXpMazhEOHFOQU5PdC9YZCsrOUFTNHhmMFJ2ZEpt?=
 =?utf-8?B?MTNDcjNrOTZXZDdEcjFzV200RVZCcVZxeVNwd2hkL2dZOFRId1poYXhMcWJ6?=
 =?utf-8?B?QjQxdytDT2VuYklpZ0RtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDRwSWFrNCtYK0kzd1dQSldFZ0NUYSswdVpoVkM1dEpiek1nUnJ2MEI1NTE3?=
 =?utf-8?B?eUdTQzlIamhjeTIzN3ZHOXFnOTJRa09YWE9iV2lDd2s4YkdXcS9MSmJqaHpO?=
 =?utf-8?B?UDR3Z0dHR2MrWlh1SkhBUzFPNmd2aEZibEZaSFhQVlhQYjFkSEROVUgxVDI5?=
 =?utf-8?B?SDZ1WE1VUklVTUw1anJlR25EQWlWd0pzZmxPdjh5RGcvRDVXUk84U29PNFgw?=
 =?utf-8?B?R09qd1ptLzJkK0FLM0RiUTFiU1RmdFoxSGRsNnVFNk9JRDJDOXhRVzQvTUpi?=
 =?utf-8?B?YStMZGFIUkZYWFVvZlRKcUQ4QTQ5bXVXTzBISjI4UnhDNTVMbWpDYkRpclZI?=
 =?utf-8?B?Y0JjQjhZUTVsY0Z5YkNnaVZyY0V6M2pOcTI2RVQrcHBuMkZJY3B2MWc0eUJK?=
 =?utf-8?B?M3RVY2JkWkNsY1QyMzcwN3NXMFFhRElRTDRGQ2FCSFNsN0VuNTlEYXl2OG9v?=
 =?utf-8?B?UURiUmRGMWIxZlBkeW9hN0xlaUFRYWxvTXBoeUFQZ0o0bEdWT1E5QkRHZURE?=
 =?utf-8?B?NEk2NmFxTUQzTE0zKzg3OG1SdDc1RmR6aTZXdlMrL2RCK1U1czZHcm0xdlA2?=
 =?utf-8?B?cTIrVTBFNzJMRE4yNDdQeXNxMEx2ZG1tNjRSdlZkeWovWExqWVQ3aWJvRTNw?=
 =?utf-8?B?Snp3cUxET3hsK09aVlpWTjQrMExwTzJPSUZ4UVV5akdPKzJEZk1WYnk4bDdp?=
 =?utf-8?B?SUxReTlhMVhLVkN1cXdaWGI1QWNEbEczMHRUR3VOak8yMmI3QytYSUY3MDVC?=
 =?utf-8?B?bEl1R1RjZzhvbk1ORkg1QjdvZjE5aHNSdVhZc2c3YlJxV0E3YlJ5a1RRMHNO?=
 =?utf-8?B?UGZubU8wUE5CT2hDSSs5dmxWSmpseUJqZ2VPdEhERXNsNU9jYkNXVGZOZDRO?=
 =?utf-8?B?bVFueWlRbHpROXJtRWNCa09XeDFVTDFGY0docnRxeHZwMFNsckJUUi9IM0lX?=
 =?utf-8?B?VFkySjFvU3kwR0VYNTFudFZNVzA0dGtxMnpvL2s0QXB6U2NBY3JTMUVlMnVz?=
 =?utf-8?B?eTFoL25vSW1YTUR5V0JUd1BPYUc5VWVmNjMzTVV4bGYrNVR2NlJQa1k2TDNU?=
 =?utf-8?B?ZEtYZzdNbCtSSmo0RUFEVHNYUU96eGt1KzR4aG9CbitZWGMrd25TWnZuZ3VG?=
 =?utf-8?B?RS82RjROR2VWNk9ScldUOGZWckpMa0VBWVI3b3JTSk5id3BvZEl0NHBJYktD?=
 =?utf-8?B?d3BucDRTZkN1RzZjNTVjYURrVXQ3L3FrQ3ovQ01POTA0WlUwU1NlMGVDRGth?=
 =?utf-8?B?VmlWc25MaDkxUmM4dUMxT3NZZjlRR0w3dHNKalU4dXF4eTlBMDlmSGRoUFk1?=
 =?utf-8?B?Y0dhZkFlckxqZDArVkF4MWNGMmNMZHFzL3dmZ1AvVm4rZTUrWjJQLzhIRzBi?=
 =?utf-8?B?TUd2SmdzWnpBSExsazRZV3B0WEFnRjdtUk5JMHNSMzRxckJpMThZRW9ubDNq?=
 =?utf-8?B?T0xKSzZQNnlLdzl4d2NwME5LY05KeVlCb3hJMlVXcFFqY01xUTdadmMySy81?=
 =?utf-8?B?bzlzZlFjLzV1UE95cGVWTG9zaU0zamVTOFdQNlhmN3dqVlJ5SXBRMVFjMVdK?=
 =?utf-8?B?TkN0NCtnMFhKQi9FaXdPaEpTWUdrY0NFTHlwMjNhVkcxMzBXWWlINWtncllG?=
 =?utf-8?B?Z3dUWkI4N053UHIrZldya0RrQkttUWYrWk9DaDJkaXpRUFpZK1pWWjNPMjZh?=
 =?utf-8?B?bUk2WitYN3Erc0EreVNhV1JMbDNFWFlWUjZ3cTFOd0RYOFNQNW5ubFdLYjIw?=
 =?utf-8?B?YkpqR1ZkMkdWK0E5NzVsbWM2WUlpY3Q4M3JmOE56SjNhaENmaFNZeG1iVEpn?=
 =?utf-8?B?Zis3MUVnUWRXb01vb2ovZEVBTkVDWFhqNmtKRUJsdHRLS29idzFvTGlYVzJy?=
 =?utf-8?B?WjBGZEZpZzFNYUk3WDVSejR4eGZ4SHJ5Y2Jia2FwdTFtNW1BQTdVZ1ZZSmMz?=
 =?utf-8?B?bUxiaVdvcG5QV1hWR3MzMml0VUJBYWZwRXVTV3I0SzNDRHBESzVaZ1hsUWZV?=
 =?utf-8?B?ajhrVVBURHBLeGxTajFHVHhxZTN2N1JrMWZuVEtuQm1BYkcwempEdUNZa3d2?=
 =?utf-8?B?OW1UcTV4ZmlhOXdMMHdvaDZUb0k4YXEvVHBjeEx3SVR1SFNEMUd5WFFaVFpK?=
 =?utf-8?Q?QOZmUrH1lYjjZxrIYZsR/O0R/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6379315f-0f0b-4f26-86f3-08dcbd2f452f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 13:36:30.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+1ZUMw9jr0VAZF1W7v8ty2LNvsciH0dRy/mDEmBqpgoQrrZPQpGeLwEGbD7XEdtZTZsEMQ6AhM9fBugreYx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9005

On 15.08.24 12:08, Florian Bezdeka wrote:
> Hi Richard,
> 
> On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
>> I expect that some members of the Xenomai community will be attending
>> the upcoming Open Source Summit in Vienna. If there's enough interest,
>> we could arrange an in-person community meeting at a local beer
>> garden?
> 
> Nice idea! I will be there and yes, there is interest to meet.
> 
> I can already tell that Jan and me can not join on Thursday of the
> conference week, 19th of September. Every other day should work on my
> end (- can't speak for Jan though).
> 

Hehe, just realized that I have a double-appointment on that Thursday
now (RT and CIP). Definitely no space for Xenomai.

Wednesday might be an option.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

