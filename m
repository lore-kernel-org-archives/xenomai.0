Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6E38BF6A
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575821; cv=fail; b=db1YEBl8Sm0VjrvOBM77hJdsnDlstUJSOj0wxQssouece/bU5Lwo8oRhUpe2fFI+2nSllhuG5ni6qpGv7OAbWOxdYCT5o+dbBUc1gXjLvfU9DIwpUUMU82Nus3nC8cSbghORh7EBRoWlMIUKK/N8bfHYZUguJVcTwOEHNQpZ7Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575821; c=relaxed/simple;
	bh=zHEX/N7Ld7eP9jcaA0yJZnMwRL6G2PF5SGB6sg3T+IU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJkO0mY2nZuH/bgC0duWQ3VccZm7AMUDip/2z7O0drL0hAQxwKsoyrbBZpjtCRybbzY67ZzPr2ao5nnzwyQDRTVAT1wxhBp7t2qR1b0lgrx5rQJN0SJvpEhB63oHmFrNhw9PsQJB5vharNmYFi+H+WZAOZOnHmxAGJI11Oe1bqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ISMu1DAz; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ISMu1DAz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCL1KAIPtinFWqIndpDUgYspAFirMSRjlcwFUfgsOAWQlqpbXig7hVuOM6bHBASuUX7FDV0ER20YfyLBu8Le7sIz5pfJHvVWAACmLCpKi97IqIKSeEpFHc9kHW3q68FUqckjAYva4b2qQvNHcd/a6Bgam+tdBCkVJ6WDsmJUnD6B58Kg/miiPzrXFMACtditSJI0AAVOKL7UVpApVuTqvdoVNuxrv/IOisUSLxte9y+gFr1GruXMjPTRQTQfqU/2K//SU2decBx609fvkVeI0vXOFzOyPGEnZcrra70QVPixSdFNeD6IPFuMu2I55+bhQi5SgAlziy9yy9T613CEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGphTWxZgmHi1yBMYKQOrPdZyEGjSkuqPC95aHDN0qk=;
 b=pJoYPWZlJA2i/0Lk86XvG5IccikNnVea0ZwF7er5jzaO8AhgqLi/6XaMLTWd8wI23Uz/eAm4iVdk5lPxETcHlqm2Zp3F8uKxMCdsumymuwHNgDTRq6wFeR8+6jMpZrQMyc8BIvSYTBeUMnCv0MT0g5dYri470HALjCHXdBaFdHe6J7W44FwwC7IFap6ZViOAC/aS99rqxROougLpBQtsTleQSMCfLNIhVUJ4wSpOsiMu3ixpSW1JVSgDqF9ehPductjA/Ja4aY+w+DDUlCWnTDx8Lz3X8WbNvCUfHlXZ5EQCtI7OdizrDC6lwLTHl0Luo7NuD+BPRBxQFzXiZH86ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGphTWxZgmHi1yBMYKQOrPdZyEGjSkuqPC95aHDN0qk=;
 b=ISMu1DAz4Kc/UED0if2ssVqf133szxlLRw52FPcAxynhF6hcigszZsobqfO538JaeHLRafCODl6mpCW87fe8lLLOsHqOVs7b9okVRZZNpA6DMpu0E3OpuHKool1Cney1oJTO6pv2CjjgWBoktYUPhp104X5qu86AC08jSkQScEFfNchftUsjKNbqrFr/g9OR4Hq12XEcGYY0KMP+6249xJ9dfq+iBMgbGAs5TXWJeVrMAi25aS22vxZnEBY9f04c83agPhdSGk9nlJJ8kQfKQLCyCJ2COkBg2tDhxvH4DUPe1LIVlpXAKHQj/5GlzcKVUaoQxmC0b7kJrBODzgJdfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:237::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:50:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:50:10 +0000
