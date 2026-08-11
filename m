Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB141A922
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438358; cv=fail; b=jZiU2lLdDSwjLXjInaKMGxbDL1IKs7K/JTk1pD2CsyQl+O+aBToeKDkhOEuKe09nWLVH2zVjBfm8SZNCc1NO+OmAUvEEebLLPJmES5c2urEMXQFffoMlCEbRahuRCUKc1Q3mmek/OHmZRJTdlyNQHyLSArWq8fZAxSA30seMpdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438358; c=relaxed/simple;
	bh=k4/+RX8VAc0tq6P/nrjOeE5UOoHogAL5ynADeDXYX1c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4GMRLYvWJlfWXjvxP7wu6sP1Q8OsLJtgfODCsJk/hLuUkO9UrSN9t/3CHXJqbvI3TWOBQa3YSya1nXEetq2wjhwNntKcnWsEApg85kLISHcbQwcCIKQKSZVJ2VmwaK+k2dqDkHjd7qDGQ33+EBD1KD0ZrlWK9xHFJqH6XwasqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qVn1ylWH; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qVn1ylWH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awRo30P16/SazVPtWZthKQGDf2xvECwSG/MVWuuDG0OlxZVhGuBU03H08PTD6P46IryZjtpNUdwUVQTTYq3y+2qV6ZWbzfORchfUim9wifrYV4+nbi5fyyJcNEtrdbzDavX9fyQ/dIyIevsJsr9lvWlLSaTttynOHuXbrh0jxOpd6Wfh1yUIvutK6vcAS2tHgoneYWJFGSvL7J/4ZcUIB3fl7JcdJ6B4Cqp5nFUy28AlToOxyo6Ar3mrVeUvgofv56iKq/eY5RTgBMV4k35oklGBUoJQqyOJ3ITDi8wmFqOSoXq6IEsDzThtlpCjQ52X4HLJLNnQCYhiF5RD7IsUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg/F+4miYJqzZ2kfQIhThBFnF3LPNSxibX8HvAnkSBQ=;
 b=GK/WKq1dF29DV1rwB5ssc41IqdNjz+s123IfqoeXsBI/1mcF1IF2RvO8v5Wlp+4VIxwR2MIwKsXDYtrrTerLA/BnLbfYfWD5wauIxhmyZnFRF/Qe7BlzsOH5edg5VdC2yXwoZvH080Lr/PKIkvMHJXRpE/koNheIxMTePa27P6r3hRg9pLSgFyYu4BlhbcXmnAXEtUPlSAYXapTBbTRP59cHT4inSHLjW8WNZMDVVtH+KEkbeIhZBJZCM5LWU/s0VEtO3YCUwJCtvYamwp6pc0nbr3mDWRvSWos4WmygykqqyUienKfn2NL48SeXO/BtujKnCjW10PQykmMqF//E/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg/F+4miYJqzZ2kfQIhThBFnF3LPNSxibX8HvAnkSBQ=;
 b=qVn1ylWHSxrIKSUcUsmju1qTBO4KR52iATDdYozh2amdPjowGYsill+kXJCBoQCMtQIB2Ls7El8LixX5/nLciwWu5mMBCWzjKVXSWqJsMuwGwaVj+8C0Z4pjzehGp4dE+k1MQKAnL4T3xqU1Tgkenu844wEJnvLMcY4cAI3PjFV+fSzDQk6NryEQ9kW1L7t1xONI9SbOsqciHC6BudMv/ZfD2D0/PTq4YLCGqXxio0algq3B+4fb173hc+3BE3ET+fH6eEAia/A0YypaQWRP6oWNKin6LAHExLs/xkwZvlqpix8JxI/ZVL/jFYwwMFZjxBHCaHGrtMM001ppHQyDDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 08:52:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:52:33 +0000
