Date: Tue, 27 Sep 2011 14:01:22 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110927120122.GA10155@domain.hid>
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8188CB.4040102@domain.hid>
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 27, 2011 at 10:26:51AM +0200, Jan Kiszka wrote:
> On 2011-09-26 13:41, Richard Cochran wrote:
> > - Simple to implement new drivers.
> > 
> >   Compare my rtpacket.h with the rtnet driver headers to see what I
> >   mean. Or, read rtnet/Documentation/README.drvporting and ask
> >   yourself, is it easy to port a driver to rtnet?
> 
> I would be careful with deriving generic properties from a potentially
> lucky first example. Already tried to apply your pattern on a standard
> PCI NIC, e.g. the common Intel 8257x series?

Of course, you are right about this. It would make sense to try a few
different flavors of MAC driver. But I do think my class API makes
sense from a design standpoint.

> > - Easier to maintain drivers.
> > 
> >   Making regular drivers into real time drivers will always be a
> >   chore. But, with its simple interface, the packet class driver hack
> >   is way less painful. (Look at my gianfar example. There really are
> >   not many changes to the Linux driver.)
> 
> What is your "simple interface"? That's what I'm interested in.

* class driver provides:
  - rtpacket_receive  Called by MAC driver when a packet arrives.
  - rtpacket_recycle  Called by MAC driver to yield transmitted buffers
                      back to class driver.
* MAC driver provides:
  - ops.transmit      Called by class driver to send a packet.
  - ops.recycle       Called by class driver to yield delivered buffers
                      back to MAC driver.
  - ops.filter        User space must provide a list of allowed Ether
                      types, and the MAC driver must filter out types
                      not in the list.
* That's all, folks.

> What is the pattern to apply on an arbitrary driver to add RT
> support?

There is no getting around the fact that you must get to know the MAC
driver (and perhaps HW). How to splice the interface into the driver
must be seen on a case by case basis.

> How does interface claiming work (so the RT is not conflicting with
> Linux)?

The idea is to always offer both, so every ethX creates a rt-ethX.
The RT traffic should always take priority over non-RT, to the extent
possible in the hardware.

> How does the configuration work?

The RT port is up whenever the normal network interface is. I do *not*
want to duplicate anything from the Linux network stack at all.

The only "nice-to-have" I think missing is MAC address filtering or
enabling mutlicast MAC reception or promiscuous mode. Since there are
global (at the hardware level), you can just set this using a normal
socket. But perhaps a user API that just calls the normal Linux kernel
code would work.

> How do you deal with things like watchdogs, error handling, IRQ
> coalescing avoidance, etc.?

Again, every MAC driver needs to be tastefully and wisely adapted. I
don't necessarily need to avoid coalescing. The goal (for me) is *not*
to provide deterministic Ethernet performance. Instead the RT packets
should just be delivered ASAP.

The userland RT send/recv methods must not block or switch to
secondary mode, however.

> Hmm, looks like your concept is completely lacking IRQ
> support. That's of course a major limitation, specifically with RT
> Ethernet protocols where the network provides a clock source.

I don't know of any Ethernet protocols where the network provides a
clock, except for NTP and PTP, and for these RT performance is not
required. (EtherCAT does not count because the clock source is in the
first slave.)

Again, I know that rtnet is making Ethernet deterministic, but I just
don't need this.

> I'm surely not voting against Xenomai integration of some RT Ethernet
> (micro-)stack. I'm even not voting against rewriting the RTnet mess from
> scratch.

So, I think raw Ethernet access is not even a micro-stack. It is no
stack at all, just packets. The stack logic, if any, goes into the
user space program.

> What I'm skeptic about are statements like "this is so much simpler
> because it will never require X or Y". Reminds me of the people
> reimplementing QEMU as kvm-tool. The architecture of an RT Ethernet
> stack should at least be based on the experience of RTnet, not widely
> ignore it.

no stack, no stack, no stack!

It sounds like to me that the requirements on rtnet drivers
practically force you to write a special rtnet driver. I don't need
rtnet, just raw Ethernet from a Xenomai program in primary mode. This
is relatively easy to do by splicing into the existing MAC drivers.

Thanks,

Richard

