References: <CAMJ=MEfkw3N1O1t3Nic10sdYO6hrUU7OOR5=a0wi61w1V-23vA@mail.gmail.com>
 <8149f85c-4d2e-8411-ee9a-86669c5a1532@siemens.com>
 <CAMJ=MEeCbvzH8QjbZxAQd9H3fcCdNcYphqAXdHsBiUiXyXtUyw@mail.gmail.com>
 <878sah7hyu.fsf@xenomai.org>
 <CAMJ=MEc-Vs-pGXgzjxpM9m6BYMFvAHctm=bafHtmtXwsSf97Pg@mail.gmail.com>
 <871rg54mkh.fsf@xenomai.org>
 <CAMJ=MEdgoosLDBA+veLs48tSDJs_sx5ZaRbt+sLWPmq95bcEsw@mail.gmail.com>
 <CAMJ=MEdDpgNxtw4NjEmfYP7Hqcxa0W4q29UO=eWuds0tKxcXuw@mail.gmail.com>
 <90061cec-1289-025e-8896-5d85df0d1817@siemens.com>
 <CAMJ=MEerVHH6UECfZrQ__ai1wMhEr4Jzkz9b9H+MiSY2qjTULw@mail.gmail.com>
 <332c15fb-574a-5cfc-fc65-0ed4c56657bc@siemens.com>
 <CAMJ=MEfinqZnOe0tR2pd9y52y+pPN3Nz=HhggusSmpR+nX=Jrw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: race in timerobj
In-reply-to: <CAMJ=MEfinqZnOe0tR2pd9y52y+pPN3Nz=HhggusSmpR+nX=Jrw@mail.gmail.com>
Date: Mon, 25 Jan 2021 16:56:15 +0100
Message-ID: <87r1m93t9c.fsf@xenomai.org>
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
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Ronny Meeus <ronny.meeus@gmail.com> writes:

> Jan,
>
> This is my last attempt since I do not want to waste more time on this issue.
> Feel free to change whatever you want to the patch.
> I put my gmail in the correct mode but it keeps on wrapping
> the text and git email also doesn't work (we do not use git overhere)
>
> Best regards,
> Ronny
>
> commit 352b0355f617bfbb38f9bd7b1f7d74967f44c857
> Author: Ronny Meeus <ronny.meeus@gmail.com>
> Date:   Mon Jan 25 15:11:52 2021 +0100
>
>     copperplate/timerobj: fix corrupted timer list.
>
>     We observe an issue that the timer-list gets corrupted resulting in an
>     endless loop executed by the timer-server thread.
>
>     During the processing of the timeout list, a pointer to the next timer
>     to be handled is kept in the tmp stack variable.
>     Just before calling the timer handler of the current timer the lock on
>     the timer list is released giving other threads to change the list.
>     If the timer currently referenced by tmp is deleted, we end up with an
>     invalid node (next pointer pointing to itself) and this will result in
>     an endless loop of the timer server.
>
>     Test code is not available but I have seen this issue in our real
>     production code and after applying this path, the issue is solved.
>
>     The patch basically changes the timer server logic to always start
>     from the beginning of the list since when a timer is processed, it is
>     either removed (one-shot) or reinserted in a different location in the
>     list.
>     The processing of the list will stop anyhow if all timers that need
>     to expire up to "now" are handled.
>
>     Signed-off-by: Ronny Meeus <ronny.meeus@gmail.com>
>
> diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
> index 08cc0d3..96ad2e5 100644
> --- a/lib/copperplate/timerobj.c
> +++ b/lib/copperplate/timerobj.c
> @@ -100,7 +100,7 @@ static void *timerobj_server(void *arg)
>  {
>         void (*handler)(struct timerobj *tmobj);
>         struct timespec now, value, interval;
> -       struct timerobj *tmobj, *tmp;
> +       struct timerobj *tmobj;
>         sigset_t set;
>         int sig, ret;
>
> @@ -119,7 +119,9 @@ static void *timerobj_server(void *arg)
>
>                 __RT(clock_gettime(CLOCK_COPPERPLATE, &now));
>
> -               pvlist_for_each_entry_safe(tmobj, tmp, &svtimers, next) {
> +               while (!pvlist_empty(&svtimers)) {
> +                       tmobj = pvlist_first_entry(&svtimers,
> typeof(*tmobj), next);
> +
>                         value = tmobj->itspec.it_value;
>                         interval = tmobj->itspec.it_interval;
>                         handler = tmobj->handler;
>
>

Ack, thanks.

-- 
Philippe.

