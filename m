Date: Wed, 19 Nov 2014 09:21:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119082140.GX3177@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xnintr_irq_handler: IRQ135 not handled. Disabling IRQ
 line.
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

On Wed, Nov 19, 2014 at 08:00:53AM +0000, Terje Frøysa wrote:
> Dear forum,
> 
> While running a long term test of my application, the application terminates without warning and the message below is logged in the console window.
> What may be the cause of this event?

Your application registers a handler for IRQ 135, which returns
RTDM_IRQ_NONE, meaning "the IRQ was not for me". And since there is
no other handler registered for this IRQ which returns
RTDM_IRQ_HANDLED, Xenomai considers your driver is buggy, so
disables the IRQ line, to avoid the buggy code path that is your irq
handler, because if indeed your irq handler did not acknowledge the
IRQ at the device level, and Xenomai does not disable the IRQ line,
the IRQ will trigger again, and the system will enter an infinite
loop in IRQ mode, causing a lockup.

So, return RTDM_IRQ_NONE in an RTDM irq handler should really mean
that the IRQ is for another driver sharing the same line, not that
the IRQ was acknowledged at device level, but your hardware generate
spurious interrupts or your software has nothing to do to handle
this interrupt.

-- 
					    Gilles.

