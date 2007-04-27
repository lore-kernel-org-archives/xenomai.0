From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4631E30B.6060701@domain.hid>
References: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 15:14:40 +0200
Message-Id: <1177679680.5010.78.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-04-27 at 13:48 +0200, Jan Kiszka wrote:

> > 
> > I have attached my kernel config to this mail.
> > Any idea on this? Is there anybody out there that has MSI running succesfully with the Xenomai adeos patch?
> 
> Hmm, from a glance at the 2.6.20 ipipe patch I would say that MSI is
> currently unsupported. No related patch hunk makes it look suspicious to
> me -- or is this supposed to work automagically, Philippe?

Since genirq, MSI interrupts have their irq_chip descriptor managed by
the IO-APIC support. What remains to be tested is the masking/unmasking
code, which is still implemented by the msi driver; unfortunately I have
no PCI-Express hw at hand anymore, so I can't test CONFIG_PCI_MSI
properly.

At first sight, the issue Mathias raised looks like an out-of-bound
array reference indexed on an unexpectedly large IRQ value; this would
be quite a dumb bug, but the only way to check that is with proper hw.

-- 
Philippe.



