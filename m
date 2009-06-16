MIME-Version: 1.0
Date: Tue, 16 Jun 2009 18:10:20 +0300
Message-ID: <9c789a000906160810s77ceb784xb3a0d8320d210a7c@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001485f423dcdca24c046c78929b
Subject: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, Alexis Berlemont <alexis.berlemont@domain.hid>, xenomai@xenomai.org

--001485f423dcdca24c046c78929b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi !
I've got a snapshot of the current git update but I still receive some
errors! Now the kernel is stable and doesn't crashes anymore but it seems
that there is a problem with attaching a driver !

Here's the output !

/usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
PCI: Unable to reserve mem region #1:1000@domain.hid for device 0000:00:10.0
Comedi: comedi_pcimio: pcmio_attach: error setting up mite
Comedi: comedi_assign_driver: call(drv->attach) failed (ret=-5)
comedi_config: comedi_snd_attach failed ret=-5


THe fake and the loop drivers are attaching properly !

Best !

--001485f423dcdca24c046c78929b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi !<br>I&#39;ve got a snapshot of the current git update but I still recei=
ve some errors! Now the kernel is stable and doesn&#39;t crashes anymore bu=
t it seems that there is a problem with attaching a driver !<br><br>Here&#3=
9;s the output !<br>
<br>/usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio=A0=A0 <br>PCI=
: Unable to reserve mem region #1:1000@domain.hid for device 0000:00:10.0<br>=
Comedi: comedi_pcimio: pcmio_attach: error setting up mite<br>Comedi: comed=
i_assign_driver: call(drv-&gt;attach) failed (ret=3D-5)<br>
comedi_config: comedi_snd_attach failed ret=3D-5<br><br><br>THe fake and th=
e loop drivers are attaching properly !<br><br>Best !<br>

--001485f423dcdca24c046c78929b--

