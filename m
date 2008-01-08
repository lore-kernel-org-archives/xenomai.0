Message-ID: <14854214.1199776626079.JavaMail.ngmail@domain.hid>
Date: Tue, 8 Jan 2008 08:17:06 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] posix functions for real time and non real time
	threads
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

Hi everybody,

I have a fairly huge application that consists of several real time threads=
 and several non real time (posix) threads.
For the non real time threads I use the pthread_create function and e.g. th=
e pthread_mutex_lock/unlock functions to
synchronize them.
Is it possible to use the Xenomai Posix skin for real time threads as well?
When linking against pthread_rt and pthread I have two "variants" of e.g. p=
thread_create. One to be used for real
time threads and one for the non real time threads. How are they distinguis=
hed?
How can I define to create a real time task using pthread_create and how ca=
n I define to create a non real time task
using pthread_create.

Thanks for any hints on that issue.

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

