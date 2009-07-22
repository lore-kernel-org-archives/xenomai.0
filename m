Message-ID: <450733.63606.qm@domain.hid>
Date: Wed, 22 Jul 2009 02:28:42 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@domain.hid>
In-Reply-To: <1248253650.3992.374.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai exceptions tracing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Hi Philippe,
Thanks for replying .
Indeed it's a powerpc . it is a mpc8272 freescale powerpc family cpu.
I printed the kmsg log and that's what I printed in this email below ,
from the kmsg log I see that the next message after this exception is
from where the application is being shut down .
Could this be a response to this exception , or is it just by chance printe=
d straight after ?
Thanks,
Yigal.=20

--- On Wed, 7/22/09, Philippe Gerum <rpm@xenomai.org> wrote:

> From: Philippe Gerum <rpm@xenomai.org>
> Subject: Re: [Xenomai-help] xenomai exceptions tracing
> To: "Yigal Goldberger" <yigal_gold@domain.hid>
> Cc: xenomai@xenomai.org
> Date: Wednesday, July 22, 2009, 12:07 PM
> On Wed, 2009-07-22 at 01:28 -0700,
> Yigal Goldberger wrote:
> > Hi all,
> > I'm using kernel 2.6.29.4 with xenomai .
> > I'm getting an exception 769 . I'd like to know what
> this exception means (or hints where to look for it ).
> >=20
>=20
> It looks like you are running a ppc system. Those are minor
> MMU faults,
> due to PTE misses that happen on some platforms (83xx and
> 85xx come to
> mind). Those get reported because you turned the nucleus
> debug switch
> on. Nothing bad in your case.
>=20
> > 6>MTD_open
> > <6>MTD_ioctl
> > <6>MTD_open
> > <6>MTD_ioctl
> > <6>Xenomai: Switching 802Rdr to secondary mode
> after exception #769 from user-sp
> > ace at 0x10017cec (pid 974)
> > <6>Xenomai: Posix: closing message queue
> descriptor 3.
> > <6>Xenomai: Posix: closing message queue
> descriptor 4.
> > <6>Xenomai: Posix: closing message queue
> descriptor 5.
> > <6>Xenomai: Posix: closing message queue
> descriptor 7.
> > <6>Xenomai: Posix: closing message queue
> descriptor 8.
> > <6>Xenomai: Posix: closing message queue
> descriptor 9.
> > <6>Xenomai: Posix: closing message queue
> descriptor 10.
> > <6>Xenomai: Posix: closing message queue
> descriptor 11.
> > <6>Xenomai: Posix: closing message queue
> descriptor 12.
> > <6>Xenomai: Posix: closing message queue
> descriptor 14.
> > <6>Xenomai: Posix: closing message queue
> descriptor 15.
> >=20
> > Thanks,
> > Yigal Goldberger.
> >=20
> >=20
> >=A0 =A0 =A0=A0=A0
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --=20
> Philippe.
>=20
>=20
> =0A=0A=0A      

