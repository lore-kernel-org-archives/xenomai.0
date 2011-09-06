Message-ID: <4E65CBCF.7020600@domain.hid>
Date: Tue, 06 Sep 2011 09:29:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkC=KgmuRFxNiGOqSGChpFQdv+fYRu8OgU0jMQc_dudShA@mail.gmail.com>	<4E652AE8.1050507@domain.hid>
	<CAOiXNkC3qdOLEwZUWciaGpKNjsgP+RBkDzG1gMQ2jY2-MSfvvg@domain.hid>
In-Reply-To: <CAOiXNkC3qdOLEwZUWciaGpKNjsgP+RBkDzG1gMQ2jY2-MSfvvg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PWM generation with GPIO
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 09/05/2011 10:14 PM, Andrey Nechypurenko wrote:
>> The best way to know if what you observe is due to the natural jitter or
>> to some other issue is to measure the jitter at the point where you
>> think it is.
> 
> Since the generation loop is so simple I was assuming (maybe too
> naive) that this is exactly where it starts to deviate from the ideal
> timing. But you are right - more precise measurements are required and
> I will definitely try to do it.
> 
>> But, anyway, such low level code would be best implemented
>> in a driver, completely in kernel-space, that would reduce the jitter,
>> an ioctl allowing to configure the duty cycle.
> 
> I was trying to stay in the user space as long as possible :-) .
> Please correct me if I am wrong here, but I was thinking that Xenomai
> actually runs Linux kernel as one of it's tasks (acting as a kind of
> supervisor). As a result, kernel could be preempted whenever Xenomai
> finds it necessary so the real-time performance of the Xenomai task
> (thread?) might be even better then kernel driver. Am I wrong with
> this assumption?
> 
> In addition, by any chances, maybe you have some figures to estimate
> the jitter values which might be realistic to achieve using
> driver-based approach you suggested? Would you expect these figures to
> be considerably better then what I was observing with Xenomai-based
> implementation?

Of course, Linux drivers may be preempted by Xenomai. I was talking
about a Xenomai driver, using the RTDM skin using for instance two
timers, a periodic timer which handler would set the gpio to 1 and
launch the second timer, a one shot time which handler would set the
gpio to 0.

To estimate the jitter of code executed in the timer handler, use
latency -t 2. Note that for latency -t 2 to work, you need to enable the
corresponding driver in the kernel configuration (Real-time
sub-system/drivers/testing/timer benchmark driver).

Regards.

-- 
                                                                Gilles.

