MIME-Version: 1.0
Sender: lcasassa@domain.hid
From: Linus Casassa <linus@domain.hid>
Date: Fri, 2 Oct 2009 20:28:00 -0400
Message-ID: <47a3101a0910021728p63da56f7g59edabc521cc4dfe@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd2960022529d0474fcf5db
Subject: [Xenomai-help] Xenomai on gumstix
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

--000e0cd2960022529d0474fcf5db
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It works!

But I notice that the frequency is bad configured.

I am using the trivial-periodic example.
http://www.xenomai.org/documentation/xenomai-2.4/html/api/trivial-periodic_=
8c-example.html

I had to change
rt_task_set_periodic(NULL, TM_NOW, 1000000000);
to
rt_task_set_periodic(NULL, TM_NOW, 1000);
to get 1 second.

How can I fix this?

I have a gumstix verdex pro:
Marvell PXA270 with XScale
Speed: 400MHz

PD: The more I go into xenomai the more I like it! Thanks for the wonderful
invention!

--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd2960022529d0474fcf5db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It works!<br><br>But I notice that the frequency is bad configured.<br><br>=
I am using the trivial-periodic example.<br><a href=3D"http://www.xenomai.o=
rg/documentation/xenomai-2.4/html/api/trivial-periodic_8c-example.html">htt=
p://www.xenomai.org/documentation/xenomai-2.4/html/api/trivial-periodic_8c-=
example.html</a><br>

<br>I had to change<br>rt_task_set_periodic(NULL, TM_NOW, 1000000000);<br>t=
o<br>rt_task_set_periodic(NULL, TM_NOW, 1000);<br>to get 1 second.<br><br>H=
ow can I fix this?<br><br>I have a gumstix verdex pro:<br clear=3D"all">
Marvell PXA270 with XScale<br>
Speed: 400MHz<br><br>PD: The more I go into xenomai the more I like it! Tha=
nks for the wonderful invention!<br><br>-- <br>Linus Casassa<br>Estudiante =
Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd2960022529d0474fcf5db--

