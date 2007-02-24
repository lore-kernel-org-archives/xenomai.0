From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1172310149.2161.1.camel@domain.hid>
References: <45DF7933.6090803@domain.hid> <200702240010.57003.paul_c@domain.hid>
	<1172310149.2161.1.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 13:00:02 +0100
Message-Id: <1172318402.2161.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] [RFT] RTnet on x86_64
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users <rtnet-users@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, rtnet-developers <rtnet-developers@domain.hid>

On Sat, 2007-02-24 at 10:42 +0100, Philippe Gerum wrote:
> On Sat, 2007-02-24 at 00:10 +0000, Paul wrote:
> > Hi Jan
> > 
> > On Friday 23 February 2007 23:30, Jan Kiszka wrote:
> > > recent development on Xenomai and the underlying I-pipe patch [1]
> > > reached a point where real experiments on yet another architecture for
> > > RTnet are starting to make sense.
> > >
> > > In fact, RTnet has been enabled to build over x86_64 already two weeks
> > > back, including a necessary fix to the RTDM layer. I just checked again:
> > > it still compiles fine. 8)
> > >
> > > I'm lacking a test platform, so _you_ have the unique chance to be the
> > > first person running RTnet on 64 bits! Grab a 2.6.19 kernel and the
> > > latest I-pipe patch [2], checkout Xenomai [3] and RTnet trunk [4]. Put
> > > everything on some native 64-bit Linux installation and give it hell.
> > 
> > As you probably know, I've already committed to running tests over the weekend 
> > on real hardware - Not being familiar with RTnet, are there any test suites 
> > that can be used on say i386<->AMD64<->ppc ?
> > 
> > > Ah, and don't forget to report your findings!
> > 
> > /me is good at breaking "stuff" and reporting the results ;)
> > 
> > 
> 
> Btw, to push SMP too hard for now, I've just discovered an instability
> under RT operations, and enabling the tracer over SMP does introduce
> another random issue here. UP still looks fine. I'm going to chase the
> SMP issues now.
> 

CONFIG_PREEMPT breaks the toy when enabled, so you should be able to
safely run the Xenomai stack over SMP/x86_64 without preemption for the
time being.

-- 
Philippe.



