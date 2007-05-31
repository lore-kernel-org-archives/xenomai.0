Message-ID: <7289437c0705310605u18710c74w3f2a89114727169@domain.hid>
Date: Thu, 31 May 2007 15:05:44 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14626_30037620.1180616744882"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
	<465C6268.1090704@domain.hid>
	<18012.28254.882249.144005@domain.hid>
	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D664E.3040700@domain.hid> <465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_14626_30037620.1180616744882
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>Could you run ls in /usr/xenomai_arm-2.3.1uClibc/lib ? To see if Xenomai
>installed libpthread_rt.so or only libpthread_rt.a.

I haven't the libpthread_rt.so, only libpthread_rt.a.

>Also, I wonder what is this space in the libraries directory, did you
>put a space in xenomai installation directory prefix ?

There is no space in xenomai installation directory.

On 5/31/07, Perrine Martignoni <perrmart@domain.hid> wrote:
>
> >Perrine, did you happen to configure Xenomai with "configure --host=3Dar=
m
> >..."? If yes (see config.log), please use "--host=3Darm-linux". This
> >solved all issues for me.
> >
> >Awaiting your feedback!
>
> I configure Xenomai with --host=3Darm.
> I tried to configure like this but it doesn't work :
>
> ./configure --build=3Darm-linux --host=3Darm-linux CC=3Darm-linux-gcc
> CXX=3Darm-linux-g++ LD=3Darm-linux-ld --prefix=3D/usr/xenomai_arm-2.3.1uC=
libc/
> --enable-posix-auto-mlockall
> checking build system type... arm-unknown-linux-gnu
> checking host system type... arm-unknown-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for arm-linux-gcc... arm-linux-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... configure: error: cannot run C
> compiled programs.
> If you meant to cross compile, use `--host'.
> See `config.log' for more details.
> [root@domain.hid xenomai-2.3.1 ]#
>
>
> On 5/31/07, Daniel Schnell <daniel.schnell@domain.hid> wrote:
> >
> > I checked README.INSTALL for the ppc part and there the documentation i=
s
> > also wrong.
> >
> > I think I have to reinstall Xenomai now and take out the
> > Wl,--start-group in our make files ...
> >
> > Very interesting thread.
> >
> >
> > Best regards,
> >
> > Daniel.
> >
> > -----Original Message-----
> > From: xenomai-help-bounces@domain.hid [mailto: xenomai-help-bounces@domain.hid=
g]
> > On Behalf Of Jan Kiszka
> > Sent: 31. ma=ED 2007 09:05
> > To: Perrine Martignoni
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] Xenomai with =B5Clibc
> >
> > Jan Kiszka wrote:
> > > I noticed that linking like this
> > >
> > > arm-linux-gcc ...<flags> <object>.o -lpthread -lrt -lpthread_rt ...
> > >
> > > doesn't raise the error. But linking like this
> > >
> > > arm-linux-gcc `xeno-config --posix-ldflags` <object>.o -o <target>
> > >
> > > ie. the standard way for external Xenomai POSIX apps, causes even mor=
e
> > > problems with this toolchain (it's fine here for native builds).
> > > Anyone any comments? Maybe Wolfgang?
> >
> > Reason found, I think. No ELDK issue, rather a bug in Xenomai's
> > README.INSTALL:
> >
> > Perrine, did you happen to configure Xenomai with "configure --host=3Da=
rm
> > ..."? If yes (see config.log), please use "--host=3Darm-linux". This
> > solved all issues for me.
> >
> > Awaiting your feedback!
> >
> > Jan
> >
> >
>

------=_Part_14626_30037620.1180616744882
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>&gt;Could you run ls in /usr/xenomai_arm-2.3.1uClibc/lib ? To see if X=
enomai<br>&gt;installed libpthread_rt.so or only libpthread_rt.a.</div>
<div>&nbsp;</div>
<div>I haven&#39;t the libpthread_rt.so, only libpthread_rt.a.</div>
<div><br>&gt;Also, I wonder what is this space in the libraries directory, =
did you<br>&gt;put a space in xenomai installation directory prefix ?</div>
<div>&nbsp;</div>
<div>There is no space in xenomai installation directory.<br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/31/07, <b class=3D"gmail_sendername">=
Perrine Martignoni</b> &lt;<a href=3D"mailto:perrmart@domain.hid">perrmart@domain.hid=
mail.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span class=3D"q">
<div>&gt;Perrine, did you happen to configure Xenomai with &quot;configure =
--host=3Darm<br>&gt;...&quot;? If yes (see config.log), please use &quot;--=
host=3Darm-linux&quot;. This<br>&gt;solved all issues for me.<br>&gt;<br>&g=
t;Awaiting your feedback!=20
</div>
<div>&nbsp;</div></span>
<div>I configure Xenomai with --host=3Darm.</div>
<div>I tried to configure like this but it doesn&#39;t work : </div>
<div>&nbsp;</div>
<div><font face=3D"" size=3D"2">./configure --build=3Darm-linux --host=3Dar=
m-linux CC=3Darm-linux-gcc CXX=3Darm-linux-g++ LD=3Darm-linux-ld --prefix=
=3D/usr/xenomai_arm-2.3.1uClibc/ --enable-posix-auto-mlockall<br>checking b=
uild system type... arm-unknown-linux-gnu=20
<br>checking host system type... arm-unknown-linux-gnu<br>checking for a BS=
D-compatible install... /usr/bin/install -c<br>checking for arm-linux-gcc..=
. arm-linux-gcc<br>checking for C compiler default output file name...=20
a.out<br>checking whether the C compiler works... configure: error: cannot =
run C compiled programs.<br>If you meant to cross compile, use `--host&#39;=
.<br>See `config.log&#39; for more details.<br>[root@domain.hid xenomai-2.3.=
1
 ]#</font></div>
