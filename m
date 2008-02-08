Message-ID: <47AC5660.6020203@domain.hid>
Date: Fri, 08 Feb 2008 14:17:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: 200710081503.15198@domain.hid>
	<200802061509.13010@domain.hid>	<2ff1a98a0802070523r7af4ec4fv20f514b0cf1868c@domain.hid>	<47AB0B79.8000709@domain.hid>
	<47AB0F88.3000001@domain.hid>	<47AB174F.5070207@domain.hid>
	<47AB1C21.3070702@domain.hid> <200802081341.13030@domain.hid>
In-Reply-To: <200802081341.13030@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] FPU not available
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

Petr Cervenka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> On Wed, Feb 6, 2008 at 3:09 PM, Petr Cervenka <grugh@domain.hid> wrote:
>>>>>>> Hello.
>>>>>>>  Recently, we switched to newer distribution of linux (Kubuntu 7.10). During this switch we changed many things (Xenomai 2.4.1, linux kernel 2.6.24, x86_64 architecture, ...).
>>>>>>>  No we have problem, that in one of our tasks we are sometimes not able to use floating point operations (under very specific circumstances) . In such case, that task crashes immediately, but rest of the application runs "normaly". Output from dmesg is attached to this message. Task was created with T_FPU flag.
>>>>>>>  Is there anything we can check or change?
>>>>>>>  Petr Cervenka
>>>>>> I do not know if this is related to the issue you are facing, but the
>>>>>> first FPU fault of a thread running in primary mode may be handled by
>>>>>> Xenomai without switching to secondary mode. So, maybe the fault
>>>>>> epilogue implicitely expects Xenomai to have switched the fault to
>>>>>> secondary mode and use some secondary mode services such as
>>>>>> ipipe_restore_root, whereas the thread never leaved primary mode.
>>>>>>
>>>>> Good point! That is probably this path (and not the one I starred on):
>>>>>
>>>>> __ipipe_handle_exception()
>>>>> 	...
>>>>> 	if (unlikely(ipipe_trap_notify(vector, regs))) {
>>>>> 		local_irq_restore(flags);
>>>>> 		return 1;
>>>>> 	}
>>>>>
>>>>> That needs some more thoughts...
>>>> Looking at the whole __ipipe_handle_exception, the problem is related to
>>>>  the early, context-independent __ipipe_stall_root(). Can we postpone
>>>> this safely after having called any potential high-stage hooks for this
>>>> exception, and then only if the callee migrated the thread to the root
>>>> domain? Or is there a need to have the root domain stalled across the
>>>> post-fault migration?
>>>>
>>> Someone from the root domain may want to get notified of the exceptions
>>> occurring in that domain too, in which case we may not postpone the
>>> virtual mask fixup after the notifier invocation, otherwise we would
>>> call the handler with a broken interrupt state.
>>>
>>>> In the latter case, we would have to fiddle with the stall bits directly
>>>> instead of calling local_irq_restore - not just to work around the
>>>> BUG_ON, but also to avoid sync'ing root over potentially stalled
>>>> non-root domains...
>>>>
>>> This used to be done by ipipe_restore_pipeline_nosync() in older
>>> patches, but this one has disappeared after the flat log refactoring. We
>>> indeed need to resurrect something alike in order to reset the stall bit
>>> without calling the syncer, when taking the fast exit path after
>>> ipipe_trap_notify().
>> Hmm, so it could be fairly simple in fact:
>>
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -755,7 +755,9 @@ int __ipipe_handle_exception(struct pt_r
>> #endif /* CONFIG_KGDB */
>>
>> 	if (unlikely(ipipe_trap_notify(vector, regs))) {
>> -		local_irq_restore(flags);
>> +		if (!flags)
>> +			__clear_bit(IPIPE_STALL_FLAG,
>> +				    &ipipe_root_cpudom_var(status));
>> 		return 1;
>> 	}
>>
>> Petr, ready to try?
>>
> I tried this patch and the problem (or the race condition) disappeared. ;-)
> Is there any (easy) method to recognise if the problem was solved?
>

If the following warning pops up when running your app, then the patch
just saved your day too.

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index ce24db7..8b034cd 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -759,6 +759,7 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)

 	if (unlikely(ipipe_trap_notify(vector, regs))) {
 		if (!flags)
+			WARN_ON(!ipipe_root_domain_p);
 			__clear_bit(IPIPE_STALL_FLAG,
 				    &ipipe_root_cpudom_var(status));
 		return 1;

> To your previous questions:
> We use Athlon64 X2 (2 cores, 64-bit), kubuntu 7.10 amd64.
> We have 2 real-time userspace applications: some kind of server for rtnet communication with special measuring hardware, and clients (1-4 instances) for some computing, configuration, ethernet comunication, etc. Comunication between server and clients is via named rt_queues.. Any "failing example" is perhaps impossible.
> Any attempt with IPIPE_DEBUG and tracer removes the race condition.
> 
> Thank you VERY MUCH for you help and support (all of you).
> Petr
> 
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
>>
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

