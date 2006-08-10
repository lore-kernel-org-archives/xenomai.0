Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 00:13:08 +0200
Message-Id: <1155247988.4297.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, andrewg@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

On Wed, 2006-08-09 at 11:35 +0200, Dmitry Adamushko wrote: 
> 
> Hello,
>  
> 
>         I'm not that deep into rt_task_send/receive design, but this
>         problem
>         seems to be related to some heavy disagree between
>         xnsynch_sleep_on and 
>         rt_task_send about the correct ownership of the receiver's
>         send queue. 
> 
> 
> Not transfering the ownership causes this problem, yes. But looking
> briefly at the code... there is even yet another problem (if I haven't
> overlooked something) that also exists in 2.1.
> 
> rt_task_reply() wakes up a sender with : 
> 
> [code]
> 
> if (receiver->wait_args.mps.mcb_s.flowid == flowid) {
>                         /* Note that the following will cause the
> receiver to be
>                            unblocked without transferring the
> ownership of the
>                            msendq object, since we want the sender to
> keep it. */
>                         xnpod_resume_thread(&receiver->thread_base,
> XNPEND);
>                         break;
> 
> [/code]
> 
> 
> Now let's suppose : sender.prio > recv.prio
> 
> so recv.prio is boosted when sender executes xnsynch_sleep_on().
> 
> The "recv" task (the one that calls rt_task_receive() and
> rt_task_reply()) doesn't use xnsynch_* functions (like
> xnsynch_wakeup_this_sleeper() ) to actually wake up the sender.
> Therefore xnsynch_clear_boost() is never called and "recv" keeps
> temporarily inhereted priority as a permanent one from now on.
> No? 
> 

No. xnpod_resume_thread() detects that the sender is pending on the
msendq, and eventually calls xnsynch_forget_sleeper(), which removes the
sender from the pend queue, then clears the boost.

The problem is triggered by synch->owner being cleared in
xnsynch_flush(), as a result of the receiver task to exit (called from
the native task deletion hook, i.e. xnsynch_destroy(&task->msendq)).
The problem to fix is indeed in xnsynch_sleep_on(), but it's rather a
matter of making sure that the awakened thread is not going to check the
owner field of a synch object that has just been destroyed.

> I have a few ideas on how to fix it intelegently so if Philippe will
> not come up with a quick solution, I may take a look?
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



