Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8238331C
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095907; cv=fail; b=Fz5WR6M3wVYgDJ7/KHXWcuKjapEeFpog4IUk0MQ88QBGlr/OpRGHDkoOVYrLopW+mGN0rPUsH607G0kMKlXd9AyW4W7N0BQUM4yhQQ0m+J2C6bJl5YskLQN2kCab6aOiNXSJwVuDZ1DhN+0PffWoCBP42cHyjCq6O3jiYv45Hb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095907; c=relaxed/simple;
	bh=OFTidkQs84y1AK6mXbHGEO1V19RC/mcVG2QrxJRphA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2GFJXGvqb3VgCohDfchxmHX4+gNFx/gw4vYGa0Wlv9+2rpBhJqTUT04FA5KL16CUsFzqjVl83NXDjyioc37MjE6tBcBhVFFgmUXTwh89faT3fNWloM40KySpuGH9BqPjqCJTceSdLDk5o7oxZJaqimh06y2KmOac1gjUsHvQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WoQMA69c; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WoQMA69c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCCgi65JZ1nPJXDKgbtuU0OjqFawZSTGYnQDa0WFhB2neKR4JAxK5bU03IvE1tG7jvY8KREBvwA4lmMrhSeAyrR6om9re21w90TKaRQ2NGOrz2GZZmPpCmP8Eq1IvitGvVjN8+EWRLpDJFgJa19owkRfURLbDpHT1tl8dza7+b28BqqgNCSWPPJEigMLXPxvMD7BfelICcEro8h9EVeC0O5gTgZPGFAZ5pT27c/SsYOkc4r0mK9buJZb5MdmvgmCuCOz3582+rZHZ29jhvY9SMYoe0d/Q0XHA+AVJIemdC8BZzzdjuAMmsd144mXb1FDgJy+0FMJbf8LAlQm7jjb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USJYMqrIqdBc+GLPQE56SZYa3ziCDz7iYnlZMjelhgE=;
 b=D3G1GuI9FRpfbmZtAf7XaqhCciHAYigGhhLoGDUQnxkNaj7wQ63kOHvjyKqZG4c0SfVSyhtK4jrkKFIa8LXpbtWtSYoIGsqgLyp2iFVqp9EuxTfEF+rxup595GGLdjiqJ6x/HHKCV9HvlA/I15blsOFHx4MQ4LYAlCMamZCalmvzqIyV+dAyfSsp6hd6kXRlBtbn54yi9vBm2pp7iO+soIjNzJKyvo7DKiBdSjJIiVBtjWJi3FwKQrE6E7UfY7Rs05b523RF6vS7wgAqBVE25tikwjXoeW9/3ZnfRGMRCFhmPDsVGuyOte9MHLU4SrA2IW4Gw+aner3qHwNMA2qHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USJYMqrIqdBc+GLPQE56SZYa3ziCDz7iYnlZMjelhgE=;
 b=WoQMA69cnZjJFUQ4PEQgzS+25Aqlgk7MmppOr1B7XtYOr6LaHlWMd2IXWbnHvHMUPlG2B8QTaDkjbeEn9Bmfw6cjCyRefZOgAxirLnbyrVvU29nsDFJwyveth1jtv5HxwPO4hu5xTeMuXxJM0xriB9fWLfSZLj2nW498tr20lvuGnar89FRKReaiNms6LSwGzfxVoC/nc1HqVMFeBtc0k+H6YkDa+VWptsQEAjvfyyuPZdiLdFGlDyQZGi0AaxB7LHQR4W1wr7x/MsVnvq5kVRElk4befuGDbfRPl4K6qpq5/w6lWv8n2d9cAMbhtuCeVKWcHZEQw1d2eQw8TI0GyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 09:18:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:18:22 +0000
