MIME-Version: 1.0
In-Reply-To: <4BFD400F.1080307@domain.hid>
References: <AANLkTilzHg1IAyyLDpri8k8jI1hRooOwdehF8259xoAL@mail.gmail.com>
	<4BFD3F44.5000708@domain.hid>
	<AANLkTik4hSCdh03zRoiqLGfaF3RftwzhuWz-Qbfo7BDv@domain.hid>
	<4BFD400F.1080307@domain.hid>
Date: Wed, 26 May 2010 17:08:10 +0100
Message-ID: <AANLkTinCDHMi5TrYiyzCAkElG1N57f2tOTtcY8yEX6Y5@domain.hid>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=0016364165e7f950930487817a7f
Subject: Re: [Xenomai-help] pthread_setschedparam() segfault using Xenomai
	2.5.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--0016364165e7f950930487817a7f
Content-Type: text/plain; charset=ISO-8859-1

On 26 May 2010 16:36, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> wrote:

> Stephen Bryant wrote:
> > Already compiling the kernel, but the results may have to wait until
> > tomorrow,
>
> If it is the bug I am thinking it is, then you do not need to recompile
> the kernel, recompiling user-space support should be enough.
>
>
> --
>                                             Gilles.
>

Using Xenomai 2.5.3 has resolved the problem - and you were right that I did
not need to recompile the kernel, just the user-space support.  I'm guessing
this is the 'posix wrappers: avoid undefined reference with uclibc'
mentioned in the announcement?

Steve

--0016364165e7f950930487817a7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 26 May 2010 16:36, Gilles Chanteperdrix <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles=
.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Stephen Bryant wrote:<br>
&gt; Already compiling the kernel, but the results may have to wait until<b=
r>
&gt; tomorrow,<br>
<br>
</div>If it is the bug I am thinking it is, then you do not need to recompi=
le<br>
the kernel, recompiling user-space support should be enough.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>Using Xenomai 2.5.3 has resolved the problem =
- and you were right that I did not need to recompile the kernel, just the =
user-space support.=A0 I&#39;m guessing this is the &#39;posix wrappers: av=
oid undefined reference with uclibc&#39; mentioned in the announcement?<br>
<br>Steve<br>

--0016364165e7f950930487817a7f--

