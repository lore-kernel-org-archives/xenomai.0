Message-ID: <20080825141624.3hk4ndxf9xwcgkcg@domain.hid>
Date: Mon, 25 Aug 2008 14:16:24 +0200
From: bernhard@domain.hid
References: <20080812075358.4cg1ix9945msccsc@domain.hid>
	<48A12EA8.4070601@domain.hid> <48A34D75.9090509@domain.hid>
	<48A359D4.9090002@domain.hid> <48A3D20B.2080509@domain.hid>
	<48A3D595.9040607@domain.hid>
	<20080814125307.1uviqgmj95no4k0k@domain.hid>
	<48A43555.3070701@domain.hid> <48A45084.3000208@domain.hid>
	<48A46408.7010602@domain.hid> <48A6B8EC.8020302@domain.hid>
	<48AA9DAA.3040801@domain.hid>
	<20080819123133.n9ool6j5d5msowk8@domain.hid>
	<48AAD622.8030402@domain.hid> <48AB32B8.5040403@domain.hid>
	<48ABE629.5090303@domain.hid>
In-Reply-To: <48ABE629.5090303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

Zitat von Philippe Gerum <rpm@xenomai.org>:

> The risk in ironing those PCI locks is to run with hw interrupts  =20
> disabled for a
> long time, inducing pathological latencies, so running RTAI's latency test=
 in
> the background should help detecting those peaks.
>
> However, we may find nothing bad if the kernel uses the MMConfig  =20
> access method
> to the PCI space since this is basically fast mmio there. But since  =20
> you seem to
> be running on x86_32, we may want to check whether BIOS or direct  =20
> access to the
> PCI config does not raise the typical latency too much, as well (I'm =20
>  unsure that
> PCI_GOBIOS will give us decent results though).
>
> To sum up: with different settings for the PCI config access method in "Bu=
s
> options" (by order of criticality, MMConfig then Direct, then maybe  =20
> BIOS), does
> the latency tool report pathological peaks?
>

Hi Philippe

I played with the different PCI configurations and the results are =20
devastating. Latencies (and jitter) skyrocket after some minutes of =20
testing and peak at several milliseconds. I didn't do the regression =20
with 'normal' INTs though, but that's something up next. Additionally =20
MMCONFIG produced some strange msg at boot.

I suspect I'm going to use INTs for my current project :(

Bernhard


PCI_GOMMCONFIG
--------------

I get the following dmesg:

ACPI: bus type pci registered
PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 31
PCI: Not using MMCONFIG.
PCI: Fatal: No config space access function found
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI Exception (evregion-0420): AE_ERROR, Returned by Handler for
[PCI_Config] [20080321]
ACPI Error (psparse-0530): Method parse/execution failed
[\_SB_.PCI0.LNK1._STA] (Node f7835e3c), AE_ERROR
ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.LNK1._STA]
(Node f7835e3c), AE_ERROR
ACPI Exception (evregion-0420): AE_ERROR, Returned by Handler for
[PCI_Config] [20080321]
ACPI Error (psparse-0530): Method parse/execution failed
[\_SB_.PCI0.LNK2._STA] (Node f7835d9c), AE_ERROR
ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.LNK2._STA]
(Node f7835d9c), AE_ERROR
ACPI Exception (evregion-0420): AE_ERROR, Returned by Handler for
[PCI_Config] [20080321]
ACPI Error (psparse-0530): Method parse/execution failed
[\_SB_.PCI0.LNK3._STA] (Node f7835cfc), AE_ERROR
ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.LNK3._STA]
(Node f7835cfc), AE_ERROR
ACPI Exception (evregion-0420): AE_ERROR, Returned by Handler for
[PCI_Config] [20080321]
ACPI Error (psparse-0530): Method parse/execution failed
[\_SB_.PCI0.LNK4._STA] (Node f7835c5c), AE_ERROR

[....]


PCI_GODIRECT
------------

Here desg looks better:

ACPI: bus type pci registered
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:0a.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIGP] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LU1B] (IRQs 5 7 9 10 11 14 15) *0
ACPI: PCI Interrupt Link [LU2B] (IRQs 5 7 9 10 11 14 15) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 11 14 *15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0
ACPI: PCI Interrupt Link [AIGP] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AUBA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AUB2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AU1B] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AU2B] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0







