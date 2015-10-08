MIME-Version: 1.0
In-Reply-To: <20151007144156.GC30140@hermes.click-hack.org>
References: <56139C8B.3060509@control.lth.se>
 <20151006192323.GB30765@hermes.click-hack.org>
 <5614C8E3.5090809@sigmatek.at> <5614D22A.8030203@sigmatek.at>
 <5615108A.6070001@control.lth.se>
 <20151007124107.GB30140@hermes.click-hack.org>
 <E56D0663-C3E8-42E8-A6D7-8CFCF9F7C116@control.lth.se>
 <20151007144156.GC30140@hermes.click-hack.org>
Date: Thu, 8 Oct 2015 11:08:46 +0200
Message-ID: <CAPRPZsAm5=TpD7K9S6i+rEStR3Pokk=yOPEP2ZRaFL39Szf+3Q@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Problems disabling SMI interrupts on MSI H87-G43
	motherboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <Xenomai@xenomai.org>

>> >> Thanks everybody, seems like I have to give up on that motherboard:
>> >>
>> >> 1. Nothing found to disable in the BIOS
>> >> 2. Disabling all sourcecs with smictrl
>> >(git://git.kiszka.org/smictrl.git)
>> >>    still gives high latencies with RTNet (+1.5 milliseconds).
>> >> 3. latency test does not show anything suspicious, so it might
>> >>    be some other issue.
>> >>
>> >> Anybody that has a suggestion on a recent motherboard that has been
>> >used with
>> >> RTNet and showing good results?

As you found out, most MB BIOSes set the SMI lock bit. No way around it.

How frequently do the high latencies occur => we had a MB that issued
an SMI to speed up the fans when the CPU temperature was rising. We
set the fans to max in BIOS to avoid this, successfully. (We think
that the SMI is issued as a last resort when the kernel is not
handling ACPI thermal events. So disabling every CPU ACPI feature in
an effort to avoid latencies may actually cause SMIs.)

Do you use the onboard LAN => some Intel (i217) uses a low-performance
version of PCIe, called Kumeran, see
http://sourceforge.net/p/e1000/mailman/message/32283346. In this post,
I also tested a patch that seemed to help a bit. Maybe it also affects
the 1.5ms latency ? Do you have the same issue with an external PCI(e)
NIC ? Ans in that case, also test different PCIe slots; some are
behind bridges, others not.

>> Well, same kernel identical ethernetcard on motherboard without SMI, works flawlessly (network jitter in 30 ms range).

30ms ? That's also quite significant, I'd say.

Which MB are you using that does not have SMI (or at least lets you
disable it completely) ?


Jeroen.

