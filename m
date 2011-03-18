MIME-Version: 1.0
Date: Fri, 18 Mar 2011 12:48:39 +0100
Message-ID: <AANLkTi=G7sEYAqMKS+PEaDgH2q=d-h=_wsoCkFZLLAip@domain.hid>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd56612e40300049ec05b75
Subject: [Xenomai-help] Xenomai and select() function - don't work correctly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd56612e40300049ec05b75
Content-Type: text/plain; charset=ISO-8859-1

Hello,

on my atom processor based computer is Xenomai installed. (Kernel 2.6.26,
1000Hz, Xenomai 2.4.10, PREEMPT patch, no xenomai application running).

A normal linux application reads serial data from an UART
(16550A) and checks by select() function if there are new received
bytes. Select() has a timeout parameter, set to 12 milliseconds. Some times
it happens that select() waits 43 ms instead of maximum 12 ms. Result value
of select() is timeout instead of "byte received". Could this caused by
Xenomai? How could I improve it?

Thanks and regards,
Jens

--000e0cd56612e40300049ec05b75
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>
<div>=A0</div>
<div>on my atom processor based computer is Xenomai installed. (Kernel 2.6.=
26, 1000Hz, Xenomai 2.4.10, PREEMPT patch,=A0no xenomai application running=
).</div>
<div>=A0</div>
<div>A=A0normal linux application reads serial data from an UART (16550A)=
=A0and=A0checks by select() function if there are new received bytes.=A0Sel=
ect() has a timeout parameter, set to 12 milliseconds. Some times it happen=
s that select() waits 43 ms instead of maximum 12 ms.=A0Result value of sel=
ect() is timeout instead of &quot;byte received&quot;. Could=A0this caused =
by Xenomai?=A0How could I improve it?</div>

<div>=A0<br>Thanks and regards,<br>Jens</div>

--000e0cd56612e40300049ec05b75--

