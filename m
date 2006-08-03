Subject: Re: [Xenomai-help] testing interrupt latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17618.14793.304543.952079@domain.hid>
References: <1154615459.9835.62.camel@domain.hid>
	<17618.14793.304543.952079@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 20:18:34 +0200
Message-Id: <1154629114.5010.161.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, 2006-08-03 at 20:00 +0200, Gilles Chanteperdrix wrote:
> Bart Jonkers wrote:
>  > Hey,
>  > 
>  > I have written a small module to test the interrupt response time of
>  > Xenomai to compare it with the time of Linux.
>  > 
>  > I generate an interrupt on a GPIO pin and toggles another GPIO pin in
>  > the interrupt service routine. (code below)
>  > The time between the generated interrupt and the value change on the
>  > GPIO pin is taken as interrupt response time.
>  > 
>  > Everything works well, but I notice a strange behavior.
>  > I thought that the interrupt response time of xenomai should be (as good
>  > as) constant all the time. But I see that this is not the case.
>  > 
>  > Did I do something wrong in my code or did I made a wrong assumption?
> 
> What should be guaranteed by Xenomai is that the response time is
> bounded, not that it is constant. Of course, we make all we can to make
> the bound as small as possible, but each hardware has its
> limits.
> 

Indeed. Not to speak of the basic issue all real-time Linux
infrastructures (native or not) have to deal with, compared to purely
standalone RTOSes: the hardware is shared by GPOS services which do not
give a damn of our efforts to keep the latencies close to the hardware
limits. See TLB flushes, significant cache trashing, power saving
tricks, funky processor modes and friends. This is the price to pay for
having real-time and general purpose services integrated on a single and
commoditized hardware and software platform.

-- 
Philippe.



