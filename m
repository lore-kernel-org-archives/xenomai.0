Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C23DEFE2
	for <xenomai@lists.linux.dev>; Fri, 15 May 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832145; cv=fail; b=KeZatgwLJeli6FLLmpFd3acrVPYG4PilffYqkDAlRxlRlW/5ZSHPxJhZoOMz/fVv/JNivTYnWzJWosuTsIvUK2NGOCDs3zEj0njKtbKvBL8gC57UuSv6WO1gPoykiqwls/Elx+yxQf8YBnrFLuql+camoBEfEIsG1DiergZbuBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832145; c=relaxed/simple;
	bh=jmaKueeJEY0+TUPMkVeHnr5OJqZf+lPk7a4JdNHO7Kw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g0VuLC8HGtVKBUz2tltyYAj543RZPIKC6zS3m+atpXs+sGwMfXceLQgBZiYYjLA60UoKzrB0sDj4Z+TmCHvwhW/tfZU/HaTdK0iawog/hwXeelObEnnSw5UQcg8X4Rg5DtdVJHnDdCx+NI5hH/v0BSnSYPWi+pwE4xkyRXmTEQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G6oyzF4+; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G6oyzF4+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyENGiBzzm98v6XxE0ZICub8UoOqrx6fmlCD7IymxvXgujA5WUh6t2OUrK/exE5hhCRb/I6tng/kV7Ar5+9KKsFpEgsBkKhowckkTgwCTp3lLGAOCYqWKtomiVsEtkzuOdDAi2MOiH8w5ncASGE7RD3cdAnK8kMwsAukOQMxHaTN05iAF86+SYqvzZLqEGbHoDW9UgE0T29FZG4ZT6O4s78RBVdvM3hKGqRSQmrGPF0GPT1++/l375Nj28AG9hipSjTk5Ujxd44FV9hXyMXzXn/wWTTvvGTkZ82ch3p8fPeZKDD8DgD7nf4A+nDOwIlqbW1CcLYsWSYer+uBkpsO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zztQEvycpxSAore6Nroctso4RxaNZXOT8mSxeBS7tlA=;
 b=qU+x/hgVjj19xFdWlovPduwKbD7NuTWXfYOUxuZ04Q8JhfZ9AFkasxJ9gQp7embFavSMVYQcpPKhC52XweEGIFYikf8pSpMnQFczR77W/OYhmN5GaWNrqeZ6PUcH5/KYtNUiLlUGwLA3JnNlyUcusiCMoGGWJofjbY3h3NARG618aJ6xYnjZTQL3nQ6DK+0nHaoIRdVZbJwZ0m6tSiKwF+FbS0ZxexPdLrXgFoAI003kbgKsAWJWRZOnnpATv8vsJEgpjdjVORiax3/gqmPhOtdjHseTdHTHwYX6Jb4ynRRezIRL9DAETyQo/jYxCXEPGYKfXx6INyw3PCEoBycgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zztQEvycpxSAore6Nroctso4RxaNZXOT8mSxeBS7tlA=;
 b=G6oyzF4+0RSqt89Bb53t3n0VqobJvl8EuHoZlHEMsVARnzaUooB+dGjG/mwp7uHXmwC1nVJLflv5R1DprXV0yUVYSPMAz0GmwTKVPz+/DOiKgMqCWnOt6+7ONIkTTzs+8ct7PcI0YfzwIBMyxZqb3f+oh65Ctf3y4xa/jtMsEmfBbXR110wGPA5wgtCswoPArFGnmmK0u/5azy6wKzk/zOckrI6hmt1zfUzvbcB00+FpeyL2FhRajRq7kJYi2lFj9kzGFzNow9/GALGlBaZ2FBKcgDnuRpPg5neNagsuw4IO86BT1cUqp0YuvMnrK7DL0Sg5QoPlEHxXSvx3SNXcfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Fri, 15 May
 2026 08:02:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 08:02:19 +0000
