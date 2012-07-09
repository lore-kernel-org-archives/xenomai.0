MIME-Version: 1.0
In-Reply-To: <4FF708E3.9020407@xenomai.org>
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>
	<4FCF2751.5070700@xenomai.org> <4FCF4D05.3070502@xenomai.org>
	<4FCF58AF.5040106@xenomai.org> <4FCF5A4C.60704@xenomai.org>
	<4FCF5DED.8060007@xenomai.org> <4FCF60CD.8000709@xenomai.org>
	<4FCF6152.7010002@xenomai.org> <4FCF62DD.10102@xenomai.org>
	<4FCF68CA.8010206@xenomai.org> <4FCF713F.1030603@xenomai.org>
	<4FCF7418.4020805@xenomai.org> <4FCF7576.8030201@xenomai.org>
	<4FCF9A1E.6090706@xenomai.org> <4FCF9AAD.7020707@xenomai.org>
	<4FD1C3EE.1000005@xenomai.org> <4FD1C50D.5010906@xenomai.org>
	<4FD1C60D.401@xenomai.org> <4FD1C67E.5010600@xenomai.org>
	<4FD1C751.5070501@xenomai.org>
	<CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>
	<CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>
	<4FF3232E.3050605@xenomai.org>
	<CAHue_TVfw+HxX4uPOQU_j766ApjBHAOPPOzxOaXvX_p5NvR=Gw@mail.gmail.com>
	<4FF708E3.9020407@xenomai.org>
Date: Mon, 9 Jul 2012 17:34:23 +0200
Message-ID: <CAHue_TUx_JT6MgFPH6Eg_rb2K2nRwxH-Mnvd6gOTU+ZGdPj5Mg@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
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

Obviously I misunderstood the way it installs itself. Anyway after the
proper installation (no xeno-flags for busybox and dest_dir as
$myfilesystem_root/) neither latency or xeno-test was working.

*/usr/xenomai/bin/xeno-test-run: error while loading shared libraries:
libpthread.so.0: cannot open shared object file: No such file or directory
/usr/xenomai/bin # ./latency
./latency: error while loading shared libraries: libpthread.so.0: cannot
open shared object file: No such file or directory
/usr/xenomai/bin #


*
So I run cmd:

*arm-unknown-linux-gnueabi-readelf -d latency*

and copied all the NEEDED libraries into /lib path of my rootfs. And again
i got this:

*/usr/xenomai/bin # ./latency
Xenomai init: open(/dev/mem): No such file or directory
*

Xenomai generated lots of devices (rtheap, rtp0 - rtp31) but no mem device.
Is it supposed to generate itself or should I use mdev in script or smth?

Sorry to be so problemative but I'm quite determined to run this system
which I believe is nearly ready.

regards,
Marcin Ku=B6ka

2012/7/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 07/06/2012 05:42 PM, Marcin Ku=B6ka wrote:
> >>
> >> You are compiling with -march=3Darmv7-a and linking with
> >> -march=3Darmv4t, are you sure this is supposed to work?
> >>
> >> I guess compiling for armv7 and linking for armv4 is not supported...
> >> Anyway, to understand what happens, you can do what is written,
> >> look at config.log.
> >>
> >>
> > Yes that was the problem. Many thanks!
> >
> > Now i face another problem. I put the CFLAGS and LDFLAGS in busybox to
> > xeno-config --skin=3Dnative --cflags and xeno-config --skin=3Dnative --=
cflags
>
> You do not need to compile busybox with xenomai native skin. You only
> need to compile xenomai applications with xenomai native skin flags. In
> fact, as long as you do not make your own xenomai application, you do
> not need to compile anything with xenomai flags. You should just install
> xenomai on an otherwise normal root filesystem and try running xenomai
> testsuite programs, such as "latency".
>
> > and imported NEEDED libraries to my/rootfilesystem/path/lib and got
> xenomai
> > error:
> >
> > *Xenomai: /dev/rtheap is missing
> > *
> > *(chardev, major=3D10 minor=3D254)
> >
> > *
> > I was surprised that i have to copy those devices by myself but I did i=
t.
>
> You are suppposed to run make DESTDIR=3D/my/rootfilesystem/path install,
> and everything will be installed.
>
> > Now the problem sounds following:
> >
> > *Xenomai init: open(/dev/mem): No such file or directory
> > Kernel panic - not syncing: Attempted to kill init!*
>
> That is because you have compiled busybox with xenomai flag, which is
> completely useless. And if your filesystem does not have /dev/mem, it is
> seriously screwed.
>
> Seriously, is README.INSTALL so hard to understand?
>
> --
>                                             Gilles.
>



--=20
Marcin Ku=B6ka
