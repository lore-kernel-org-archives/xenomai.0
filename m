Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A437F014
	for <xenomai@lists.linux.dev>; Thu, 14 May 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752839; cv=fail; b=Bwfp4D9r2tim+rPmQdraa/N/jKOwQfFeInIIqs+kTtQzVykxaARwV8QomeS9qM8uyBbNbZgjHIk+btxngnswb2eDlps0rClOGP0uY0BHz2j4XeKpJbK7UcsuP69Zt1WrknYUim1cX0mmq0Wr4A1m4RzCkVHQbL73SEerrjOkqTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752839; c=relaxed/simple;
	bh=VglfXUFKF3AFLruXeMcSftlEz2d9++Pl6nvA5vVSMH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jykb5teKREPg/TPYTFb2BRuv10MJGLu5T4jluv2AWgGFlCpffGkIwUh+iptLCkBrqkWiSiYE3tHQA95e1jN6Q+8VMw7mswUzjP7IQYzCKfGx09TqBBo8hV3Af+WQeUbqhPNnFq7qdzC+/MiriBsinuLb6+F4K3D3yTayeERmekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dQdGBOHD; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dQdGBOHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMkQSYPIZitfTYJ+rVDr3245sLD9l/tr45QbKACoEx/SckeuM5AYzW1bX3+yQFX7P54jOji2+pUdGcscfP7KFBj9YSIp8p4F/hsaBDEhnexeWMFEzSgrIKvYd7VsRnKGbjMdB9i1DwrIju85bPL8IVc4alJ4Z1FVIqbpGsaYldnUTwN0Y2LXmMPfaI3g+Gs+2ibEhjba2zN0TYJUhjoB/FaIpzKv8gmd/melVBrb/TrMOqF9sZaJ8BTlFsucqv8nlbEedUKf6+TluZHDZOrcTJAfuePu4lbDdNYP7kKrE9KrPSPR986pknXUzzLOid2DM3OuzAllBJYAqdORAIR7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipCbxrzgfXzYd0lfPlSQQXxXXtznFHgNx4Z+XvaAVP0=;
 b=dxCQ2qMhBIzrVHUeAgUJIbgeKehnXT16lh6Y3uZKyI0U9j6CaagrDKbbjv+mAQTDGYz89q6dIN9VeHaN1BJ1ibbCkG/QjMz0oUU8CkIDg4Wkuw9FFqbGdqd0vMSYVdfAq1t7bgvNzd/mpBDQcQiTfOLCPsordkBy808ihateJX7UQgei+izEKvTs+drRfptr1NqNMG511bHUQPbFCvpfsirVgpIWm4sWK+x/S2jg4o/usgebsTrQ38SOJLLeO5HlyVS//P103ANu94+cQ8jPjaIvMtvZJ8kyas5tD1VqL9FIDDj4S/tw/nAg/gQX/5l+YF0qiG4zkdhJ25PBxUJhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipCbxrzgfXzYd0lfPlSQQXxXXtznFHgNx4Z+XvaAVP0=;
 b=dQdGBOHD7OqAfkKohfIoD4gLoU5gwWfttzs0NwhT89x67F18QfpewYvWuxapqzSRn3Oma0SFyUFYOlBHPjzK5fO0DyVelumooEdXWkoPllu/ikWdyokVMEIARAHizMzbZZgxfMBZFxoIdZpZbmvTmJbIKqctrze0cILbPy/3IznicU00hOSkpB0AFAXCV2dpuqmR8/R2Sj5u1bZFHFpGmyJZgDYru9iokDW8NUtwjM1T72/lFaGUE7fVQCNOJCVbBRw4xEcte4gXF0nJbFpA5WqQk+wE389RMMGk+62MpJRUKsrk1ZAniZeO+p9NxK8M9IeQwM0irf3hKgR1PEuVJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 10:00:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 10:00:32 +0000
