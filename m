Message-ID: <4E652AE8.1050507@domain.hid>
Date: Mon, 05 Sep 2011 22:02:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkC=KgmuRFxNiGOqSGChpFQdv+fYRu8OgU0jMQc_dudShA@mail.gmail.com>
In-Reply-To: <CAOiXNkC=KgmuRFxNiGOqSGChpFQdv+fYRu8OgU0jMQc_dudShA@mail.gmail.com>
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

On 09/05/2011 09:53 PM, Andrey Nechypurenko wrote:
> Hi Folks,
> 
> Recently I was trying to control standard servo motor with PWMs. The
> system is 600MHz BeagleBoard xM (ARM) running Linux kernel version
> 2.6.35.9 with Xenomai version 2.5.6.
> 
> Pulses needs to be generated with 20milliseconds interval (50Hz).
> Pulse width defines servo position and is typically in the range of
> 0.8milliseconds to 2.0milliseconds. To generate PWMs I am using GPIO
> pin connected to the servo through TI's TXS0108E voltage-level
> translator to translate +1.8V GPIO to required +5V. To trigger GPIO
> state I am using direct memory writes (to mmapped area).
> 
> The generation loop is running in the Xenomai thread with priority 99
> and looks like this:
> 
>   for(;;) {
>       //set_data_out has offset 0x94
>       gpio[OFFSET(0x6094)]=0x40000000;
>       rt_task_sleep(up_period);
>       //clear_data_out has offset 0x90
>       gpio[OFFSET(0x6090)]=0x40000000;
>       rt_task_wait_period(NULL); }
> 
> where gpio array is a pointer to the memory area responsible for
> controlling GPIO state. The complete code could be found here:
> https://www.gitorious.org/veter/vehicle/blobs/master/src/xenopwm.c
> 
> So now the question/problem I have. If the system load is low, then
> everything is fine. However, if the system load goes beyound ~60%,
> servos starts shaking which is a sign of not precise PWM timing. I
> have written the blog post with more details and relevant videos:
> http://veter-project.blogspot.com/2011/09/real-time-enough-about-pwms-and-shaky.html
> . Just scroll down to the section named "Solution 2 - predictable
> timing with Xenomai" since the rest is probably obvious for the folks
> hanging around here ;-) .
> 
> Running the Xenomai's latency application in parallel with our test
> program reveals the latency of around 40 microseconds. Based on what I
> read in Internet, 40 microseconds is considered "normal/OK" latency
> for Linux/Xenomai running on ARM at 600MHz. Taking in account typical
> pulse width of about 1 millisecond, 40 microseconds is about 4%. Could
> it be that this 4% is in fact what causes servos to shake? If yes,
> does it mean that even with Xenomai it is not possible to control
> servos reliably even under moderate system load on the mentioned
> hardware?
> 
> I am kind of hope that there are some tweeks could be done to make the
> timing more precise and would really appreciate any hints.

The best way to know if what you observe is due to the natural jitter or
to some other issue is to measure the jitter at the point where you
think it is. But, anyway, such low level code would be best implemented
in a driver, completely in kernel-space, that would reduce the jitter,
an ioctl allowing to configure the duty cycle.

> 
> Thank you,
> Andrey.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
                                                                Gilles.

