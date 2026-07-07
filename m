Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35A3D8900
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423279; cv=fail; b=jjwJAQEJoR1n8V0cfc7HnaXT8iIS6o509LI9s4pm0RQfyCCcwMbsIxv2uezkXMKASPGLF5RMYXFWP9HO9rlkUQiLYAgPSXp18VTkumgmgaS9qo2gcGuHnWEa21OHdNRGLZrVZGWlhosHoNSWFoXRaiGhnGR3a1FaDY2JGc9s++U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423279; c=relaxed/simple;
	bh=RDSawTs2BUK9ePUaFbixj4H5/5NMObdtvOxejUKXb2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0awdHo/ovUr9s4GCnUjlefVW0wdOs9frwW1bkfa97uR6gmCKTaLqd/ZxoFhwuZ/P1ofkvYlYCQX8G/gDTXH1LKbT2fbEhIzPzBRb9KWQ6dEX0swC8Lv1zz3mcj/vjU3oecRkyy8NiwCaSS51yHfkLwJF+Bde/x/E/q81QeDJI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DzszzqW8; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DzszzqW8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwG5ZFno767HDR6h9nm1QLOoKc4Ix8Juby1/UWOTZpFrRimCcboPiLtEMs63FzAwUiG5RRSDHZSV170f+FZolTfFgxuKzmV7Wmf7RTE6qO2ZbkrpdwPozmauj8Dz5JmQiXlNkk1GUUiKV4qw1+5FAnqrtxiDqkGU1/zSj93HVm1IzB+O2GxWIlNL6knQCqqFlvWY97Awn4WRMMyaZi9ftn7bEylQ1oVymNt3OLn+XFjDv7DvZ8TvIYxLnJI02GtwGztEbxQ18RYW/9nS0rA93EvSlTHqIeMmzO1DuVp88Toei7FjOsuXSnBi95rQuyzbUXyTXEcGxsq/DumDbic/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36Y/zOcJZS2lofhXYZ1QKmDsIVPzoq9te6fr0/aZj/o=;
 b=jDxaQeMBj4NYnKqNRaDQ0HnUVZ9RI8Ry+WioS6k4u7taSBOdM4P1AWwyjczrUNP5Trjj55OB84MF3bj5fo1BPBycUmy3tDLWrCXlAnMLb7v73aNuoeIf2ORwqiSSAXg5BukKh9xv/gZ2eGgehDng1uH0CMTWk+UhEIjT1/vET4EuIdHEmtdA6TiwUSTNTTdtlqpwZZ1GJQe2OYNBF8l9kFDM5LnbKe7BOGXDOtMW1EmkJqoT0AE8DqmiR0djRpg1MsCARAMV/zYwKtQk/7jn08+o1nlK6D9Oo3jAlmYiQDoFYL5LYqY6Bz+ZDc6ArlZUsXfAX+jKdDx/Z0jW+9Q0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36Y/zOcJZS2lofhXYZ1QKmDsIVPzoq9te6fr0/aZj/o=;
 b=DzszzqW8UPKB0BzIveIKXX461lIoyvi+y8F+4G8BXNpWLSsZ3A7tSqvaj+R1AwkgkBYQzUZGypf4ekREu1otnq3lu2kAPZAc534wWsTwPVUhWMlw6P7flYuUtwpBQGJDOlta/e1HhFpMFCreKUtCYyxGJGoXVcx98ZdWcXKPMdCZygabACILc8IYQAzWqF9GXTau8a7Prkop0eX8ZGCZ85VVVEq3d91vhKrapEBbPMALPFf1u60vdFlQOgECdjQ1FlS5Ealu9qJXC8VX/g36uUHMKXl4ptMJNFDe7j2RiMefYItBQAPd25uEnNJ1ieRJrvgbaclcUB+M3dJntyed9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 11:21:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 11:21:12 +0000
