Date: Thu, 5 Mar 2020 12:07:21 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <857866991.69963.1583406441558.JavaMail.zimbra@nod.at>
In-Reply-To: <77fa7cc8d0a54c03b41a8fcadd786a8f@RCDC-MAIL09.corp.diehl.com>
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <d36eca04d68b4434bde75d9cfa8c1418@RCDC-MAIL09.corp.diehl.com>
 <f7fc8190-afe3-872e-d7aa-dcabcd576a77@siemens.com>
 <ee2bea74fc5b40af8fbc9cff17c9bd78@RCDC-MAIL09.corp.diehl.com>
 <CAFLxGvyxyfU0_F+mqymZg1d+X_Rzw9=LoZQAXuF5J8skR8n2Xg@mail.gmail.com>
 <6b399d7610174bb585e2fb439d735402@RCDC-MAIL09.corp.diehl.com>
 <8f7a0986-8549-fd2c-f49b-65595f9a1d16@siemens.com>
 <77fa7cc8d0a54c03b41a8fcadd786a8f@RCDC-MAIL09.corp.diehl.com>
Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Carsten EHRMANN" <Carsten.Ehrmann@diehl.com>
> An: "Jan Kiszka" <jan.kiszka@siemens.com>, "Richard Weinberger" <richard.=
weinberger@gmail.com>
> CC: "xenomai" <xenomai@xenomai.org>
> Gesendet: Donnerstag, 5. M=C3=A4rz 2020 11:17:26
> Betreff: RE: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenoma=
i 3.x

> Hi Jan,
>=20
> sry, my fault.
>=20
> I enabled RTIPC as well as XDDP
>=20
>=20
> ______________________________________
> # Real-time IPC drivers
> #
> CONFIG_XENO_DRIVERS_RTIPC=3Dm
> CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy
> CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy
> CONFIG_XENO_OPT_IDDP_NRPORT=3D32
> CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy
> CONFIG_XENO_OPT_BUFP_NRPORT=3D32
> ______________________________________
>=20
> Then build the kernel again.
>=20
> Then I checked weather xeno_rtipc.ko was loaded, it wasn't. I tried it wi=
th
> insmod and modprobe but both got error: Unknown symbol in module
>=20
> The Dmesg:
> [  230.190867] xeno_rtipc: Unknown symbol xnmap_delete (err 0)
> [  230.190900] xeno_rtipc: Unknown symbol xnpipe_connect (err 0)
> [  230.191011] xeno_rtipc: Unknown symbol xnpipe_states (err 0)
> [  230.191043] xeno_rtipc: Unknown symbol xnmap_enter (err 0)
> [  230.191068] xeno_rtipc: Unknown symbol xnpipe_mfixup (err 0)
> [  230.191122] xeno_rtipc: Unknown symbol xnpipe_disconnect (err 0)
> [  230.191180] xeno_rtipc: Unknown symbol xnmap_create (err 0)
> [  230.191231] xeno_rtipc: Unknown symbol xnmap_remove (err 0)
> [  230.191310] xeno_rtipc: Unknown symbol xnpipe_send (err 0)
> [  230.191341] xeno_rtipc: Unknown symbol xnpipe_recv (err 0)
>=20
>=20
>=20
> Do I need some other xenomai settings enabled or  libraries?

Looks more like kernel and module do not match.
A common problem is that one enables drivers and just copies the new module=
s
but enabling drivers changes also core kernel stuff and therefore you need
also to install the recently build kernel.

Thanks,
//richard

