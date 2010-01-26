Message-ID: <4B5EF1CE.9010402@domain.hid>
Date: Tue, 26 Jan 2010 14:44:46 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <4B5EB6D2.9040206@domain.hid> <4B5ED445.1040908@domain.hid>
	<4B5ED4F7.4030006@domain.hid> <4B5EE589.2040406@domain.hid>
	<4B5EE6AA.5030807@domain.hid> <4B5EEA87.3020505@domain.hid>
	<4B5EECD2.2090804@domain.hid>
In-Reply-To: <4B5EECD2.2090804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2] x86: Fix root domain state restoring
 on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Mauerer wrote:
>> Jan Kiszka wrote:
>>> Wolfgang Mauerer wrote:
>>>> Jan Kiszka wrote:
>>>>> Wolfgang Mauerer wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> If we enter __ipipe_handle_exception over a non-root domain and leave it
>>>>>>> due to migration in the event handler over root, we must not restore the
>>>>>>> root domain state so far saved on entry. This caused subtle pipeline
>>>>>>> state corruptions. Instead, only save and restore them if we were
>>>>>>> entering over root.
>>>>>>>
>>>>>>> However, the x86-32 regs.flags fixup is required nevertheless to take
>>>>>>> care of mismatches between the root domain state and the hardware flags
>>>>>>> on entry. That may happen if we fault in the iret path. But also in this
>>>>>>> case we must not restore an invalid root domain state. So if we entered
>>>>>>> over non-root, pick up the input for __fixup_if from the root domain
>>>>>>> after running the ipipe handler.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>> ---
>>>>>>>
>>>>>>> Next try. But this time I think I finally understood what scenario
>>>>>>> __fixup_if is actually fixing. Please correct me if I'm still missing
>>>>>>> one.
>>>>>> looks good - it works for my test cases and solves the problems with
>>>>>> the hw/pipeline state mismatch during early bootup. But do you happen
>>>>>> to have any scenario at hand with ipipe_domain_root_p && !root_entry?
>>>>>> Couldn't trigger this one yet so only the raw_irqs_disabled_flags
>>>>>> fixup is excercised, though I guess it can't do any harm to really
>>>>>> ensure that the explanation fits reality this time...
>>>>> You mean non-root entry -> migration -> __fixup_if? In that case we pick
>>>>> up the flags for fixup _after_ the migration (raw_irqs_disabled()). Or
>>>>> what do you mean?
>>>> (...)
>>>>>>> -	if (unlikely(!ipipe_root_domain_p)) {
>>>>>>> +	if (likely(ipipe_root_domain_p)) {
>>>>>>> +		/*
>>>>>>> +		 * 32-bit: In case we faulted in the iret path, regs.flags do
>>>>>>> +		 * not match the root domain state as the low-level return
>>>>>>> +		 * code will evaluate it. Fix this up, either by the root
>>>>>>> +		 * state sampled on entry or, if we migrated to root, with the
>>>>>>> +		 * current state.
>>>>>>> +		 */
>>>>>>> +		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
>>>>>>> +					raw_irqs_disabled(), regs);
>>>> I'm referring to the case that evaluates to
>>>> __fixup_if(raw_irqs_disabled(), regs); That is, something that
>>>> triggers
>>>>
>>>> 		if (!root_entry)
>>>> 			do_something();
>>>>
>>>> Could be that we're talking about to the same case, although I'm not
>>>> sure ;-)
>>> Right, that's the case I described above. What problem do you precisely
>>> see or what concerns to you have about the suggested behavior?
>> None. I'd just like to be able to trigger it to avoid that
>> there are any unforseen problems we're still missing.
>> Since this corner of Ipipe seems to have proven tricky before
>> AFAIK, I thought it might perhaps be worth while to really excercise
>> every possible code path.
> 
> To trigger it, you need to recreate the scenario that our colleagues
> managed to generate on the MARS: Have Linux IRQs disabled (or enabled,
> to have both variations), schedule in a Xenomai task, let it raise a
> fault so that Xenomai migrates it back.

Yep, but allocating a large amount of memory in non-rt, switching to
rt and then accessing this and switching back to non-rt
in the hope of generating many faults so that the scenario would be
synthesised without expensive and hard to access hardware was
unsuccessful, so my little innocent question was really just if you
happened to have a testcase.

But as I said in the very beginning, the patch nevertheless looks
good to me.

Cheers, Wolfgang

