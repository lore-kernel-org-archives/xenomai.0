MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18517.2563.512561.580561@domain.hid>
Date: Sun, 15 Jun 2008 14:24:35 +0200
In-Reply-To: <4854CF37.20001@domain.hid>
References: <4850DC9D.4010607@domain.hid>
	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid> <485174A7.7040505@domain.hid>
	<485227E2.3030603@domain.hid> <48523BE4.8070403@domain.hid>
	<48523E11.40702@domain.hid> <4854CF37.20001@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] High latencies on Core2Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Sebastian Smolorz wrote:
 > > Philippe Gerum wrote:
 > >> Sebastian Smolorz wrote:
 > >>> Philippe Gerum wrote:
 > >>>> Could you run another trace with that patch applied? TIA,
 > >>>
 > >>> Here it comes.
 > >>>
 > >>
 > >> Thanks. Is the latency spot regularly happening at the same place
 > >> after a few runs,
 > >> or rather randomly?
 > > 
 > > 
 > > I can for sure activate it with a kernel compilation with make -j2.
 > > Without load, it is more or less random and more seldom.
 > > 
 > 
 > Could you try booting with idle=poll just to make sure that we don't get trapped
 > into long wakeup latency from some idling instruction? We explicitly avoid mwait
 > unless forced to use it by a bootparam, but maybe something goes wrong with the
 > default idle code as well.
 > 
 > FYI, I have latency spots of the same magnitude on a Dell precision m65 laptop
 > here too, but I also have latency figures  < 5 us under extreme load on a
 > four-way Opteron-based workstation (Fujitsu Siemens) with the very same
 > pipeline+Xenomai combo, so there is a significant risk that a hw issue (possibly
 > chipset) bites us here.

Maybe the chipsets evolved and our SMI disabling code is no longer
working... Someone probably needs to read a recent chipset documentation.

-- 


					    Gilles.

