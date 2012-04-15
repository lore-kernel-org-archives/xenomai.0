MIME-Version: 1.0
In-Reply-To: <4F8B4B4E.7000202@domain.hid>
References: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>
	<4F8B4B4E.7000202@domain.hid>
Date: Mon, 16 Apr 2012 00:53:30 +0200
Message-ID: <CAOiXNkDXL94Y17EghAZAOLh4PFSFfFoJNnEbguLxFY054reUhA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] RTDM or native Xenomai API
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

Hi Gilles,

Thank you very much for such low-latency reply! :-)

> RTDM is the API of choice for developing drivers for real-time
> applications using xenomai.

Please correct me if I just misunderstand something here, but as I
understand, RTDM is an abstraction layer with concrete implementation
using xenomai API. As stated in the referenced paper from Jan Kiszka,
the original reason for introducing this layer was to achieve
portability across different RT solutions for Linux. Since that time,
a lot of considered RT solutions becomes irrelevant. In fact, I would
say, there are only Xenomai and preempt_rt. If this assumption is
true, then I can not see the advantages of the additional layer unless
it is more then just an abstraction layer. Does RTDM API makes certain
tasks easier/better compared to the similar native xenomai API? Just
to give concrete example - what is the advantage of using
rtdm_task_init() vs. rt_task_create or xnintr_init() vs.
rtdm_irq_request()?

> Also note that in the case of omap3, gptimers may be used to generate
> PWM without software assistance. And that the gpio kernel functions are
> safe to be used in real-time context.

We already using 2 available hardware PWM generators. The experiment
with GPIO was mainly to start collecting experience with Xenomai and
see how far the one can go in user space. Now, I want to make the next
step and write kernel module which is doing the same. That is why the
question about RTDM.

Thank you very much!
Andrey.

