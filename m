References: <570B7253.1000904@basystemes.fr> <570BBD4C.6040409@xenomai.org>
 <570CF2E2.3000904@basystemes.fr>
From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <570F932A.6020102@basystemes.fr>
Date: Thu, 14 Apr 2016 14:55:06 +0200
MIME-Version: 1.0
In-Reply-To: <570CF2E2.3000904@basystemes.fr>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue while porting ipipe to kernel > 4.5
 (clockevents API change)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>



Le 12/04/2016 15:06, Thierry Bultel a =E9crit :
>
>
> Le 11/04/2016 17:05, Philippe Gerum a =E9crit :
>> On 04/11/2016 11:45 AM, Thierry Bultel wrote:
>>> Hi,
>>> while porting ipipe to 4.5, I am facing the following issue:
>>>
>>> clockchips.h has changed, and the set_mode function pointer has been
>>> replaced by
>>>
>>>      int            (*set_state_periodic)(struct clock_event_device *);
>>>      int            (*set_state_oneshot)(struct clock_event_device *);
>>>      int            (*set_state_oneshot_stopped)(struct
>>> clock_event_device *);
>>>      int            (*set_state_shutdown)(struct clock_event_device *);
>>>
>>> Moreover, CLOCK_EVT_MODE_XXX have been renamed to :
>>>
>>> enum clock_event_state {
>>>      CLOCK_EVT_STATE_DETACHED,
>>>      CLOCK_EVT_STATE_SHUTDOWN,
>>>      CLOCK_EVT_STATE_PERIODIC,
>>>      CLOCK_EVT_STATE_ONESHOT,
>>>      CLOCK_EVT_STATE_ONESHOT_STOPPED,
>>> };
>>>
>>> The impact therefore goes further than ipipe , since xenomai uses a
>>> single pointer
>>> for performing emulation.
>>>
>>> I am just wondering what is the best way to deal with this, without
>>> impacting to much code
>>> Is it best to add a compatibility wrapper (moreover, the set_state_xxx
>>> functions are only used in clockevents.c), and some extra #defines
>>> or to spread the changes up to xenomai code ?
>>>
>> I would confine the changes to the pipeline, I don't see any reason for
>> spreading those changes to Xenomai only for supporting the
>> ONESHOT_STOPPED mode, which might be usable as a hint, but may be
>> ignored by Xenomai as well, especially by legacy Xenomai 2.x releases.
>>
>> You could redirect the new state handlers to a set of internal wrapper
>> routines in the pipeline, which would translate the calls to the
>> Xenomai's current emulation handlers.
>>
>
> Thanks Philippe,
>
> At this step, I have something that compiles without CONFIG_XENOMAI=20
> (there is a little work to do in xenomai,
> since some other kernel APIs changed too, like cpu masks, and struct=20
> msghdr ... )
>
> Before going to that, I would like to get rid of this:
>
> The kernel boots fine with CONFIG_IPIPE disabled.
>
> With CONFIG_IPIPE and !CONFIG_SMP, the kernel boots fine up to user land.
> With CONFIG_IPIPE and  CONFIG_SMP, the kernel hangs at random=20
> positions during initcalls.
> I had to enable CONFIG_EARLY_PRINTK to notice it, because nothing came=20
> on the console else.
>
> "printk-bisecting" makes the hang position change, making impossible=20
> to localize the hang position this way.
>
> I have CONFIG_DEBUG_SPINLOCK enabled but that does not help much. I=20
> payed much attention to spinlock.h without noticing
> anything wrong.
>
> What can I do to investigate this ?
>
> I forgot to say that the target CPU is an IMX6Q
>
> Thanks
> Thierry
>

Hi,

I managed to narrow down the issue.

tick_sched_timer() is never called, because the softirq timer code is not e=
xecuted.. thus calls like 'msleep' never return.

The reason is that in timekeeping_get_delta(), the "now" is always the same,

that is to say, that tkr->read (which is __ipipe_tsc_get) always report the=
 same value.

I have CONFIG_IPIPE_ARM_KUSER_TSC enabled (by default)
What can be wrong ?

(The base I started with is ipipe-core-4.1.18-arm-4.patch)

Thanks
Thierry





