Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DF46BA
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 13:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMrgYw3bUs4Vy75jGH9jK01jk+xeUheWvyPVoMD0zOdA8MbEanrHeqZgy9aAlqQWkymoCbwbark3GaXGdbBB7Wo0iEQ55CzK2V40zj/Yj/hq6Mo9/SZz78KSj4Tume4a7y8GFmQ6o+GWMbA8Eb++v6Jgsob4x5AqVO9WWc1qWya/nHP/al9wk4Gj3ob3u5quK1zheCoi9ixT0MoWGWc9x/fW7m+C51FD2PmPYmcSJ7+cLGSIMr6QNLkecw521gjo9DYoFW0ashvlv/O6h1qvQV7N7ZUn9yeCGaicMppmRaIxyfJWbxxf03SgH6x6ccfOl8AE5n9YFM5oPYwZNlQXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw/h7mm+WTRaIsqMUQFkINJarz8VBq2w24lzzT4nPMI=;
 b=TBn3vwQTIRMGaUzd+p0szs9nAqVri54NpTB4fxMzVuy2gyGe/BR+o87Qw5eB6YEiYq8kmzc8CSPsN3VhKr/3Q3O+BWaNmkTiGUwwE/Eme2KMfKkOZfTQSHqqflG9uBhYMQhVYpeDlnsuxQnZvVNVtfbmxxmVOI9aGY21aGnvqeDEPDkd/IcswAkd5fKsO0D23XisJd9as1T4TH1El2AK3QinA7jcavS7Fe5GE5j+ie1yFF7siLNVP7+f6vnHbi8pI8wjqDlhbhE++Wx536AkM5pvqcQGK/5m+M0VGHXYjPzQOIetcCV2my0D4S+XMtW70yaLa9sKaTmGIbiO5VCjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw/h7mm+WTRaIsqMUQFkINJarz8VBq2w24lzzT4nPMI=;
 b=cOrvQ+iROnjsLT8YzweDhljUKohJnsfKnO85y9O3EKUj4gaclT9jI31+FTasjqhOtnpAkg8q7TCpvAKHkhx7is/2PyZ3Za09+/jCfctqcKeTAucMJcD40Jm2QR1l3U8f2NnpfMJyIB1JjU1Z2uf/8rt1IOovy6x4MN1HasksdLK369WoM1SiI2ub0HDQif++FZTKEJVn3cQnMX73/H96NGWjBWMPHnfWjHdXA9UV/OG+ceuXviyR3OKFx/oHDIs3EHY2JvYf54KR4IhdsoUtnU43n8i7DpLYeAfcGAtCw3jyuOSP94IDwpr6WDyjsBUsCM31r+O4pi0O/sr4GmFlZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:04:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:04:52 +0000
