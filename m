Subject: Antwort: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task
	mode and task priority
Message-ID: <OF57C5E5AF.FD2C8432-ONC1257272.005A3F8F@uk.marconicomms.com>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Mon, 29 Jan 2007 17:41:37 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
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
Cc: xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>


Hi Philippe,

see below a code snippet for demonstration of the task priority problem.
The expected behaviour is that the new task is running immediately after
lowering root's priority.
The log of the reached statements should therefor be: 1, 10, 2, 3, 4, 5
But instead the log is: 1, 2, 3, 4, 10, 5, i.e. the new task is running
only after blocking root task.

About your question regarding the preemtible bit:
The task should always be non-preemtible, also after it is unblocked.

Thank you

Regards
Markus






u_long log_array[10];
u_long log_idx=0;

void task1 (void)
{
    for(;;)
    {
        log_array[log_idx++] = 10; /* we reached this statement, log it */

        /* do some stuff which could block, for demo do a tm_wkafter */
        tm_wkafter(200);
    }
}

void root(void)
{
    u_long dummy, tid, i;


    /* set root's prio to a very high value */
    t_setpri(0, 240, &dummy);
    /* confirm that root is preemptible */
    t_mode(T_NOPREEMPT, T_PREEMPT, &dummy);

    /* create/start all tasks, for demo only one task */
    for (i=0; i<1; i++)
    {
        /* create a new task with prio 80 */
        t_create("TSK1", 80, 0x1000, 0, T_LOCAL|T_NOFPU, &tid);
        /* start the new task as preemptible */
        t_start(tid, T_PREEMPT|T_NOTSLICE|T_SUPV|T_NOASR, (void(*)(u_long,
u_long, u_long, u_long))task1, NULL);

        log_array[log_idx++] = 1; /* we reached this statement, log it */

        /* lower root's prio to one less than new task's prio */
        t_setpri(0, 80-1, &dummy);

        log_array[log_idx++] = 2; /* we reached this statement, log it */

        /* set root's prio back to the high value */
        t_setpri(0, 240, &dummy);

        log_array[log_idx++] = 3; /* we reached this statement, log it */
    }

    /* after starting all tasks, set root's prio to the final value */
    t_setpri(0, 220, &dummy);

    log_array[log_idx++] = 4; /* we reached this statement, log it */

    /* do some stuff which could block, for demo do a tm_wkafter */
    tm_wkafter(100);

    log_array[log_idx++] = 5; /* we reached this statement, log it */

    /* print the log */
    for (i=0; i<6; i++)
    {
        printf("%d ", log_array[i]);
    }
    printf("\n");
    exit(0);
}







On Mon, 2007-01-29 at 14:25 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-01-26 at 18:16 +0100, Thomas Necker wrote:
> >
> >>Hi Philippe
> >>
> >>
> >>>>non-preemptive mode.
> >>>>With original pSOS this was allowed and "non-preemptive" meant that a
> >>>>runnable task cannot be preempted by other tasks but can block
itself.
> >>>>Why is this different in Xenomai and is it possible to implement the
> >>
> >>same
> >>
> >>>>behaviour in Xenomai core?
> >>>>
> >>>
> >>>Xenomai implements the non-preemptible mode as most RTOSes implement
> >>>scheduling locks. From this POV, allowing a non-preemptible task to
> >>>block makes no sense, and doing so usually either locks up the board,
or
> >>>causes an API error.
> >>>
> >>>It could be possible to switch the preemption bit on before entering a
> >>>blocking state only for pSOS tasks, then reinstate it when the task
> >>>wakes up, though. However, before going down that path, is there any
> >>>pSOS documentation that clearly states that such behaviour is to be
> >>>expected (i.e. that blocking calls _may_ be called in non-preemptible
> >>>mode)?
> >>>
> >>>Or did you benefit from an undocumented and fortunate side-effect of
the
> >>>pSOS implementation when relying on such behaviour?
> >>
> >>Since Markus has already left, I had a quick look in the pSOS System
> >>Concepts Manual:
> >>
> >>    Each task has a mode word, with two settable bits that can affect
> >>scheduling.
> >>    One bit controls the task's preemptibility. If disabled, then once
the
> >>task
> >>    enters the running state, it will stay running even if other tasks
> >>    of higher priority enter the ready state. A task switch will occur
> >>only if
> >>    the running task blocks, or if it re-enables preemption.
> >>
> >>So it clearly states that a non-preemtible task may block (and
> >>rescheduling occurs in
> >>this case).
> >
> >
> > Ok, so this is a must fix. Will do. Thanks for reporting.
>
> I had a look at the OSEK specification, it also has non-preemptible
> tasks. So, I guess we should add an xnpod_locked_schedule that simply
does
>
> if (xnthread_test_state(xnpod_current_sched()->runthread, XNLOCK)) {
>            xnpod_unlock_sched();
>            xnpod_lock_sched();
> } else
>            xnpod_schedule();
>
> and call this xnpod_locked_schedule() instead of xnpod_schedule() in
> these skins.

Ack, would do. Thomas, could you confirm that the preemptible bit is
raised again for the task when it is scheduled back in?

>
>
>
>
--
Philippe.



_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core







