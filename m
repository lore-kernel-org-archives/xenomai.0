Message-ID: <44E9BDCF.2070109@domain.hid>
Date: Mon, 21 Aug 2006 16:06:07 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <44E9BA20.4000607@domain.hid>
In-Reply-To: <44E9BA20.4000607@domain.hid>
Subject: Re: [Xenomai-help] Oops on PPC405EP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: holindho@domain.hid
Cc: xenomai@xenomai.org

holindho@domain.hid wrote:
> Dirk Eibach kirjoitti:
>> rpm@xenomai.org wrote:
>>
>>> On Mon, 2006-08-21 at 14:15 +0200, Dirk Eibach wrote:
>>>
>>>> Oops: Exception in kernel mode, sig: 4 [#1]
>>>> NIP: C016772C LR: C003C7B0 SP: C1A19E50 REGS: c1a19da0 TRAP: 0700
>>>> Not tainted
>>>> MSR: 0002b030 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
>>>> TASK = c1a10b60[500] 'sampling-497' THREAD: c1a18000
>>>> Last syscall: 50332203
>>>> GPR00: C1A10D48 C1A19E50 C1A10B60 C1A10D48 C0005940 0002B030 0007C45F
>>>> C1A10B5F
>>>> GPR08: 00000001 00400000 00000001 C0260040 00000000 10020184 01FEF400
>>>> 00000000
>>>> GPR16: 00000001 FFFFFFFF 00000000 00000000 0FFAC420 00000000 C1A19F50
>>>> C021C420
>>>> GPR24: 0000000E C0250000 C0260000 00000000 00000018 C0261350 C0362768
>>>> C0261380
>>>> Call trace: [c00421fc]  [c0042668]  [c0043530]  [c0035708]  [c000b418]
>>>> [c0002bf4]
>>>>
>>> Oops indeed. Could you objdump the kernel, and locate the symbols close
>>> to the addresses 0xC016772C and 0xC003C7B0? TIA,
>>>
>> Just compiled symbols into the kernel. Now it should be human readable ;)
>>
>> Oops: Exception in kernel mode, sig: 4 [#1]
>> NIP: C016892C LR: C003D8CC SP: C1A39E50 REGS: c1a39da0 TRAP: 0700    Not
>> tainted
>> MSR: 0002b030 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
>> TASK = c1a2fb40[501] 'sampling-498' THREAD: c1a38000
>> Last syscall: 50332203
>> GPR00: C1A2FD28 C1A39E50 C1A2FB40 C1A2FD28 C0005960 0002B030 000634DF
>> C1A2FB3F
>> GPR08: 00000001 00400000 00000001 C027E040 00000000 10020184 01FEF400
>> 00000000
>> GPR16: 00000001 FFFFFFFF 00000000 00000000 0FFAC420 00000000 C1A39F50
>> C021D4A0
>> GPR24: 0000000E C0270000 C0280000 00000000 00000018 C027F350 C0382768
>> C027F380
>> NIP [c016892c] rthal_restore_fpu+0x10/0xe4
>> LR [c003d8cc] xnpod_switch_fpu+0x94/0x12c
>> Call trace:
>>   [c0043318] xnshadow_harden+0xd0/0xfc
>>   [c0043784] xnshadow_wait_barrier+0x100/0x114
>>   [c004464c] losyscall_event+0xc0/0x194
>>   [c0036824] __ipipe_dispatch_event+0x88/0x148
>>   [c000b488] __ipipe_syscall_root+0x50/0xd0
>>   [c0002c14] DoSyscall+0x24/0x6c
> 
> Since your hardware AFAIK does not have an FPU, shouldn't you be 
> compiling Xenomai without hardware FPU support?
> 
> -- Heikki Lindholm
> 
> 
> To: eibach@domain.hid
> Cc: xenomai@xenomai.org

You are certainly right, PPC 405EP does not have an FPU. I just did not 
realize I had to turn it off in Real-time sub-system. Sorry.

Now the first test is running :)

Cheers.
-- 
Dirk Eibach <eibach@domain.hid>
Guntermann & Drunck Systementwicklung GmbH
F & E
Dortmunder Str. 4a, D-57234 Wilnsdorf
Tel.: +49 (0) 2739 8901 100, Fax.: +49 (0) 2739 8901 120




