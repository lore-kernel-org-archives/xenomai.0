Date: Tue, 2 Dec 2014 11:53:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141202105344.GH2076@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
 <20141202093346.GE2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C519EE@SINTEFEXMBX05.sintef.no>
 <20141202095707.GG2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51AB4@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C51AB4@SINTEFEXMBX05.sintef.no>
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

On Tue, Dec 02, 2014 at 10:20:59AM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> 
> The flags are zero (from example code).... should I have used RTDM_IRQTYPE_EDGE ?
> 
> err = rtdm_irq_request(&info->gpio_irq, gpio_irq_n, imu_irq_handler, 0, THIS_MODULE->name,  NULL);

If the IRQ is of a certain type, you certainly want to pass the
right irq type.

Looking at the code:
- you only get the message after not returning RTDM_IRQ_HANDLED 1000
times, so, if you see the message, it is sure that some code is not
returning RTDM_IRQ_HANDLED, I suggest you check if the interrupt is
shared, and if another handler is not called
- the xenomai core skips reenabling the interrupts in that case, so,
if it gets reenabled, something re-enables it.

Are you sure that you do not register the handler to early, that it
fires because the hardware is not initialized, then gets disabled by
Xenomai core. Then later, your driver performs the hardware
initializations, and re-enables irqs ?

-- 
					    Gilles.