Message-ID: <13f31041-c0d7-4e4a-a4dd-74d9aae99453@siemens.com>
Date: Fri, 15 May 2026 10:02:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious task resume due to SIGSHADOW
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
 <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
 <3077e418-741f-441a-91d6-a07ec6c8f2ed@siemens.com>
 <CAFLxGvw+YkAdHC5HeqcAZJ5aGpm9tHNYO7+aoguHDPaVcAwAQw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvw+YkAdHC5HeqcAZJ5aGpm9tHNYO7+aoguHDPaVcAwAQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: fd34ebbd-9a68-4476-e5e7-08deb2584960
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|11063799003|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Fh4lXqaAq4NzInaelsS1ctdk5KPXbw29nO42RxhnZszgurMWpHbEOwdfDAIMV2tIW7uEhmz7GpyNp+hiTohEBnLl6dpuMTTbaPWpBWaEO2/i3LrvToyyyClEpSv+4aOOUWP2vO9NFoIqrGc3DogAwzotHC0QLDVhR/lm6j8R3Zd8bsZvqW64LsJ07r6Uz6cWynk0waQZwFSb8otBhHR7SOrNWvPLDb1Q4TYurNyg3jGwrt+DEC2c/HA0j153gZyxO5Lk2TfXbuDBDQT2e8Otz7Kyvg6tls30mPVhq/8wsa1iw0FFcv0e7/rgswIeH41pe0eBaKEnd6Reqbv1LjQKKUmv4FD5ari68qhjT2iP6XpWNgaH+5txjaGSGDlb1pofISyg5zbLixlOT1ghoiP+GDUJa64H0z+DoboWDmtdSbQTlWdqt4ewC3xWCAGoTpndMUAz0Jo5uynCtA9D5wskE+caoBGPTiWXQ76ukT/uv9Awyh+/3+DSFl8rR0KiIuQ1MAhh0tkaW/Xgp/QnBFnxn9lF7o7nJ3v9tU9u9/ea7yRlQ6CgP8hsA7WSB+iUCWON7PktMC+q0bu0PbJJjgZV80eIwEGcJwynH1rRUiMvHEH2WL58Ops5PbQeG7L3XdR1kSS0pzjf+cK68GWgOn5uaX8ALdwqWYykpbLo8ALwPKTelIC3hGtJYWU/SQbX9P+8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799003)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJxRDdFdlllT2tJQXFqKzJiaFFNbUl5bDFJRTg1NzZHd1Myb2FxSjVyaTBW?=
 =?utf-8?B?QmVUVGI4OFhBWHdkMnVjU3V2Ui85S3RURnMyeXNRd0NaVGQ1ZUVEcG5VTWlV?=
 =?utf-8?B?V1o4UVl6TVBURThESHNYN1BTU0V5UXEyUjRXb1ZYQnNrR25mRlZpTmdwSTNu?=
 =?utf-8?B?RFUveUZ2VnZXMUxYNW1jOWhuYm1PTi9VT0xWSVdRNWdQRXhXMlZYOFk1cXB1?=
 =?utf-8?B?eTA3ZnZWZHoxOFJkbE9zaExDMzlRdEQ4Y0FvRkw3QloxZGVCek53aXFlekxM?=
 =?utf-8?B?SlJQQzdCYUpCVmpxRnhYUXU2YlBWVXlKcTlUNXpvZ1FjZStud285YjVycStZ?=
 =?utf-8?B?dTNwZjlYVlhYV0o1KzNHeC9UWUVHWnhUVnZFZ0taVnBJU1I0MlE0RWQrclNu?=
 =?utf-8?B?QW83b3lKc2VmTDRpb0F2U0hPekx0cm5UWkNiVCtRTEc1eWpDOVBiQmIxVXlM?=
 =?utf-8?B?Znp6Mk9kL1pYdW42RkdITkhmYXZPRVN2T1N0S2xhcEN0Qko5MXJmbnhPWXBP?=
 =?utf-8?B?Y2gvSkN0L1hvNkVlMktJUjhPUnhwdVk2ZDFyUFRCWnZHUklyckRraHVxakx5?=
 =?utf-8?B?VHYrR3d5Vy9PL090WHNwU3V3Vi9sNlRWTm82VXBIK1hvRVpqbjFCU0pWSmtU?=
 =?utf-8?B?bFIvWW9kV0F5YWVCUXlqaWZ2ZjZCeVFld1VzSE9TY3Z5YXJKaVd1bUI2YzNl?=
 =?utf-8?B?MGNydTdvYmZwb3MxSkZ1TG5DUEtpQi9IdCs5Zys3aXZUNSt2a29pcmVNNWU5?=
 =?utf-8?B?VFBuQ1VnZTdJb3RsSzBVaE9jNFJDOUdDazhxbWNxTmJ1TS8yVWR1ditJZDRu?=
 =?utf-8?B?dS96blZGdXRsU05KNzJRS21JUE4zenFuaFN5Nkh2V2duaFVDL0V1ZGNQaU1U?=
 =?utf-8?B?aDBBK0VwMjREYUxtL0I3VTQyYTcyUTlINC9RU2NPTGEycTgxOG1GeGhZdDZq?=
 =?utf-8?B?NTNoNkZQdG55TGU5SjJOTk1oNHlVVG9zOE54WEtWS1NMKzhlMk5OT0gzRXR0?=
 =?utf-8?B?b1dQNjZXOERpUkxqQ0lUZ0hsRXBydTVZNFd3dzQ3aXdOYkpUVVVuZFJseWp3?=
 =?utf-8?B?eFFVRTEwS3IveUxEL21mR3NTMG5peEFmaVZ5VUtpRW1NdjlLWHNYcEdxNWg1?=
 =?utf-8?B?VUR0YW40ZmxNVGV4a3YwWDM5RXVwZFNKNFN4TEJ6S0krdVFPd0oxOFk5cGdi?=
 =?utf-8?B?N0h4QmdMQVo4amNydDRtTy9lNlpIWFBYN3Rtb2ZOMUFpVEFTMWtoY3ZtYTdr?=
 =?utf-8?B?Z2o5TXhDckVaRDAvcDFGVHdhUGtzRkRGV2xNRkR4UXQyMlk3eS9xNWh0ZFBV?=
 =?utf-8?B?NTdEaUJqR2ZoQjh5c09TN1JWVW9YU3VVaURLWlBXRkdrSmQ3b3c3dUZZekZC?=
 =?utf-8?B?b1h1cXFienJoZjdPVkdDVmtabjU2ZUcrODJkN0xiMjUrWlpwTk1CdVZReTNQ?=
 =?utf-8?B?V2wxSzZGS3lCWDdZVS9lQlN3a3hwWndpV0Zib09uQUtDVE96WHVlYUhKSEp0?=
 =?utf-8?B?b25ESUppcjhDdUtpSWIrSHlaWFIwOFFWM2NnNHhJRXdOYXdTSjhVNjh2Snpp?=
 =?utf-8?B?cjVjR1oyKzBKcU9oNE9zQjRJM2tCVGFLRmF4U05sVTJBVkhNbzhMQXlUeitP?=
 =?utf-8?B?N29iVElKSXp4dG44WDk0K3VwTW92YkJUaHRGTWwxZ2pDeElrQmgrUXg1bFBP?=
 =?utf-8?B?Nldsd1FNRGNkdzhPZU9ubythZmZBUG9USTh4cThrUk5iTzloSU90L0g3czkv?=
 =?utf-8?B?UE5INHpmNVppUHROYjZtMVlIemZXc0JNTlU1SXJ6K3NWdjFLTHg5L2hteVJk?=
 =?utf-8?B?NmU1TEh2TDhGTkhEaWZIbEYrMm1JL3pNQ21kQmRwTGxvaFZHSDNRSkJsWmwz?=
 =?utf-8?B?MHpGR29VTm9qeFgyT3B4T1BKVnk5T255RXJFNGFsVUoyaTRIdGkzbWFHYUR1?=
 =?utf-8?B?WG5aaFh1YVc1ekdsRFc3cG5lcVBpRHFWQk1ncDdBUTdSbW1zWW04ZEFBSGNF?=
 =?utf-8?B?Um5yYmJqZXZJd2VkRHkycWxDNjRmbkVBTlIwbFBreHEzVlorUmgwbEkzdWF6?=
 =?utf-8?B?Zy82SkRabEdnZ2w2VTg5b3dwMkZaM01uYXM1QkRjdlNaUUtsWUc0NFJ5VHRt?=
 =?utf-8?B?K1BQbVk5akkxUTlESGtaeEN5RXNESlJ4d1o1VHdBK0tad0JNR1FncFIxem4x?=
 =?utf-8?B?eDc4NnNMaUpiZWIzT1k3UkZ6SXI1WVR6eFdub2NJS21JdWlNdU1VaUNFZzVt?=
 =?utf-8?B?UlJaZnVMQXpJVGhoME9MUk5ZdXVTVDhUN0crb0p3QXNFdm05S2UvNStaMjdP?=
 =?utf-8?B?VENDeXBubWVuUWdNTkpSZE8vRjRsVy9PNVZyM0cyVTZ6Mis2NlZ2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd34ebbd-9a68-4476-e5e7-08deb2584960
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:02:19.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wko1Zvnry/DTgkRcxNw2jLioRPccybzMzmqiJCnqwwDiKg6ivC6y9UL8K760DVXmO0UCqpLvVPkcEU8cjtiw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6897

