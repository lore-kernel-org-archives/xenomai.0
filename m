MIME-Version: 1.0
Date: Mon, 11 Jan 2010 23:10:15 +0530
Message-ID: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64cb432bcf5c9047ce707b3
Subject: [Xenomai-help] Xenomai not booting on a dell server
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

--0016e64cb432bcf5c9047ce707b3
Content-Type: text/plain; charset=ISO-8859-1

Hi,

      I am trying to install xenomai on a Dell Poweredge server (R710).The
platform details are given below:

Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16 GB,uses SAS
disks through a SAS Host Bus Adapter(HBA).

Drivers for this HBA only available from fedora 10 onwards.

So I patched xenomai  2.4.10 with linux 2.6.29.4 with fedora 11 as the host
OS.I used fedora 11 config file.I made the following changes to the config
file

1.In processor types and features: architecture->Core2/Newer Xeon,
subarchitecture->Generic, thermal throttling disabled,HPET support enabled

2.Power management stopped.

3.Support for PCI hotplug disabled.

4.MSI,MSI-X disabled.

5.In real time subsystem all options selected.

6.SMP support enabled

7.MTD support disabled

8.All other default options.

After making and installing the modules ,when i selected the xenomai kernel
on rebooting it didnt boot at all.There was just a blinking cursor on the
screen.

I referred to the following documents while installing

http://download.intel.com/design/intarch/papers/322386.pdf

http://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pdf<http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf>

http://www.lara.ene.unb.br/~phsantana/files/technotes/HowTo_Debian_Embedded.pdf<http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf>


I would love any suggestions and help in this regard.

Thanking you in advance.

With Regards,

S Saravanan

--0016e64cb432bcf5c9047ce707b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>=A0=A0=A0=A0=A0 I am trying to install xenomai on a Dell Powered=
ge server (R710).The platform details are given below:<br><br>Two quad Inte=
l(8 cores) Xeon E5506@domain.hid 6,RAM-16 GB,uses SAS disks through=
 a SAS Host Bus Adapter(HBA).<br>
<br>Drivers for this HBA only available from fedora 10 onwards.<br><br>So I=
 patched xenomai=A0 2.4.10 with linux 2.6.29.4 with fedora 11 as the host O=
S.I used fedora 11 config file.I made the following changes to the config f=
ile<br>
<br>1.In processor types and features: architecture-&gt;Core2/Newer Xeon, s=
ubarchitecture-&gt;Generic, thermal throttling disabled,HPET support enable=
d<br><br>2.Power management stopped.<br><br>3.Support for PCI hotplug disab=
led.<br>
<br>4.MSI,MSI-X disabled.<br><br>5.In real time subsystem all options selec=
ted.<br><br>6.SMP support enabled<br><br>7.MTD support disabled<br><br>8.Al=
l other default options.<br><br>After making and installing the modules ,wh=
en i selected the xenomai kernel on rebooting it didnt boot at all.There wa=
s just a blinking cursor on the screen.<br>
<br>I referred to the following documents while installing <br><cite><br><a=
 href=3D"http://download.intel.com/design/intarch/papers/322386.pdf">http:/=
/download.intel.com/design/intarch/papers/322386.pdf</a><br><br><a href=3D"=
http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf">h=
ttp://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pdf</a><b=
r>
<br><a href=3D"http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowT=
o_Debian_Embedded.pdf">http://www.lara.ene.unb.br/~phsantana/files/technote=
s/HowTo_Debian_Embedded.pdf</a><br><br><br>I would love any suggestions and=
 help in this regard.<br>
<br>Thanking you in advance.<br><br>With Regards,<br><br>S Saravanan<br><br=
><br><br><br><br><br><br><br><br></cite>

--0016e64cb432bcf5c9047ce707b3--

