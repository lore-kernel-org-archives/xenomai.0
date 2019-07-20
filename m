Subject: Re: Asynchronous notify?
References: <CAFLxGvwmtY6MD1LLJ9PbjXOp9a_7nNnVRCOKRkJQ1VA-d_QM2Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <baae67c1-504e-410a-54c7-09b20edac153@xenomai.org>
Date: Sat, 20 Jul 2019 21:45:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwmtY6MD1LLJ9PbjXOp9a_7nNnVRCOKRkJQ1VA-d_QM2Q@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 7/19/19 12:26 PM, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> Is there a way in Xenomai 3 to have a signal alike notification?

Yes, but not async. Only the sigwait*() interface is available (async
notification does not mix well with requirement for deterministic
behavior of rt code, it's even worse when it comes to POSIX signal
semantics).

> 
> The Xenomai 2 code base I work on needs a way to get exceptions such
> as #DB and #BP
> delivered to a RT_TASK in real time context.

#DB and #BP should cause a switch to secondary mode for the receiving
task. Is this mechanism a way to handle this directly from primary mode?

> For Xenomai 2 they implemented a subset of regular RT-signals which
> work in real time context.
> So the RT_TASK could register a signal handler for #DB on x86.
> 
> Before I start porting this feature to Xenomai 3 (I'll happily publish
> these patches) I want
> to sort out whether this can be achieved with stock features or
> minimal adoptions.
> 

Duplicating the signal trampoline stuff for the purpose of delivering
signals from primary mode directly from the receiving context is likely
to be ugly. Another option would be to do that on return from the
syscall trampoline, but this would require arch-dependent code in the
fast path, which would not be pretty either.

FWIW, here is the way I would convert any trap to a POSIX signal the
cobalt API could deliver via the existing sigwait interface, in order to
enable some kind of health monitoring thread:

- I would divert one of the legit POSIX signals (1 ... _NSIG) for
conveying such information (SIGUSRx?).

- in handle_exception() (posix/process.c), I would emit that signal via
the __cobalt_sigqueue() interface, using sigval to carry the trap code
(e.g. #DB). Siginfo's si_pid would be automatically set there to the
faulting process pid.

This would implement a group-targeted signal, which means that any
thread waiting for that event would receive it, along with the fault
code. Otherwise, the event would be queued until some thread eventually
issues sigwait() for it (e.g. the HM thread returning from a previous
signal handling).

-- 
Philippe.

