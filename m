MIME-Version: 1.0
Sender: ismael.ilias@domain.hid
In-Reply-To: <4D74B024.5010008@domain.hid>
References: <AANLkTik2mjdhFGGedWVVT=itGeusDPE=QbDhZCC7oD_+@mail.gmail.com>
	<4D74B024.5010008@domain.hid>
Date: Mon, 7 Mar 2011 15:29:33 +0100
Message-ID: <AANLkTikT3fkGjfQBu+s8iqfUJ6Qfo+mDwkvENDEcmqSQ@mail.gmail.com>
From: Jonathan ILIAS-PILLET <ismael@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: xenomai@xenomai.org

2011/3/7 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> We do not know anything about your setup (except the platform). See:
> http://www.xenomai.org/index.php/Request_for_information

Oh, sorry. Here it is :
- linux kernel : 2.6.29.6
- adeos patch : adeos-ipipe-2.6.29-arm-1.13-00.patch
- xenomai : 2.4.8
- host linux distribution : ubuntu 10.04 (64 bits)
- compiler : gcc 4.2.1 (buildroot's generated toolchain)

For those who knows it, all of this comes from Armadeus distribution
(vendor package for the board we use) in version 3.3 which is based on
buildroot (see http://www.armadeus.com/wiki/).

> It would also be interesting to know if you have root thread priority
> coupling enabled.

Actually, I've never choose any option about this, I thought it was
activated by default. Perhaps I messed the kernel configuration
related to this, where this feature can be enabled or disabled ?

According to http://www.xenomai.org/index.php/Proc/xenomai/sched, I
guess it is enabled :
# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
 0  0       -1      0          0          master    R          ROOT


> In any case, your real-time tasks should never use all the cpu without
> letting Linux run. The only way to guarantee the stability of the system
> is by letting Linux run from time to time.

OK, I understand. Linux kernel is time dependant (at least for the
scheduler). But is there a specific reason for this or is it a general
precaution ?

When you say "time to time", is there any rule to follow to be sure
that enough time is given to Linux ? Something like CPU cannot spend
more than 500 ms in one second for primary mode threads ?

Thanks
-- 
Jonathan ILIAS-PILLET

