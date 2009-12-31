MIME-Version: 1.0
In-Reply-To: <1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4AF04886.9040903@domain.hid>
	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid>
	<4AF15D68.7060001@domain.hid>
	<873433.54790.qm@domain.hid>
	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>
	<20091215213210.19d5b6a5@domain.hid>
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
Date: Thu, 31 Dec 2009 10:52:53 -0200
Message-ID: <4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d77e71c8eb34047c05bb83
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
To: xenomai@xenomai.org

--0016e6d77e71c8eb34047c05bb83
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am currently working on the port of Xenomai for the TI OMAP L-138
processor (DaVinci platform). I didn't finish yet. As soon as I finish, I
will send the patch, and I intend to do so next week.

I followed the instructions from Xenomai's wiki page. Until now, I am able
to boot my ported kernel with the I-Pipe feature. When I build the kernel
with Xenomai feature, the kernel stops to boot.

I have some questions:

1) How is the better way to debug the boot process? When my kernel stops
booting, after the message "Uncompressing .........." the boot halts. I
don't know what is going on and I don't know what to do in order to follow
the processes internally. Both debuggers (kernel and i-ipipe) are enabled in
the kernel configuration.

2) How tested the code must be done in order to send you a patch? Is there
any minimal set of tests that I should perform just before sending you a
patch for revision?

Best regards,

Flavio

Flavio de Castro Alves Filho
Embedded Software Services
www.phiinnovations.com
+55 11 84 94 56 76


2009/12/15 Sergey Didenko <didenkos@domain.hid>

> hi
>
> you are right, this is not common patch, but still it is a patch and you
> can apply it.
> to do that, run the command
> patch -p0 < new-patch
> in you linux kernel folder
>
> if you open the *.patch file with text editor, you will see the changes for
> only 4 files.
> This patch includes the changes to support Marvell SoC MV88F6290 with
> Counting Down free running counter.
>
> Kernel version is 2.6.29-v02.00.29
> Xenomai version is 2.4.9.1
>
> Sergey
>
> 2009/12/16 Aleksandr Lavrushchenko <aleksandr.lavrushchenko@domain.hid>
>
>>  On Fri, 6 Nov 2009 18:39:05 +0900
>> Sergey Didenko <didenkos@domain.hid> wrote:
>>
>> > Hello
>> >
>> > Here it is!
>> > I'm very sorry for this delay, it was related to 2 facts:
>> > 1) before publishing I wanted to put the code in order and to verify
>> > once again
>> > 2) I was extremely busy these days, especially with the project on
>> > Xenoimai and I could not do anything with that code except making my
>> > project work on it.
>> >
>> > I want to say only that it is working and you can use it with some
>> > changes for your board.
>> > One more time sorry for very late reply.
>> Hi.
>> I want to ask some questions about patch.
>> For which kernel version (and kernel patches if any) and xenomai version
>> this patch. And how apply it right, since it's not common patch, rather
>> suite of files?
>>
>> Thank you for answer.
>> --
>> WBR Lavruschenko Oleksandr
>>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--0016e6d77e71c8eb34047c05bb83
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>
<div>=A0</div>
<div>I am currently working on the port of Xenomai for the TI OMAP L-138 pr=
ocessor (DaVinci platform). I didn&#39;t finish yet. As soon as I finish, I=
 will send the patch, and I intend to do so next week.</div>
<div>=A0</div>
<div>I followed the instructions from Xenomai&#39;s wiki page. Until now, I=
 am able to boot my ported kernel with the I-Pipe feature. When I build the=
 kernel with Xenomai feature, the kernel stops to boot.</div>
<div>=A0</div>
<div>I have some questions:</div>
<div>=A0</div>
<div>1) How is the better way to debug the boot process? When my kernel sto=
ps booting, after the message &quot;Uncompressing ..........&quot; the boot=
 halts. I don&#39;t know what is going on and I don&#39;t know what to do i=
