Message-ID: <29451992.1164376099993.JavaMail.ngmail@domain.hid>
Date: Fri, 24 Nov 2006 14:48:19 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Strange SIGXCPU signal at rt_task_trampoline
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

I have the strange effect, that I get a reproducable SIGXCPU signal in gdb=
=20
when running my Xenomai (native skin) application.
It occurs in rt_task_trampoline() within the do..while loop.
The situation is that I am re-creating and starting a task that has been=20
terminated before.
Unfortunately I was not able to create a very simple application that shows=
 this
effect.
I am using xenomai (SVN 1882), Pentium 4, gcc 4.1.2
I have enclosed the output of the gdb session:

---------- GDB START ------------
[Thread debugging using libthread_db enabled]
[New Thread -1215682880 (LWP 3132)]
[New Thread -1215687504 (LWP 3135)]
[New Thread -1219687504 (LWP 3138)]
[New Thread -1219822672 (LWP 3160)]
[New Thread -1219957840 (LWP 3161)]
[New Thread -1220093008 (LWP 3162)]
[New Thread -1220228176 (LWP 3163)]
[New Thread -1220363344 (LWP 3164)]
[New Thread -1220498512 (LWP 3165)]
[New Thread -1220633680 (LWP 3166)]
[Thread -1220633680 (zombie) exited]
[Thread -1220363344 (zombie) exited]
[Thread -1220228176 (zombie) exited]
[Thread -1219957840 (zombie) exited]
[Thread -1219822672 (zombie) exited]
[Thread -1220093008 (zombie) exited]
[Thread -1220498512 (zombie) exited]
[New Thread -1219822672 (LWP 3167)]

Program received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread -1219822672 (LWP 3167)]
0xb78f1f5e in rt_task_trampoline () from /usr/xenomai/lib/libnative.so.0
(gdb) bt
#0  0xb78f1f5e in rt_task_trampoline () from /usr/xenomai/lib/libnative.so.=
0
#1  0xb78e1240 in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
#2  0xb79bf32e in clone () from /lib/tls/i686/cmov/libc.so.6
(gdb)
---------- GDB END ----------------
What can this be?
Thanks for any help on that issue!

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

