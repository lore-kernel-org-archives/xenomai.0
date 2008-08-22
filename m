Message-ID: <48AEAC0B.8000608@domain.hid>
Date: Fri, 22 Aug 2008 14:07:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>	<488A073F.1090403@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170BF3DB1DB6@domain.hid>	<48ABDA75.70901@domain.hid>	<C1C62166118DFA4A8BBA01A2411F0D170E9BD4FF66@domain.hid>
	<48AC23B6.3030902@domain.hid> <48AC4A2A.8080304@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BD4FFDD@PRI-MBX-101.dom1.vinci-energies.net>
	<48AD6368.7020504@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BD5002E@PRI-MBX-101.dom1.vinci-energies.net>
	<48ADA5FF.5030703@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BD50078@domain.hid>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170E9BD50078@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BARRE Sebastien <sbarre@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

BARRE Sebastien wrote:
> * TEST 3 :
> 
> I try to put parentheses to avoid compilation warning :
> 
>                 if (xnthread_user_task(thread)->state == (TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH) ) {
>                         rpi_pop(thread);
>                         xnlock_get_irqsave(&nklock, s);
> #ifdef CONFIG_SMP
>                         /* If the task changed its CPU while in secondary mode,
>                            change the CPU of the underlying Xenomai shadow too. We
>                            do not migrate the thread timers here, it would not
>                            work. For a "full" migration comprising timers, using
>                            xnpod_migrate_thread is required. */
>                         thread->sched = xnpod_sched_slot(cpu);
> #endif /* CONFIG_SMP */
>                         xnpod_resume_thread(thread, XNRELAX);
>                         ishield_off();
>                         xnpod_schedule();
>                         xnlock_put_irqrestore(&nklock, s);
>                 }
>         }
> 
> --> the result is not the same : the test program doesn't really start, nothing is displayed on the console. Control-C stop the program.
> The system is not dammaged. I've added a printf in the test program to check if it begin to execute :

Then we have a problem. With the ipipe-longer-atomicswitch.diff, the
state of the task when the gatekeeper thread is awaken should be
TASK_INTERRUPTIBLE | TASK_ATOMICSWITCH. So, there is something wrong
with the ATOMICSWITCH patch, it does not have the expected effect.

-- 
                                                 Gilles.

