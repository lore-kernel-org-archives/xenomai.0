Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B773530
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187007; cv=fail; b=E0qa2AsKTdveUXMJdBrJUk7eMcWWMGt3N7eqon73m7SNvvHJGd8awD/jO5JEgAL0wjqekMyGEQcGV0OLJwqHfinpreMMX5QxrL4xoFKWRuoVXwBSVpVVLofgGwIracGeVafepJ9NE5HNI4ph7emUDho01+Koa7QV8/+RVs5k1CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187007; c=relaxed/simple;
	bh=Glg4EE1IA9Ys55oOcqEMvQolEblflLYBScJBPbD7H1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9LKg18ENF1rAodL1SdGEoukI5gLcwfFHQcraAeWdsyMVK2CRMDev/O3G2aDiwJE+/LLMo1hXL5WWvPiUULPqL9oMvvSVjIf25fgCTFEuT6SGhJs1Z1RrK9+KdWxAnRcabDRf5OTQfgr3B9GLFhe4Lkpawc8ARnXYtheTq0O2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TiCx3k4c; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TiCx3k4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/i+Fs9ebEHASA/lTZasiT74e+IBUVLi+fR8VQ4UaWvZSDWGimdTnCySY7poF2Crh5tjzI/75pEjvSLbGb9GM8oi+7QfVGhmJDyYGaIqd7zFlcOgr9iLlgz8Zf+nhDH9FPDsJ4ZyXgJFCMDYDHk/661XcTnAI3FrViaFbx3kxWNGTav5PIJUwD7zFtWwZI5L89aVjMhGRfn8xqHVkHTbAaBFuYSrqXfjMVAsaIT+YQjH1Q42zdds/stoTxbcqTXiMTfPdv3/pvH0Vq0+IMWMvSLT92VdPuuVbJG4QDiAT2gEbkDlpW9TEpHZei72l3ai9CVsj9EJ0Lg2sHozFOnnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxG0LeHpe3TnR1iFawAbqvZ3Z7tJOxh1Kdtfgdjs1TQ=;
 b=T6fC/Kx5EgWw+XCj4o5hUgkqwvo7Z/XdD72MV86RHJ+ccJFa1l/7ZUPbnLlq7kPpLWYmUO4ORYz95RNuDBIbWLQLlCyQ2tqVPKdx8DGlPuqZs96wQ5VItICkL1Gqed6/ie0AHowEkJ8fA0taLxhvdZOL+RaArr0P82NkwrE94PmRR33KL0ET3/pvoTGx8uBdvD+2+PWKpkhKduFk6dCugIsBMHow2g1XOosxALkk9GNEsRPotBAhJk299rwaB1fN6Ym4dP5GKzPjWsKCfdKS12JJV2HLTbmFfFOK800SW0e/NkQZnArE9wePKA2pagA+Vu4i12uwnVbeEKOINWfrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxG0LeHpe3TnR1iFawAbqvZ3Z7tJOxh1Kdtfgdjs1TQ=;
 b=TiCx3k4cPGka4lXOinRv+MW4sV7lQYySu8hX3MG2CCUYmgNnkWuw7b9I5TK6LXhiHZqY4pLs4EdPYceHyRhOolpe2BzefiU6QZHbVi/z7opIkuHSBXLAkizezPQffuVV0SWIh4b8elIiv1m1OfbIDlopD3VIMC1REU0sauU+JL2Kqh5y68tDgjOmIPijZbcFYC03btIbjgwDDc5RfedUC+FesY+RwnJBj3EqUj25j8f9k4Pslfd2c10qxp+/NNOhngcJ1AdcLtLPhe7MYxDqe1+y4QiJmYQgKXxBXUV6cRrLs44Vxlgn3wE7TkShNFKdjYZUBoxKNiQPCrBS7z/swQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 13:16:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:16:40 +0000
