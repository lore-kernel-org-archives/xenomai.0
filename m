Message-ID: <264350.28868.qm@domain.hid>
Date: Fri, 16 Oct 2009 05:27:00 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@domain.hid>
In-Reply-To: <4AD83649.7080109@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,
Thanks for the answer.

I need shared memory only between user space applications , so I do prefer =
the second option. (our system is stable and we're satisfied from the perfo=
rmance , so we'd like to make as little changes as possible at this mature =
stage of the project ).
Can you advise me how to get the right version of the glibc (is it a stand =
alone change , simply replacing the glibc file , or do I need to make other=
 changes ?)

Thanks again to the Xenomai operation , and to you personaly for your suppo=
rt !
Yigal Goldberger .


--- On Fri, 10/16/09, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
g> wrote:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not impl=
emented
> To: "Yigal Goldberger" <yigal_gold@domain.hid>
> Cc: xenomai@xenomai.org
> Date: Friday, October 16, 2009, 12:00 PM
> Yigal Goldberger wrote:
> > Hi again,
> >=20
> > I'm trying to create a shared memory area .
> > The system is a powerpc based board running linux
> kernel 2.6.29.4
> > and Xenomai 2.4.8 .
> > When I call shm_open from user space I get error 38 -
> function not implemented .
>=20
> Normally, xenomai's shm_open tries to use the xenomai posix
> skin service
> first, and if it fails (because the shared memory option
> was not enabled
> in the posix skin configuration), falls back to linux
> service.
>=20
> You get this error because:
> - Xenomai posix skin's shared memory services are not
> enabled;
> - your glibc does not support posix shared memory services
> (you can
> check this in xenomai's config.log, there is a test
> detecting it).
>=20
> Now, Xenomai posix skins's shared memory services are to be
> used if you
> want to share memory between a kernel-space real-time posix
> application,
> and a user-space real-time posix application.
>=20
> So, if this is what you want to do, enable the xenomai
> posix skin shared
> memory services in the kernel configuration (and please
> upgrade to
> xenomai 2.4.9.1, because some bugs in the shared memory
> support were
> fixed recently). If you want to share memory between two
> user-space
> applications, you can also use xenomai shared memory
> services, but you
> are probably better of upgrading your glibc to a glibc
> which support
> posix shared memories.
>=20
> --=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
> =A0 =A0 =A0 =A0 =A0 Gilles
>=20
> =0A=0A=0A      

