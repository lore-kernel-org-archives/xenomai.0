From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1283267823.1709.1869.camel@domain.hid>
References: <1283267823.1709.1869.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Sep 2010 07:14:39 +0200
Message-ID: <1283318079.1709.1877.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL-REQUEST] assorted fixes and updates for
 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 2010-08-31 at 17:17 +0200, Philippe Gerum wrote:
> The following changes since commit 004f652d31d2e3b9b995850dbefcf12bc6dbd96d:
>   Gilles Chanteperdrix (1):
>         Fix typo in edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
> 
> are available in the git repository at:
> 
>   ssh+git://git@domain.hid for-upstream
> 
> Philippe Gerum (16):
>       powerpc: upgrade I-pipe support to 2.6.34.4-powerpc-2.10-04
>       nucleus: demote RPI boost upon linux-originated signal
>       blackfin: upgrade I-pipe support to 2.6.35.2-blackfin-1.15-00
>       nucleus: requeue blocked non-periodic timers properly
>       x86: upgrade I-pipe support to 2.6.32.20-x86-2.7-02, 2.6.34.5-x86-2.7-03
>       arm: force enable preemptible switch support in SMP mode
>       arm: enable VFP support in SMP
>       arm: use rthal_processor_id() over non-linux contexts
>       powerpc: resync thread switch code with mainline >= 2.6.32
>       x86: increase SMP calibration value
>       nucleus/sched: move locking to resume_rpi/suspend_rpi
>       hal/generic: inline APC scheduling code
>       nucleus, posix: use fast APC scheduling call
>       nucleus/shadow: shorten the uninterruptible path to secondary mode

This one causes the now famous "need_resched" debug assertion to trigger
on UP. I'll have a look at this asap. It does not depend on 56ff4329f
though.

>       nucleus/sched: prevent remote wakeup from triggering a debug assertion
>       powerpc: upgrade I-pipe support to 2.6.35.4-powerpc-2.11-00
> 

-- 
Philippe.



