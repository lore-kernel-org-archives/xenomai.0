From: stefano.franzoni@domain.hid
Date: Thu, 18 Dec 2008 16:02:03 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Message-Id: <20081218150221.6297D1C066@domain.hid>
Subject: [Xenomai-help] Pentium III performances
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Dear experts

we have a systems with Ubuntu Linux 2.6.25.11 and Xenomai 2.4.4.
The system has a Pentium III (Coppermine) 1GHz.
The Xenomai installation seems to be ok.

I generate a periodic event based on a ISA irq every 2 msec. and also seems
to be right.
When we generate events in the human interface (open windows, ecc..) we
don't respect the deadline of 2 msec.

Pentium III is an obsolete system but we are wondering if this loose
performances depends on it.
It would be useful to know if this is a supported hardware and if is known
the related maximum IRQ latency and the maximun IRQ jitter.

Thanks in advance

Stefano


