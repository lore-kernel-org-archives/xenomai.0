MIME-Version: 1.0
Date: Sun, 15 Apr 2012 23:24:09 +0200
Message-ID: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] RTDM or native Xenomai API
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

Hi Folks,

In our hobby robotics project [1] we start using Xenomai for RT tasks.
The first application was PWM generation with GPIO to control servo
motors [2] (the next would be dealing with interrupts from wheel
encoders). We have made it from the user space and result was not as
good as we would like it to be so I decide to write kernel module to
reduce the jitter. And here comes the question whether to use RTDM or
just plain Xenomai API?

I was never using RTDM in the past. Based on what I have read, the
main intent of the RTDM is to make driver code portable across
different RT solutions for Linux. I understand it and it makes sense.
However, looking around and asking myself what are these different
solutions, I just can name Xenomai and preempt_rt patch. AFAIK, all
the rest are either dead (or almost dead) or not relevant for hobby
open-source development. So my question is what are the practical
advantages of using RTDM instead of Xenomai API? I would be very glad
to hear the opinion of experienced Linux RT developers about it.

Thank you very much,
Andrey.

[1] http://veter-project.blogspot.de/2011/11/how-to-build-beagleboard-based-wifi.html
[2] http://veter-project.blogspot.de/2011/09/real-time-enough-about-pwms-and-shaky.html

