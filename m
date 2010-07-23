MIME-Version: 1.0
In-Reply-To: <4C4960F4.3020306@domain.hid>
References: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
	<4C4960F4.3020306@domain.hid>
Date: Fri, 23 Jul 2010 13:59:58 +0300
Message-ID: <AANLkTikuw=JJHLsfhevBF8=RA+bXOTd8vnsY7hLD=AEV@mail.gmail.com>
From: =?ISO-8859-9?Q?G=F6rkem_Karado=F0an?= <gkaradagan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e640d34093c062048c0bef4f
Subject: Re: [Xenomai-help] staging_dir install errors
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

--0016e640d34093c062048c0bef4f
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

$ cd /opt/linux-2.6.33
$ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu
--host=3Darm-none-linux-gnueabi --enable-arm-mach=3Domap3 --enable-arm-tsc
$ mkdir staging_dir
$ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install

ok i edited my installing document and it works thank you. now how can i
test that? is it work or not?

2010/7/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> G=F6rkem Karado=F0an wrote:
> > $ /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \
> >
> > --adeos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-a=
rm-*
> \
> >   --linux=3D/opt/linux-2.6.33/
> > $ cd /opt/linux-2.6.33/
> > $ mkdir build_root
> > $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> > O=3D/opt/linux-2.6.33/build_root omap3_evm_defconfig
> > $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> > O=3D/opt/linux-2.6.33/build_root bzImage modules
> >
> > $ cd /opt/linux-2.6.33/build_root
> > $ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu
> > --host=3Darm-linux --enable-arm-mach=3Domap3 --enable-arm-tsc
> > $ mkdir staging_dir
> > $ cd ..
> > $ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install ///// I got this
> > error in this part.
>
>
> > libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtd=
k
> > -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> > -march=3Darmv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
> > -I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF
> > .deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c  -fPIC
> > -DPIC -o .libs/librtdk_la-init.o
> > /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> > -march=3D switch
> > /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> > -mtune=3D switch
>
> Sorry, wrong answer. You have not told configure the proper compilation
> prefix, so, it failed finding "arm-linux-gcc", and fall back to gcc.
> Unfortunately, gcc is not able to generate arm code, only
> arm-none-linux-gnueabi-gcc is.
>
> pass --host=3Darm-none-linux-gnueabi to configure, or pass a value for CC
> on configure command line.
>
> --
>                                             Gilles.
>
>

--0016e640d34093c062048c0bef4f
Content-Type: text/html; charset=ISO-8859-9
Content-Transfer-Encoding: quoted-printable

$ cd /opt/linux-2.6.33<br>$ /opt/xenomai-2.5.3/configure --build=3Di686-pc-=
linux-gnu --host=3Darm-none-linux-gnueabi --enable-arm-mach=3Domap3 --enabl=
e-arm-tsc<br>$ mkdir staging_dir<br>$ make DESTDIR=3D/opt/linux-2.6.33/stag=
ing_dir install<br>
=A0<br>ok i edited my installing document and it works thank you. now how c=
an i test that? is it work or not?<br><br><div class=3D"gmail_quote">2010/7=
/23 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.cha=
nteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>G=F6rkem Karado=F0an wrote:<br>
&gt; $ /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \<br>
&gt;<br>
&gt; --adeos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.33-=
arm-* \<br>
&gt; =A0 --linux=3D/opt/linux-2.6.33/<br>
&gt; $ cd /opt/linux-2.6.33/<br>
&gt; $ mkdir build_root<br>
&gt; $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-<br>
&gt; O=3D/opt/linux-2.6.33/build_root omap3_evm_defconfig<br>
&gt; $ make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-<br>
&gt; O=3D/opt/linux-2.6.33/build_root bzImage modules<br>
&gt;<br>
&gt; $ cd /opt/linux-2.6.33/build_root<br>
&gt; $ /opt/xenomai-2.5.3/configure --build=3Di686-pc-linux-gnu<br>
&gt; --host=3Darm-linux --enable-arm-mach=3Domap3 --enable-arm-tsc<br>
&gt; $ mkdir staging_dir<br>
&gt; $ cd ..<br>
&gt; $ make DESTDIR=3D/opt/linux-2.6.33/staging_dir install ///// I got thi=
s<br>
&gt; error in this part.<br>
<br>
<br>
</div><div class=3D"im">&gt; libtool: compile: =A0gcc -DHAVE_CONFIG_H -I. -=
I/opt/xenomai-2.5.3/src/rtdk<br>
&gt; -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe<br>
&gt; -march=3Darmv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes<br>
&gt; -I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF<br>
&gt; .deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c =A0-fP=
IC<br>
&gt; -DPIC -o .libs/librtdk_la-init.o<br>
&gt; /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for<b=
r>
&gt; -march=3D switch<br>
&gt; /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for<b=
r>
&gt; -mtune=3D switch<br>
<br>
</div>Sorry, wrong answer. You have not told configure the proper compilati=
on<br>
prefix, so, it failed finding &quot;arm-linux-gcc&quot;, and fall back to g=
cc.<br>
Unfortunately, gcc is not able to generate arm code, only<br>
arm-none-linux-gnueabi-gcc is.<br>
<br>
pass --host=3Darm-none-linux-gnueabi to configure, or pass a value for CC<b=
r>
on configure command line.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br>

--0016e640d34093c062048c0bef4f--

