References: <20220117165341.387782-1-florian.bezdeka@siemens.com>
 <871r12hksf.fsf@xenomai.org>
 <6a63cc2c027ba27c07852f91d9e2067760068e94.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] cobalt: Fix resource leak of cobalt_monitor
Date: Sat, 22 Jan 2022 19:16:33 +0100
In-reply-to: <6a63cc2c027ba27c07852f91d9e2067760068e94.camel@siemens.com>
Message-ID: <87lez7d2bs.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Thu, 2022-01-20 at 09:12 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > We have a test within the smokey testsuite which actually does
>> > something like
>> > 
>> >    cobalt_monitor_init()
>> >    cobalt_monitor_wait()
>> >        cobalt_monitor_enter()
>> >          -> timeout
>> >        cobalt_monitor_exit()
>> >    cobalt_monitor_destroy()
>> > 
>> > If the posix_mutex tests were run right after this scenario the mutex
>> > tests failed. The wrong mutex state was caused by the monitor in the
>> > previous test not being cleaned up properly.
>> > 
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> > 
>> > I'm not 100% sure about this fix. Maybe we should move it into
>> > cobalt_monitor_reclaim, maybe I'm using the monitor in a wrong way
>> > inside the y2038 tests. Everything is possible...
>> > 
>> > @Philippe: It would be very nice if you could have a look as well.
>> > Thanks!
>> > 
>> 
>> Looks ok, thank you for spotting this. I think the issue your patch
>> fixes caused a PI boost to linger since deleting the gate lock does not
>> drop ownership - only xnsynch_release() does so - leaving the owner with
>> a boosted priority unduly (*). This is likely to wreck any subsequent
>> test depending on the priority scheme.
>> 
>> You could indeed move the release call to the reclamation routine.
>
> Checked that again and my conclusion is that the current location is
> correct and it should not be moved into cobalt_monitor_reclaim.
>
> Reasoning: cobalt_monitor_reclaim is called by cobalt_process_detach()
> as well, but there is no owner check like in CoBaLt_monitor_destroy.
>
> Do you agree?
>

I guess you want me to look at the code at this point. Ok, let's try
this. On task exit, PI is cleared when either release_all_ownerships()
or xnsynch_release() are called, whichever comes first. For a thread
which belongs to the Cobalt personality, the exit sequence may include
in that order:

1. __handle_taskexit_event
        cobalt_remove_process
                cobalt_process_detach
                        __reclaim_resource
                                cobalt_monitor_reclaim
                                        xnsynch_destroy => flush waiters, clear PI
2. __xnthread_cleanup
        release_all_ownerships => monitor already destroyed, no lock held

So, despite the fact that an exiting thread drops all ownerships on
locks only _after_ the resources it owns have been reclaimed, this
should be ok to keep the release out of the reclamation code, because
all waiters were flushed prior to that point, plus the lock owner exits
anyway (unlike in the plain monitory_destroy() case).

So yes, you are right and I was likely off base when mentioning the move
to the reclamation code. You may want to double-check that taking a
termination signal while holding a monitor does indeed what I just
described though.

shameless plug: the v3 way of doing resource management is overly
complicated and somewhat fragile, would benefit from a serious
streamlining effort. v4 does much, much better by simply relying on the
common VFS for this part.

-- 
Philippe.

