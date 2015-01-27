Date: Tue, 27 Jan 2015 15:00:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150127140003.GB16502@hermes.click-hack.org>
References: <20150126190241.GA10160@bugfree>
 <20150126190911.GN12812@hermes.click-hack.org>
 <20150126195219.GA10959@bugfree>
 <20150126195409.GA1491@hermes.click-hack.org>
 <20150127130925.GA22089@dmia-degroote.isae.fr>
 <20150127132647.GA16502@hermes.click-hack.org>
 <20150127135506.GB22089@dmia-degroote.isae.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150127135506.GB22089@dmia-degroote.isae.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on Odroid-U3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnaud Degroote <arnaud.degroote@isae.fr>
Cc: xenomai@xenomai.org

On Tue, Jan 27, 2015 at 02:55:06PM +0100, Arnaud Degroote wrote:
> On 27/Jan - 14:26, Gilles Chanteperdrix wrote:
> > On Tue, Jan 27, 2015 at 02:09:25PM +0100, Arnaud Degroote wrote:
> > > I suppose the offender is related to exynos_eint_gpio_irq available here
> > > 
> > > https://github.com/adegroote/linux/blob/linux-stable-xenomai-odroid-3.17.y/drivers/pinctrl/samsung/pinctrl-exynos.c#L278
> > > 
> > > but from documentation and other code sample, I don't see the cause of the trouble.
> > > Any idea / guidance is welcome. Thanks in advance,
> > 
> > If all the generic_handle_irq were properly replaced with
> > ipipe_handle_demuxed_irq, you should not arrive at
> > exynos_eint_gpio_irq via generic_handle_irq. There is a hole somewhere.
> 
> I double checked, the only generic_handle_irq caller in vmlinux is
> handle_IRQ. And the two only callers of handle_IRQ are asm_handle_IRQ
> and __ipipe_do_IRQ, so it looks like I'm good on this point.

Unless I misunderstand the trace you have sent, as I said, I suspect
you are not.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150127/a6f737de/attachment.sig>
