Date: Mon, 9 Nov 2015 12:45:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151109114531.GA1563@hermes.click-hack.org>
References: <20151108084205.GG1798@hermes.click-hack.org>
 <BLU436-SMTP73E9091DCDE4C2D26FB175F0160@phx.gbl>
 <20151108171031.GR1798@hermes.click-hack.org>
 <BLU436-SMTP122F0286E6E48736DB2C3A6F0160@phx.gbl>
 <20151108172614.GS1798@hermes.click-hack.org>
 <BLU436-SMTP502B67C2B024CF139D04DEF0160@phx.gbl>
 <20151108174512.GT1798@hermes.click-hack.org>
 <BLU436-SMTP32474C5F5180D497EB0B7CF0160@phx.gbl>
 <20151108230959.GV1798@hermes.click-hack.org>
 <BLU437-SMTP73704258277408A0F2C238F0150@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP73704258277408A0F2C238F0150@phx.gbl>
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Sun, Nov 08, 2015 at 04:54:39PM -0800, Mathieu Rondonneau wrote:
> > Well, I am sorry, I am unable to communicate in a language where the
> > (universal) rules of logic do not apply. I suspect very few people
> > can.
> >
> I don't think it is about that.

It is exactly about that. The doc says "if the handler is
handle_fasteoi_irq, then add irq_hold and put an ipipe_lock in the
mask/unmask callbacks". Applying partially the "then" clause, when
the condition is false (when the handler is not handle_fasteoi_irq)
is an error of logic.

> What i am saying is the doc does not need to follow the coding structure.
> I think what I take from it (and I tend to forget) is that the doc is 
> for specific port and does not mean to be generic.

I have tried to make everything for the ARM architecture so that the
work of porting the I-pipe can be generic. So, having a
documentation that is not generic would be a failure.

> > Anyway, I am interested by your contribution, but as it is, I am
> > afraid you still misunderstood.
> >
> Please explain one more time, I really would like to understand :)
> I like what you guys are doing.
> the RPI2 uses handle_percpu_devid_irq for the local 
> timers/counters/IPI/videocore.
> 
> Once I get something working, I definitely will send you a patch for you 
> guys to review.

I was talking about your contribution to the documentation. But of
course, the contribution of the port would be welcome, but this goes
without saying, since the documentations says it:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Publishing_your_modifications

> 
> >>
> >> Side note: with two irqchip (one for handle_level_irq that does not
> >> lock_irq in mask and the one for handle_percpu_devid_irq that does the
> >> lock_irq in mask()) it does work.
> >
> > You can probably have only one irqchip and not bother to insert the
> > calls to ipipe_lock/unlock_irq.
> 
> Ok, this is new peace of information, that would work too. But then, 
> when one needs a lock_irq in mask and one does not?
> (it is the same question as 2 comments above.

As the doc says, when the handler is handle_fasteoi_irq.

-- 
					    Gilles.
https://click-hack.org

