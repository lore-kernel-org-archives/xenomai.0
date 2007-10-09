MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18187.63871.791885.643837@domain.hid>
Date: Tue, 9 Oct 2007 23:58:23 +0200
In-Reply-To: <470BDA72.8070908@domain.hid>
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
	<470BC537.8010200@domain.hid>
	<305035a40710091207j4038c62s5fb81903ce843910@domain.hid>
	<305035a40710091207l185a8fcm8baf715e0a0ef2b3@domain.hid>
	<470BDA72.8070908@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Fwd: RTAI and Xenomai latency in kernel mode on
 AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Again, the priority should not be the issue. The issue is likely that a
 > pending or just being handled non-RT IRQ can stall some RT IRQ at
 > hardware level. That must not happen. I-pipe rather has to log,
 > acknowledge, and possibly mask that line quickly so that RT IRQs can be
 > delivered again.

Thinking a bit more about my ethernet vs timer issue. If, when an
ethernet interrupt is pending, adeos is not aware that there is also a
timer interrupt pending, it will call the ethernet interrupt handler
immediately then unmask the interrupt. So, Adeos will never have a
chance to handle the timer interrupt before another ethernet interrupt
is handled. Ergo, giving the timer interrupt the highest priority is
what must be done.


-- 


					    Gilles Chanteperdrix.

