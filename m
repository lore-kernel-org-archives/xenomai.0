Message-ID: <26440461.1166445600596.JavaMail.ngmail@domain.hid>
Date: Mon, 18 Dec 2006 13:40:00 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] rtnet / Xenomai: Kernel 2.6.19.1 hangs,
	2.6.17.7 works
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtnet-users@domain.hid, xenomai@xenomai.org

Hi rtnet and Xenomai users,

I have an issue with the latest Xenomai (svn #1962) and rtnet (svn #1095) v=
ersions
using kernel 2.6.19.1. The very same application worked fine on 2.6.17.7 (s=
ame Xenomai/rtnet).
My application does the following steps in user space:
1) I open one UDP socket to an embedded device.
2) The timeout of the socket is set to 5 seconds.
3) I send out one UDP message A via rt_dev_send() to the device.
4) Then I wait for the response for A in rt_dev_recv()
5) Directly after the return of rt_dev_recv() I send  message B via rt_dev_=
send()
6) Then I wait for the response for B in rt_dev_recv()
Here my PC freezes. I am no longer able to access it, I have to press the r=
eset button on the PC.

I have connected the PC and the embedded device with a hub. This allows me =
to monitor the network
traffic using a second PC. Ethereal shows me, that message B is sent to the=
 embedded device
and the response of B is sent back to the PC.

Whenever I place a printf() directly after the rt_dev_recv() statements to =
see what happens,
everything works fine and the PC no longer freezes.

As mentioned above, when I use the very same application with 2.6.17.7 (sam=
e Xenomai, rtnet version)
everything is perfect!
I have a Pentium 4 Dual core, SMP enabled.

Any idea on this strange behaviour?

Thanks for any feedback

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

