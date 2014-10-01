From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 16:33:01 -0400
Message-ID: <20141001203301.GH4435@csclub.uwaterloo.ca>
References: <542C165E.6060809@xenomai.org>
 <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org>
 <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca>
 <542C3A89.7000307@xenomai.org>
 <20141001174029.GF4435@csclub.uwaterloo.ca>
 <542C3DF7.90804@xenomai.org>
 <20141001175437.GG4435@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141001175437.GG4435@csclub.uwaterloo.ca>
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

On Wed, Oct 01, 2014 at 01:54:37PM -0400, Lennart Sorensen wrote:
> Well gpio-omap has this:
> 
>         if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>                 __irq_set_handler_locked(d->irq, handle_level_irq);
>         else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>                 __irq_set_handler_locked(d->irq, handle_edge_irq);
> 
> 
> So I imagine it would call handle_level_irq in my case.  When I don't
> specify HIGH or LOW, it would call neither and I get no hang.  I did
> not try FALLING or RISING yet, although currently I suspect those would
> hang too.
> 
> I also see:
> 
>                         ipipe_handle_demuxed_irq
>                                 (irq_find_mapping(bank->domain, bit));
> 
> That's in gpio-omap as well.  I see no calls to generic_handle_irq?

I noticed gpio_unmask_irq in gpio-omap.c uses irqd_get_trigger_type to
get the existing trigger type in case if was masked by setting it to
type NONE.  I don't see anywhere actually calling irqd_set_trigger_type
though to actually populate the data with the desired trigger.  Maybe I
just missed it but I just don't see where that is being done.  Doesn't
explain the hang, but sure looks weird.

-- 
Len Sorensen

