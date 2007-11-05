Message-ID: <472FA210.7030904@domain.hid>
Date: Tue, 06 Nov 2007 00:06:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>	<472E3758.3060304@domain.hid>	<18222.15424.494628.332671@domain.hid>
	<472F5990.5000408@domain.hid> <472F6CE1.7050208@domain.hid>
In-Reply-To: <472F6CE1.7050208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-commits] r3147 - __xn_access_ok changes
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>  > [Let's discuss this without bothering users :)]
>>>  > 
>>>  > Philippe Gerum wrote:
>>>  > > Author: rpm
>>>  > > Date: Sun Nov  4 18:18:39 2007
>>>  > > New Revision: 3147
>>>  > > 
>>>  > > URL: http://svn.gna.org/viewcvs/xenomai?rev=3147&view=rev
>>>  > > Log:
>>>  > > Make __xn_access_ok() return false for addresses lower than the natural page size.
>>>  > > 
>>>  > > Modified:
>>>  > >     trunk/ChangeLog
>>>  > >     trunk/include/asm-x86/syscall_32.h
>>>  > >     trunk/include/asm-x86/syscall_64.h
>>>  > 
>>>  > Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? Because
>>>  > the current version is "slightly" broken, tagging any address in user
>>>  > land as invalid.
>>>  > 
>> Another example that committing last minute "fixes" before leaving for a 
>> trip is just as safe as checking for your parachute _after_ you jumped 
>> out of the plane. Fixed the trivial way for now. Sorry for this.
>>
>>>  > And if this test was meant to catch NULL page accesses early, is the
>>>  > intention to cope with all those current i-pipe patches that do not yet
>>>  > include the discussed domain switch on non-root faults? If yes, this
>>>  > test would be a workaround for legacy code and should not become default
>>>  > (pure overhead for later versions).
>>>
>>> We can reduce the overhead of the two tests by testing 
>>> (unsigned long) (addr - PAGE_SIZE) < (PAGE_OFFSET - PAGE_SIZE)
>>>
>> Yep. I'd rather keep the reference to the actual task's segment limit in 
>> this expression though, instead of hardcoding PAGE_OFFSET.
>>
>> Aside of this, we should not need to pass the current task pointer to 
>> each and every syscall anymore, so we may rely on the original uaccess code.
>>
>> __xn_access_ok was there to allow for passing the task pointer
>> explicitly in order to test the address range against the task's segment
>> limit, at times when Adeos would switch the underlying stack to some
>> private, non-Linux one.
>>
>> With modern I-pipe, domains don't have any private stack, but simply
>> reuse the current one, which means that any task running a syscall
>> over the Xenomai domain may always be referenced by "current", including
>> on archs using the stack pointer trick to determine this value.
>>
>> I'll do this change early in the 2.5 series; it's too late for 2.4.
>>
>> This said, we'll still need __xn_access_ok from now on, to pre-test the 
>> address for obvious spuriousness, like the NULL case which started this 
>> discussion.
> 
> ...which still doesn't answer my original question: Is the current
> (virtually fixed - please fix in real-life soon!) version a legacy
> wrapper for you? Because I still don't see the need for it with, e.g.,
> my latest patch for i386-ipipe.

I usually refrain from rehashing the obvious, but here it comes anyway: 
yes, it's a work around, because we have more than 340 older I-pipe 
patches out there for a number of archs, and leaving the possibility for 
lockups with those just due to some uncaught NULL pointer would be bad 
policy. And yes, it adds a few cycles more to the hot path for that 
reason, so we may want to make this conditional -- albeit the fixes are 
functionally quite different, and getting -EFAULT at application level 
may give a better debugging help than relying on CONFIG_IPIPE_DEBUG and 
looking at the kernel log periodically, at least for most common error 
cases like NULL pointers.

As a matter of fact, there is not a single I-pipe patch officially 
released which implements the fixup I've been talking about yesterday 
yet, therefore, no time is lost for making the uaccess trick conditional.

