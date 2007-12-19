Message-ID: <5864711.1198077318353.JavaMail.ngmail@domain.hid>
Date: Wed, 19 Dec 2007 16:15:18 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] /proc/xenomai/affinity and T_CPU(n) in rt_task_create
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

Hi everybody,

I am currently evaluating the latest Xenomai release 2.4.0 on a Dual Core P=
entium 4 using
the 2.6.23 kernel and also the latest rtnet 0.9.10-rc1.
I have one question concerning the relation of the /proc/xenomai/affinity e=
ntry and the parameter
T_CPU(n) I pass with rt_task_create (native API).
If I set /proc/xenomai/affinity to 1 (which means to run all real time task=
s on CPU 0). I am not allowed
to pass T_CPU(1) with rt_task_create. rt_task_start returns with a -EINVAL.

Background for my question is:
rtnet uses a internal system task For this task I cannot pass the CPU I wan=
t to run this CPU on.
My idea is now to set /proc/xenomai/affinity to 1 which means (in my mind) =
that all tasks that do
not have specified explicitly a task number (T_CPU(n)) will run on the CPU(=
s) specified by /proc/xenomai/affinity.
All those tasks that specify T_CPU explicitly will run on the specified CPU=
, no matter what value=20
/proc/xenomai/affinity is.
However, this seems not to work.

I want to run rtnet on CPU 0 and my own code on CPU 1. For this I write 1 t=
o /proc/xenomai/affinity and=20
pass T_CPU(1) with all my calls to rt_task_create. However, these tasks ret=
urn with -EINVAL.
I debugged into Xenomai and found out that is caused in xnpod_start_thread(=
) at the condition
if (xnarch_cpus_empty(thread->affinity)) ...

When I write 3 to /proc/xenomai/affinity my tasks start fine, however I hav=
e now no control of the
CPU placement of the rtnet system task.


Any hints on that are highly welcome.

=20
Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  29,95 Euro  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2

