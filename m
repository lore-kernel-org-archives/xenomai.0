Message-ID: <4D74ECCE.3080001@domain.hid>
Date: Mon, 07 Mar 2011 15:33:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik2mjdhFGGedWVVT=itGeusDPE=QbDhZCC7oD_+@mail.gmail.com>	<4D74B024.5010008@domain.hid>
	<AANLkTinnCqCNrJ-tukjxGd-zdtM9nuG2fw4Zer+iTSiQ@mail.gmail.com>
In-Reply-To: <AANLkTinnCqCNrJ-tukjxGd-zdtM9nuG2fw4Zer+iTSiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Program hangs using "rt_task_sleep" in a
 particular way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan ILIAS-PILLET <ismael@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jonathan ILIAS-PILLET wrote:
> 2011/3/7 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> We do not know anything about your setup (except the platform). See:
>> http://www.xenomai.org/index.php/Request_for_information
> 
> Oh, sorry. Here it is :
> - linux kernel : 2.6.29.6
> - adeos patch : adeos-ipipe-2.6.29-arm-1.13-00.patch
> - xenomai : 2.4.8
> - host linux distribution : ubuntu 10.04 (64 bits)
> - compiler : gcc 4.2.1 (buildroot's generated toolchain)
> 
> For those who knows it, all of this comes from Armadeus distribution
> (vendor package for the board we use) in version 3.3 which is based on
> buildroot (see http://www.armadeus.com/wiki/).

This is very old stuff. Could you try whether you reproduce this issue
with Xenomai latest release (2.5.5.2) ? Also, using 2.4.8 is
preposterous, you should at least upgrade to the latest release from the
same branch, it should be 2.4.9.1.

> 
>> It would also be interesting to know if you have root thread priority
>> coupling enabled.
> 
> Actually, I've never choose any option about this, I thought it was
> activated by default. Perhaps I messed the kernel configuration
> related to this, where this feature can be enabled or disabled ?
> 
> According to http://www.xenomai.org/index.php/Proc/xenomai/sched, I
> guess it is enabled :
> # cat /proc/xenomai/sched
> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>   0  0       -1      0          0          master    R          ROOT

No, you do not see anything here. You have to check the kernel
configuration.

Relying on someone else's configuration will not fly for long, you have
to know what is in the kernel you compile.

> 
> 
>> In any case, your real-time tasks should never use all the cpu without
>> letting Linux run. The only way to guarantee the stability of the system
>> is by letting Linux run from time to time.
> 
> OK, I understand. Linux kernel is time dependant (at least for the
> scheduler). But is there a specific reason for this or is it a general
> precaution ?
> 
> When you say "time to time", is there any rule to follow to be sure
> that enough time is given to Linux ? Something like CPU cannot spend
> more than 500 ms in one second for primary mode threads ?

No. Something like your application should release the cpu once every
10ms so that Linux receives its ticks when it expects them (so, every
1ms if running at 1000 Hz). In fact, a typical application is blocked
most of the time and only reacts to events (be it the timer interrupt).

-- 
					    Gilles.

