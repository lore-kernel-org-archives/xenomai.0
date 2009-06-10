MIME-Version: 1.0
In-Reply-To: <4A299794.6010504@domain.hid>
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid> 
	<4A299794.6010504@domain.hid>
From: Thiago Lima <thiagolims@domain.hid>
Date: Wed, 10 Jun 2009 19:36:51 +0000
Message-ID: <6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid>
Content-Type: multipart/alternative; boundary=001e680f1230fd6ce8046c039995
Subject: Re: [Xenomai-help] Get ready queue
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

--001e680f1230fd6ce8046c039995
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, i didnt understand you answer.
I get the global queue doing this:

threads =3D &pod->threadq;    // GLOBAL QUEUE
holder =3D getheadq(&nkpod->threadq); //HEAD NODE

thanks for helping.

On Fri, Jun 5, 2009 at 10:09 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Thiago Lima wrote:
> > Hi everybody,
> >
> > I have a function in a linux kernel module that is called whenever a
> > function in xenomai domain starts. In this moment, i need to get the
> ready
> > queue with all ready threads of xenomai.
> > Do you realize how can i do that ?
>
> If you are using a skin, then you should restrict yourself to the
> services of that skin. If you are writing a skin, then the services you
> can access are those of the nucleus.
>
> http://www.xenomai.org/documentation/trunk/html/api/group__nucleus.html
>
> If you are writing your own skin, then you can add an xnholder structure
> to the TCB of your tasks, it will allow you to walk this list once you
> need it.
>
> --
>                                             Gilles.
>



--=20
Thiago Lima Silva
Graduando - Ci=EAncia da Computa=E7=E3o UFBA
Registered Linux user #466887

--001e680f1230fd6ce8046c039995
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, i didnt understand you answer.<br>I get the global queue doing this:=
<br><br>threads =3D &amp;pod-&gt;threadq;=A0=A0=A0 // GLOBAL QUEUE=A0=A0=A0=
 <br>holder =3D getheadq(&amp;nkpod-&gt;threadq); //HEAD NODE<br><br>thanks=
 for helping.<br>

<br><div class=3D"gmail_quote">On Fri, Jun 5, 2009 at 10:09 PM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im">Thiago Lima wrote:<br>
&gt; Hi everybody,<br>
&gt;<br>
&gt; I have a function in a linux kernel module that is called whenever a<b=
r>
&gt; function in xenomai domain starts. In this moment, i need to get the r=
eady<br>
&gt; queue with all ready threads of xenomai.<br>
&gt; Do you realize how can i do that ?<br>
<br>
</div>If you are using a skin, then you should restrict yourself to the<br>
services of that skin. If you are writing a skin, then the services you<br>
can access are those of the nucleus.<br>
<br>
<a href=3D"http://www.xenomai.org/documentation/trunk/html/api/group__nucle=
us.html" target=3D"_blank">http://www.xenomai.org/documentation/trunk/html/=
api/group__nucleus.html</a><br>
<br>
If you are writing your own skin, then you can add an xnholder structure<br=
>
to the TCB of your tasks, it will allow you to walk this list once you<br>
need it.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Thiago Lima Silv=
a<br>Graduando - Ci=EAncia da Computa=E7=E3o UFBA<br>Registered Linux user =
#466887<br><br>

--001e680f1230fd6ce8046c039995--