<div><span class=3D"e" id=3D"q_112e23744185a0d1_2">
<div><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/31/07, <b class=3D"gmail_sendername">=
Daniel Schnell</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,event=
,this)" href=3D"mailto:daniel.schnell@domain.hid" target=3D"_blank">daniel.s=
chnell@domain.hid
</a>&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I checked README.INSTALL for the=
 ppc part and there the documentation is also wrong.<br><br>I think I have =
to reinstall Xenomai now and take out the Wl,--start-group in our make file=
s ...=20
<br><br>Very interesting thread.<br><br><br>Best regards,<br><br>Daniel.<br=
><br>-----Original Message-----<br>From: <a onclick=3D"return top.js.OpenEx=
tLink(window,event,this)" href=3D"mailto:xenomai-help-bounces@domain.hid" targ=
et=3D"_blank">
xenomai-help-bounces@domain.hid</a> [mailto:<a onclick=3D"return top.js.OpenEx=
tLink(window,event,this)" href=3D"mailto:xenomai-help-bounces@domain.hid" targ=
et=3D"_blank"> xenomai-help-bounces@domain.hid</a>] On Behalf Of Jan Kiszka<br=
>Sent: 31. ma=ED 2007 09:05
<br>To: Perrine Martignoni<br>Cc: <a onclick=3D"return top.js.OpenExtLink(w=
indow,event,this)" href=3D"mailto:xenomai@xenomai.org" target=3D"_blank">x=
enomai-help@domain.hid</a><br>Subject: Re: [Xenomai-help] Xenomai with =B5Clib=
c <br>
<br>Jan Kiszka wrote:<br>&gt; I noticed that linking like this<br>&gt;<br>&=
gt; arm-linux-gcc ...&lt;flags&gt; &lt;object&gt;.o -lpthread -lrt -lpthrea=
d_rt ...<br>&gt;<br>&gt; doesn&#39;t raise the error. But linking like this=
=20
<br>&gt;<br>&gt; arm-linux-gcc `xeno-config --posix-ldflags` &lt;object&gt;=
.o -o &lt;target&gt;<br>&gt;<br>&gt; ie. the standard way for external Xeno=
mai POSIX apps, causes even more<br>&gt; problems with this toolchain (it&#=
39;s fine here for native builds).=20
<br>&gt; Anyone any comments? Maybe Wolfgang?<br><br>Reason found, I think.=
 No ELDK issue, rather a bug in Xenomai&#39;s<br>README.INSTALL:<br><br>Per=
rine, did you happen to configure Xenomai with &quot;configure --host=3Darm=
 ...&quot;? If yes (see=20
config.log), please use &quot;--host=3Darm-linux&quot;. This solved all iss=
ues for me.<br><br>Awaiting your feedback!<br><br>Jan<br><br></blockquote><=
/div><br></span></div></blockquote></div><br>

------=_Part_14626_30037620.1180616744882--

