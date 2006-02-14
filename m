Message-ID: <fd6a47a90602141052u1e136db8y@domain.hid>
Date: Tue, 14 Feb 2006 19:52:33 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <43F220D7.6040705@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9421_7703291.1139943153824"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

------=_Part_9421_7703291.1139943153824
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In the meantime, I've located the rthal_irq_disable() and used it instead o=
f
the RTDM return value (which is now 0).

The machine still hangs.

More importantly, I noticed that the second (after the first) interrupt get=
s
lost (as is to be expected when the interrupt remains disabled). This cause=
s
the RTDM driver to timeout and the Xenomai program using the RTDM driver is
actually able to gracefully shut down. It seems that, upon exiting, the
machine hangs.

I'll now try two new tests:

1. Turn off the cards's interrupts after the first IRQ has arrived.
2. Keep my program alive for a few secs using task_sleep() or so to see if
cleanup code is going awry.

Any other tests ?

Jeroen.

------=_Part_9421_7703291.1139943153824
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In the meantime, I've located the rthal_irq_disable() and used it instead o=
f the RTDM return value (which is now 0).<br>
<br>
The machine still hangs.<br>
<br>
More importantly, I noticed that the second (after the first) interrupt
gets lost (as is to be expected when the interrupt remains disabled).
This causes the RTDM driver to timeout and the Xenomai program using
the RTDM driver is actually able to gracefully shut down. It seems
that, upon exiting, the machine hangs.<br>
<br>
I'll now try two new tests:<br>
<br>
1. Turn off the cards's interrupts after the first IRQ has arrived.<br>
2. Keep my program alive for a few secs using task_sleep() or so to see if =
cleanup code is going awry.<br>
<br>
Any other tests ?<br>
<br>
Jeroen.<br>
<br>

------=_Part_9421_7703291.1139943153824--

