References: <3319d6fa-2541-67bf-f03b-15b440a1b8a6@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <babd4b2f-eee6-e5a7-ac1f-4f409c6a828b@xenomai.org>
Date: Tue, 10 Jul 2018 10:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <3319d6fa-2541-67bf-f03b-15b440a1b8a6@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Eager FPU vs. recent kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 07/09/2018 07:48 PM, Jan Kiszka wrote:
> Hi,
> 
> the x86 FPU changes that so far only affected 4.14 and delayed its ipipe
> progress on that arch. However, CVE-2018-3665 is not making it a topic
> for every ipipe kernel (that should be kept up to date): lazy FPU is
> history, now also for security reasons (before that only for performance
> reasons).
> 
> That raises the question how much the Xenomai 3 core depends on lazy FPU
> state switching.

This is a cobalt/arch/x86 issue. On the one hand, FPU management is lazy
there because XNFPU drives FPU handling, and that flag is only set in a
TCB when the first FPU fault is taken over the corresponding task. On
the other hand, FPU switching has always been fundamentally eager in
cobalt/arch/x86.c, only coping with Linux's laziness. The latter part is
what makes this arch-support code so tricky and prone to regression.

> Philippe, can you describe the general flow of context
> switching /wrt the FPU state so far?

x86-wise, I would not say there is a general flow, only a collection of
corner cases due to the mix between lazy and eager mode constraints,
which are somewhat documented in xnarch_switch_fpu().

- xnarch_switch_fpu() is called from the generic scheduler bits upon
context switch, only if XNFPU is set in the outgoing task's TCB.

- xnarch_handle_fpu_fault() tracks first use of the FP unit, raising
XNFPU in the faulting task's TCB.

- we have to deal with the situation where a rt thread is preempting the
regular kernel in the middle of a kernel_fpu_begin/kernel_fpu_end
section, which leads to maintaining some sort of extra backup area for
fpregs used in kernel context in the core (kfpu boolean).

 Can we overcome lazy by just
> replacing the current FPU functions in kernel/cobalt/arch/x86/thread.c
> with eager ones, maybe depending on some CONFIG_IPIPE_X86_HAS_EAGER_FPU
> compile-time dependency?
> 

I believe that the only sane way of dealing with the FPU is to stop
dealing with it in the real-time core entirely, this always has been a
mess, still is, and surely would be in the future. I would rather rely
on the regular switch_to logic for this part too (this proved to work on
ARM in a different context than Xenomai).

This means that the I-pipe should deal with possible preemption of
regular Linux tasks by a co-kernel context FPU-wise, instead of
outsourcing those bits in the arch-bits of Xenomai.

PS: I'm deeply buried in a full incremental split of the x86 pipeline
code at the moment. This builds over the first pass done months ago, but
this time reorganizing the code in a series of commits actually allowing
for an incremental build. The purpose is two-fold:

- decouple the basics of IRQ pipelining from the support for co-managing
tasks with Linux, so that it is possible to port/upgrade to a different
kernel release piece by piece, cherry picking the basic bits required
for pipelining and making them work first, then continuing with the
task-related stuff (trap/fault handling, kernel event notification,
syscall routing then domain migration).

- document each and every commit from the stack with respect to its purpose.

Once I'm done with that, I'll go back focusing on my ARM games.

-- 
Philippe.

