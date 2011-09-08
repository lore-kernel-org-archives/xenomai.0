MIME-Version: 1.0
In-Reply-To: <4E68226E.2000208@domain.hid>
References: <4E68226E.2000208@domain.hid>
Date: Thu, 8 Sep 2011 10:21:48 +0200
Message-ID: <CAOiXNkARu4YOd+K9YMqXbvQhUYEh38fVyNQi-mthMYjQe7mCYA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Xenomai help <xenomai@xenomai.org>
Cc: Bob Feretich <bob.feretich@domain.hid>

On 8 September 2011 04:03, Bob Feretich <bob.feretich@domain.hid> wrot=
e:
> Is there a reason that your not using the BeagleBoard PWM Timer hardware?

I do use two of them. Attempt to generate PWM using GPIO is just for
me to learn about real-time performance I can achieve with Xenomai. My
hope that later, in addition to PWMs, using the same approach I would
be able to handle another real-time tasks required for my hobby
robotics project (veter-project.blogspot.com just in case if you are
curious).

> So I wrote
> a RTDM driver to use the three that were pinned out, =A0and used real tim=
e
> limit and overflow interrupts to to wiggle a GPIO for the fourth PWM outp=
ut.

It seams to me that you are using different implementation approach
then suggested by Gilles in this thread: "I was talking
about a Xenomai driver, using the RTDM skin using for instance two
timers, a periodic timer which handler would set the gpio to 1 and
launch the second timer, a one shot time which handler would set the
gpio to 0."

Could you please say a few words about the reasons why you chose this
particular way?

> The Linux version of this driver made the 4th servomotor growl. There is =
no
> growl using the RTDM version. I asked a lab technician to probe the four
> servo PWM signals and tell me which was software GPIO generated. He could
> not tell.

It is not a surprise that Linux version was not perfect. What was
surprising for me is the fact that my user-space Xenomai application
was also not very precise (the relevant source is here:
https://www.gitorious.org/veter/vehicle/blobs/master/src/xenopwm.c and
the periodic function is pwm_func()). Similarly to what Gilles
suggested but in user-space, I run periodic task and toggle the pin
with direct memory writes. My understanding was that periodic task
(despite being launched in user-space) is controlled by Xenomai which
in turns works with system timers and should deliver much more precise
timing. So there might be fundamental difference between periodic task
launched in user-space with rt_task_start/rt_task_set_periodic and
similar periodic task running as RTDM driver which I do not
understand. If this assumption is true, I would really appreciate any
pointers to the documentation which explains what are the differences
and why RTDM driver can deliver better rt performance then Xenomai
thread from user-space.

> The RTDM driver is open source. If you want it contact me off list and I'=
ll
> send you the source.

Will definitely contact you. I just start to write my own RTDM driver
for it and still want to do it myself to learn. But it would a big
help for me to have working "reference" implementation.

> Before you contact me for questions about the driver though...
> 1) Know how to build a standard Linux driver.
> 2) Read the OMAP technical reference manual
> (http://www.ti.com/lit/ug/spruf98t/spruf98t.pdf) sections on the Timers
> (Chapter 16).

Ok. ;-)

Regards,
Andrey.

