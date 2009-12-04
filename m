From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B1850B6.4010906@domain.hid>
References: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
	<4B1850B6.4010906@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 10:59:39 +0100
Message-ID: <1259920779.2174.77.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with pthread_cond_wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>, xenomai@xenomai.org

On Fri, 2009-12-04 at 00:58 +0100, Gilles Chanteperdrix wrote:
> Soboljew, Patrick wrote:
> > Hello all,
> > 
> > I have a strange problem concerning the posix skin of xenomai (Ver.
> > 2.4.9.1). Whenever two or more threads call 'pthread_cond_wait' and I
> > want to interrupt the program with SIGINT (CTRL-c) only the main thread
> > and the first thread that called 'pthread_cond_wait' get the signal. The
> > remaining threads are not interrupted so I have created some zombies
> > here. I discovered this problem when I tried to debug some code with the
> > ACE/TAO Framework which calls these functions in a similar way. The
> > debugger also has problems to interrupt these threads.
> > 
> > The small code example illustrates what I did.
> > 
> > Has anyone an idea what exactly causes this problem?
> 
> The problem is the way pthread_cond_wait handles interruption by 
> signals: the thread tries to re-acquire the mutex before returning to 
> user-space, so as to make the system call restartable, so may be 
> suspended if the mutex is not free (which happens for the second thread 
> in your test program), so that it does not return to user-space, the 
> signal remains pending and unhandled, and you get the disturbing 
> behaviour when hitting ctrl-c or when running inside gdb.
> 
> We can fix that by making the syscall non restartable, and let the 
> user-space handle the mutex re-locking (which it fortunately already 
> does). 
> 
> Note that restarting automatically pthread_cond_wait is not even 
> correct, since we could miss a pthread_cond_signal if it was sent 
> between the time when the thread was unblocked from the cond wait, and 
> the time it starts waiting again. So, in this case, it is better to 
> return to the caller, you get a spurious wake-up, which means that the 
> caller must run pthread_cond_wait in a loop for the program to run 
> correctly.
> 
> Anyway, here is a quick fix, could you try it?
> 
> Notes for Philippe: the quick fix does not break the ABI, but also 
> changes the behaviour of non restartable syscalls, they forcibly return 
> -EINTR. This may look like a disrupting change for the 2.4 branch, but 
> there is actually currently only one non-restartable syscall in Xenomai 
> 2.4: pthread_mutex_unlock, and it is ready to handle -EINTR. However, at
> this chance, we should mark a few more syscalls as non restartable, 
> notably nanosleep and select, because they use relative timeouts. I 
> think a lot of syscalls in the native skin are using relative timeouts 
> too, and should be marked as non-restartable, but this implies
> documenting the return value -EINTR.

This seems the wrong approach, at the very least for the native skin.
-EINTR is already used and documented there, as a possible return value
for blocking syscalls which have been forcibly unblocked (i.e. via
rt_task_unblocked()).

Returning -EINTR upon signal interrupt as well would confuse the
application, i.e. what was the actual reason for that syscall to return?
As a corollary, a bunch of applications are currently not handling
-EINTR, precisely because rt_task_unblock() is not used in their
application; so making all timed syscalls non-restartable might break
them badly.

The best fix would rather to convert relative timeouts to their
XN_REALTIME form internally, the way it is done for a few syscalls in
2.5 already.

> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index 0b02f70..b361480 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -823,7 +823,7 @@ static inline void request_syscall_restart(xnthread_t *thread,
>  		if (__xn_interrupted_p(regs)) {
>  			__xn_error_return(regs,
>  					  (sysflags & __xn_exec_norestart) ?
> -					  -ERESTARTNOHAND : -ERESTARTSYS);
> +					  -EINTR : -ERESTARTSYS);
>  			notify = !xnthread_test_state(thread, XNDEBUG);
>  		}
>  
> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
> index d936f21..4c16589 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -1518,6 +1518,7 @@ static int __pthread_cond_wait_prologue(struct task_struct *curr,
>  						    timed,
>  						    XN_INFINITE);
>  
> +#if 0
>  	if (err == EINTR) {
>  		do {
>  			xnthread_clear_info(cur, XNKICKED);
> @@ -1528,7 +1529,7 @@ static int __pthread_cond_wait_prologue(struct task_struct *curr,
>  		xnthread_set_info(cur, XNKICKED);
>  		err = EINTR;
>  	}
> -
> +#endif
>  
>  	if (!err || err == EINTR || err == ETIMEDOUT)
>  		__xn_copy_to_user(curr, (void __user *) __xn_reg_arg3(regs),
> @@ -2834,7 +2835,7 @@ static xnsysent_t __systab[] = {
>  	[__pse51_cond_init] = {&__pthread_cond_init, __xn_exec_any},
>  	[__pse51_cond_destroy] = {&__pthread_cond_destroy, __xn_exec_any},
>  	[__pse51_cond_wait_prologue] =
> -	{&__pthread_cond_wait_prologue, __xn_exec_primary},
> +	{&__pthread_cond_wait_prologue, __xn_exec_primary | __xn_exec_norestart},
>  	[__pse51_cond_wait_epilogue] =
>  	    {&__pthread_cond_wait_epilogue, __xn_exec_primary},
>  	[__pse51_cond_signal] = {&__pthread_cond_signal, __xn_exec_any},
> 


-- 
Philippe.



