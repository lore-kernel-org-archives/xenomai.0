From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <BLU0-SMTP74AA1DAE7E44EF487B424DBDA50@domain.hid>
References: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
	<4D9CA930.3000204@domain.hid>
	<BLU0-SMTP74AA1DAE7E44EF487B424DBDA50@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 00:26:25 +0200
Message-ID: <1302128785.2030.90.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement
 tool on Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna murthy j s <krishnamurthyjs@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2011-04-06 at 19:31 +0100, krishna murthy j s wrote:
> Thanks for the reply. Can you please tell me why my questions are
> useless. Such attitude will take Xenomai user group no where. 

It is often better to go nowhere than to go to the wrong place. Anyway,
some reasons for the flak you received could be:

- no specification of your target hardware. I understand there is a
long-standing trend to throw results into the latency debate without a
single bit of information regarding the hardware configuration under
test, the actual code being used (and not a vague description of what it
eventually does), how it has been changed and how it has been used, but
well, we are old-fashioned folks: we do prefer facts. Besides, we do
think there is life beyond x86, so it is always better to be specific in
this area when sending us inquiries.

- backfire comes from the PREEMPT_RT test suite. As such, it does not
care of any dual kernel issues. We do, when writing an application. So,
unless you also wrote an RTDM driver to replace the original backfire
driver, what you are testing is actually plain vanilla Linux, with the
additional overhead of moving your task back and forth between the
Xenomai scheduler and the Linux scheduler at a high rate. If so, no
wonder why you get some extra latency with Xenomai. It's a bit like
driving on a racetrack paved with speed bumpers.

- measuring the latency of Linux signal delivery like backfire does is
interestingly totally off-base wrt Xenomai, because linux signals are
delivered to Xenomai tasks ... in Linux mode (yes, we have runtime modes
like dual kernel systems may have). So, no real-time here either. Since
Xenomai does not implement signal delivery in real-time mode yet, what
you are testing still remains a mystery. But maybe you could explain
better?

To sum up, each RT enabler comes with a test suite which has been
written carefully to illustrate a particular behavior or performance
aspect, and Xenomai follows this common rule.

Before issuing any claims, maybe you could have posted your code, a
detailed description of your setup, and your test scenario. Asking
people to reverse-engineer what you might have done, based on a couple
of lose details placed side-by-side with strong claims and conclusions,
is not the best way to draw attention.

So, don't take what was said earlier personally. It is just that
sometimes, people may have tuned their bullshit deflector a bit eagerly.
Mine is totally busted btw, so you never know.

> 
> On Wed, Apr 6, 2011 at 6:56 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>         
>         krishna m wrote:
>         > I ported the backfire tool in the OSADL site
>         [https://www.osadl.org/backfire-4.backfire.0.html] to measure
>         the user to/from kernel latency.I wanted to measure the
>         difference between the RT_PREEMPT kernel and Xenomai Kernel.
>         Surprisingly i see RT_PREEMPT performance better than Xenomai.
>         >
>         > Here are few points to note:
>         > 1. The thread priority of the "sendme" tool of backfire in
>         RT_PREEMPT is 99 [highest]
>         > 2. I have made the thread priority 99 for the rt_task that i
>         spawn [par of ported sendme]
>         > ret = rt_task_shadow(&rt_task_desc, NULL, 99, 0);
>         >
>         > My Questions:
>         > * I wanted to know if any one has done such measurements
>         using backfire and how dose Xenomai fair agnist RT_PREEMPT?
>         > * is there any similar tool like backfire in the Xenomai
>         tool set that dose the similar measurements?
>         > * Do I need to do more Xenomai specific optimization in the
>         "sendme" and "backfire" code to get better performance?
>         
>         
>         Useless notes, useless questions. Show us the "ported" code.
>         
>         
>         --
>                                                    Gilles.
>         
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



