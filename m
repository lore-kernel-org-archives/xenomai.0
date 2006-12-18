From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] Latency trace on ARM
Date: Mon, 18 Dec 2006 11:52:00 +0100
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1GvE4x-0002Xw-4y@domain.hid> <4582B3B0.8080505@domain.hid>
In-Reply-To: <4582B3B0.8080505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GwG68-0005um-1j@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >> Sebastian Smolorz wrote:
> >>> Jan Kiszka wrote:
> >>>> Sebastian Smolorz wrote:
> >>>>> Hi,
> >>>>>
> >>>>> we all know that the latency test should not be run with a period of
> >>>>> 100 us because it easily gets locked up. The attached trace
> >>>>> illustrates this problem in detail. It shows that a timer interrupt
> >>>>> needs about 50 us to be processed. Furthermore, there is not enough
> >>>>> time between two timer interrupts for the latency task to get all its
> >>>>> work done.
> >>>>>
> >>>>> The current I-pipe tracer patch for ARM is available at
> >>>>> http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm.p
> >>>>>at ch _v4
> >>>>>
> >>>>> Comments welcome.
> >>>>
> >>>> Something is still broken, given all those "N"s in Delay column. Is
> >>>> there something like NMI at all on your board?
> >>>
> >>> There isn't AFAIK. What could be the reason for all this noise?
> >>> Recursive spin-locking?
> >>
> >> Yes. If those Ns aren't false positive in the sense that
> >> IPIPE_TFLG_NMI_HIT is set accidentally, __ipipe_trace is re-entered
> >> while IPIPE_TFLG_NMI_LOCK is still set.
> >
> > Interesting: If I disable CONFIG_IPIPE_TRACE_MCOUNT the "Noise" doesn't
> > appear at all.
>
> Sounds like some function that __ipipe_trace calls is instrumented, thus
> the recursion. Could be something trivial like memcpy (if that happens
> to be uninlined here).

Ok, your hint was very useful! The problem was __ipipe_mach_get_tsc() which is 
no inline function (and can't be). I solved it by adding 'notrace' to the 
function. Now the 'N's don't appear at all!

--
Sebastian

