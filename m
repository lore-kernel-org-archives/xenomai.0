MIME-Version: 1.0
In-Reply-To: <49EAEBF8.9090006@domain.hid>
References: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>
	<49E89BC7.6000704@domain.hid>
	<2b490f270904190151n70cfc610u9a742da5c62e4076@domain.hid>
	<49EAEBF8.9090006@domain.hid>
Date: Thu, 23 Apr 2009 09:02:13 +0200
Message-ID: <2b490f270904230002u224fb692g6ff0ad237acc8dfb@domain.hid>
From: Dehann Fourie <dehann.fourie@domain.hid>
Content-Type: multipart/alternative; boundary=0016369fa2fda97526046833759a
Subject: Re: [Xenomai-help] RT Serial, rt_dev_read blocking problem
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

--0016369fa2fda97526046833759a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

Just for informations sake. I am still on xeno 2.4.3, but setting
.rx_timeout to RTSER_TIMEOUT_NONE has fixed the problem. Many thanks.

Dehann

On Sun, Apr 19, 2009 at 11:16 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Dehann Fourie wrote:
> > Hi Gilles,
> >
> > Thanks a lot. Will give it a try. I have tried  .rx_timeout =
> > RTSER_TIMEOUT_NONE before, but then I was not able to read any data. I am
> > assuming the data expired before I had read it. This was on a different
> > config however, so I will try it again.
> >
> > Please excuse my lack of knowledge but I am not following you on:
> > -  ... and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31
> > -     from head.
>
> Xenomai has a git repository now. See http://git.xenomai.org/
> 3a23967f3cc8d6881d8e3280130bbc431195aa31<http://git.xenomai.org/%0A3a23967f3cc8d6881d8e3280130bbc431195aa31>is the identifier of a commit.
>
> --
>                                             Gilles.
>



-- 
Dehann Fourie

--0016369fa2fda97526046833759a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,<br><br>Just for informations sake. I am still on xeno 2.4.3, but=
 setting .rx_timeout to RTSER_TIMEOUT_NONE has fixed the problem. Many than=
ks.<br><br>Dehann<br><br><div class=3D"gmail_quote">On Sun, Apr 19, 2009 at=
 11:16 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gil=
les.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Dehann Fourie wrote:<br>
&gt; Hi Gilles,<br>
&gt;<br>
&gt; Thanks a lot. Will give it a try. I have tried =A0.rx_timeout =3D<br>
&gt; RTSER_TIMEOUT_NONE before, but then I was not able to read any data. I=
 am<br>
&gt; assuming the data expired before I had read it. This was on a differen=
t<br>
&gt; config however, so I will try it again.<br>
&gt;<br>
&gt; Please excuse my lack of knowledge but I am not following you on:<br>
&gt; - =A0... and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31=
<br>
&gt; - =A0 =A0 from head.<br>
<br>
</div>Xenomai has a git repository now. See <a href=3D"http://git.xenomai.o=
rg/%0A3a23967f3cc8d6881d8e3280130bbc431195aa31" target=3D"_blank">http://gi=
t.xenomai.org/<br>
3a23967f3cc8d6881d8e3280130bbc431195aa31</a> is the identifier of a commit.=
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Dehann Fourie<br=
>

--0016369fa2fda97526046833759a--

