Message-ID: <13096879.1164184060512.JavaMail.ngmail@domain.hid>
Date: Wed, 22 Nov 2006 09:27:40 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Limiting Xenomai tasks to one certain core in a dual
	core system
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

I want to run Xenomai and rtnet (using RTDM) on a dual core CPU.
Using the kernel parameter isolcpus I can force the standard Linux tasks
to run on one of the cores.
The other core should be used exclusively by all real time tasks (including=
 rtnet).
I can - of course - pass a parameter on each rt_task_create() call.
However how can I force rtnet (using RTDM) to run on this CPU core?
Is there a possibility to mask the CPUs to be used globally?
This could also avoid to pass the CPU number with each rt_task_create() cal=
l.

Thanks for any feedback on this.

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

