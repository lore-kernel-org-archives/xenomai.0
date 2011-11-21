MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <4ECA2FF8.7040406@domain.hid>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
Date: Mon, 21 Nov 2011 12:10:12 +0100
Message-ID: <CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec54ee6cc0b64fb04b23cbb76
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

--bcaec54ee6cc0b64fb04b23cbb76
Content-Type: text/plain; charset=ISO-8859-1

Thanks very much Wolfang !
Cool script, I didn't know about it :)
I'll try to correct my code with that information !

Thanks again,

Hadrien

On Mon, Nov 21, 2011 at 12:03 PM, Wolfgang Grandegger <wg@domain.hid>wrote:

> On 11/21/2011 11:44 AM, Hadrien Caron wrote:
> > Hello to all !
> >
> > I have a small problem using a4l_sync_write : I am using it inside a
> > program that should write on a digital port.
> > The function a4l_sync_write returns a value of -38.
> > But according to the documentation, there is only 3 possible error
> > possibles :
> > EINVAL = 22
> > EFAULT = 14
> > ENOMEM = 12
> >
> > So what is error 38 ? Is it missing from the documentation ? Or am I
> doing
> > something wrong ?
>
> With "http://www.xenomai.org/index.php/Resolving_Error_Codes" I get:
>
> $ errno 38
> #define ENOSYS          38      /* Function not implemented */
>
> Wolfgang.
>
>

--bcaec54ee6cc0b64fb04b23cbb76
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks very much Wolfang !<br>Cool script, I didn&#39;t know about it :)<br=
>I&#39;ll try to correct my code with that information !<br><br>Thanks agai=
n,<br><br>Hadrien<br><br><div class=3D"gmail_quote">On Mon, Nov 21, 2011 at=
 12:03 PM, Wolfgang Grandegger <span dir=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid=
randegger.com">wg@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On 11/21/2011 11:44 AM, Hadrien Caron wrote:<br>
&gt; Hello to all !<br>
&gt;<br>
&gt; I have a small problem using a4l_sync_write : I am using it inside a<b=
r>
&gt; program that should write on a digital port.<br>
&gt; The function a4l_sync_write returns a value of -38.<br>
&gt; But according to the documentation, there is only 3 possible error<br>
&gt; possibles :<br>
&gt; EINVAL =3D 22<br>
&gt; EFAULT =3D 14<br>
&gt; ENOMEM =3D 12<br>
&gt;<br>
&gt; So what is error 38 ? Is it missing from the documentation ? Or am I d=
oing<br>
&gt; something wrong ?<br>
<br>
</div>With &quot;<a href=3D"http://www.xenomai.org/index.php/Resolving_Erro=
r_Codes" target=3D"_blank">http://www.xenomai.org/index.php/Resolving_Error=
_Codes</a>&quot; I get:<br>
<br>
$ errno 38<br>
#define ENOSYS =A0 =A0 =A0 =A0 =A038 =A0 =A0 =A0/* Function not implemented=
 */<br>
<font color=3D"#888888"><br>
Wolfgang.<br>
<br>
</font></blockquote></div><br>

--bcaec54ee6cc0b64fb04b23cbb76--

