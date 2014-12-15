Date: Mon, 15 Dec 2014 21:04:32 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <548f3ed0cc1f95.52388489@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

> >> Certainly a well behaved driver would not touch a device already handled
> >> by a linux driver.  It should be possible to just issue an unbind request
> >> to the linux driver for the desired device and then a bind request to
> >> the rtnet driver to take over that device.
> 
> Thanks for sharing this information.  It sounds like that might work.
> 
> > The problem with the
> > bind/unbind solution is that the driver that will get all the cards
> > first depends on the drivers initialization order. With the "cards"
> > parameter, you do not have this issue.
> 
> Maybe one could create a script that would attempt to unbind both the rt and non-rt drivers (or check to see which one is bound and then unbind it), and then make the desired "bind" calls.  It would be better if the incorrect binding were not made in the first place, however.  I think the ideal solution would be to have a file that contains device/driver pairs that would keep the kernel from passing the specified devices to any other drivers.  I wonder how hard that would be to implement.

The RTnet configuration file rtnet.conf has already instrumentation for binding/unbinding devices. The REBIND_RT_NICS variable has to be set up with the correct NIC PCI addresses. If you have more then one NIC, you can identity PCI address of respective eth's using ethtool

ethtool -i eth0
ethtool -i eth1

etc.

The bus-info field contains device pci addres that you can directly insert to REBIND_RT_NICS. If you don't know which eth menage with physical interface, you can blink LED port of the NIC using, eg.

ethtool -p eth0

Best,
Mariusz