Message-ID: <7ccc013e-5c32-4f18-8a7d-45ddcfc96650@siemens.com>
Date: Mon, 15 Apr 2024 06:16:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Linux system got freezing when "Xenomai App" started (or
 terminated).
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
References: <SL2P216MB22740891EAD5CFE21E4A39E3E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 65567407-e2de-4950-fbdc-08dc5d4e4942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cprfhMhM/NoK/UfNVj4EHjBRz74hfxJZeY9RR0IJdWWXS8zyU8B7Af8+Qby3aNd5+fN7IREQr9GgyseoSV2QHbMFPHSAgNo5getrQG/eQVZo7vCGfBc8kPA9nzXawDRDrKK6YeLOuRQUPdanWqmL+1leJYTBjWBwZy7oSIWHPhKIyy8qX7lDFQFI2rvCAZDlz2U6BRb3HssT6wLGLaQfFMomqvex/Fms+S9jelRId5Bb3L9vg1q10faZcEoyQtKMdrp0mXSxBJzbm/KvZDCBzdwnGUZxgpQ4Hlj5Fqaw6ywEnhW0/+b7zVnbELgx5ZoaH+BccotrhymXYA4EPDCCyVsd29EcAtl8ELDIDnMbAHPCANRIqIRpBih1aWAyx3OE6igLTva7YIw5yN192wKHFa0KMG6i97SP++pQfZNOqnT9cQrDYNkKL29aMzIiZvfoF6a8obYQQW1rHZ+Q3a09gkP2x/JzonlJaf7DF9qd3AuCXg4j01xcIHnNLeO1AS/gtS8QXmT5HbfYeNe8VNW+Z1wAyFbh/Sr/wxlTBoCa8KX9GI6ozWZl48lriFOOBNWTM2Iuqv4WFoYVdHfKxcUZ1IUTi/ZjRvFh/MOMwUKE46M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2gwUEw0VHRWNXRLRUZESTNqenFIN3RtUkFsSEJJY3dqOEI4S1V4UmNCTEx6?=
 =?utf-8?B?M3NiMzNTdDhRUG1xOHBERE5hVjcvcnV0aks1RVVvWC9HUmJQV2JrTVRpUGFS?=
 =?utf-8?B?WGxCQTRjS1l0N2RFcFd1ZUVNRkFMNVFFVm9QZW5lWHFCWXlwSytCcGNFbDRh?=
 =?utf-8?B?QmwvbE1UMGRzWWdOa3NabzJyMno2RExCUndNQ3RhNmdScTIvYzVrMTJTd2to?=
 =?utf-8?B?MXVBRGhHY2UyVi8yWk50S282aXRabkhsMm4yM2RSdVVGY0xlVndaK1VuaGVj?=
 =?utf-8?B?Q2FWU2JVTERWem9yRThWQld0VlA2YXVjbzREUHBYOUpETnhZak1zRCtDRnlk?=
 =?utf-8?B?cFluenBvM2FuODdmWmZuNEV1dXJLU0xnYzJTL0YxTWRDME9EdlR5NStlOG5q?=
 =?utf-8?B?Q0g1bTVMb2RTT0VKUWJpN201SFVyaHpUb1dFMjFLMzFqSGE3UGdPSTQ4Q1la?=
 =?utf-8?B?NzBEbDI5QkhXYy9BVDJ2V096a1dkN1NLTGtBZXE4dWliVnl0QUlMQWcxRU44?=
 =?utf-8?B?eXNnSUZyYnVBampkWWZYNHFpZGNRSWxPaFZDV3dnM3NSVTZmRWs1dDZURkRp?=
 =?utf-8?B?a1A1T21zTTg1MWhiWW9YUUUwTTZQTHYvRDV1Sk9QQjVuVWdGNGgray9iYjEz?=
 =?utf-8?B?QXdIK24wVWljVlMwdUNRMldUNXVQRzFVRFdGYUN6SkJxUCsyaHFOVEw5WVQy?=
 =?utf-8?B?Z1dVdTRvZlJiakw2NUd4RDRvd1AxNk1HeDBrMloxandZcjNBQlN0WW5Jcngr?=
 =?utf-8?B?QVNiNGhmdUhmZDRIckJuNUUrVWx5cW1CZ0NDYkM5NVZTZTRkdDFvTXR1bUVt?=
 =?utf-8?B?ZUJ2MkRvaDMxTC9QQlpLMVBLSEc4eWxzSUFLTEFuK1kzUEVSWjc4KzNoTm9W?=
 =?utf-8?B?bUFZQXE1aGwrUHhQWVNtNlBsSG5PUnVuWWp5UG5ycnBIWGFpTUFnRVQ5ajI5?=
 =?utf-8?B?Lzd1c1V5dytBSEw4VnlYeFJ6QTdZV2RQYTlLZTM5ZWZQb24zRDhNZ3FKWkhV?=
 =?utf-8?B?ZWh0UDg2MUVZcHRsUkJIYStuK2xxZ29KWUhkT3N0UXZTYUJlcHlqYXlxZUlk?=
 =?utf-8?B?MTMxclp1YnhpY3NCYUViWEhkaC9uMmkrSGFSL1FCY2tJWXJHZExHQVNMck5F?=
 =?utf-8?B?Sk9XMUtub2dKV3Z3V0NPdnZWWjhHNlUvTVV0NFQvenVSdVJ1c21JbjJDZ25D?=
 =?utf-8?B?VTVsdUFTUXFCUXBBYkNiZC9adUpYVSs2dzFjeUR2S2lkY3k0MnlUT20rMURs?=
 =?utf-8?B?c1NBRjI1c0tNL2c5V2dEVThoTytKQVNCNTJxSEVhZkJIdkdxbFRYVVpleUFX?=
 =?utf-8?B?WUo2ZjNCbmcxalV5WEhGZjY3dHc0bFpFR3hxOUt1MUxCNnFQWUJONml2Mzh1?=
 =?utf-8?B?a1RxbWRMZVlzZGpjaDhZUE9VNG94WEZhQS93UlgycWVUWXRkVmh4UGdXWTRy?=
 =?utf-8?B?OGlORmYwQXRBMnRnRkF0QjZmaUM0cGd5ZURoYTlDNTBGTHZUMXpVQ1ZqRGdQ?=
 =?utf-8?B?U2tIUGROWnNBNTJleWovOXNvRzdDWkdUVGlQejZRUlo3L1VBVUZoelU3S0Nv?=
 =?utf-8?B?RVBnV2MvbmJxeTE1aUxtMk9mNkM3bzFxKzdWNEhKN1VwamVweCtrOXBLeXRr?=
 =?utf-8?B?blg0Q2JmY2NZWVNWYUl2Witlbldyci9LOE9DZjBzMDdCOTkxalhncG1aaU5E?=
 =?utf-8?B?V1ZzL3B3UHhqeGUrUDQrS0dSbzhtK0ppMkY3WGJBeStsemtoSy9xQlVtYnhS?=
 =?utf-8?B?RjdSVTJYT3NaMnUrSjM4MExGOGFRVi9FeG04RzFOTWxKMGZmeGRoYUdGaGdE?=
 =?utf-8?B?NDZxWmhzWWxxYmFIT0UxTVloSUdxNHZla1h2UU9kOEF6eXZYeFBkRG5FQXJE?=
 =?utf-8?B?K0lhYnM2MVNacjhCSzZnUW5MQ21CWW5hZTBxOGpCbDRTbWwwVXRueWRKQ2Jt?=
 =?utf-8?B?cy9QZWQ0Tm1tMmxqQUtITkxhekdoOEpDenV4d1k0dlhMWU9QOHplbXhsMkNZ?=
 =?utf-8?B?RXBYTE10dHVRekNCUDlpdTBZZmt2MHp4WndVZy8vTGM4eFgvcHExTlZrRmIz?=
 =?utf-8?B?UUt0SHhzRkFjRll2dVYwYkw3d0k1dnlFRklhOXhyOU5mQ3RVRStnRk4va1Uv?=
 =?utf-8?Q?1MfFGYepVrQxI+etbLkBq2MEW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65567407-e2de-4950-fbdc-08dc5d4e4942
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:16:40.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mJPMg2F2pVHc4S0cef/xAIjLXkAnWs6wUiw/QqGNKNaXDD2HcUimt9FW2bIVghu+PFU0EkLyKGhHfSjH/rKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6915

