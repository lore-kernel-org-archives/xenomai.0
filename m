Date: Fri, 10 Oct 2008 15:24:29 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1471674837-1223652269=:28662"
Message-ID: <819144.28662.qm@domain.hid>
Subject: Re: [Xenomai-help] trap exceptions in user
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
Cc: Xenomai help <xenomai@xenomai.org>

--0-1471674837-1223652269=:28662
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A> Where does custom_except leaves, in kernel-space or user-space ?=0A=0A=
I have called rthal_trap_catch in the init function of the KD.=0AI have tri=
ed also in a rt task inside KD.=0A=0A>> - KD has an rtdm interface to map t=
he 16 MB memory on user space with=0A>> rtdm_iomap_to_user.=0A>> - UD start=
s and It maps with the rtdm (rtdm_iomap_to_user)=0A>=0A>This is completely =
useless. You can use an anonymous mapping in=0A>user-space, you will not ne=
ed the help from an rtdm driver. And your=0A>mapping needs to be executable=
 (you need to pass PROT_EXEC to mmap).=0A>> =0A>> - UD copy a binary asm x8=
6 test fpu (some instructions to generate=0A>> exceptions for tests) in the=
 16 MB memory mapped=0A>=0A>If you do that, your binary needs to be relocat=
able, that is its code=0A>must not depend on the address at which it is loa=
ded. Are you sure your=0A>binary blob has this property ?=0A=0AIt's a long =
story... I know anonymous mapping is better but I have need physical contig=
uos memory=0A(not for the test of course). The binary blob has fixed addres=
ses between 1 to 16 MB so I have mapped the first 15 MB of the UD (starting=
 to 1 MB). I Know it is very strange...=0A=0A>> =0A>> - UD start the real t=
ime task=0A>> =0A>> Now here is a the problem. If I invoke an exception (in=
t 3, floating=0A>> point exception and so on) outside the 16 MB mapped memo=
ry=0A>> "custom_except" is called ok. If the same code is invoked into the =
16=0A>> MB mapped memory the program crash (and this is ok) reporting the=
=0A>> description of the exception in the terminal (also this is ok) but=0A=
>> "custom_except" is not called!=0A>=0A>Who reports the exception, then ? =
=0A=0AI start UD from the terminal and the terminal always report the right=
 error.=0A=0A>Are you sure the exception reported is=0A>the one you expect =
? =0A=0AYes, I tried floating point, debug (int 3), page fault..=0A=0A>IOW,=
 are you sure the problem is not that your=0A>memory mapping is not executa=
ble ?=0A=0AThe PROT_EXEC flag is set.=0AIf I try to execute some instructio=
ns It works.=0A=0A>> Is there something wrong using the mapped memory in th=
is mode?=0A>> NOTE: I am using xenomai 2.4.0rc1 with kernel 2.6.23=0A>>Is t=
his a joke ? Why choosing a release candidate of a release which=0A>>happen=
ed since then ? Why not using the latest stable release ?=0A=0Ayou are righ=
t. It will be better to use the latest one (not rc). I had an already patch=
ed kernel=0A(with an other working xenomai application)=0A=0A    Gabriele=
=0A=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e s=
crivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-1471674837-1223652269=:28662
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>&gt; Where does custom_except leaves, in kernel-space or user-space ?<br=
><br>I have called rthal_trap_catch in the init function of the KD.<br>I ha=
ve tried also in a rt task inside KD.<br><br>&gt;&gt; - KD has an rtdm inte=
rface to map the 16 MB memory on user space with<br>&gt;&gt; rtdm_iomap_to_=
user.<br>&gt;&gt; - UD starts and It maps with the rtdm (rtdm_iomap_to_user=
)<br>&gt;<br>&gt;This is completely useless. You can use an anonymous mappi=
ng in<br>&gt;user-space, you will not need the help from an rtdm driver. An=
d your<br>&gt;mapping needs to be executable (you need to pass PROT_EXEC to=
 mmap).<br>&gt;&gt; <br>&gt;&gt; - UD copy a binary asm x86 test fpu (some
 instructions to generate<br>&gt;&gt; exceptions for tests) in the 16 MB me=
mory mapped<br>&gt;<br>&gt;If you do that, your binary needs to be relocata=
ble, that is its code<br>&gt;must not depend on the address at which it is =
loaded. Are you sure your<br>&gt;binary blob has this property ?<br><br>It'=
s a long story... I know anonymous mapping is better but I have need physic=
al contiguos memory<br>(not for the test of course). The binary blob has fi=
xed addresses between 1 to 16 MB so I have mapped the first 15 MB of the UD=
 (starting to 1 MB). I Know it is very strange...<br><br>&gt;&gt; <br>&gt;&=
gt; - UD start the real time task<br>&gt;&gt; <br>&gt;&gt; Now here is a th=
e problem. If I invoke an exception (int 3, floating<br>&gt;&gt; point exce=
ption and so on) outside the 16 MB mapped memory<br>&gt;&gt; "custom_except=
" is called ok. If the same code is invoked into the 16<br>&gt;&gt; MB mapp=
ed memory the program crash (and this is ok) reporting
 the<br>&gt;&gt; description of the exception in the terminal (also this is=
 ok) but<br>&gt;&gt; "custom_except" is not called!<br>&gt;<br>&gt;Who repo=
rts the exception, then ? <br><br>I start UD from the terminal and the term=
inal always report the right error.<br><br>&gt;Are you sure the exception r=
eported is<br>&gt;the one you expect ? <br><br>Yes, I tried floating point,=
 debug (int 3), page fault..<br><br>&gt;IOW, are you sure the problem is no=
t that your<br>&gt;memory mapping is not executable ?<br><br>The PROT_EXEC =
flag is set.<br>If I try to execute some instructions It works.<br><br>&gt;=
&gt; Is there something wrong using the mapped memory in this mode?<br>&gt;=
&gt; NOTE: I am using xenomai 2.4.0rc1 with kernel 2.6.23<br>&gt;&gt;Is thi=
s a joke ? Why choosing a release candidate of a release which<br>&gt;&gt;h=
appened since then ? Why not using the latest stable release ?<br><br>you a=
re right. It will be better to use the latest one (not rc). I had an
 already patched kernel<br>(with an other working xenomai application)<br><=
br>&nbsp;&nbsp;&nbsp; Gabriele<br></div></div></div><br>=0A=0A=0A=0A      <=
hr size=3D1><font face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.=
rd.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fww=
w.ymailblogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0=
, consigli... e scrivi la tua opinione!</font></body></html>
--0-1471674837-1223652269=:28662--

