Subject: Re: About the reasons for setting the timer-internal thread with the
 THREADOBJ_IRQCONTEXT flag.
References: <CAAvDm6YkY012JKwbWErAe2CYpcDzyT+31P1n+nTaogx0tA1L8g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7f665187-523e-02fc-6de3-bc4e41b96d02@siemens.com>
Date: Wed, 2 Sep 2020 09:08:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YkY012JKwbWErAe2CYpcDzyT+31P1n+nTaogx0tA1L8g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 01.09.20 11:11, 孙世龙 sunshilong via Xenomai wrote:
> Hi,
> 
> I found that the timer-internal thread is set with the
> THREADOBJ_IRQCONTEXT flag.
> Here is the related code snippet:
> static int server_prologue(void *arg)
> {
>    svpid = get_thread_pid();
>    copperplate_set_current_name("timer-internal");
>    timersv_init_corespec();
>    threadobj_set_current(THREADOBJ_IRQCONTEXT);
> 
>    return 0;
> }
> 
> Could you please tell me the reasons for setting the timer-internal
> thread with the THREADOBJ_IRQCONTEXT flag.
> 
> What are the potential problems if not setting this flag?
> (I want to make it possible to call rt_task_sleep in the callback
> function of the timer which is created by rt_alarm_create.)
> 

"
 * Alarm handlers are always called on behalf of Xenomai's internal
 * timer event routine. Therefore, Xenomai routines which can be
 * called from such handlers are restricted to the set of services
 * available on behalf of an asynchronous context.
"

That is a (reasonable) design decision because you would otherwise risk
that a handler registered for low-prio task can block the delivery of an
event for a high-prio task. I would just be a mess, at least in a more
complex RT application.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

