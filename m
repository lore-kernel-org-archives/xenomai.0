Message-ID: <626948.38990.qm@domain.hid>
Date: Wed, 2 Dec 2009 10:30:03 -0800 (PST)
From: Yigal Goldberger <yigal_gold@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] serial port errors
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

Hi all,

I've been debugging this issue for days now , but can't figure it out :
My system is based on mpc8248 by freescale , and I'm using kernel 2.6.29.4 =
with Xenomai 2.4.8 . I have 2 serial devices receiving simultaneously .
When using Baudrate 115200 problems occure - I get errors in the data recei=
ved . (this doesn't happen when receiving only on one port at a time in thi=
s BAUDRATE) , but also doesn't occure when receving on both simultaneously =
on BAUDRATE- 38400 . When the error occures I get (sometimes , but not alwa=
ys - "No room in flip buffer"
and also I get error - EAGAIN=A0 from the=A0=A0=A0"nread =3D read() "=A0 fu=
nction .
And while getting EAGAIN I also get a possitive retrun value (nread) .
Ideas are welcome .

Ideas are most welcome !
Thanks,
Yigal Goldberger.

=0A=0A=0A      

