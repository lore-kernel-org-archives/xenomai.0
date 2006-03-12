Message-ID: <fd6a47a90603120709k2dcc2a4h@domain.hid>
Date: Sun, 12 Mar 2006 16:09:24 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24689_26580177.1142176164574"
Subject: [Xenomai-core] PRNG not seeded on AMD K7
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_24689_26580177.1142176164574
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When I try to open an ssh connection to or from a PC running Xenomai, I get
a 'PRNG not seeded' error. However, it only occurs when an RT application i=
s
running (such as 'latency'). The computer on which this occurs is an AMD
K7-650. I've tested on a Pentium III 500 as well (nearly same .config) and
this error doesn't show up then.

Any idea of where I should start debugging ? I assume that PRNG stands
for 'Programmable Random Number Generator' or something like that.

Jeroen.

------=_Part_24689_26580177.1142176164574
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>When I try to open an ssh connection to or from a PC running Xenomai, =
I get a&nbsp;'PRNG not seeded' error. However, it only occurs when an RT ap=
plication is running (such as 'latency'). The computer on which this occurs=
 is an AMD K7-650. I've tested on a Pentium III 500 as well (nearly same .c=
onfig) and this error doesn't show up then.
</div>
<div>&nbsp;</div>
<div>Any idea of where I should start debugging ? I assume that PRNG stands=
 for&nbsp;'Programmable Random Number Generator' or something like that.</d=
iv>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>

------=_Part_24689_26580177.1142176164574--