On 14.05.26 13:08, Richard Weinberger wrote:
> On Thu, May 14, 2026 at 12:00 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 12.05.26 09:19, Richard Weinberger wrote:
>>> On Tue, May 12, 2026 at 7:50 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
>>> index 7402e2ef6..d72c3788b 100644
>>> --- a/kernel/cobalt/dovetail/kevents.c
>>> +++ b/kernel/cobalt/dovetail/kevents.c
>>> @@ -145,6 +145,14 @@ static int handle_sigwake_event(struct task_struct *p)
>>>        if (xnthread_test_state(thread, XNRELAX))
>>>                goto out;
>>>
>>> +       if (sigismember(&p->pending.signal, SIGSHADOW))
>>> +               goto out;
>>> +
>>> +       if (sigismember(&p->signal->shared_pending.signal, SIGSHADOW))
>>> +               goto out;
>>> +
>>
>> None of this will work, and I'm afraid your approach that you shared
>> yesterday for retired Xenomai versions will also fail. I played with
>> something even more targeted than the above, and different scenarios,
>> e.g. task startup, were starting to lock-up. No surprise, we are
>> breaking SIGSHADOW here.
> 
> Please help me to understand why this approach is doomed.
> I fully understand that unconditionally checking for SIGSHADOW and returning
> from handle_sigwake_event() is wrong.
> The check should happen only if task p has the state flag XNSUSP set.

Besides identifying the condition when we should act here (you
practically cannot peek into siginfo), the main issue is that the signal
will not be consumed but just deferred. This can easily cause confusion
or worse things later on after resuming execution again.

> 
> What race do you see with the "fix" applied?

I didn't debug further, but the issue was that your test case was no
longer starting its tasks.

> Maybe I'm focusing too strong on the symptom that a suspended task wakes up?

Yes, we need to think the suspension/resumption with all its branches
holistically. I've tried that, and will share a patch in a minute.
Spoiler: There might have been another case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
