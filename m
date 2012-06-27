MIME-Version: 1.0
In-Reply-To: <4FEB242B.5080306@xenomai.org>
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
	<4FCDFB35.1050705@xenomai.org>
	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
	<4FCE28F8.9040001@xenomai.org>
	<CAHue_TW1ntMpOxwACiawgtm67nYq_e7i11CDxz=CfpGGwRes_A@mail.gmail.com>
	<4FD8F4B5.7000001@xenomai.org>
	<CAHue_TXMiLTxiK2ZORVccov2wqd+ML-H0zwhLoDYh+7+8_56xw@mail.gmail.com>
	<4FE46F5F.1060500@xenomai.org>
	<CAHue_TX3UmeMbu9mU_YSKdHeN8oUYFhaeA=mUGgpvJzjnaEdxw@mail.gmail.com>
	<4FEB242B.5080306@xenomai.org>
Date: Wed, 27 Jun 2012 17:45:29 +0200
Message-ID: <CAHue_TXXqYsod32WGRzgC9wsnuKkVWX=4vyA9oEi9c_rP276qQ@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Ahh ok my mistake. I applied the adeos-3.0.13-arm-1.18-09.patch to kernel
by myself that is why i uncheck xenomai kernel extension (but not "Package
Selection for the target->Real-Time"! That one have to remain checked!) in
buildroot setup. Anyway it works and xeno-test works fine also ;)
For now I don't want to change anything as long as everything is ok since I
have to carry on with the project but later on, I will find out the exact
way how did I manage to do this (compile xenomai on versatile express
machine).


2012/6/27 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 06/27/2012 04:20 PM, Marcin Ku=B6ka wrote:
> > Ok thank you for helping me out! You've been very helpfull.
> >
> > Just for anyone trying to do the same in future:
> >
> > I used two of git projects from http://git.xenomai.org/ipipe-gch.git/
> >
> >    - ipipe-gch.git (linux kernel)
> >    - xenomai-2.6.git (the file HAVE TO be named xenomai-2.6 as buildroo=
t
> >    will be looking for that folder and if he denies to find it in
> >    'output/build' it will start downloading the common xenomai from
> xenomai
> >    site and we don't want that)
> >
> >
> > In buildroot:
> >
> >    - Kernel->Kernel version (Custom tarball) and specify the URL of a
> >    tarball (ipipe-gch linux kernel)
> >    - Linux Kernel Extensions -> UNCHECK Adeos/Xenomai Real-time patch
> >
> > then build the kernel and that's all.
> >
> > For me it worked.
> >
> > Many thanks to Gilles!
>
> So, you can run the latency test with this kernel for instance? Looks to
> me like you are building a kernel without xenomai support...
>
> --
>                                            Gilles.
>



--=20
Marcin Ku=B6ka
