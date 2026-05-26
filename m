Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2263DA7EE
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799175; cv=fail; b=p5/mvkK6b5nVyNbq3m62XhBGG1UTNoVyMIwwfHdPrQhNOaEPDkp00yvpikHoX2SK9//edFglpbsRcbr4J1YoWcaHvUA6eVQx0sYjJ7o9HGC6LMcLhqqXacUjrTj/wVbAFfDCiCicwTE2EcifAJIXev6c/WCi9MQmcb0j/g9KYqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799175; c=relaxed/simple;
	bh=fXcjOn0R51Yod6uiRKTuwKkOVEm/LlqsFB4l7aVL6Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVZ3PlFoJzyQHr6gqAAw5z2DtEZIPtpipgA7b22j5TiBtvRDOcQtrK8tQfKVay4cnezlYDGTumMlPd3pjAvKrMSN4QpK/rjDKvMJ1X1rDirYu0JFehlPoxcSOtgtO/RNS7ZvsvkZWx8bTzCsbiTFuC7SDgIOI3DEXei8nevdx4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uQdEVDRY; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uQdEVDRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgtJKAZroQ6GhWUCZ5gYjPrkaI8bTuscdver0ob2jZyreNIrt2bxTwrM4JZN7a04pcMBsftOchIMC9e7qM8+DmExT+vyCmtCYnQfJitXhv3/Bmejn3HTA2Dkvn4Oct/dgoohqKZkeo1unXU8GnVNhnMzvrcArNB2FrEBDAvmFQ59kgmD3X+kJS3gOBra/DWZ/ahAQW+5n8SRzk9blClYuZbHXsFFcJpUins49nXldtMNVYbZ/BFvM7VfuYb6eFYKQpTJd4tLWQPRxFmxrznwTvKAkYbceuOBi3vZ5P6CWxZZfhjqKstxzBWLzzNIKseStcIIF32HCVw+1xT75X5tPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xkJgCqf9zPj9+K2QvM8R2Y8bfouVZLatiLJ8wh0enc=;
 b=NAoZeGxAdHrc6tY+H0WJEO5I4T31FE906BN3IGwbD+UvFqWkdmpiArfTPT7obYg+hIB6W8pjcA1WQvGjqj3P5HnYYi3aOrEk+gJw8E1Q0L+jgiJOv17DoI18knDIe2FfZ8LNEz6fIQBfK2GTYv1DQpa4UG/XrsVKaOgyXVjab/PDP7S/aFNQmPjk0ngWfmUO2iq9ZyU70i7Y09Fk3jtLNwIqzjh9hgeKreJH0dug2SXIVkNstpWA1Yzgq3AAanZZVAbIGG88JWdnlacksj89mf63Nn2ffFaaGL1qexrl2qArJ8LUyHZG3sdPjqjp9jj7hPNcrLZVGmkYzDth8zcKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xkJgCqf9zPj9+K2QvM8R2Y8bfouVZLatiLJ8wh0enc=;
 b=uQdEVDRYXWB+twotEH1o5v7ZzMas02qZRVgKFK4OcmTI2IoH+57bh0ew78DZvJgctGkEHiyxF97nGpfwAxuMk/ObTSWvWq+wPwDcMgwKQuHd3YLAkMUgaoFWZxMcKZF+ro3YEizQIkQLRGZXgfv+qAlYzocWUFArebOinpD0rCh5YqSj+gqlW1HIHt5GKzO5ShtmHDvDSSbHZGZhorxC97rA0Jx3L6kskxCxDDDb9sXdHWDRWBLI21scmzdYqp1ftV2lWH0zUdgdlbVrY/nhhgAHF4MvYo9+C2hPj7wU/oF3sOcmSYVNGLf2vNY/I6uva4Sm5VxkTkAS7Ux9142lEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 12:39:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 12:39:29 +0000
