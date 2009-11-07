MIME-Version: 1.0
Sender: lcasassa@domain.hid
From: Linus Casassa <linus@domain.hid>
Date: Sat, 7 Nov 2009 12:04:29 -0300
Message-ID: <47a3101a0911070704o5307a23dhef368d04cc25fc6@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd1b4302077c30477c948a2
Subject: [Xenomai-help] Gumstix arm pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--000e0cd1b4302077c30477c948a2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.

What is the minimum time I can get in a periodic task? My board has an arm
pxa 400 MHz processor.

I ask because I can't get less time than 200 ms. If I try 10 ms the system
hangs and I have to restart the board. I notice that 200 ms are 200 ticks.
Is there a way to obtain 1 ms periodic task?


The periodic task flips the state of a GIPO so I can measure the accuracy o=
f
the periodic task. I noticed that when the system hangs the GPIO continues
flipping his state but with a period of 33us when it should be 10ms for
example.

I am using xenomai 2.9.1 with kernel 2.6.24.

Any suggestions?

Thanks.

--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd1b4302077c30477c948a2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi.</div>
<div>=A0</div>
<div>What is the minimum time I can get in a periodic task? My board has=A0=
an arm pxa 400 MHz processor. </div>
<div>=A0</div>
<div>I ask because I can&#39;t get less time than 200 ms. If I try 10 ms th=
e system hangs and I have to restart the board. I notice that 200 ms are 20=
0 ticks.<br>Is there a way to obtain 1 ms periodic task? </div>
<div>=A0</div>
<div>=A0</div>
<div>The periodic task flips the state of a GIPO so I can measure the accur=
acy of the periodic task. I noticed that when the system hangs the GPIO con=
tinues flipping his state but with a period of 33us when it should be 10ms =
for example.</div>


<div>=A0</div>
<div>I am using xenomai 2.9.1 with kernel 2.6.24.</div>
<div>=A0</div>
<div>Any suggestions?</div>
<div>=A0</div>
<div>Thanks.</div>
<div>=A0</div>
<div>-- <br>Linus Casassa<br>Estudiante Ingenier=EDa Civil Electr=F3nica<br=
>Fono: 56-9-97776941<br></div>

--000e0cd1b4302077c30477c948a2--

