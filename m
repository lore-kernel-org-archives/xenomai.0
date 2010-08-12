From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1281628688.1730.76.camel@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
	<1279210298.1995.38.camel@domain.hid>
	<1279623645.2187.35.camel@domain.hid>  <4C469259.3000708@domain.hid>
	<1281538723.2246.120.camel@domain.hid>  <1281627931.2211.97.camel@domain.hid>
	<1281628688.1730.76.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 18:03:45 +0200
Message-ID: <1281629025.1730.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tim Cussins <timcussins@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-08-12 at 17:58 +0200, Philippe Gerum wrote:
> On Thu, 2010-08-12 at 16:45 +0100, Tim Cussins wrote:
> > Hi all,
> > 
> > On Wed, 2010-08-11 at 15:58 +0100, Tim Cussins wrote:
> > 
> > > I took the mv88f6290 patch and bullied it into applying to vanilla
> > > 2.6.29. Built ok, but was at home and no way to test, so I just got on
> > > with migrating it to 2.6.33. That seems to be done - check the 2.6.33
> > > boot output:
> > >   
> > >    ...
> > >   I-pipe: Domain Xenomai registered.
> > >   Xenomai: hal/arm started.
> > >   Xenomai: scheduling class idle registered.
> > >   Xenomai: scheduling class rt registered.
> > >   Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> > >   Xenomai: starting native API services.
> > >   Xenomai: starting POSIX services.
> > >   Xenomai: starting RTDM services.
> > >    ...
> > 
> > Just a status update - I think I'm pretty much were Sergey was back here
> > (+ some):
> > 
> > vanilla 2.6.33 kernel +
> > adeos-ipipe-2.6.33-arm-1.17-02.patch +
> > kirkwood specific stuff (taken from adeos-ipipe-2.6.29-mv88f6290.patch)
> > 
> > I can run all the xenomai apps. As with Sergey I'm seeing negative
> > values for the minimum latency, which seems odd. See Sergey's post if
> > interested:
> 
> Negative values are ok, they just mean that the timer shot is too much
> anticipated for your hardware, which has better latency than defined by
> the default calibration value.
> 

Assuming that those negative values are in the micro-second range though
(say, 1-20 us maybe?). Huge negative values would rather mean that
something is broken in the timing sub-system.

> Try reducing the value in /proc/xenomai/latency (i.e. echo (ns)
> > /proc/xenomai/latency), until the latency test shows a minimum latency
> slightly above 0.
> 
> > 
> > http://www.mail-archive.com/xenomai@xenomai.org
> > 
> > Cheers,
> > Tim
> > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 

-- 
Philippe.



