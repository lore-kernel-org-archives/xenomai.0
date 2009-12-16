MIME-Version: 1.0
In-Reply-To: <20091215213210.19d5b6a5@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4AF04886.9040903@domain.hid> 
	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid> 
	<4AF15D68.7060001@domain.hid>
	<873433.54790.qm@domain.hid> 
	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid> 
	<20091215213210.19d5b6a5@domain.hid>
From: Sergey Didenko <didenkos@domain.hid>
Date: Wed, 16 Dec 2009 10:15:03 +0900
Message-ID: <1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
Content-Type: multipart/alternative; boundary=001636e1f7aba7b238047ace3d5f
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aleksandr Lavrushchenko <aleksandr.lavrushchenko@domain.hid>
Cc: xenomai@xenomai.org

--001636e1f7aba7b238047ace3d5f
Content-Type: text/plain; charset=UTF-8

hi

you are right, this is not common patch, but still it is a patch and you can
apply it.
to do that, run the command
patch -p0 < new-patch
in you linux kernel folder

if you open the *.patch file with text editor, you will see the changes for
only 4 files.
This patch includes the changes to support Marvell SoC MV88F6290 with
Counting Down free running counter.

Kernel version is 2.6.29-v02.00.29
Xenomai version is 2.4.9.1

Sergey

2009/12/16 Aleksandr Lavrushchenko <aleksandr.lavrushchenko@domain.hid>

> On Fri, 6 Nov 2009 18:39:05 +0900
> Sergey Didenko <didenkos@domain.hid> wrote:
>
> > Hello
> >
> > Here it is!
> > I'm very sorry for this delay, it was related to 2 facts:
> > 1) before publishing I wanted to put the code in order and to verify
> > once again
> > 2) I was extremely busy these days, especially with the project on
> > Xenoimai and I could not do anything with that code except making my
> > project work on it.
> >
> > I want to say only that it is working and you can use it with some
> > changes for your board.
> > One more time sorry for very late reply.
> Hi.
> I want to ask some questions about patch.
> For which kernel version (and kernel patches if any) and xenomai version
> this patch. And how apply it right, since it's not common patch, rather
> suite of files?
>
> Thank you for answer.
> --
> WBR Lavruschenko Oleksandr
>

--001636e1f7aba7b238047ace3d5f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi<div><br><div>you are right, this is not common patch, but still it is a =
patch and you can apply it.</div><div>to do that, run the command</div><div=
><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; =
font-size: 13px; ">patch -p0 &lt; new-patch</span></div>

<div><span class=3D"Apple-style-span" style=3D"font-size: 13px; "></span><f=
ont class=3D"Apple-style-span" face=3D"arial, sans-serif">in you linux kern=
el folder</font></div><div><font class=3D"Apple-style-span" face=3D"arial, =
sans-serif"><br>

</font></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-seri=
f">if you open the *.patch file with text editor, you will see the changes =
for only 4 files.</font></div><div><font class=3D"Apple-style-span" face=3D=
"arial, sans-serif">This patch includes the changes to support Marvell SoC =
MV88F6290 with Counting Down free running counter.</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><br></font=
></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif">Ker=
nel version is 2.6.29-v02.00.29</font></div><div><font class=3D"Apple-style=
-span" face=3D"arial, sans-serif">Xenomai version is 2.4.9.1</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, sans-serif"><br></font=
></div><div><font class=3D"Apple-style-span" face=3D"arial, sans-serif">Ser=
gey<br></font><br><div class=3D"gmail_quote">2009/12/16 Aleksandr Lavrushch=
enko <span dir=3D"ltr">&lt;<a href=3D"mailto:aleksandr.lavrushchenko@domain.hid.=
com">aleksandr.lavrushchenko@domain.hid</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Fri, 6 Nov 2009 18:39:=
05 +0900<br>
Sergey Didenko &lt;<a href=3D"mailto:didenkos@domain.hid">didenkos@domain.hid=
</a>&gt; wrote:<br>
<br>
&gt; Hello<br>
&gt;<br>
&gt; Here it is!<br>
&gt; I&#39;m very sorry for this delay, it was related to 2 facts:<br>
&gt; 1) before publishing I wanted to put the code in order and to verify<b=
r>
&gt; once again<br>
&gt; 2) I was extremely busy these days, especially with the project on<br>
&gt; Xenoimai and I could not do anything with that code except making my<b=
r>
&gt; project work on it.<br>
&gt;<br>
&gt; I want to say only that it is working and you can use it with some<br>
&gt; changes for your board.<br>
&gt; One more time sorry for very late reply.<br>
</div>Hi.<br>
I want to ask some questions about patch.<br>
For which kernel version (and kernel patches if any) and xenomai version<br=
>
this patch. And how apply it right, since it&#39;s not common patch, rather=
<br>
suite of files?<br>
<br>
Thank you for answer.<br>
<font color=3D"#888888">--<br>
WBR Lavruschenko Oleksandr<br>
</font></blockquote></div><br></div></div>

--001636e1f7aba7b238047ace3d5f--

