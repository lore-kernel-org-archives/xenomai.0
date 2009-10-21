From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Wed, 21 Oct 2009 10:48:51 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB172FEEF2DCE0@domain.hid>
References: <1254853590.3718.28.camel@domain.hid>
	,<1254859856.2784.251.camel@domain.hid>
	<245373446233674495BCA5CA2FC1EB172FEEF2DCD7@domain.hid>,
	<1256135559.2862.418.camel@domain.hid>
In-Reply-To: <1256135559.2862.418.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

> >
> > > > > > > - powerpc32 updates for 2.6.30. Mainly to merge the once expe=
rimental
> > > > > > > bits that prevent most alignment faults from triggering a sec=
ondary mode
> > > > > > > switch. Andreas told me this works like a charm on 83xx, and =
I did not
> > > > > > > see any issue on 52xx, 85xx or 86xx either.
> > > > > > >
> > > > > >
> > > > > > Can I get a version of that patch for testing? Is it in your gi=
t
> > > > > > repository?
> > > > >
> > > > > I just pushed this commit to my remote tree (ipipe-2.6.30-powerpc
> > > > > branch); it should appear in a few hours once mirrored (cron job)=
.
> > > > >
> > > >
> > > > I finally had a chance to test the ipipe-2.6.30-powerpc version
> > > > from the git repository. Unfortunately, I noticed that our applicat=
ion
> > > > dies after some time and that this behaviour is related to that
> > > > alignment patch (if I take it out everything runs fine for > 2 days=
).
> > > >
> > > > Currently I'm investigating the reasons for that crash. It has
> > > > something to do with floating point registers not being restored
> > > > properly. Our alignment exceptions are mainly triggered by accesses
> > > > to unaligned floating point data.
> > >
> > > Does it work any better with this patch in?
> >
> > I applied that patch but unfortunately our application still dies. I in=
cluded
> > an application with with you (hopefully) can reproduce the problem
> > which we are seeing. Our system is a MPC8360 with 2.6.30, ipipe 2.7,
> > xenomai 2.4.9.1.
> >
> > Here are the steps:
> >
> > 1) apply ipipe with alignment patch, recompile kernel
> > 2) comile test1.c (attached) with:
> >         gcc -Wall -O2 `xeno-config --xeno-cflags` \
> >                                 `xeno-config --xeno-ldflags` \
> >                                  -l native -l rtdk  -o test1 test1.c
> > 3) Start test1 in one shell
> > 4) Open a second shell and start 'switchbench'
> >
> > Just when 'switchbench' is running, I get the following
> > output from my test application:
> > ...
> > Missmatch: 0xfff8000082064000
> > Missmatch: 0xfff8000082064000
> > Missmatch: 0xfff8000082064000
> > Missmatch: 0xfff8000082064000
> > ...
>=20
> There is a serious issue going on with this patch, because this
> optimization depends on the ability of Xenomai to properly handle
> non-linux, non-RT FPU usage in kernel space, which is not guaranteed so
> far for powerpc (x86 is ok regarding this, though).
>=20
> So I'm just reverting this patch, in order to get back to a correct
> behavior asap. This will require more thoughts later, when 2.5.0 is out.
> Sorry for the delay.
>=20

No worries Philippe... that's just one of a number of pending issues :p

Thanks again for your help,
Andreas



