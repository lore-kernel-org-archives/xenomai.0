References: <CAMJ=MEfkw3N1O1t3Nic10sdYO6hrUU7OOR5=a0wi61w1V-23vA@mail.gmail.com>
 <8149f85c-4d2e-8411-ee9a-86669c5a1532@siemens.com>
 <CAMJ=MEeCbvzH8QjbZxAQd9H3fcCdNcYphqAXdHsBiUiXyXtUyw@mail.gmail.com>
 <878sah7hyu.fsf@xenomai.org>
 <CAMJ=MEc-Vs-pGXgzjxpM9m6BYMFvAHctm=bafHtmtXwsSf97Pg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: race in timerobj
In-reply-to: <CAMJ=MEc-Vs-pGXgzjxpM9m6BYMFvAHctm=bafHtmtXwsSf97Pg@mail.gmail.com>
Date: Fri, 04 Dec 2020 16:29:02 +0100
Message-ID: <871rg54mkh.fsf@xenomai.org>
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

> Op di 1 dec. 2020 om 14:51 schreef Philippe Gerum <rpm@xenomai.org>:
>>
>>
>> Ronny Meeus via Xenomai <xenomai@xenomai.org> writes:
>>
>> > Op di 1 dec. 2020 om 12:06 schreef Jan Kiszka <jan.kiszka@siemens.com>:
>> >>
>> >> On 01.12.20 11:26, Ronny Meeus via Xenomai wrote:
>> >> > Hello Xenomai community,
>> >> >
>> >> > it looks like we have a race condition in the timer object handling.
>> >> > The scope of the below mentioned issue is the alarm interface of the
>> >> > alchemy skin:
>> >> > int rt_alarm_start(RT_ALARM *alarm, RTIME value, RTIME interval)
>> >> >
>> >> > The documentation mentions that this start can be called also on an
>> >> > already running timer:
>> >> > "This service overrides any previous setup of the expiry date and
>> >> > reload interval for the given alarm."
>> >> >
>> >> > In the timer server code (see file lib/copperplate/timerobj.c):
>> >> > static void *timerobj_server (void *arg))
>> >> > I see the timer being re-inserted in the timeout list in case of a
>> >> > periodic timer.
>> >> >
>> >> > write_lock_nocancel(&svlock);
>> >> > ...
>> >> > if (interval.tv_sec > 0 || interval.tv_nsec > 0) {
>> >> >   timespec_add(&tmobj->itspec.it_value, &value, &interval);
>> >> >   timerobj_enqueue(tmobj);
>> >> > }
>> >> > write_unlock(&svlock);
>> >> > tmobj->handler(tmobj);
>> >> > write_lock_nocancel(&svlock);
>> >> > }
>> >> >
>> >> > This re-insert is done with the svlock taken but the timer specific
>> >> > lock is not taken.
>> >> >
>> >> > In the start on the other hand I see:
>> >> >
>> >> > int timerobj_start(struct timerobj *tmobj,
>> >> >   void (*handler)(struct timerobj *tmobj),
>> >> >   struct itimerspec *it) /* lock held, dropped */
>> >> > {
>> >> > tmobj->handler = handler;
>> >> > tmobj->itspec = *it;
>> >> > ...
>> >> > write_lock_nocancel(&svlock);
>> >> >
>> >> > So the itspec is updated with only the timerobj lock taken.
>> >> > If the timeout value is changed via the timerobj_start while the timer is
>> >> > under processing by the timer server, we can enter an endless loop (at
>> >> > least that is what we see sporadically)
>> >> >
>> >> > Does this make sense?
>> >>
>> >> Yes, at least to me. Patch welcome.
>> >
>> > Jan,
>> >
>> > this is the patch we are currently testing with (note that the line numbers
>> > might not match since we are not at the latest revision).
>> >
>> > diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
>> > --- a/lib/copperplate/timerobj.c
>> > +++ b/lib/copperplate/timerobj.c
>> > @@ -165,7 +165,8 @@ static void *timerobj_server(void *arg)
>> >                                 timerobj_enqueue(tmobj);
>> >                         }
>> >                         write_unlock(&svlock);
>> > -                       tmobj->handler(tmobj);
>> > +                       if (tmobj->handler)
>> > +                               tmobj->handler(tmobj);
>> >                         write_lock_nocancel(&svlock);
>> >                 }
>> >
>> > @@ -232,10 +233,14 @@ int timerobj_start(struct timerobj *tmob
>> >                    void (*handler)(struct timerobj *tmobj),
>> >                    struct itimerspec *it) /* lock held, dropped */
>> >  {
>> > +       write_lock_nocancel(&svlock);
>> > +
>> > +       if (pvholder_linked(&tmobj->next))
>> > +               pvlist_remove_init(&tmobj->next);
>> > +
>> >         tmobj->handler = handler;
>> >         tmobj->itspec = *it;
>> >
>> > -       write_lock_nocancel(&svlock);
>> >         timerobj_enqueue(tmobj);
>> >         write_unlock(&svlock);
>> >         timerobj_unlock(tmobj);
>> >
>> >
>> >>
>> >> Note, though, that updating the handler will remain inherently racy.
>> >>
>>
>> Good catch. Also, we would need a consistent view of the
>> (value,interval,handler) triplet for any time wrt concurrent start/stop
>> updates, all accessed under server lock. We would not want a new value
>> being copied to be used with an old interval and/or handler for
>> instance.
>>
>> There is also a locking imbalance to be fixed on error in
>> timerobj_start().
>>
>> e.g. (proudly untested).
>>
>> diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
>> index cbfcda566..08cc0d3b9 100644
>> --- a/lib/copperplate/timerobj.c
>> +++ b/lib/copperplate/timerobj.c
>> @@ -98,6 +98,7 @@ static int server_prologue(void *arg)
>>
>>  static void *timerobj_server(void *arg)
>>  {
>> +       void (*handler)(struct timerobj *tmobj);
>>         struct timespec now, value, interval;
>>         struct timerobj *tmobj, *tmp;
>>         sigset_t set;
>> @@ -120,17 +121,18 @@ static void *timerobj_server(void *arg)
>>
>>                 pvlist_for_each_entry_safe(tmobj, tmp, &svtimers, next) {
>>                         value = tmobj->itspec.it_value;
>> +                       interval = tmobj->itspec.it_interval;
>> +                       handler = tmobj->handler;
>>                         if (timespec_after(&value, &now))
>>                                 break;
>>                         pvlist_remove_init(&tmobj->next);
>> -                       interval = tmobj->itspec.it_interval;
>>                         if (interval.tv_sec > 0 || interval.tv_nsec > 0) {
>>                                 timespec_add(&tmobj->itspec.it_value,
>>                                              &value, &interval);
>>                                 timerobj_enqueue(tmobj);
>>                         }
>>                         write_unlock(&svlock);
>> -                       tmobj->handler(tmobj);
>> +                       handler(tmobj);
>>                         write_lock_nocancel(&svlock);
>>                 }
>>
>> @@ -218,8 +220,7 @@ int timerobj_start(struct timerobj *tmobj,
>>                    void (*handler)(struct timerobj *tmobj),
>>                    struct itimerspec *it) /* lock held, dropped */
>>  {
>> -       tmobj->handler = handler;
>> -       tmobj->itspec = *it;
>> +       int ret = 0;
>>
>>         /*
>>          * We hold the queue lock long enough to prevent the timer
>> @@ -232,14 +233,23 @@ int timerobj_start(struct timerobj *tmobj,
>>          */
>>         write_lock_nocancel(&svlock);
>>
>> -       if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL)))
>> -               return __bt(-errno);
>> +       if (pvholder_linked(&tmobj->next))
>> +               pvlist_remove_init(&tmobj->next);
>> +
>> +       tmobj->handler = handler;
>> +       tmobj->itspec = *it;
>> +
>> +       if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL))) {
>> +               ret = __bt(-errno);
>> +               goto fail;
>> +       }
>>
>>         timerobj_enqueue(tmobj);
>> +fail:
>>         write_unlock(&svlock);
>>         timerobj_unlock(tmobj);
>>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  int timerobj_stop(struct timerobj *tmobj) /* lock held, dropped */
>> @@ -251,10 +261,9 @@ int timerobj_stop(struct timerobj *tmobj) /* lock held, dropped */
>>         if (pvholder_linked(&tmobj->next))
>>                 pvlist_remove_init(&tmobj->next);
>>
>> -       write_unlock(&svlock);
>> -
>>         __RT(timer_settime(tmobj->timer, 0, &itimer_stop, NULL));
>>         tmobj->handler = NULL;
>> +       write_unlock(&svlock);
>>         timerobj_unlock(tmobj);
>>
>>         return 0;
>> --
>
> Philippe,
>
> we tested with the patch you proposed and the problem seem to be resolved.
> I think this is a good improvement.
>
> Best regards,
> Ronny
>
>> Philippe.

Ok, thanks for testing. Now pushing a patch referring to your original
post with the preliminary fix.

-- 
Philippe.

