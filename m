From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] Latency trace on ARM
Date: Fri, 15 Dec 2006 10:48:34 +0100
References: <E1GutB2-0005VT-Vb@domain.hid> <45819EFA.2090908@domain.hid>
In-Reply-To: <45819EFA.2090908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1Gv9g9-0001FB-Gy@domain.hid>
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
> > Hi,
> >
> > we all know that the latency test should not be run with a period of 100
> > us because it easily gets locked up. The attached trace illustrates this
> > problem in detail. It shows that a timer interrupt needs about 50 us to
> > be processed. Furthermore, there is not enough time between two timer
> > interrupts for the latency task to get all its work done.
> >
> > The current I-pipe tracer patch for ARM is available at
> > http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm.patch
> >_v4
> >
> > Comments welcome.
>
> Something is still broken, given all those "N"s in Delay column. Is
> there something like NMI at all on your board?

There isn't AFAIK. What could be the reason for all this noise? Recursive 
spin-locking?

>
> BTW, two asses the tracer's overhead, you may want to run some
> consecutive ipipe_trace_specials and watch the result in the log. Should
> be around 1.something per trace point.

It lies between 1.5 and 2.25 us. So the delay values get much more better.

--
Sebastian

