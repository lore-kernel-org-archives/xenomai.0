MIME-Version: 1.0
References: <CAAvDm6YkY012JKwbWErAe2CYpcDzyT+31P1n+nTaogx0tA1L8g@mail.gmail.com>
 <7f665187-523e-02fc-6de3-bc4e41b96d02@siemens.com>
In-Reply-To: <7f665187-523e-02fc-6de3-bc4e41b96d02@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Wed, 2 Sep 2020 17:12:38 +0800
Message-ID: <CAAvDm6aTM_BSf5ynk-3STppE3GAy6+t0NLk5-bK8fR5N45XX8w@mail.gmail.com>
Subject: Re: About the reasons for setting the timer-internal thread with the
 THREADOBJ_IRQCONTEXT flag.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

>That is a (reasonable) design decision because you would otherwise risk
>that a handler registered for low-prio task can block the delivery of an
>event for a high-prio task. I would just be a mess, at least in a more
>complex RT application.

I see, thank you for the clarification.

It causes what can be done in the callback function of the alarm is very
limited since a lot of APIs can not be invoked(i.e.:
No data synchronization could be done by locking/unlocking RT_Mutex.
Message pipe services(RT_QUEUE), Semaphore services(RT_SEM) and etc
could not be called, too.)

Am I right?

Best regards
Sunshilong


On Wed, Sep 2, 2020 at 3:08 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 01.09.20 11:11, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai wro=
te:
> > Hi,
> >
> > I found that the timer-internal thread is set with the
> > THREADOBJ_IRQCONTEXT flag.
> > Here is the related code snippet:
> > static int server_prologue(void *arg)
> > {
> >    svpid =3D get_thread_pid();
> >    copperplate_set_current_name("timer-internal");
> >    timersv_init_corespec();
> >    threadobj_set_current(THREADOBJ_IRQCONTEXT);
> >
> >    return 0;
> > }
> >
> > Could you please tell me the reasons for setting the timer-internal
> > thread with the THREADOBJ_IRQCONTEXT flag.
> >
> > What are the potential problems if not setting this flag?
> > (I want to make it possible to call rt_task_sleep in the callback
> > function of the timer which is created by rt_alarm_create.)
> >
>
> "
>  * Alarm handlers are always called on behalf of Xenomai's internal
>  * timer event routine. Therefore, Xenomai routines which can be
>  * called from such handlers are restricted to the set of services
>  * available on behalf of an asynchronous context.
> "
>
> That is a (reasonable) design decision because you would otherwise risk
> that a handler registered for low-prio task can block the delivery of an
> event for a high-prio task. I would just be a mess, at least in a more
> complex RT application.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

