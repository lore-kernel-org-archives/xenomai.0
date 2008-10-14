Date: Tue, 14 Oct 2008 10:01:38 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-204381555-1223978498=:75012"
Message-ID: <621300.75012.qm@domain.hid>
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

--0-204381555-1223978498=:75012
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>> You should trace the exception path in the I-pipe patch to find the=0A>=
>>  point where your exception handling callback is not called.=0A>> =0A>> =
will it be a large print work or there are another ways to do that?=0A>> :)=
=0A>=0A> Yes, a small printk works. There is not that much code involved.=
=0A=0AI have found the problem.=0AI used a printf some instructions before =
the call to the asm blob.=0AOnce removed seems to work as expected.=0AI've =
seen also that writing=0A      printf(expr); \=0A      rt_task_set_mode(0, =
T_PRIMARY, 0);=0Ait works (I think printf does a switch to secondary domain=
).=0ANow I should use a user-space-no-problem print like rtdm_printk in ker=
nel space.=0AThe docs says rtdm_in_rt_context and rtdm_printk are avalaible=
 but in the rtdm.h=0Athere is no trace of them and I can't use rtdm_driver.=
h 'cause it's kernel only...=0A=0A    Gabriele=0A=0A=0A      Scopri il blog=
 di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua opinione.=0Ahttp://=
www.ymailblogit.com/blog
--0-204381555-1223978498=:75012
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;">&=
gt;&gt;&gt; You should trace the exception path in the I-pipe patch to find=
 the<br>&gt;&gt;&gt;&nbsp; point where your exception handling callback is =
not called.<br>&gt;&gt; <br>&gt;&gt; will it be a large print work or there=
 are another ways to do that?<br>&gt;&gt; :)<br>&gt;<br>&gt; Yes, a small p=
rintk works. There is not that much code involved.<br><br>I have found the =
problem.<br>I used a printf some instructions before the call to the asm bl=
ob.<br>Once removed seems to work as expected.<br>I've seen also that writi=
ng<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(expr); \<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; rt_task_set_mode(0, T_PRIMARY, 0);<br>it works (I think printf
 does a switch to secondary domain).<br>Now I should use a user-space-no-pr=
oblem print like rtdm_printk in kernel space.<br>The docs says rtdm_in_rt_c=
ontext and rtdm_printk are avalaible but in the rtdm.h<br>there is no trace=
 of them and I can't use rtdm_driver.h 'cause it's kernel only...<br><br>&n=
bsp;&nbsp;&nbsp; Gabriele<br><br></div></div></div><br>=0A=0A=0A=0A      <h=
r size=3D1><font face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.r=
d.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww=
.ymailblogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0,=
 consigli... e scrivi la tua opinione!</font></body></html>
--0-204381555-1223978498=:75012--

