MIME-Version: 1.0
Date: Fri, 10 Jun 2011 15:48:43 +0200
Message-ID: <BANLkTi=hBWZO5ngeXbPHELnYW9ofD7OuNg@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5016697fcd27604a55bd3fb
Subject: [Xenomai-help] --enable-arm-mach=omap4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec5016697fcd27604a55bd3fb
Content-Type: text/plain; charset=ISO-8859-1

Dear Giles,

I done according to the documentation mentioned in readme.install (building
for arm)

passing --enable-arm-mach=omap4 but i got below error

checking for ARM machine... configure: error: Invalid machine selected:
"omap4"

as you mentioned , Once  kernel was prepared i cant configure pass omap3 .
But how to pass --enable-arm-mach=omap4  then?

during xenomai/scripts/prepare-kernel.sh    we are just giving arch=arm

-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec5016697fcd27604a55bd3fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Giles,<div><br></div><div>I done according to the doc=
umentation mentioned in readme.install (building for arm)<br clear=3D"all">=
<br>passing --enable-arm-mach=3Domap4 but i got below error</div><div><br><=
/div>
<div>checking for ARM machine... configure: error: Invalid machine selected=
: &quot;omap4&quot;</div><div><br></div><div><meta http-equiv=3D"content-ty=
pe" content=3D"text/html; charset=3Dutf-8">as you mentioned , Once =A0kerne=
l was prepared i cant configure pass omap3 . But how to pass --enable-arm-m=
ach=3Domap4 =A0then?</div>
<div><br></div><div>during xenomai/scripts/prepare-kernel.sh =A0 =A0we are =
just giving arch=3Darm=A0</div><div>=A0</div><div>-- <br><br>Suresh balijep=
alli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec5016697fcd27604a55bd3fb--

