Message-ID: <fd6a47a90602010032u3776fd8n@domain.hid>
Date: Wed, 1 Feb 2006 09:32:39 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
In-Reply-To: <43DFC50B.1090707@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1633_26381702.1138782759825"
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
	<43DFB5F9.50406@domain.hid> <b647ffbd0601311150t6092a758w@domain.hid>
	<43DFC50B.1090707@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_1633_26381702.1138782759825
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> > I mean that the support of shared interrupts for ISA boards
> (edge-triggered
> > stuff) is a kind of emulation to overcome the shortcommings of the
> initial
> > design on the hardware level. The hardware was just not supposed to
> support
> > shared interrupt channels. So, let's keep it a bit aside from another
> code
> > :o)
>
> Unfortunately, this crappy hardware is still quite common in the
> embedded domain.


If I've understood correctly, the only reason for having this support is to
avoid - after discovering an interrupting UART - that the IRQ line remains
high upon exit, which would cause the 8259 not to issue the CPU IRQ for tha=
t
line anymore ?

The proposed solution is therefore to traverse the entire list of
UARTs connected to that IRQ line and make sure none of them was interruptin=
g
in two consecutive passes (by checking their status registers). That would
mean the IRQ line must be deasserted and the 8259 will properly detect any
newly arriving interrupts, since the 8259 has been acknowledged before
handling the interrupt.

1. Wouldn't it be more efficient to make this a compile-time option, instea=
d
of burdening the nucleus with it ?
2. Would it be an option, in the embedded boards Jan is speaking of, to put
the 8259 in level sensitive mode ? Some of the boards I know don't actually
have this selection logic for the built-in interrupt sources such as the
timer and the IDE I/F and it therefore only applies to the ISA bus.
3. Beware of UARTs that cause interrupts and have a problem that causes the=
m
to spuriously return 'all green' upon reading of the IIR register. I have
dealt with an integrated ('Super I/O') card with that problem before. The
only solution was to look at LSR and check THRE as well, even when no TX
interrupt was seemingly present. Must be a logic race.

Jeroen.

------=_Part_1633_26381702.1138782759825
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; I mean that the support of =
shared interrupts for ISA boards (edge-triggered<br>&gt; stuff) is a kind o=
f emulation to overcome the shortcommings of the initial
<br>&gt; design on the hardware level. The hardware was just not supposed t=
o support<br>&gt; shared interrupt channels. So, let's keep it a bit aside =
from another code<br>&gt; :o)<br><br>Unfortunately, this crappy hardware is=
 still quite common in the
<br>embedded domain.</blockquote>
<div>&nbsp;</div>
<div>If I've understood correctly, the only reason for having this support =
is to avoid - after discovering an interrupting UART - that the IRQ line re=
mains high upon exit, which would cause the 8259 not to issue the CPU IRQ f=
or that line anymore ?
</div>
<div>&nbsp;</div>
<div>The proposed solution is therefore to traverse the entire list of UART=
s&nbsp;connected to&nbsp;that IRQ line and make sure none of them was inter=
rupting in two consecutive passes (by checking their status registers). Tha=
t would mean the IRQ line must be deasserted and the 8259 will properly det=
ect any newly arriving interrupts, since the 8259 has been acknowledged bef=
ore handling the interrupt.
</div>
<div>&nbsp;</div>
<div>1. Wouldn't it be more efficient to make this a compile-time option, i=
nstead of burdening the nucleus with it ?</div>
<div>2. Would it be an option, in the embedded boards Jan is speaking of, t=
o put the 8259 in level sensitive mode ? Some of the boards I know don't ac=
tually have this selection logic for the built-in interrupt sources such as=
 the timer and the IDE I/F and it therefore only applies to the ISA bus.
</div>
<div>3. Beware of&nbsp;UARTs that cause interrupts and have a problem that =
causes them to spuriously return 'all green' upon reading of the&nbsp;IIR r=
egister. I have dealt with an integrated ('Super I/O') card with that probl=
em before. The only solution was to look at LSR and check THRE as well, eve=
n when no TX interrupt was seemingly present. Must be a logic race.
</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></div>

------=_Part_1633_26381702.1138782759825--

