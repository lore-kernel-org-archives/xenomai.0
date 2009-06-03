Message-ID: <4A26439C.6090802@domain.hid>
Date: Wed, 03 Jun 2009 11:34:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <103585745.148571244020625685.JavaMail.root@domain.hid>
In-Reply-To: <103585745.148571244020625685.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to chose between xenomai and preempt RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LECOINTRE <adrien20@domain.hid>
Cc: xenomai@xenomai.org

Adrien LECOINTRE wrote:
> Jeff Angielski wrote:
>> Of course, just by choosing to use Xenomai, you don't get hard
>> realtime. You still need to design your system and software
>> correctly.
> 
> Yes but a software can be well designed on PREEMPT_RT as well. I
> built a kernel and a filesystem with the less possible number of
> driver. After startup there is only an ATA driver and bash running on
> my system! In this situation I really doubt that a big latency can
> occurs.

Modern ATA means DMA, which means contention with the real-time system,
whatever this system is. So, large disk transfers will cause big latencies.

> 
> Then if my real-time software uses a specific device I just have to
> write my own driver (instead of using a "basic" linux driver) if I
> want to know exactly what's going on my system and keep a hard
> real-time behavior.

I would say the drivers need auditing and maybe to be modified, not to
be rewritten. Rewriting them is probably a waste of time, and you do not
benefit from using PREEMPT_RT if you do that.

> 
> Those are basics things that we always do when designing a real-time
> software on any RT OS.
> 
> Of course for a real-time software with a lot of non-real-time loads
> it's probably easier to use Xenomai and let Linux deals with loads.
> 
> I read a lot of things about PREEMPT_RT not providing hard real-time
> but I coudn't find any test case which shows that. My loads are
> probably not good enough but it shouldn't be so difficult to find a
> way to cause a significant latency on a supposed non-hard-real-time
> OS.

You are really talking in the void as long as you do not tell us what
platform you intend to use.

-- 
					    Gilles.

