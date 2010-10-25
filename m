MIME-Version: 1.0
Date: Tue, 26 Oct 2010 02:49:03 +0530
Message-ID: <AANLkTin30_=udvCD6D87cV4yqYoMt+BMTo4is8COdv_f@domain.hid>
From: Peter Warner <xenomai.start@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd25856a961e80493778ae4
Subject: [Xenomai-help] Serial Driver for PCI Card
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

--000e0cd25856a961e80493778ae4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have two serial ports in my system one is generic and another one is on
add-on cards(PCI).
I compiled the xenomai serial driver as a module and when I am trying to
load it using the following command:

modprobe xeno_16550A io=0x3f8, 0x2f8 irq=4,3 baud_base=115200,115200

then I am getting the error message unknown symbol in object for more
information type dmesg.  when I am typing dmesg I am getting the message
unknown identifier "io".

Can anyone suggest what are the steps to be taken or to modify the driver
for the extended serial port.  or Else I have the linux driver for it
provided by the vendor Is there any way that it can be made to xenomai
complaint. If it can be done then please suggest what are the steps to be
taken.

Bye Bye

-- 
Regards,
peter

--000e0cd25856a961e80493778ae4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have two serial ports in my system one is generic and another =
one is on add-on cards(PCI). <br>I compiled the xenomai serial driver as a =
module and when I am trying to load it using the following command:<br><br>
modprobe xeno_16550A io=3D0x3f8, 0x2f8 irq=3D4,3 baud_base=3D115200,115200<=
br><br>then I am getting the error message unknown symbol in object for mor=
e information type dmesg.=A0 when I am typing dmesg I am getting the messag=
e=A0 unknown identifier &quot;io&quot;.<br>
<br>Can anyone suggest what are the steps to be taken or to modify the driv=
er for the extended serial port.=A0 or Else I have the linux driver for it =
provided by the vendor Is there any way that it can be made to xenomai comp=
laint. If it can be done then please suggest what are the steps to be taken=
.<br>
<br>Bye Bye<br clear=3D"all"><br>-- <br>Regards,<br>peter<br><br>

--000e0cd25856a961e80493778ae4--

