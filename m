Message-ID: <4C2326A7.8010906@domain.hid>
Date: Thu, 24 Jun 2010 11:34:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<20100609181153.GA27353@domain.hid>
	<1276902677.12743.108.camel@domain.hid>
	<20100624092259.GA21635@domain.hid>
In-Reply-To: <20100624092259.GA21635@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mayday support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Tschaeche IT-Services wrote:
> On Sat, Jun 19, 2010 at 01:11:17AM +0200, Philippe Gerum wrote:
>> On Wed, 2010-06-09 at 20:11 +0200, Tschaeche IT-Services wrote:
>>> On Wed, Jun 09, 2010 at 12:41:23PM +0200, Philippe Gerum wrote:
>>>> We definitely need user feedback on this. Typically, does arming the
>>>> nucleus watchdog with that patch support in, properly recovers from your
>>>> favorite "get me out of here" situation? TIA,
>>>>
>>>> You can pull this stuff from
>>>> git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
>>> manually build a kernel (timeout 1s) with your patches.
>>> user space linked to 2.5.3 libraries without any patches.
>>> Looks fine: the amok task is switched to secondary domain
>>> (we catched the SIGXCPU) running the loop in secondary domain.
>>> then, on a SIGTRAP the task leaves the loop.
>>>
>>> also, if SIGTRAP arives before SIGXCPU it looks good,
>>> apart from the latency of 1s.
>>>
>>> did not check the ucontext within the exception handler, yet.
>>> would like to setup a reproducible kernel build first...
>>> we will go into deeper testing in 2 weeks.
>>>
>>> maybe we need a finer granularity than 1s for the watchdog timeout.
>>> is there a chance?
>> The watchdog is not meant to be used for implementing application-level
>> health monitors, which is what you seem to be looking after. The
>> watchdog is really about pulling the break while debugging, as a mean
>> not to brick your board when things start to hit the crapper, without
>> knowing anything from the error source. For that purpose, the current 1s
>> granularity is just fine. It makes the nucleus watchdog as tactful as a
>> lumberjack, which is what we want in those circumstances: we want it to
>> point the finger at the problem we did not know about yet and keep the
>> board afloat; it is neither meant to monitor a specific code we know in
>> advance that might misbehave, nor provide any kind of smart contingency
>> plan.
>>
>> I would rather think that you may need something like a RTDM driver
>> actually implementing smarter health monitoring features that you could
>> use along with your app. That driver would expose a normalized socket
>> interface for observing how things go app-wise, by collecting data about
>> the current health status. It would have to tap into the mayday routines
>> for recovering from runaway situations it may detect via its own,
>> fine-grained watchdog service for instance.
> 
> Perfect, that's exactly what we want (and already have implemented).
> How can i tap into the MayDay routines from my driver?
> Is there a rt_mayday(RT_TASK)?

I think you will simply have to call the nucleus services directly,
which indicates that there is something wrong with it conceptually.

An RTDM driver is just another workaround. A better solution will once
come with RT-signals: A user space(!) high-prio watchdog thread will be
able to send a signal to the spinning thread, and the signal handler can
then report the error and/or kick the thread out of primary mode.

Alternatively, the nucleus could export a user space interface to send
SIGDEBUG from an RT thread to some other thread. That would allow to
push the watchdog policy into user space, freeing the kernel (or some
workaround driver) from any customization burdens.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

