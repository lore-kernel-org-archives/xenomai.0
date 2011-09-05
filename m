MIME-Version: 1.0
In-Reply-To: <4E652AE8.1050507@domain.hid>
References: <CAOiXNkC=KgmuRFxNiGOqSGChpFQdv+fYRu8OgU0jMQc_dudShA@mail.gmail.com>
	<4E652AE8.1050507@domain.hid>
Date: Mon, 5 Sep 2011 22:14:54 +0200
Message-ID: <CAOiXNkC3qdOLEwZUWciaGpKNjsgP+RBkDzG1gMQ2jY2-MSfvvg@domain.hid>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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

> The best way to know if what you observe is due to the natural jitter or
> to some other issue is to measure the jitter at the point where you
> think it is.

Since the generation loop is so simple I was assuming (maybe too
naive) that this is exactly where it starts to deviate from the ideal
timing. But you are right - more precise measurements are required and
I will definitely try to do it.

> But, anyway, such low level code would be best implemented
> in a driver, completely in kernel-space, that would reduce the jitter,
> an ioctl allowing to configure the duty cycle.

I was trying to stay in the user space as long as possible :-) .
Please correct me if I am wrong here, but I was thinking that Xenomai
actually runs Linux kernel as one of it's tasks (acting as a kind of
supervisor). As a result, kernel could be preempted whenever Xenomai
finds it necessary so the real-time performance of the Xenomai task
(thread?) might be even better then kernel driver. Am I wrong with
this assumption?

In addition, by any chances, maybe you have some figures to estimate
the jitter values which might be realistic to achieve using
driver-based approach you suggested? Would you expect these figures to
be considerably better then what I was observing with Xenomai-based
implementation?

Thank you very much for such a quick response!
Andrey.

