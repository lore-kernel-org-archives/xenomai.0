Message-ID: <b647ffbd0604240228sb8d58a3kc3b780a576c2d95a@domain.hid>
Date: Mon, 24 Apr 2006 12:28:18 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <444C89F4.3040302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
	<44416943.4070702@domain.hid>
	<b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>
	<444C89F4.3040302@domain.hid>
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
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
Cc: xenomai@xenomai.org

> > Another approach would be to introduce a service like
> > xnintr_synchronize() and enfource the upper interfaces (e.g. skins) to
> > make use of it in their _delete() methods.
>
> That would be useful too for solving the "concurrent ISR while deleting
> issue", but would not enforce single deletion in the SMP case, I guess.

I actually want to introduce this call anyway. The nucleus then
provides single xnintr_disabe (nosync) interface +
xnintr_synchronize() and a skin is free to introduce both sync and
nosync versions on its own. Otherwise, there will be the same problem
as with xnintr_detach() - i.e. xnintr_disable (sync) can't be called
from a locked section as it's actually done in rt_intr_delete() (of
course, if we do really need the atomicy in the later one).


> --
>
> Philippe.
>

--
Best regards,
Dmitry Adamushko

