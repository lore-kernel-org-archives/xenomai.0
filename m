Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2009 14:16:18 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01776718@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] How to use Xenomai libraries with "normal" (non
	Xenomai) linux processes ?
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

I have build a library which makes use of some Xenomai-Posix functions =
(mainly shared memory but also some semaphore functions). This library =
provides functions (logging) which should be used by Xenomai tasks and =
Linux processes.
When I link this new library with a standard linux process, this process =
obviously becomes automatically a Xenomai task (task is listed in =
/proc/xenomai/sched) just by linking with my library (not even calling a =
xeno-function is necessary).=20
Unfortunatelly this seems also to have an influence on the scheduling =
policy and the priority of the linux process:

When I set the policy (to SCHED_FIFO) and the priority of this linux =
process (by an external startup process) with :
	p.sched_priority =3D somepriority;
	sched_setscheduler(pidoflinuxprocess, SCHED_FIFO, &p);

and afterwards query the policy and priority within the process with :
	sched_getscheduler()
	sched_getparam()
I get the the policy SCHED_OTHER and a totaly different priority. This =
unfortunatelly prevents the linux process to be scheduled by linux as a =
prioritized process and therefore other prioritized processes with lower =
priority now are scheduled (by Linux) in front of my (normaly high =
prioritized) process.

After this long eplanation, which, I hope, is understandable, here my =
question:

How can I use Xenomai-libraries without Xenomai scheduling, or how can I =
build Xenomai based libraries usable for Xenomai and Linux (without =
influencing Linux schduling parameters)?

Unfortunatelly I don=B4t have a small and handy testcase at the moment, =
but I would create one, if you need it for answering my question.
Some additional info : I use Xenomai 2.3.5 on a PPC 2.4.25 Kernel

Thank you for your help in advance and best regards
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

