Message-ID: <43DD491E.7010601@domain.hid>
Date: Mon, 30 Jan 2006 00:00:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Initialization of a nucleus pod
References: <47338.83.179.137.211.1137593134.squirrel@domain.hid>	<17359.35617.906625.920464@domain.hid>
	<1596.10.2.100.4.1137683264.squirrel@domain.hid>
In-Reply-To: <1596.10.2.100.4.1137683264.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Germain Olivier <germain.olivier@domain.hid>
Cc: xenomai@xenomai.org

Germain Olivier wrote:
> Thank you for your response
> 
> So rootcb isn't the "scheduler task".
> I was thinking it was this task which was determining what thread to run,
> depending of its parameters (priority, periodicity, scheduling mode).
> 
> I go back to the code to understand how it work ...
>

Use the simulator to understand the dynamics of this code: it brings you 
single-stepping of the entire Xenomai core over GDB, at source code level.


> Germain
> 
> 
>>xnthread_init does part of the initialization. The low level part of
>>rootcb (its xnarchtcb_t member) is initialized twice, first by the call
>>to xnarch_init_tcb in xnthread_init, and then overriden by
>>xnarch_init_root_tcb in xnpod_init.
>>
>>For any other thread than root, the thread would be given a stack and
>>entry point by the call to xnarch_init_thread in xnpod_start_thread. But
>>the root thread is Xenomai idle task, a placeholder for whatever task
>>Linux is currenty running. At the time where xnpod_init is called, the
>>root thread is the current context, so already has a stack and is
>>already running.
>>
>>--
>>
>>
>>					    Gilles Chanteperdrix.
>>
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

