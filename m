MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18278.61029.777027.211635@domain.hid>
Date: Mon, 17 Dec 2007 22:47:17 +0100
In-Reply-To: <168027.86920.qm@domain.hid>
References: <168027.86920.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

Michael Trimarchi wrote:
 > In linux the interrupt nesting is controlled by the hardware logic. Is it true?
 > 
 > 
 > 
 > The priority is mainted using ipipe in at91sam9260? 

On AT91 the interrupt controller works as follows: when an interrupt
occurs, the processor irq line is asserted, until the processor reads
the AIC_IVR register. At that point, and until the processor writes to
the AIC_EOICR register, interrupts of lower priority are masked, and
only interrupts of higher priority could cause the processor irq line to
be reasserted.

In linux implementation (as of today), the write to the AIC_EOICR
register occurs at the end of the asm_do_IRQ function, after the
interrupt handler is invoked. So, this means that during all the work
done by an interrupt handler, lower priority interrupts are masked, and
only higher or equal priority interrupts can trigger the next
interrupt. So, the answer to your first question is yes, the interrupt
nesting of Linux _on AT91_ is controlled by the hardware logic.

Now about the I-pipe. The first implementation of I-pipe on AT91
followed the same logic as Linux, and this caused me a lot of headaches:
when testing the I-pipe: I could get timer interrupt jitter of 40 ms
when the board was put under ethernet irq load and could not understand
why. Until I understood that the interrupt controller had priorities,
and that the TC (used as timer hardware on AT91) had a lower priority
than the ethernet interrupt. So my first conclusion was that TC should
be given a priority higher than any other interrupt on the system if we
wanted to run Xenomai on AT91. And the result is that the I-pipe patch,
until 1.7-06 followed the same logic as Linux.

But this behaviour means that a non real-time interrupt can delay a
real-time interrupt if its hardware priority is higher. And discussion
with Jan convinced me that the behaviour was wrong: interrupt controller
priorities should only arbiter interrupts occuring at the same time, and
soon I understood why this happened: because of the late writing to the
AIC_EOICR register, so, I changed the write to the AIC_EOICR register to
happen when acknowleding the interrupt, at the very beginning of the
interrupt handling, which allowed me to test successfully the I-pipe
patch with the original interrupt priorities. So, the answer to your
second question is no: the priority in I-pipe (from 1.8-00 onward) is no
longer handled in hardware, and it is probably better the way it is.

Interestingly enough, I have not followed that discussion at all, but a
discussion took place about interrupt handling and the RT patch on AT91,
and looking at the patches sent to the linux-arm-kernel mailing list, it
seems that these people came to the same conclusion: write to the
AIC_EOICR should take place when acknowleding the interrupt, that is why
I say that the I-pipe patch is probably better the way it is.

-- 


					    Gilles Chanteperdrix.

