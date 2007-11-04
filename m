Message-ID: <472E26BC.5060908@domain.hid>
Date: Sun, 04 Nov 2007 21:08:28 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <20071031154106.29f66afc@domain.hid>	<18216.57598.559447.478769@domain.hid>	<20071104120932.0a396361@domain.hid>
	<472E06CF.1060305@domain.hid> <472E1913.3080909@domain.hid>
In-Reply-To: <472E1913.3080909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_inquire and NULL 2nd arg
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Daniel Simon wrote:
>>> On Wed, 31 Oct 2007 21:09:34 +0100
>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> Daniel Simon wrote:
>>>>  > Hello all,
>>>>  > 
>>>>  > I am testing some former programs with
>>>>  > xenomai-2.4-rc4/kernel-2.6.23.1/pentiumM;
>>>>  > 
>>>>  > Calling rt_task_inquire(Id, NULL) with a null second argument now
>>>>  > freezes or reboots the pc...
>>>>  > 
>>>>  > I had no problem with this call with a former (2.3.1) xenomai version. Is
>>>>  > it a known behaviour?
>>>>
>>>> the rt_task_inquire system call checks that the "info" pointer points to
>>>> a piece of writable memory and returns -EFAULT otherwise. 
>>> That was the behaviour I got with xenomai-2.3.1 (I only wanted to check if the
>>> task was still existing and thus only interested in the value returned)
>>>
>>>> So, what you
>>>> should get is a segmentation fault, no freeze or reboot. Actually, I
>>>> have tested a small test which segfaults as expected. Could you provide
>>>> us with the simple test that causes a freeze or reboot ?
>>>>
>>> file testinfo.c and config attached, uncommenting line 201 reboots the system
>>> at cleaning time after ^C 
>>> (xeno 2.4-rc5, kernel 2.6.23.1, gcc 4.0.2 with --xeno-cflags and --xeno-ldflags)
>>>
>> As a matter of fact, the address checking code on x86* considers any
>> address below the page offset as being valid, so passing NULL went
> 
> Could you explain why Xenomai is special here? The range-checking macros
> matched mainline before (as it should be), now it is different without
> any (at least to) obvious reason. Their purpose is not to avoid page
> faults but to avoid "confused deputy" attacks (user making the kernel
> accessing privileged memory).
> 

Mainline macros only check for (addr < PAGE_OFFSET), which basically
says that any address below the first kernel location is ok. The rest is
expected to be caught by the usual exception mechanism. Because of the
dual domain model, we have to fixup things that Linux hasn't.

>> undetected in your case. This was already the case with 2.3.1, you
>> likely just got lucky with respect to the consequences of another hole -
>> in the I-pipe this time - which has been plugged recently, and now fixes
>> up any fault whenever Xenomai has to leave it unhandled:
>> http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=commit;h=e7b140c69794521fe8979a39337f36112dbe330c
> 
> Err, my feeling is you misunderstand this.
> 
>> The fix above was only available when CONFIG_IPIPE_DEBUG was enabled in
>> the latest patch series, and prevented any ungraceful consequence of
>> writing to an invalid address from the Xenomai domain. We actually need
> 
> Nope, it is intended to catch *improperly handled* invalid memory
> accesses, ie. non-root domain bugs in the kernel.
> 

You are missing the major issue: there is some situations where Xenomai
will never handle a fault occurring on top of the Xenomai domain,
because it has not really be triggered by a shadow, but rather by a pure
Linux thread running a syscall in high stage. This is the case for those
running __xn_exec_any flagged services, like rt_task_inquire. And no, we
don't want to turn __xn_exec_any services into __xn_exec_conforming
ones, because there is no point in having real-time threads calling such
services from secondary mode to be uselessly switched to primary mode.

>> to have this fixup done in any case. Next I-pipe patches will include
>> this change.
> 
> I'm not sure if we need this debugging feature on by default - in the
> fast path of Linux code running on usual page faults. The check must
> never fire unless the RT domain's kernel is buggy, thus we should only
> use it during debugging.

As explained, some situations should better be left to the I-pipe as a
fallback situation. This is what is going to happen with the next patches.

What we have to do is the fixup always, only enabling the debug message
and the trace freeze according to the IPIPE_DEBUG knob. The rationale is
simple: those situations are bugous, but should not be lethal, because
Linux normally allows for the fault to occur, so we should allow this
too. But since this reveals a problem, this has to be reported in the
message log when running in debug mode, since we cannot propagate this
information in any other way.

> 
> Something is fishy here - or I'm still missing the point. The question
> for me is: Why was the NULL pointer access over Xenomai passed through
> without relaxing the caller,

The caller was _NOT_ running as a shadow. You may have tasks running as
pure Linux threads in the Xenomai domain. In such a case, Xenomai
_cannot_ handle the situation by itself, and needs the help of the
I-pipe, because only the I-pipe is allowed to switch domains.

-- 
Philippe.

