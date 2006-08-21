Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210447m45704e2bhd1884bce9e6a2a66@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
	<1156154538.4402.32.camel@domain.hid>
	<b647ffbd0608210347y4a863588r607c403de0640e74@domain.hid>
	<1156159631.4402.41.camel@domain.hid>
	<b647ffbd0608210446v38656cecxc231dba4e8f55dc2@domain.hid>
	<b647ffbd0608210447m45704e2bhd1884bce9e6a2a66@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 14:45:37 +0200
Message-Id: <1156164337.4402.48.camel@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 13:47 +0200, Dmitry Adamushko wrote:
>                              From: 
> Dmitry Adamushko
> <dmitry.adamushko@domain.hid>
>                                To: 
> xenomai@xenomai.org
>                           Subject: 
> [Xenomai-core] [patch, minor]
> xnpipe_recv and
> xntimer_get_timeout_periodic()
>                              Date: 
> Mon, 21 Aug 2006 13:47:00 +0200
> 
> 
> 
> 
> 
>         On Mon, 2006-08-21 at 12:47 +0200, Dmitry Adamushko wrote: 
>         >
>         > what about pipe-related change (I mean timeslice updating
>         in 
>         > xnpipe_recv()) ?
>         >
>         
>         It's basically useless, since xnsynch_sleep_on() handles the
>         resource
>         stealing case internally, and the loop in xnpipe_recv is fake
>         actually.
>         Think of it as a goto statement in disguise.
> 
> It has nothing to do with "resource stealing" (in terms of synch.c).
> The synch object is not PIP at all.
> 

Ok, I thought we were discussing a more general issue about a new
potential side-effect of the resource stealing feature.

> task1 : blocked in xnpipe_recv()
> 
> task2 : xnpipe_send() ---> wakes up task1 ---> task1 is waiting to be
> scheduled in
> 
> task3 [prio > task2.prio] : gets CPU and calls xnpipe_recv()
> 
>    task3 gets a message so state->inq is empty now.
> 
> ...
> 
> task2 : calls getq(&state->inq) which is NULL now (if there were no
> more messages)
> 
> calls xnsynch_sleep_on() again with the initial "timeout".
>   

Definitely, yes. Please ignore my previous comment. I'll apply this one,
thanks.

-- 
Philippe.



