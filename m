MIME-Version: 1.0
Date: Sun, 19 Apr 2009 20:52:02 +0200
Message-ID: <b131c9f0904191152i16953fe1k3f035d19a7c606e4@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=000325574a4ed0fa610467ece873
Subject: [Xenomai-help] Xenomai v2.5-rc1 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--000325574a4ed0fa610467ece873
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

hi

Thanx for v2.5-rc1. Here are some minor observations

1. The prepare-kernel script requires --arch=x86 for an x86 32 bit platform.

--arch=i386 as per README.INSTALL section 2.1 does not seem to be allowed
anymore

(README.INSTALL updates required ?)

2. With Xenomai v2.4.x echoing the xenomai group id to
/sys/module/xeno_nucleus/parameters/xenomai_gid
allowed a Xenomai application to be run without having to type 'sudo'. Does
not work with v2.5-rc1.
Get the following message :

Xenomai: open: Permission denied
Xenomai: mmap(local sem heap): Permission denied

[Application runs normally if sudo is used]

Has this feature been removed ?

3. When running the latency test in a console window within X and the window
is maximised/minimized
the following message appears :

Not SIGSHADOW !

Latency test then continues to run normally

[This was seen with the 2.6.29.1 build. Will have to confirm if it appears
with the 2.6.28.9 build]

Hope this helps
Vicki

--000325574a4ed0fa610467ece873
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi<br><br>Thanx for v2.5-rc1. Here are some minor observations <br><br>1. T=
he prepare-kernel script requires --arch=3Dx86 for an x86 32 bit platform.<=
br><br>--arch=3Di386 as per README.INSTALL section 2.1 does not seem to be =
allowed anymore<br>
<br>(README.INSTALL updates required ?)<br><br>2. With Xenomai v2.4.x echoi=
ng the xenomai group id to /sys/module/xeno_nucleus/parameters/xenomai_gid =
<br>allowed a Xenomai application to be run without having to type &#39;sud=
o&#39;. Does not work with v2.5-rc1.<br>
Get the following message :<br><br>Xenomai: open: Permission denied<br>Xeno=
mai: mmap(local sem heap): Permission denied<br><br>[Application runs norma=
lly if sudo is used]<br><br>Has this feature been removed ?<br><br>3. When =
running the latency test in a console window within X and the window is max=
imised/minimized<br>
the following message appears :<br><br>Not SIGSHADOW !<br><br>Latency test =
then continues to run normally<br><br>[This was seen with the 2.6.29.1 buil=
d. Will have to confirm if it appears with the 2.6.28.9 build]<br><br>Hope =
this helps<br>
Vicki<br><br><br><br>

--000325574a4ed0fa610467ece873--

