MIME-Version: 1.0
From: Ashish Budhiraja <ashishmach@domain.hid>
Date: Fri, 8 Jul 2011 14:10:00 +0200
Message-ID: <CAG1VJdr9-_WbBTg+L7tAT8+aGOM7oH844F3NfcRmQrHLcCvpAw@domain.hid>
Content-Type: multipart/alternative; boundary=002215b033aed5804804a78db825
Subject: [Xenomai-help] Compiling Library files over Xenomai
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

--002215b033aed5804804a78db825
Content-Type: text/plain; charset=ISO-8859-1

Hello Everyone,

I am using Roboard (RB-100) on which I have Xenomai installed. All the
example files are working fine and
I have internet through wifi and lan both.


Roboard comes with normal C & C++&header files in a folder called
roboard_lib. These files are for IO, pwm, spi, i2c etc....Actually I am
having trouble with compiling and linking the roboard_lib files.

 If anyone can help me to edit makefile to compile a library please reply.
Because I tried a lot with the makefile available with examples files, but
couldn't succeed.

The errors which I am getting:

1) I think somehow my gcc doesn't accept "bool" so I had to include
stdbool.h,,,it works now.
2) I am getting errors like *undefined reference to "SOMEfunction" *...this
I think this is because my library files are not compiling.

Thanks a lot ,,,,please guide me through this....if someone can show me
their MAKEFILE(with library compiled) it would be a great help.

Regards,

Ashish

--002215b033aed5804804a78db825
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Everyone,<br><br>I am using Roboard (RB-100) on which I have Xenomai =
installed. All the example files are working fine and <br>I have internet t=
hrough wifi and lan both.<br><br><br>Roboard comes with normal C &amp; C++&=
amp;header files in a folder called roboard_lib. These files are for IO, pw=
m, spi, i2c etc....Actually I am having trouble with compiling and linking =
the roboard_lib files.<br>

<br>=A0If anyone can help me to edit makefile to compile a library please r=
eply. Because I tried a lot with the makefile available with examples files=
, but=A0 couldn&#39;t succeed.<br><br>The errors which I am getting:<br><br=
>

1) I think somehow my gcc doesn&#39;t accept &quot;bool&quot; so I had to i=
nclude stdbool.h,,,it works now.<br>2) I am getting errors like <b>undefine=
d reference to &quot;SOMEfunction&quot; </b>...this I think this is because=
 my library files are not compiling.<br>

<br>Thanks a lot ,,,,please guide me through this....if someone can show me=
 their MAKEFILE(with library compiled) it would be a great help.<br><br>Reg=
ards,<br><br>Ashish <br><br>

--002215b033aed5804804a78db825--

