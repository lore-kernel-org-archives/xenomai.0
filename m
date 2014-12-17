Resent-Message-ID: <20141217190615.GJ2012@hermes.click-hack.org>
Resent-To: xenomai@xenomai.org
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <mailman.737.1418843176.6101.xenomai@xenomai.org>
Subject: [Xenomai] RTnet announce
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Date: Wed, 17 Dec 2014 19:06:15 -0000
To: Xenomai <xenomai@xenomai.org>

Have some of you have noted, and even started testing, the xenomai 3
git repository integrates a first port of the RTnet IP stack for
Xenomai. This was supposed to be tested with the release of the next
release candidate, with the following note. 

Note that this is a work in progress, so,

what has been tested and works:
- the core module, 
- the IP stack, 
- the nomac access control policy, 
- the rtnetproxy addon, 
- the rtcap addon, 
tested with the following drivers:
- r8169 (updated to support the 8136 chip and MSI) tested on x86_64 atom
- 8139too tested on SMP Pentium 3
- at91_ether (rebased on Linux 3.16 version, in order to get it to
compile with latest kernels) tested on at91rm9200
- macb (same rebase, gaining support for gem driver) tested on
at91sam9263 and at91sama5d3 (using the newly supported gigabit gem driver)
this for kernel versions 3.14 and 3.16.

what has changed:
modules refcounts are now linked to the network interfaces status:
you can not remove a module as long as the interface it implements
(whether real-time for a NIC driver or Linux driver for the modules
which implement Linux net device drivers) is not down. So use 
ifconfig/rtifconfig to stop the interface before trying and
unloading modules.

what has not been tested:
- basically all the other drivers, the PCI/PCIe drivers have been
compile tested, but that is all. 
- The PPC drivers have not even been compile tested
- The UDP protocol, 
- the AF_PACKET interface.
- the TDMA access control policy

what is known not to work.
- not compiling some parts as module. This probably works for the
rtnet core, but not for much else, compiling as module imposes the
initialization order due to module dependencies, whereas building
everything in the kernel means that the initialization order is no
longer guaranteed
- the TCP protocol, it does not even compile so has been temporarily
disabled, this should be fixed shortly

Regards.

-- 
					    Gilles.

