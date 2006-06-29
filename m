Sender: dv@domain.hid
Message-ID: <44A3919C.596DFDAE@vollmann.ch>
Date: Thu, 29 Jun 2006 10:38:52 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Some questions about the ARM port (Integrator vs.
	PXA)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

looking at the ARM Integrator patch (which seems to be something
like the reference port for ARM), I'm not really clear about some
of the code:

 a) What's the difference between __ipipe_mach_ticks_per_jiffy
    and LATCH?

 b) Is there some (hidden, intended future) semantics of tscok?
    Right now it just avoids that garbage is returned before
    the timer is initialized.

 c) In the interrupt routine, the comment currently says:
    "If Linux is the only domain, ack the timer and reprogram it",
    but the actual code looks as if the comment should read:
    "If Linux is running natively, ack the timer.
    If Linux's the only domain, reprogram it."
    What's wrong, the code or the comment?

 d) __ipipe_mach_set_dec() sets the next match value of the timer.
    But the current counter isn't changed.  Correct?
    Or is setting the match value and setting the current counter
    the same operation on the Integrator?

    __ipipe_mach_get_dec() doesn't return the next match value, but
    the current actual counter, i.e. some value between 0 and the
    next match value.  Correct?
    And if so, which value?  The number of ticks elapsed since the
    last match or the number of ticks until the next match occurs?

    The names "..._dec" suggest that the integrator provides a clock
    register that decrements.  The PXA provides clock registers
    that are incremented, and the timer used for the Linux ticks
    is (in Linux) never reset, but instead the match value at
    which an interrupt occurs is incremented on each interrupt.
    So, a port to the PXA wouldn't be straightforward, and so I
    want to make sure that I really understand the semantics
    of the ARM port.

Thanks for any clarifications,
 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

