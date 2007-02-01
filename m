Message-ID: <2284653.1170323957613.JavaMail.ngmail@domain.hid>
Date: Thu, 1 Feb 2007 10:59:17 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Running real time task on one of the cores of a Dual
	Core CPU
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

I have some results and some questions on running Xenomai on a Dual Core CP=
U.
At my PC I have a Pentium D CPU (3.2 GHz), kernel 2.6.19.2, Xenomai 2.3 + s=
ome COW patches.
In the kernel I have enabled SMP.

The first interesting thing I noticed is that this kernel seems to run all =
standard processes
on core 0. The kernel does not automatically distribute processes on two co=
res.
I think I saw a different behaviour with an earlier kernel version (2.6.17 =
or even 2.4.33).
I do not have to use the isolcpus kernel parameter to force running all use=
r space tasks on core 0.
This is exactly the thing I wanted to have. All "standard" linux tasks are =
running
on core 0.
Does anybody know if there was a change in the kernel?

Now I placed all real time tasks from Xenomai on core 1. This works fine.
My application calculates periodically a fairly complex simulation model. T=
he interesting thing
is now, that the computation time needed for this model is much more consta=
nt in opposite to the
UP mode. On an UP system I had computation times between 111 and 170 micros=
econds.
With the SMP system I have now computation times between 111 and 115 micros=
econds.
Great! The worst case execution time is very close to the best case executi=
on time!
I think this is caused by a more deterministic usage of the cache for the r=
eal time system.
In the UP system the cache cannot be reserved for the real time application=
, i.e. the real time
application has to re-read more often directly from memory.

Now my questions:
In a setup that uses core 0 for standard linux stuff and core 1 for Xenomai=
 stuff the
Xenomai scheduler is running in SMP mode. However, I am not sure if this re=
quired in this setup.
As all real time code is bound to one core there does not have to be any mu=
lti processing
save synchronisation for the real time code.
My proposal is to support three different scheduling modes:
1 - UP as now
2 - SMP as now
3 - UP on a certain core: All real time code runs on one (runtime selectabl=
e) core even
if the linux kernel is fully SMP. This should increase the performance as i=
nter CPU
protection is not required for the real time code.
Any comments on this idea are welcome!

I also use rtnet. Unfortunately I am not able to force rtnet (RTDM based) t=
o run on CPU core 1
without patching the RTDM code.
A couple of months ago, I already asked for this issue.
Jan, can you tell me the latest news regarding this issue?

Thanks for all feedback on the topics

Regards

Mathias=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

