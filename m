Date: Fri, 17 Feb 2006 08:05:06 -0800
Subject: Re: [Xenomai-help] no-brainer realtime issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C01B3432.2453%steve@domain.hid>
In-Reply-To: <43F5F2E0.7050201@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Yous seem to be running in periodic timing mode, with a default slice of 125
> us.
> Which parameters are passed to rt_task_set_periodic() and
> rt_task_wait_period() in
> your sampling task?

I am confused why this matters? You said the latency test shows my realtime
does not work, so clearly the problem I have isn't specific to my code, but
rather to my system, right?

Here is my call to rt_task_set_periodic:

rt_task_set_periodic(&task, TM_NOW, rt_timer_ns2ticks(500000));

I don't pass any parameters to rt_task_wait_period()

Steven


