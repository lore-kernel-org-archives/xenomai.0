Message-ID: <b647ffbd0602181204u518296fev@domain.hid>
Date: Sat, 18 Feb 2006 22:04:15 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43F4E2D3.4010705@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6249_19932122.1140293055898"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<43F3C4EA.7050303@domain.hid> <b647ffbd0602160220we254aacx@domain.hid>
	<43F47705.90309@domain.hid> <b647ffbd0602160558i4112313an@domain.hid>
	<43F48832.7060804@domain.hid>
	<b647ffbd0602161128t70d1f08ax@domain.hid>
	<43F4E2D3.4010705@domain.hid>
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

------=_Part_6249_19932122.1140293055898
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

let's make yet another revision of the bits :

new XN_ISR_HANDLED  =3D=3D old XN_ISR_HANDLED + old XN_ISR_NO_ENABLE

ok.

new XN_ISR_NOENABLE =3D=3D ~ old XN_ISR_ENABLE

ok.

new XN_ISR_PROPAGATE =3D=3D XN_ISR_CHAINED

ok.

new XN_ISR_NOINT =3D=3D ?

does it suppose the interrupt line to be .end-ed (enabled) and irq not to b=
e
propagated? Should be so, I guess, if it's different from 5). Then nucleus
ignores implicit IRQ enable for 5) as well as for 3).

Do we really need that NOINT then, as it seems to be the same as ~HANDLED?

or NOINT =3D=3D 0 and then it's a scalar value, not a bit.

So one may consider HANDLED =3D=3D 1 and NOINT =3D=3D 0 as really scalar va=
lues

and

NOENABLE and PROPAGATE as additional bits (used only if needed).


--
Best regards,
Dmitry Adamushko

------=_Part_6249_19932122.1140293055898
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi Jan,<br>
<br>
let's make yet another revision of the bits :<br>
<br>
new XN_ISR_HANDLED&nbsp; =3D=3D old XN_ISR_HANDLED + old XN_ISR_NO_ENABLE<b=
r>
<br>
ok.<br>
<br>
new XN_ISR_NOENABLE =3D=3D ~ old XN_ISR_ENABLE<br>
<br>
ok.<br>
<br>
new XN_ISR_PROPAGATE =3D=3D XN_ISR_CHAINED<br>
<br>
ok.<br>
<br>
new XN_ISR_NOINT =3D=3D ?<br>
<br>
does it suppose the interrupt line to be .end-ed (enabled) and irq not
to be propagated? Should be so, I guess, if it's different from 5).
Then nucleus ignores implicit IRQ enable for 5) as well as for 3).<br>
<br>
Do we really need that NOINT then, as it seems to be the same as ~HANDLED?<=
br>
<br>
or NOINT =3D=3D 0 and then it's a scalar value, not a bit.<br>
<br>
So one may consider HANDLED =3D=3D 1 and NOINT =3D=3D 0 as really scalar va=
lues <br>
<br>
and <br>
<br>
NOENABLE and PROPAGATE as additional bits (used only if needed).<br>
<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_6249_19932122.1140293055898--

