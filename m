MIME-Version: 1.0
In-Reply-To: <1289833622.1933.128.camel@domain.hid>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
	<1289813422.1933.79.camel@domain.hid> <4CE13133.4070006@domain.hid>
	<1289833622.1933.128.camel@domain.hid>
Date: Mon, 15 Nov 2010 21:26:07 +0100
Message-ID: <AANLkTinOLTEzR-xAw3msZjyj6kOqCpW0y6uOcHX7_Ogd@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=00163646da6c08c72604951d40fa
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

--00163646da6c08c72604951d40fa
Content-Type: text/plain; charset=ISO-8859-1

Hello

Thanks for the information.
I was testing on QEMU but I have seen that there are issue with the timing
anyhow.
I'm currently changing to a target environment. Once this is completed, I
will re-run my tests and get back with the result.

I do not really understand what you mean with the simulator.
Where can I find more information about it?

Thanks
Ronny

On Mon, Nov 15, 2010 at 4:07 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-11-15 at 14:10 +0100, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > If you want to validate the pSOS emulation core, the best tool is the
> > > simulator. Unfortunately, this tools still requires to be built with an
> > > antiquated C++ toolchain, so the only sane way to enable it nowadays is
> > > via qemu. You would need ~2 hours to set this up.
> > >
> > > If you want to try this, I can help. Otherwise, other suggestions you
> > > already got on this list will do.
> >
> > Maybe we should put a page on the wiki on how to use the simulator?
> >
>
> The problem is that we have no bandwidth to maintain it properly, this
> is a project in itself; so this should be clearly stated on such
> documentation. The gcc-based (2.95.x) instrumenter is 12-years old now,
> and rewriting this part would a very significant work. It's really a
> pity, since the simulator is definitely the ultimate tool for finding
> functional bugs in emulators. Oh, well.


> --
> Philippe.
>
>
>

--00163646da6c08c72604951d40fa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>Thanks for the information.<br>I was testing on QEMU but I hav=
e seen that there are issue with the timing anyhow.<br>I&#39;m currently ch=
anging to a target environment. Once this is completed, I will re-run my te=
sts and get back with the result.<br>
<br>I do not really understand what you mean with the simulator.<br>Where c=
an I find more information about it?<br><br>Thanks<br>Ronny<br><br><div cla=
ss=3D"gmail_quote">On Mon, Nov 15, 2010 at 4:07 PM, Philippe Gerum <span di=
r=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On Mon, 2010-11-15 at 14:10 +0100, Gilles Chanteperdrix wrote:<br>
&gt; Philippe Gerum wrote:<br>
&gt; &gt; If you want to validate the pSOS emulation core, the best tool is=
 the<br>
&gt; &gt; simulator. Unfortunately, this tools still requires to be built w=
ith an<br>
&gt; &gt; antiquated C++ toolchain, so the only sane way to enable it nowad=
ays is<br>
&gt; &gt; via qemu. You would need ~2 hours to set this up.<br>
&gt; &gt;<br>
&gt; &gt; If you want to try this, I can help. Otherwise, other suggestions=
 you<br>
&gt; &gt; already got on this list will do.<br>
&gt;<br>
&gt; Maybe we should put a page on the wiki on how to use the simulator?<br=
>
&gt;<br>
<br>
</div>The problem is that we have no bandwidth to maintain it properly, thi=
s<br>
is a project in itself; so this should be clearly stated on such<br>
documentation. The gcc-based (2.95.x) instrumenter is 12-years old now,<br>
and rewriting this part would a very significant work. It&#39;s really a<br=
>
pity, since the simulator is definitely the ultimate tool for finding<br>
functional bugs in emulators. Oh, well.=A0</blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--00163646da6c08c72604951d40fa--

