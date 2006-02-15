From: "Russell Johnson" <rjohnson@domain.hid>
Subject: RE: [Xenomai-core] Handling PCI MSI interrupts
Date: Wed, 15 Feb 2006 16:09:55 -0700
Message-ID: <008501c63284$ef549ed0$1e01a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43F38A5E.9030402@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>, 'Jeroen Van den Keybus' <jeroen.vandenkeybus@domain.hid>
Cc: 'xenomai-core' <xenomai@xenomai.org>



> It's definitely an Adeos issue and msi.c needs fixing. What=20
> about this patch, do=20
> things improve with it (against 2.6.15-ipipe-1.2-00)?

I'm currently patching my setup which started with =
ipipe-2.6.14-i386-1.0-12.
I've been having no luck with any MSI devices in the system even if they
have supposedly had MSI disabled.  I'll post my testing results in the =
next
day or so.

Russ



