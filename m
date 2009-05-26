Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
	<9c789a000905260819t55dd4beajf3f3b68b635bf16d@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 26 May 2009 16:29:13 +0200
In-Reply-To: <9c789a000905260819t55dd4beajf3f3b68b635bf16d@domain.hid>
	(Cristian Axenie's message of "Tue\,
	26 May 2009 18\:19\:07 +0300")
Message-ID: <87vdnox7ie.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Cristian Axenie <cristian.axenie@domain.hid> writes:

> On Tue, May 26, 2009 at 5:36 PM, Cristian Axenie <cristian.axenie@domain.hid=
om> wrote:
>
>     On Tue, May 26, 2009 at 4:55 PM, Alexis Berlemont <berlemont.hauw@domain.hid=
e.fr> wrote:
>=20=20=20=20
>         Hi,
>=20=20=20=20=20=20=20=20
>         On Tue, May 26, 2009 at 12:32 AM, Cristian Axenie
>         <cristian.axenie@domain.hid> wrote:
>         >
>         >
>         > ---------- Forwarded message ----------
>         > From: Cristian Axenie <cristian.axenie@domain.hid>
>         > Date: Tue, May 26, 2009 at 1:16 AM
>         > Subject: Re: [Xenomai-help] Driver testing procedure ?!
>         > To: Alexis Berlemont <berlemont.hauw@domain.hid>
>         >
>         >
>         >
>         >
>         > On Tue, May 26, 2009 at 1:10 AM, Alexis Berlemont <berlemont.ha=
uw@domain.hid>
>         > wrote:
>         >>
>         >> Cristian Axenie <cristian.axenie@domain.hid> writes:
>         >>
>         >> > Hi,
>         >> >
>         >> > I finally figured out this aspect but I still have one probl=
em, residing
>         >> > in the fact that I have no comedi devices in my dev list
>         >> > and so I cannot ./comedi_config /dev/comedi0 nipcimio !
>         >> >
>         >> > As I see it there are no comedi devices
>         >> >
>         >> > /usr/xenomai/sbin # cat /proc/devices
>         >>
>         >> You should not look at there. This proc file lists everything =
but RTDM
>         >> devices.
>         >>
>         >> >
>         >> > and the list
>         >> >
>         >> > /usr/xenomai/sbin # cat /proc/comedi/devices
>         >> > --=C2=A0 Comedi devices --
>         >> >
>         >> > | idx | status | driver
>         >> > |=C2=A0 00 | Unused | No driver
>         >> > |=C2=A0 01 | Unused | No driver
>         >> > |=C2=A0 02 | Unused | No driver
>         >> > |=C2=A0 03 | Unused | No driver
>         >> > |=C2=A0 04 | Unused | No driver
>         >> > |=C2=A0 05 | Unused | No driver
>         >> > |=C2=A0 06 | Unused | No driver
>         >> > |=C2=A0 07 | Unused | No driver
>         >> > |=C2=A0 08 | Unused | No driver
>         >> > |=C2=A0 09 | Unused | No driver
>         >> > /usr/xenomai/sbin # cat /proc/comedi/drivers
>         >> > comedi_config=C2=A0=C2=A0 rtcanconfig=C2=A0=C2=A0=C2=A0=C2=
=A0 rtps
>         >> > /usr/xenomai/sbin # cat /proc/comedi/drivers
>         >> > --=C2=A0 Comedi drivers --
>         >> >
>         >> > | idx | driver name
>         >> > |=C2=A0 00 | pcimio
>         >> > |=C2=A0 01 | comedi_8255
>         >> > |=C2=A0 02 | comedi_loop
>         >> > |=C2=A0 03 | comedi_fake
>         >> >
>         >> > Shouldn't the specific comedi devices be generated when inst=
alling
>         >> > Xenomai ?
>         >>
>         >> That is common comedi behaviour. So far, the comedi drivers ar=
e listed,
>         >> they are available in the kernel. However, you have to attach =
them so as
>         >> to make them reachable (thanks to comedi_config).
>         >>
>         >> Once the attach will be done, you will see your driver appear =
in
>         >> /proc/comedi/devices.
>         >>
>         >> If the comedi_config did not work, the problem is here. In suc=
h case,
>         >> could you send the traces?
>         >
>         > The problem is that the comedi devs are not present in /dev and=
 so when I
>         > run comedi config
>         >
>         > /usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio
>         > comedi_config: comedi_open failed ret=3D-19
>         >
>         > Shouldn't the comedi0, comedi1... devices be created when insta=
lling Xenomai
>         > ?
>=20=20=20=20=20=20=20=20
>         Here, we are talking about RTDM devices not common Linux /dev fil=
es.
>         Have a look at /proc/xenomai/rtdm/comediXX.
>
>     =C2=A0 Thanks for making it clear to me. I've tested with the comedi0=
 RTDM device and a (sad) SEGFAULT emerged
>     here the oops

That was expected considering the amount of code. We need to locate the
segfault origin inside the driver. According to your description, it
must be in the attach procedure (in the function pcimio_attach()).

It is even bound to be located in the function ni_E_init() which is
quite big.

A simple method would be to use dichotomy to find out the faulting line
thanks to traces (rtdm_printk()).
=20=20=20=20
Alexis.