Message-ID: <94e64297-32e5-4818-867b-a8fa27d0c630@siemens.com>
Date: Tue, 12 May 2026 10:50:08 +0200
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
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3a2008-96f4-4064-47c3-08deb003790c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dxXmN0bMQPT6enqKiX4dAri4QOZIXUCRbdlq+lQhiGVe9OQJI7xnNUgE07/d4lwHMJXSEQaGMPApVr3Tsq5i08liCT92mIv45yNAF4t6tv56cBGAT2tDFfLXue4/uAuw2tAM/GNN+jQI3F4nLdz/W8OMvefE6Bj0J9cEDKduZPGozIiMNUY1+03QZ/qcbkCETvC0mB2FPQKF1089gMuKpJQWfcuZPbbSeA55foxqdR1TVq19oWWpMCAEsYRSxcljjE3wRPbqQEnvEBxkXxThLrkvWlilGSAhI8x+Vacz4XVIhHg0Huw3uEWkOfX+HcErI4nv/EHut2CxiWhUpenWGZe0vC7eKYSz9IA/tBoKDVBDG5G0ORF1EZGZGXx2yyfSyanNsmVe2K0alQOl55I9sDoLN7wL/Ozy9DYCtKfSx7jx6c9nzBbqmcOSo7JvRhshUWrN6JWy59NnGIhJWk8eHSZnUVf0k92T9T69CEDp6gexqhf/hK2CIcy2RjdaGy8UcwqhWu4/jVp9sJRHf0NbwEZT7UC9QgYQ3f6WfLsDcG/4ZM7Wd32Oh9Jrg02GdY4JWQYtrn7WlBm3VGUqa5VBMQO0HmGfDwbPP4Dz1LL/9Yxx7F0nLwA6PCxMYLMmVvQY7hVd4jclTFW8F6Sod4bcQjEXfXkBjWMBFSlCdzHcBBaSiofseFFsov3pulnvcy29
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TExON0NMaStja0ZUR0FPVDhwRE1PbktXbnFWZXEzQU93alpaZVJPZjFteWdt?=
 =?utf-8?B?aWsvVkVVY2JBOEVSc0VEa3BrSExhMTZIY3p6TmYwR082bWdQblM3Z0tpV0xu?=
 =?utf-8?B?Z003ME9hSzNYdjgxeGxDZ054aGk1dWhDdDNmdytKVzBKeWJOQTI3TEV2WUxm?=
 =?utf-8?B?N1hMTnAvcTR6ZmxsQkNvS1RRWll1TUptQkhtRkFaWS9XRVFrakRhSi92bStQ?=
 =?utf-8?B?SjhHWXBuMGFJT0Uwc2FaVHQ5TTlwYjRRb3FBUHJ4TzlBQVh4RG56YU1iVkE1?=
 =?utf-8?B?MFJFYWlpOFFzVElxRTM2a0lrck1tQ1RKaHdNRHZGME8zT1kvTHhDNVV2ZUho?=
 =?utf-8?B?Qis0eUtIeTJuQnlqa3dqUStvQmFkd3hJSDBhbjh2WXpuWXVCYW5oQ1hucVFj?=
 =?utf-8?B?Zk5xcGZNVzJyQ1pYMFIraHVFRmpTb3pBVE5KSXNiNTNZU0FkQVdNQVhjVXdC?=
 =?utf-8?B?eEM2UEZESTFBN0l3MUVQY2poSk5uNHkrdmxEVFlqWlpPcWlOcE5OWmk1YzhS?=
 =?utf-8?B?Q0ZEMXc0YW5yQTRGSzZ3aDRuelZmbi9rUnFTdHM5RlBPL1F6UCt5UDRKZ0FP?=
 =?utf-8?B?U002K2RaM1N4YVZaTmZFbEtycmJMTG5xbDNDV3dqeEZ4eVF0OGJkaXcvZ0dP?=
 =?utf-8?B?dGFSNm8waHNzYnBzcE51aUk3TXdQODE1Um5iT2lCY2JLNmh4TENmekV1YnJH?=
 =?utf-8?B?RDROTkEvQ2s5eGJmUFpmYjNZREtlVlpHWVNwQlFMY0YvWjBVWEJMYWZGK1o1?=
 =?utf-8?B?QzdDUEY2bW9NS25XMldFaGtqYXl3Ylg5YUlzRTV1L2d1Q3cxZEROcGxST0Vp?=
 =?utf-8?B?WG00VjFGVlE4Q3JQYzBubnBpK1orRHY4SHFJQXRKUXFZSG5qSngwK0t2dEhs?=
 =?utf-8?B?VU5wN3c4dWNjMXFYWDRZOEZPb0t6T2wvdXFBdTYyMTYwTWthOGcyQkRVM1NL?=
 =?utf-8?B?ODgrU2xNMytEOER2SEI1NTk5V2RHTFFQR3hFZlcvU2VHTDVQeEt4cHAzNEJW?=
 =?utf-8?B?cGt5QjlNSWdZeWJkSFlMZDR5cFUxN2lhSkc1UVhEbm5HdE93dklpbkVmQ2JU?=
 =?utf-8?B?RFRXQ0xaeUNhNXd3a1lhanp3eWE0U1NlSE5jQkFoS0VEL3k0MHYxTzN0SXNC?=
 =?utf-8?B?dkpEMkpUZlZiTHJnUEVIK1lOdnkvSlNONjdUOEdUSHlCbGtkdFozcEljWVF3?=
 =?utf-8?B?K3IzVWR3MittVjZjOXJNcFMrbWJhSkVuTDdBNDB1dG9seVlqU29QeGc2cERx?=
 =?utf-8?B?U0dmYmpzT04vWTRDQncvUWd3ZmwvN0tWZUZtQWpUY0J2VXBIU05rRVhDTTg4?=
 =?utf-8?B?Ry8xNTd1MnBCN20zWkcrbWtwM09qRlB5V0dXbktxR2l4OTBQRTIxZjVyMWRr?=
 =?utf-8?B?MEhQTkRERThPQ0R4aEZhelJJTk15QmNoajR3U2hIU0pMWEQ4UFBTMmQ3dDhQ?=
 =?utf-8?B?WnloaU5YelMyOXJqUVJmVHo1YS9qZUxBdXMvdDVvSjVXejVMMXFsbEk1OHBk?=
 =?utf-8?B?V0c0NWNMK1daUXZ0ZU5hODVQYzlCZGd6TFl6TVlMY0xlUlBmTkxKYlloSnk2?=
 =?utf-8?B?ZnIwZjVnQ2NIbHVMMjM3ZUlUL01pZHhxeENTM1dhSGtEcG9XRWNXOXZvejg4?=
 =?utf-8?B?V1d1Z3hGaGdMZ1NKZE56enVlbmwrVUxsNDdzSmVqa1BITDRFdE03Sk1OUzFt?=
 =?utf-8?B?QlZleDl4N3FIZFh4SlFwNW5QNk9sSGg4Mnh6T2dIT0Qzd2Y5Vkc3VGN5TERl?=
 =?utf-8?B?QjFFZmRweXJsVUVKc3U3YWRsUGNJZWV0T2txSld1SXZ3empERXhQUWkwNjN6?=
 =?utf-8?B?UG5YV1k2VlhzanVidE5PVjduVFVnWDJ3OGVON1VPNXhRZUh3dTlYYmRvVmsz?=
 =?utf-8?B?SWsxaTNLU1BITzl3MW5Cb1RjWkVTVU5mVkRMNTJhL2hlN0o1Z2wzRlhDcXRy?=
 =?utf-8?B?dm1HcTNibzNTRWJmblBTTnFjTGp0OXBUM0djemc2WWpoNTlhVmdwSzRzcDYy?=
 =?utf-8?B?UmhtdXYvRTZOaTdZcHc3Qm1VaEFHWmU0c2Q2aHYvL0tFUUw4MXc1V0ZwWi9W?=
 =?utf-8?B?bXd1SWxOcmt2QzZIOW4zVitZUWU2TElkdmVXSGt3RndXZTRSNk1jNFNuMUpC?=
 =?utf-8?B?WHZzdVIyQ1hkOTZ4ZjB1bEY5ZDlCTW9WNXhwcnRtUXlYNzBMbzhWUTJUR0wx?=
 =?utf-8?B?enRYaXMzUzRxeFR6S2Nqem5VY2Mzd2dFYkZMdU01OVZqdlQvekhkY3BwSndF?=
 =?utf-8?B?eFdSRHJCWnZxMWJjRmFuTVZLbDF3a3RMNFFZaTltb3FRZzdPdFhlelZGdWhB?=
 =?utf-8?B?UFJwS3psUmpPMVMwTVFEQTZ3TlJsK0htWm5DR29CZnlNUGY0ejRHUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3a2008-96f4-4064-47c3-08deb003790c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:50:10.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 384w5fiemyJUS0yCfVM/BuBOIuJf7LPimOxp5LVOUAS8/XAvUEp2u67hxPlLI/4rBFRurz9CZVQfloqxgoagbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8523

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

Unlikely, because it will completely confuse tcb->suspends, preventing
future suspends for the task that was not properly resumed.

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
>        /*
>         * Allow a thread stopped for debugging to resume briefly in order to
>         * migrate to secondary mode. xnthread_relax will reapply XNDBGSTOP.

Will have a look, thanks.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
