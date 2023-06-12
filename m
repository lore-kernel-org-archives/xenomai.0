Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97F11C88
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:43:27 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [217.70.178.230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AD0DFC98B9
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:37:59 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 1F2AE240002
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 10:37:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 24A377803D8
	for <xenomai@xenomai.org>; Mon, 12 Jun 2023 10:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J77IN7YPcqchK1HT50EILEBxkO4w0gjsapq6AYT/wjc1OiH7vzvIutzzE4Mqs2KELdspJpAlmFusQ5UgNUTT1u0wdVMpr9ZVqqUctH21CYIkHmqFcss/uEKDAl8MAmnTpftuGlvpSPolqW3HFnWjmWXds6AT9xuGmlFNScV1Dsgl/RuCZxH0aQu7sDQbqlZ5Ghv2SfTXtS6CA9rMbyNgM9ME4yhBR3/xAE0jTABOrIWQDb33aOIecLgOP2X6b8WeAcotfhquTe+AIx+0+zrOo/aG0AdzY+zy0hGZugv5rYflNZpqIVKuM+vlXIomDxfJFnrsWyeR4p5n0jtZGY7G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9shk7+tVh4TUDDPHmWdBg4zVVEoVgsaB3Wzbz4dh/IU=;
 b=M7A9Mkr+dPJSPJPHMu51EUR6YmTP1p0/ocTc4QK4lOciSDY4QiIlvc+/UCwavZR/IuOFqCfSQm/6CkvP+RKHw+Uv5f+rIFs8g4APTO8VZTjRsecWS+7ExDPBX4PfGtkQNMiZWMAouMBRvNxnNcjTkcysieKK5HnQzFAyNRHt8S9kN4ZG64vUP/w4dBd6pavF0N2fYF+yCNCj6UtVJVu1V1z1Vu75f5GtCYfdKYUQEob4s8XZB+kBhAwHKCfpcOI/poALoSHEuVzOgp+D42t0YxvXcaH4DMjPXWuwEQ78K+40XXBbLcQfsA80BeH1yacCoONMKt/h+Jbz3C/nwqHYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9shk7+tVh4TUDDPHmWdBg4zVVEoVgsaB3Wzbz4dh/IU=;
 b=PWUtvhuEjGU1eOYklPHy7L7SeZlwcDdHOiIfYONSSzyx+pIokpzm1C1Wko7uD0YDXBfYIPpUtwaBCPI+eKFNKsZvuPpjppOBQ05jlP4Zae0kw2nY0Da7P71Sz1X3K8rJv4NYODAhpexmkl6Mv4UJ00ICC5TkX5216Yc+jq5mNBp1NYBo/1a6GgtoLLEILYrmoEzQkjVFVVQR1mmk8WsIkMKchcUgcRY67jrTUHoH7W6dWnNlL7pDfewWzFSCxffsdqaQbB8Y9n6XlTsvQLmfTncKTFykEJrwaa89HYIQAp006TYdgWGJc5gQhc9TRJ4ATuyDs+3MvWod0ABVA0P3uw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 10:37:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 10:37:49 +0000
Message-ID: <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
Date: Mon, 12 Jun 2023 12:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Massive variations of execution time on x86
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai <xenomai@xenomai.org>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: b46d5253-37a0-4343-d944-08db6b31116e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	780LVPxyZGFSLPvVEvH1Dw8EGwFB2vzyyTl3hYzfKMHd85+SzkXNQe8an8GEHwSnsX4zHRoM9/uO0QH7HbEZt+DQVnKf14LlZJ5KCLb1KkE/C3CyR7O/nAowPcLwL1S0rJMC2zBngI+10HMXWsbNC8T5JQyHNSbFX06vFqA1FsLT6DzqLDy/3UqAmJBFRksVlrhcR1+lPqPgeeUN0zVmKNxTuQ6rZLXGFkQw1yi0BGgGdsMGzt0+APAtPgZ0MxsLlNm0dUGcdtubdLANz7Ak0G6DaS3UVeeUIP1N9OfwX0WhAT2EoV4LDXN+1CysF0EzBWmXwTNUHG/blo2bfufyDqdSaN0SyKzS+O1FH+grCb69bRubDSPccFH+V9ADNaeYKLxDeSfMDy6iLXT52o5+5YS0tyE0g2z+9HZ5FjU2vQ/8nsdSDbHpLDmfmuNss1q0AfwJzOcSWcpBRuCgBIo2RpiOEgffGooiZAZ3wub0epAnhtGG+hROTTIKsV7vk7YZhKQqNUFO+3Ac1rQ7HPMF3D++RN1n0jM5oTbPl0rH5EppI2Jx/RlBtOOy8f54tOxvGD6fRewjr0BUwUBvLO+DiEjdcdOl4e0yylbXmgTr2hn1cPGyBL6mKkJqYBGHvTPXy1TTln2P33q9np8YyuZDpuh0wZ/WCIge4ewRMxMo+lo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(5660300002)(66556008)(8936002)(44832011)(31686004)(41300700001)(66946007)(316002)(2906002)(110136005)(8676002)(2616005)(66476007)(53546011)(6506007)(186003)(6512007)(83380400001)(26005)(82960400001)(478600001)(6486002)(31696002)(86362001)(36756003)(38100700002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emR3eERGR1Zja3ZVbEdiMS95RmZVVHgyRUxzK0RNQ2t2MmJxZ3gxMzZCV0xv?=
 =?utf-8?B?T3A5dElPbEp2WGVIRlh1cVgxdGRRZFRpVlJwUVNYaVlORE0wNFphR1lDWHN4?=
 =?utf-8?B?UzJnMzZyUjVMQTRBQksvMExENm1IbklLcGYvcSt0anUxb2ZRUDRReDRTYVcy?=
 =?utf-8?B?d2xmeVRJRE1LUWozRTlmSFQyMStSZWlhTEduaTFXRDZyYmdDWmxvamVHOEhn?=
 =?utf-8?B?aHgxUFRnK0l1cDYyb1BiRkxRQWE4dU9NOU1VM2dkNnBldWVlVUdReTFra2tq?=
 =?utf-8?B?RlQxeWJFQURLaVBwd1loMnpoRnVYZkFWa0g1WkVVU3h2N2JJd0lkSWZjeXNk?=
 =?utf-8?B?MFgzRGc5U1E4citFN3ZRRmFQYjlWTUx5czQxb3ZGdXpPd29tWG0xWkdTeUlU?=
 =?utf-8?B?MTZSN050WHU2bzlhUUN6eDk4VURTdkI0dTgwQ1hTUnNiMTZDMUFHM1BMSXo0?=
 =?utf-8?B?T29WZXYxYjI2NDAyZEVTWms2c2FUTFdKSDlmWWh5VWM4eVFQQTJYc3hxWDRY?=
 =?utf-8?B?TFFhc1gySWI3VWpoaU01REMvd21USVg1Q2M5T09LSFkzUWlqUXdxM2Q4b3Zk?=
 =?utf-8?B?TEhUMzR3MXJBdEY3VHJBRHJDajRXQjFaUGFXa1g4VUxuWUpRczVueE9LQUtP?=
 =?utf-8?B?VFdhbXJ1TzF6ZDNta1lpSVZyanBib0VBejUwazlMSGczbnBjOWZ4RDNweURB?=
 =?utf-8?B?ZUJlMzN1MGlMWVJEYTJXS1Y1TUZtQzkzQkRFSTBsZHhHY1RtMnVsMVlURXZp?=
 =?utf-8?B?Z2tqNWdCanRQK0xTZnMxTXU3U3VtK215ZFlaOHVxZGhyUlUzbU51aDVzQmx1?=
 =?utf-8?B?S3dZUXEzL0dkUGllRVQ2Rjl6T3FBWmVkRW1mcTdETHl4ZDhyVnlTRGVEakQx?=
 =?utf-8?B?aUVpZDhSeEJISWpyTUhaeWpnVjdDZkxyVUxWUllFZXp3Qy9CczlIMDExRFhq?=
 =?utf-8?B?cTlmVU5GMnRoUHkwem41NzhRdnl1cnA2dnBZZU5QckxuTk1GczdkVGhubVNO?=
 =?utf-8?B?MjRuNk9yRy9uc2xNd09qVTBYUTRRYVBmVUFFVzNmbHdFc0c2VlVqNHNOaitI?=
 =?utf-8?B?NDZuTGF0Q29veXJCdS9jRzVsSWxVMFRoNldBRmVnMkJmMVRubmRQWmttblI0?=
 =?utf-8?B?UzlCYnpzN0FKcTl0YzI4OStHODBBYWdvT0Q3ZWoxaHNkeHJWNTJtZFpDRzkx?=
 =?utf-8?B?K2VDZDJEbktDdXk3YVBvQXJ3UUVvbXdzMm1wc0dBM0tTb3c2QzJUNGtCMXdj?=
 =?utf-8?B?VEU0V2k1RHVHS2V3SjJWTjgvUFZsaHRSaWxlZ1grVi8zRXdBUjA4ZVZZSno2?=
 =?utf-8?B?U2RwcWRYeGFlTzBTdU9iQXJrVndzZUd5QTZOdXk4cVVNN2dzakZ3Ly90bWxQ?=
 =?utf-8?B?cGxyZDh0dkRlSVhRSm9uaGc1NFNJYUdPdytWaW9IQnREZjhqMFl2QWZSVlVa?=
 =?utf-8?B?Z0QxS2crSE9rTVM5NGdkNUVSVlhhckcvNHE0ZWdGQWpVT0x5YlR1enlYb2Zz?=
 =?utf-8?B?a0hScklpZnZiaFNLaUk4TnpwZ3pHeE5jT3NLRElvaHFzN09FV2VtSERmVU82?=
 =?utf-8?B?OTdLRTFra0loaTF1VkttNDRXOGtoS0g4aUc2SFo4NktyUHF4U3NUR3pNcWVx?=
 =?utf-8?B?QmhKcnBNbklXNFp4ZnczWlZSbk8zWndhMkZDT2Q2VzcwUVBlQXZaQ3JVOWM1?=
 =?utf-8?B?TzlDY2JoTEpGemlLLzFjVnhWbEJ0bzNsR2JlNGluM0Y0am5UMUdoL1RXNEd3?=
 =?utf-8?B?RjZWbGt5ZGdzeXN1b1dEN1ZKRXJLOGNwQUZGbC8yNVBQUkxBd3RhQWVaRkNi?=
 =?utf-8?B?aU5idmdPTXFJQWNqMmQ4YTg5MTB5NFpYZitJQi8rT0JUaENCS0wxdVovTkw0?=
 =?utf-8?B?OEVtemVMakYyaGRWcEVDMzMrcVAxODMvTG5LZjdCUFc5eS9KOFlId3h4c1N5?=
 =?utf-8?B?K2Q5NVFQUkVYcVZTNWlQaGJrb0hHVlJEQXVrQTFQU2N0ODJEbnowY3c2Zkxp?=
 =?utf-8?B?djRiRlYwbm90aDFVQzh3bmhqWWFUU09SdjY2YmJOanFkVGdLV1FFd3Nzb1h4?=
 =?utf-8?B?NnRVVzhSbWlzdy9HTmY4dFg5TTZFVm1RWi9ncWtCYWJSZGRMRU9MTE5NSGF4?=
 =?utf-8?B?VTlCakdlRzFvWHRtcHRoUVk4SE5FQkhrYURZUndGWEphN3pYM2grY0NWR09z?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46d5253-37a0-4343-d944-08db6b31116e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 10:37:49.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2jdLNuhQp884HBR4kJMtko/zFKhBSmrCXkbtGv9cxawUCs+u4UchxSYkTA8dB2PczLVs6qGI8oK8WMZHKNnHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7512
Received-SPF: pass (spool4: domain of siemens.com designates 40.107.8.81 as permitted sender) client-ip=40.107.8.81; envelope-from=jan.kiszka@siemens.com; helo=EUR04-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=PWUtvhuE;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.8.81 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 12.06.23 12:25, Richard Weinberger wrote:
> Hi!
> 
> A well established RT application failed lately in QA.
> It fails only on newer x86 systems such as Tremont, Tiger-Lake or Elkhart-Lake.
> 
> While analyzing the failure I've noticed that the application never
> is interrupted by the CPU scheduler, it has the CPU all the time
> and it does not call into the kernel (neither Linux nor cobalt).
> It turned out that a CPU bound computation within the application takes sometimes
> significant longer.
> 
> I can reproduce also using a simple for() loop.
> So it is also not a memory bus issue, IMHO.
> 
> For example, a pure user space computation takes most of the time 100us
> but in about 10% of all executions it can take up to 500us.
> The number vary heavily depending on CPU type and generation but
> execution is still often way slower than expected.
> 
> The most problematic case thus far is with a Tremont-L system,
> where the execution time varies between 100us and 500us.
> On the other hand, the discrepancy is slightly better with an Elkhart Lake system,
> with a delta of "only" 60us.
> 
> Initially, I suspected that the CPU frequency governor might not be set to performance,
> but I have confirmed that it is indeed configured correctly.

We just had such a case in-house with the governor not being set to
performance and frequency varying on RT entry - too bad that it's not
that simple here apparently.

> Since the application consistently acquires the CPU when necessary,
> latency does not appear to be the issue.
> This has been verified by running cyclictest and latency programs plus an in-house test.
> 
> I have also experimented with various kernel settings, such as idle=poll, intel_idle.max_cstate=0,
> and ensuring that turbo mode is disabled.
> However, none of these adjustments have provided any improvement thus far.
> Additionally, I have tried using the cpuidle.off=1 setting.
> According to the hardware vendor, SMIs are also disabled.
> 
> I would greatly appreciate your insights on this matter.
> Is there any obvious setting or configuration that I might have overlooked?
> 
> Please note that we are currently using kernel 5.15 with Xenomai 3.2,
> although I do not believe this to be a significant factor in the issue.

Thermal throttling of any kind? Is the system passively cooled and may
overheat under performance settings for power management?

Also, do you see similar variations with similar variations on the same
hardware with preempt-rt (provided at least your synthetic tests are
portable)?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

