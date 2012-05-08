Message-ID: <4FA8E320.5070302@domain.hid>
Date: Tue, 08 May 2012 11:10:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FA8C9D6.4020404@domain.hid>
In-Reply-To: <4FA8C9D6.4020404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Scheduler extensions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jonas Flodin <jonas.flodin@domain.hid>
Cc: xenomai@xenomai.org

On 05/08/2012 09:23 AM, Jonas Flodin wrote:
>
> Hi!
>
> I'm a PhD student who is currently doing research on multicore real-time
> scheduling. I'm considering using Xenomai as a base for my research
> experiments, but this would require me to replace or extend the current
> scheduler. So far I have found no documents detailing how the scheduler
> is implemented or how to extend it (if possible). Could you point me to
> information regarding the scheduler?
>

There is no documentation on the scheduling core. You should probably 
start with ksrc/nucleus/sched*.c, and include/nucleus/sched*.h, having a 
look at the files implementing the plain FIFO policy in sched-rt*.

Hint: the scheduling core is meant to be extensible, adding a new policy 
entails providing an implementation for a new struct xnsched_class 
object. Make sure to read the comments in the files implementing the 
existing policies (-rt, -sporadic, -tp), they usually mention details on 
the calling context and requirements for the handlers defined by the 
xnsched_class type.

> Thank you in advance.
>
> BR
> Jonas Flodin
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>


-- 
Philippe.

