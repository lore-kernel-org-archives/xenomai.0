Message-ID: <55870914.6040300@xenomai.org>
Date: Sun, 21 Jun 2015 20:57:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <558579E2.9070507@web.de> <5585ADDE.9070005@xenomai.org>
 <5586FA30.8020302@web.de>
In-Reply-To: <5586FA30.8020302@web.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 06/21/2015 07:53 PM, Jan Kiszka wrote:
> On 2015-06-20 20:15, Philippe Gerum wrote:
>> On 06/20/2015 04:34 PM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> the mayday mechanism is causing troubles to me again.
>>>
>>> First of all, there is a bug /wrt restarting the mayday syscall. We
>>> current don't restart on pending signals, thus destroy the register of
>>> the interrupted thread that contains the syscall return code. See my
>>> for-forge branch for a fix proposal.
>>>
>>> But actually I would like to get rid of the syscall trampoline
>>> completely if somehow possible, at least for certain archs. The reason
>>> is that it ruins debuggability. If a RT thread is stopped by gdb with
>>> the help of the mayday mechanism, it ends up waiting for resumption on
>>> the mayday page. Even worse, backtracing is broken, at least on x86.
>>>
>>> That brings me to the key question: why do we need the syscall
>>> trampoline? We set TIP_MAYDAY in the target task, the task causes
>>> IPIPE_TRAP_MAYDAY to be reported via the trap hook, the hook sets the
>>> trampoline code, the trampoline triggers the syscall, and only on
>>> syscall return, we finally migrate the task to Linux. What prevents
>>> doing the migration already in the trap hook, ie. in
>>> handle_mayday_event? The pattern seems similar to the migration we
>>> trigger on userspace faults. And it seems to works, at least for x86,
>>> and doesn't have the unwanted side effects.
>>>
>>> The background of this work is improving gdb support, in particular
>>> deterministic stopping and resuming of multi-threaded RT processes. I'm
>>> still in the design & prototype phase, RFC patches will follow later.
>>>
>>
>> Ok. The proposed design has to cover the basic case solved by the mayday
>> mechanism, i.e. a runaway thread spinning into a syscall-less loop.
>>
>> e.g. it should be able to switch such code back to secondary mode:
>>
>> 	for (;;) ;
>>
> 
> Related smokey test case passes, both on x86 and ARM. Other archs need
> to be checked carefully, though. I've pushed a commit that radically
> removes everything, but essentially does this:
> 
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index 6110da6..85e9144 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -762,16 +761,9 @@ static inline int handle_exception(struct ipipe_trap_data *d)
>  
>  static int handle_mayday_event(struct pt_regs *regs)
>  {
> -	struct xnthread *thread = xnthread_current();
> -	struct xnarchtcb *tcb = xnthread_archtcb(thread);
> -	struct cobalt_ppd *sys_ppd;
> -
> -	XENO_BUG_ON(COBALT, !xnthread_test_state(thread, XNUSER));
> +	XENO_BUG_ON(COBALT, !xnthread_test_state(xnthread_current(), XNUSER));
>  
> -	/* We enter the mayday handler with hw IRQs off. */
> -	sys_ppd = cobalt_ppd_get(0);
> -
> -	xnarch_handle_mayday(tcb, regs, sys_ppd->mayday_tramp);
> +	xnthread_relax(0, 0);
>  
>  	return KEVENT_PROPAGATE;
>  }
> 
> 
> Could you check this on the other archs?
> 

I'll check on bfin and ppc. We won't release nios2 and sh support for
3.0 eventually.

-- 
Philippe.

