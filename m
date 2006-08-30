Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F5FC95.4030206@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<44F592AD.2000900@domain.hid> <1156960547.4323.68.camel@domain.hid>
	<44F5DDF1.3030006@domain.hid> <1156970880.4323.74.camel@domain.hid>
	<44F5FB26.40700@domain.hid> <1156971559.4323.82.camel@domain.hid>
	<44F5FC95.4030206@domain.hid>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 23:58:30 +0200
Message-Id: <1156975110.28417.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-30 at 23:01 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-08-30 at 22:55 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2006-08-30 at 20:50 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>
> >>>>> On Wed, 2006-08-30 at 15:29 +0200, Jan Kiszka wrote:
> >>>>>   
> >>>>>> Dmitry Adamushko wrote:
> >>>>>>     
> >>>>>>> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>>>>>       
> >>>>>>>> Dmitry Adamushko wrote:
> >>>>>>>>
> >>>>>>>> I think the additional costs of maintaining an error counter are almost
> >>>>>>>> negligible. The test is in the unlikely path, and the first condition
> >>>>>>>> already keeps us away from touching the counter.
> >>>>>>>>         
> >>>>>>> But it's updated (unhandled = 0) any time the ISR(s) report something
> >>>>>>> different from XN_ISR_NONE.  Hence, it's at the beginning of the xnintr_t
> >>>>>>> structure, hopefully, at the same cache line with other highly-used members
> >>>>>>> (i.e. isr, cookie and hits).
> >>>>>>>       
> >>>>>> Mmh, considering this and also the existing code I wonder if we could
> >>>>>> optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing
> >>>>>> is slow anyway): currently the intr object is touched both before
> >>>>>> (naturally...) and after the call to the ISR handler. Maybe we can push
> >>>>>> all accesses before the handler for the fast path. E.g.:
> >>>>>>
> >>>>>> int unhandled = intr->unhandled;
> >>>>>>
> >>>>>> intr->unhandled = 0;
> >>>>>> ++intr->hits;
> >>>>>> s = intr->isr(...);
> >>>>>>
> >>>>>> if (s == XN_ISR_NONE) {
> >>>>>> 	intr->unhandled = ++unhandled;
> >>>>>> 	if (unhandled == XNINTR_MAX_UNHANDLED)
> >>>>>> 		ALARM!
> >>>>>> }
> >>>>>>
> >>>>>>     
> >>>>> Without speculating whether this could actually reduce cache misses or
> >>>>> not when the branch is taken, the main issue I see here is that we would
> >>>>> optimize the error case, at the expense of an additional memory fetching
> >>>> No, it's the common path. Otherwise, I would have stopped already. I don't
> >>>> expect further memory access because the head of intr should be cached
> >>>> already.
> >>>>
> >>> Sorry, my brain cells must be glued together, but then, I just don't get
> >>> what your patch actually optimizes :o}
> >> Cache misses when accessing intr AFTER the ISR has finished (not on
> >> latest Pentium with 4 MB caches...) for the non-error case.
> > 
> > What do you call the "error case"?
> > 
> 
> XN_ISR_NONE

So the suggested optimization is about saving the clearing of
intr->unhandled, and the related cache reload/sync? Quite frankly, we
should really reduce the cache misses rate of Adeos instead (especially
the pipeline syncer, and the costly domain walk chain which has a
significant cache impact), it _is_ the one which has the highest margin
of improvement. Beside this, I'm still unsure that eating one register
more to cache the "unhandled" variable on x86 - only to handle the error
case that almost never happens - would not have a negative impact on the
common path, which would silently obliterate the initial gain.

Last point that bothers me: ISRs are allowed to re-enable the IRQ line
and unstall the Xenomai stage in the pipeline during processing, and the
nucleus is expected to handle interrupt nesting gracefully. So if such
nesting happens with two or more interrupts from the same unhandled
source (without entering any IRQ flood, that is), we would miss at least
one incrementation of the "unhandled" count, due to the local variable
caching, each time.

-- 
Philippe.



