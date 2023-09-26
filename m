Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A845682
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 07:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP+RumKc28mGu4hVu412pns+lnqni/TGVzNQu/bfCW9RE3Ki8nb3MdHOlR9GwwDZAWUG7sukUDZ9DUBLH6jeQmeDxOcIg36zK7ijGPrnaX1+tk9JcxoU0W4UrDYw/TUwl3/g7LBA3de7/0iuydVhygKvH+BvSrLOSFvnXYK25qKq8zA3IRFMydcan5gRhFVoIQBCP2s2BkOfcHFbxIhN084qQ0lk0mZTAJLty3pHbLFUSbbdoZNjwDFPBDxbHWAIILYhf4X7DEX0o9PqbJJsv7H8zN+PQBzW+RfzKB4KrTRPgMuvjxeYxARLTqSb7yxQa9kd8zTGkmWaCVinPnazFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvZyjmRXJklQsG7CFDsfD6bo5puBQpUUKp61ZC8nbLU=;
 b=Vb0cnyePwsc76weSHUno/cV6MnuZeiKDGNxnErXi/q2vHVKmwRi7WX/ySEoAnAfLgwKht3TCfdv/U72pueIXuAvlEAQGz0oxMdu4gT/j95AkPDZXl7UY3GdQXUi+1cN4aLaw3vH+pm/v6d/L+uE7hwXOuQL0UVrnSyLGQ4bnpfkd+M0T8Y8vtePBAhXLpP1yGDoXQ3oeojgplU1Nar40Ssra14DdS+r61BaU/Ol1sfzMsWK4GkxkjQfWCDfPFE0BH000c/cRL972LdBEvRIjpAh315j1lxC0JkDiUuOKQEata8+sfunfyjYXqPuHJ8YQ+AZV7uIeuvVhJ2EBvY2xVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvZyjmRXJklQsG7CFDsfD6bo5puBQpUUKp61ZC8nbLU=;
 b=LrtbB5O4lKfRNFfUzyPxDeCOYJ6mzwRHf0uIBOl0affQfhniBcTDix2pKxObZkrzs6IeuObArLuDfxOQ1sGkhJnhESkkQKuOrjqyBTpxWa/kQNmgDwGpcZK90bZ1dPUGDZgclz63AxY1NAWmwAI4IQeFPZrv1j1XZvnBw4GO9X4i2K8p0HQuWOM4EzvjwBx92yq6463x//PJ/Jnf/gU5WaGSQBTsWhdLR6ernRS5IOw8XLWz9KH9trVI/Rv9Y+iZIv1xbknQfpUWmXNcD72u5sou2wmFj+Bs8SLOa/TS5rmDFYet4QNHVPicyyt4zr2I0onenRZVOixuPDs6ztEERA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 07:07:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 07:07:37 +0000
