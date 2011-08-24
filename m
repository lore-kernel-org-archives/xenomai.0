MIME-Version: 1.0
In-Reply-To: <4E54F5B4.5070100@domain.hid>
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>
	<4E54EAE4.2060705@domain.hid>
	<CAL+uwv9Lg6uhqwy_YMxevFt4e8RJLrxZhm186L4-0xAHYDgLUw@domain.hid>
	<4E54F5B4.5070100@domain.hid>
Date: Wed, 24 Aug 2011 16:12:58 +0200
Message-ID: <CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307cfecec8f71004ab40e8cc
Subject: Re: [Xenomai-help] Hanging
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
Cc: Xenomai help <xenomai@xenomai.org>

--20cf307cfecec8f71004ab40e8cc
Content-Type: text/plain; charset=ISO-8859-1

Thank you Giles.

yes .The rt_printf is single-writer/ single -reader.



On 24 August 2011 14:59, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 08/24/2011 02:35 PM, suresh reddy wrote:
> >  Dear Giles,
> >
> > Please find the attached file of used code . Iam sure that iam not
> leaving
> > primary mode but iam using rt_printf(" xenomai") in a for loop to print
> for
> > some 1000 times.
>
> So, please take the time to understand how rt_printf work, and you will
> understand my answer.
>
> --
>                                             Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf307cfecec8f71004ab40e8cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Giles.<div><br></div><div>yes .The rt_printf is =
single-writer/ single -reader.</div><div><br></div><div><br><br><div class=
=3D"gmail_quote">On 24 August 2011 14:59, Gilles Chanteperdrix <span dir=3D=
"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chante=
perdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 08/24/2011 02:35 PM, s=
uresh reddy wrote:<br>
&gt; =A0Dear Giles,<br>
&gt;<br>
&gt; Please find the attached file of used code . Iam sure that iam not lea=
ving<br>
&gt; primary mode but iam using rt_printf(&quot; xenomai&quot;) in a for lo=
op to print for<br>
&gt; some 1000 times.<br>
<br>
</div>So, please take the time to understand how rt_printf work, and you wi=
ll<br>
understand my answer.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><br>S=
uresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--20cf307cfecec8f71004ab40e8cc--

