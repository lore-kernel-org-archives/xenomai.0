Message-ID: <702460.16116.qm@domain.hid>
Date: Fri, 16 Oct 2009 09:41:19 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not
	implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, eldk@domain.hid
Cc: xenomai@xenomai.org

Hi Again Gilles,
I've also sent this mail to the DENX mailing list , since the toolchain is =
suplied by DENX.
Our board was ported some two months ago by DENX software based on the MPC8=
272 (freescale) .
I'd like to add the support for shared memory , but as I said I'd like to k=
eep the system as untouched as possible - as I said It's been tested and is=
 running stable and with good performance .
Since I know that these things are delicate, I'd appreciate your guidance a=
s to which files I need replaced (by which files) , and which configuration=
s need be changed .
Best Regards,
Yigal Goldberger .



--- On Fri, 10/16/09, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
g> wrote:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not impl=
emented
> To: "Yigal Goldberger" <yigal_gold@domain.hid>
> Cc: xenomai@xenomai.org
> Date: Friday, October 16, 2009, 4:18 PM
> Yigal Goldberger wrote:
> > Gilles,
> > Thanks for the answer.
> >=20
> > I need shared memory only between user space
> applications , so I do prefer the second option. (our system
> is stable and we're satisfied from the performance , so we'd
> like to make as little changes as possible at this mature
> stage of the project ).
> > Can you advise me how to get the right version of the
> glibc (is it a stand alone change , simply replacing the
> glibc file , or do I need to make other changes ?)
> >=20
> > Thanks again to the Xenomai operation , and to you
> personaly for your support !
> > Yigal Goldberger .
>=20
> Any reasonably recent version of the glibc should do, but:
> - you may be using the glibc from your toolchain, so
> changing glibc may
> mean changing toolchain;
> - well, the glibc is a bit the heart of the user-space
> support. It has
> more than one files. And changing them may change a lot of
> things.
>=20
> So, I think, the simpler thing for you is to use xenomai
> shared memories.
>=20
>=20
> --=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 Gilles
>=20
>=0A=0A=0A      

