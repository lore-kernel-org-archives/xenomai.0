Message-ID: <13529671.1166621136153.JavaMail.ngmail@domain.hid>
Date: Wed, 20 Dec 2006 14:25:36 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4587E404.2050101@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_41146_11724861.1166621136152"
References: <4587E404.2050101@domain.hid> <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] A fairly small rtnet/Xenomai application that
	freezes the PC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

------=_Part_41146_11724861.1166621136152
Content-Type: multipart/alternative; 
	boundary="----=_Part_41145_25172011.1166621136152"

------=_Part_41145_25172011.1166621136152
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan and Gilles,

after a long debug-reboot-try-again-session I was able to reduce the proble=
m I had
to a very short application that leads to a complete system freeze on a 2.6=
.19.1 kernel.
As with my PC I am not able to run the NMI stuff within Xenomai, I forward =
the application to you
and the list. Perhaps somebody can try out the enclosed application with th=
e latest Xenomai version
on 2.6.19.1.
Please adjust the IP settings in the C file and in the xenorun script to yo=
ur setup.
It is sufficient to send out UDP frames, if the remote device does not answ=
er this does not hurt.
However the remote device should listen on a specified port to avoid ICMP c=
omplains about
no-opened UDP ports...
Using Ethereal I monitored the traffic.
Here is the summary of it:
ARP request/response (from the xenorun script)
ARP request/response (from the applicaion)
UDP message to port 18765 (no answer)
2 seconds later: UDP message to port 18765 (no answer)
2+5=3D7 seconds later: ARP request/response (from the application)
2 seconds later: UDP message to port 18765
Here the system freezes. I do not see the message "Step A".

One important piece is the system() call out of the realtime application to=
 do a rtroute.
When I remove this call, there is no error...


I am using Xenomai SVN #1969 and the included 2.6.19.1 patch. Pentium 4 UP.

Any feedback on this is highly welcome!

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
------=_Part_41145_25172011.1166621136152--

------=_Part_41146_11724861.1166621136152
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=rtnet_crashtest.tgz

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
6UHbIAAoAAA=
------=_Part_41146_11724861.1166621136152--


