Date: Tue, 25 Jan 2011 14:17:40 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <14122707.101295961457625.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <20964580.81295961364859.JavaMail.SYSTEM@PC-MRINALDI>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5_8621536.1295961457609"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
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
Cc: xenomai@xenomai.org

------=_Part_5_8621536.1295961457609
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- Messaggio originale -----=20
Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>=20
A: "Michel Rinaldi" <automation.03@domain.hid>=20
Cc: xenomai@xenomai.org
Inviato: Luned=C3=AC, 24 gennaio 2011 17:54:51 GMT +01:00 Amsterdam/Berlino=
/Berna/Roma/Stoccolma/Vienna=20
Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join=
=20


>Ok. Sorry, the rt_sem_p is actually waiting for the semaphore. So, for=20
>it to take a long time, the kernel module would have to post it all the=20
>time. In the kernel module, you should check rtdm_task_wait_period=20
>return value.=20
>=20
>Anyway, what I said still stands: if we suspect the application of being=
=20
>the culprit, we should try and run a system without this application=20
>first. That is, only latency and some non real-time load.=20

I run a latency test for about 2 hours, in concomitance with two=20
dd if=3D/dev/zero of=3D/dev/null=20
commands and some sporadic ssh big file transfers. Last row in test output =
was:=20

RTD| 6.546| 7.191| 10.346| 0| 0| 1.101| 29.508=20

Maximum latencies was obtained during file transfers.=20
With this result I think that I could assert that Xenomai works properly on=
 my system, is right?=20

In facts, same test (only without file transfer) under another system with =
1GHz Intel Atom on a SCH (Poulsbo) chipset (not supported by Xenomai to dis=
able SMIs) reports these results:=20

RTD| 11.353| 13.808| 31.264| 3| 0| 2.934| 231.539=20

I think high latencies are due to SMIs.=20
By the way, is there a reason why Xenomai does not disable SMIs on SCH chip=
sets?=20
In past I tried to "patch" smi.c file with SCH identifier, but latency test=
 results make worse instead improve.=20

Thank you again=20
Mauro=20

------=_Part_5_8621536.1295961457609
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><br>----- Messaggio originale -----<br>Da: "Gilles Chanteperdrix" &lt;gill=
es.chanteperdrix@domain.hid&gt;<br>A: "Michel Rinaldi" &lt;automation.03@domain.hid=
migroup.it&gt;<br>Cc: xenomai@xenomai.org<br>Inviato: Luned=C3=AC, 24 genn=
aio 2011 17:54:51 GMT +01:00 Amsterdam/Berlino/Berna/Roma/Stoccolma/Vienna<=
br>Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_joi=
n<br><br><br>&gt;Ok. Sorry, the rt_sem_p is actually waiting for the semaph=
ore. So, for<br>&gt;it to take a long time, the kernel module would have to=
 post it all the<br>&gt;time. In the kernel module, you should check rtdm_t=
ask_wait_period<br>&gt;return value.<br>&gt;<br>&gt;Anyway, what I said sti=
ll stands: if we suspect the application of being<br>&gt;the culprit, we sh=
ould try and run a system without this application<br>&gt;first. That is, o=
nly latency and some non real-time load.<br><br>I run a latency test for ab=
out 2 hours, in concomitance with two <br>dd if=3D/dev/zero of=3D/dev/null<=
br>commands and some sporadic ssh big file transfers. Last row in test outp=
ut was:<br><br>RTD| 6.546| 7.191| 10.346| 0| 0| 1.101| 29.508 <br><br>Maxim=
um latencies was obtained during file transfers.<br>With this result I thin=
k that I could assert that Xenomai works properly on my system, is right?<b=
r><br>In facts, same test (only without file transfer) under another system=
 with 1GHz Intel Atom on a SCH (Poulsbo) chipset (not supported by Xenomai =
to disable SMIs) reports these results:<br><br>RTD| 11.353| 13.808| 31.264|=
 3| 0| 2.934| 231.539<br><br>I think high latencies are due to SMIs.<br>By =
the way, is there a reason why Xenomai does not disable SMIs on SCH chipset=
s?<br>In past I tried to "patch" smi.c file with SCH identifier, but latenc=
y test results make worse instead improve.<br><br>Thank you again<br>Mauro<=
br></div></body></html>
------=_Part_5_8621536.1295961457609--