Message-ID: <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
Date: Tue, 26 Sep 2023 09:07:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 9805efb3-9ccd-4f61-c1c7-08dbbe5f438d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4dVWBe/FdQb+jdKbpyFG29muPIJxUTk3Kb9eRwXgR8pZ6cyfzr0jWNczrfId1+dHaf2+D5X4TXAG1ht4r8Ou5JGMfMPGdVdHw77hoVUWV/Hs0v7Tn1BrH6GkeDdCF+/DbZG2873pjHmqMUuEJNMP/J6FxqdBZa/YUFzdjp0V+2WJ/Es74tlyjZ81C++STT2SLq8cu06aOLD32/DiI+c62sS1BRqqLimathEQd+L78/ZVR6dx+pplWyanUBdAtr247HP1igAp/zbzJ7SVni7mOKVQPmaVDWkx/W1IyOk2Yscw1jxeHlypdgovEHfEh/peSEycPL/NT2JmWWnbmS2Wk1hpqot/HsjM5+PJbkj0NGBXVADYUfF4MK/shrqZE6tXrap/dlJFYMuiAY7ee/h3vhFcYe0B66EuwVs056+fOmvLcvRT9UMtb/h36PED9krDiqD7w6QHCFiPuGAgwra+kw+CADA3i1EIPMCAfPZ9aJJL2cG7Xu9RRkiGgdyO1O3rCPQxo1RLeh5Yy7phsRXrTQG28N90nYSGV13TsLuI2HPSfKp7GchuYqGh/FBHajkg8TsFwQDxNLooWvCJ2MuF3jiPCzjQUskbin5Xihcr8h6wkFSV1J7a0ju99TRx2B+skXrJC30YjfqWOtDObNql6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(84040400005)(230922051799003)(186009)(1800799009)(451199024)(2906002)(31686004)(44832011)(41300700001)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(110136005)(966005)(478600001)(6666004)(6486002)(6512007)(53546011)(6506007)(26005)(2616005)(316002)(83380400001)(36756003)(31696002)(86362001)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yzh6K3dlNVNvOU45Mk5ybjN4UGhpMnZHWStPNFJuZFJMUFNnMjZodmk1TWxM?=
 =?utf-8?B?bkNpWDUyclYwUmNoKzY1NXZITzdENVBOa2Zpb2o5a0xmaU9mbEFKdjdrTnFt?=
 =?utf-8?B?cUNQbUpGSTFpbUtjOEkzQ3E5V0tMUFRUMVczS0ZSbWVXTkpRSEpKZkZwMEJ2?=
 =?utf-8?B?WU5ybndMd2E0ckpmYnRiZTJJOFlMVjZSWWh1RThKVENtTFN2TDF4NjZ5ZGpu?=
 =?utf-8?B?cTkvNTZ3dEZIVlEzaklFcEs3MXpSV08zdHVjU1M3VWVLZGxNMm9CbGFTQm1w?=
 =?utf-8?B?M21PZTZWNVhtRnhqVjNaSjlnQmRKb0MxY3lHSVZGOE1NOVJBWU9ONWN0MHpp?=
 =?utf-8?B?Zkh3NHViLzNwZGlTSHptb1hhK2wzc3d0SnJoS3VpZDlNWTJSdHpweXNLb0da?=
 =?utf-8?B?MEJHZ05URS9oeTduT3FDZ3BzRFdVV0gxbVpqZ1gzWHRBS1B4NHdZQkdCUWZw?=
 =?utf-8?B?SnJJQVZ2KzlsL1R3K2FpUU53UThHcTJMaFNOQkRkaWNsbzdKaHk0STRjWm5w?=
 =?utf-8?B?ZHRPQkJNM0YrR21DdDJ3SzQxNy9pVnJKMjAwTzdRWmpSb2FzSWJGWXVNSzFW?=
 =?utf-8?B?cmYxb3FENW5Kbk5IMkphUFNHc2Uyd09KcmVFWjRuOTV3THBERFhPaFFZSGFS?=
 =?utf-8?B?eGFFSzhOaHpvZjAxREdUTllaMkhWT3JqS21mY1JwaVk0am1MaFo2VWhpY0p5?=
 =?utf-8?B?TGVoanJiajEvM1A1RlVQYVRkR1lPdEVhTXRLTGxoVFFpcTd1NG4wbEVXQUFj?=
 =?utf-8?B?Vk8vekZXSVQ5Y2pFbjd5ZTZxcURtMFBVWUpaU0JlTWxPVFA2R04rM1l6UnQr?=
 =?utf-8?B?bTU5T3I4d0tRNGl1T20rTEJyRUl1b2dXNDJ1dGhjQll0cVNsMUdBQVhyNk1N?=
 =?utf-8?B?NUFhK2JSMDdtZ0xSRVZMNlYrR2NhbXF1bFhJekpTQ3VvbzVmVXZSVjlFNEtz?=
 =?utf-8?B?aG50RXlBVW5xYUpiUUx1K2lEYUgvNkZxSUNHQ3BCbDZuSkQrdDFsSG1JRE5S?=
 =?utf-8?B?b2lzTGxFVmx2QXpIWDJGcHBMQ2tLWDlXOSszOGFXSDlxNTlTR0RKVG5VU1BF?=
 =?utf-8?B?NzY5MDJxcXZGVHhwUkdoa2QyNzdPa2JjNm8xWXNNWEFiTEUxLzg1MWZYNHhp?=
 =?utf-8?B?cytENXBXRmFXUVZRUHNkVjUvWHNHQkJsS1JxTVR5NGQ1L2RBSWJQNmpJaWcv?=
 =?utf-8?B?UUc2clFSZ1c3bHdBYmVwbFoxTmM2bUhPWCtXQkt0UHRLaWNwaXZHaHg4Y05l?=
 =?utf-8?B?VE8rU0M1SGhQLzFiT1MvYXJCZ2c0N2VySzBtWkZXZ2tVY0o2WHBoMWRtYlYy?=
 =?utf-8?B?S0FmWDdMbmRoL3dGRWxBaXF5SGo5Q2IyUXVCM091eXA3NkhvaHlXYmRTL2Rv?=
 =?utf-8?B?bmNPVWxTUDNhVmpOYUdZd3dPMjRyVnh6ak5xZW9INDQ1SVhjdXhNekJzL1Jj?=
 =?utf-8?B?UGsrRm1XV0RzS0hSbkF6RGk1cmZjTmVvUlVvT202WlNUVnVuanNVWUVQVEo3?=
 =?utf-8?B?NGtFTSt0R21ua0RkK3FIbmtITUY1ZzZhb2JaYlczZ0tmWkdLRUVWYmZpQyta?=
 =?utf-8?B?amtpcG5sY1VCcDVESW5oVElZMno0OXNFUlRlb3ZBUTZGMFJFeVB0RllRV25p?=
 =?utf-8?B?Z0xnajRZcEovSGUvdEFqL2ZuZ0FwWnQ3Nml5aUV0Qi9VcTZ6Nm9qU0cxK0ph?=
 =?utf-8?B?MXpYekFVQjlFZy9QeU9TVllFRjFNVmFPZG5xTThqNGZTQ1hsUjRRTkQ0ZDdy?=
 =?utf-8?B?T2k5MGhxenFncmxZdlRmbzFjckgyTEE3enhvS0JYUmpoYVR6U0dNQnNUOVo4?=
 =?utf-8?B?U0RJL05ZMnl2a3A4em5saGl4dEFZdDJPVG5WOGxSUldkSTlvMElxZ1ZZL3lY?=
 =?utf-8?B?K2NGY2dud042QnRrU2NBY2xqL0NPSGJOVFYxbGU2WGxRUzB4M0gyMFlid1JG?=
 =?utf-8?B?eldNU05FOUwyUThHMG0wR1IvSE41WHJzdDZ4V2RJdlZiRGtYNUh3aXFBVC9h?=
 =?utf-8?B?dHJTY1dkMFRsMk9HbFZUc29zZ0xvTEZxN2tESzRsY2JCaTBUYytSbWRaUmRx?=
 =?utf-8?B?L0txN0RiM2x0TkFzZlp2Y2I1TUZLcWJLRE9BdjA0dFN0Uk5URHMwb1ZZaU9u?=
 =?utf-8?B?ZEt6SXlUbVNBRElsTVBOU2dpSk4zdklRazRQbGVQWmtxYmdZZnJQZ0E4WjBZ?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9805efb3-9ccd-4f61-c1c7-08dbbe5f438d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:07:36.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyOwpVdrLlYcVvK4hx064CJ3kD0o/kDp1jHqt8WMU8sWs/i4wrA4fuqFgH76fEI7RnEeo30oOEhUQ2/5GtxUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6745

