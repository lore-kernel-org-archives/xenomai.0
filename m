Message-ID: <4742E61C.2080301@domain.hid>
Date: Tue, 20 Nov 2007 14:50:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47374EF7.4070608@domain.hid>
	<4741CAEE.7020003@domain.hid>	<47429113.9080705@domain.hid>
	<4742B4AE.10803@domain.hid> <4742CA03.7060505@domain.hid>
In-Reply-To: <4742CA03.7060505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] x86_64: cleanup IRQ on/off tracing
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Tracing of IRQ on/off paths on x86_64 currently suffers from heavy
>>>>> over-instrumentation.
>>>> I understand the point of grouping ipipe_trace_begin/ipipe_trace_end
>>>> statements inside the .interrupt macros and using a lightweight thunk
>>>> code since we are already covered by the SAVE_ARGS prologue, but I find
>>>> the following hunk suspicious, since unlike i386, we do not virtualize
>>>> inline sti/cli ops for x86_64. My concern is that removing this
>>>> instrumentation would leave us naked in the cold the day some subtle
>>>> upstream change introduces a hw masked section we don't immediately
>>>> notice; such trace points would precisely help us spotting it.
>>> The situation is not that different compared to i386:
>>>  - we do not add or remove enabling/disabled points
>>>  - we rely on the correctness of mainline here, so we are not on our own
>>>    anyway
>> No we don't. Never, really. Gilles just found a bug in mainline's ARM
>> syscall epilogue, which would run do_notify_resume() with hw interrupts
>> off. Old virtualization patches had to face a subtle change in the
>> exception #14 handling with x86, going from a trap gate to an interrupt
>> gate, which basically means that hw interrupts where forced off
>> branching to the handler in the latter case, unlike in the former one.
> 
> For such things we are already recording the hard IRQ mask with each and
> every trace point. And as long as we run with I-pipe through many common
> code paths in entry.S like Linux, we _do_ rely on their correctness, or
> better on us having carefully reviewed the code and ongoing mainline
> changes in new kernels.

My point is that we might not have enough "density" in our
instrumentation anymore to easily spot such regressions. Again, it's not
like I'm saying that using the tracer is the only method to chase
latencies, but since we have it now, we may want to use it whenever
possible. I still don't agree on the fact that we rely on Linux's
correctness though, that's partly why we indeed do analyze the standard
code paths as you mentioned, actually.

> 
>>>  - if things actually change in mainline, the tracer will probably be
>>>    the last indicator for it (patching breaks and/or leaking clis will
>>>    fairly visible impact)
>>>
>> Sorry, I don't get what you mean here.  Could you explain your rationale
>> a bit more? The scenario I'm thinking of is when mainline adds some code
>> to entry.S which may call into kernel routines, adding unnoticed latency
>> to vanilla, but enough to be significant for any real-time activity (say
>>> 5us).
> 
> Then these quirks will show up in those frozen paths we take with
> testsuite tools. IRQS_OFF tracing will only report it by itself if 5 us
> happen to be to longest path in the kernel with hard interrupts enable.
> Do you expect this to happen?

The point is that you may prefer having to analyze a code path made of
30 IRQs off spots, rather than one made of 200 or more. Ok, let's
illustrate the scenario I have in mind:

Here is what would be the problematic kind of hunk, mainline might
decide to add:

	cli
	TRACE_IRQS_OFF
	...
/* We get there hw interrupts off */
sysret_careful:
	bt $TIF_NEED_RESCHED,%edx
-	jnc sysret_signal
+	jnc sysret_whatever
	TRACE_IRQS_ON
	sti
	pushq %rdi
	CFI_ADJUST_CFA_OFFSET 8
	call schedule
	popq  %rdi
	CFI_ADJUST_CFA_OFFSET -8
	jmp sysret_check

	/* Handle a signal */
sysret_signal:
	TRACE_IRQS_ON
	sti
	...

+ sysret_whatever:
	leaq -ARGOFFSET(%rsp),%rdi
	call whatever_this_does_is_expensive
	jmp sysret_signal

My fear is that, since we do not have instrumentation in TRACE_IRQ_xx
macros anymore, we may have lesser information to spot the call to
whatever_this_does_is_expensive() as being the potential latency raiser.

I do agree that we might catch this by dissecting each and every hunk
mainline adds to entry.S, but still, we lose some runtime debugging support.

> 
>>> On the other side, there was a good reason not to instrument cli/sti in
>>> the assembly exit/entry code on i386, just like it is on x86_64: The
>>> effort to get worthwhile outputs is noticeable.
>> Again, most of (pre-existing) cli/sti are virtualized by Adeos on x86,
>> whilst they are not on x86_64, which means that x86 did not have to
>> instrument the code about changes in the hw masking state anyway.
>>
>> As you see, the current
>>> approach is not very helpful due to loosing the caller context (thanks
>>> to the thunks). And those points only mark uninteresting micro paths,
>>> thus create a lot of noise in normal traces.
>>>
>> These are two separate issues: knowing whether the IRQs off flag is
>> raised, and knowing which precise code spot reported this. The former is
>> still a valuable information, despite the latter would be missing. At
>> least, this tells you where to start digging. I agree wrt the noise
>> issue, but this is a bit like an umbrella, it starts being useful only
>> when it actually rains.
>>
>> Btw, the caller's context is lost because we are relying on
>> __builtin_return_address which imposes a well-defined call frame layout,
>> we could find a more ad hoc way to handle the case of assembly-written
>> call sites to pass this information to the tracer.
>>
>>> So, I see not good reason for fixing this instrumentation and still vote
>>> for killing it.
>>>
>> This is 100% tracer-related code which won't break anything, so I'm
>> going to apply this patch if you want this to be merged. Still, you may
>> also want to consider my point regarding vanilla's perceived
>> infallibility. As a matter of fact, vanilla has some bugs too, and aside
>> of that, its perception of what a pathological latency spot is may be
>> very different (i.e. relaxed) compared to ours in some circumstances.
> 
> This particular instrumentation will not tell you by itself that
> something broke regarding cli/sti in [ia32]entry.S. The current version
> will not even be useful if you received noticed differently that
> something is fishy. You can fix the latter, but I would rather spent the
> required time on reading mainline git commits to *entry.S - more
> efficient IMHO because it addresses the root of (potential!) problems.
>

It's all a matter of method, and your argument is certainly right in a
number of cases. But, we provide mechanisms to help debugging, we should
not impose policies on debugging.

> Jan
> 


-- 
Philippe.

