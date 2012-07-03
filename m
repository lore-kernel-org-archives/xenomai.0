MIME-Version: 1.0
In-Reply-To: <4FEB324B.7020800@xenomai.org>
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
	<CAHue_TXXqYsod32WGRzgC9wsnuKkVWX=4vyA9oEi9c_rP276qQ@mail.gmail.com>
	<4FEB324B.7020800@xenomai.org>
Date: Tue, 3 Jul 2012 18:49:36 +0200
Message-ID: <CAHue_TUVeQaxd4hUbT4ok6xprD9WHnj5qw9hcp-W6WK2ZcSwxQ@mail.gmail.com>
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

All I did was applying standard adeos-3.0.13-arm-1.18-09.patch to kernel
ipipe core-3.2 from your repository and used xenomai upgraded to head
branch as you suggested. All done in buildroot-2012.05 using buildroot's
toolchain. Unfortunately I did not manage to compile it under buildroot
environment with an external toolchain such as crosstool-ng or
CodeSourcery. The reason why I'm trying to compile the linuxXenomaiOnBoard
kernel with an external toolchain is that any application (even hello
world) cross-compiled with e.g. crosstool-ng cannot be run on linux with
Xenomai on board cross-compiled with a buildroot toolchain (the working
one).

So again I tried cross-compile linux with xenomai with a crosstool-ng and
at first hand xenomai works fine cause i received this in dmesg:
*
*
*I-pipe: head domain Xenomai registered.*
*Xenomai: hal/arm started.*
*Xenomai: scheduling class idle registered.*
*Xenomai: scheduling class rt registered.*
*Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.*
*Xenomai: debug mode enabled.*
*Xenomai: starting native API services.*
*Xenomai: starting POSIX services.*
*Xenomai: starting RTDM services.*

but, latency test doesn't work. Not even xeno-test. Is there in the linux
kernel config any option which enables those?


Thanks and regards
Marcin Ku=B6ka

2012/6/27 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 06/27/2012 05:45 PM, Marcin Ku=B6ka wrote:
> > Ahh ok my mistake. I applied the adeos-3.0.13-arm-1.18-09.patch to kern=
el
> > by myself that is why i uncheck xenomai kernel extension (but not
> "Package
> > Selection for the target->Real-Time"! That one have to remain checked!)
> in
> > buildroot setup. Anyway it works and xeno-test works fine also ;)
> > For now I don't want to change anything as long as everything is ok
> since I
> > have to carry on with the project but later on, I will find out the exa=
ct
> > way how did I manage to do this (compile xenomai on versatile express
> > machine).
>
> It would be interesting if you could post the patch for vexpress, so
> that we can include it in future ipipe patches.
>
> --
>                                             Gilles.
>



--=20
Marcin Ku=B6ka
