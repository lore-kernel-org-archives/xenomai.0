MIME-Version: 1.0
Sender: manuel.vonthron@domain.hid
From: Manuel Vonthron <manuel.vonthron@domain.hid>
Date: Wed, 18 Jan 2012 16:09:02 -0500
Message-ID: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3079ba56ac3a9d04b6d3dc65
Subject: [Xenomai-help] "Inappropriate ioctl for device" with xeno_16550A on
 Xenomai 2.6, not Xenomai 2.5
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

--20cf3079ba56ac3a9d04b6d3dc65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,

I am using the driver "xeno_16550A" for serial communication between a
powersupply and its controlling PC (x86). I started working with Xenomai
2.5.5, but I recently switched to another machine where I installed Xenomai
2.6.

On this new machine, I get the "Inappropriate ioctl for device" error while
setting up my serial connection:
  err =3D rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
  >> error -25: Inappropriate ioctl for device
The following reads/writes don't fail but without proper configuration,
messages aren't understood by the device.

My tests with non-RT code and the regular Linux driver keeps working with
this new machine and again, the RT code is the very same, I only updated my
Makefile to match the new version.

- setserial infos:
  /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal
skip_test
- xeno_16550A loaded with:
  `modprobe -v xeno_16550A io=3D0x03f8 irq=3D4 baud_base=3D115200`
- result of "rtdm" unit test:
  SetupExclusive openSuccessive openDefer close by driver handlerDefer
close by pending referenceNormal closeDeferred module unload#

Do you have any idea where the error comes from and how would I fix it?


Thanks,
Manuel



--=20
Manuel Vonthron
Laboratoire de Nanorobotique
=C9cole Polytechnique de Montr=E9al
Montr=E9al, QC
http://nano.polymtl.ca/

--20cf3079ba56ac3a9d04b6d3dc65
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>I am using the driver &quot;xeno_16550A&quot; for serial c=
ommunication between a powersupply and its controlling PC (x86). I started =
working with Xenomai 2.5.5, but I recently switched to another machine wher=
e I installed Xenomai 2.6.<br>

<br>On this new machine, I get the &quot;Inappropriate ioctl for device&quo=
t; error while setting up my serial connection:<br>=A0 err =3D rt_dev_ioctl=
(fd, RTSER_RTIOC_SET_CONFIG, &amp;serial_config);<br>=A0 &gt;&gt; error -25=
: Inappropriate ioctl for device<br>

The following reads/writes don&#39;t fail but without proper configuration,=
 messages aren&#39;t understood by the device.<br><br>My tests with non-RT =
code and the regular Linux driver keeps working with this new machine and a=
gain, the RT code is the very same, I only updated my Makefile to match the=
 new version. <br>

<br>- setserial infos:<br>=A0 /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud=
_base 115200 spd_normal skip_test<br>- xeno_16550A loaded with:<br>=A0 `mod=
probe -v xeno_16550A io=3D0x03f8 irq=3D4 baud_base=3D115200`<br>- result of=
 &quot;rtdm&quot; unit test:<br>

=A0 SetupExclusive openSuccessive openDefer close by driver handlerDefer cl=
ose by pending referenceNormal closeDeferred module unload#<br><br>Do you h=
ave any idea where the error comes from and how would I fix it?<br><br><br>

Thanks,<br>Manuel<br><br><br clear=3D"all"><br>-- <br>Manuel Vonthron<br>La=
boratoire de Nanorobotique<br>=C9cole Polytechnique de Montr=E9al<br>Montr=
=E9al, QC<br><a href=3D"http://nano.polymtl.ca/" target=3D"_blank">http://n=
ano.polymtl.ca/</a><br>




--20cf3079ba56ac3a9d04b6d3dc65--

