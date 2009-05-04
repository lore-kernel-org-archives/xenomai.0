Date: Mon, 4 May 2009 12:04:24 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
Message-ID: <Pine.LNX.4.64.0905041110140.10290@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Defensive IRQ allocation procedure.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am I correct in believing that an RTDM driver can safely call
request_irq() from its non-realtime ioctl_nr() callback? I want to do
this to verify that a non-realtime driver isn't using the same IRQ as
my realtime device, before I attempt to use it in my RTDM driver, and
as well as to prevent any non-realtime drivers from allocating that
IRQ once I have started to use it. I can't do this at module
initialization time, because I don't know which of our identical
digital I/O boards is connected to what, until I perform I/O to them,
and not all of them need interrupts.

Thanks,

Martin

