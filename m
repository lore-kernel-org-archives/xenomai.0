From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46A0C4B6.5070706@domain.hid>
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>
	<469F9CE2.9080603@domain.hid> <1184869450.28303.155.camel@domain.hid>
	<469FC65E.7070508@domain.hid> <1184880955.28303.235.camel@domain.hid>
	<46A0C4B6.5070706@domain.hid>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 20:33:31 +0200
Message-Id: <1184956411.5998.76.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC
	freeze	after	rt_task_start
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: mathias_koehrer@domain.hid, xenomai@xenomai.org

On Fri, 2007-07-20 at 16:20 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> ...
> > Read my mail, without listening to your own grumble at the same time,
> > you should see that this is not a matter of being right or wrong, it is
> > a matter of who needs what, and how one will use Xenomai. Your grumble
> > does not prove anything unfortunately, otherwise everything would be
> > fixed since many moons.
> 
> Why things are unfixed has something to do with their complexity. RPI is
> a complex thing AND it is a separate mechanism to the core (that's why I
> was suggesting to reuse PI code if possible - something that is already
> integrated for many moons).
> 

I'm afraid RPI and PI are very different beasts. The purpose of RPI is
to track real-time priority for the _pseudo_ root thread, PI deals with
Linux tasks. Moroever, RPI does no priority propagation beyond the first
level (i.e. the root thread one), and only has to handle backtracking in
a trivial way. For this reason, the PI implementation is way more
complex, zillion times beyond RPI, so the effort would be absolutely
counter-productive.

I understand your POV, the whole RPI thing seems baroque to you, and I
can only agree with you here, it is. However, we still need RPI for
proper behaviour in a lot of cases, at least with a co-kernel technology
under our feet. So, I'm going to submit fixes for this issue, and agree
to change the default knob from enabled to disabled for the native and
POSIX skins if need be, if the observation period tells us so.

Now, within the RPI issue, there is the double locking one: I'm going to
be very pragmatic here. If this is logically possible to keep the double
locking, I will keep it. The point being that people running real-time
applications on SMP configs tend in fact to prefer asymmetry to symmetry
when building their design. I mean that separate CPUs are usually
dedicated to different application tasks; in such a common pattern, if
one of the CPU is running a frequent (mode) switching task, it may put a
serious pressure on the nklock for all others (imagine a fast periodic
timeline on one CPU sending data to a secondary mode logger on a second
CPU, both being synchronized on a Xenomai synch). This is what I don't
want, if possible. If it is not possible to define a proper locking
scheme without resorting to 1) hairy and overly complex constructs, or
2) voodoo spells, then I will put everyone under the nklock, albeit I
think this is a sub-optimal solution.

Ok, let's move on. The main focus is -rc1, and beyond that 2.4 final. We
are damned late already.

-- 
Philippe.