Message-ID: <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
Date: Tue, 26 May 2026 14:39:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
 <87h5nvl5ct.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87h5nvl5ct.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: a94a48b0-b130-48da-d1b3-08debb23d418
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|5023799004|11063799006|6133799003|18002099003|22082099003|56012099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info:
	oqPQ3mX8Xuz8e23aFsPlqQwg9M6dC3Uc51RNn3NwOck1u2OxSDe79HK/oOlIRWbSd1XnnAhjcH28ZpDoQOlfdKpd4S825Qw90lIwuHYqHP3Hahgv5GSfJDpomd1FBpsyAv1b7WITeY1jvjk6EqI7bYd3WjFDzBXnJ97kfzukbFCJyooqT4QxXt3mYywV3QFibp5Mmudc97DvermLbL3ifS56ZNcDh6XodO9WBb25CyHcyro489IgYNkAUY5HVLbEgx9Up5AqusO8dkgD5IjCS2juYTdQIIoH5F5ipWowaHow4Dli4VfoOq7I42ZRkZhvIklQT+x3cibbAm0wJkPMzEMoWrTo65BX4WdIlBqg9y2YwpiAEUzWkz7VsXiV9BMH4RVjVYzmaz6zMKAiIolYd34ysNLKdOH1Z3+BLT6VfKj//IWl4TVEK2DBgnxn72YwVH0ul+qeQgztY99EW2cmzoUIa3bg7aj+Wpa0rPwUg1ZYBxhphAbaIObnP+fDNNQQ5GZKnc6Aik/ZKYykQYK2CsG9lSrBcBcP58UHcvsbcLOgbmBt7xOIF9o8UdM4Yg35hGtSCS/QdfyMbtUTAjCZNh0tW44M6M/69uwFxRS3PEqealAHAQb4r83fhkdbnNHPmRtcCrE85ZMLeSQ5jPl7O1HvuTTVdeMOQs/zF1fqztoXI+qduzFc4GOgJv7K+BNsu+UDA260Zihm3kYjuxZIyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(3023799007)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERYd25RaUtFRFZzSWoxKzQzYWtMRmZCMlRwMElxemJvL2hYeHYrMy95TC9t?=
 =?utf-8?B?VTRKLzhQWFdxWjFmdjRZZkdXeWpJRUl6UDArbHNqaHFTTkxxQVdkOHZ5UHZx?=
 =?utf-8?B?WHpma05GT0hCZko4NkpzV2Y5RStFcEI1QWkrK216L2NLZVQvTk9mamlhWS9w?=
 =?utf-8?B?Qm5MQUtYMWFrYUxJWnRCVWRMZ1dkZHU5ejdFQStBbXFHcDViTW1LZHl6Y3cz?=
 =?utf-8?B?Vi9NNzJncUNiVGpHa0Y3c3pFQUFKbUg0c2doalRIMXBxTzQzK2VZQ2lJMWxN?=
 =?utf-8?B?N1QzK0VldWozUFk4UXZIZjNqYlhWMlVhRStpUElyUEZsQ3d5R0REL3N0a0M2?=
 =?utf-8?B?T29UL0VHRm5pdFhPd1k0Zm4zb3VJUG1RK1ZDVjI3WjFGS1c5cGllb3IwNXoy?=
 =?utf-8?B?a3QrbFpFRUErYlNFOE01NWxyVVpPTWVtcUhkWi9oeWxUTGIvUkxsTUdnL0pR?=
 =?utf-8?B?a1NOZkFoei9UZTUwSzdkNlN4WWxUVHZFMkN0ZnRKYTljOEJYcUhtZXJKb3NN?=
 =?utf-8?B?dW1rNzdxMDNzY0JsK3BMMWR2cjY3eWU5WEw1Ryt1MGUxaU1iQms1Z3JBTjJ5?=
 =?utf-8?B?WWxnNkE0OXBvbGoxa09nTjlNQ3RNS1F1MWFYbkxaR0lVZmlvbHdacWZmdFA0?=
 =?utf-8?B?Y2lFNDY2YVF2N2x3b0lmeUlBdCsvZ2lXczl5cUFVbG03SGI4elBYeGpaYWFo?=
 =?utf-8?B?bm93Y1E5dnJmMzIreFRKNWs5dzF6UVdPWmViZStycmcvN0lvaHZGVk90RHp3?=
 =?utf-8?B?SFRYWHl5NmNuelFOcGovR3EvRFl0S3R6OXJ3VncvQUFoT09iQllHVUk4ekR5?=
 =?utf-8?B?WnVrc1MvMlp1WjdxbkF4ak5JVkpXd215VVhFWThMNGEvMGpEREEzQi9LZlo0?=
 =?utf-8?B?TVNuSkdXVGlKQm54cXpNbXowNmV5Z1VmK2RlOU1TS0RKVjM2R0Fla1NNTGRz?=
 =?utf-8?B?REZmMHhPTzllVHFxNTAzSU9DVUVJMnRqZC9DZktDL25ERmNrOU14TVhCT2M2?=
 =?utf-8?B?SUUreUhQL3hEMnpITWlzNHRRMTJ0RkpHN3JIREUvR1ducWFhdCs4NHRmdDRs?=
 =?utf-8?B?YUpMUjZNcC8vdU9DL0NqRTBYay93ZExZdG93UENqelFpUEp5VktqV045Q2lM?=
 =?utf-8?B?NHh0Smp4T0N4OVpldGdFWkhwTnB6eFZoZUpxWmxWZWYwZXZGak16RXl3NDk0?=
 =?utf-8?B?dmg5czVmM2dxUzZ3TlYzK05ndlNJYW9BTzV4N2lJY05EZjl0QUZZQ3F6d3pk?=
 =?utf-8?B?S1RxVGxSbEVwL3lQakVNK1BsRFlrb0N1MXNrKzZVd2tmMjhJNndOZXpuTE1F?=
 =?utf-8?B?YUpBZTBSZ1VpME1EbnE1aUwzdjVvQUpiQThmRGhlbFc4M3pVNEhSLzVkcGtr?=
 =?utf-8?B?Z3h3MS9XNUZoNHp2VjhwUDZDNWpSbkY0RHk0aWw2dzhFZjYzVDcwLzcyenNt?=
 =?utf-8?B?dm1SeVVQTmM2RmU4UnMxcThzMFFxbmtVQ2RlVDRXSnNET2E3cGgrSFV0M0N2?=
 =?utf-8?B?WTZwRzNjMGgvdnREcG1EZVAzRmt1UTFGNThMMWtZOWhpWVRjUjJCMndGNlR4?=
 =?utf-8?B?c3Z4dkxzeDFBdVdZbFVLM1VnWDlBQ2NzQmxDZXhmYUk1NEpCMzg5UW5lOW8x?=
 =?utf-8?B?b05NNytMVFhnL054NjRwZ1NJOHpCWlZ3cHJwOHp3ZkZrU2w0Mkh2TnBwMldZ?=
 =?utf-8?B?REtDRTFlR2xXVTBYNlN2N1QyM2NPVGZpbkRhMWpVQXpKV2FBN2VPWXVUZmxJ?=
 =?utf-8?B?R21veUZ4ZnhkNm15S1dGK2tIN3Y1d1V1ZGJETEE0R2xORHBaeDZmeXVHSjVV?=
 =?utf-8?B?dlZHb3RuN1Vrc1lHdUZOT1ZidDExYkd0RllXelBmQzlxZkxxaU53Rk5qK0hj?=
 =?utf-8?B?cnhsNmVnY1FKSUVSSCtCU0tJallINVNaSzdJK3VFOStyeWUzY2hQYkRrQndJ?=
 =?utf-8?B?aUdlbHNTcGNId1dneHhpY3VRNHJzNmYyeXdLLzJkVHpKaThCUDUwL0JwY1VZ?=
 =?utf-8?B?V1J6TFRDV1BWM0FueVVQeHVKN3NLUEF1NGdTUU50bVZ4dHR5bmlzbmpEaS9w?=
 =?utf-8?B?TkcyNi91RmdiUExYbmpxMjc0WmFYTWJYQjhMZ1pINExyN1owVUJaeSs1UlNk?=
 =?utf-8?B?WTJrdWlhMGVPbXJFcWJqTmROT1crTEpmeXgxOVFQNU5oRHpLUld3OGE3YXgr?=
 =?utf-8?B?azZ4Ly82T2FCT1VwMDRrL2p1S0tabUZ5ZktMUGx6L2lsYUhlblF0bU5jbW5a?=
 =?utf-8?B?N0JYZ0pMbXRNMjJDT0hNWmhoRW4rZG8zZ2lwT0JjY3BSQ2l0L0VwYVp1T2pR?=
 =?utf-8?B?TXpvYno4YnMvLzdWTGlhekJldTkzRk5JRmJxNUlFdkFHZXdvb25LZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94a48b0-b130-48da-d1b3-08debb23d418
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 12:39:29.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkZzVs/+se+5rSlDCGmx1j4FnsApzKJvnSnQxDobbVblxOb+NKwB5AkK9KAGESdOfTWScYkgzXo8JAde36Y9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9010

