References: <20220117165341.387782-1-florian.bezdeka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] cobalt: Fix resource leak of cobalt_monitor
Date: Thu, 20 Jan 2022 09:12:05 +0100
In-reply-to: <20220117165341.387782-1-florian.bezdeka@siemens.com>
Message-ID: <871r12hksf.fsf@xenomai.org>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org, jan.kiszka@siemens.com


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> We have a test within the smokey testsuite which actually does
> something like
>
>    cobalt_monitor_init()
>    cobalt_monitor_wait()
>        cobalt_monitor_enter()
>          -> timeout
>        cobalt_monitor_exit()
>    cobalt_monitor_destroy()
>
> If the posix_mutex tests were run right after this scenario the mutex
> tests failed. The wrong mutex state was caused by the monitor in the
> previous test not being cleaned up properly.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>
> I'm not 100% sure about this fix. Maybe we should move it into
> cobalt_monitor_reclaim, maybe I'm using the monitor in a wrong way
> inside the y2038 tests. Everything is possible...
>
> @Philippe: It would be very nice if you could have a look as well.
> Thanks!
>

Looks ok, thank you for spotting this. I think the issue your patch
fixes caused a PI boost to linger since deleting the gate lock does not
drop ownership - only xnsynch_release() does so - leaving the owner with
a boosted priority unduly (*). This is likely to wreck any subsequent
test depending on the priority scheme.

You could indeed move the release call to the reclamation routine.

(*) ownership is reacquired including on a timeout condition by the call
to monitor_enter() at the end of __cobalt_monitor_wait().

-- 
Philippe.

