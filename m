Message-ID: <25556725.1178802170156.JavaMail.ngmail@domain.hid>
Date: Thu, 10 May 2007 15:02:50 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4642E54B.3060600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4642E54B.3060600@domain.hid>
	<1178727256.11688.35.camel@domain.hid>	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<12120203.1178785866207.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
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

Hi Jan,

it is the first time I use oprofile, I hope I have here results that are si=
gnificant...
I wrote a bash script  to start everything:
--------------------
#!/bin/bash
opcontrol --start
./performance
opcontrol --stop
opreport
--------------------
My real time test application is called "performance".
Here is the output:
------------------------------------------------------------
Profiler running.
delta is 2023521331 per step: 5058
Stopping profiling.
CPU: P4 / Xeon, speed 3192.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stop=
ped) with a unit mask of 0x01 (mandatory) count 100000
GLOBAL_POWER_E...|
  samples|      %|
------------------
    38103 76.4368 vmlinux
     2659  5.3341 xeno_nucleus
     2327  4.6681 libnative.so.0.0.0
     2078  4.1686 bash
        GLOBAL_POWER_E...|
          samples|      %|
        ------------------
             2069 99.5669 bash
                3  0.1444 anon (tgid:4769 range:0xb7fea000-0xb7feb000)
                2  0.0962 anon (tgid:22703 range:0xb7fea000-0xb7feb000)
                2  0.0962 anon (tgid:4883 range:0xb7fea000-0xb7feb000)
                1  0.0481 anon (tgid:1883 range:0xb7fea000-0xb7feb000)
                1  0.0481 anon (tgid:4942 range:0xb7fea000-0xb7feb000)
     1587  3.1836 xeno_native
     1514  3.0372 libc-2.3.6.so
      907  1.8195 ld-2.3.6.so
      317  0.6359 oprofiled
        GLOBAL_POWER_E...|
          samples|      %|
        ------------------
              315 99.3691 oprofiled
                2  0.6309 anon (tgid:1855 range:0xb7fea000-0xb7feb000)
      142  0.2849 performance
        GLOBAL_POWER_E...|
          samples|      %|
        ------------------
              130 91.5493 anon (tgid:22701 range:0xb7fea000-0xb7feb000)
               12  8.4507 performance
       91  0.1826 oprofile
       33  0.0662 gawk
       25  0.0502 e1000
       24  0.0481 grep
        7  0.0140 ls
        4  0.0080 cat
        4  0.0080 libncurses.so.5.5
        3  0.0060 libpopt.so.0.0.0
        3  0.0060 libselinux.so.1
        3  0.0060 libsepol.so.1
        3  0.0060 libdl-2.3.6.so
        3  0.0060 libpthread-2.3.6.so
        2  0.0040 mkdir
        2  0.0040 ophelp
        1  0.0020 lsmod
        1  0.0020 mktemp
        1  0.0020 libnss_compat-2.3.6.so
        1  0.0020 libnss_files-2.3.6.so
        1  0.0020 dirname
        1  0.0020 id
        1  0.0020 tr
        1  0.0020 in.telnetd
------------------------------------------


>=20
> Mind to run oprofile on this setup to see where costs primarily come from=
?
>=20

Does this help??

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