On 15.04.24 11:23, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
> Hello. I am a Linux Application Developer.
> 
> 
> Application uses Xenomai 3.1x.
> The machine environment is 64bit and kernel 5.4.255.
> 
> Repeat machine reboot at 55 second intervals.
> Most of the time it works fine, but sometimes the system freezes.
> The mouse doesn't move and the keyboard doesn't work.
> The screen also freezes.
> There are no special messages in the kernel log.
> The same goes for syslog.
> 

Does the system already have a debug UART attach so that the kernel can
dump potential crash messages there? This is too often essential for
diagnosis.

> 
> 
> So I'm running some tests.
> If you test without running the application, there is no problem with the system.
> Problems occur when the application runs.
> However, I don't see any special messages in the application log.
> 
> 
> I haven't found the cause of Freezing yet.
> I am currently viewing the “https://v3.xenomai.org/troubleshooting/” site.
> I would like to test some of the things mentioned on this site.
> If possible, I would like you to look at this site together.
> 
> 
> This site is talking about Kernel configuration that needs to be removed.
> "CONFIG_KGDB"
> This option is currently enabled, so I removed it and tested it.
> But Freezing occurred.
> A problem has occurred, but should this option be removed?
> 
> 
> This site talks about "Freeze or machine lockup".
> 1. “Stack space overflow issue now biting sim real-time kernel thread?”
> 2. “Spurious delay/timeout values computed by the application (specifically: too short)”
> 3. “A case of freeze is a system call called in a loop which fails without its return value being properly checked.”
> 
> 
> There are three explanations: I have a question about the first one.
> How many threads can the xenomai program create?

There are some internal resource limits, configurable during build-time,
but you will get errors on creation when you hit them.

> What is the maximum stack size per thread in the xenomai program?

Only limited by available memory and memory layout.

> Our program has at least 22 xenomai threads.
> The stack size is different for each thread. It may have a maximum of 8 MB and a minimum of 2 MB.
> 

This is not the problem when it comes to freezes like you are seeing.

> 
> 
> The question is complicated and long, but I desperately need help.

Did you already compare / try the kernel configs for x86 that we are
using in xenomai-images [1]? Sometimes, user run into interesting corner
cases that your tests didn't cover because we can't test all the
possible config variations.

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/

-- 
Siemens AG, Technology
Linux Expert Center

