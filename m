Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
References: <cover.1625777265.git.jan.kiszka@siemens.com>
 <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
 <5185508f-d8b7-fb49-de71-65c70eb33f8a@siemens.com>
 <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
Date: Tue, 20 Jul 2021 11:27:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>

On 20.07.21 09:57, Richard Weinberger wrote:
> On Mon, Jul 19, 2021 at 4:42 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> We have kind of a similar case in our backlog. The application expects
>> to handle certain FPU-related faults gracefully, i.e. without falling
>> out of RT with the causing thread, using a context update to bring it on
>> the road again.
>>
>> We modeled that case on top of the debug monitor thread, waking it up
>> also on such faults and giving it a chance to remotely fix up the
>> triggering thread.
> 
> Yeah, sounds related and I think useful for our case too.
> 
>>>
>>> 2. Break point handling:
>>> The runtime allows instrumenting of programs it executes. A system
>>> operator can mark code paths
>>> to see how often they are executed. So the runtime installs a break
>>> point instruction at the desired
>>> place and handles the breakpoint exception in the primary domain where
>>> just a counter
>>> is incremented.
>>> Although this slows down execution and hurts the system response time
>>> it is still fast enough
>>> to satisfy our real-time requirements.
>>> On the other hand switching to the secondary domain is far too expensive.
>>
>> But this is not debugging, this is UPROBES / UPROBE_EVENTS, no? Maybe
>> better make that work with oob if it does not yet.
> 
> I don't disagree that uprobes might help but the whole point of our patch
> is exception delivery to userspace. How userspace uses the exception is
> not set in stone.
> For example, the application itself is modifying the code and places
> breakpoint instructions.
> Another obstacle is that the application that runs on top of the
> Xenomai based framework
> is not a regular Linux application, it does not even follow the
> calling convention, I bet this
> makes things with uprobes not easier.
> 
>>
>>>
>>> Maybe we can combine both approaches? We'll happily port the current
>>> patch to Xenomai 3.1
>>> and give the monitor thread approach a try.
>>>
>>
>> I'd like to see how you implemented that signal-like context switching
>> in your approach. That is where I shied away from, rather using a thread
>> switch plus a (not too nice, granted) mcontext get/set for other threads.
> 
> The key is ipipe_trap_hook().
> __ipipe_notify_trap() passes a struct pt_regs of the trapping task to
> ipipe_trap_hook(). In ipipe_trap_hook() a signal frame is placed on
> the stack and
> program counter, stack pointer, etc. in pt_regs are set accordingly.
> After ipipe_trap_hook() returns, the entry logic in arch/arm/ or
> arch/x86/ will restore
> from the modified pt_regs and the trapping task executes the signal handler.
> 
>> My current understanding is that a real-time domain signal mechanism
>> will require changes in the pipeline patch underneath, thus first of all
>> needs to be sold to the dovetail infrastructure (and then we can discuss
>> if we backport that to ipipe anymore).
> 
> I'm pretty sure our approach has issues but so far no changes to ipipe
> are needed.
> 

Then look at dovetail - ipipe will vanish. I'm pretty sure now your
approach faces the same issue like we do /wrt not delivering fixed-up
faults.

If that is the case, we should first of all ensure that the foundation
is provided by the pipeline. Then we can sort out the API model and
implementation details at Xenomai-level.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

