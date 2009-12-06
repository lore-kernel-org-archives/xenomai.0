From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B18DFD6.1030907@domain.hid>
References: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
	<4B1850B6.4010906@domain.hid>
	<1259920779.2174.77.camel@domain.hid>
	<4B18DFD6.1030907@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Dec 2009 18:22:19 +0100
Message-ID: <1260120139.2174.154.camel@domain.hid>
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

On Fri, 2009-12-04 at 11:09 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Fri, 2009-12-04 at 00:58 +0100, Gilles Chanteperdrix wrote:
> >> Soboljew, Patrick wrote:
> >>> Hello all,
> >>>
> >>> I have a strange problem concerning the posix skin of xenomai (Ver.
> >>> 2.4.9.1). Whenever two or more threads call 'pthread_cond_wait' and I
> >>> want to interrupt the program with SIGINT (CTRL-c) only the main thread
> >>> and the first thread that called 'pthread_cond_wait' get the signal. The
> >>> remaining threads are not interrupted so I have created some zombies
> >>> here. I discovered this problem when I tried to debug some code with the
> >>> ACE/TAO Framework which calls these functions in a similar way. The
> >>> debugger also has problems to interrupt these threads.
> >>>
> >>> The small code example illustrates what I did.
> >>>
> >>> Has anyone an idea what exactly causes this problem?
> >> The problem is the way pthread_cond_wait handles interruption by 
> >> signals: the thread tries to re-acquire the mutex before returning to 
> >> user-space, so as to make the system call restartable, so may be 
> >> suspended if the mutex is not free (which happens for the second thread 
> >> in your test program), so that it does not return to user-space, the 
> >> signal remains pending and unhandled, and you get the disturbing 
> >> behaviour when hitting ctrl-c or when running inside gdb.
> >>
> >> We can fix that by making the syscall non restartable, and let the 
> >> user-space handle the mutex re-locking (which it fortunately already 
> >> does). 
> >>
> >> Note that restarting automatically pthread_cond_wait is not even 
> >> correct, since we could miss a pthread_cond_signal if it was sent 
> >> between the time when the thread was unblocked from the cond wait, and 
> >> the time it starts waiting again. So, in this case, it is better to 
> >> return to the caller, you get a spurious wake-up, which means that the 
> >> caller must run pthread_cond_wait in a loop for the program to run 
> >> correctly.
> >>
> >> Anyway, here is a quick fix, could you try it?
> >>
> >> Notes for Philippe: the quick fix does not break the ABI, but also 
> >> changes the behaviour of non restartable syscalls, they forcibly return 
> >> -EINTR. This may look like a disrupting change for the 2.4 branch, but 
> >> there is actually currently only one non-restartable syscall in Xenomai 
> >> 2.4: pthread_mutex_unlock, and it is ready to handle -EINTR. However, at
> >> this chance, we should mark a few more syscalls as non restartable, 
> >> notably nanosleep and select, because they use relative timeouts. I 
> >> think a lot of syscalls in the native skin are using relative timeouts 
> >> too, and should be marked as non-restartable, but this implies
> >> documenting the return value -EINTR.
> > 
> > This seems the wrong approach, at the very least for the native skin.
> > -EINTR is already used and documented there, as a possible return value
> > for blocking syscalls which have been forcibly unblocked (i.e. via
> > rt_task_unblocked()).
> > 
> > Returning -EINTR upon signal interrupt as well would confuse the
> > application, i.e. what was the actual reason for that syscall to return?
> > As a corollary, a bunch of applications are currently not handling
> > -EINTR, precisely because rt_task_unblock() is not used in their
> > application; so making all timed syscalls non-restartable might break
> > them badly.
> > 
> > The best fix would rather to convert relative timeouts to their
> > XN_REALTIME form internally, the way it is done for a few syscalls in
> > 2.5 already.
> 
> Yeah, but that would be an ABI change.

The native userland interface always passes timeout args to the kernel
by address, so we may have another option.

> 
> In the mean time, I thought more about that: actually, syscalls with
> relative timeouts are restartable if the timeout is passed by pointer
> and the syscall updates the timeout upon interruption by a signal, the
> way nanosleep does (so, in a sense, nanosleep is restartable, contrarily
> to what I said). Even select could be restartable, but the specification
> mandates that it returns EINTR upon interruption by a signal and is not
> restarted automatically.
> 


-- 
Philippe.



