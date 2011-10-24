MIME-Version: 1.0
In-Reply-To: <4E9D5C7C.1040306@domain.hid>
References: <CAMwkeZxovug1Zws+NCvaU_6vhK2f3FbZqPg5kq2wVV-YvOkLSA@mail.gmail.com>
	<CAMesUR4iU0=-vTVmk=adq5uR_bep-C7Mycoxk=59Msn2BFngiA@mail.gmail.com>
	<4E9D5C7C.1040306@domain.hid>
Date: Mon, 24 Oct 2011 17:04:54 -0200
Message-ID: <CAMwkeZwAMFQWm9Uz6k=G7QvYn2CBbd0nZAZrL7Gk5LBVSPauzg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec51dde2f2771c804b0101922
Subject: Re: [Xenomai-help] Command code working with comedi not working
 with analogy [partially solved]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec51dde2f2771c804b0101922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 18 de octubre de 2011 09:01, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> escribi=C3=B3:

> On 10/18/2011 12:25 AM, Alexis Berlemont wrote:
>
> > The last few days, I did not have enough time to review the buffer
> > allocation system just like Comedi did. So, I implemented a quick
> > workaround Gilles indicated me.
> >
> > Could you validate it on your 64bits architecture (with more than 4GB o=
f
> RAM)?
> >
> > The code is available here:
> > git://git@domain.hid
> > branch: analogy.
>
> I pull this for -rc5.
>
>
Ok guys, this is working now with 6GB of memory.

Thanks!
Fernando

--bcaec51dde2f2771c804b0101922
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 18 de octubre de 2011 09:01, Gilles Chanteper=
drix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
rg">gilles.chanteperdrix@xenomai.org</a>&gt;</span> escribi=C3=B3:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">On 10/18/2011 12:25 AM, Alexis Berlemont =
wrote:<br>
<br>
&gt; The last few days, I did not have enough time to review the buffer<br>
&gt; allocation system just like Comedi did. So, I implemented a quick<br>
&gt; workaround Gilles indicated me.<br>
&gt;<br>
&gt; Could you validate it on your 64bits architecture (with more than 4GB =
of RAM)?<br>
&gt;<br>
&gt; The code is available here:<br>
&gt; git://<a href=3D"http://git@domain.hid" target=3D"_bl=
ank">git@domain.hid</a><br>
&gt; branch: analogy.<br>
<br>
</div></div>I pull this for -rc5.<br>
<br></blockquote></div><br>Ok guys, this is working now with 6GB of memory.=
<br><br>Thanks!<br>Fernando<br>

--bcaec51dde2f2771c804b0101922--

