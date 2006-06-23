Subject: Re: [Xenomai-core] Condition variable
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E052DB84@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E052DB84@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 12:36:37 +0200
Message-Id: <1151058997.4438.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-06-23 at 11:48 +0200, ROSSIER Daniel wrote:
>  
> 
> Hi all,
> 
>  
> 
> Is there a particular reason to enforce the queuing policy to the
> "highest priority" thread for a variable condition?
> 

The reason was that condvar support for the native skin should closely
follow the POSIX behaviour, which uses the scheduling policy to define
the pending order of threads blocked on mutexes/condvars.

> I would expect that we can also specify a FIFO queue at the creation
> mode of such an object, as it is the case
> of other synchronization objects.

The problem I see is that a condvar must be associated with a mutex, and
since a mutex must be pended on by priority and exhibits priority
inheritance by construction, I would find rather strange to have part of
the synchronization combo behave in fifo mode, whilst the other part
enforces prio mode.

> 
>  
> 
> Thanks for your help.
> 
>  
> 
> Daniel
> 
>  
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



