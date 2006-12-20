Message-ID: <31078593.1166623877982.JavaMail.ngmail@domain.hid>
Date: Wed, 20 Dec 2006 15:11:17 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <45894179.8060805@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43953_1818513.1166623877980"
References: <45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Aw: Re: A fairly small rtnet/Xenomai application
 that freezes the PC
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

------=_Part_43953_1818513.1166623877980
Content-Type: multipart/alternative; 
	boundary="----=_Part_43952_23807843.1166623877980"

------=_Part_43952_23807843.1166623877980
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan,

enclosed is the ethereal dump file.
Unfortunately I do not have a slow machine... (We try to get the fastest ma=
chines running...).

Thanks for checking the application.

Mathias
> > after a long debug-reboot-try-again-session I was able to reduce the
> problem I had
> > to a very short application that leads to a complete system freeze on a
> 2.6.19.1 kernel.
> > As with my PC I am not able to run the NMI stuff within Xenomai, I forw=
ard
> the application to you
> > and the list. Perhaps somebody can try out the enclosed application wit=
h
> the latest Xenomai version
> > on 2.6.19.1.
>=20
> Thanks for the test case, I will give this a try ASAP.
>=20
> > Please adjust the IP settings in the C file and in the xenorun script t=
o
> your setup.
> > It is sufficient to send out UDP frames, if the remote device does not
> answer this does not hurt.
> > However the remote device should listen on a specified port to avoid IC=
MP
> complains about
> > no-opened UDP ports...
> > Using Ethereal I monitored the traffic.
> > Here is the summary of it:
> > ARP request/response (from the xenorun script)
> > ARP request/response (from the applicaion)
> > UDP message to port 18765 (no answer)
> > 2 seconds later: UDP message to port 18765 (no answer)
> > 2+5=3D7 seconds later: ARP request/response (from the application)
> > 2 seconds later: UDP message to port 18765
> > Here the system freezes. I do not see the message "Step A".
>=20
> Could you set me the Ethereal dump for reference? Just in case the test
> does not kick immediately for me and I need to check the event flow.
>=20
> >=20
> > One important piece is the system() call out of the realtime applicatio=
n
> to do a rtroute.
> > When I remove this call, there is no error...
> >=20
> >=20
> > I am using Xenomai SVN #1969 and the included 2.6.19.1 patch. Pentium 4
> UP.
>=20
> Do you have a different (slower) execution platform at hand to check if
> the CPU speed as influence on the lock-up? I hope it is not the case -
> makes tracking easier. But it wouldn't be the first time.
>=20
> >=20
> > Any feedback on this is highly welcome!
> >=20
>=20
> You will get it.
>=20
> Thanks again,
> Jan
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_43952_23807843.1166623877980--

------=_Part_43953_1818513.1166623877980
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=rtnet_crashtest.tcpdump

1MOyoQIABAAAAAAAAAAAAP//AAABAAAAdzWJRcunCwA8AAAAPAAAAP///////wAwSFr5CwgGAAEI
AAYEAAEAMEha+QvAqCjxAAAAAAAAwKgoCwAAAAAAAAAAAAAAAAAAAAAAAHc1iUWkqAsAPAAAADwA
AAAAMEha+QsAYDQAMe8IBgABCAAGBAACAGA0ADHvwKgoCwAwSFr5C8CoKPEAAAAAAAAAAAAAAAAA
AAAAAAB4NYlFgs8LADwAAAA8AAAA////////ADBIWvkLCAYAAQgABgQAAQAwSFr5C8CoKPEAAAAA
AADAqCgLAAAAAAAAAAAAAAAAAAAAAAAAeDWJRU7QCwA8AAAAPAAAAAAwSFr5CwBgNAAx7wgGAAEI
AAYEAAIAYDQAMe/AqCgLADBIWvkLwKgo8QAAAAAAAAAAAAAAAAAAAAAAAHk1iUUU5AsAPgAAAD4A
AAAAYDQAMe8AMEha+QsIAEUAADAAAEAA/xGpb8CoKPHAqCgLJxBJTQAcvQsAAAAAAAAAAAAAAAAA
AAAAAAAAAHs1iUXT5AsAPgAAAD4AAAAAYDQAMe8AMEha+QsIAEUAADAAAUAA/xGpbsCoKPHAqCgL
JxBJTQAcvQsAAAAAAAAAAAAAAAAAAAAAAAAAAII1iUXk+QsAPAAAADwAAAD///////8AMEha+QsI
BgABCAAGBAABADBIWvkLwKgo8QAAAAAAAMCoKAsAAAAAAAAAAAAAAAAAAAAAAACCNYlF7/oLADwA
AAA8AAAAADBIWvkLAGA0ADHvCAYAAQgABgQAAgBgNAAx78CoKAsAMEha+QvAqCjxAAAAAAAAAAAA
AAAAAAAAAAAAhDWJRU4jDAA+AAAAPgAAAABgNAAx7wAwSFr5CwgARQAAMAACQAD/EaltwKgo8cCo
KAsnEElNABy9CwAAAAAAAAAAAAAAAAAAAAAAAAAA
------=_Part_43953_1818513.1166623877980--


