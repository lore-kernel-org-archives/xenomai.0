Message-ID: <47CBDA5B.70603@domain.hid>
Date: Mon, 03 Mar 2008 12:00:43 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <47C838A9.8040200@domain.hid>	<2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>
	<47CBD35A.6030305@domain.hid>
In-Reply-To: <47CBD35A.6030305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_cond_wait doesn't timeout (xenomai 2.4.1)
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
> Gilles Chanteperdrix wrote:
>> On Fri, Feb 29, 2008 at 5:54 PM, Anders Blomdell
>> <anders.blomdell@domain.hid> wrote:
>>> Hi,
>>>
>>>  with xenomai 2.4.1 my call to:
>>>
>>>   rt_cond_wait(&cond, &mutex, 1000);
>>>
>>>  doesn't timeout (signalling works OK). Kernel version is 2.6.23.12, can it be
>>>  due to CONFIG_NO_HZ=y, or have I misunderstood something?
>> What is your system timer setting ? Are you running in periodic or
>> aperiodic mode ? If aperiodic, 1000 ticks means 1000 ns, that is 1us,
>> so rt_cond_wait should return instantaneously.
> OK, here comes a simplified program that just outputs A, and then hangs.
>

I can't reproduce this issue with your test code here, but this might be
the sign of some timer race depending on how fast is the hw.

By hanging, I assume the box is still ok, right?
If so, could you please send the output of /proc/xenomai/stat,
/proc/xenomai/sched, /proc/xenomai/timer and /proc/xenomai/timerstat/master?

TIA,

-- 
Philippe.

