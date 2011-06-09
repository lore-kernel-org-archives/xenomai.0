From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DF0CBDA.9080300@domain.hid>
References: <4DF0BFA8.9070003@domain.hid>
	<1307624711.2139.5.camel@domain.hid>  <4DF0CBDA.9080300@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 15:48:37 +0200
Message-ID: <1307627317.2139.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Oops with synchronous message passing support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2011-06-09 at 15:34 +0200, Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> On 06/09/2011 03:05 PM, Philippe Gerum wrote:
> > On Thu, 2011-06-09 at 14:42 +0200, Wolfgang Grandegger wrote:
> >> Hello,
> >>
> >> I just realized a problem with synchronous message passing support. When
> >> rt_task_send() send times out, I get the oops below from line:
> >>
> > 
> > Does this help?
> > 
> > diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
> > index b822fd0..b0e99a7 100644
> > --- a/ksrc/skins/native/task.c
> > +++ b/ksrc/skins/native/task.c
> > @@ -1988,21 +1988,28 @@ int rt_task_receive(RT_TASK_MCB *mcb_r, RTIME timeout)
> >  	}
> >  
> >  	/*
> > -	 * Wait on our receive slot for some client to enqueue itself
> > -	 * in our send queue.
> > +	 * We loop to care for spurious wakeups, in case the
> > +	 * client times out before we unblock.
> >  	 */
> > -	info = xnsynch_sleep_on(&server->mrecv, timeout, XN_RELATIVE);
> > -	/*
> > -	 * XNRMID cannot happen, since well, the current task would be the
> > -	 * deleted object, so...
> > -	 */
> > -	if (info & XNTIMEO) {
> > -		err = -ETIMEDOUT;	/* Timeout. */
> > -		goto unlock_and_exit;
> > -	} else if (info & XNBREAK) {
> > -		err = -EINTR;	/* Unblocked. */
> > -		goto unlock_and_exit;
> > -	}
> > +	do {
> > +		/*
> > +		 * Wait on our receive slot for some client to enqueue
> > +		 * itself in our send queue.
> > +		 */
> > +		info = xnsynch_sleep_on(&server->mrecv, timeout, XN_RELATIVE);
> > +		/*
> > +		 * XNRMID cannot happen, since well, the current task
> > +		 * would be the deleted object, so...
> > +		 */
> > +		if (info & XNTIMEO) {
> > +			err = -ETIMEDOUT;	/* Timeout. */
> > +			goto unlock_and_exit;
> > +		}
> > +		if (info & XNBREAK) {
> > +			err = -EINTR;	/* Unblocked. */
> > +			goto unlock_and_exit;
> > +		}
> > +	} while (!xnsynch_pended_p(&server->mrecv));
> >  
> >  	holder = getheadpq(xnsynch_wait_queue(&server->msendq));
> >  	/* There must be a valid holder since we waited for it. */
> 
> Yes, it does help:
> 
>   -bash-3.2# ./oops_sender
>   pre-rt_task_receive()
>   rt_task_send() failed: -110 (Connection timed out)
>   Killing child
> 
> No more oops, thanks for your quick help.

Ok, thanks for reporting. Patch queued.

> 
> Wolfgang.
> 
> 

-- 
Philippe.



