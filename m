MIME-Version: 1.0
Date: Mon, 13 Sep 2010 10:06:29 +0200
Message-ID: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba8e4d1ae22e6704901f9285
Subject: [Xenomai-help] rt_queue_read and EPERM?
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

--90e6ba8e4d1ae22e6704901f9285
Content-Type: text/plain; charset=ISO-8859-1

Hello
I am try to use a RT_QUEUE. I am writing messages with rt_queue_write to the
queue. But when function rt_queue_read is called result is always  "-1".

"-1" means EPERM. What means exactly: "EEPERM is returned if this service
should block"? I don't understand why a function should block to get a
message from a queue!?

Thanks and regards,
Jens,

--90e6ba8e4d1ae22e6704901f9285
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hello</p>
<div>I am try to use a RT_QUEUE. I am writing messages with r<font face=3D"=
Helv" size=3D"2"><font face=3D"Helv" size=3D"2">t_queue_write to the queue.=
 But=A0when function=A0<font face=3D"Helv" size=3D"2"><font face=3D"Helv" s=
ize=3D"2">rt_queue_read is called result is=A0always=A0 &quot;-1&quot;.</fo=
nt></font></font></font></div>

<div><font face=3D"Helv"></font>=A0</div>
<div><font face=3D"Helv">&quot;-1&quot; means </font><font face=3D"Helv">EP=
ERM. What means exactly:=A0&quot;EEPERM is returned if this service should =
block&quot;? I don&#39;t understand why a function should block to get a me=
ssage from a queue!?</font></div>

<div><font face=3D"Helv"></font>=A0</div>
<div>Thanks and regards,</div>
<div>Jens,</div>

--90e6ba8e4d1ae22e6704901f9285--

