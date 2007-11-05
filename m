Message-ID: <472F6CE1.7050208@domain.hid>
Date: Mon, 05 Nov 2007 20:20:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>	<472E3758.3060304@domain.hid>	<18222.15424.494628.332671@domain.hid>
	<472F5990.5000408@domain.hid>
In-Reply-To: <472F5990.5000408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r3147 - __xn_access_ok changes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > [Let's discuss this without bothering users :)]
>>  > 
>>  > Philippe Gerum wrote:
>>  > > Author: rpm
>>  > > Date: Sun Nov  4 18:18:39 2007
>>  > > New Revision: 3147
>>  > > 
>>  > > URL: http://svn.gna.org/viewcvs/xenomai?rev=3147&view=rev
>>  > > Log:
>>  > > Make __xn_access_ok() return false for addresses lower than the natural page size.
>>  > > 
>>  > > Modified:
>>  > >     trunk/ChangeLog
>>  > >     trunk/include/asm-x86/syscall_32.h
>>  > >     trunk/include/asm-x86/syscall_64.h
>>  > 
>>  > Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? Because
>>  > the current version is "slightly" broken, tagging any address in user
>>  > land as invalid.
>>  > 
> 
> Another example that committing last minute "fixes" before leaving for a 
> trip is just as safe as checking for your parachute _after_ you jumped 
> out of the plane. Fixed the trivial way for now. Sorry for this.
> 
>>  > And if this test was meant to catch NULL page accesses early, is the
>>  > intention to cope with all those current i-pipe patches that do not yet
>>  > include the discussed domain switch on non-root faults? If yes, this
>>  > test would be a workaround for legacy code and should not become default
>>  > (pure overhead for later versions).
>>
>> We can reduce the overhead of the two tests by testing 
>> (unsigned long) (addr - PAGE_SIZE) < (PAGE_OFFSET - PAGE_SIZE)
>>
> 
> Yep. I'd rather keep the reference to the actual task's segment limit in 
> this expression though, instead of hardcoding PAGE_OFFSET.
> 
> Aside of this, we should not need to pass the current task pointer to 
> each and every syscall anymore, so we may rely on the original uaccess code.
> 
> __xn_access_ok was there to allow for passing the task pointer
> explicitly in order to test the address range against the task's segment
> limit, at times when Adeos would switch the underlying stack to some
> private, non-Linux one.
> 
> With modern I-pipe, domains don't have any private stack, but simply
> reuse the current one, which means that any task running a syscall
> over the Xenomai domain may always be referenced by "current", including
> on archs using the stack pointer trick to determine this value.
> 
> I'll do this change early in the 2.5 series; it's too late for 2.4.
> 
> This said, we'll still need __xn_access_ok from now on, to pre-test the 
> address for obvious spuriousness, like the NULL case which started this 
> discussion.

...which still doesn't answer my original question: Is the current
(virtually fixed - please fix in real-life soon!) version a legacy
wrapper for you? Because I still don't see the need for it with, e.g.,
my latest patch for i386-ipipe.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

