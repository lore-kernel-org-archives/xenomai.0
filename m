Message-ID: <4A2645FD.1030500@domain.hid>
Date: Wed, 03 Jun 2009 11:44:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <103585745.148571244020625685.JavaMail.root@domain.hid>
	<4A26439C.6090802@domain.hid>
In-Reply-To: <4A26439C.6090802@domain.hid>
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

Gilles Chanteperdrix wrote:
> Adrien LECOINTRE wrote:
>> Jeff Angielski wrote:
>>> Of course, just by choosing to use Xenomai, you don't get hard
>>> realtime. You still need to design your system and software
>>> correctly.
>> Yes but a software can be well designed on PREEMPT_RT as well. I
>> built a kernel and a filesystem with the less possible number of
>> driver. After startup there is only an ATA driver and bash running on
>> my system! In this situation I really doubt that a big latency can
>> occurs.
> 
> Modern ATA means DMA, which means contention with the real-time system,
> whatever this system is. So, large disk transfers will cause big latencies.
> 
>> Then if my real-time software uses a specific device I just have to
>> write my own driver (instead of using a "basic" linux driver) if I
>> want to know exactly what's going on my system and keep a hard
>> real-time behavior.
> 
> I would say the drivers need auditing and maybe to be modified, not to
> be rewritten. Rewriting them is probably a waste of time, and you do not
> benefit from using PREEMPT_RT if you do that.

The minimal modification that you want to do to make a driver real-time
with preempt_rt is to make its irqs non threaded and make its spinlocks
good old raw spinlocks.

-- 
					    Gilles.

