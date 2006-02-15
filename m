Message-ID: <fd6a47a90602150300y5e435a22i@domain.hid>
Date: Wed, 15 Feb 2006 12:00:36 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <43F2521E.7040200@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15614_18960184.1140001236448"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
	<43F2521E.7040200@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_15614_18960184.1140001236448
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In a search for the problem, I encountered some code which may be at the
root of the problem. In file

arch/i386/kernel/io_apic.c

I see that a function mask_and_ack_level_ioapic_vector() is being defined,
whereas the original 2.6.15 code did not ever issue any IO_APIC calls (both
mask_and_ack_level_ioapic and end_edge_ioapic are void in include/linux/).

Is it possible that this code was transferred with patches for earlier
kernels (at least from 2.6.11) ?

I'm going to check this now and hopefully fix it.

[ As a matter of fact, the IO_APIC shouldn't play any role in the processin=
g
of MSI interrupts, which are addressed at (default) addr. 0xFEE00000 in the
CPU. An exception to this are interrupts issued by PCI cards to the IO_APIC
itself (default addr.: 0xFEC00020) to trigger IRQs 0-23, which is a feature
Linux doesn't seem to use and was seemingly intended for card mftrs. to
support MSI without changing the drivers. ]


Jeroen.

------=_Part_15614_18960184.1140001236448
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>In a search for the problem, I encountered some code which may be at t=
he root of the problem. In file</div>
<div>&nbsp;</div>
<div>arch/i386/kernel/io_apic.c<br><br>I see that a function mask_and_ack_l=
evel_ioapic_vector()
is being defined, whereas the original 2.6.15 code did not ever issue
any IO_APIC calls (both mask_and_ack_level_ioapic and end_edge_ioapic
are void in include/linux/).<br>
<br>
Is it possible that this code was transferred with patches for earlier kern=
els (at least from 2.6.11) ?<br>
<br>
I'm going to check this now and hopefully fix it.<br>

</div>

<div><br>
[ As a matter of fact, the IO_APIC shouldn't play any role in the
processing of MSI interrupts, which are addressed at (default) addr.
0xFEE00000 in the CPU. An exception to this&nbsp;are&nbsp;interrupts
issued by PCI cards to the IO_APIC itself (default addr.: 0xFEC00020)
to trigger IRQs 0-23, which is a feature Linux doesn't seem to use and
was&nbsp;seemingly intended for card mftrs. to support MSI without
changing the drivers. ]
</div>
<div>&nbsp;</div>
<br>
Jeroen.<br>
<br>


------=_Part_15614_18960184.1140001236448--

