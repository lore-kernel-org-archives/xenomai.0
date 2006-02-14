Message-ID: <fd6a47a90602141007g7830d31fu@domain.hid>
Date: Tue, 14 Feb 2006 19:07:16 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <43F21867.8070002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8725_12617585.1139940436600"
References: <fd6a47a90602140744lc1d4365q@domain.hid>
	<43F21867.8070002@domain.hid>
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

------=_Part_8725_12617585.1139940436600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

One moment. I'm trying to locate rthal_disable_irq()...


> Does calling rthal_disable_irq() instead of returning RTDM_IRQ_ENABLE, bu=
t
> rather
> 0, prevents the freeze?
>

------=_Part_8725_12617585.1139940436600
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><div>One moment. I'm trying to locate rthal_disable_irq()...<br>
&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Does =
calling rthal_disable_irq() instead of returning RTDM_IRQ_ENABLE, but rathe=
r<br>
0, prevents the freeze?<br></blockquote></div><br>

------=_Part_8725_12617585.1139940436600--