n order to follow the processes=A0internally. Both debuggers (kernel and i-=
ipipe) are enabled in the kernel configuration.</div>

<div>=A0</div>
<div>2) How tested the code must be done in order to send you a patch? Is t=
here any minimal set of tests that I should perform just before sending you=
 a patch for revision?</div>
<div>=A0</div>
<div>Best regards,</div>
<div>=A0</div>
<div>Flavio</div>
<div><br clear=3D"all">Flavio de Castro Alves Filho<br>Embedded Software Se=
rvices<br><a href=3D"http://www.phiinnovations.com">www.phiinnovations.com<=
/a><br>+55 11 84 94 56 76<br><br><br></div>
<div class=3D"gmail_quote">2009/12/15 Sergey Didenko <span dir=3D"ltr">&lt;=
<a href=3D"mailto:didenkos@domain.hid">didenkos@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">hi=20
<div><br>
<div>you are right, this is not common patch, but still it is a patch and y=
ou can apply it.</div>
<div>to do that, run the command</div>
<div><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: arial, sans-serif">patch =
-p0 &lt; new-patch</span></div>
<div><span style=3D"FONT-SIZE: 13px"></span><font face=3D"arial, sans-serif=
">in you linux kernel folder</font></div>
<div><font face=3D"arial, sans-serif"><br></font></div>
<div><font face=3D"arial, sans-serif">if you open the *.patch file with tex=
t editor, you will see the changes for only 4 files.</font></div>
<div><font face=3D"arial, sans-serif">This patch includes the changes to su=
pport Marvell SoC MV88F6290 with Counting Down free running counter.</font>=
</div>
<div><font face=3D"arial, sans-serif"><br></font></div>
<div><font face=3D"arial, sans-serif">Kernel version is 2.6.29-v02.00.29</f=
ont></div>
<div><font face=3D"arial, sans-serif">Xenomai version is 2.4.9.1</font></di=
v>
<div><font face=3D"arial, sans-serif"><br></font></div>
<div><font face=3D"arial, sans-serif">Sergey<br></font><br>
<div class=3D"gmail_quote">2009/12/16 Aleksandr Lavrushchenko <span dir=3D"=
ltr">&lt;<a href=3D"mailto:aleksandr.lavrushchenko@domain.hid" target=3D"_bl=
ank">aleksandr.lavrushchenko@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class=3D"im">On Fri, 6 Nov 2009 18:39:05 +0900<br>Sergey Didenko &lt;<=
a href=3D"mailto:didenkos@domain.hid" target=3D"_blank">didenkos@domain.hid</=
a>&gt; wrote:<br><br></div>
<div class=3D"im">&gt; Hello<br>&gt;<br>&gt; Here it is!<br>&gt; I&#39;m ve=
ry sorry for this delay, it was related to 2 facts:<br>&gt; 1) before publi=
shing I wanted to put the code in order and to verify<br>&gt; once again<br=
>
&gt; 2) I was extremely busy these days, especially with the project on<br>=
&gt; Xenoimai and I could not do anything with that code except making my<b=
r>&gt; project work on it.<br>&gt;<br>&gt; I want to say only that it is wo=
rking and you can use it with some<br>
&gt; changes for your board.<br>&gt; One more time sorry for very late repl=
y.<br></div></div>
<div class=3D"im">Hi.<br>I want to ask some questions about patch.<br>For w=
hich kernel version (and kernel patches if any) and xenomai version<br>this=
 patch. And how apply it right, since it&#39;s not common patch, rather<br>
suite of files?<br><br></div>
<div class=3D"im">Thank you for answer.<br><font color=3D"#888888">--<br>WB=
R Lavruschenko Oleksandr<br></font></div></blockquote></div><br></div></div=
><br>_______________________________________________<br>Xenomai-help mailin=
g list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a href=
=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">https://m=
ail.gna.org/listinfo/xenomai-help</a><br><br></blockquote></div><br>

--0016e6d77e71c8eb34047c05bb83--

