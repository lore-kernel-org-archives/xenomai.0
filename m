MIME-Version: 1.0
Sender: sink00@domain.hid
In-Reply-To: <4E0F7C03.20304@domain.hid>
References: <201106301212.47433.carlosnov@domain.hid>
	<4E0D7DE7.50803@domain.hid>
	<201107011423.18553.carlosnov@domain.hid>
	<4E0F7C03.20304@domain.hid>
Date: Sat, 2 Jul 2011 17:38:57 -0300
Message-ID: <CAODUr7tzvghAD0Z5xy3qf9Z0P7DLw34j2mX2H5JCw6q2CydurA@mail.gmail.com>
From: Luis Rossi <luisf.rossi@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec52156e595a5dc04a71c1fe8
Subject: Re: [Xenomai-help] Writing a new driver, Skin differences.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--bcaec52156e595a5dc04a71c1fe8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry to get inside in the middle ofconversation... what you mean writing
driver in kernel-space is deprecated. Is there any other way to make a
driver? I belive a kernel-driver should be the most RT possible no?

On Sat, Jul 2, 2011 at 5:13 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/01/2011 07:23 PM, Carlos Eduardo de Brito Novaes wrote:
> > Hello,
> >
> > I think I the question on using memory mapped are solved. Now I was
> wondering
> > and cant find a big difference over the four skins, at least for a new
> project
> > with no previous code written on the past. Is there any advantage in
> using the
> > rtdm skin over the navive one?
>
> The RTDM is meant for writing drivers in kernel-space and continuity
> will be ensured in Xenomai 3.x, whereas the other kernel-space skins
> will no longer be available in Xenomai 3.x. Writing drivers in
> kernel-space with either the native or the posix skin is deprecated.
>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



--=20
Lu=EDs Filipe Rossi
Electrical Engineer
Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
Escola Polit=E9cnica
Universidade de S=E3o Paulo
Cel. +55 (11) 7662-9234

--bcaec52156e595a5dc04a71c1fe8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry to get inside in the middle ofconversation... what you mean writing d=
river in kernel-space is deprecated. Is there any other way to make a drive=
r? I belive a kernel-driver should be the most RT possible no?<br><br><div =
class=3D"gmail_quote">
On Sat, Jul 2, 2011 at 5:13 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
nomai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 07/01/2011 07:23 PM, Carlos Eduardo de Brito Novaes wr=
ote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I think I the question on using memory mapped are solved. Now I was wo=
ndering<br>
&gt; and cant find a big difference over the four skins, at least for a new=
 project<br>
&gt; with no previous code written on the past. Is there any advantage in u=
sing the<br>
&gt; rtdm skin over the navive one?<br>
<br>
</div>The RTDM is meant for writing drivers in kernel-space and continuity<=
br>
will be ensured in Xenomai 3.x, whereas the other kernel-space skins<br>
will no longer be available in Xenomai 3.x. Writing drivers in<br>
kernel-space with either the native or the posix skin is deprecated.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font><div><div></div><div class=3D"h5"><br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div>Lu=EDs=
 Filipe Rossi<br>Electrical Engineer</div>
<div><span style=3D"text-transform:none;text-indent:0px;border-collapse:sep=
arate;font:medium &#39;Times New Roman&#39;;white-space:normal;letter-spaci=
ng:normal;color:rgb(0,0,0);word-spacing:0px"><span style=3D"border-collapse=
:collapse;font-family:arial, sans-serif;font-size:13px">Biomechatronics Lab=
. / <span style=3D"text-transform:none;text-indent:0px;border-collapse:sepa=
rate;font:medium &#39;Times New Roman&#39;;white-space:normal;letter-spacin=
g:normal;color:rgb(0,0,0);word-spacing:0px"><span style=3D"border-collapse:=
collapse;font-family:arial, sans-serif;font-size:13px">Grupo de Sensores In=
tegr=E1veis e Sistemas</span></span></span></span></div>

<div>Escola Polit=E9cnica<br>Universidade de S=E3o Paulo</div>
<div>Cel. +55 (11) 7662-9234</div><br>

--bcaec52156e595a5dc04a71c1fe8--

