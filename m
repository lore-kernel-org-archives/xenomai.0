Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 Dec 2009 10:46:29 +0100
Message-ID: <EA8B423DB69FD24FA233008019A052AE015E8275@domain.hid>
In-Reply-To: <4B1850B6.4010906@domain.hid>
References: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
	<4B1850B6.4010906@domain.hid>
From: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
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
To: xenomai@xenomai.org

=20
> Soboljew, Patrick wrote:
> > Hello all,
> >=20
> > I have a strange problem concerning the posix skin of xenomai (Ver.
> > 2.4.9.1). Whenever two or more threads call 'pthread_cond_wait' and
I=20
> > want to interrupt the program with SIGINT (CTRL-c) only the main=20
> > thread and the first thread that called 'pthread_cond_wait' get the=20
> > signal. The remaining threads are not interrupted so I have created=20
> > some zombies here. I discovered this problem when I tried to debug=20
> > some code with the ACE/TAO Framework which calls these=20
> > functions in a similar way. The debugger also has problems to
interrupt=20
> > these threads.
> >=20
> > The small code example illustrates what I did.
> >=20
> > Has anyone an idea what exactly causes this problem?
>=20
> The problem is the way pthread_cond_wait handles interruption by
> signals: the thread tries to re-acquire the mutex before=20
> returning to user-space, so as to make the system call=20
> restartable, so may be suspended if the mutex is not free=20
> (which happens for the second thread in your test program),=20
> so that it does not return to user-space, the signal remains=20
> pending and unhandled, and you get the disturbing behaviour=20
> when hitting ctrl-c or when running inside gdb.
>=20
> We can fix that by making the syscall non restartable, and=20
> let the user-space handle the mutex re-locking (which it=20
> fortunately already does).=20
>=20
> Note that restarting automatically pthread_cond_wait is not=20
> even correct, since we could miss a pthread_cond_signal if it=20
> was sent between the time when the thread was unblocked from=20
> the cond wait, and the time it starts waiting again. So, in=20
> this case, it is better to return to the caller, you get a=20
> spurious wake-up, which means that the caller must run=20
> pthread_cond_wait in a loop for the program to run correctly.
>=20
> Anyway, here is a quick fix, could you try it?
>=20
> Notes for Philippe: the quick fix does not break the ABI, but=20
> also changes the behaviour of non restartable syscalls, they=20
> forcibly return -EINTR. This may look like a disrupting=20
> change for the 2.4 branch, but there is actually currently=20
> only one non-restartable syscall in Xenomai
> 2.4: pthread_mutex_unlock, and it is ready to handle -EINTR.=20
> However, at this chance, we should mark a few more syscalls=20
> as non restartable, notably nanosleep and select, because=20
> they use relative timeouts. I think a lot of syscalls in the=20
> native skin are using relative timeouts too, and should be=20
> marked as non-restartable, but this implies documenting the=20
> return value -EINTR.
>=20
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c=20
> index 0b02f70..b361480 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -823,7 +823,7 @@ static inline void=20
> request_syscall_restart(xnthread_t *thread,
>  		if (__xn_interrupted_p(regs)) {
>  			__xn_error_return(regs,
>  					  (sysflags &=20
> __xn_exec_norestart) ?
> -					  -ERESTARTNOHAND :=20
> -ERESTARTSYS);
> +					  -EINTR : -ERESTARTSYS);
>  			notify =3D !xnthread_test_state(thread, XNDEBUG);
>  		}
> =20
> diff --git a/ksrc/skins/posix/syscall.c=20
> b/ksrc/skins/posix/syscall.c index d936f21..4c16589 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -1518,6 +1518,7 @@ static int=20
> __pthread_cond_wait_prologue(struct task_struct *curr,
>  						    timed,
>  						    XN_INFINITE);
> =20
> +#if 0
>  	if (err =3D=3D EINTR) {
>  		do {
>  			xnthread_clear_info(cur, XNKICKED);
> @@ -1528,7 +1529,7 @@ static int=20
> __pthread_cond_wait_prologue(struct task_struct *curr,
>  		xnthread_set_info(cur, XNKICKED);
>  		err =3D EINTR;
>  	}
> -
> +#endif
> =20
>  	if (!err || err =3D=3D EINTR || err =3D=3D ETIMEDOUT)
>  		__xn_copy_to_user(curr, (void __user *)=20
> __xn_reg_arg3(regs), @@ -2834,7 +2835,7 @@ static xnsysent_t=20
> __systab[] =3D {
>  	[__pse51_cond_init] =3D {&__pthread_cond_init, __xn_exec_any},
>  	[__pse51_cond_destroy] =3D {&__pthread_cond_destroy,=20
> __xn_exec_any},
>  	[__pse51_cond_wait_prologue] =3D
> -	{&__pthread_cond_wait_prologue, __xn_exec_primary},
> +	{&__pthread_cond_wait_prologue, __xn_exec_primary |=20
> +__xn_exec_norestart},
>  	[__pse51_cond_wait_epilogue] =3D
>  	    {&__pthread_cond_wait_epilogue, __xn_exec_primary},
>  	[__pse51_cond_signal] =3D {&__pthread_cond_signal, __xn_exec_any},
>=20
> --=20
> 					    Gilles.

Perfect, you made my day. Now it works as expected. Will this patch find
its way into xenomai 2.4.x or do we have to change to xenomai 2.5 in the
near future?


