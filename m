Subject: Re: race in timerobj
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <332c15fb-574a-5cfc-fc65-0ed4c56657bc@siemens.com>
Date: Mon, 25 Jan 2021 15:36:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEerVHH6UECfZrQ__ai1wMhEr4Jzkz9b9H+MiSY2qjTULw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 25.01.21 15:27, Ronny Meeus wrote:
> commit b38a39bcd758872201e71c07a24d8b5e7f26c3ac
> Author: Ronny Meeus <ronny.meeus@gmail.com>
> Date:   Mon Jan 25 15:11:52 2021 +0100
> 
>     We observe an issue that the timer-list gets corrupted resulting in an
>     endless loop executed by the timer-server thread.
> 
>     During the processing of the timeout list, a pointer to the next timer
>     to be handled is kept in the tmp stack variable.
>     Just before calling the timer handler of the current timer the lock on
>     the timer list is released giving other threads the opportunity to
> change the list.
>     If the timer currently referenced by tmp is deleted, we and up with an
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

DCO (https://developercertificate.org) via signed-off-by missing.

> diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
> index 08cc0d3..b6c6abb 100644
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
> @@ -119,7 +119,12 @@ static void *timerobj_server(void *arg)
> 
>                 __RT(clock_gettime(CLOCK_COPPERPLATE, &now));
> 
> -               pvlist_for_each_entry_safe(tmobj, tmp, &svtimers, next) {
> +               for (;;) {
> +                       if (pvlist_empty(&svtimers)) {

How about "while (!pvlist_empty(&svtimers)) ..."?

> +                               break;
> +                       }
> +                       tmobj = pvlist_first_entry(&svtimers,
> typeof(*tmobj), next);
> +

And then your mail client rewraps the email. If possible, disable this,
otherwise use git send-email.

>                         value = tmobj->itspec.it_value;
>                         interval = tmobj->itspec.it_interval;
>                         handler = tmobj->handler;
> 
> 

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