Message-ID: <9cd49fec-3f65-47c9-91cc-d13754e29d94@siemens.com>
Date: Mon, 28 Aug 2023 15:04:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dovetail: Fix undefinstr/break trap handling
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
Cc: rpm@xenomai.org, Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20230825125844.588598-1-florian.bezdeka@siemens.com>
 <ec37174a-39fe-44c7-82a9-342b95682f81@siemens.com>
 <92c6af9151c4b3d2a1737484487ff1ea55e5f131.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <92c6af9151c4b3d2a1737484487ff1ea55e5f131.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 327dd36c-0b89-460e-3731-08dba7c75e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rqIC2bHKJnC0YWQ0K1fr4KxTMFjvv467CZD/2cmW6I3qDTpWrPArfYNhEDamykp7xmc0t41oEmn6cGnA65po/UxY+pkW8+WsUtXA6AAgSi3GeLJV/nKLLw3OT2hjpcR5zeVRyaQ8rMHdVFBckmvUN+icAqlvecqVwjCHWu7fcsI7wlukNjfqK+eh0xmLP7cHu30H6zB+TxAFV/WA0aDG5tc+pyqCMLYD0A6qJz7KguLSb6LNfq6wq1K7rvVQkaQu2H+xzOW+hspuyRBWKsQNz6p8QoR9c2Bt4/nZun7k3Bezr+QHuyAeiTapRqT4HDsbbmaahgEfOh2ekCqg+zIZroqELXojVFUuo1CRpiHt7aCoAZEAvEI8sKolE14XUyjl4bU4i0OmAjqMi8ke/JZZNfD3tsTq8QlbOZAoYJulJgVGpUb/YfDCQ9IVx8MtfdnDsNRoUx5w5jVLZLxCrCNktaNhK8L54oChWWFF3XcXy+WmAJmXmxBD+6zALNd/mYIkHiNB7u2+1oE6H2gVVxdzF6LsJ9iPJgpMuo2kds7BQVKm1MIVv4MvO6m4xlhrUjG7Kc+SSPZZmxvKhvmce2v4IiSTIjUDdL0SXiiZx//wkWVhXDZ74DPFEzK8wlVu1lz/575ZRPT4CQTEypH4NsCgyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(84040400005)(451199024)(1800799009)(186009)(31686004)(6506007)(6486002)(6512007)(36756003)(86362001)(31696002)(82960400001)(38100700002)(107886003)(2616005)(2906002)(26005)(83380400001)(53546011)(966005)(478600001)(110136005)(66476007)(66556008)(66946007)(41300700001)(8676002)(4326008)(8936002)(44832011)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRBMjlzVk1VOWFGV2V3bHFjR0RrcmlobFVIR1VpeU1LOHNjYk96Q1BiZVp6?=
 =?utf-8?B?elhTMDVZYlg5THJuVm13RG5SRHpDR3poRHJIdTlTZHJsUGlMYzZGQWZERUdM?=
 =?utf-8?B?NVB6V3Fwc3NaTkZZZTZYWWpUMXZLZ1VEdHZtNDBrbkZHVzdPRVMwVENZUDgy?=
 =?utf-8?B?cTNGU0tRNXk0bjQrTFMxNDZLK1VkYmpQMUdOVmE4NWhtM09rdnphREpYRk84?=
 =?utf-8?B?V050MjRLT0k1cmQyclgva0ViUWdWMk5uNlFVSUY1WEQxUTk1UDNlaFVxQUxt?=
 =?utf-8?B?bjg0M2htNWcrUlUvUkpMU1NSb2JZK1cvd1NrMjFPUTRCaU45K21RUWpPdlF6?=
 =?utf-8?B?SEZHSjBzaldUWXZFTHFVSzV1WmlqSU8vUGZzRDBkcFk4cmtBUm9raEpyb2dG?=
 =?utf-8?B?SURFRmV6L1h0V1dKaHZ3NnBucWFVUHlidEFtU3JCa0ptQkZBMElycEtMVkhn?=
 =?utf-8?B?RHpVQ0FYd3pqc0NtWjFQK2VtTkZhK3pONjRtZjJyZXlGNngzcVdLM0RweTJi?=
 =?utf-8?B?NGRnZWVTajRONmFTcHpFaE9ZQWFRemJhdXg0SHdRdTdrTFE0RjdrMXdEZ3pJ?=
 =?utf-8?B?S0NRbyt4UnpweVhaeUdIdHBDTDlhTzM4RlhacGdKL2hwN1RWcWF6dXZ4bmFv?=
 =?utf-8?B?RlpZS201R01UeUZCa1NiTGdBMnVnQkk1WThtd1BBbWptSlJVOURuYXRqWEVy?=
 =?utf-8?B?YTVwT0VoaFRvdUpJdk12eTFSRTlTUE1RbjF1eU5LclBtY0ZpUjNIWk5LVndJ?=
 =?utf-8?B?MWpVR0o1OEZJaW1oY2V5OUUvK0hOMFRtcEg4SENNa1V6ZFRISDRYMG0rNFNs?=
 =?utf-8?B?YTZnQktpTW0wOVpYOVNaQXIwbnNrQVRmM0N2UmlnU0ZTeFQ2Tk05TEJhREVR?=
 =?utf-8?B?V054SDdRYWh0QUNaSUFZTW1FUFFKeXhBd0k3T1JKQ29BRWtTUVM4N1VIeG1L?=
 =?utf-8?B?Q0FaV01uVHVsOFZiVnhUVUNnT3lxNjcrVWVtSTlGeU5zUWRGT2NDcGRxUzlk?=
 =?utf-8?B?RFlTMXhwNThqOEVaWjZPY3JHTG15YUZtakM2Sk5pQWNlZ2laajhSUkFUWERZ?=
 =?utf-8?B?enJ5Z081cFJONW9WTEFtczZNZEE4OUx2NjJNdWMxZThLRWlFVDZzVW5MSW9M?=
 =?utf-8?B?b3JEVS9KOEVWVnFZR0pkM3cvdGNkTXhETHc5bFpsTW5xeXAwVS9wNlo5UnNX?=
 =?utf-8?B?WjZoQkt2YmtBRnZWQm5lWnFDdUEwb3dVUm4rekJjN2xERWo4bFpscEp6bExB?=
 =?utf-8?B?a3hHYlM5ODVRMnZMK1J0Z1Q3TVEwenJob2I4Q0pEaHZwRFZPbk1mOWw2SEJP?=
 =?utf-8?B?M251K0o5WHNnOWgvcndqaUdnMjlNbFRSTUIrd0pjcTVHdC9TRXdCQXJWWXJy?=
 =?utf-8?B?cy84MFhBMGFtVDJHUDNTTHRsMTYvRlF5ckJaWjVhY0NqLzU4MytzZ1ViNnJR?=
 =?utf-8?B?YWJQM2JBSlhaREZkUXMyZVRLeGtmbVJwbjh0L0FXdjlPaHpyMFBUNnhoUFgy?=
 =?utf-8?B?SGEzYkN0ZWVtUVlQSFlrY01lSWRRYWpxRm8vVlk1aGpuajlBUHdaZjd6blE1?=
 =?utf-8?B?UmxEKy9rRnBqK2ZCd2ZBV1k2NXc5a1BJY3dFVVluSDNWZTAxL2xkRWN2REpG?=
 =?utf-8?B?eU5yTzBad2pZZ2M4enJhM2tTYXVMd0lMZndGSkhXbmRIWmkyRmo5dTBicUJk?=
 =?utf-8?B?cjBPa2crTjRxRUlmVnE1VVhTNXhrZU9tcElPdUQzb2FqVFZSbXhKTzRydCt2?=
 =?utf-8?B?MnJmVmR0SExkVTRjWjZ6NFBKT0orNDNiN2RrMkNlbVd5Y2JVZERPSGtzWFZh?=
 =?utf-8?B?YUx3bW5DekRFR0hmeEVCYVlGWGUvc1owN1RIUDVWdlo2VjkwZGZ1dEVVTjB4?=
 =?utf-8?B?UnBtS3pRRXNIN3RsWmluZlArcGwyaDFPdWw2UFBnWWx5QUJJcDFqZXJOSTkw?=
 =?utf-8?B?Z3dhell0RkYzRVM0aFBnaGNpaWZRTy9NWUplbWo0NDV2YXdhUGhFSHMwWUw0?=
 =?utf-8?B?V0FqdDdGeGtSWGkvNGJpelZ4ZlpFejVkNUcrcklZVEFMU29RdTVQbW9iQldM?=
 =?utf-8?B?THFGVDRRd0o1dXRmQW1LS3JROTdsVlJVdmdyZzF0RWYxRFhLU2lwQlV5ZHJx?=
 =?utf-8?B?bENUYnJqbkc2TmZjbE5SUGdpSGovNEZESTcvMHIxcHpON0hYU3IwSjdCeFZQ?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327dd36c-0b89-460e-3731-08dba7c75e28
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:04:52.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb8Hve0iYJH3JtxQNJH1S/fZAxZqyq/3c9o5lcwsmXVxrgJrLzYJVNYuNNywAKI2R3pkaetFBm6Jz6Y43EEaoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5156

