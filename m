Message-ID: <fd6a47a90602151002q3f38748ep@domain.hid>
Date: Wed, 15 Feb 2006 19:02:16 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <fd6a47a90602150300y5e435a22i@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20175_25599064.1140026536300"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
	<43F2521E.7040200@domain.hid>
	<fd6a47a90602150300y5e435a22i@domain.hid>
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

------=_Part_20175_25599064.1140026536300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At second sight, the patches are ok.

I=B4ve boiled the problem down to a lack of EOI. If I do __ack_APIC_irq() b=
y
hand after the desc->handler->end() has run, the system no longer freezes.

I'm finding out why that is.

Jeroen.

------=_Part_20175_25599064.1140026536300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At second sight, the patches are ok.<br>
<br>
I=B4ve boiled the problem down to a lack of EOI. If I do __ack_APIC_irq()
by hand after the desc-&gt;handler-&gt;end() has run, the system no
longer freezes.<br>
<br>
I'm finding out why that is.<br>
<br>
Jeroen.<br>

------=_Part_20175_25599064.1140026536300--

