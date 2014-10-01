From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 11:46:41 -0400
Message-ID: <20141001154641.GC4435@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org>
 <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542C1DA3.8080306@xenomai.org>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Oct 01, 2014 at 05:28:35PM +0200, Gilles Chanteperdrix wrote:
> Do you use gpio_to_irq to obtain the irq number?

Yes.  I tried doing request_irq from a dummy linux driver and I managed
to get an interrupt.  I can't seem to get xenomai to see the interrupt
though.  Hmm.

I see this:

root@len-rx1400:~# cat /proc/xenomai/irq 
IRQ         CPU0        CPU1
 30:     2294394     1660178         [timer]
398:           0           0         0000002d
1031:           0           0         [sync]
1032:           1           0         [timer-ipi]
1033:         531           1         [reschedule]
1034:           0           0         [virtual]
1038:      535719         531         [virtual]

398 is the IRQ for GPIO bank 7 pin 14.  The linux driver test got an
interrupt from the device on that pin, but when I use xenomai I am so
far not getting the interrupt as far as I can tell.

Maybe I should try and no longer call request_irq first.

> Actually, it tells you that you called rt_intr_create from user-space,
> which ends-up calling ipipe_set_irq_affinity, which is not happy because
> it is not called from Linux domain. We modified ipipe_virtualize_irq to
> avoid that (only checking for root domain when CONFIG_IPIPE_LEGACY is
> not set), but we probably forgot the SMP case with ipipe_set_irq_affinity.

Oh.  Well if you have a patch I can test that.  Or a suggestion for
where to go and try to fix it.

-- 
Len Sorensen

