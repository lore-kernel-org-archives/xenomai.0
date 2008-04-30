Message-ID: <2ff1a98a0804300926x32d69d22k1db49c9fc48c3cc3@domain.hid>
Date: Wed, 30 Apr 2008 18:26:05 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1209572150.1662.322.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1209512080.1662.311.camel@domain.hid>
	<200804300813.28178.Sebastian.Smolorz@domain.hid>
	<1209572150.1662.322.camel@domain.hid>
Subject: Re: [Xenomai-help] Latency test locking AT91 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Travis Stratman <tstratman@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Apr 30, 2008 at 6:15 PM, Travis Stratman <tstratman@domain.hid> wrote:
> On Wed, 2008-04-30 at 08:13 +0200, Sebastian Smolorz wrote:
>  > Travis Stratman wrote:
>  > > I am working on getting Xenomai running on a board using the AT91SAM9260
>  > > processor. The actual hardware on the board is very similar to the
>  > > AT91SAM9260EK.
>  > >
>  > > I was able to patch and build the kernel and userspace without a
>  > > problem. However, when I run the latency test, I often see the board
>  > > lockup. I'm using 2.4.3 and the 2.6.20 adeos patch. I compiled all of
>  > > the xenomai features that I needed into the kernel rather than building
>  > > them as modules. I am using a GCC-4.1.1 EABI compiler and enabled the
>  > > arm-eabi in configure. I have configured with and without the arm-tsc
>  > > support.
>  > >
>  > > If I run the xeno-test script, everything seems fine until I get to the
>  > > latency test, where it hangs, generally after printing "warming up..."
>  > > but it doesn't always get that far. When I turn debugging on in the
>  > > kernel configuration, the watchdog will kill the thread. If I run
>  > > latency on its own, with or without dd load, I can sometimes get it to
>  > > run and other times it fails before the first data is printed or after
>  > > the first few tests. Sometimes it just seems to hang and then starts
>  > > printing again after about 30 seconds or so, usually stopping later.
>  >
>  > Please run the latency test with a higher period value, e.g.
>  >
>  > latency -p 500
>  >
>  > and see if it runs correctly.
>
>  Thank you, that seems to have fixed the issue. The entire xeno-test
>  script completes and the latencies seem to be very good.
>
>  I assuming that this is just because the board does not have enough
>  horsepower to run the test at 100 us?

Well yes. 100 us seems to be close to the limit between what the box
can bear and what it can not, because, whereas I have been oberving
the same lockup as you for a long time, it seems to have disappeared
when running latency without load with trunk and I-pipe patch for
2.6.24.

>
>  I'm new to this so I'm trying to learn as I go. Is there any specific
>  condition where I would not want to enable the ARM TSC support?

The option exists in the configure script because the tsc support is a
relatively recent addition to the I-pipe patch, so we need a way to
have xenomai compile and work for people using older patches. We do
not do any run-time detection in order to avoid adding any overhead to
the function reading the tsc.

-- 
 Gilles

