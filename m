MIME-Version: 1.0
In-Reply-To: <CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
Date: Wed, 28 Sep 2011 12:37:57 -0300
Message-ID: <CAMwkeZyweBUfU_b3+d2jmO-tEXDdEhvfWfNZ1HRt6O9vnxd3+w@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215e5d2a6d4d04ae022d51
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--bcaec5215e5d2a6d4d04ae022d51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/9/28 Julien Delange <julien.delange@domain.hid>

> 2011/9/27 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> > [snip]
>
> Dear Fernando,
>
> Would it be possible to provide more information about your bug, in
> particular, the configuration of the board (which is analogy0, ...)
> and the code you are trying to use ?
>
> Also, as Gilles said, please also try the latest rc release, it might
> solve your issues.
>
> Thanks,
>

Ok guys, I was about to copy a minimal example when I realized that I was
using:

a4l_open(&dev_output, "/dev/comedi1");

instead of:

a4l_open(&dev_output, "analogy1");

However, "cmd_read" is still not working, so I'll still give rc3 a try and
let you know.

Sorry for the inconveniences. There's no better way to find a bug than
explaining to others what you are doing ;)

Thanks,
Fernando

--bcaec5215e5d2a6d4d04ae022d51
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/9/28 Julien Delange <span dir=3D"ltr">&lt;<=
a href=3D"mailto:julien.delange@domain.hid">julien.delange@domain.hid</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=
.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
2011/9/27 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
&gt; [snip]<br>
<br>
Dear Fernando,<br>
<br>
Would it be possible to provide more information about your bug, in<br>
particular, the configuration of the board (which is analogy0, ...)<br>
and the code you are trying to use ?<br>
<br>
Also, as Gilles said, please also try the latest rc release, it might<br>
solve your issues.<br>
<br>
Thanks,<br></blockquote></div><br>Ok guys, I was about to copy a minimal ex=
ample when I realized that I was using:<br><br><div style=3D"margin-left: 4=
0px;">a4l_open(&amp;dev_output, &quot;/dev/comedi1&quot;);<br><br></div>
instead of:<br><br><div style=3D"margin-left: 40px;">a4l_open(&amp;dev_outp=
ut, &quot;analogy1&quot;);<br><br></div>However, &quot;cmd_read&quot; is st=
ill not working, so I&#39;ll still give rc3 a try and let you know.<br><br>
Sorry for the inconveniences. There&#39;s no better way to find a bug than =
explaining to others what you are doing ;)<br><br>Thanks,<br>Fernando<br>

--bcaec5215e5d2a6d4d04ae022d51--

