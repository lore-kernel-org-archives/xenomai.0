Message-ID: <fd6a47a90602141341j21ce1b77l@domain.hid>
Date: Tue, 14 Feb 2006 22:41:10 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <fd6a47a90602141133v6aeae6e1n@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11125_28303970.1139953270448"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F21867.8070002@domain.hid>
	<fd6a47a90602141007g7830d31fu@domain.hid>
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>
	<fd6a47a90602141052u1e136db8y@domain.hid>
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
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

------=_Part_11125_28303970.1139953270448
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've got some bad news.

I've rewritten (parts of) my driver to operate in native Linux (i.e. no
RTDM, no Xenomai). When I run this in a Xenomai-augmented kernel (with
Adeos, evidently), the machine hangs. However, when the same code is run in
the same but unmodified kernel, the code works as expected. Therefore it
seems that Adeos is to blame here.

Now, I could try to write a small driver program illustrating the problem.
Of course, it is impossible for you to test on my board. Maybe we could
agree on an MSI capable piece of hardware, that I could write the code for =
?

The reason I would very much like to test this setup is that I look upon MS=
I
as a very viable alternative to these ever-damned interrupt sharing
mechanisms. It is becoming more and more difficult to find computers that
allow you to reserve (a few) IRQ-lines these days (especially notebooks and
OEM desktops). Additionally, MSI is capable of bypassing the IO-APIC
entirely (although the Linux kernel needs that APIC support to enable MSI -
I've still got to find out why that is).

Jeroen.

------=_Part_11125_28303970.1139953270448
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've got some bad news.<br>
<br>
I've rewritten (parts of) my driver to operate in native Linux (i.e. no
RTDM, no Xenomai). When I run this in a Xenomai-augmented kernel (with
Adeos, evidently), the machine hangs. However, when the same code is
run in the same but unmodified kernel, the code works as expected.
Therefore it seems that Adeos is to blame here. <br>
<br>
Now, I could try to write a small driver program illustrating the
problem. Of course, it is impossible for you to test on my board. Maybe
we could agree on an MSI capable piece of hardware, that I could write
the code for ?<br>
<br>
The reason I would very much like to test this setup is that I look
upon MSI as a very viable alternative to these ever-damned interrupt
sharing mechanisms. It is becoming more and more difficult to find
computers that allow you to reserve (a few) IRQ-lines these days
(especially notebooks and OEM desktops). Additionally, MSI is capable
of bypassing the IO-APIC entirely (although the Linux kernel needs that
APIC support to enable MSI - I've still got to find out why that is).<br>
<br>
Jeroen.<br>

------=_Part_11125_28303970.1139953270448--