On 28.08.23 14:52, Florian Bezdeka wrote:
> On Mon, 2023-08-28 at 14:33 +0200, Jan Kiszka wrote:
>> On 25.08.23 14:58, Florian Bezdeka wrote:
>>> When running an compat RT application on arm64 the break trap is
>>> handled via the undefined instruction trap.
>>>
>>> A possible call stack looks like this:
>>>
>>> Call trace:
>>>   handle_inband_event+0x2d0/0x320
>>>   inband_event_notify+0x28/0x50
>>>   signal_wake_up_state+0x7c/0xa4
>>>   complete_signal+0x104/0x2d0
>>>   __send_signal_locked+0x1d0/0x3e4
>>>   send_signal_locked+0xf0/0x140
>>>   force_sig_info_to_task+0xa0/0x164
>>>   force_sig_fault+0x64/0x94
>>>   arm64_force_sig_fault+0x48/0x80
>>>   send_user_sigtrap+0x50/0x8c
>>>   aarch32_break_handler+0xac/0x1d0
>>>   do_undefinstr+0x6c/0x360
>>>   el0_undef+0x4c/0xd0
>>>   el0t_32_sync_handler+0xd0/0x140
>>>   el0t_32_sync+0x190/0x194
>>>
>>> The trap is never reported to the companion core at that stage so
>>> running_oob() in do_undefinstr() will always return true. As the
>>> following bailout happens before calling the compat breakpoint
>>> detection (aarch32_break_handler()) debugging the compat 
>>> application does not work.
>>>
>>> In addition aarch32_break_handler() has to report the trap entry to the
>>> companion core.
>>>
>>> Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  arch/arm64/kernel/debug-monitors.c | 3 +++
>>>  arch/arm64/kernel/traps.c          | 7 -------
>>>  2 files changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>>> index 32271ed24ef5..ef7ac042a0a6 100644
>>> --- a/arch/arm64/kernel/debug-monitors.c
>>> +++ b/arch/arm64/kernel/debug-monitors.c
>>> @@ -373,7 +373,10 @@ int aarch32_break_handler(struct pt_regs *regs)
>>>  	if (!bp)
>>>  		return -EFAULT;
>>>  
>>> +	mark_trap_entry(ARM64_TRAP_UNDI, regs);
>>>  	send_user_sigtrap(TRAP_BRKPT);
>>> +	mark_trap_exit(ARM64_TRAP_UNDI, regs);
>>> +
>>>  	return 0;
>>>  }
>>>  NOKPROBE_SYMBOL(aarch32_break_handler);
>>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>>> index cc68be400244..9bf2f309248f 100644
>>> --- a/arch/arm64/kernel/traps.c
>>> +++ b/arch/arm64/kernel/traps.c
>>> @@ -489,13 +489,6 @@ void arm64_notify_segfault(unsigned long addr)
>>>  
>>>  void do_undefinstr(struct pt_regs *regs, unsigned long esr)
>>>  {
>>> -	/*
>>> -	 * If the companion core did not switched us to in-band
>>> -	 * context, we may assume that it has handled the trap.
>>> -	 */
>>> -	if (running_oob())
>>> -		return;
>>> -
>>>  	/* check for AArch32 breakpoint instructions */
>>>  	if (!aarch32_break_handler(regs))
>>>  		return;
>>
>> This is not against v6.5-dovetail-rebase, right? We likely need to start
>> from the top, then backport to stable.
> 
> That applied for 6.1 and all other (lower) versions that are currently
> covered by our CI. Might need some lifting for 6.5, didn't check yet.
> 
>>
>> Also note that this change came in via
>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/2b2ccdaeb8116727cf4076960d664a3cedff0ac6,
>> so just dropping it will likely cause problems elsewhere. Should we
>> rather move that down in the handler?
> 
> Well, as written in the commit message running_oob() will always return
> true for RT tasks so I'm quite sure that the invalid instruction
> handling was broken on arm64 for some time now. We bailed out even
> before sending the notification to the companion core.
> 
> Moving it down might fix the compat case but native arm64 would stay
> broken. No?
> 

Something looks still fishy, either in the original patch that
introduced the condition (I still don't get that special case) or now
with this change trying to restore things. I agree that also the
original change needed the notification to be delivered.

Philippe, can you help clarifying the logic behind
do_undefinstr/do_el0_undef?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

