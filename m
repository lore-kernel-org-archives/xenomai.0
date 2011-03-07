Date: Mon, 7 Mar 2011 10:26:04 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110307092604.GA21619@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299225060.2107.20.camel@domain.hid>
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Fri, Mar 04, 2011 at 08:51:00AM +0100, Philippe Gerum wrote:
> I'm not saying this would be impossible to enable MSIs there, I'm just
> saying that so far: nobody cared. Terrae incognitae.

Philippe,

I read adeos-ipipe-2.6.36-powerpc-2.12-02.patch in order to
re-acquaint myself with adeos. While I do not pretend to really
understand it, I did notice an incongruity in the interrupt handling
for my particular board.

The function, fsl_msi_cascade, in arch/powerpc/sysdev/fsl_msi.c:185
has in the non-ipipe version two different actions

	desc->chip->unmask(irq);
	desc->chip->eoi(irq);

depending on whether the controller is an ipic or mpic. The ipipe
code unconditionally executes ipic/unmask.

I noticed that the function 

	cpm_cascade() in arch/powerpc/platforms/8xx/m8xx_setup.c

does call eoi(), so I guessed that the eoi() in fsl_msi_cascade()
might have been overlooked. Putting the eoi() into the ipipe version
lets the machine handle the interrupts, and my test programs will even
run with the PCIe card and driver.

However, I am really making a grab in the dark, and I see strange
warnings like unexpected (in_irq() || irqs_disabled()) from
kernel/softirq.c:143 and so on.

Also, more interrupts appear for my card in /proc/interrupts than
expected.

Is this any kind of hint, or am I just completely lost?

Thanks,

Richard


