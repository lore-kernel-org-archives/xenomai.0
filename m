Date: Tue, 2 Dec 2014 13:13:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141202121320.GI2076@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
 <20141202093346.GE2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C519EE@SINTEFEXMBX05.sintef.no>
 <20141202095707.GG2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51AB4@SINTEFEXMBX05.sintef.no>
 <20141202105344.GH2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51CF0@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C51CF0@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] IRQ155 not handled. Disabling IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 02, 2014 at 12:07:50PM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> 
> I think setting the IRQ type mended the problem.
> 
> Before that I did some digging:
> I couldn't find any information that indicated a shared interrupt:
> The /proc/interrupts did not contain the IRQ155 and the /proc/xenomai/irq held only one entry for my driver (below).
> The external interrupt source is a PWM generated pulse-train of 200Hz, i.e. 5ms interval started the code-line before entering the read-loop.
> You say that the line must have been unserved for a 1000 events before being disabled.
> A 1000 events from when and at what rate if EDGE not spesified? The irq handler have no optional returns but "RT_INTR_HANDLED".
> Hence, I cannot imagine where the non-handled returns are coming from. At 5ms rate this would require 5s of pulses to reach 1000.
> The distance in time from IRQ enable to disable the IRQ line seem less than 4us..
> [19833.958667] RTDM IMU 27 - enable IRQ
> [19838.962472] Xenomai: xnintr_irq_handler: IRQ155 not handled. Disabling IRQ line.
> 
> However, I changed the flags to "RTDM_IRQTYPE_EDGE" and it seemed to have a good effect.
> I don't get the message any longer 

If the default irq type is say level low, your pwm signal being low
for for instance 5ms generates interrupts during 5ms, and since the
interrupt condition (low level) is still true, the interrupt
triggers over and over again.

Is the interrupt shared with Linux ?

-- 
					    Gilles.

