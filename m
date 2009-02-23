Message-ID: <49A29578.3050909@domain.hid>
Date: Mon, 23 Feb 2009 13:24:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EA168.3000103@domain.hid> <49A290AD.9040909@domain.hid>
In-Reply-To: <49A290AD.9040909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Stall bit setting in __ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> as already indicated, I'm starting to understand the ipipe bug Roman
>> sees. It seems to melt down to the following path:
>>
>> - exception raised over non-root domain (__rt_event_wait...)
>> - root domain is stalled on entry of __ipipe_handle_exception
>> - fault causing task is first relaxed, then scheduled away under Linux
>> - scheduled-in Linux task was interrupted in __ipipe_divert_exception,
>>   shortly before __fixup_if
>> - __fixup_if finds root domain stalled and propagates this to the
>>   register set of the interrupted context (user space task running on
>>   its first fpu instruction, having triggered device_not_available).
>> - return to user space task with irqs disable - bang!
>>
> 
> Good catch.
> 
>> Two ways to approach this:
>> 1. Do we actually have to stall the root domain in
>>    __ipipe_handle_exception before ipipe_trap_notify? I don't see why we
>>    should be better off with doing this afterwards.
> 
> We do, because the root domain may install an I-pipe event handler on exceptions
> as well, and the callee may assume that the virtual interrupt state is correct.

But from that POV, you would have to stall all domains before calling
the hook, not just root
.

> 
>> 2. Avoid that __ipipe_divert_exception is interruptible and can pick up
>>    the stall flag from a different Linux task. But I don't know if there
>>    aren't more race windows like that.
>>
> 
> Since the core of the issue is about a preemption point that may be introduced
> by a thread migration to secondary, the same goes with __ipipe_syscall_root;
> this is what I stumbled upon on a different trace set.
> 
> The way to fix this properly is to decouple fixup_if() from the current global
> interrupt state at call time, and rather make such state context-dependent, so
> that iret emulation always uses the proper state value. A typical approach would
> be to record the stall bit value on the caller's stack, and feed fixup_if() with it.
> 

Didn't get yet how this should work, but I guess you've implemented it
in -06. Will check.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

