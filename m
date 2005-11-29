Message-ID: <438C577D.1010600@domain.hid>
Date: Tue, 29 Nov 2005 14:28:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_intr_enable() requierd after rt_intr_create
References: <438C5316.70204@domain.hid>
In-Reply-To: <438C5316.70204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I noticed that when an interrupt object is created using
> rt_intr_create(), it is created disabled, and a call to rt_intr_enable(=
)
> is necessary for the ISR to be called.
>=20
> Question is: is this the expected behaviour?.

Yes. You don't necessarily want to take interrupts immediately after the=20
object is created, for which you might have some additional housekeeping=20
chores to perform before that.

  If so, I think this should
> be mentioned somewhere in the rt_intr_create documentation. In fact,
> from reading the docs one could infer the opposite.
>=20

Ok, will add a note to rt_int_create().

> On a related issue, I noticed that the rt_intr_enable() documentation s=
ays:
>=20
> "Enables the hardware interrupt line associated with an interrupt
> object. Over Adeos-based systems which mask and acknowledge IRQs upon
> receipt, this operation is necessary to revalidate the interrupt channe=
l
> so that more interrupts from the same source can be notified."
>=20
> Is this correct?. I ask because the rt_intr_create() documentation tell=
s
> you to just return RT_INTR_ENABLE from the ISR if you want this. It's
> confusing.
>=20

Well, the text seems pretty clear to me here: rt_intr_enable() specifies=20
that the re-enabling _operation_ should be carried on after IRQ receipt,=20
but not necessarily using rt_intr_enable(). Returning RT_INTR_ENABLE=20
from the ISR is just the other way to do this.

>=20
> Nacho.
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