On 26.09.23 08:35, 박경훈(Kyunghoon Park) 수석 두산로보틱스 wrote:
> Hello !
> 
> 
> I am having difficulty developing a xenomai applications in the linux system.
> 
> The xenomai application is implemented to create multiple RT tasks and perform their respective functions by switching between them.
> 
> However, a phenomenon was discovered where the linux shell command crashed with a segfault when the xenomai application running
> (error message in the /var/log/kern.log : ps[1493445]: segfault at 28 ip 00007f18fb955304 sp 00007ffe6a76fb50 error 6 in ld-2.31.so[7f18fb952000+23000])
> 
> It occurs in several shell commands(ps, sleep, awk, grep ...) and the symptoms of segfaults are all the same.
> (occurrence location, occurrence library: ld-2.31.so)
> 
> If this xenomai application doesn't run, it won't happen at all
> 
> When I checked with GDB, it occurred at "THREAD_SET_STACK_GUARD 
> (stack_chk_guard)" in the glibc's security_init() function(elf/rtld.c)
> 
> I tested with the xenomai demo program(/usr/xenomai/demo/altency) instead of the xenomai application, but the same symptoms occurred.
> 
> I don't know what the problem is(xenomai porting, xenomai and linux kernel version conflict, ....)
> 
> I really need your help.
> 
> 
> ## Note (enviroment)
> xenomai : xenomai-stable.3.1.x
> kernel : 5.4.208

You want to update, specifically to include ipipe-core-5.4.255-x86-15
because of [1].

Jan

[1]
https://source.denx.de/Xenomai/ipipe-x86/-/commit/2c7a52ca04566c6a27dd99bb9ea81107b986c49e

-- 
Siemens AG, Technology
Linux Expert Center

