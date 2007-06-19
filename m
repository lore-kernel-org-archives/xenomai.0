Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <f48df4840706191211h232fefe0tb14ff96372117c5a@domain.hid>
References: <f48df4840706191211h232fefe0tb14ff96372117c5a@domain.hid>
Content-Type: multipart/alternative; boundary=Apple-Mail-1--30683823
Message-Id: <401A67A8-BB34-4B7A-A99B-CD23DD70E9FC@gmail.com>
From: Bruno Rouchouse <brouchouse@domain.hid>
Date: Tue, 19 Jun 2007 23:11:02 +0200
Subject: Re: [Xenomai-help] Adeos tag on kernel name
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--Apple-Mail-1--30683823
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1;
	delsp=yes;
	format=flowed

General Setup
	() Local version - append to kernel release

Corresponds to CONFIG_LOCALVERSION in the .config file.

Thanks Philippe!

--Bruno

Le 19 juin 07 =E0 21:11, Bruno Rouchouse a =E9crit :

> Hi Xenomai users !
>
> just having some little trouble with my last Xenomai compilation. =20
> I'm wondering what I'm doing wrong...
>
> Last kernel I build on my laptop was a 2.6.20.11 . uname -a gives me:
> 2.6.20.11-adeos #1 SMP Thu May 17...
>
> Modules are installed in a directory named /lib/modules/2.6.20.11-=20
> adeos
>
> So far everything is fine...
>
> On my workstation with a freshly installed Debian etch =20
> distribution, uname -a returns:
> 2.6.20.11-adeos #1 SMP Thu May 17...
>
> No adeos tag here!
>
> During the build and installation process of the kernel, my /lib/=20
> modules/2.6.20.14 (without adeos this one) has been then =20
> overwritten -- no big deal though -- but I would like to have both =20
> version of 2.6.20.14 on my box:  one with adeos and another without =20=

> it.
>
> Did I forget anything somewhere? Configuration maybe...
>
> I tried to find out what condition changes the name of the built =20
> kernel -- Makefile (EXTRAVERSION) or include/linux/version.h -- but =20=

> I haven't been too lucky so far.
>
> Could someone point me out what is wrong here or what I'm doing wrong?
>
> Thanks in advance.
>
> --Bruno
>

--
Bruno Rouchouse
brouchouse@domain.hid




--Apple-Mail-1--30683823
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; ">General Setup<DIV><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN>() Local =
version - append to kernel release</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Corresponds to =
CONFIG_LOCALVERSION in the .config file.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Thanks =
Philippe!</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>--Bruno</DIV><DIV><BR><DIV><D=
IV>Le 19 juin 07 =E0 21:11, Bruno Rouchouse a =E9crit :</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite">Hi Xenomai =
users !<BR><BR>just having some little trouble with my last Xenomai =
compilation. I'm wondering what I'm doing wrong...<BR><BR>Last kernel I =
build on my laptop was a <A href=3D"http://2.6.20.11">2.6.20.11</A> . =
uname -a gives me:<BR>2.6.20.11-adeos #1 SMP Thu May =
17...<BR><BR>Modules are installed in a directory named =
/lib/modules/2.6.20.11-adeos <BR> <BR>So far everything is =
fine...<BR><BR>On my workstation with a freshly installed Debian etch =
distribution, uname -a returns:<BR>2.6.20.11-adeos #1 SMP Thu May 17... =
<BR><BR>No adeos tag here!<BR><BR>During the build and installation =
process of the kernel, my /lib/modules/2.6.20.14 (without adeos this =
one) has been then overwritten -- no big deal though -- but I would like =
to have both version of <A href=3D"http://2.6.20.14">2.6.20.14</A> on my =
box:=A0 one with adeos and another without it.<BR><BR>Did I forget =
anything somewhere? Configuration maybe...<BR><BR>I tried to find out =
what condition changes the name of the built kernel -- Makefile =
(EXTRAVERSION) or include/linux/version.h -- but I haven't been too =
lucky so far. <BR><BR>Could someone point me out what is wrong here or =
what I'm doing wrong?<BR><BR>Thanks in =
advance.<BR><BR>--Bruno<BR><BR></BLOCKQUOTE></DIV><BR><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>--</DIV><DIV>Bruno Rouchouse</DIV><DIV><A =
href=3D"mailto:brouchouse@domain.hid">brouchouse@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-1--30683823--

