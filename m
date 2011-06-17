MIME-Version: 1.0
In-Reply-To: <4DF9DCE3.70703@domain.hid>
References: <4DF9CA75.1040903@domain.hid>
	<4DF9DCE3.70703@domain.hid>
Date: Fri, 17 Jun 2011 15:05:30 +0100
Message-ID: <BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>
From: Jakub Nowacki <j.s.nowacki@domain.hid>
Content-Type: multipart/alternative; boundary=0016363b85d2da1a6b04a5e8e0f2
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--0016363b85d2da1a6b04a5e8e0f2
Content-Type: text/plain; charset=ISO-8859-1

>
>
> I've added my ID to the table in smi.c file as:

{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN+0xa)}

Everything complies OK but during the startup I get message:

[    2.137733] Xenomai: SMI-enabled chipset found
[    2.137744] Xenomai: SMI workaround failed!

Should I do something extra apart from adding it to the table?

Best wishes,

Jakub

--0016363b85d2da1a6b04a5e8e0f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><font class=3D"A=
pple-style-span" color=3D"#888888"><br></font></blockquote></div>I&#39;ve a=
dded my ID to the table in smi.c file as:<div>
<br><div>{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5_3400_SERIES=
_LPC_MIN+0xa)}</div><div><br></div></div><div>Everything complies OK but du=
ring the startup I get message:</div><div><br></div><div><div>[ =A0 =A02.13=
7733] Xenomai: SMI-enabled chipset found</div>
<div>[ =A0 =A02.137744] Xenomai: SMI workaround failed!</div></div><div><br=
></div><div>Should I do something extra apart from adding it to the table?<=
/div><div><br></div><div>Best=A0wishes,</div><div><br></div><div>Jakub</div=
>

--0016363b85d2da1a6b04a5e8e0f2--