Message-ID: <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
Date: Mon, 18 May 2026 11:18:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Richard Weinberger <richard@nod.at>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4359a1ed-7094-4296-ddae-08deb4be68aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|55112099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ktFYIiMwFa+JtYKTJUqnnrLDBwKVkrbcfem1P5m6GfNTrchobs9raCesK6ttFbO0mQ9VX5HJv3BpzGW3i6ykmPrFxAXjN+Nfc6ai4UL/w9g7OALpiI5q0awka/zeByQD2CdQhR5jT3ST11vJpdmL9fofbjDgKOj7P8maWBYzK3Qk1P+rb/56hZMLjq14pRn60SzMrmwKGblTW4Ma81UuKFfXmyGePyyYPy3kVEKfMavR21KxvKN9d0KsN/Wsk3SdYmBC9MSD7vQnM+YuuUvkPECmSMKIqzM3YKmO7fuQHxgNgXQvMwyh5VxVCP+jzuSTgKeJjQlc5g47jXEl7kRp8mrafXgT6oQSHq4yk9JzBbzhbAOD1zKNQ0yaDdrMFIB68YqVQQvI1/LN31mdMJ6lZiRLgDjGQswvEvxoqNgYrhoZuMafs0engMnO5WgjEW7wvGEVFUsAoyVGwuE2ziAjm4dzNcmFu9u1DPaNOoGW1I1dW6s8uU71+1GJI0B4HUBP4SzwvYpLHC77RZuKDiEtdcWnn+QeY0Mv36436jQnrRjK1pgzOti5BNE94YVk5m7Z81VcyWyT60lwqfPeQ/epGOFlztb00bLpfublukGTMvwlkgiHNBOtSYyYgmiJuvHDU+WqeCgUYqvj1EKXtVn8g9ilcJW9S9EDouzSzFp/cBXsZIm+f8uJRE6rq5YoT2hF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(55112099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bElMWFBJQXNSTmtnaVRXeFFTelUyVGprWG1ON1o3aWJQS0kzVWl5Mm1KK2FI?=
 =?utf-8?B?UXlZcSs4RVhNUDY2V0hCeW1hNUhPNGMzWFhXek5IT2RVWG9kMlNRbDNCNUx4?=
 =?utf-8?B?T2FUbElSeTI0MHZzbysvR0dVNVN1OHVEU0d4UXNLK2RBcXptbU14bUFScUxM?=
 =?utf-8?B?aFNkN3BEZXJielZYQTc3MjVPQ1NLYks0OWIzSkNYcGErK2RFNXRPRDZXYUwx?=
 =?utf-8?B?ejBwYUVvbzBRbVVrQzRJTjVXaGIyQytucTVldC9VOVB6QncyVTltQW03Slli?=
 =?utf-8?B?emk2Y29rYnpHWkFwRHNMTFJRM1FJaktZTnhEWUZ5M1kzTzFWa1pGcFgrc1FT?=
 =?utf-8?B?a2VtMHpFZFltQXEydlJzR1EzZkxBQzZ2QnNxUU5LS1FJMmN3WFpzNmJMeGFP?=
 =?utf-8?B?alg0S0Fuemd6bjJvSEQ3NGVNRUJzakhhS1FFMi9QNzBEa2YwbmZEWXN6Vitz?=
 =?utf-8?B?V0RkQVRTMDNCMnJaNTI0UmI4RkdlT3NJTWNoRWdWU0FJK0pySmoyMEZLbjRn?=
 =?utf-8?B?OFhBa1RRUElQQVlVa1B6emlRQ0E2TUpvTEVFWVhLU1NtOVE3K29jYUdHZFlO?=
 =?utf-8?B?elBqT2RqQTFxcW5XWmsrQTBvWTVON1NMRHpnT2kzaDhYRmhMbFpmejJXWkRT?=
 =?utf-8?B?Mk5SNHBiS0VjZDJjQXRTcjcxYnBmeFhhZC9uaUd4clRjeGhnMEJZNGF2anky?=
 =?utf-8?B?ZHYrQWlMdE01NUdKYXl2RWFVUFhDNlNVcTlad2h4OXdwbGdmcUtSMXMralZl?=
 =?utf-8?B?bld5MU5LWVE5NWJOUjNKSDVwbm1VY0VqdGRGWndjRjZ0VXlGRTlLVGN0UDRs?=
 =?utf-8?B?cVJyRitoaWtDSGV2cThjcW1PdXRVSEExU0FtK1hCdVN3NnlQK2NGcmt2NlZT?=
 =?utf-8?B?TVhadTNQODdhR3NqZk1mU0RyUkVaQTR3dGRNKy9qbmRmY3ZhQXFnS0ZBb3d4?=
 =?utf-8?B?SnI3YkRCQWRueVp0N0grYmdFOUFxUWtRS2ljZUpoYk5UMGNic3FXRDhsT21u?=
 =?utf-8?B?U1k0RjU4RG9Ra21sS3R2SVVSalMybUYwN2dHZHlKdElVaGNYV0Fkc3RtczA0?=
 =?utf-8?B?UE5CQnA4MXU1US9FdFZsZHBRWlNNYkZFN1FuZ3gvRHZoSVVhdUYzUzdpRlhs?=
 =?utf-8?B?RHllSnUyRUM4NlBQRWQ5aVVYZlBYc2wyM3JUc0lUeXhPUzNmS3BHY04zcmxr?=
 =?utf-8?B?ZDREeWNUczkwZVZ2bmtnZm4vM2dPYi84TFdEMitseWhHUWVPQS83UEs0MGI2?=
 =?utf-8?B?dnRMRlpNUldKMFFxUVo5TUtDS2o2NlRCZ2xqWk9mM1cwS1gxd1M5d0M4b0xi?=
 =?utf-8?B?SVFqRXZWQkdIYThyNnlMQUNBS1NKVWNTaHUwQ2tOSStMbWs1TlNMTEx5K2py?=
 =?utf-8?B?cDVoM2g3NXlXUXZ0SVkwc0hMUVo2cG9XTXFZQmVkYkxoZ0dMNVFxRElqaGZ5?=
 =?utf-8?B?M3VoVTRFejN2ZzBlMTlsVy9nMndMbHJtN2dIalpiK0pQVEpIOGh1dlpsa2k5?=
 =?utf-8?B?OGhjWSs4SjdIcy9hdGdmQldpNTlaV2xqSEFrK3RtazZvTHR0bWtQVk1xL0JZ?=
 =?utf-8?B?MS9IVVBJOHZNaHhGcFUxZFpkNk1VS3ErYk1KNkFyaXQwc0E3U2FvM2F3S2F3?=
 =?utf-8?B?YmlFOS9VTTRBamU1RVFlSDBvc2VnOEVsY21JRGpCU0JCc3Z1SklVSkNZcjNr?=
 =?utf-8?B?cHRZaEJjRkJTSTVKenBDdUc1UGM0b2dOaDRIRVo3bjl4S2hXallwZ0xYK213?=
 =?utf-8?B?bzdKR20xRlRmRkQwRU5jOFpzQStoOCtTbXJxUmdOZFIxUHNPV3dHOVkwRlh2?=
 =?utf-8?B?NFF3V21mazJ5b3k0clNVVlR1dUg5Qk5ES1NLMWV0ZWJWTWMzTmM4OFYySHAw?=
 =?utf-8?B?aUxVMGRTVjFYOUJjRkQ4UzRWMnRMZXR0amtja01tc09iZFJjRVMrcXM5cTZ1?=
 =?utf-8?B?MTJtWElKcGFCNytNVXV4aHF3RjlqcUp4c2xjeTZaOENHNVlIcjZsam9ZL0Fu?=
 =?utf-8?B?NXhXbGg5UVZ5NTRvYzdhN0pNY0RHRVFhZ2Y2b2tnUWRiUUJnVTNHVHYyTEJN?=
 =?utf-8?B?ZlgyZTBvWlRTbE83eDVENHkwSExJaldubEgwdTBmdUx6Tk5xTkJKOU5maFR4?=
 =?utf-8?B?TEJ6M2tNU052RHh0c2lEM25hemJRVkZGWVI0QXZKNW05OUlmNlhKdUs3dTV3?=
 =?utf-8?B?UmZKWmdGY1pKNnEyazBBMlpjMk0vcjl6bWlUbkRhS1RYdThqTDNLNEx1WmRB?=
 =?utf-8?B?SVVXWmxhNElpYU9qU3FqV0ppMFRBWm5jTmRZZi8xbWpScGpCSzFoYzFMRXNN?=
 =?utf-8?B?SXVmQlE5UDVTNVFTb1JHNEhQeGRhbmxYdjIvOWMvbnJBS1NMcGV0dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4359a1ed-7094-4296-ddae-08deb4be68aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:18:22.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDpdlrtGw4zQNWxrC+HW3eEbNdkqW+U8usopjnRgdYi/yCRtjw0wZYpGw4y8uMwTyScF495i24/p9x0EALElIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3748

On 18.05.26 11:10, Florian Bezdeka wrote:
> On Sat, 2026-05-16 at 17:48 +0200, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> When a remote thread is suspended, xnthread_suspend checks if it is
>>> currently relaxed and then calls it into hardened state via SIGSHADOW.
>>> However, this signal may race with the thread entering primary mode on
>>> its own, e.g. via a syscall. In that case, the thread will be kicked out
>>> of its suspension state by the pending signal, and the migrate syscall
>>> it then executes will not perform the expected suspension anymore.
>>>
>>> Plug this race by introducing two thread state flags, one for pending
>>> XNSUSP and another one for XNHELD. After having performed the requested
>>> hardening on SIGSHADOW_ACTION_HARDEN, we are now testing for those
>>> pending suspension states and replay them via self-suspension as needed.
>>> If a resume took place in the meantime, the state flags were cleared
>>> again, and nothing will happen after the migration step.
>>>
>>> Reported-by: Richard Weinberger <richard@nod.at>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Didn't check yet if EVL solves this topic differently or is exposed to 
>>> similar race. But given that Richard found the pattern even in Xenomai 
>>> 2, it's likely worth to check EVL carefully.
>>>
>>
>> Unlike v3, v4 does not use signals for internal synchronization, so it
>> does not suffer that particular issue related to suspending a thread
>> (no SIGSHADOW in evl). However, this issue is only a symptom of a much
>> broader problem both v3 and v4 have when it comes to dealing with
>> signals pending for suspended threads, and your patch won't solve it.
>>
>> To illustrate this, let's say (A) and (B) are Cobalt threads running
>> oob, (X) may be any in-band context:
>>
>> CPU0                                          CPU1
>> ----                                          ----
>>
>> A: xnthread_signal(B, SIGxx)                  B: core_syscall()
>>    <schedule irq_work>                              core_suspend(B, XNPEND)
>> A: core_suspend(B, XNSUSP)                    B: <schedules out>
>>       core_add_state(B, T_SUSP)
>>    core_reschedule()
>>       core_resched_ipi(CPU1)                  
>> X: irq_work_handler()
>>       send_sig(B, SIGxx)
>>          handle_inband_event(B, INBAND_TASK_SIGNAL)
>>             core_resume(B, XNPEND)
>>             core_resume(B, XNSUSP)
>>             core_add_state(B, XNKICKED)
>>          core_reschedule()
>>             core_resched_ipi(CPU1)                    
>>                                               X: <ipi-handler>
>>                                                     core_reschedule()
>>                                               B: <resuming oob>
>>                                               B: XNKICKED: prepare_for_signal()
>>                                                     xnthread_relax()
>>                                               B: <running in-band>
>>                                               B: migrate_syscall()
>>                                                  nop (XNPNDSUSP was not set)
>>                                               B: <still running in-band>
>>
>> Remoteness of CPUs does not even matter, e.g. with prio(A) > prio(B),
>> we might observe:
>>
>> CPU0
>> ----
>>
>> B: core_syscall()
>>       core_suspend(B, XNPEND)
>> B: <schedules out>
>> X: send_sig(B, SIGxx)
>>       handle_inband_event(B, INBAND_TASK_SIGNAL)
>>          core_resume(B, XNPEND) /* B is now fully unblocked */
>>          core_add_state(B, XNKICKED)
>> <IRQ>: core_resume(A)
>> A: <resuming oob>
>> A: core_suspend(B, XNSUSP)
>>       unblocked + XNKICKED set -> abort: XNSUSP ignored
>> B: <resuming oob>
>> B: XNKICKED: prepare_for_signal()
>>       xnthread_relax()
>> B: <still running in-band>
>>
>> There is clearly no shortage of possible variations of the scenarios
>> above especially if we bring up more complex multi-CPU configurations,
>> all of them causing some sort of breakage. IOW, there is a general issue
>> with signals wrt forcible suspension, not just with SIGSHADOW-based
>> synchronization in xnthread_suspend() vs migrate() which in addition,
>> has its own set of flaws.
>>
>> A way to address this properly may require to break an ancient
>> invariant, which states that a thread with any blocking bit set must not
>> be linked to any runqueue. On the contrary, a way to make sure that a
>> suspend request remains pending across a stage migration in order to
>> deal with an in-band signal is precisely to allow that request to linger
>> as long as necessary in a thread state mask, only to be considered once
>> the 'kicked' flag is cleared, ignored and left pending
>> otherwise. Meanwhile, that thread should be allowed to run.
>>
>> I need to have a closer look, but at first glance it seems fairly
>> straightforward to implement this in v4 at least.
>>
>> -- 
>> Philippe.
> 
> Uh... All of that sounds a bit scary...
> 
> There was a reprocuder provided by Richard on the list as well, right?
> Please make sure that we integrate a test case at the same time as the
> fixes. Otherwise the testcase might never be added.

Yes, I already asked for a reworked version (Richard and/or the AI).

What may also be valuable here is derive a test case that plays with
regular signal injections like Philippe sketched above. To my
understanding, that would even be (structurally) shareable between
Xenomai 3 and 4.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