Message-ID: <8bc74e8b-69d5-4ae6-83d8-bdf746a81606@siemens.com>
Date: Tue, 11 Aug 2026 10:52:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Cobalt scheduler preemption behavior
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGqEW4d+HOhyaNhDLe3tv9TFgcUtTFa6hH_7SPq892pXA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPGqEW4d+HOhyaNhDLe3tv9TFgcUtTFa6hH_7SPq892pXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3589:EE_
X-MS-Office365-Filtering-Correlation-Id: 3199438a-7aa7-4353-8d66-08def785e20f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Pd9BKTh+oNWHoKhJxh03M30dztMtfAuRc+DOC8equzrxlj3GoqD6HcDj43abP84qAHGe/jdgHC8re3lQzL+kMqj38Pj1xEVGO3OiJffHYGhdrxLMEA0poZyNWDU/iQsqeYCdBwV5sTVLTD1yYUdTHNzBlHyugvUgY+mxZUs1KRdmqf3DpAYp6C5MWQuK2+hWQqe2qcJODGwe0ItKFuoH61FXKZAEOpYrj7AOTeJycc4d6Qey0Si5spjmg75eebmJwY51Jd3PzH9h0bJOWVSoiIwh4S8hu6OxIPuuHXbDKnitF1S7xakdFWxgb1jyqsxw5RlJEXEgexevZPcwQfup8BdBmZ5WDeAO+l4QJBsMsltHR7xKRs41h95ZhOXyEO135JB1HCasPmkDjlxJMnLw3OF91qCTP2lntLrJ4LuOFdLuptV+rS19Ad0BOn1c7BAJLS8tVUA85UTFjLh5/SYmkanoBEY3mLfrmXXmy1PEOX48eY1UgnUjQfCge1juYEz3zwY4/qOdHLunaoPo6sCMCaZfzfkS3hRlB7KUisuP1VMCwWHmj8oMZvPhIcd4qfKsARUOeXijVeGS6d73OTyUJE85pjf/LKYBpiL03hUBUe2RdYR/VvMSpvmXOYYsGRvuY5uALnwcailZ0NUERU1rn0Pg7lqSFnRJ4f+GBllnlIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZCdDEyT0ZOd3cvUlZPUG9FNmJjTU1GZXhvTUpFaURWSHFQU0JaQmxoTExm?=
 =?utf-8?B?aFJZWXRMRmdSbC9IMll1MDZQUGIvNisxWDNGd1VkVXRPYWFDck1xUllFOC9C?=
 =?utf-8?B?R3lndDlEVldESUN2R3RZSk1mYndHL0E5RjJUVUpQT3JnRnBua1Nldjl4NGhq?=
 =?utf-8?B?VHkzeE03SzZ1dzNqYVUvMmg5dWpqVVZteFk4MTJkZVg3dGNKeldKMTlaSDgw?=
 =?utf-8?B?dlBLWmllWWRQUGIxUkhTRVRndlpaQU41OTdHbE0wYkRSQzFHNlY1WTlUdzhP?=
 =?utf-8?B?RzV1K2pZMnpDWWFxTS9CYTZkd2pwWjgyeEtzU1h4UUZWei9QcVhRY3QzQTU5?=
 =?utf-8?B?ci9SWWRIektuK252WkluQVlRdjZSSUk5VlpNQkFSTXJ3WHZtMDRiWldmWXc1?=
 =?utf-8?B?cCs0V1cyeGtiWEJBVFY1a0FvR0hDNDlaR2hidzJHZjhhUGJmQ2V3SlIrUElr?=
 =?utf-8?B?WDI5aGVPclg3OFR2SVRBNmpKT0tCa2xSb2oyblRYZzA2bjNMaGFkejc1RmFq?=
 =?utf-8?B?RVBGaVZBbVFNakFtRGEzL3lOWFdRanp4YUM0bFBGVXNTZWR2Qm5CK0JyNjNo?=
 =?utf-8?B?ZU1FaUp3akdCMUNyMHVqVG5GUFd5V2Y2US9xZ1pWTjBhN21ETnduZ2Izdk9u?=
 =?utf-8?B?VXFuS2UrZk40ekpUVEtUS3k2QXNtMGJTeE9xTUlkTk5BNVhLalRoZmc4b3Bj?=
 =?utf-8?B?alovZmpCZW96OGdPUUc1YVVYM1hqVTVIN1JHY0w0alZVNTloam1vMHAybmJy?=
 =?utf-8?B?a2s2UXUwczZxNytXRTJMTGNxM3NHZ3EyTGlwc3ZmWTAvbGxsbVc1OEN6MFdN?=
 =?utf-8?B?blJDYmluL2ovbzdueVdWRHczMXpwM3BhRzVDamp6Z3BzRGl5TmdiMkZJSUtx?=
 =?utf-8?B?YkYveUVFYTBzYThGUVdRaWRIbG5DWjU4Tkt6RG95RG9YUjN2TUU1cDE0T1Y4?=
 =?utf-8?B?UVVwWWcraEdaZlhvSU9PdGNGbHNmYnc2UFd3MFZ5d3hvSGtQVE80ZlMxRDdR?=
 =?utf-8?B?MFRtRXE3Yk9qMDdtR2Z5WGVEZGdtNEtwbXRLTldNTkFVUjBkbGtVMDdWSk9H?=
 =?utf-8?B?MzlZMXlWUCtpem9TKzFRbnphVC9vVkNoanpaZUo2U0ZUU3N5cjVwaTZzRHRY?=
 =?utf-8?B?clF2b0ZPb2M0aUs4Vlh6T0p5TzJyUzRydzl4ZFF3bVJCNHN2Um5pZGFqNEIy?=
 =?utf-8?B?cVpueituOHVJZlVkTWJSeDJ3TURpUm9DWTkwc0s0MFllbkY1SWFiRit1REdw?=
 =?utf-8?B?a3pvZWp5eXFwbmY2Nnp5ZmdNcjhsREN1MEZUZS9uTld5cStMZkpZRC91L0Ns?=
 =?utf-8?B?cExwNkZkRXMxekJ6MkJBaXEwelZLamF5V3l1Y1RBL2U4NmVmUFdZOWc4YWVZ?=
 =?utf-8?B?TDZmMWVqc0ZFMU9HUE5LcVpRNHhCREdNbzRYd2M5YlpqdnQzZVNjRjdzM2tZ?=
 =?utf-8?B?VFZUbExHTTkrd2Q0Y2hrNkJMcGdKS2RwMUJuOTZqdFBxTmYyTnFoVHVmODhy?=
 =?utf-8?B?OGo1Smo4OTNKaHN1WHMxWWpDSkZpOVZXSzhvN1daK1U3VFBURlBzL2JDdnlO?=
 =?utf-8?B?R08xSnpIM3ZXOThFUkFUaXkxVmtyTkZ6ZHh6dEpLRHR3NG13OExVb1pYbUFz?=
 =?utf-8?B?RTZsZ0FyVTh6QXVOT3dGaU1IaVIzOCtJNE12bHJnbGlLcmZzMUpxVDdSeHRq?=
 =?utf-8?B?WlZ3c0x3b3hiMmNSRDR5d3g3RFdZUFNNU2xtOTlGTnpTOTRGZnFMK1Zqb3g0?=
 =?utf-8?B?T05yYlF6bi9zN3RyS1lXNGJmQXk4ZWxVc25ITWREY3VUMHNxQ0wyODNYSC95?=
 =?utf-8?B?OGpmUHVlUXJTZEVVNkREU3QwVnpYMEptdnIwV0thc1pSdERiMlg2andja2dk?=
 =?utf-8?B?VDZmZkhhWVdYR2crTUpLV3l3SXIrUXFjUmZ4U2RsRmo2ZzY5RHZPNFh4TEov?=
 =?utf-8?B?MUlpdjRLZFRPdTFwMFMwNk1iUUEwRTgwWjQ0OTFONnhJWUVUQ2tTVVM3SlJy?=
 =?utf-8?B?QmlFZDlPclhQcWUwYzREN3U0czU3V2FUaGN1cTZTUU0yWHhxZnNsR0xqR1ZN?=
 =?utf-8?B?SDNsWEU1aGtxTndsSmZtVEZhekV6RVg5SzJkWitxZjFuSUxHeWxtSmNUaWU3?=
 =?utf-8?B?UkVmTWFYZzhqemtvQ0FqMVBsTUlWeGhpU2hHOFRYTUhkMXFDNHdWeGxJS3JT?=
 =?utf-8?B?RXNaSFp0UkJKa3M5OVI2MXhyTk5TNTV5dzNEQWwrUGlvSUxhL2c3VUVkVFFL?=
 =?utf-8?B?Q09vRldwSlBOQkZ6c2dtbElpcTdteGgzZGJzWkxOc0JqcDc2OGxIT1R2czJ0?=
 =?utf-8?B?cVJKaUdpY2dFVWlXZlFCbTRmQ2NleXJLaFRuckdBdytzK1ZhLzhDUitDeUVy?=
 =?utf-8?Q?mMNa9MPfYFNI8T0I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3199438a-7aa7-4353-8d66-08def785e20f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:52:33.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf2gqxqA0Z2KNxLLFjFHvE8ZDB4tqELU7/BlSW9n2rvMDNiXpmmjnTrpi2nHF3xDr8FjGaOxy/ojruaI5vnUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3589

