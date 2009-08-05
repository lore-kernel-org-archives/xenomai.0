MIME-Version: 1.0
Date: Wed, 5 Aug 2009 09:57:50 -0300
Message-ID: <8b216e9e0908050557s3789edcdq5b8b6b88bf52861b@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=0016e643562ceefb150470648c57
Subject: [Xenomai-help] Slow boot with Xenomai
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

--0016e643562ceefb150470648c57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
We are currently trying to install Xenomai (version 2.5rc2) on a Geode GX1
(PCM 3350 board), kernel 2.6.26 (Debian 5.0). However, we have run into a
few issues.

Whenever we install the kernel with Local APIC support enabled, xenomai
gives the error:

Xenomai: Local APIC absent or disabled!
Disable APIC support or pass "lapic=3D1" as bootparam.


Passing the lapic=3D1 parameter doesn't seem to do much, so we decided to t=
urn
off APIC support in the kernel.

The kernel now boots, however, it does so extremely slowly. It is hanging
(i.e., takes a long time) whenever an IRQ probe is required.
The latencies are also pretty bad - worst case in xeno-test is 2ms!

So, any ideias on why this is happening?

Thanks for the help,
--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/

--0016e643562ceefb150470648c57
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>We are currently trying to install Xenomai (versi=
on 2.5rc2) on a Geode GX1 (PCM 3350 board), kernel 2.6.26 (Debian 5.0). How=
ever, we have run into a few issues.</div><div><br></div><div>Whenever we i=
nstall the kernel with Local APIC support enabled, xenomai gives the error:=
</div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; "><pre style=3D"margin-top: 0em; margin-right: 0em; margin-b=
ottom: 0em; margin-left: 0em; ">Xenomai: Local APIC absent or disabled!
Disable APIC support or pass &quot;lapic=3D1&quot; as bootparam.</pre></spa=
n></div><div><br></div><div>Passing the lapic=3D1 parameter doesn&#39;t see=
m to do much, so we decided to turn off APIC support in the kernel.</div><d=
iv>
<br></div><div>The kernel now boots, however, it does so extremely slowly. =
It is hanging (i.e., takes a long time) whenever an IRQ probe is required.<=
/div><div>The latencies are also pretty bad - worst case in xeno-test is 2m=
s!</div>
<div><br></div><div>So, any ideias on why this is happening?</div><div><br>=
</div><div>Thanks for the help,</div><div>-- <br> =A0 =A0 =A0 -Felipe Brand=
=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automation Laboratory<b=
r> =A0 =A0 =A0 Department of Electrical Engineering<br>
 =A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br> =A0 =A0 =A0 <a href=
=3D"http://www.lara.unb.br/">http://www.lara.unb.br/</a><br>
</div>

--0016e643562ceefb150470648c57--

