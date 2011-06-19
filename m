MIME-Version: 1.0
In-Reply-To: <4DFDFD2F.1080506@domain.hid>
References: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>
	<4DFDF79F.1090502@domain.hid>
	<BANLkTinVUd-R1cpD+40MGZZckzGhwrqRvw@domain.hid>
	<4DFDFD2F.1080506@domain.hid>
Date: Sun, 19 Jun 2011 16:06:35 +0200
Message-ID: <BANLkTimdiUofRrXahOThW5C1RixQ-s5pMQ@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Problem accesing I2C without using Linux kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

> Ok. I would pass the size of an entire page anyway, I do not think
> mapping anything not aligned on a page boundary makes sense.
>
> If it still fails, enable CONFIG_DEBUG_USER in kernel configuration,
> pass user_debug=29 on kernel command line, and post the user debug log
> upon failure, then the disassembly of the function where the SIGBUS happens.

Ok, Thank you for suggestions! I'll try it.

> Note that this mailing list is probably not the best place to ask your
> question, since we mostly talk about Xenomai here, and your issue does
> not seem to have anything to do with Xenomai.

I understand. Do you have an idea what list might be more appropriate
for it? I did also post the same question to the BeagleBoard mail
list.

> Please keep the discussion public.

Sorry, just hit "Reply" instead of "Reply to all" :-) .

> Second stupid questions: are you sure all the clocks needed to get that
> I2C module running are enabled?

The module works. I think kernel configured it properly because I can
use user space utility for example i2cdetect and see my sensors
detected on the bus. At the moment where I was trying to read the
status I did not made any reconfiguration before. So my assumption was
that the module is already configured properly and at least an attempt
to read the status should succede.

Thank you,
Andrey.

