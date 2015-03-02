Message-ID: <54F4C88C.4020705@siemens.com>
Date: Mon, 02 Mar 2015 21:31:08 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54F0CF9E.1040707@siemens.com>
 <20150227202724.GL434@hermes.click-hack.org> <54F0D599.8090009@siemens.com>
 <20150227212130.GP434@hermes.click-hack.org>
 <20150227212439.GQ434@hermes.click-hack.org> <54F4A04A.9050600@siemens.com>
 <54F4B1AB.3030909@xenomai.org> <54F4B750.6070201@siemens.com>
In-Reply-To: <54F4B750.6070201@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86
 and ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-03-02 20:17, Jan Kiszka wrote:
> On 2015-03-02 19:53, Philippe Gerum wrote:
>> On 03/02/2015 06:39 PM, Jan Kiszka wrote:
>>> On 2015-02-27 22:24, Gilles Chanteperdrix wrote:
>>>> On Fri, Feb 27, 2015 at 10:21:30PM +0100, Gilles Chanteperdrix wrote:
>>>>> On Fri, Feb 27, 2015 at 09:37:45PM +0100, Jan Kiszka wrote:
>>>>>> On 2015-02-27 21:27, Gilles Chanteperdrix wrote:
>>>>>>> On Fri, Feb 27, 2015 at 09:12:14PM +0100, Jan Kiszka wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> just pushed a first implementation of the general model that I proposed
>>>>>>>> for exception handling. You can find it at
>>>>>>>>
>>>>>>>> http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework
>>>>>>>
>>>>>>> Also, the clean way to pass virtual + physical flags is to use
>>>>>>> arch_mangle_bits. Using two longs (potentially 128 bits then) is
>>>>>>> completely useless since one of the longs simply has one significant
>>>>>>> bit.
>>>>>>
>>>>>> The costs of mangling is higher than using two regs for passing that
>>>>>> data as-is, both binary and LOC-wise (tried it). Plus the code is more
>>>>>> readable.
>>>>>
>>>>> That is false on ARM. On ARM gcc does not pass structs by values in
>>>>> registers. The values get passed on stack.
>>>>
>>>> Sorry, misread the assembler. They are passed by registers, however
>>>> the registers get uselessly saved on stack, then restored to other
>>>> registers. 
>>>>
>>>> struct foo {
>>>> 	int x;
>>>> 	int y;
>>>> };
>>>>
>>>> int f(struct foo f)
>>>> {
>>>> 	return f.x + f.y;
>>>> }
>>>>
>>>> Gives, with -Os:
>>>> 00000000 <f>:
>>>>    0:   b082            sub     sp, #8
>>>>    2:   ab02            add     r3, sp, #8
>>>>    4:   e903 0003       stmdb   r3, {r0, r1}
>>>>    8:   e89d 0009       ldmia.w sp, {r0, r3}
>>>>    c:   4418            add     r0, r3
>>>>    e:   b002            add     sp, #8
>>>>   10:   4770            bx      lr
>>>>
>>>
>>> Ouch. I missed that this sneaked in.
>>>
>>> The complications with the existing mangle functions are that they do
>>> not play well with what I need for the existing
>>> ipipe_restore_root_nosync. I can open-code the latter (size increases),
>>
>> Unless this is part of a heavily used static inline, this increase
>> should be negligible.
>>
>>> extend the former to alternatively return architectural flags (instead
>>> of boolean), or provide another wrapper to convert the virt bit into flags.
>>>
>>> Hmm, or - and that's probably cleanest - I simply align
>>> ipipe_restore_root_nosync to ipipe_restore_root argument-wise. The
>>> latter takes "x" (stall) as boolean, the former as architectural flags.
>>> That's highly confusing anyway. And it seems there are no users to break
>>> in Xenomai, despite that it is exported to modules.
>>>
>>
>> It is exported because it was called from some static inline helper
>> which was part of an obsolete interface, not because client code should
>> use it.
>>
>> The cleanest approach is not to use ipipe_restore_root_nosync() at all.
>> There are only a very few occasions when no syncing the interrupt log
>> ever makes sense, and all are now open-coded to make it clear that we
>> are doing something very unusual.
> 
> Hmm, I still seeing it called by both x86 and ARM.
> 
>>
>> ipipe_restore_root_nosync() is confusing enough that people tend to use
>> it the wrong way, introducing nasty bugs, so I definitely plan to get
>> rid of it.
> 
> Indeed.
> 
> I'm currently re-analyzing x86 in this regard. It is called there after
> every exception - but what if Linux didn't enable IRQs while handling
> the exception and, thus, didn't flush the log. We could have some
> interrupts pending, no?

Seems we have a couple of sleeping issues in x86:

 - page fault entry over root, root was unstalled
 - we stall root because hard irqs are found off in the exception
   context
 - we call the Linux handler
 - early in __do_page_fault, hard IRQs get reenabled
 - an interrupt for Linux arrives and gets logged
 - Linux doesn't reenable interrupts as it leaves early (vmalloc_fault
   or spurious_fault)
 - we restore root according to the state found on entry, but we do not
   flush the log
 - the exception return path on x86 no longer modifies or flushes as
   well
 => lost an event

With __ipipe_divert_exception on 3.14, there are also cases we we do not
seem to adjust the root state after forwarding an int3. Normally,
do_int3 re-enables interrupts, but not if it leaves early due to dynamic
ftrace or alternates related breakpoints.

BTW, we do not seem to enable hard IRQs while handling most exceptions
under Linux, probably only consistently if we migrated from head before
- or I'm missing that part right now. Hmm, need to check if some of them
are entered with hard irqs on anyway.

> 
> The alternative - already lived in ARM's ipipe_fault_exit today - is
> taking Linux interrupts at that point. If that is always OK is another
> question...

I'll check this on x86, and then it can become part of the common trap
functions (for archs that are capable of taking IRQs over exception
handlers).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

