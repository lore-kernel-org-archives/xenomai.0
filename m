MIME-Version: 1.0
Date: Tue, 20 Jan 2009 12:06:47 +0100
Message-ID: <28d526a60901200306r16a6a23cg15f4490fbcccf8a0@domain.hid>
From: Simon Boman <simon.boman@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problem with gpioirqbench..
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

Hi!

I have modified gpioirqbench to my platform MPC8360, but when I execute it:
ipic.c is responding:
ipic: "edge sense not supported on internal interrupts"
Because "ipic only supports edge mode on external interrupts"

when this function:
of_irq_to_resource(np, 0, &r) is executing in gpioirq-hw.h.


Can somebody help me ?

TIA
/Simon