Message-ID: <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
Date: Tue, 7 Jul 2026 13:21:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
 <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
 <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3264:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d8d4ca-f265-4d00-5eb3-08dedc19d9fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|18002099003|11063799006|22082099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PK762etldyRMcmlxdewmVxR/6fkcJ1mmyG3Om3OAXO21R1ZVD9FtaUt0Bzyg/lkMWljNF0vx6vnl2lK66gSnwQbp3pvT3IkLaEsyeQIGwwPPNqJ3V4l5jUnMrlwgJp30xULUukh8StiDi9nxrGD/Axrw+gYs1UfdHxLOiB/Gq3Haj0frsDql4FhrHOWdctaaZavNAaQDaqEA9OyznY0eQwk9pnObud7zP5Uw49JfQ3pMSKD5/NEHBy0pOQ1iMLCkuaxTWtsvv3vKVNK2JzaEXnqBdSFVJoGSDrGdLC47EoehjBkRa2jjLNJGpgh+MaH1ee5kZNQAyptgDOM6Il/deRFXh/QYjsraVZIWeXf4prSsHCHj0b7f70AHBbHm9CRkPyjqx1PeBqfBmY/ewcKBaBepgX1ulsSNQhNM7+xS6uH44EjMhiWJFmt46W9dpiWOz4k60gX0BBN60D9BFmpo47J52THFDF0AxOK4PdmmZ/cwjY9q65GnC8O0zFzyrhg/lJz2AuJITJE5KEyL/gNppZaxztg6zUdkOKcZYjR/YWS8Ep6lZ4PJlPol/uXHXUjulKuZ4EQSfb4US66Et4J/YrOKGx2GquOdik2MtbkN5PQ984LzOOS8G/qm2Ury+9fqs94PstMD3Y7GjOkYQNyn/H0m8EJWdGst/9P4B+sbqJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(18002099003)(11063799006)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3o0TWdqQ1hQR0UzK21SUGVoNi8zMDBtYisxL1JqR2JxZm04ODZiTm1abktj?=
 =?utf-8?B?SlZobHcrWGRrSGpEQ0w1Yk43eS94TGdabEdXa2ZxdVBrTDFMVjV4SXdsRHUr?=
 =?utf-8?B?NGcxc0lWbXdQcVZyUkFKYVFaNC9NbjE3RHp3MEtpS21BaVo2THJwTTRybW5M?=
 =?utf-8?B?R2J6S2Q2UFRONUhUZ2kraXNTcGZNQ0U2dVNhcU5VUzg0b21pQjhPT3ZST0ZK?=
 =?utf-8?B?QjdFdVVlbVlsdUJsQ0FYaE03TFppQXpwR2EvWllUbGszcXNENXY2K2Vpc1BJ?=
 =?utf-8?B?Q2I4RjlFdnVQQVhaZWs1alJjRUFLSjU1K1J1dG1pZ2RkbElJVkNxZHZPSGlo?=
 =?utf-8?B?UUYrVElILzFiWFNlakJieVNyMDlhWTh2NTNna3ZyNEdyaDRqNThuenNmUzU5?=
 =?utf-8?B?MHhucDVtR1ZVUXZRVE1SanlqS0MydDg2OEdJWGM2YldwRXlCYzBVNjhON1or?=
 =?utf-8?B?bDBJcGJXV21TTitmWWhKZW16cHE3MzVWMmtYdFhPRkNZeFV1OVFwYmtpaFdw?=
 =?utf-8?B?NUFGanJRWlBsVkNQMitlTFNmenUzTzJkazFPMWlTS3RQbXpxL2swSTJ0ZzlF?=
 =?utf-8?B?SENoTFgyMGI1NElQd1oyTjZRMHpWaXdWWWVTRmo1T0FCSnlGSmFVdTBaU3Zz?=
 =?utf-8?B?NW14ZWV6amRvQjhEa3FSNHgzbEIvWjRzTFRpRXZWbVlSM1FiK3dlOG84Szlk?=
 =?utf-8?B?MHI0R2t5SitsZWlFVW85VHlSSkZsc0lFV0JHOHphUkZrZUVIQTRWSUI3WGEz?=
 =?utf-8?B?aXlma0ZleStUd09aZDBQblRnaTJUR3Vrd2VKSHFDSVpUc3hjdEdaR0k5eVVm?=
 =?utf-8?B?bmhpWlVYSjJKcWIwNTg0em1RNytaRS9PajZ1eGV0a05xRnp5RjhDQmhQRzZN?=
 =?utf-8?B?S3NBdDVkYURYZFFVbzdBVVF2UTFsZ1pnbU0ydi9UTmwybUJHcXE0dlhnZUF2?=
 =?utf-8?B?dXc2RTN1VEZoYzM4MTFjT2lHcFBkdDFKOVdKQjRNMXczeXYzb2xQcEZYbTM5?=
 =?utf-8?B?WlB5c3hqTmRGemIzdGo0MmNtaTJ5N2FiVmgxTmJoMlRzRFlqOGJqMDViaFJm?=
 =?utf-8?B?RXhDM2ZPbU5aL2ZyVlBkeHgwWWhRdlFGNnU3dVJBT1NUNzcrVjhhN0xhT243?=
 =?utf-8?B?ZExnSXhUQnZxMDRuQnRSUWZDczlhWmVBMEZJV2RiWjJJMkllSmhZVkdUWHpG?=
 =?utf-8?B?MHpZbkJOTHNHOWxRUHhzODNmdlc3NlRNQi9BZm1aZ3k2bFZKNDBOK3BWM3VZ?=
 =?utf-8?B?R0JKVDlsM1NEczN3RnY2OGtLbHYyNFR6MmNocG1pTlRiNFp4WlJHK2tBUEdH?=
 =?utf-8?B?bERFQTBiNDhaYUFncURQQlVpMmtiN0NMakFveVpkRDQvWjN3NDl0eVhNVS8z?=
 =?utf-8?B?bFFmZFZlRzZIMmFhKzZMTjk4SlhSdkdVZndPelphN0RVdTh3bnZ1R0lKOWJj?=
 =?utf-8?B?SFlMUjZtcy9WRWZwTDhDZGtDRW9Vd0NqYnNuYWRmTUVJVHhRUXI5REhkd1VR?=
 =?utf-8?B?Yjg5UjgwWUNhTU9zcG9KTkRUR2JSME0rT1ZPVld4VndKSEVZYkRFRlhBaVBy?=
 =?utf-8?B?Sm1yYUliMVVpdEZtSEQyeVRtd1I0akhJR2ZBOGpsRFZWbzgyTURDYkp2ZWVR?=
 =?utf-8?B?QzFzV1gzZEdUcHFNc3k3Q1RjS21zYXVxK3dhSXVxb1VRUkk4TmF4WG8wTkdp?=
 =?utf-8?B?QzIwTlorRnFlbG5SZ2d2MWN4akkxVVFGN25aT044YmhsYW5KdllhSHd5eExU?=
 =?utf-8?B?c0h0ekV3bGVXbHBlNENFMnQydGpPbTJGdjlKNk51eHNwQWZOYjRYS2JvZEdN?=
 =?utf-8?B?OFBLakNBa0E2TWlkT0cyT1lOR2JOSklwU1hCL0dyTExRMldnR3RLZUZvR3py?=
 =?utf-8?B?QmxoLzIvOHpEL3BBck0vU3VnVjVwWnhHaDVxZXlVM1FGdDJSTjlJbW03NE91?=
 =?utf-8?B?MURzUVpvRTZNQ0dTWmsreUZqaXFSNEZ1MURVOU9TU2JvNGZVKzdUWmkveFNN?=
 =?utf-8?B?WERBL0JaTUtQeFJ6RTdzVUhSdHhVdkVLV0M1d25TRFdaUVBJR2RYMDByL3Zs?=
 =?utf-8?B?TTBVV2JuM2JhU1U0RXZsQVZrcVFGQ1QwaDZUQ2NPdHlvMmh1MnFWNCtCUHJD?=
 =?utf-8?B?ZElGN0dCUEo5WHZYanVVRFkydUhEemx1WStvbXFNQUxiN3YxajR2cUZLb2Vo?=
 =?utf-8?B?a1NwN0NLRzl1NitpaWtUMTdyb29mWTNvMTRuMzQwZ2xiY09lam8vZHBhMkI5?=
 =?utf-8?B?S0crMCttV09Ibkc1VUxidkM4Z0ZuMGZXQzJBR1BHUzRWYnRSSmp0d3l5Qno0?=
 =?utf-8?B?QUxNeHpzRit1UWROM3BYaHVrbHBmNGpMa2xWd3BReUI0SUR6ME5YZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d8d4ca-f265-4d00-5eb3-08dedc19d9fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:21:12.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBWra6cnXwycj/HXLU5/iHlWH0ThE67CHd6xJ/J/1xkMDG+f930zMtkrzCxhe17fVdS/+iPvc5fYvbooxrWMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3264