On 08.08.26 08:17, C Smith wrote:
> I am using Xenomai 3.1, Cobalt kernel 4.19.229 X8664  (I know it's old
> but this is a legacy system our company still develops).  I am
> wondering about expected Cobalt scheduler behavior on a single core. I
> have set isolcpus to reserve core 1, my first real time task sets
> affinity to core 1, the priority is 99.
> 
> ret = rt_task_create(&main_task, "my_rt_task", 0, 99, T_JOINABLE);
> CPU_ZERO(&cpus);
> CPU_SET(1, &cpus);
> rt_task_set_affinity(&main_task, &cpus)
> 
> Then I do the same with a second RT task, giving it the same priority
> (99) and same CPU core 1 affinity.
> 
> First Question: If the first RT task is executing, and the second RT
> task wakes up from a sleep, can I expect the scheduler to preempt the
> first RT task to run the second RT task on that same CPU core?

Same prio and SCHED_FIFO (used when prio > 0) means that the first task
runs until completion (exit, self-suspend, blocked on wait-condition)
before the second in that FIFO queue for the same prio level is run.

> 
> I put DIO pulses around both tasks and the oscilloscope says 'yes',
> the second task preempts the first. I'm a bit confused about that, as
> I expected FIFO non-preemptable behavior from the Cobalt kernel.  ie:
> I thought the first task would finish, then the second task would run.
> 
> Second question: Is there a way to configure the Cobalt kernel, or my
> two RT tasks, such that they can't preempt one another, but when there
> is contention the first to run is allowed to finish before the second
> runs?
> 

To achieve preemption, you need different prio levels or some
time-slicing configuration (rt_task_slice).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
