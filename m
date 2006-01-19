Message-ID: <1596.10.2.100.4.1137683264.squirrel@domain.hid>
In-Reply-To: <17359.35617.906625.920464@domain.hid>
References: <47338.83.179.137.211.1137593134.squirrel@domain.hid>
	<17359.35617.906625.920464@domain.hid>
Date: Thu, 19 Jan 2006 16:07:44 +0100 (CET)
Subject: Re: [Xenomai-core] Initialization of a nucleus pod
From: "Germain Olivier" <germain.olivier@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Thank you for your response

So rootcb isn't the "scheduler task".
I was thinking it was this task which was determining what thread to run,
depending of its parameters (priority, periodicity, scheduling mode).

I go back to the code to understand how it work ...

Germain

>
> xnthread_init does part of the initialization. The low level part of
> rootcb (its xnarchtcb_t member) is initialized twice, first by the call
> to xnarch_init_tcb in xnthread_init, and then overriden by
> xnarch_init_root_tcb in xnpod_init.
>
> For any other thread than root, the thread would be given a stack and
> entry point by the call to xnarch_init_thread in xnpod_start_thread. But
> the root thread is Xenomai idle task, a placeholder for whatever task
> Linux is currenty running. At the time where xnpod_init is called, the
> root thread is the current context, so already has a stack and is
> already running.
>
> --
>
>
> 					    Gilles Chanteperdrix.
>


