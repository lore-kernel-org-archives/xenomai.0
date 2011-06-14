MIME-Version: 1.0
In-Reply-To: <4DF72AE9.10904@domain.hid>
References: <BANLkTinhVjCZH-ni-M-HWUv5EY5hy8YcBA@mail.gmail.com>
	<4DF72AE9.10904@domain.hid>
Date: Tue, 14 Jun 2011 13:35:12 +0200
Message-ID: <BANLkTin-cH7UsO+Gq6aniRLWRGSDE_0ktw@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53aed3cd9921504a5aa6d30
Subject: Re: [Xenomai-help] xenomai configuration
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

--bcaec53aed3cd9921504a5aa6d30
Content-Type: text/plain; charset=ISO-8859-1

Yes . i passed linux build option to display on configure window as linux
build in xenomai tree.

Now Iam running DESTDIR .

which giving me following error.

error: bad value (armv7-a) for -march= switch
/home/balijepalli/pandaboard/xenomai-2.5.6/src/rtdk/rt_print.c:1: error: bad
value (armv7-a) for -mtune= switch


Thanks for the help .








On 14 June 2011 11:33, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 06/14/2011 11:17 AM, suresh reddy wrote:
> > Dear all,
> > Iam running the below command . It giving me the config options as below
> > . It showing me as linux is not building in xenomai tree (maked
> > below).It seems i went wrong somewhere . Can somebody let me know where
> > should i check for this option.
>
> No. There is nothing wrong. Building linux in xenomai build tree is
> enabled by an option which you did not pass, and which is about to be
> deprecated.
>
> --
>                                             Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec53aed3cd9921504a5aa6d30
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes . i passed linux build option to display on configure =
window as linux build in xenomai tree.<div><br></div><div>Now Iam running D=
ESTDIR .=A0</div><div><br></div><div>which giving me following error.</div>=
<div>
<br></div><div><div>error: bad value (armv7-a) for -march=3D switch</div><d=
iv>/home/balijepalli/pandaboard/xenomai-2.5.6/src/rtdk/rt_print.c:1: error:=
 bad value (armv7-a) for -mtune=3D switch</div></div><div><br></div><div><b=
r>
</div><div>Thanks for the help .</div><div><br></div><div><br></div><div><b=
r></div><div><br></div><div><br></div><div><br></div><div><br><br><div clas=
s=3D"gmail_quote">On 14 June 2011 11:33, Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 06/14/2011 11:17 AM, s=
uresh reddy wrote:<br>
&gt; Dear all,<br>
&gt; Iam running the below command . It giving me the config options as bel=
ow<br>
&gt; . It showing me as linux is not building in xenomai tree (maked<br>
&gt; below).It seems i went wrong somewhere . Can somebody let me know wher=
e<br>
&gt; should i check for this option.<br>
<br>
</div>No. There is nothing wrong. Building linux in xenomai build tree is<b=
r>
enabled by an option which you did not pass, and which is about to be<br>
deprecated.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><br>Suresh balij=
epalli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec53aed3cd9921504a5aa6d30--

