MIME-Version: 1.0
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2D797@domain.hid>
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>
	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D27F@EXDB4.ug.kth.se>
	<22150A2C94CC924695BE248F94CD11F2D375@domain.hid>
	<4C2DDE49.1080009@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D3C1@domain.hid>
	<AANLkTimw6Bz9-ZVvFl46_WTlo2Z-T8Kc0mebS5DYd-1K@mail.gmail.com>
	<22150A2C94CC924695BE248F94CD11F2D4D6@domain.hid>
	<AANLkTimRsJQOJehXmFnWE0vEYTkDLXivif3aeNaTNJB8@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D5F3@domain.hid>
	<AANLkTimtPz6v0XseTXMFwENAs4bF1mTfQEtTCY-W5VaI@mail.gmail.com>
	<22150A2C94CC924695BE248F94CD11F2D75E@EXDB4.ug.kth.se>
	<22150A2C94CC924695BE248F94CD11F2D797@domain.hid>
Date: Mon, 5 Jul 2010 17:15:56 -0300
Message-ID: <AANLkTikTdTdwmS6S59QxDHg4U2z1PnfhOGZxIE7p7ccD@mail.gmail.com>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=00163630f5bbb8435d048aa99ab5
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fredrik Asplund <fasplund@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--00163630f5bbb8435d048aa99ab5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Great! The entire system worked very well.

Tested for 4 hours under load, best latency around 17us, and worst 47us. No
lock-ups or instability.

Thanks for the help! I will try to automate and document the process a bit,
and put it in my lab's wiki (giving proper credit, of course).

2010/7/5 Fredrik Asplund <fasplund@domain.hid>

> >>I downloaded the uImage and RootFS from your website and deployed to th=
e
> >>SD Card - and it did boot from the SD (I saw the clean startup and the
> logs).
> >>The kernel has Xenomai enabled, but the user-space portion doesn't seem
> to be installed.
> >Ok. I must have copied the wrong file to DropBox. Try this one instead:
> >http://dl.dropbox.com/u/8307741/Angstrom-gumstixwithxenomai
> >-glibc-ipk-2010.4-test-20100701-overo.rootfs.tar.bz2
>
> I checked my SD Card and the file above is the one I used when testing
> Xenomai last week (and also the one which has a name that corresponds to =
the
> build file I used). The other one must have been some old rootfs which I
> built earlier (it was around 23-01 when I updated the Wiki).
>
> Sorry.
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Automation and Robotics Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00163630f5bbb8435d048aa99ab5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Great! The entire system worked very well.<div><br></div><div>Tested for 4 =
hours under load, best latency around 17us, and worst 47us. No lock-ups or =
instability.</div><div><br></div><div>Thanks for the help! I will try to au=
tomate and document the process a bit, and put it in my lab&#39;s wiki (giv=
ing proper credit, of course).<br>
<br><div class=3D"gmail_quote">2010/7/5 Fredrik Asplund <span dir=3D"ltr">&=
lt;<a href=3D"mailto:fasplund@domain.hid">fasplund@domain.hid</a>&gt;</span><br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">&gt;&gt;I downloaded the uImage and RootF=
S from your website and deployed to the<br>
&gt;&gt;SD Card - and it did boot from the SD (I saw the clean startup and =
the logs).<br>
&gt;&gt;The kernel has Xenomai enabled, but the user-space portion doesn&#3=
9;t seem to be installed.<br>
&gt;Ok. I must have copied the wrong file to DropBox. Try this one instead:=
<br>
&gt;<a href=3D"http://dl.dropbox.com/u/8307741/Angstrom-gumstixwithxenomai"=
 target=3D"_blank">http://dl.dropbox.com/u/8307741/Angstrom-gumstixwithxeno=
mai</a><br>
&gt;-glibc-ipk-2010.4-test-20100701-overo.rootfs.tar.bz2<br>
<br>
</div></div>I checked my SD Card and the file above is the one I used when =
testing Xenomai last week (and also the one which has a name that correspon=
ds to the build file I used). The other one must have been some old rootfs =
which I built earlier (it was around 23-01 when I updated the Wiki).<br>

<br>
Sorry.<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Felipe Br=
and=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Automation and Robotics Laborator=
y<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =A0 UnB =
- University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>
</div>

--00163630f5bbb8435d048aa99ab5--