On 03.07.26 16:00, Tobias Schaffner wrote:
> 
> 
> On 7/3/26 14:07, Jan Kiszka wrote:
>> On 03.07.26 13:54, Tobias Schaffner wrote:
>>> Hi all,
>>>
>>> in some of my test runs the sched-tp-overrun test was failing with:
>>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>>> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
>>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>>
>>> I only see this on virtual targets.
>>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/
>>> jobs/393605372
>>> Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.
>>>
>>
>> Maybe improper/missing synchronization during test startup? Or when is
>> this hit?
> 
> 
> Does not look like a synchronization problem to me.
> The key part of the test failure is this combination:
> 
> /*
> * Trigger an overrun condition by staying busy for longer
> * than the duration of our allotted time window.
> */
> for (;;) {
>     evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>     if (timespec_sub_ns(&now, &start) > OVERRUN_TIME)
>         break;
> }
> 
> /*
> * Now check whether we received the overrun event as
> * expected. Since non-blocking input is enabled, a lack of
> * notification would amount to an error (EAGAIN).
> */
> __Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));
> 
> 
> The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
> or in some cases or at least the message was not send in time.
> 
> I suspected the issue to be time stealing but saw the fixup parts of the
> tp scheduler trying to handle missed time frames. I think we just have
> to increase the overrun time but not sure how much to still keep the
> fixup parts tested. I guess these code paths are only exercised on
> virtual targets.
> 

So, do you want to drop tp-overrun from this patch for now, or how to
proceed?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
