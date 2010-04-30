MIME-Version: 1.0
In-Reply-To: <4BDAEE48.3060507@domain.hid>
References: <x2qa2d86cab1004300739z5dffe340o7df607e1dc2ec189@domain.hid>
	<4BDAECA0.8030006@domain.hid>
	<z2sa2d86cab1004300748n41fbef55t5fefc57827f2f089@domain.hid>
	<4BDAEE48.3060507@domain.hid>
Date: Fri, 30 Apr 2010 16:53:44 +0200
Message-ID: <r2wa2d86cab1004300753g460979f8q2964646a5c362df@domain.hid>
From: Leyrit Vincent <sec.leyrit@domain.hid>
Content-Type: multipart/alternative; boundary=001517475434ee33b50485756836
Subject: Re: [Xenomai-help] help with porting simple posix application
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

--001517475434ee33b50485756836
Content-Type: text/plain; charset=ISO-8859-1

sorry i have forgot to post all the code :
here printf is a define to the one provided by xenomai library :

#define xnarch_printf printf


On Fri, Apr 30, 2010 at 4:50 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Leyrit Vincent wrote:
> > Thanks you for the link, i have already have a look on it ...
> > The only thing that i do not understand in the code i have posted, is
> > that i never do any call to a linux domain syscall ...
>
> printf sometimes results in a linux domain syscall, it is mentioned in
> the howto.
>
> --
>                                             Gilles.
>

--001517475434ee33b50485756836
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sorry i have forgot to post all the code : <br>here printf is a define to t=
he one provided by xenomai library :<br><br>#define xnarch_printf printf<br=
><br><br><div class=3D"gmail_quote">On Fri, Apr 30, 2010 at 4:50 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Leyrit Vincent wrote:<br>
&gt; Thanks you for the link, i have already have a look on it ...<br>
&gt; The only thing that i do not understand in the code i have posted, is<=
br>
&gt; that i never do any call to a linux domain syscall ...<br>
<br>
</div>printf sometimes results in a linux domain syscall, it is mentioned i=
n<br>
the howto.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--001517475434ee33b50485756836--

