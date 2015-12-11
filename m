Date: Fri, 11 Dec 2015 15:59:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151211145929.GC24775@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
 <20151208201331.GA3667@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A70DC03@mb2010-1.intra.tut.fi>
 <20151210150110.GA20328@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A710FEB@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A710FEB@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as
 raw ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Dec 10, 2015 at 05:25:41PM +0000, Umair Ali wrote:
> Hello,
> 
> > >
> > >  what you observe is the jitter, you can measure the timer
> > interrupt jitter with the "latency" test, but I bet that maybe the
> > latency may be higher than 5us;
> > - if you really really need to reduce the jitter, then using kernel
> > timers instead of sleeping in a user-space thread is recommended,
> >
> > Yes, you are right that what i have observed is the jitter. I have
> > gone through the links which you have provided me in the last
> > email. I am building my application using POSIX skin. In the
> > links, they have used the rtdm_timer_start(). Now my question is
> > that can i use the rtdm functions in the application compiling
> > with posix skin, if yes then how. Do i have to change the skin for
> > comilation in order to use the rtdm functions. Please refer me
> > some guide for using the Xenomai Kernel timers with posix skin in
> > order to avoid the jitter. Last thing do i need to made a kernel
> > module in order to use the kernel timers. I am confused. Please
> > guide me.
> 
> > If you want to use kernel-space, you need to write a driver,
> > running in kernel spaces, and drivers use the RTDM API. The POSIX
> > API is for the application.
> 
> As i need to send raw Ethernet packets therefore i am using rtnet
> driver for this purpose. Do you mean that i have to write my own
> driver for ethernet card. Or should i have to write an rtdm driver
> that uses rtnet drivers for sending the raw ethernet. Or is there
> a way i can change the rtnet drivers according to my need.

I mean that if you want to send a packet every 5us with very low
jitter, you should not send the packets from a user-space thread,
but pass them to a driver which sends them based on an RTDM timer. I
would not recommend doing that, because you would have to modify
rtnet to do it: the rtnet stack send path may use a mutex, so can
not be called from a timer handler.

-- 
					    Gilles.
https://click-hack.org

