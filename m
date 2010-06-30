MIME-Version: 1.0
In-Reply-To: <4C2B0043.1070108@domain.hid>
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
	<4C2B0043.1070108@domain.hid>
Date: Wed, 30 Jun 2010 18:58:15 -0300
Message-ID: <AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=00163630f75f65b1de048a467332
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--00163630f75f65b1de048a467332
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am actually trying to do the exact same thing.

On Wed, Jun 30, 2010 at 5:28 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Fredrik Asplund wrote:
> >> Xenomai 2.5.3 was tested on OMAP3 with the mainline kernel. If you
> >> absolutely want to use this vendor branch, you will have to fix the
> >>  patch rejects by hand.
> >
> > Ok, yes, I thought so. I guess I was hoping someone had done the same
> > thing and had some pointers on what to do in this specific case (i.e.
> > applying Xenomai using Bitbake on a vendor branch).
> >
> > I will try to apply the patch rejects (I want to deviate from the
> > original setup as little as possible, at least to begin with)
>
> If you do not want to deviate from Xenomai usual setup, use the mainline
> kernel. If I were you, I would have serious doubts on a vendor kernel
> which touches generic files such as include/asm/cacheflush.h in order to
> add some board-specific code.
>
>
My first choice was to run a vanilla kernel, but no luck - didn't find any
suitable config files, or any reports of success. I am on the same system -
Gumstix Overo, kernel 2.6.33, Xenomai 2.5.3.

Anyway, I've managed to change the files manually - the changes seem very
minor (the changes in include/asm/cacheflush.h just move a function
elsewhere, no code changes at all).

However, I am having problems with the kernel - any user-space Xenomai
program gives me the following error:
Xenomai or CONFIG_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Kernel-space programs give me the following error:
open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
directory
modprobe klat_mod or try the -P latency

I've tried the obvious solutions (tweaking kernel configs, enabling debug,
etc...) but no clues on how to fix the error.

All the logs seem normal to me (I-pipe reports normal starup, Xenomai
reports successful start). I am starting to think that one of my changes to
the kernel might be making the system to fail silently.

So, any clues? I can send my changes and logs tomorrow morning, if they are
of any help.

Another option which I am considering is trying Xenomai with the 2.6.31
kernel, or maybe even 2.6.30 or 2.6.28.

Thanks in advance,
     -Felipe Brand=E3o Cavalcanti

, but
> > when I went through the source folder I couldn=B4t find any "*.rej"
> > files (even though the log suggests they were created). Do I need to
> > call the prepare-kernel.sh script differently somehow or is the
> > problem in my tool environment?
>
> The log is the result of running patch in "dry-run" mode, so that if it
> fails, prepare-kernel.sh does not break your sources. Apply the adeos
> patch by hand with the patch command. Once the sources are fixed,
> prepare-kernel.sh will be able to detect that your kernel is already
> patched and will skip that step.
>
> >
> > / Fredrik
>
>
> --
>                                             Gilles.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Automation and Robotics Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00163630f75f65b1de048a467332
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am actually trying to do the exact same thing.<br><br><div class=3D"gmail=
_quote">On Wed, Jun 30, 2010 at 5:28 AM, Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Fredrik Asplund wrote:<br>
&gt;&gt; Xenomai 2.5.3 was tested on OMAP3 with the mainline kernel. If you=
<br>
&gt;&gt; absolutely want to use this vendor branch, you will have to fix th=
e<br>
&gt;&gt; =A0patch rejects by hand.<br>
&gt;<br>
&gt; Ok, yes, I thought so. I guess I was hoping someone had done the same<=
br>
&gt; thing and had some pointers on what to do in this specific case (i.e.<=
br>
&gt; applying Xenomai using Bitbake on a vendor branch).<br>
&gt;<br>
&gt; I will try to apply the patch rejects (I want to deviate from the<br>
&gt; original setup as little as possible, at least to begin with)<br>
<br>
</div>If you do not want to deviate from Xenomai usual setup, use the mainl=
ine<br>
kernel. If I were you, I would have serious doubts on a vendor kernel<br>
which touches generic files such as include/asm/cacheflush.h in order to<br=
>
add some board-specific code.<br>
<div class=3D"im"><br></div></blockquote><div><br>My first choice was to ru=
n a vanilla kernel, but no luck - didn&#39;t find any suitable config files=
, or any reports of success. I am on the same system - Gumstix Overo, kerne=
l 2.6.33, Xenomai 2.5.3.<br>

<br>
Anyway, I&#39;ve managed to change the files manually - the changes seem
very minor (the changes in include/asm/cacheflush.h just move a
function elsewhere, no code changes at all).<br>
<br>
However, I am having problems with the kernel - any user-space Xenomai prog=
ram gives me the following error:<br>Xenomai or CONFIG_OPT_PERVASIVE disabl=
ed.<br>(modprobe xeno_nucleus?)<br><br>Kernel-space programs give me the fo=
llowing error:<br>
open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or direct=
ory<br>modprobe klat_mod or try the -P latency<br>=A0<br>I&#39;ve tried the=
 obvious solutions (tweaking kernel configs, enabling debug, etc...) but no=
 clues on how to fix the error.<br>
<br>All the logs seem normal to me (I-pipe reports normal starup, Xenomai r=
eports successful start). I am starting to think that one of my changes to =
the kernel might be making the system to fail silently.<br><br>So, any clue=
s? I can send my changes and logs tomorrow morning, if they are of any help=
.<br>
<br>Another option which I am considering is trying Xenomai with the 2.6.31=
 kernel, or maybe even 2.6.30 or 2.6.28.<br><br>Thanks in advance,<br>=A0=
=A0=A0=A0 -Felipe Brand=E3o Cavalcanti<br><br></div><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">
, but<br>
&gt; when I went through the source folder I couldn=B4t find any &quot;*.re=
j&quot;<br>
&gt; files (even though the log suggests they were created). Do I need to<b=
r>
&gt; call the prepare-kernel.sh script differently somehow or is the<br>
&gt; problem in my tool environment?<br>
<br>
</div>The log is the result of running patch in &quot;dry-run&quot; mode, s=
o that if it<br>
fails, prepare-kernel.sh does not break your sources. Apply the adeos<br>
patch by hand with the patch command. Once the sources are fixed,<br>
prepare-kernel.sh will be able to detect that your kernel is already<br>
patched and will skip that step.<br>
<br>
&gt;<br>
&gt; / Fredrik<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font><div><div></div><div class=3D"h5"><br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Automation and Robo=
tics Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--00163630f75f65b1de048a467332--

