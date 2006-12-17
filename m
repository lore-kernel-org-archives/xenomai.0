Subject: Re: [Adeos-main] ppc Linux(root-domain) syscall
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1166378947.458587c3ef22e@domain.hid>
References: <1166378947.458587c3ef22e@domain.hid>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 19:27:11 +0100
Message-Id: <1166380031.7818.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: barbalace@domain.hid
Cc: adeos-main@gna.org

On Sun, 2006-12-17 at 19:09 +0100, barbalace@domain.hid wrote:
> Reading Adeos patch (adeos-ipipe-2.6.14-ppc-1.3-05.patch) I see that after a
> 0xc00 (System call) is issued entry.S call __ipipe_syscall_root; this one in
> arch/ppc/kernel/ipipe-root.c dispatch the event and after this return
> eventually DoSyscall is executed if __ipipe_syscall_root return 0.
> If I don't missunderstand the code why not execute DoSyscall in the event
> dispatching?

Because you don't want to run all the code present in DoSyscall when you
don't run over the Linux domain, and the system call entry point may be
invoked from a non-Linux context, e.g. some RTOS running in parallel.
In the latter case, __ipipe_syscall root may return non-zero,
specifically 1 or -1.

The former means "the last syscall was not a Linux one, please forget
completly and exit", and the latter means "this was not a Linux syscall,
but it might have changed something Linux should be aware of, so check
for pending signals, rescheduling opportunities etc.". This is how
Xenomai interposes on all syscalls issued from a RT task in user-space,
and dispatches them depending on who wants to process it (i.e. the RTOS
kernel first, and eventually Linux if applicable).

> 
> Thanks
> Antonio
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