Message-ID: <3077e418-741f-441a-91d6-a07ec6c8f2ed@siemens.com>
Date: Thu, 14 May 2026 12:00:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious task resume due to SIGSHADOW
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
 <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de46233-c01e-4527-e72d-08deb19fa296
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|18002099003|22082099003|56012099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	1l7pK8YJYCh43XVnhrNxCcSCc9rJkaJ46p59QoLC+w9sSmUNNKhE9ubG8oz4q76PjPid1pNv605zuu5dvsGi4pUI+K5qd77cmBrFTCiCOx7Po8q7lb/+97+WcKQibaPuO18IdILQVukoKMMR7iHIR3Yqh6Q7DSDbo4/ClhM1NDrjQXGKNqLJm8iKrSLC3pwvc2KVDEK3a5jZkmXmTpPxOskS+bMQaaSrpojJ380DnoJYvhwb/ZVBH6OkQVUCKIRDDSbamdetAEzOY6uEkCa0kiA0gMpfBmxdbhP+yW1j6UQ924A41NfcR36XkQzCBVYiCDMH0wkD/HzBKkfNubIS7YdgiG4qE+6z0ZNaVUjVKl5/OJsu65YuzZ1X7mUbSRDuOU0IV4dnohFgyAAoY9jl108RYHx5QU72Ffmjb7lKDiHJakWiNQWZct0scNIBXl1S36QTTtdaFXnS/0KJ2U6mXJ4ytO4MfIPEbV27tXUc/Mkqz5tnLjMwlnxT+sj/4rmqWmqsVjZ8hLn6j0oOCn7YVyv3Wt0ENRx5fWLalJyT+5r4urGGXvLHuX3P+eLAqTnwYd6R0DYKXj3P5szy+rfDDDgDXNouEkGrIj8mXib/yB5R0KIlBeg8QkxipnFzDPVHXEBW7TuFl3auZ2hnUWYWjbXR6+ma6y4FKpPN4jAdLgqNr5EPNO40zUm9VKvvj53D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJyRStpVkRWdFF3Q3cveUg5MUVPMndQejZncHA0eEV2SHBDdTdYcVozZEE0?=
 =?utf-8?B?SCtkemNoQ1pKTURRYzdMRHdmMHNqMlBLcThHT0dKc1ptNlFzNHdXVHVQSEVU?=
 =?utf-8?B?MWRFR2xiTkZiN3VtckxWQ3RYVnNCYnMrbmxRTllnTnlzNUlVOEtrRUhOM3F0?=
 =?utf-8?B?K2pycHdEQXpFRmR3UG8zTlhwaGdGbHpabUpQc0RFQ2JiNkZ5UDNqay9jMG9l?=
 =?utf-8?B?cnozY1ZQK3VhUGtmY1JnVFBUdjlmZSt6OGs0dG5Ob244ZlZ3dmlIRXAzVTZy?=
 =?utf-8?B?VnZoampLcWRKZVl6YWR2TSthVVk5WWNRc0NVNFFOYWlEbkpGeXFXa01DZndu?=
 =?utf-8?B?RHJxTEt1Um9mUi83RXJMSHJBVURJUW82YXMrUDJoZnRvZW9OWWZQbVNtSzZu?=
 =?utf-8?B?Y2dkcWsvdlMyTHdwS2s3VHBrd21yOUloN1lKRm04VHp5dUowZTMySDBBTHpa?=
 =?utf-8?B?VTBIRmtPdmFIZXVMQ0ZvTHR5ZnFjUE5mRmVhQmhocTdYSkVQVmIrSEorc3JY?=
 =?utf-8?B?eWplUmp6TGVOZjhESlR6bXJjc2lkUmRTNVRRVlE0Q3RNNk8xSHBPYkl2NUxM?=
 =?utf-8?B?RnZzTWhCa0p2MVpaQ1ZORE5YQVBINWZLVjlSTVd5eldrVVJybEFDLzZISzAy?=
 =?utf-8?B?ZGVlTEJwQXZTdFBHYys4NW9uMmhyN3hCejVjM0lnc3didEpIbXdCWnFQTlRy?=
 =?utf-8?B?b3VzVStsRUkzSWh2bCtjTGtBc0J0ZHA0R3NYejJzQjhlcktsVmx0cDZjQjlB?=
 =?utf-8?B?QU90aEIySllmRXNLdTBiS2lRYVNKUWZ6RGFSOUNrRDRHRVhSVFBsZVJlOTR2?=
 =?utf-8?B?eHB0WFoxcS84MEFZQUhYNXhxSFFHK3pkcUlXbnRKV0xlNWUraFRpM2l5WkVu?=
 =?utf-8?B?d3cwS0YzS3VjZGdTSVhMSHNtR1Q1ZG56Y20vZ2F3R0Ryc2d2SGxVTm9hdUhy?=
 =?utf-8?B?NkkvQjhuQ2E5UFFtdWNLdENOMmdNbnVFT0pKSXRpTGJYZlRwaXBVKzZJM2Nt?=
 =?utf-8?B?a0VGODFTNjdkQk96dnU4MkRBcVE1U3k4WW54eXRLZngxb0dVbGpvNGpZRHVs?=
 =?utf-8?B?b2krbUdDYjNyNXVtcTQ5M1d0Q0N3ZTE0djJqRXFoZHlHOXIwKzRrc2JLZ3J6?=
 =?utf-8?B?L3JqL2IvUWxXY2kvV292TVBWTC9obm1PNy8wWjZEZDlmMGFSUDV4Y3p1ZFJq?=
 =?utf-8?B?QzBVazdoWkhLaTZ5SlJ0QktYRnVVa1owdnhrcmxsZEdubVlXdSs5N2M2b0Zu?=
 =?utf-8?B?WnRUK0F3RDNVZDNVdFZsZ2JPa0h1VFdkdGJCNUtkbysrVDVyOUtYZ0Yza0pr?=
 =?utf-8?B?U0U3ck1xNEI0NnNaL1ZWaElWQlNQbXk4Vzg2SjFLQndRNnNNQmVwSVBYRUU4?=
 =?utf-8?B?NVNmS2EwYVJUKzlyMTZZVUI3a0xMWmQ1bEp3K09jaUdrbllQQnNtUld6V2hQ?=
 =?utf-8?B?MFk3M092OFFTNTRmSTFhMkdyQnlwTWJDUWpkNFlKU2RXR084ZVZHUVQ2NW1X?=
 =?utf-8?B?NG5sellzRHhzMHIxZjVXcWk5aUZNVnRUL3A1ZUREbk5jRlNwUS9vOWpwM2lM?=
 =?utf-8?B?SnVJcjVOWGVDSTBVM1FWa2Rzc3RIOVdoOWlsNGpqNkQxUEgxNTE5NklyV0U2?=
 =?utf-8?B?aEdOQ2lKcDZQa2Z5bkZsY2doUGVGNWJGeEhWWkVIamNXdWZsT0hacElQakpY?=
 =?utf-8?B?LzJZZFphYW5XdHdURFBmaXE0VkdMS1p5aCtKOE9jQXJOTFNweUsvSlc2ZDZP?=
 =?utf-8?B?Y0N3aFJCY1FieUltaFMxdDN0VytpQTNtOXlGUnpHYXkyTU1XRVovWXpvTmdp?=
 =?utf-8?B?dFFDekNLdVZxRjJYd3ZJdGE0MS8yWHJBanRkTFhTcXF3bzdxdkx6LytOTmhS?=
 =?utf-8?B?RFlNU09QSm9kQnQxVCtWbzNrSkJVZUUrdUhmcGxSK2tMY3hPMXY3YzVUV2tj?=
 =?utf-8?B?M1pwR256Wk04Y2ZQSVRQZnc0M3hnK0hPcVh6VTRiZi81cDJmbGNFUDlpdTFy?=
 =?utf-8?B?Uy9tUU9GVUVTczZITDMyUzVzR24vZ1l3a3VpT0xXcFNtQ1NMRkdIaFhWRVpH?=
 =?utf-8?B?Y2ZSRzBWQ1FrM0gwYUMweWZlQmdwZmhRTHZyVWcrcnFVejQxUG5xL2ovUTlB?=
 =?utf-8?B?MWlRQ3hQZkpUUGx2ck5wQXpZZUQ0Q0ZQTjZ0L2h4ZVpKZkNtYWVrTDRDV2s2?=
 =?utf-8?B?NDRKZ3lGVW5QRGhidEZmYzhqQ25MN2MyMUNGUHlyZXo5a05jNXkrTTV2Y3pa?=
 =?utf-8?B?REhWQ3NkYVZYQStobzVHYkZRcHFCcG9GYlNQRU1wMGZaazJzN2liZXRJUFRa?=
 =?utf-8?B?UW9Nbi9ZcjdlYll1cG1PcnBOcVdaeUsrKzNFV3B5VytDb1pPT1VoZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de46233-c01e-4527-e72d-08deb19fa296
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:00:32.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojOGmUqRl4KGAR2eA3N/OBrCek+loKN+WpLLG3ZcTXCZqnsJpRL5rzmo2YBLTBCS/uDrbxVMOjpmjUo++Bmczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7412

