From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Wed, 30 Apr 2008 08:13:28 +0200
References: <1209512080.1662.311.camel@domain.hid>
In-Reply-To: <1209512080.1662.311.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200804300813.28178.Sebastian.Smolorz@domain.hid>
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

Travis Stratman wrote:
> I am working on getting Xenomai running on a board using the AT91SAM9260
> processor. The actual hardware on the board is very similar to the
> AT91SAM9260EK.
>
> I was able to patch and build the kernel and userspace without a
> problem. However, when I run the latency test, I often see the board
> lockup. I'm using 2.4.3 and the 2.6.20 adeos patch. I compiled all of
> the xenomai features that I needed into the kernel rather than building
> them as modules. I am using a GCC-4.1.1 EABI compiler and enabled the
> arm-eabi in configure. I have configured with and without the arm-tsc
> support.
>
> If I run the xeno-test script, everything seems fine until I get to the
> latency test, where it hangs, generally after printing "warming up..."
> but it doesn't always get that far. When I turn debugging on in the
> kernel configuration, the watchdog will kill the thread. If I run
> latency on its own, with or without dd load, I can sometimes get it to
> run and other times it fails before the first data is printed or after
> the first few tests. Sometimes it just seems to hang and then starts
> printing again after about 30 seconds or so, usually stopping later.

Please run the latency test with a higher period value, e.g.

latency -p 500

and see if it runs correctly.

-- 
Sebastian

