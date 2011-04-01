Message-ID: <4D959E99.4020402@domain.hid>
Date: Fri, 01 Apr 2011 11:44:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>	<1301412534.2109.24.camel@domain.hid>	<4D922EF5.8020808@domain.hid>	<1301426227.2109.35.camel@domain.hid>	<4D9230C5.7050007@domain.hid>	<1301426830.2109.41.camel@domain.hid>	<4D923306.60409@domain.hid>	<1301461081.2092.14.camel@domain.hid>	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>	<1301472945.2092.21.camel@domain.hid>	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>	<4D948F87.9010109@domain.hid>	<4D9494B6.6040304@domain.hid>
	<AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
In-Reply-To: <AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> 
> Thanks Gilles for your input. This Priority Coupling stuff is a little
> complex and input about the corner cases is always welcome and
> helpful!
> 
> I did a little more tests with xnpod_schedule() commented out on
> LO_WAKEUP_REQ. Scheduling shows as expected to me: the lower and level
> primary tasks don't interrupt the migrated thread while higher
> priority tasks do interrupt that task. I have not seen any deadlocks
> yet or ran into corner cases, but of course I don't know all.
> 
> Now, looking back in the history of shadow.c I see that
> xnpod_schedule() was introduced when the xnsched_renice_root() was
> introduced, which is now part of rpi_clear_local. In my point of view,
> the xnpod_schedule() call is only needed when the
> xnsched_renice_root() has been done, so should be moved inside the if
> of rpi_clear_local. But again, it is my point of view and don't know
> all the corner cases.
> 
> In our case the scheduled task after the switch to secondary is
> actually mostly the IDLE task, thus calling the xnsched_renice_root
> and xnpod_schedule() for doing exactly that what is in the comment. So
> my main question remains: is the call to xnpod_schedule really needed
> here after xnsched_renice_root()? And if so, why doesn't the
> xnpod_schedule not take the priorities on the rpi list into account?

The current task when entering LO_WAKEUP_REQ is not a Xenomai task, so,
rip_clear_local disables the boost. At this point we have no guarantee
that "p" will be the next task scheduled, or that the next call to
schedule will schedule another task at all, so that we will pass by
do_schedule_event.

There may be a way to avoid this, but removing xnpod_schedule() is
certainly not it. Imagine that when we enter LO_WAKEUP_REQ, current is a
Linux real-time task with a higher priority than the Xenomai task, the
root thread will be unduly boosted until the moment where that task is
suspended and the Xenomai task can be at last scheduled. This would be a
plain sort of priority inversion.

-- 
					    Gilles.

