Message-ID: <4E68226E.2000208@domain.hid>
Date: Wed, 07 Sep 2011 19:03:26 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Is there a reason that your not using the BeagleBoard PWM Timer hardware?
The OMAP3 ARM chip has 4 PWM hardware timers. They can generate rock 
solid PWM pulse trains via the DMTIMER interface. The BeagleBoard 
C2/C3/C4 brings out 3 of these timers to the expansion connector.

Writing a RTDM driver to manipulate these timers is easy.
I needed 4 PWM timer outputs, brought to the expansion connector. So I 
wrote a RTDM driver to use the three that were pinned out,  and used 
real time limit and overflow interrupts to to wiggle a GPIO for the 
fourth PWM output.

The Linux version of this driver made the 4th servomotor growl. There is 
no growl using the RTDM version. I asked a lab technician to probe the 
four servo PWM signals and tell me which was software GPIO generated. He 
could not tell.

The RTDM driver is open source. If you want it contact me off list and 
I'll send you the source.
Before you contact me for questions about the driver though...
1) Know how to build a standard Linux driver.
2) Read the OMAP technical reference manual 
(http://www.ti.com/lit/ug/spruf98t/spruf98t.pdf) sections on the Timers 
(Chapter 16).

Regards,
Bob Feretich

> From: Andrey Nechypurenko<andreynech@domain.hid>
> Subject: [Xenomai-help] PWM generation with GPIO
> To: Xenomai help<xenomai@xenomai.org>
> Message-ID:
> 	<CAOiXNkC=KgmuRFxNiGOqSGChpFQdv+fYRu8OgU0jMQc_dudShA@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
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
>    for(;;) {
>        //set_data_out has offset 0x94
>        gpio[OFFSET(0x6094)]=0x40000000;
>        rt_task_sleep(up_period);
>        //clear_data_out has offset 0x90
>        gpio[OFFSET(0x6090)]=0x40000000;
>        rt_task_wait_period(NULL); }
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
> hanging around here  .
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
>
> Thank you,
> Andrey.
>