On 12.05.26 09:19, Richard Weinberger wrote:
> On Tue, May 12, 2026 at 7:50 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 11.05.26 23:49, Richard Weinberger wrote:
>>> I'm currently debugging an issue on a very old Xenomai system, while
>>> reading the source I noticed that the very same issue could also exist
>>> on recent Xenomai releases.
>>>
>>> What I see is the following:
>>> - A task gets suspended and unblocked using rt_task_suspend() and
>>> rt_task_unblock()
>>
>> This is intentionally rt_task_unblock instead of rt_task_resume?
> 
> From what I can tell, yes.
> 
>> Because:
>>
>> "A nesting count is maintained so that rt_task_suspend() and
>> rt_task_resume() must be used in pairs."
> 
> The application has non-trivial thread management, from what I can
> tell, it's fine.
> 
>>> - In some cases it happens that the task resumes to execute
>>> - It resumes because a Linux signal is pending, being SIGSHADOW
>>>
>>> Since SIGSHADOW is internally used to suspend a task, this alerted me.
>>> So, I suspect the following issue:
>>> When xnthread_suspend() fires SIGSHADOW using
>>> __xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN); nothing
>>> seems to prevent the case where the target task enters the primary
>>> domain right before it sees SIGSHADOW. In the next step
>>> do_sigwake_event() causes it to resume instead of sleeping.
>>>
>>> Hmm?
>>>
>>
>> Traces to confirm this theory would be good. But it could indeed be
>> problematic that the target state (__THREAD_S_SUSPENDED) is only tracked
>> in userspace where the scheduler has no access to while waking a task.
> 
> I think I found a reproducer. See next patch in this mail thread.
> 
> This quick and dirty change seems to mitigate the problem, but I consider it
> a sledge hammer:
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 7402e2ef6..d72c3788b 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -145,6 +145,14 @@ static int handle_sigwake_event(struct task_struct *p)
>        if (xnthread_test_state(thread, XNRELAX))
>                goto out;
> 
> +       if (sigismember(&p->pending.signal, SIGSHADOW))
> +               goto out;
> +
> +       if (sigismember(&p->signal->shared_pending.signal, SIGSHADOW))
> +               goto out;
> +

None of this will work, and I'm afraid your approach that you shared
yesterday for retired Xenomai versions will also fail. I played with
something even more targeted than the above, and different scenarios,
e.g. task startup, were starting to lock-up. No surprise, we are
breaking SIGSHADOW here.

The fundamental issue we need to solve with remote suspension/resumption
is the asynchronicity of the command vs. the pending (and
non-suppressible) signals. One idea I had is to use a separate
SIGSHADOW_ACTION_SUSPEND and perform a self-suspension instead of just a
hardening. That works nicely for resolving the issue you found, but it
creates a new race between this pending signal and remote resumption.

We likely rather need some additional state flag in the thread to encode
"suspend is pending" which can do the right thing before a thread is
returning to userland and can also be cleared from remote if suspension
is lifted quickly again.

Did I say that asynchronous thread suspension is a horrible concept to
implement correctly?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
