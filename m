MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18349.44283.592864.119317@domain.hid>
Date: Sat, 9 Feb 2008 14:39:07 +0100
In-Reply-To: <246938.91746.qm@domain.hid>
References: <d6c8ef150802081142y54648ecex5b307eb3c25e5086@domain.hid>
	<246938.91746.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: david-b@domain.hid, adeos-main@gna.org

Michael Trimarchi wrote:
 > Hi,
 > > Thanks. Actually, I have simillar problems (buffer
 > > overrun) when working
 > > with serial port (at91sam9260-ek based board). But,
 > > I haven't inspected the
 > > problem more than that. I'll do that next week.
 > > 
 > > On Feb 8, 2008 8:36 PM, Gilles Chanteperdrix
 > > <gilles.chanteperdrix@xenomai.org>
 > > wrote:
 > > 
 > > >
 > > > I received a mail from Michael recently telling me
 > > that he observes the
 > > > same behaviour with the PREEMPT_RT patch, so the
 > > I-pipe patch is
 > > > probably out of cause. He now suspects a hardware
 > > issue (one serial port
 > > > pin seems to be shared with another peripheral, as
 > > I think I understood).
 > > >
 > > >
 > >
 > I finish my investigation, and I think that depens
 > only 
 > in some overhead. In linux is present using hrtimer
 > and doesn't depends on NO_HZ options. If some hrtimer
 > is executed with the interrupts disabled and the
 > serial
 > must receive a single char, you receive and overrun.
 > I suppose that the NO_HZ option can be a solution
 > (less interrupt) but an the end, doesn't change. The
 > dma
 > patch on serial device resolve the problem. I think
 > that for adeos is the same. I try to investigate, how
 > long is the max blocking time in hrtimer interrupt.
 > 
 > Using TC timer is ok. David and Gilles, you are right
 > but I want to know how in linux-rt and adeos, I can
 > reduce the latency to support this interrupts
 > frquency.

If I were you, if this serial driver was used only for debugging, I
would tolerate overruns. And if my application relied on the correct
working of a serial driver, I would use another driver, because you can
not base a system on a driver needing 10000 interrupts by second without
loss. This is not reasonable, especially on ARM. Or use a lower baud
rate.

-- 


					    Gilles Chanteperdrix.