On 25.05.26 20:19, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 18.05.26 11:10, Florian Bezdeka wrote:
>>> On Sat, 2026-05-16 at 17:48 +0200, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> When a remote thread is suspended, xnthread_suspend checks if it is
>>>>> currently relaxed and then calls it into hardened state via SIGSHADOW.
>>>>> However, this signal may race with the thread entering primary mode on
>>>>> its own, e.g. via a syscall. In that case, the thread will be kicked out
>>>>> of its suspension state by the pending signal, and the migrate syscall
>>>>> it then executes will not perform the expected suspension anymore.
>>>>>
>>>>> Plug this race by introducing two thread state flags, one for pending
>>>>> XNSUSP and another one for XNHELD. After having performed the requested
>>>>> hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
>>>>> pending suspension states and replay them via self-suspension as needed.
>>>>> If a resume took place in the meantime, the state flags were cleared
>>>>> again, and nothing will happen after the migration step.
>>>>>
>>>>> Reported-by: Richard Weinberger <richard@nod.at>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> Didn't check yet if EVL solves this topic differently or is exposed to 
>>>>> similar race. But given that Richard found the pattern even in Xenomai 
>>>>> 2, it's likely worth to check EVL carefully.
>>>>>
>>>>
>>>> Unlike v3, v4 does not use signals for internal synchronization, so it
>>>> does not suffer that particular issue related to suspending a thread
>>>> (no SIGSHADOW in evl). However, this issue is only a symptom of a much
>>>> broader problem both v3 and v4 have when it comes to dealing with
>>>> signals pending for suspended threads, and your patch won't solve it.
>>>>
>>>> To illustrate this, let's say (A) and (B) are Cobalt threads running
>>>> oob, (X) may be any in-band context:
>>>>
>>>> CPU0                                          CPU1
>>>> ----                                          ----
>>>>
>>>> A: xnthread_signal(B, SIGxx)                  B: core_syscall()
>>>>    <schedule irq_work>                              core_suspend(B, XNPEND)
>>>> A: core_suspend(B, XNSUSP)                    B: <schedules out>
>>>>       core_add_state(B, T_SUSP)
>>>>    core_reschedule()
>>>>       core_resched_ipi(CPU1)                  
>>>> X: irq_work_handler()
>>>>       send_sig(B, SIGxx)
>>>>          handle_inband_event(B, INBAND_TASK_SIGNAL)
>>>>             core_resume(B, XNPEND)
>>>>             core_resume(B, XNSUSP)
>>>>             core_add_state(B, XNKICKED)
>>>>          core_reschedule()
>>>>             core_resched_ipi(CPU1)                    
>>>>                                               X: <ipi-handler>
>>>>                                                     core_reschedule()
>>>>                                               B: <resuming oob>
>>>>                                               B: XNKICKED: prepare_for_signal()
>>>>                                                     xnthread_relax()
>>>>                                               B: <running in-band>
>>>>                                               B: migrate_syscall()
>>>>                                                  nop (XNPNDSUSP was not set)
>>>>                                               B: <still running in-band>
>>>>
>>>> Remoteness of CPUs does not even matter, e.g. with prio(A) > prio(B),
>>>> we might observe:
>>>>
>>>> CPU0
>>>> ----
>>>>
>>>> B: core_syscall()
>>>>       core_suspend(B, XNPEND)
>>>> B: <schedules out>
>>>> X: send_sig(B, SIGxx)
>>>>       handle_inband_event(B, INBAND_TASK_SIGNAL)
>>>>          core_resume(B, XNPEND) /* B is now fully unblocked */
>>>>          core_add_state(B, XNKICKED)
>>>> <IRQ>: core_resume(A)
>>>> A: <resuming oob>
>>>> A: core_suspend(B, XNSUSP)
>>>>       unblocked + XNKICKED set -> abort: XNSUSP ignored
>>>> B: <resuming oob>
>>>> B: XNKICKED: prepare_for_signal()
>>>>       xnthread_relax()
>>>> B: <still running in-band>
>>>>
>>>> There is clearly no shortage of possible variations of the scenarios
>>>> above especially if we bring up more complex multi-CPU configurations,
>>>> all of them causing some sort of breakage. IOW, there is a general issue
>>>> with signals wrt forcible suspension, not just with SIGSHADOW-based
>>>> synchronization in xnthread_suspend() vs migrate() which in addition,
>>>> has its own set of flaws.
>>>>
>>>> A way to address this properly may require to break an ancient
>>>> invariant, which states that a thread with any blocking bit set must not
>>>> be linked to any runqueue. On the contrary, a way to make sure that a
>>>> suspend request remains pending across a stage migration in order to
>>>> deal with an in-band signal is precisely to allow that request to linger
>>>> as long as necessary in a thread state mask, only to be considered once
>>>> the 'kicked' flag is cleared, ignored and left pending
>>>> otherwise. Meanwhile, that thread should be allowed to run.
>>>>
>>>> I need to have a closer look, but at first glance it seems fairly
>>>> straightforward to implement this in v4 at least.
>>>>
>>>> -- 
>>>> Philippe.
>>>
>>> Uh... All of that sounds a bit scary...
>>>
>>> There was a reprocuder provided by Richard on the list as well, right?
>>> Please make sure that we integrate a test case at the same time as the
>>> fixes. Otherwise the testcase might never be added.
>>
>> Yes, I already asked for a reworked version (Richard and/or the AI).
>>
>> What may also be valuable here is derive a test case that plays with
>> regular signal injections like Philippe sketched above. To my
>> understanding, that would even be (structurally) shareable between
>> Xenomai 3 and 4.
>>
> 
> Agreed. A fix for this issue ([1] and subsequent) is now available for
> v4. As I mentioned, the basic idea behind it is to make the forcible
> 'suspend' request a lazy condition, which comes into force only when the
> 'kicked' condition is cleared, and the latter can only happen as a
> result of switching in-band. Forcing the target thread to switch back
> oob at the first opportunity afterwards causes the suspension to take
> effect eventually. Because this is a 'systemic' approach when it comes
> to the scheduling rules, there is no risk of partial fixing depending on
> particular code locations to enforce the logic or not, so we won't have
> to play whack-a-mole with this issue.
> 
> This change does not broadly affect the overall scheduling logic in the
> core but rather refines it, it is mainly composed of the following
> steps:
> 
> - suspending a kicked thread (XNSUSP|XNHELD for v3, EVL_T_SUSP for v4)
>   requires to link it to its runqueue, which enables lazy handling of
>   the suspend condition.
> 
> - the code releasing a thread must be made aware that a suspended thread
>   being released might be linked to the runqueue (if kicked only).
> 
> - the scheduler in-band tail code should allow a thread to resume
>   execution if a lazy-suspend condition is pending for it. This is
>   merely about filtering out such condition from a sanity
>   check/assertion in that code if any.
> 
> - on preemption by the rescheduling procedure (xnsched_run() /
>   evl_schedule()), a kicked thread must be left into the runqueue, even
>   if suspended.
> 
> - the in-band migration code should clear the 'kicked' marker bit on
>   entry (with all locking provisions in place until dovetail_leave_oob()
>   is called).
> 
> - the thread kicking service (xnthread_kick() / evl_kick_thread())
>   should stop lifting the forcible suspend conditions, obviously, only
>   unblocking threads which are in some synchronous wait state (XNPEND /
>   EVL_T_PEND). This way, a sigwake event won't inadvertently remove the
>   suspend bits like Richard noticed.
> 
> - A (Dovetail) RETUSER request should be used to force a thread to
>   switch oob, getting rid of the flaky SIGSHADOW scheme for
>   this. dovetail_request_ucall() enables a synchronous call from the
>   target thread back to the oob core, which is much better and saner.
> 
> This is still a sketchy and stodgy description, but I would not consider
> this fix as a major change when it comes to v4, and since it does not
> interfere with the locking model at all, I believe v3 could follow the
> same path to address this problem.
> 
> Finally, there is a now a fairly exhaustive test in libevl to exercise
> this fix which could be easily ported to v3, see [2]. It managed to
> trigger several tricky issues when debugging the fix, so this may help.
> 

Thanks for the pointers, I need to drill through them - unless $someone
has more time this week (I'm hanging out at Embedded Recipes).

Jan

> HTH,
> 
> [1]
> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/5e708006ebb97c7c23ed3ee3c6fbebac4a4fd99f
> 
> [2] https://gitlab.com/Xenomai/xenomai4/libevl/-/blob/next/tests/thread-suspend.c?ref_type=heads
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
